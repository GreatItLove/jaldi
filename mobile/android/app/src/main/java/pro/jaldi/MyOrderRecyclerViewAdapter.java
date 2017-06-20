package pro.jaldi;

import android.app.Activity;
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

import pro.jaldi.OrderFragment.OnListFragmentInteractionListener;
import pro.jaldi.dummy.DummyContent.DummyItem;

import static pro.jaldi.LoginActivity.LOGIN_TOKEN_KEY;
import static pro.jaldi.LoginActivity.SERVER_API_URL;
import static pro.jaldi.LoginActivity.getAuthToken;

/**
 * {@link RecyclerView.Adapter} that can display a {@link DummyItem} and makes a call to the
 * specified {@link OnListFragmentInteractionListener}.
 */
public class MyOrderRecyclerViewAdapter extends RecyclerView.Adapter<MyOrderRecyclerViewAdapter.OrderViewHolder> {
    private List<OrderModel> mOrderModels;
    public Context mContext;
    private final OnListFragmentInteractionListener mListener;
    private final boolean mShouldShowMyOrders;

    public MyOrderRecyclerViewAdapter(Context context, List<OrderModel> items, boolean shouldShowMyOrders, OnListFragmentInteractionListener listener) {
        mContext = context;
        mShouldShowMyOrders = shouldShowMyOrders;
        mOrderModels = items;
        for (OrderModel orderModel: mOrderModels) {
            orderModel.mContext = context;
        }
        mListener = listener;
    }

    public void setOrdersList(List<OrderModel> orderModels) {
        this.mOrderModels = orderModels;
        for (OrderModel orderModel: this.mOrderModels) {
            orderModel.mContext = this.mContext;
        }
        notifyDataSetChanged();
    }

    private void handleTakeOrderClicked(final Button source, final OrderModel order) {
        new AlertDialog.Builder(mContext)
                .setTitle(R.string.take_order_confirmation_title)
                .setMessage(R.string.take_order_confirmation_message)
                .setPositiveButton(R.string.alert_yes_button, new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int whichButton) {
                        requestTakeOrder(source, order);
                    }})
                .setNegativeButton(R.string.alert_no_button, null).show();

    }

    private void requestTakeOrder (final Button source, OrderModel order) {
        RequestQueue requestQueue = Volley.newRequestQueue(mContext);
        String URL = SERVER_API_URL + "rest/order/take/" + order.id;

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
                            source.setText(R.string.order_taken_button);
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
    public OrderViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_order, parent, false);
        return new OrderViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final OrderViewHolder orderViewHolder, int position) {
        final OrderModel order = mOrderModels.get(position);
        orderViewHolder.mOrder = order;
        OrderModel.OrderTypeModel orderTypeModel = order.getOrderTypeModel();
        orderViewHolder.orderIcon.setImageResource(orderTypeModel.imageResId);
        orderViewHolder.orderType.setText(mContext.getText(orderTypeModel.titleResId));
        orderViewHolder.orderAddress.setText(order.getAddress());
        orderViewHolder.orderCost.setText(order.getCost());
        orderViewHolder.orderDuration.setText(order.getDuration());
        orderViewHolder.orderDate.setText(order.getDate());
        orderViewHolder.orderTime.setText(order.getTime());
        orderViewHolder.orderDistance.setText(order.getDistance());
        if (mShouldShowMyOrders) {
            orderViewHolder.orderPositions.setVisibility(View.GONE);
            orderViewHolder.takeOrderBtn.setVisibility(View.GONE);
            orderViewHolder.orderStatus.setVisibility(View.VISIBLE);
            OrderModel.OrderStatusModel orderStatusModel = order.getOrderStatus();
            if (orderStatusModel.titleResId != 0) {
                orderViewHolder.orderStatus.setText(orderStatusModel.titleResId);
            }
            if (orderStatusModel.backgroundColorResId != 0) {
                orderViewHolder.orderStatus.setBackgroundResource(orderStatusModel.backgroundColorResId);
            }
        } else {
            orderViewHolder.orderStatus.setVisibility(View.GONE);
            orderViewHolder.orderPositions.setVisibility(View.VISIBLE);
            orderViewHolder.orderPositions.setText(order.getLeftPositions());
            orderViewHolder.takeOrderBtn.setVisibility(View.VISIBLE);
            orderViewHolder.takeOrderBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    handleTakeOrderClicked((Button) v, order);
                }
            });
        }
        orderViewHolder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (null != mListener) {
                    // Notify the active callbacks interface (the activity, if the
                    // fragment is attached to one) that an item has been selected.
                    mListener.onListFragmentInteraction(orderViewHolder);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mOrderModels.size();
    }

    public class OrderViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public OrderModel mOrder;
        public Button takeOrderBtn;
        public TextView orderType;
        public TextView orderPositions;
        public TextView orderStatus;
        public ImageView orderIcon;

        public TextView orderAddress;
        public TextView orderCost;
        public TextView orderDuration;
        public TextView orderDistance;
        public TextView orderDate;
        public TextView orderTime;

        public OrderViewHolder(View view) {
            super(view);
            takeOrderBtn = (Button) view.findViewById(R.id.takeOrderButton);
            orderType = (TextView) view.findViewById(R.id.orderType);
            orderStatus = (TextView) view.findViewById(R.id.orderStatus);
            orderIcon = (ImageView) view.findViewById(R.id.orderIcon);
            orderAddress = (TextView) view.findViewById(R.id.orderAddressValue);
            orderCost = (TextView) view.findViewById(R.id.orderCostValue);
            orderPositions = (TextView) view.findViewById(R.id.orderPositionLeft);
            orderDuration = (TextView) view.findViewById(R.id.orderDurationValue);
            orderDistance = (TextView) view.findViewById(R.id.orderDistanceValue);
            orderDate = (TextView) view.findViewById(R.id.orderDate);
            orderTime = (TextView) view.findViewById(R.id.orderTime);

            mView = view;
        }
    }
}
