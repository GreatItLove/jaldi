package com.jaldi.services.model;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/14/17
 * Time: 3:08 AM
 */
public class OrderByTypeMetaData {

    private Order.Type type;
    private long count;
    private long amount;

    public Order.Type getType() {
        return type;
    }

    public void setType(Order.Type type) {
        this.type = type;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }
}
