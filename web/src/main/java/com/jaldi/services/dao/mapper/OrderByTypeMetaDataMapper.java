package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.Order;
import com.jaldi.services.model.OrderByTypeMetaData;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/14/17
 * Time: 3:20 AM
 */
public class OrderByTypeMetaDataMapper implements RowMapper<OrderByTypeMetaData> {

    @Override
    public OrderByTypeMetaData mapRow(ResultSet rs, int i) throws SQLException {
        OrderByTypeMetaData orderByTypeMetaData = new OrderByTypeMetaData();
        orderByTypeMetaData.setType(Order.Type.valueOf(rs.getString("type")));
        orderByTypeMetaData.setCount(rs.getLong("ordersCount"));
        orderByTypeMetaData.setAmount(rs.getLong("totalAmount"));
        return orderByTypeMetaData;
    }
}
