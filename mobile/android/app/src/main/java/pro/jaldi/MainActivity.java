package pro.jaldi;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import static pro.jaldi.LoginActivity.SERVER_API_URL;

public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener, OrderFragment.OnListFragmentInteractionListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);
        showMyOrders();
        View header = navigationView.getHeaderView(0);
        ImageView profileImageView = (ImageView) header.findViewById(R.id.profileImageView);
        setProfileImageAsync(profileImageView);
    }

    private void setProfileImageAsync(final ImageView profileImageView) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    String imageId = LoginActivity.getProfileImageId(MainActivity.this);
                    URL imageUrl = new URL(SERVER_API_URL + "getFile?id=" + imageId);
                    final Bitmap mIcon_val = BitmapFactory.decodeStream(imageUrl.openConnection().getInputStream());
                    if (mIcon_val != null) {
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                profileImageView.setImageBitmap(mIcon_val);
                            }
                        });
                    }
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
        thread.start();
    }

    @Override
    public void onBackPressed() {
        ImageView profileImageView = (ImageView) findViewById(R.id.profileImageView);
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.orders) {
            showAllOrders();
        } else if (id == R.id.myOrders) {
            showMyOrders();
        } else if (id == R.id.signOut) {
            signOut();
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    private void showAllOrders() {
        OrderFragment orderFragment = new OrderFragment();
        FragmentManager fm = getSupportFragmentManager();
        fm.popBackStack(null, FragmentManager.POP_BACK_STACK_INCLUSIVE);
        FragmentTransaction tr = fm.beginTransaction();
        tr.replace(R.id.ordersListContainer, orderFragment);
        tr.commit();
    }

    private void showMyOrders() {
        OrderFragment orderFragment = new OrderFragment();
        FragmentManager fm = getSupportFragmentManager();
        fm.popBackStack(null, FragmentManager.POP_BACK_STACK_INCLUSIVE);
        FragmentTransaction tr = fm.beginTransaction();
        tr.replace(R.id.ordersListContainer, orderFragment);
        tr.commit();
    }

    private void signOut() {
        LoginActivity.signOut(this);
        Intent intent = new Intent(this, LoginActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(intent);
    }

    private void showOrderDetails(OrderModel selectedOrder) {
        OrderDetailFragment orderDetailFragment = new OrderDetailFragment();
        orderDetailFragment.selectedOrder = selectedOrder;
        FragmentManager fm = getSupportFragmentManager();
        FragmentTransaction tr = fm.beginTransaction();
        tr.replace(R.id.ordersListContainer, orderDetailFragment).addToBackStack("");
        tr.commit();
    }

    @Override
    public void onListFragmentInteraction(OrderModel order) {
        Log.d("MYTAG", "Oroder " + order.id + " clicked");
        showOrderDetails(order);
    }
}
