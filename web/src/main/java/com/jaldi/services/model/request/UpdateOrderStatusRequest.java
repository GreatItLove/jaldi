package com.jaldi.services.model.request;

import com.jaldi.services.model.Order;

/**
 * Created by ArtStyle on 06.06.2017.
 */
public class UpdateOrderStatusRequest {

    private long orderId;
    private Order.Status status;

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public Order.Status getStatus() {
        return status;
    }

    public void setStatus(Order.Status status) {
        this.status = status;
    }
}
