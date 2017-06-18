package pro.jaldi;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.AppCompatButton;
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


public class OrderDetailFragment extends Fragment implements OnMapReadyCallback, View.OnClickListener {
    public OrderModel selectedOrder;
    private View contentView;
    private String orderCurrentStatus;
    private Button nextStatusBtn;

    public OrderDetailFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        getOrder();
        // Inflate the layout for this fragment
        contentView = inflater.inflate(R.layout.fragment_order_detail, container, false);

        SupportMapFragment mapFragment = (SupportMapFragment) getChildFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);


        ImageView orderTypeIcon = (ImageView) contentView.findViewById(R.id.detailsOrderIcon);
        OrderModel.OrderTypeModel orderTypeModel = selectedOrder.getOrderTypeModel();
        orderTypeIcon.setImageResource(orderTypeModel.imageResId);

        TextView orderAddress = (TextView) contentView.findViewById(R.id.detailsAddressValue);
        orderAddress.setText(selectedOrder.getAddress());

        TextView orderCost = (TextView) contentView.findViewById(R.id.detailsCostValue);
        orderCost.setText(selectedOrder.getCost());

        TextView orderDistance = (TextView) contentView.findViewById(R.id.detailsDistanceValue);
        orderDistance.setText(selectedOrder.getDistance());

        TextView orderDuration = (TextView) contentView.findViewById(R.id.detailsDurationValue);
        orderDuration.setText(selectedOrder.getDuration());

        TextView orderUserName = (TextView) contentView.findViewById(R.id.detailsOrderUserName);
        orderUserName.setText(selectedOrder.getUserName());

        TextView orderUserPhone = (TextView) contentView.findViewById(R.id.detailsOrderUserPhone);
        orderUserPhone.setText(selectedOrder.getUserPhone());

        AppCompatButton callBtn = (AppCompatButton) contentView.findViewById(R.id.detailsCall);
        callBtn.setOnClickListener(this);

        AppCompatButton messageBtn = (AppCompatButton) contentView.findViewById(R.id.detailsMessage);
        messageBtn.setOnClickListener(this);

        AppCompatButton cancelBtn = (AppCompatButton) contentView.findViewById(R.id.detailsCancel);
        cancelBtn.setOnClickListener(this);

        nextStatusBtn = (Button) contentView.findViewById(R.id.detailsNextStatusButton);
        nextStatusBtn.setOnClickListener(this);
        orderCurrentStatus = selectedOrder.status;
        if (orderCurrentStatus.equals("CANCELED")) {
            nextStatusBtn.setText(R.string.status_canceled);
            nextStatusBtn.setEnabled(false);
        } else {
            nextStatusBtn.setText(getOrderStatus());
        }
        if (orderCurrentStatus.equals("FINISHED")) {
            nextStatusBtn.setEnabled(false);
        }
            return contentView;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        if (selectedOrder.latitude != 0 && selectedOrder.longitude != 0) {
            LatLng orderAddress = new LatLng(selectedOrder.latitude, selectedOrder.longitude);
            googleMap.addMarker(new MarkerOptions().position(orderAddress).title(selectedOrder.address));
            googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(orderAddress, 15.0f));
        } else {
            LatLng defaultAddress = new LatLng(55.7492899, 37.0720539);
            googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(defaultAddress, 6.0f));
        }
    }

    private  void getOrder() {
        RequestQueue requestQueue = Volley.newRequestQueue(getContext());
        String URL = SERVER_API_URL + "rest/order/" + selectedOrder.id;

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
                    final OrderModel orderModel = new Gson().fromJson(json, OrderModel.class);

                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            selectedOrder = orderModel;
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
        TextView orderUserName = (TextView) contentView.findViewById(R.id.detailsOrderUserName);
        orderUserName.setText(selectedOrder.getUserName());

        TextView orderUserPhone = (TextView) contentView.findViewById(R.id.detailsOrderUserPhone);
        orderUserPhone.setText(selectedOrder.getUserPhone());
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.detailsNextStatusButton:
               handleOrderNextStatusClicked();
                break;
            case R.id.detailsCall:
                callUser();
                break;
            case R.id.detailsMessage:
                messageUser();
                break;
            case R.id.detailsCancel:
                cancelOrder();
                break;
        }
    }

    private void handleOrderNextStatusClicked() {
        String [] statusVarians = {"EN_ROUTE", "WORKING", "TIDYING_UP", "FINISHED"};
        int indexOfCurrentStatus = java.util.Arrays.asList(statusVarians).indexOf(orderCurrentStatus);
        int indexOfNextStatus = indexOfCurrentStatus + 1;
        if (indexOfNextStatus == statusVarians.length - 1) {
            // the last status.
            nextStatusBtn.setEnabled(false);
        }
        orderCurrentStatus = statusVarians[indexOfNextStatus];
        nextStatusBtn.setText(getOrderStatus());

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
                            handleOrderStatusChanged();
                        }
                    });
                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private String getOrderStatus() {
        int resId = R.string.status_en_route;
        switch (orderCurrentStatus) {
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
        params.put("orderId", selectedOrder.id + "");
        params.put("status", orderCurrentStatus);
        return params;
    }

    private void handleOrderStatusChanged() {

    }

    private void callUser() {
        String phone = selectedOrder.getUserPhone();
        if (!phone.isEmpty()) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", phone, null));
            startActivity(intent);
        } else {
            Toast.makeText(getContext(), R.string.toast_details_no_phone_error, Toast.LENGTH_LONG).show();
        }
    }

    private void messageUser() {
        String phone = selectedOrder.getUserPhone();
        if (!phone.isEmpty()) {
            startActivity(new Intent(Intent.ACTION_VIEW, Uri.fromParts("sms", phone, null)));
        } else {
            Toast.makeText(getContext(), R.string.toast_details_no_phone_error, Toast.LENGTH_LONG).show();
        }
    }

    private void cancelOrder() {
        RequestQueue requestQueue = Volley.newRequestQueue(getContext());
        String URL = SERVER_API_URL + "rest/order/cancel/" + selectedOrder.id;

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
                            handleOrderCanceled();
                        }
                    });
                }
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private void handleOrderCanceled() {
        Log.d("MYLOG", "Order has been canceled successfuly.");
        Toast.makeText(getContext(), R.string.toast_details_cancel_successful, Toast.LENGTH_LONG).show();
    }
}
