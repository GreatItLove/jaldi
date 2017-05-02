package com.jaldi.services.model.request;

/**
 * User: Sedrak Dalaloyan
 * Date: 6/21/15
 * Time: 19:35
 */
public class UpdateProfileRequest {

    private long id;
    private String oldPassword;
    private String newPassword;
    private String profileImageBase64;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getProfileImageBase64() {
        return profileImageBase64;
    }

    public void setProfileImageBase64(String profileImageBase64) {
        this.profileImageBase64 = profileImageBase64;
    }
}
