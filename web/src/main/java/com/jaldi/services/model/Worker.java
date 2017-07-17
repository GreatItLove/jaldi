package com.jaldi.services.model;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/3/17
 * Time: 6:03 PM
 */
public class Worker {

    private User user;
    private boolean cleaner;
    private boolean carpenter;
    private boolean electrician;
    private boolean mason;
    private boolean painter;
    private boolean plumber;
    private boolean acTechnical;
    private float rating;
    private int totalOrders;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public boolean isCarpenter() {
        return carpenter;
    }

    public boolean isCleaner() {
        return cleaner;
    }

    public void setCleaner(boolean cleaner) {
        this.cleaner = cleaner;
    }

    public void setCarpenter(boolean carpenter) {
        this.carpenter = carpenter;
    }

    public boolean isElectrician() {
        return electrician;
    }

    public void setElectrician(boolean electrician) {
        this.electrician = electrician;
    }

    public boolean isMason() {
        return mason;
    }

    public void setMason(boolean mason) {
        this.mason = mason;
    }

    public boolean isPainter() {
        return painter;
    }

    public void setPainter(boolean painter) {
        this.painter = painter;
    }

    public boolean isPlumber() {
        return plumber;
    }

    public void setPlumber(boolean plumber) {
        this.plumber = plumber;
    }

    public boolean isAcTechnical() {
        return acTechnical;
    }

    public void setAcTechnical(boolean acTechnical) {
        this.acTechnical = acTechnical;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }
}
