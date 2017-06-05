package com.jaldi.services.model;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/5/17
 * Time: 7:42 PM
 */
public class PartialOrder {

    private Order order;
    private User worker;
    private Float rating;

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public User getWorker() {
        return worker;
    }

    public void setWorker(User worker) {
        this.worker = worker;
    }

    public Float getRating() {
        return rating;
    }

    public void setRating(Float rating) {
        this.rating = rating;
    }
}
