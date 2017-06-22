package pro.jaldi;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationManager;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.NavigationView;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.gms.location.FusedLocationProviderClient;

import org.json.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import static pro.jaldi.LoginActivity.LOGIN_TOKEN_KEY;
import static pro.jaldi.LoginActivity.SERVER_API_URL;
import static pro.jaldi.LoginActivity.getAuthToken;

public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener, WorkFragment.OnListFragmentInteractionListener {

    private FusedLocationProviderClient mFusedLocationClient;
    private int MY_PERMISSIONS_REQUEST_LOCATION = 111;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        startLoacionUpdate();
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);
        showFindWork();
        navigationView.setCheckedItem(R.id.findWork);
        View header = navigationView.getHeaderView(0);
        ImageView profileImageView = (ImageView) header.findViewById(R.id.profileImageView);
        setProfileImageAsync(profileImageView);
    }

    private void uploadLocation(Location location) {
        Log.d("LOCATION_LOG", "lon: " + location.getLongitude());
        Log.d("LOCATION_LOG", "lat: " + location.getLatitude());

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        String URL = SERVER_API_URL + "rest/profile/location";

        Map<String, String>  params = new HashMap<String, String>();
        params.put("latitude", location.getLatitude() + "");
        params.put("longitude", location.getLongitude() + "");

        JSONObject jsonBody = new JSONObject(params);
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

                    return null;
                }
            }

            @Override
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String>  params = new HashMap<String, String>();
                params.put(LOGIN_TOKEN_KEY, getAuthToken(MainActivity.this));
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                String jsonResponse = new String(response.data);
                return Response.success(jsonResponse, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private void startLoacionUpdate() {
        LocationManager locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        android.location.LocationListener locationListener = new android.location.LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                uploadLocation(location);
            }

            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {
            }

            @Override
            public void onProviderEnabled(String provider) {
            }

            @Override
            public void onProviderDisabled(String provider) {
            }
        };
        Criteria criteria = new Criteria();
        criteria.setAccuracy(Criteria.ACCURACY_MEDIUM);
        criteria.setAltitudeRequired(false);
        criteria.setBearingRequired(false);
        criteria.setCostAllowed(true);
        criteria.setPowerRequirement(Criteria.POWER_HIGH);
        String provider = locationManager.getBestProvider(criteria, true);

        if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            requestLocationPermission();
        } else {
            locationManager.requestLocationUpdates(provider, 2 * 60 * 1000/*milliseconds*/, 200/*meters*/, locationListener);
        }
    }

    private void requestLocationPermission() {
        if (ContextCompat.checkSelfPermission(this,
                android.Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED) {

                ActivityCompat.requestPermissions(this,
                        new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION},
                        MY_PERMISSIONS_REQUEST_LOCATION);

        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == MY_PERMISSIONS_REQUEST_LOCATION) {
            if (grantResults.length > 0
                    && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                startLoacionUpdate();
            }
        }
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
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
            updateActionBar(null);
        }
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.findWork) {
            showFindWork();
        } else if (id == R.id.myWorks) {
            showMyWorks();
        } else if (id == R.id.signOut) {
            signOut();
        } else if (id == R.id.contactOperator) {
            contactOperator();
            return false;
        }
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    private void showFindWork() {
        WorkFragment workFragment = new WorkFragment();
        workFragment.shouldShowMyWorks = false;
        FragmentManager fm = getSupportFragmentManager();
        fm.popBackStack(null, FragmentManager.POP_BACK_STACK_INCLUSIVE);
        FragmentTransaction tr = fm.beginTransaction();
        tr.replace(R.id.worksListContainer, workFragment);
        tr.commit();
        ActionBar ab = getSupportActionBar();
        if (ab != null) {
            ab.setTitle(R.string.action_bar_title_find_work);
            ab.setSubtitle(null);
        }
    }

    private void showMyWorks() {
        WorkFragment workFragment = new WorkFragment();
        workFragment.shouldShowMyWorks = true;
        FragmentManager fm = getSupportFragmentManager();
        fm.popBackStack(null, FragmentManager.POP_BACK_STACK_INCLUSIVE);
        FragmentTransaction tr = fm.beginTransaction();
        tr.replace(R.id.worksListContainer, workFragment);
        tr.commit();
        ActionBar ab = getSupportActionBar();
        if (ab != null) {
            ab.setTitle(getText(R.string.action_bar_title_my_works));
            ab.setSubtitle(null);
        }
    }

    private void contactOperator() {
        final String operatorPhone = "+97455568546";
        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.fromParts("tel", operatorPhone, null));
        startActivity(intent);
    }

    private void updateActionBar(MyWorkRecyclerViewAdapter.WorkViewHolder selectedWork) {
        ActionBar ab = getSupportActionBar();
        if (ab == null) {
            return;
        }
        Fragment activeFragment = getSupportFragmentManager().findFragmentById(R.id.worksListContainer);
        if (activeFragment instanceof WorkFragment) {
            if (((WorkFragment)activeFragment).shouldShowMyWorks) {
                ab.setTitle(R.string.action_bar_title_my_works);
                ab.setSubtitle(null);
            } else {
                ab.setTitle(R.string.action_bar_title_find_work);
                ab.setSubtitle(null);
            }
        } else if (activeFragment instanceof WorkDetailFragment && selectedWork != null) {
            String workNumber = " (" + selectedWork.mWork.id + ")";
            ab.setTitle(selectedWork.workType.getText() + workNumber);
            ab.setSubtitle(selectedWork.workDate.getText() + " " + selectedWork.workTime.getText());
        }
    }

    private void signOut() {
        LoginActivity.signOut(this);
        Intent intent = new Intent(this, LoginActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(intent);
    }

    private void showWorkDetails(MyWorkRecyclerViewAdapter.WorkViewHolder selectedWork) {
        WorkDetailFragment workDetailFragment = new WorkDetailFragment();
        workDetailFragment.selectedWork = selectedWork.mWork;
        FragmentManager fm = getSupportFragmentManager();
        FragmentTransaction tr = fm.beginTransaction();
        ActionBar ab = getSupportActionBar();
        if (ab != null) {
            String workNumber = " (" + selectedWork.mWork.id + ")";
            ab.setTitle(selectedWork.workType.getText() + workNumber);
            ab.setSubtitle(selectedWork.workDate.getText() + " " + selectedWork.workTime.getText());
        }
        tr.replace(R.id.worksListContainer, workDetailFragment).addToBackStack("");
        tr.commit();
    }

    @Override
    public void onListFragmentInteraction(MyWorkRecyclerViewAdapter.WorkViewHolder work) {
        Fragment activeFragment = getSupportFragmentManager().findFragmentById(R.id.worksListContainer);
        if (activeFragment instanceof WorkFragment && ((WorkFragment)activeFragment).shouldShowMyWorks) {
            showWorkDetails(work);
        }
    }
}
