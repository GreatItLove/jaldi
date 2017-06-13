package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.DashboardMetaDataMapper;
import com.jaldi.services.dao.mapper.OrderByTypeMetaDataMapper;
import com.jaldi.services.model.DashboardMetaData;
import com.jaldi.services.model.OrderByTypeMetaData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/14/17
 * Time: 2:30 AM
 */

@Repository
public class DashboardDaoImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public DashboardMetaData getMetaData() {
        return jdbcTemplate.queryForObject("SELECT (SELECT count(id) FROM jaldi.user WHERE `type` = 'CUSTOMER') customersCount, (SELECT count(id) FROM jaldi.`order`) ordersCount, " +
                "(SELECT sum(cost) FROM jaldi.`order`) totalAmount, (SELECT count(id) FROM jaldi.user WHERE `type` = 'WORKER') workersCount;", new DashboardMetaDataMapper());
    }

    public List<OrderByTypeMetaData> orderByCategory() {
        try {
            return jdbcTemplate.query("SELECT `type`, count(id) AS ordersCount, sum(cost) totalAmount FROM `order` GROUP BY `type` ORDER BY ordersCount DESC;", new OrderByTypeMetaDataMapper());
        } catch (DataAccessException e) {
            return Collections.emptyList();
        }
    }
}
