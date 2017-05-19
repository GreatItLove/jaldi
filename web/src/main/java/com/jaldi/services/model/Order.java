package com.jaldi.services.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.jaldi.services.common.date.CommonDateTimeDeserializer;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/15/17
 * Time: 4:43 PM
 */
public class Order {

    public enum Type {
        CLEANER,
        CARPENTER,
        ELECTRICIAN,
        MASON,
        PAINTER,
        PLUMBER,
        AC_TECHNICAL
    }

    public enum Status {
        CREATED,
        CANCELED
    }

    public enum PaymentType {
        CASH
    }

    private long id;
    private Type type;
    private Status status;
    private int workers;
    private float hours;
    private String address;
    private Double latitude;
    private Double longitude;
    private BigDecimal cost;
    private PaymentType paymentType;
    private Date orderDate;
    private User user;
    private Date creationDate;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getWorkers() {
        return workers;
    }

    public void setWorkers(int workers) {
        this.workers = workers;
    }

    public float getHours() {
        return hours;
    }

    public void setHours(float hours) {
        this.hours = hours;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public PaymentType getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    @JsonDeserialize(using = CommonDateTimeDeserializer.class)
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }
}
