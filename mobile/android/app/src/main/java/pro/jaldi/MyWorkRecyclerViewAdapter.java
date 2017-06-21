package pro.jaldi;

import android.content.Context;
import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import pro.jaldi.WorkFragment.OnListFragmentInteractionListener;
import pro.jaldi.dummy.DummyContent.DummyItem;

import static pro.jaldi.LoginActivity.LOGIN_TOKEN_KEY;
import static pro.jaldi.LoginActivity.SERVER_API_URL;
import static pro.jaldi.LoginActivity.getAuthToken;

/**
 * {@link RecyclerView.Adapter} that can display a {@link DummyItem} and makes a call to the
 * specified {@link OnListFragmentInteractionListener}.
 */
public class MyWorkRecyclerViewAdapter extends RecyclerView.Adapter<MyWorkRecyclerViewAdapter.WorkViewHolder> {
    private List<WorkModel> mWorkModels;
    public Context mContext;
    private final OnListFragmentInteractionListener mListener;
    private final boolean mShouldShowMyWorks;

    public MyWorkRecyclerViewAdapter(Context context, List<WorkModel> items, boolean shouldShowMyWorks, OnListFragmentInteractionListener listener) {
        mContext = context;
        mShouldShowMyWorks = shouldShowMyWorks;
        mWorkModels = items;
        for (WorkModel workModel : mWorkModels) {
            workModel.mContext = context;
        }
        mListener = listener;
    }

    public void setWorkssList(List<WorkModel> workModels) {
        this.mWorkModels = workModels;
        for (WorkModel workModel : this.mWorkModels) {
            workModel.mContext = this.mContext;
        }
        notifyDataSetChanged();
    }

    private void handleTakeWorkClicked(final Button source, final WorkModel work) {
        new AlertDialog.Builder(mContext)
                .setTitle(R.string.take_work_confirmation_title)
                .setMessage(R.string.take_work_confirmation_message)
                .setPositiveButton(R.string.alert_yes_button, new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int whichButton) {
                        requestTakeWork(source, work);
                    }})
                .setNegativeButton(R.string.alert_no_button, null).show();

    }

    private void requestTakeWork(final Button source, WorkModel work) {
        RequestQueue requestQueue = Volley.newRequestQueue(mContext);
        String URL = SERVER_API_URL + "rest/order/take/" + work.id;

        StringRequest stringRequest = new StringRequest(Request.Method.POST, URL, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.i("VOLLEY", response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("VOLLEY", error.toString());
                Toast.makeText(mContext, R.string.toast_details_error_on_cancel, Toast.LENGTH_LONG).show();
            }
        }) {
            @Override
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String>  params = new HashMap<String, String>();
                params.put(LOGIN_TOKEN_KEY, getAuthToken(mContext));
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                if (response != null) {
                    ((AppCompatActivity)mContext).runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            source.setSelected(true);
                            source.setText(R.string.work_taken_button);
                        }
                    });

                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    @Override
    public WorkViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_work, parent, false);
        return new WorkViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final WorkViewHolder workViewHolder, int position) {
        final WorkModel work = mWorkModels.get(position);
        workViewHolder.mWork = work;
        WorkModel.WorkTypeModel workTypeModel = work.getWorkTypeModel();
        workViewHolder.workIcon.setImageResource(workTypeModel.imageResId);
        workViewHolder.workType.setText(mContext.getText(workTypeModel.titleResId));
        workViewHolder.workAddress.setText(work.getAddress());
        workViewHolder.workCost.setText(work.getCost());
        workViewHolder.workDuration.setText(work.getDuration());
        workViewHolder.workDate.setText(work.getDate());
        workViewHolder.workTime.setText(work.getTime());
        workViewHolder.workDistance.setText(work.getDistance());
        if (mShouldShowMyWorks) {
            workViewHolder.workPositions.setVisibility(View.GONE);
            workViewHolder.takeWorkBtn.setVisibility(View.GONE);
            workViewHolder.workStatus.setVisibility(View.VISIBLE);
            WorkModel.WorkStatusModel workStatusModel = work.getWorkStatus();
            if (workStatusModel.titleResId != 0) {
                workViewHolder.workStatus.setText(workStatusModel.titleResId);
            }
            if (workStatusModel.backgroundColorResId != 0) {
                workViewHolder.workStatus.setBackgroundResource(workStatusModel.backgroundColorResId);
            }
        } else {
            workViewHolder.workStatus.setVisibility(View.GONE);
            workViewHolder.workPositions.setVisibility(View.VISIBLE);
            workViewHolder.workPositions.setText(work.getLeftPositions());
            workViewHolder.takeWorkBtn.setVisibility(View.VISIBLE);
            workViewHolder.takeWorkBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    handleTakeWorkClicked((Button) v, work);
                }
            });
        }
        workViewHolder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (null != mListener) {
                    // Notify the active callbacks interface (the activity, if the
                    // fragment is attached to one) that an item has been selected.
                    mListener.onListFragmentInteraction(workViewHolder);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mWorkModels.size();
    }

    public class WorkViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public WorkModel mWork;
        public Button takeWorkBtn;
        public TextView workType;
        public TextView workPositions;
        public TextView workStatus;
        public ImageView workIcon;

        public TextView workAddress;
        public TextView workCost;
        public TextView workDuration;
        public TextView workDistance;
        public TextView workDate;
        public TextView workTime;

        public WorkViewHolder(View view) {
            super(view);
            takeWorkBtn = (Button) view.findViewById(R.id.takeWorkButton);
            workType = (TextView) view.findViewById(R.id.workType);
            workStatus = (TextView) view.findViewById(R.id.workStatus);
            workIcon = (ImageView) view.findViewById(R.id.workIcon);
            workAddress = (TextView) view.findViewById(R.id.workAddressValue);
            workCost = (TextView) view.findViewById(R.id.workCostValue);
            workPositions = (TextView) view.findViewById(R.id.workPositionLeft);
            workDuration = (TextView) view.findViewById(R.id.workDurationValue);
            workDistance = (TextView) view.findViewById(R.id.workDistanceValue);
            workDate = (TextView) view.findViewById(R.id.workDate);
            workTime = (TextView) view.findViewById(R.id.workTime);

            mView = view;
        }
    }
}
