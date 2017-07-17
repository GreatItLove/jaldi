package com.jaldi.services.dao;

import com.jaldi.services.dao.mapper.WorkerReportRequestMapper;
import com.jaldi.services.model.request.WorkerReportRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;

/**
 * Created by ArtStyle on 15.07.2017.
 */
@Repository
public class ReportDaoImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<WorkerReportRequest> workersReport(String fromDate, String toDate){
        try {
            String sql = "SELECT user.name, SUM(`order`.cost) AS cost,SUM(`order`.hours) AS hours FROM orderWorker LEFT JOIN `order` ON orderWorker.orderId = `order`.id LEFT JOIN user ON orderWorker.workerId = user.id WHERE `order`.orderDate BETWEEN ? AND ? AND user.isDeleted = 0 GROUP BY orderWorker.workerId";
            return jdbcTemplate.query(
                    sql, new WorkerReportRequestMapper(), fromDate,toDate);
        }catch (EmptyResultDataAccessException e) {
            return Collections.emptyList();
        }
    }
}
