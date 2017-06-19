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

import java.util.List;

import pro.jaldi.OrderFragment.OnListFragmentInteractionListener;
import pro.jaldi.dummy.DummyContent.DummyItem;

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
