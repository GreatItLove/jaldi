package pro.jaldi;

import android.content.Context;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by samvel on 6/5/17.
 */

public class WorkModel {
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


    Context mContext;

    WorkTypeModel getWorkTypeModel() {
        WorkTypeModel workTypeModel = new WorkTypeModel();
        switch (type) {
            case "CLEANER":
                workTypeModel.imageResId = R.drawable.work_type_cleaner;
                workTypeModel.titleResId = R.string.work_type_cleaner;
                break;
            case "CARPENTER":
                workTypeModel.imageResId = R.drawable.work_type_carpenter;
                workTypeModel.titleResId = R.string.work_type_carpenter;
                break;
            case "ELECTRICIAN":
                workTypeModel.imageResId = R.drawable.work_type_electrician;
                workTypeModel.titleResId = R.string.work_type_electrician;
                break;
            case "MASON":
                workTypeModel.imageResId = R.drawable.work_type_mason;
                workTypeModel.titleResId = R.string.work_type_mason;
                break;
            case "PAINTER":
                workTypeModel.imageResId = R.drawable.work_type_painter;
                workTypeModel.titleResId = R.string.work_type_painter;
                break;
            case "PLUMBER":
                workTypeModel.imageResId = R.drawable.work_type_plumber;
                workTypeModel.titleResId = R.string.work_type_plumber;
                break;
            case "AC_TECHNICAL":
                workTypeModel.imageResId = R.drawable.work_type_ac_technical;
                workTypeModel.titleResId = R.string.work_type_ac_technical;
                break;
        }
        return workTypeModel;
    }

    WorkStatusModel getWorkStatus() {
        WorkStatusModel workStatusModel = new WorkStatusModel();
        switch (status) {
            case "CREATED":
                workStatusModel.titleResId = R.string.status_created;
                workStatusModel.backgroundColorResId = R.color.status_created;
                break;
            case "ASSIGNED":
                workStatusModel.titleResId = R.string.status_assigned;
                workStatusModel.backgroundColorResId = R.color.status_assigned;
                break;
            case "EN_ROUTE":
                workStatusModel.titleResId = R.string.status_en_route;
                workStatusModel.backgroundColorResId = R.color.status_en_route;
                break;
            case "WORKING":
                workStatusModel.titleResId = R.string.status_working;
                workStatusModel.backgroundColorResId = R.color.status_working;
                break;
            case "TIDYING_UP":
                workStatusModel.titleResId = R.string.status_tidying_up;
                workStatusModel.backgroundColorResId = R.color.status_tidying_up;
                break;
            case "FINISHED":
                workStatusModel.titleResId = R.string.status_finished;
                workStatusModel.backgroundColorResId = R.color.status_finished;
                break;
            case "CANCELED":
                workStatusModel.titleResId = R.string.status_canceled;
                workStatusModel.backgroundColorResId = R.color.status_canceled;
                break;
        }
        return workStatusModel;
    }

    String getUserName() {
        return user.name == null ? "" : user.name;
    }

    String getUserPhone() {
        return user.phone == null ? "" : user.phone;
    }

    String getCost() {
        String workCost = mContext.getString(R.string.not_available);
        if (cost != 0) {
            workCost = cost + " " + mContext.getString(R.string.work_cost_metric);
        }
        return workCost;
    }

    String getAddress() {
        String workAddress = mContext.getString(R.string.not_available);
        if (address != null && !address.isEmpty()) {
            workAddress = address;
            if (city != null && !city.isEmpty()) {
                workAddress += ", " + city;
            }
        }
        return workAddress;
    }

    String getLeftPositions() {
        int positionsNeeded = workers;
        int positionsLeft = positionsNeeded;
        if (workersList != null) {
            positionsLeft -= workersList.size();
        }
        return mContext.getString(R.string.work_workers_left, positionsLeft, positionsNeeded);
    }

    String getDuration() {
        String duration = mContext.getString(R.string.not_available);
        if (hours != 0) {
            duration = mContext.getString(R.string.work_duration, hours);
        }
        return duration;
    }

    String getDistance() {
        String distanceString = mContext.getString(R.string.not_available);
        if (distance > 0) {
            distanceString = mContext.getString(R.string.work_distance, (float)distance);
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

    static class WorkTypeModel {
        int imageResId;
        int titleResId;
    }

    static class WorkStatusModel {
        int backgroundColorResId;
        int titleResId;
    }
}
