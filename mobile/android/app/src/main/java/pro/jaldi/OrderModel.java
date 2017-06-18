package pro.jaldi;

import android.content.Context;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by samvel on 6/5/17.
 */

public class OrderModel {
    int id;
    String type;// "CLEANER",
    String status;//": "FINISHED",
    int workers;//": 1,
    int hours;//": 4,
    String address;//": "Bol'shaya Dmitrovka ulitsa 5/6с8",
    String city;//": null,
    String country;//": null,
    String comment;//": "",
    double latitude;//: 55.759613484815,
    double longitude;//: 37.614441699156,
    int cost;//": 400,
    double distance; //": 40,
    String paymentType;//": "CASH",
    float userRating;//: 5,
    String userFeedback;//": null,
    ProfileModel user;//":{
    List<ProfileModel> workersList;
    long orderDate;//": 1496253600000,
    long creationDate;//": 1496235815000,
//            "formattedOrderDate": "31/05/2017 18:00",
//            "formattedCreationDate": "31/05/2017 13:03"


    Context mContext;

    OrderTypeModel getOrderTypeModel() {
        OrderTypeModel orderTypeModel = new OrderTypeModel();
        switch (type) {
            case "CLEANER":
                orderTypeModel.imageResId = R.drawable.order_type_cleaner;
                orderTypeModel.titleResId = R.string.order_type_cleaner;
                break;
            case "CARPENTER":
                orderTypeModel.imageResId = R.drawable.order_type_carpenter;
                orderTypeModel.titleResId = R.string.order_type_carpenter;
                break;
            case "ELECTRICIAN":
                orderTypeModel.imageResId = R.drawable.order_type_electrician;
                orderTypeModel.titleResId = R.string.order_type_electrician;
                break;
            case "MASON":
                orderTypeModel.imageResId = R.drawable.order_type_mason;
                orderTypeModel.titleResId = R.string.order_type_mason;
                break;
            case "PAINTER":
                orderTypeModel.imageResId = R.drawable.order_type_painter;
                orderTypeModel.titleResId = R.string.order_type_painter;
                break;
            case "PLUMBER":
                orderTypeModel.imageResId = R.drawable.order_type_plumber;
                orderTypeModel.titleResId = R.string.order_type_plumber;
                break;
            case "AC_TECHNICAL":
                orderTypeModel.imageResId = R.drawable.order_type_ac_technical;
                orderTypeModel.titleResId = R.string.order_type_ac_technical;
                break;
        }
        return orderTypeModel;
    }

    OrderStatusModel getOrderStatus() {
        OrderStatusModel orderStatusModel = new OrderStatusModel();
        switch (status) {
            case "CREATED":
                orderStatusModel.titleResId = R.string.status_created;
                break;
            case "ASSIGNED":
                orderStatusModel.titleResId = R.string.status_assigned;
                break;
            case "EN_ROUTE":
                orderStatusModel.titleResId = R.string.status_en_route;
                break;
            case "WORKING":
                orderStatusModel.titleResId = R.string.status_working;
                break;
            case "TIDYING_UP":
                orderStatusModel.titleResId = R.string.status_tidying_up;
                orderStatusModel.backgroundColorResId = R.color.status_tidying_up;
                break;
            case "FINISHED":
                orderStatusModel.titleResId = R.string.status_finished;
                orderStatusModel.backgroundColorResId = R.color.status_finished;
                break;
            case "CANCELED":
                orderStatusModel.titleResId = R.string.status_canceled;
                break;
        }
        return orderStatusModel;
    }

    String getUserName() {
        return user.name == null ? "" : user.name;
    }

    String getUserPhone() {
        return user.phone == null ? "" : user.phone;
    }

    String getCost() {
        String orderCost = mContext.getString(R.string.not_available);
        if (cost != 0) {
            orderCost = cost + " " + mContext.getString(R.string.order_cost_metric);
        }
        return orderCost;
    }

    String getAddress() {
        String orderAddress = mContext.getString(R.string.not_available);
        if (address != null && !address.isEmpty()) {
            orderAddress = address;
            if (city != null && !city.isEmpty()) {
                orderAddress += ", " + city;
            }
        }
        return orderAddress;
    }

    String getLeftPositions() {
        int positionsNeeded = workers;
        int positionsLeft = positionsNeeded;
        if (workersList != null) {
            positionsLeft -= workersList.size();
        }
        return mContext.getString(R.string.order_workers_left, positionsLeft, positionsNeeded);
    }

    String getDuration() {
        String duration = mContext.getString(R.string.not_available);
        if (hours != 0) {
            duration = mContext.getString(R.string.order_duration, hours);
        }
        return duration;
    }

    String getDistance() {
        String distanceString = mContext.getString(R.string.not_available);
        if (distance > 0) {
            distanceString = mContext.getString(R.string.order_distance, (int)distance);
        }
        return distanceString;
    }

    String getDate() {
        String date = mContext.getString(R.string.not_available);
        if (creationDate != 0) {
            Date creationDate = new Date(orderDate);
            date = new SimpleDateFormat("dd MMM yyyy").format(creationDate);
        }
        return date;
    }

    String getTime() {
        String time = mContext.getString(R.string.not_available);
        if (creationDate != 0) {
            final long HOUR = 3600*1000;
            Date creationDate = new Date(orderDate);
            String startTime = new SimpleDateFormat("hh:mm a").format(creationDate);
            Date endDate = new Date(orderDate + hours * HOUR);
            String endTime = new SimpleDateFormat("hh:mm a").format(endDate);
            time = startTime + " - " + endTime;
        }
        return time;
    }

    static class OrderTypeModel {
        int imageResId;
        int titleResId;
    }

    static class OrderStatusModel {
        int backgroundColorResId;
        int titleResId;
    }
}
