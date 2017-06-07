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
        String payload = APNS.newPayload().alertBody("Your order status has been changed.").
                customField("orderId", order.getId()).sound("default").build();
        Token token = tokenDao.getUserToken(order.getUser().getId(), Token.Type.APNS);
        if(token != null) {
            apnsService.push(token.getToken(), payload);
        }
    }
}
