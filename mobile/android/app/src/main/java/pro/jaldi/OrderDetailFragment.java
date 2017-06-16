package pro.jaldi;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;


public class OrderDetailFragment extends Fragment implements OnMapReadyCallback {
    public OrderModel selectedOrder;

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
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_order_detail, container, false);

        SupportMapFragment mapFragment = (SupportMapFragment) getChildFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);


        ImageView orderTypeIcon = (ImageView) view.findViewById(R.id.detailsOrderIcon);
        OrderModel.OrderTypeModel orderTypeModel = selectedOrder.getOrderTypeModel();
        orderTypeIcon.setImageResource(orderTypeModel.imageResId);

        TextView orderAddress = (TextView) view.findViewById(R.id.detailsAddressValue);
        orderAddress.setText(selectedOrder.getAddress());

        TextView orderCost = (TextView) view.findViewById(R.id.detailsCostValue);
        orderCost.setText(selectedOrder.getCost());

        TextView orderDistance = (TextView) view.findViewById(R.id.detailsDistanceValue);
        orderDistance.setText(selectedOrder.getDistance());

        TextView orderDuration = (TextView) view.findViewById(R.id.detailsDurationValue);
        orderDuration.setText(selectedOrder.getDuration());


        return view;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        LatLng sydney = new LatLng(selectedOrder.latitude, selectedOrder.longitude);
        googleMap.addMarker(new MarkerOptions().position(sydney).title(selectedOrder.address));
        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(sydney, 15.0f));
    }
}
