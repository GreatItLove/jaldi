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
            return namedJdbc.query("SELECT o.`id`, o.`type`, o.`status`, o.`workers`, o.`hours`, o.`address`, o.`city`, o.`country`, o.`comment`, o.`latitude`, " +
                    "o.`longitude`, o.`cost`, o.`paymentType`, o.`userRating`, o.`userFeedback`, o.`orderDate`, o.`userId`, u.phone userPhone, o.`creationDate` FROM `order` o left join user u on o.userId = u.id WHERE (:type is null OR o.`type` = :type) AND (:status is null OR o.`status` = :status);", namedParameters, new OrderMapper());
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

    public Order update(Order order) {
        Map namedParameters = new HashMap();
        namedParameters.put("id", order.getId());
        namedParameters.put("address", order.getAddress());
        namedParameters.put("comment", order.getComment());
        namedParameters.put("cost", order.getCost());
        namedParameters.put("workers", order.getWorkers());
        namedParameters.put("hours", order.getHours());
        namedParameters.put("type", order.getType().name());
        namedParameters.put("orderDate", order.getOrderDate());
        namedJdbc.update("update `order` set `address` = :address, comment = :comment, cost = :cost, " +
                "workers = :workers, hours = :hours, `type` = :type, orderDate = :orderDate " +
                "where `id` = :id;", namedParameters);
        return order;
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


    public List<Order> getFreeOrders(Worker worker){
        String sql ="SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, " +
                "`longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate`, " +
                "(select count(workerId) from orderWorker where orderId = id) workersCount FROM `order` WHERE (`order`.status = 'CREATED' OR `order`.status = 'ASSIGNED') AND id not in (select orderId from orderWorker where workerId = :workerId) and `type` IN (:types) HAVING workersCount < workers ORDER BY orderDate ASC;";
        Map namedParameters = new HashMap();
        namedParameters.put("workerId", worker.getUser().getId());
        namedParameters.put("types", getkWorkerOrderTypes(worker));
        return namedJdbc.query(sql, namedParameters, new OrderMapper());
    }

    public List<Order> getWorkerOrders(long workerId) {
        Map namedParameters = new HashMap();
        namedParameters.put("workerId", workerId);
        return namedJdbc.query("SELECT * FROM (SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, `longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM `order` " +
                "INNER JOIN orderWorker ON `order`.id = orderWorker.orderId WHERE orderWorker.workerId  = :workerId AND status NOT IN ('FINISHED', 'CANCELED')  ORDER BY orderDate ASC) AS a " +
                "UNION " +
                "SELECT * FROM (SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, `latitude`, `longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate` FROM `order` " +
                "INNER JOIN orderWorker ON `order`.id = orderWorker.orderId WHERE orderWorker.workerId  = :workerId AND status IN ('FINISHED', 'CANCELED') ORDER BY orderDate DESC) AS b;", namedParameters, new OrderMapper());
    }

    public Set<String> getkWorkerOrderTypes(Worker worker) {
        Set<String> types = new HashSet<>();
        if(worker.isCleaner()) types.add(Order.Type.CLEANER.name());
        if(worker.isElectrician()) types.add(Order.Type.ELECTRICIAN.name());
        if(worker.isPainter()) types.add(Order.Type.PAINTER.name());
        if(worker.isCarpenter()) types.add(Order.Type.CARPENTER.name());
        if(worker.isPlumber()) types.add(Order.Type.PLUMBER.name());
        if(worker.isMason()) types.add(Order.Type.MASON.name());
        if(worker.isAcTechnical()) types.add(Order.Type.AC_TECHNICAL.name());
        return types;
    }

    public void removeWorkerFromOrder(long workerId, long orderId) {
        Map namedParameters = new HashMap();
        namedParameters.put("workerId", workerId);
        namedParameters.put("orderId", orderId);
        namedJdbc.update("DELETE from orderWorker WHERE workerId = :workerId AND orderId = :orderId;", namedParameters);
    }

    public void addWorker(long workerId, long orderId) {
        jdbcTemplate.update("INSERT INTO `orderWorker` (`orderId`, `workerId`) VALUES (?, ?);", orderId, workerId);
    }

    public List<Order> finishedWorksWithRating(long workerId) {
        try {
            Map namedParameters = new HashMap();
            namedParameters.put("workerId", workerId);
            return namedJdbc.query("SELECT `id`, `type`, `status`, `workers`, `hours`, `address`, `city`, `country`, `comment`, " +
                    "`latitude`, `longitude`, `cost`, `paymentType`, `userRating`, `userFeedback`, `orderDate`, `userId`, `creationDate`" +
                    " FROM orderWorker INNER JOIN `order` ON orderWorker.orderId = `order`.id WHERE orderWorker.workerId = :workerId AND `order`.status = 'FINISHED' AND `order`.userRating IS NOT NULL", namedParameters, new OrderMapper());
        } catch (DataAccessException e) {
            return Collections.emptyList();
        }
    }
}
