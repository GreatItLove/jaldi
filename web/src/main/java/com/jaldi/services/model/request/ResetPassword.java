package com.jaldi.services.model.request;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/29/17
 * Time: 6:19 PM
 */
public class ResetPassword {

    private String token;
    private String password;
    private String password2;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword2() {
        return password2;
    }

    public void setPassword2(String password2) {
        this.password2 = password2;
    }
}
