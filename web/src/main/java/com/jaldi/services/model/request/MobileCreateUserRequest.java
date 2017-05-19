package com.jaldi.services.model.request;

import com.jaldi.services.model.User;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/19/17
 * Time: 12:53 PM
 */
public class MobileCreateUserRequest {

    private long verificationId;
    private String verificationCode;
    private User User;

    public long getVerificationId() {
        return verificationId;
    }

    public void setVerificationId(long verificationId) {
        this.verificationId = verificationId;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public com.jaldi.services.model.User getUser() {
        return User;
    }

    public void setUser(com.jaldi.services.model.User user) {
        User = user;
    }
}
