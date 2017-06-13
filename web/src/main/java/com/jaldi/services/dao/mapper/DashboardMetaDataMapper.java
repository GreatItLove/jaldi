package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.DashboardMetaData;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 6/14/17
 * Time: 2:45 AM
 */
public class DashboardMetaDataMapper implements RowMapper<DashboardMetaData> {

    @Override
    public DashboardMetaData mapRow(ResultSet rs, int i) throws SQLException {
        DashboardMetaData dashboardMetaData = new DashboardMetaData();
        dashboardMetaData.setUsersCount(rs.getLong("customersCount"));
        dashboardMetaData.setOrdersCount(rs.getLong("ordersCount"));
        dashboardMetaData.setTotalAmount(rs.getDouble("totalAmount"));
        dashboardMetaData.setWorkersCount(rs.getLong("workersCount"));
        return dashboardMetaData;
    }
}
