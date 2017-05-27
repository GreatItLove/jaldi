package com.jaldi.services.model;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/26/17
 * Time: 5:21 PM
 */
public class DashboardMetaData {

    private long usersCount;
    private long ordersCount;
    private double totalAmount;
    private long workersCount;

    public long getUsersCount() {
        return usersCount;
    }

    public void setUsersCount(long usersCount) {
        this.usersCount = usersCount;
    }

    public long getOrdersCount() {
        return ordersCount;
    }

    public void setOrdersCount(long ordersCount) {
        this.ordersCount = ordersCount;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public long getWorkersCount() {
        return workersCount;
    }

    public void setWorkersCount(long workersCount) {
        this.workersCount = workersCount;
    }
}
