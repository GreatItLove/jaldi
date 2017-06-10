package pro.jaldi;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import pro.jaldi.OrderFragment.OnListFragmentInteractionListener;
import pro.jaldi.dummy.DummyContent.DummyItem;

import java.util.List;

/**
 * {@link RecyclerView.Adapter} that can display a {@link DummyItem} and makes a call to the
 * specified {@link OnListFragmentInteractionListener}.
 * TODO: Replace the implementation with code for your data type.
 */
public class MyOrderRecyclerViewAdapter extends RecyclerView.Adapter<MyOrderRecyclerViewAdapter.OrderViewHolder> {
private boolean isEven = false;
    public List<OrderModel> orderModels;
    private final OnListFragmentInteractionListener mListener;

    public MyOrderRecyclerViewAdapter(List<OrderModel> items, OnListFragmentInteractionListener listener) {
        orderModels = items;
        mListener = listener;
    }

    @Override
    public OrderViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_order, parent, false);
        return new OrderViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final OrderViewHolder holder, int position) {
        holder.mOrder = orderModels.get(position);
        holder.takeOrderBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                v.setSelected(true);
            }
        });
        holder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (null != mListener) {
                    // Notify the active callbacks interface (the activity, if the
                    // fragment is attached to one) that an item has been selected.
                    mListener.onListFragmentInteraction(holder.mOrder);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return orderModels.size();
    }

    public class OrderViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public OrderModel mOrder;
        public Button takeOrderBtn;

        public OrderViewHolder(View view) {
            super(view);
            takeOrderBtn = (Button) view.findViewById(R.id.takeOrderButton);
            mView = view;
        }

        @Override
        public String toString() {
            return super.toString();
        }
    }
}
