package pro.jaldi;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import static pro.jaldi.LoginActivity.LOGIN_TOKEN_KEY;
import static pro.jaldi.LoginActivity.SERVER_API_URL;
import static pro.jaldi.LoginActivity.getAuthToken;


public class WorkContainerFragment extends Fragment {

    private final int UPDATE_INTERVAL = 60 * 1000;
    private final String REQUEST_TAG = "requestListTag";

    public boolean shouldShowMyWorks = false;
    private ArrayList<WorkModel> worksArrayList = new ArrayList<>();
    private WorkFragment.OnListFragmentInteractionListener mListener;
    private WorkFragment workFragment;
    private Timer listUpdateTimer;
    private RequestQueue requestQueue;

    public WorkContainerFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setRetainInstance(true);
        requestQueue = Volley.newRequestQueue(getContext());

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View contentView = inflater.inflate(R.layout.fragment_work_list_container, container, false);
        workFragment = new WorkFragment();
        workFragment.shouldShowMyWorks = shouldShowMyWorks;
        FragmentManager fm = getChildFragmentManager();
        FragmentTransaction ft = fm.beginTransaction();
        ft.replace(R.id.listContainer, workFragment);
        ft.commit();
        return contentView;

    }

    @Override
    public void onResume() {
        super.onResume();
        listUpdateTimer = new Timer();
        TimerTask timerTask = new TimerTask() {
            @Override
            public void run() {
                getWorks();
            }
        };
        listUpdateTimer.schedule(timerTask, 0, UPDATE_INTERVAL);
    }

    @Override
    public void onPause() {
        requestQueue.cancelAll(REQUEST_TAG);
        listUpdateTimer.cancel();
        listUpdateTimer.purge();
        super.onPause();
    }

    private void showPlaceHolderViewIfNeeded() {
        if (getView() == null) {
            return;
        }
        TextView textView = (TextView) getView().findViewById(R.id.placeholderView);
        View listFragmentContainer = getView().findViewById(R.id.listContainer);
        if (worksArrayList.isEmpty()) {
            if (shouldShowMyWorks) {
                textView.setText(R.string.no_taken_works);
            } else {
                textView.setText(R.string.no_more_works);
            }
            textView.setVisibility(View.VISIBLE);
            listFragmentContainer.setVisibility(View.GONE);
        } else {
            textView.setVisibility(View.GONE);
            listFragmentContainer.setVisibility(View.VISIBLE);
        }
    }


    private void getWorks() {
        if (getContext() == null) {
            return;
        }
        String URL;
        if (shouldShowMyWorks) {
            URL = SERVER_API_URL + "rest/order/workerOrders";
        } else {
            URL = SERVER_API_URL + "rest/order/freeOrders";
        }

        StringRequest stringRequest = new StringRequest(Request.Method.GET, URL, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.i("VOLLEY", response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("VOLLEY", error.toString());
            }
        }) {
            @Override
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String> params = new HashMap<String, String>();
                if (getContext() != null) {
                    params.put(LOGIN_TOKEN_KEY, getAuthToken(getContext()));
                }
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                if (response != null) {
                    String json = new String(response.data);
                    Type listType = new TypeToken<ArrayList<WorkModel>>() {
                    }.getType();

                    worksArrayList = new Gson().fromJson(json, listType);
                    if (getActivity() != null) {
                        getActivity().runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                workFragment.setListData(worksArrayList);
                                showPlaceHolderViewIfNeeded();
                            }
                        });
                    }
                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        stringRequest.setTag(stringRequest);
        requestQueue.add(stringRequest);
    }
}