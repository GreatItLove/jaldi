package pro.jaldi;

import android.content.Context;
import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import pro.jaldi.OrderFragment.OnListFragmentInteractionListener;
import pro.jaldi.dummy.DummyContent.DummyItem;

/**
 * {@link RecyclerView.Adapter} that can display a {@link DummyItem} and makes a call to the
 * specified {@link OnListFragmentInteractionListener}.
 */
public class MyOrderRecyclerViewAdapter extends RecyclerView.Adapter<MyOrderRecyclerViewAdapter.OrderViewHolder> {
    public List<OrderModel> mOrderModels;
    public Context mContext;
    private final OnListFragmentInteractionListener mListener;
    private final boolean mShouldShowMyOrders;

    public MyOrderRecyclerViewAdapter(Context context, List<OrderModel> items, boolean shouldShowMyOrders, OnListFragmentInteractionListener listener) {
        mContext = context;
        mShouldShowMyOrders = shouldShowMyOrders;
        mOrderModels = items;
        mListener = listener;
    }

    private void setupOrderType(OrderViewHolder orderHolder) {
        switch (orderHolder.mOrder.type) {
            case "CLEANER":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_cleaner));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_cleaner);
                break;
            case "CARPENTER":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_carpenter));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_carpenter);
                break;
            case "ELECTRICIAN":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_electrician));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_electrician);
                break;
            case "MASON":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_mason));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_mason);
                break;
            case "PAINTER":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_painter));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_painter);
                break;
            case "PLUMBER":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_plumber));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_plumber);
                break;
            case "AC_TECHNICAL":
                orderHolder.orderType.setText(mContext.getString(R.string.order_type_ac_technical));
                orderHolder.orderIcon.setImageResource(R.drawable.order_type_ac_technical);
                break;
        }
    }

    private void setupOrderStatus(OrderViewHolder orderHolder) {
        switch (orderHolder.mOrder.status) {
            case "CREATED":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_created));
                break;
            case "ASSIGNED":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_assigned));
                break;
            case "EN_ROUTE":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_en_route));
                break;
            case "WORKING":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_working));
                break;
            case "TIDYING_UP":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_tidying_up));
                orderHolder.orderStatus.setBackgroundResource(R.color.status_tidying_up);
                break;
            case "FINISHED":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_finished));
                orderHolder.orderStatus.setBackgroundResource(R.color.status_finished);
                break;
            case "CANCELED":
                orderHolder.orderStatus.setText(mContext.getString(R.string.status_canceled));
                break;
        }
    }

    private String getCost(OrderModel order) {
        String orderCost = mContext.getString(R.string.not_available);
        if (order.cost != 0) {
            orderCost = order.cost + " " + mContext.getString(R.string.order_cost_metric);
        }
        return orderCost;
    }

    private String getAddress(OrderModel order) {
        String orderAddress = mContext.getString(R.string.not_available);
        if (order.address != null && !order.address.isEmpty()) {
            orderAddress = order.address;
            if (order.city != null && !order.city.isEmpty()) {
                orderAddress += ", " + order.city;
            }
        }
        return orderAddress;
    }

    private String getLeftPositions(OrderModel order) {
        int positionsNeeded = order.workers;
        int positionsLeft = positionsNeeded;
        if (order.workersList != null) {
            positionsLeft -= order.workersList.size();
        }
        return mContext.getString(R.string.order_workers_left, positionsLeft, positionsNeeded);
    }

    private String getDuration(OrderModel order) {
        String duration = mContext.getString(R.string.not_available);
        if (order.hours != 0) {
            duration = mContext.getString(R.string.order_duration, order.hours);
        }
        return duration;
    }

    private String getDistance(OrderModel order) {
        String distanceString = mContext.getString(R.string.not_available);
        int distance = 10;
        if (distance != 0) {
            distanceString = mContext.getString(R.string.order_distance, distance);
        }
        return distanceString;
    }

    private String getDate(OrderModel order) {
        String date = mContext.getString(R.string.not_available);
        if (order.creationDate != 0) {
            Date creationDate = new Date(order.orderDate);
            date = new SimpleDateFormat("dd MMM yyyy").format(creationDate);
        }
        return date;
    }

    private String getTime(OrderModel order) {
        String time = mContext.getString(R.string.not_available);
        if (order.creationDate != 0) {
            final long HOUR = 3600*1000;
            Date creationDate = new Date(order.orderDate);
            String startTime = new SimpleDateFormat("hh:mm a").format(creationDate);
            Date endDate = new Date(order.orderDate + order.hours * HOUR);
            String endTime = new SimpleDateFormat("hh:mm a").format(endDate);
            time = startTime + " - " + endTime;
        }
        return time;
    }

    private void handleTakeOrderClicked(final Button source) {
        new AlertDialog.Builder(mContext)
                .setTitle(R.string.take_order_confirmation_title)
                .setMessage(R.string.take_order_confirmation_message)
                .setPositiveButton(R.string.alert_yes_button, new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int whichButton) {
                        source.setSelected(true);
                        source.setText(R.string.order_taken_button);
                    }})
                .setNegativeButton(R.string.alert_no_button, null).show();

    }

    @Override
    public OrderViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_order, parent, false);
        return new OrderViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final OrderViewHolder orderViewHolder, int position) {
        OrderModel order = mOrderModels.get(position);
        orderViewHolder.mOrder = order;
        setupOrderType(orderViewHolder);
        orderViewHolder.orderAddress.setText(getAddress(order));
        orderViewHolder.orderCost.setText(getCost(order));
        orderViewHolder.orderDuration.setText(getDuration(order));
        orderViewHolder.orderDate.setText(getDate(order));
        orderViewHolder.orderTime.setText(getTime(order));
        orderViewHolder.orderDistance.setText(getDistance(order));
        if (mShouldShowMyOrders) {
            orderViewHolder.orderPositions.setVisibility(View.GONE);
            orderViewHolder.takeOrderBtn.setVisibility(View.GONE);
            orderViewHolder.orderStatus.setVisibility(View.VISIBLE);
            setupOrderStatus(orderViewHolder);
        } else {
            orderViewHolder.orderStatus.setVisibility(View.GONE);
            orderViewHolder.orderPositions.setVisibility(View.VISIBLE);
            orderViewHolder.orderPositions.setText(getLeftPositions(order));
            orderViewHolder.takeOrderBtn.setVisibility(View.VISIBLE);
            orderViewHolder.takeOrderBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    handleTakeOrderClicked((Button) v);
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
