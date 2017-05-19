package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.OrderMapper;
import com.jaldi.services.model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/16/17
 * Time: 3:56 PM
 */
@Repository
public class OrderDaoImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private NamedParameterJdbcTemplate namedJdbc;


    public Order create(Order order) {
        KeyHolder holder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {

            @Override
            public PreparedStatement createPreparedStatement(Connection connection)
                    throws SQLException {
                PreparedStatement ps = connection.prepareStatement("INSERT INTO `order` (type, status, workers, hours, address, latitude, longitude, cost, paymentType, orderDate, userId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, order.getType().name());
                ps.setString(2, order.getStatus().name());
                ps.setInt(3, order.getWorkers());
                ps.setFloat(4, order.getHours());
                ps.setString(5, order.getAddress());
                if(order.getLatitude() == null) {
                    ps.setNull(6, Types.DECIMAL);
                } else {
                    ps.setDouble(6, order.getLatitude());
                }
                if(order.getLongitude() == null) {
                    ps.setNull(7, Types.DECIMAL);
                } else {
                    ps.setDouble(7, order.getLongitude());
                }
                ps.setBigDecimal(8, order.getCost());
                ps.setString(9, order.getPaymentType().name());
                ps.setTimestamp(10, new Timestamp(order.getOrderDate().getTime()));
                ps.setLong(11, order.getUser().getId());
                return ps;
            }
        }, holder);
        order.setId(holder.getKey().longValue());
        return order;
    }

    public List<Order> findAll(String status) {
        try {
            Map namedParameters = new HashMap();
            namedParameters.put("status", status);
            return namedJdbc.query("SELECT `type`, `status`, `workers`, `hours`, `address`, `latitude`, " +
                    "`longitude`, `cost`, `paymentType`, `orderDate`, `userId`, `creationDate` FROM `order` WHERE :status is null OR `status` = :status", namedParameters, new OrderMapper());
        } catch (DataAccessException e) {
            return Collections.emptyList();
        }
    }
}
