package com.jaldi.services.model;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.jaldi.services.common.date.CommonDateTimeDeserializer;
import com.jaldi.services.common.date.CommonDateTimeSerializer;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

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
        ASSIGNED,
        EN_ROUTE,
        WORKING,
        TIDYING_UP,
        FINISHED,
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
    private String city;
    private String country;
    private String comment;
    private Double latitude;
    private Double longitude;
    private BigDecimal cost;
    private PaymentType paymentType;
    private Integer userRating;
    private String userFeedback;
    private Date orderDate;
    private User user;
    private Date creationDate;
    private List<Worker> workersList;

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

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
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

    public Integer getUserRating() {
        return userRating;
    }

    public void setUserRating(Integer userRating) {
        this.userRating = userRating;
    }

    public String getUserFeedback() {
        return userFeedback;
    }

    public void setUserFeedback(String userFeedback) {
        this.userFeedback = userFeedback;
    }

    @JsonSerialize(using = CommonDateTimeSerializer.class)
    public Date getFormattedOrderDate() {
        return orderDate;
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

    @JsonSerialize(using = CommonDateTimeSerializer.class)
    public Date getFormattedCreationDate() {
        return creationDate;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public List<Worker> getWorkersList() {
        return workersList;
    }

    public void setWorkersList(List<Worker> workersList) {
        this.workersList = workersList;
    }
}
