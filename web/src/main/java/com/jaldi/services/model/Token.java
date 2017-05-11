package com.jaldi.services.model;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/11/17
 * Time: 4:20 PM
 */
public class Token {

    public enum Type {
        RESET_PASSWORD
    }

    private long id;
    private String token;
    private long userId;
    private Type type;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }
}
