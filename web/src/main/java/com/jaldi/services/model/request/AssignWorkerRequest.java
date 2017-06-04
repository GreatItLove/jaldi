package com.jaldi.services.model.request;

/**
 * Created by ArtStyle on 03.06.2017.
 */
public class AssignWorkerRequest {

    private long orderId;
    private long workerId;

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public long getWorkerId() {
        return workerId;
    }

    public void setWorkerId(long workerId) {
        this.workerId = workerId;
    }
}
