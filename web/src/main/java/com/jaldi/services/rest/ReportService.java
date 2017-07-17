package com.jaldi.services.rest;

import com.jaldi.services.dao.ReportDaoImpl;
import com.jaldi.services.model.request.WorkerReportRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

/**
 * Created by ArtStyle on 15.07.2017.
 */
@RestController
@RequestMapping("/rest/report")
public class ReportService {

    @Autowired
    private ReportDaoImpl reportDao;

    @RequestMapping(value="/workersReport", method= RequestMethod.GET)
    public  List<WorkerReportRequest> workersReport(@RequestParam("fromDate") String fromDateStr,
                                                    @RequestParam("toDate") String toDateStr) {

        List<WorkerReportRequest> workerReportRequestList = reportDao.workersReport(fromDateStr, toDateStr);
        return workerReportRequestList;
    }
}
