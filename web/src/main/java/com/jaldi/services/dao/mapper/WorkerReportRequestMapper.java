package com.jaldi.services.dao.mapper;

import com.jaldi.services.model.request.WorkerReportRequest;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ArtStyle on 15.07.2017.
 */
public class WorkerReportRequestMapper implements RowMapper<WorkerReportRequest> {
    @Override
    public WorkerReportRequest mapRow(ResultSet resultSet, int i) throws SQLException {
        WorkerReportRequest workerReportRequest = new WorkerReportRequest();
        workerReportRequest.setName(resultSet.getString("name"));
        workerReportRequest.setCost(resultSet.getBigDecimal("cost"));
        workerReportRequest.setHours(resultSet.getFloat("hours"));
        return workerReportRequest;
    }
}
