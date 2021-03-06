package com.jaldi.services.dao.mapper;

import com.jaldi.services.common.DaoUtils;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/17/17
 * Time: 5:56 PM
 */
public class OrderMapper implements RowMapper<Order> {

    @Override
    public Order mapRow(ResultSet rs, int i) throws SQLException {
        Order order = new Order();
        order.setId(rs.getLong("id"));
        order.setType(Order.Type.valueOf(rs.getString("type")));
        order.setStatus(Order.Status.valueOf(rs.getString("status")));
        order.setWorkers(rs.getInt("workers"));
        order.setHours(rs.getInt("hours"));
        order.setAddress(rs.getString("address"));
        order.setCity(rs.getString("city"));
        order.setCountry(rs.getString("country"));
        order.setComment(rs.getString("comment"));
        double latitude = rs.getDouble("latitude");
        if (!rs.wasNull()) {
            order.setLatitude(latitude);
        }
        double longitude = rs.getDouble("longitude");
        if (!rs.wasNull()) {
            order.setLongitude(longitude);
        }
        order.setCost(rs.getBigDecimal("cost"));
        order.setPaymentType(Order.PaymentType.valueOf(rs.getString("paymentType")));
        int userRating = rs.getInt("userRating");
        if (!rs.wasNull()) {
            order.setUserRating(userRating);
        }
        order.setUserFeedback(rs.getString("userFeedback"));
        order.setOrderDate(rs.getTimestamp("orderDate"));
        User user = new User();
        user.setId(rs.getLong("userId"));
        if(DaoUtils.hasColumn(rs, "userPhone")) {
            user.setPhone(rs.getString("userPhone"));
        }
        order.setUser(user);
        order.setCreationDate(rs.getTimestamp("creationDate"));
        return order;
    }
}
