package com.jaldi.services.model;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.jaldi.services.common.date.CommonDateTimeSerializer;

import java.util.Date;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/28/17
 * Time: 5:06 PM
 */
public class User {

    public enum Role {
        USER,
        OPERATOR,
        ADMIN
    }

    public enum Type {
        CUSTOMER,
        WORKER,
        INTERNAL
    }

    private long id;
    private String name;
    private String email;
    private String phone;
    private String password;
    private Role role;
    private Type type;
    private String profileImageId;
    private boolean active;
    private boolean deleted;
    private Date creationDate;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public String getProfileImageId() {
        return profileImageId;
    }

    public void setProfileImageId(String profileImageId) {
        this.profileImageId = profileImageId;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    @JsonSerialize(using = CommonDateTimeSerializer.class)
    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }
}
