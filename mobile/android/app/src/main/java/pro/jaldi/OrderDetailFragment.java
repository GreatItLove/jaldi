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
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;


public class OrderDetailFragment extends Fragment implements OnMapReadyCallback {
    public MyOrderRecyclerViewAdapter.OrderViewHolder selectedOrder;

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
//        MyOrderRecyclerViewAdapter.OrderTypeModel orderTypeModel = selectedOrder.get
//        orderTypeIcon.setImageResource(selectedOrder.orderIcon.image);
        return view;
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        LatLng sydney = new LatLng(selectedOrder.mOrder.latitude, selectedOrder.mOrder.longitude);
        googleMap.addMarker(new MarkerOptions().position(sydney).title(selectedOrder.mOrder.address));
        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(sydney, 15.0f));
    }
}
