package pro.jaldi;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v7.widget.AppCompatButton;
import android.text.TextUtils;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.gson.Gson;

import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import static pro.jaldi.LoginActivity.LOGIN_TOKEN_KEY;
import static pro.jaldi.LoginActivity.SERVER_API_URL;
import static pro.jaldi.LoginActivity.getAuthToken;


public class WorkDetailFragment extends Fragment implements OnMapReadyCallback, View.OnClickListener {
    public WorkModel selectedWork;
    private View contentView;
    private String workCurrentStatus;
    private Button nextStatusBtn;
    private static final float MAP_DEFAULT_LOCATION_ZOOM = 6.0f;
    private static final float MAP_USER_LOCATION_ZOOM = 15.0f;

    private boolean isCommentTextScrolling = false;
    public WorkDetailFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        requestSelectedWork();
        // Inflate the layout for this fragment
        contentView = inflater.inflate(R.layout.fragment_work_detail, container, false);

        SupportMapFragment mapFragment = (SupportMapFragment) getChildFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);


        ImageView workTypeIcon = (ImageView) contentView.findViewById(R.id.detailsWorkIcon);
        WorkModel.WorkTypeModel workTypeModel = selectedWork.getWorkTypeModel();
        workTypeIcon.setImageResource(workTypeModel.imageResId);

        TextView workAddress = (TextView) contentView.findViewById(R.id.detailsAddressValue);
        workAddress.setText(selectedWork.getAddress());
        workAddress.setOnClickListener(this);

        TextView workCost = (TextView) contentView.findViewById(R.id.detailsCostValue);
        workCost.setText(selectedWork.getCost());

        TextView workDistance = (TextView) contentView.findViewById(R.id.detailsDistanceValue);
        workDistance.setText(selectedWork.getDistance());

        TextView workDuration = (TextView) contentView.findViewById(R.id.detailsDurationValue);
        workDuration.setText(selectedWork.getDuration());

        TextView workUserName = (TextView) contentView.findViewById(R.id.detailsWorksUserName);
        workUserName.setText(selectedWork.getUserName());

        TextView workUserPhone = (TextView) contentView.findViewById(R.id.detailsWorkUserPhone);
        workUserPhone.setText(selectedWork.getUserPhone());

        AppCompatButton callBtn = (AppCompatButton) contentView.findViewById(R.id.detailsCall);
        callBtn.setOnClickListener(this);

        AppCompatButton messageBtn = (AppCompatButton) contentView.findViewById(R.id.detailsMessage);
        messageBtn.setOnClickListener(this);

        if (selectedWork.status.equals("CREATED") || selectedWork.status.equals("ASSIGNED")) {
            AppCompatButton cancelBtn = (AppCompatButton) contentView.findViewById(R.id.detailsCancel);
            cancelBtn.setOnClickListener(this);
        } else {
            LinearLayout cancelBtnContainer = (LinearLayout) contentView.findViewById(R.id.cancelBtnContainer);
            cancelBtnContainer.setVisibility(View.GONE);
        }
        nextStatusBtn = (Button) contentView.findViewById(R.id.detailsNextStatusButton);
        nextStatusBtn.setOnClickListener(this);
        workCurrentStatus = selectedWork.status;
        if (workCurrentStatus.equals("CANCELED")) {
            nextStatusBtn.setText(R.string.status_canceled);
            nextStatusBtn.setEnabled(false);
        } else {
            nextStatusBtn.setText(getWorkStatus());
        }
        if (workCurrentStatus.equals("FINISHED")) {
            nextStatusBtn.setEnabled(false);
        }

        TextView commentTextView = (TextView) contentView.findViewById(R.id.detailsComment);

        if (selectedWork.comment != null && !selectedWork.comment.trim().isEmpty()) {
            commentTextView.setText(selectedWork.comment);
            commentTextView.setOnTouchListener(new View.OnTouchListener() {
                @Override
                public boolean onTouch(View v, MotionEvent event) {
                    if (event.getAction() == MotionEvent.ACTION_DOWN) {
                        isCommentTextScrolling = false;
                    } else if (event.getAction() == MotionEvent.ACTION_MOVE) {
                        isCommentTextScrolling = true;
                    } else if (event.getAction() == MotionEvent.ACTION_UP &&
                            isCommentTextScrolling &&
                            ((TextView) v).getMaxLines() != 1) {
                        return true;
                    }
                    return false;
                }
            });
            commentTextView.setOnClickListener(this);
        } else {
            commentTextView.setHeight(0);
            commentTextView.setEnabled(false);
            View separator = contentView.findViewById(R.id.detailsCommentSeparator);
            separator.setVisibility(View.INVISIBLE);
        }
        return contentView;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        if (ActivityCompat.checkSelfPermission(getActivity(), android.Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED || ActivityCompat.checkSelfPermission(getActivity(), android.Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            googleMap.setMyLocationEnabled(true);
        }
        if (selectedWork.latitude != 0 && selectedWork.longitude != 0) {
            LatLng workAddress = new LatLng(selectedWork.latitude, selectedWork.longitude);
            googleMap.addMarker(new MarkerOptions().position(workAddress).title(selectedWork.address));
            googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(workAddress, MAP_USER_LOCATION_ZOOM));
        } else {
            LatLng defaultAddress = new LatLng(55.7492899, 37.0720539);
            googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(defaultAddress, MAP_DEFAULT_LOCATION_ZOOM));
        }
    }

    private void toggleCommentTextView(TextView textView) {
        if (textView.getMaxLines() == 1) {
            //expand
            textView.setMaxLines(Integer.MAX_VALUE);
            textView.setEllipsize(null);
            textView.setMaxHeight(getResources().getDimensionPixelSize(R.dimen.details_comment_max_height));
            textView.setMovementMethod(new ScrollingMovementMethod());
        } else {
            //shrink
            textView.setMaxLines(1);
            textView.scrollTo(0, 0);
            textView.setMovementMethod(null);
            textView.setOnClickListener(this);
            textView.setEllipsize(TextUtils.TruncateAt.END);
        }
    }

    private void requestSelectedWork() {
        RequestQueue requestQueue = Volley.newRequestQueue(getContext());
        String URL = SERVER_API_URL + "rest/order/" + selectedWork.id;

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
                Map<String, String>  params = new HashMap<String, String>();
                params.put(LOGIN_TOKEN_KEY, getAuthToken(getContext()));
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                if (response != null) {
                    String json = new String (response.data);
                    final WorkModel workModel = new Gson().fromJson(json, WorkModel.class);

                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            selectedWork = workModel;
                            updateUserData();
                        }
                    });
                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private void updateUserData() {
        TextView workUserName = (TextView) contentView.findViewById(R.id.detailsWorksUserName);
        workUserName.setText(selectedWork.getUserName());

        TextView workUserPhone = (TextView) contentView.findViewById(R.id.detailsWorkUserPhone);
        workUserPhone.setText(selectedWork.getUserPhone());
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.detailsNextStatusButton:
               handleWorkNextStatusClicked();
                break;
            case R.id.detailsCall:
                callUser();
                break;
            case R.id.detailsMessage:
                messageUser();
                break;
            case R.id.detailsCancel:
                cancelWork();
                break;
            case R.id.detailsAddressValue:
                handleAddressClicked();
                break;
            case R.id.detailsComment:
                toggleCommentTextView((TextView) v);
                break;
        }
    }

    private void handleAddressClicked() {
        if (selectedWork.latitude == 0 || selectedWork.longitude == 0) {
            return;
        }
        String query = selectedWork.latitude + "," + selectedWork.longitude;
        String uriBegin = "geo:" + query;
        String encodedQuery = Uri.encode(query);
        String uriString = uriBegin + "?q=" + encodedQuery;
        Uri uri = Uri.parse(uriString);
        Intent mapIntent = new Intent(android.content.Intent.ACTION_VIEW, uri );
        mapIntent.setPackage("com.google.android.apps.maps");
        if (mapIntent.resolveActivity(getContext().getPackageManager()) != null) {
            startActivity(mapIntent);
        }
    }

    private void handleWorkNextStatusClicked() {
        String [] statusVarians = {"EN_ROUTE", "WORKING", "TIDYING_UP", "FINISHED"};
        int indexOfCurrentStatus = java.util.Arrays.asList(statusVarians).indexOf(workCurrentStatus);
        int indexOfNextStatus = indexOfCurrentStatus + 1;
        if (indexOfNextStatus == statusVarians.length - 1) {
            // the last status.
            nextStatusBtn.setEnabled(false);
        }
        workCurrentStatus = statusVarians[indexOfNextStatus];
        nextStatusBtn.setText(getWorkStatus());

        RequestQueue requestQueue = Volley.newRequestQueue(getContext());
        String URL = SERVER_API_URL + "rest/order/updateOrderStatus";
        JSONObject jsonBody = new JSONObject(getParams());
        final String requestBody = jsonBody.toString();

        StringRequest stringRequest = new StringRequest(Request.Method.PUT, URL, new Response.Listener<String>() {

            @Override
            public void onResponse(String response) {
                Log.i("VOLLEY", response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("VOLLEY", error.toString());
                Toast.makeText(getContext(), R.string.toast_details_error_on_cancel, Toast.LENGTH_LONG).show();
            }
        }) {
            @Override
            public String getBodyContentType() {
                return "application/json; charset=utf-8";
            }

            @Override
            public byte[] getBody() throws AuthFailureError {
                try {
                    return requestBody == null ? null : requestBody.getBytes("utf-8");
                } catch (UnsupportedEncodingException uee) {
                    VolleyLog.wtf("Unsupported Encoding while trying to get the bytes of %s using %s", requestBody, "utf-8");
                    Toast.makeText(getContext(), R.string.status_update_invalid, Toast.LENGTH_LONG).show();
                    return null;
                }
            }

            @Override
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String>  params = new HashMap<String, String>();
                params.put(LOGIN_TOKEN_KEY, getAuthToken(getContext()));
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                if (response != null) {
                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            handleWorkStatusChanged();
                        }
                    });
                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private String getWorkStatus() {
        int resId = R.string.status_en_route;
        switch (workCurrentStatus) {
            case "EN_ROUTE":
               resId = R.string.status_working;
                break;
            case "WORKING":
                resId = R.string.status_tidying_up;
                break;
            case "TIDYING_UP":
                resId = R.string.status_finished;
                break;
            case "FINISHED":
                resId = R.string.status_finished;
                break;
        }
        return getContext().getString(resId);
    }

    private Map<String, String> getParams()
    {
        Map<String, String>  params = new HashMap<String, String>();
        params.put("orderId", selectedWork.id + "");
        params.put("status", workCurrentStatus);
        return params;
    }

    private void handleWorkStatusChanged() {

    }

    private void callUser() {
        String phone = selectedWork.getUserPhone();
        if (!phone.isEmpty()) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phone, null));
            startActivity(intent);
        } else {
            Toast.makeText(getContext(), R.string.toast_details_no_phone_error, Toast.LENGTH_LONG).show();
        }
    }

    private void messageUser() {
        String phone = selectedWork.getUserPhone();
        if (!phone.isEmpty()) {
            startActivity(new Intent(Intent.ACTION_VIEW, Uri.fromParts("sms", phone, null)));
        } else {
            Toast.makeText(getContext(), R.string.toast_details_no_phone_error, Toast.LENGTH_LONG).show();
        }
    }

    private void cancelWork() {
        RequestQueue requestQueue = Volley.newRequestQueue(getContext());
        String URL = SERVER_API_URL + "rest/order/cancelWork/" + selectedWork.id;

        StringRequest stringRequest = new StringRequest(Request.Method.PUT, URL, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.i("VOLLEY", response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("VOLLEY", error.toString());
                Toast.makeText(getContext(), R.string.toast_details_error_on_cancel, Toast.LENGTH_LONG).show();
            }
        }) {
            @Override
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String>  params = new HashMap<String, String>();
                params.put(LOGIN_TOKEN_KEY, getAuthToken(getContext()));
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                if (response != null) {
                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            handleWorkCanceled();
                        }
                    });
                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private void handleWorkCanceled() {
        Log.d("MYLOG", "Order has been canceled successfuly.");
        Toast.makeText(getContext(), R.string.toast_details_cancel_successful, Toast.LENGTH_LONG).show();
    }
}
