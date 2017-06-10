package pro.jaldi;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class LauncherActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_launcher);

        SharedPreferences userDetails = getSharedPreferences("userDetails", MODE_PRIVATE);
        String authToken = userDetails.getString("authToken","");
        Intent intent;

        if (authToken.equals("")) {
            // unauthorized
            intent = new Intent(this, LoginActivity.class);
        } else {
            // authorized
            intent = new Intent(this, MainActivity.class);
        }
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NO_ANIMATION);
        this.overridePendingTransition(0, 0);
        startActivity(intent);
    }
}
