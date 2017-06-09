package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.AssignWorkerRequestMapper;
import com.jaldi.services.dao.mapper.PartialOrderResultSetExtractor;
import com.jaldi.services.dao.mapper.OrderMapper;
import com.jaldi.services.dao.mapper.WorkerMapper;
import com.jaldi.services.model.Order;
import com.jaldi.services.model.Worker;
import com.jaldi.services.model.request.AssignWorkerRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
                if (order.getLatitude() == null) {
                    ps.setNull(9, Types.DECIMAL);
                } else {
                    ps.setDouble(9, order.getLatitude());
                }
                if (order.getLongitude() == null) {
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

    public List<Order> findForUserPartial(long userId) {
        try {
            Map namedParameters = new HashMap();
            namedParameters.put("userId", userId);
            namedParameters.put("limit", 100);
            return namedJdbc.query("SELECT o.`id`, o.`type`, o.`status`, o.`workers`, o.`hours`, o.`address`, " +
                    "o.`city`, o.`country`, o.`comment`, o.`latitude`, o.`longitude`, o.`cost`, o.`paymentType`, o.`userRating`, o.`userFeedback`, o.`orderDate`, o.`userId`, o.`creationDate`, " +
                    "u.id workerId, u.email workerEmail, u.name workerName, u.phone workerPhone, u.profileImageId workerImage, u.latitude workerLatitude, u.longitude workerLongitude, wd.rating " +
                    "FROM `order` o  " +
                    "left join `orderWorker` ow on ow.orderId = o.id " +
                    "left join `user` u on ow.workerId = u.id " +
                    "left join workerDetails wd on wd.userId = ow.workerId WHERE o.userId = :userId ORDER BY o.creationDate DESC limit :limit;", namedParameters, new PartialOrderResultSetExtractor());
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

    public List<Worker> getWorkers(long orderId) {
        Map namedParameters = new HashMap();
        namedParameters.put("orderId", orderId);
        return namedJdbc.query("SELECT `id`, `email`, `name`, `phone`, `role`, `type`, `profileImageId`, `latitude`, `longitude`, `isActive`, `isDeleted`, `creationDate`, `isCleaner`, `isCarpenter`, `isElectrician`, `isMason`, `isPainter`, `isPlumber`, `isAcTechnical`, `rating` FROM `user` inner join workerDetails on `user`.id = workerDetails.userId inner join orderWorker on orderWorker.workerId = `user`.id AND orderWorker.orderId = :orderId where `type` = 'WORKER' AND isDeleted = 0;", namedParameters, new WorkerMapper());
    }

    public List<AssignWorkerRequest> getOrderWorkersByOrderId(long orderId){
        Map namedParameters = new HashMap();
        namedParameters.put("orderId", orderId);
        return namedJdbc.query("SELECT orderId, workerId FROM orderWorker WHERE orderId = :orderId", namedParameters,  new AssignWorkerRequestMapper());
    }

    @Transactional
    public boolean assignWorker(AssignWorkerRequest request) {
        Order order = findOne(request.getOrderId());
        List<AssignWorkerRequest> workersAssignOrder = getOrderWorkersByOrderId(order.getId());
        if (workersAssignOrder.size() >= order.getWorkers() ) return false;
        Date fromDate = order.getOrderDate();
        Calendar cal = Calendar.getInstance();
        cal.setTime(fromDate);
        cal.add(Calendar.MINUTE, Math.round(60 * order.getHours()));
        Date toDate = cal.getTime();
        Integer sameTimeOrders = jdbcTemplate.queryForObject("SELECT count(*) FROM `order` o inner join `orderWorker` ow " +
                "on o.id = ow.orderId where o.status != 'CANCELED' and ow.workerId = ? and o.orderDate > ? AND o.orderDate < ?;", Integer.class, request.getWorkerId(), fromDate, toDate);
        boolean created = sameTimeOrders == 0;
        if (created) {
            jdbcTemplate.update(new PreparedStatementCreator() {
                @Override
                public PreparedStatement createPreparedStatement(Connection connection)
                        throws SQLException {
                    PreparedStatement ps = connection.prepareStatement("INSERT INTO `orderWorker` (orderId, workerId) VALUES (?, ?);");
                    ps.setString(1, String.valueOf(request.getOrderId()));
                    ps.setString(2, String.valueOf(request.getWorkerId()));
                    return ps;
                }
            });
        }
        if (created) {
            updateOrderStatus(Order.Status.ASSIGNED, order.getId());
        }
        return created;
    }

    public void updateOrderStatus(Order.Status status, long orderId) {
        Map namedParameters = new HashMap();
        namedParameters.put("status", status.name());
        namedParameters.put("id", orderId);
        namedJdbc.update("update `order` set `status` = :status where `id` = :id;", namedParameters);
    }

    public List<AssignWorkerRequest> getOrderWorkersById(long orderId, long workerId) {
        Map namedParameters = new HashMap();
        namedParameters.put("orderId", orderId);
        namedParameters.put("workerId", workerId);
        return namedJdbc.query("SELECT orderId, workerId FROM orderWorker WHERE orderId = :orderId AND workerId = :workerId", namedParameters, new AssignWorkerRequestMapper());
    }


    public List<Order> getAvailableOrders(long workerId){
        String sql ="SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, `longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate`, COUNT(`order`.`id`) as qt  FROM  `order` LEFT JOIN orderWorker ON `order`.id = orderWorker.orderId WHERE (`order`.status = 'CREATED' OR `order`.status = 'ASSIGNED') GROUP BY `order`.id HAVING `order`.workers > qt";
        List<Order> list =   namedJdbc.query(sql,new OrderMapper());
        return list.stream().filter(order -> checkWorkerType(order.getType(), workerId) && (order.getStatus().equals(Order.Status.CREATED) || getOrderWorkersById(order.getId(),workerId).size()== 0)).collect(Collectors.toList());
    }

    public List<Order> getMyOrders(long workerId) {
        Map namedParameters = new HashMap();
        namedParameters.put("workerId", workerId);
        return namedJdbc.query("SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, `longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM `order` INNER JOIN orderWorker ON `order`.id = orderWorker.orderId WHERE orderWorker.workerId  = :workerId", namedParameters, new OrderMapper());
    }

    public boolean checkWorkerType(Order.Type type, long workerId) {
        Map namedParameters = new HashMap();
        namedParameters.put("workerId", workerId);
        switch (type.name()) {
            case "CLEANER":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isCleaner = 1", namedParameters, Integer.class) > 0;
            case "CARPENTER":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isCarpenter = 1", namedParameters, Integer.class) > 0;
            case "ELECTRICIAN":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isElectrician = 1", namedParameters, Integer.class) > 0;
            case "MASON":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isMason = 1", namedParameters, Integer.class) > 0;
            case "PAINTER":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isPainter = 1", namedParameters, Integer.class) > 0;
            case "PLUMBER":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isPlumber = 1", namedParameters, Integer.class) > 0;
            case "AC_TECHNICAL":
                return namedJdbc.queryForObject("SELECT count(*) FROM workerDetails WHERE userId = :workerId AND isAcTechnical = 1", namedParameters, Integer.class) > 0;
        }
        return false;
    }
}
