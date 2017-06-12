package com.jaldi.services.common;

import com.jaldi.services.dao.TokenDaoImpl;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.Token;
import com.notnoop.apns.APNS;
import com.notnoop.apns.ApnsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/7/17
 * Time: 5:55 PM
 */
@Service
public class PushNotificationService {

    @Autowired
    private ApnsService apnsService;

    @Autowired
    private TokenDaoImpl tokenDao;

    public void sendOrderStatusChangedNotification(Order order) {
        String message = "Your order status has been changed.";
        if(order.getStatus() == Order.Status.FINISHED) {
            message = "Work finished! Please rate your experience to improve service quality.";
        }
        String payload = APNS.newPayload().alertBody(message).
                customField("orderId", order.getId()).customField("orderStatus", order.getStatus().name())
                .sound("default").build();
        Token token = tokenDao.getUserToken(order.getUser().getId(), Token.Type.APNS);
        if(token != null) {
            apnsService.push(token.getToken(), payload);
        }
    }
}
