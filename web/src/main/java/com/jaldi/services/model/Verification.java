package com.jaldi.services.model;

import java.util.Date;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/19/17
 * Time: 12:26 PM
 */
public class Verification {

    private long id;
    private String recipient;
    private String code;
    private Date creationDate;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }
}
