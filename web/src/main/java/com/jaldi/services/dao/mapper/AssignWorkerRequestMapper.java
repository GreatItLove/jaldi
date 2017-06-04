package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.request.AssignWorkerRequest;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ArtStyle on 04.06.2017.
 */
public class AssignWorkerRequestMapper implements RowMapper<AssignWorkerRequest> {
    @Override
    public AssignWorkerRequest mapRow(ResultSet resultSet, int i) throws SQLException {
        AssignWorkerRequest assignWorkerRequest = new AssignWorkerRequest();
        assignWorkerRequest.setOrderId(resultSet.getLong("orderId"));
        assignWorkerRequest.setWorkerId(resultSet.getLong("workerId"));
        return assignWorkerRequest;
    }
}
