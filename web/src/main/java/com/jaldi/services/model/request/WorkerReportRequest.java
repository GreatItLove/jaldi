package com.jaldi.services.model.request;

import java.math.BigDecimal;

/**
 * Created by ArtStyle on 15.07.2017.
 */
public class WorkerReportRequest {

    private String name;
    private BigDecimal cost;
    private float hours;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public float getHours() {
        return hours;
    }

    public void setHours(float hours) {
        this.hours = hours;
    }
}
