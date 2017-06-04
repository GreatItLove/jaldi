package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.AssignWorkerRequestMapper;
import com.jaldi.services.dao.mapper.OrderMapper;
import com.jaldi.services.dao.mapper.WorkerMapper;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.Worker;
import com.jaldi.services.model.request.AssignWorkerRequest;
import com.sun.org.apache.xpath.internal.operations.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
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
import java.util.*;
import java.util.stream.Collectors;

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
                PreparedStatement ps = connection.prepareStatement("INSERT INTO `order` (type, status, workers, hours, address, city, country, comment, latitude, longitude, cost, paymentType, orderDate, userId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, order.getType().name());
                ps.setString(2, order.getStatus().name());
                ps.setInt(3, order.getWorkers());
                ps.setFloat(4, order.getHours());
                ps.setString(5, order.getAddress());
                ps.setString(6, order.getCity());
                ps.setString(7, order.getCountry());
                ps.setString(8, order.getComment());
                if(order.getLatitude() == null) {
                    ps.setNull(9, Types.DECIMAL);
                } else {
                    ps.setDouble(9, order.getLatitude());
                }
                if(order.getLongitude() == null) {
                    ps.setNull(10, Types.DECIMAL);
                } else {
                    ps.setDouble(10, order.getLongitude());
                }
                ps.setBigDecimal(11, order.getCost());
                ps.setString(12, order.getPaymentType().name());
                ps.setTimestamp(13, new Timestamp(order.getOrderDate().getTime()));
                ps.setLong(14, order.getUser().getId());
                return ps;
            }
        }, holder);
        order.setId(holder.getKey().longValue());
        return order;
    }

    public List<Order> findAll(String type, String status) {
        try {
            Map namedParameters = new HashMap();
            namedParameters.put("type", type);
            namedParameters.put("status", status);
            return namedJdbc.query("SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, " +
                    "`longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM `order` WHERE (:type is null OR `type` = :type) AND (:status is null OR `status` = :status);", namedParameters, new OrderMapper());
        } catch (DataAccessException e) {
            return Collections.emptyList();
        }
    }

    public List<Order> findForUser(long userId) {
        try {
            Map namedParameters = new HashMap();
            namedParameters.put("userId", userId);
            return namedJdbc.query("SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, " +
                    "`longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM `order` WHERE userId = :userId ORDER BY creationDate DESC;", namedParameters, new OrderMapper());
        } catch (DataAccessException e) {
            return Collections.emptyList();
        }
    }

    public Order findOne(long id) {
        try {
            return jdbcTemplate.queryForObject("SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, " +
                    "`longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM `order` WHERE id = ?;", new OrderMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public void updateWorkerRating(long id, Order order) {
        Map namedParameters = new HashMap();
        namedParameters.put("userId", id);
        namedParameters.put("userRating", order.getUserRating());
        namedParameters.put("id", order.getId());
        namedJdbc.update("update `order` set `userRating` = :userRating where `id` = :id AND `userId` = :userId;", namedParameters);
    }

    public void updateFeedback(long id, Order order) {
        Map namedParameters = new HashMap();
        namedParameters.put("userId", id);
        namedParameters.put("userFeedback", order.getUserFeedback());
        namedParameters.put("id", order.getId());
        namedJdbc.update("update `order` set `userFeedback` = :userFeedback where `id` = :id AND `userId` = :userId;", namedParameters);
    }

    public void cancelOrder(long userId, long orderId) {
        Map namedParameters = new HashMap();
        namedParameters.put("userId", userId);
        namedParameters.put("status", Order.Status.CANCELED.name());
        namedParameters.put("id", orderId);
        namedJdbc.update("update `order` set `status` = :status where `id` = :id AND `userId` = :userId;", namedParameters);
    }

    public List<Worker> findWorkersByOrderId(long orderId){
        Map namedParameters = new HashMap();
        namedParameters.put("orderId", orderId);
        return namedJdbc.query("SELECT `id`, `email`, `name`, `phone`, `role`, `type`, `profileImageId`, `latitude`, `longitude`, `isActive`, `isDeleted`, `creationDate`, `isCleaner`, `isCarpenter`, `isElectrician`, `isMason`, `isPainter`, `isPlumber`, `isAcTechnical`, `rating` FROM `user` inner join workerDetails on `user`.id = workerDetails.userId where `type` = 'WORKER' AND isDeleted = 0;",namedParameters, new WorkerMapper());
    }

    public boolean assignWorker(AssignWorkerRequest assignWorkerRequest) {
        boolean isValidData = findAllOrderWorkers().stream().anyMatch(a -> Objects.equals(a.getOrderId(), assignWorkerRequest.getOrderId()) &&
                Objects.equals(a.getWorkerId(), assignWorkerRequest.getWorkerId()));
        Order order = findOne(assignWorkerRequest.getOrderId());
        List<Order> workers = findByWorkerId(assignWorkerRequest.getWorkerId());
        workers.stream().sorted((o1, o2) -> ((Long) o1.getOrderDate().getTime()).compareTo(o2.getOrderDate().getTime())).collect(Collectors.toList());
        if(!isValidData){
            jdbcTemplate.update(new PreparedStatementCreator() {

                @Override
                public PreparedStatement createPreparedStatement(Connection connection)
                        throws SQLException {
                    PreparedStatement ps = connection.prepareStatement("INSERT INTO `orderWorker` (orderId, workerId) VALUES (?, ?);");
                    ps.setString(1, String.valueOf(assignWorkerRequest.getOrderId()));
                    ps.setString(2, String.valueOf(assignWorkerRequest.getWorkerId()));
                    return ps;
                }
            });
        }
        return isValidData;
    }

    public List<Order> findByWorkerId(long id) {
        Map namedParameters = new HashMap();
        namedParameters.put("workerId", id);
        return namedJdbc.query("SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, " +
                "`longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM orderWorker " +
                "INNER JOIN `order` ON `order`.id = orderWorker.orderId WHERE orderWorker.workerId = :workerId",namedParameters, new OrderMapper());
    }


    public List<AssignWorkerRequest> findAllOrderWorkers(){
        try {
            String sql = "SELECT orderId, workerId FROM orderWorker";
            return jdbcTemplate.query(sql, new AssignWorkerRequestMapper());
        } catch (EmptyResultDataAccessException e) {
            return Collections.emptyList();
        }
    }
}
