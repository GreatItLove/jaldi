package pro.jaldi;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

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
import com.google.gson.Gson;

import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * A login screen that offers login via email/password.
 */
public class LoginActivity extends AppCompatActivity {

    //public static final String SERVER_API_URL = "https://jaldi.pro/";
    public static final String SERVER_API_URL = "http://dev.jaldi.pro/";
    public static final String LOGIN_TOKEN_KEY = "Authorization";
    private static final String AUTH_TOKEN_KEY = "authTokenKey";
    private static final String PROFILE_IMAGE_ID_KEY = "profileIdKey";

    // UI references.
    private EditText mEmailView;
    private EditText mPasswordView;
    private View mProgressView;
    private View mLoginFormView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        // Set up the login form.
        mEmailView = (EditText) findViewById(R.id.email);

        mPasswordView = (EditText) findViewById(R.id.password);
        mPasswordView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int id, KeyEvent keyEvent) {
                if (id == R.id.login || id == EditorInfo.IME_NULL) {
                    attemptLogin();
                    return true;
                }
                return false;
            }
        });

        Button mEmailSignInButton = (Button) findViewById(R.id.email_sign_in_button);
        mEmailSignInButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                attemptLogin();
            }
        });

        mLoginFormView = findViewById(R.id.login_form);
        mProgressView = findViewById(R.id.login_progress);
    }


    /**
     * Attempts to sign in or register the account specified by the login form.
     * If there are form errors (invalid email, missing fields, etc.), the
     * errors are presented and no actual login attempt is made.
     */
    private void attemptLogin() {

        // Reset errors.
        mEmailView.setError(null);
        mPasswordView.setError(null);

        // Store values at the time of the login attempt.
        String email = mEmailView.getText().toString();
        String password = mPasswordView.getText().toString();

        boolean cancel = false;
        View focusView = null;

        // Check for a valid password, if the user entered one.
        if (!TextUtils.isEmpty(password) && !isPasswordValid(password)) {
            mPasswordView.setError(getString(R.string.error_incorrect_password));
            focusView = mPasswordView;
            cancel = true;
        }

        // Check for a valid email address.
        if (TextUtils.isEmpty(email)) {
            mEmailView.setError(getString(R.string.error_field_required));
            focusView = mEmailView;
            cancel = true;
        } else if (!isEmailValid(email)) {
            mEmailView.setError(getString(R.string.error_incorrect_password));
            focusView = mEmailView;
            cancel = true;
        }

        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            showProgress(true);
            login();
        }
    }

    private boolean isEmailValid(String email) {
        return email.contains("@");
    }

    private boolean isPasswordValid(String password) {
        return password.length() > 1;
    }

    /**
     * Shows the progress UI and hides the login form.
     */
    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
    private void showProgress(final boolean show) {
            int shortAnimTime = getResources().getInteger(android.R.integer.config_shortAnimTime);

            mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
            mLoginFormView.animate().setDuration(shortAnimTime).alpha(
                    show ? 0 : 1).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
                }
            });

            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            mProgressView.animate().setDuration(shortAnimTime).alpha(
                    show ? 1 : 0).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
                }
            });
    }

    protected Map<String, String> getParams()
    {
        Map<String, String>  params = new HashMap<String, String>();
        params.put("username", mEmailView.getText().toString());
        params.put("password", mPasswordView.getText().toString());

        return params;
    }


    private void login() {

        RequestQueue requestQueue = Volley.newRequestQueue(LoginActivity.this);
        String URL = SERVER_API_URL + "loginjwt";
        JSONObject jsonBody = new JSONObject(getParams());
        final String requestBody = jsonBody.toString();

        StringRequest stringRequest = new StringRequest(Request.Method.POST, URL, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.i("VOLLEY", response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("VOLLEY", error.toString());
                mEmailView.setError(getString(R.string.error_connection));
                mPasswordView.setError(getString(R.string.error_connection));
                showProgress(false);
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
                    mEmailView.setError(getString(R.string.error_connection));
                    mPasswordView.setError(getString(R.string.error_connection));
                    showProgress(false);
                    return null;
                }
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                String responseString = "";
                if (response != null) {
                    responseString = String.valueOf(response.statusCode);
                    if (response.statusCode == 200) {
                        String authToken = response.headers.get(LOGIN_TOKEN_KEY);
                        if (authToken != null && !authToken.equals("")) {
                            saveAuthToken(LoginActivity.this, authToken);
                            handleLoginSuccess();
                            return Response.success(responseString, HttpHeaderParser.parseCacheHeaders(response));
                        }
                    }
                }
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        mEmailView.setError(getString(R.string.error_incorrect_password));
                        mPasswordView.setError(getString(R.string.error_incorrect_password));
                        showProgress(false);
                    }
                });
                return Response.success(responseString, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }

    private void handleLoginSuccess() {
        requestProfileImage();
    }

    private void navigateToMainActivity() {
        Intent intent = new Intent(this, MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(intent);
    }

    private static void saveAuthToken(Context context, String token) {
        SharedPreferences userDetails = context.getSharedPreferences("userDetails", MODE_PRIVATE);
        SharedPreferences.Editor edit = userDetails.edit();
        edit.clear();
        edit.putString(AUTH_TOKEN_KEY, token);
        edit.commit();
    }

    private static void saveProfileImageId(Context context, String imageId) {
        SharedPreferences userDetails = context.getSharedPreferences("userDetails", MODE_PRIVATE);
        SharedPreferences.Editor edit = userDetails.edit();
        edit.putString(PROFILE_IMAGE_ID_KEY, imageId);
        edit.commit();
    }

    public static String getProfileImageId(Context context) {
        SharedPreferences userDetails = context.getSharedPreferences("userDetails", MODE_PRIVATE);
        return userDetails.getString(PROFILE_IMAGE_ID_KEY,null);
    }

    public static void signOut(Context context) {
        saveAuthToken(context, null);
    }

    public static String getAuthToken(Context context) {
        SharedPreferences userDetails = context.getSharedPreferences("userDetails", MODE_PRIVATE);
        return userDetails.getString(AUTH_TOKEN_KEY,null);
    }

    private void requestProfileImage() {
        RequestQueue requestQueue = Volley.newRequestQueue(LoginActivity.this);
        String URL = SERVER_API_URL + "rest/profile/0";

        StringRequest stringRequest = new StringRequest(Request.Method.GET, URL, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.i("VOLLEY", response);
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.e("VOLLEY", error.toString());
                showProgress(false);
                navigateToMainActivity();
            }
        }) {
            @Override
            public Map<String, String> getHeaders() throws AuthFailureError {
                Map<String, String>  params = new HashMap<String, String>();
                params.put(LOGIN_TOKEN_KEY, getAuthToken(LoginActivity.this));
                return params;
            }

            @Override
            protected Response<String> parseNetworkResponse(NetworkResponse response) {
                String responseString = "";
                if (response != null) {
                    responseString = String.valueOf(response.statusCode);
                    if (response.statusCode == 200) {
                        String jsonResponse = new String(response.data);
                        ProfileModel userProfile = new Gson().fromJson(jsonResponse, ProfileModel.class);
                        saveProfileImageId(LoginActivity.this, userProfile.profileImageId);
                    }
                }
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        navigateToMainActivity();                    }
                });
                return Response.success(responseString, HttpHeaderParser.parseCacheHeaders(response));
            }
        };
        requestQueue.add(stringRequest);
    }
}

