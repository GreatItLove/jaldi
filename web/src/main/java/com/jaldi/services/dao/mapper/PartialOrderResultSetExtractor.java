package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.Order;
import com.jaldi.services.model.User;
import com.jaldi.services.model.Worker;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/5/17
 * Time: 7:21 PM
 */
public class PartialOrderResultSetExtractor implements ResultSetExtractor<List<Order>> {

    private static final OrderMapper ORDER_MAPPER = new OrderMapper();

    @Override
    public List<Order> extractData(ResultSet rs) throws SQLException, DataAccessException {
        HashMap<Long, Order> orderHashMap = new HashMap<>();
        while (rs.next()) {
            long orderId = rs.getLong("id");
            Order order = orderHashMap.get(orderId);
            if(order == null) {
                order = ORDER_MAPPER.mapRow(rs, 0);
                long workerId = rs.getLong("workerId");
                if(workerId > 0) {
                    User user = new User();
                    user.setId(rs.getLong("workerId"));
                    user.setEmail(rs.getString("workerEmail"));
                    user.setName(rs.getString("workerName"));
                    user.setPhone(rs.getString("workerPhone"));
                    user.setProfileImageId(rs.getString("workerImage"));
                    user.setLongitude(rs.getDouble("workerLatitude"));
                    user.setLongitude(rs.getDouble("workerLongitude"));
                    Worker worker = new Worker();
                    float rating = rs.getFloat("rating");
                    if (!rs.wasNull()) {
                        worker.setRating(rating);
                    }
                    worker.setUser(user);
                    order.setWorkersList(new ArrayList<>());
                    order.getWorkersList().add(worker);
                }
                orderHashMap.put(orderId, order);
            }

        }
        return new ArrayList(orderHashMap.values());
    }
}
