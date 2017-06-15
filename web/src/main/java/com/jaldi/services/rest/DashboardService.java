package com.jaldi.services.rest;

import com.jaldi.services.dao.DashboardDaoImpl;
import com.jaldi.services.model.DashboardMetaData;
import com.jaldi.services.model.OrderByTypeMetaData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/27/17
 * Time: 6:39 PM
 */
@RestController
@RequestMapping("/rest/dashboard")
@PreAuthorize("hasAuthority('ADMIN')")
public class DashboardService {

    @Autowired
    private DashboardDaoImpl dashboardDao;

    @GetMapping("/overview")
    public DashboardMetaData overview() {
        return dashboardDao.getMetaData();
    }

    @GetMapping("/orderByCategory")
    public List<OrderByTypeMetaData> orderByCategory() {
        return dashboardDao.orderByCategory();
    }
}
