package pro.jaldi;

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
    String paymentType;//": "CASH",
    float userRating;//: 5,
    String userFeedback;//": null,
    UserModel user;//":{
    List<UserModel> workersList;
    long orderDate;//": 1496253600000,
    long creationDate;//": 1496235815000,
//            "workersList": null,
//            "formattedOrderDate": "31/05/2017 18:00",
//            "formattedCreationDate": "31/05/2017 13:03"
}
