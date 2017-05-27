package com.jaldi.services.rest;

import com.jaldi.services.model.DashboardMetaData;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/27/17
 * Time: 6:39 PM
 */
@RestController
@RequestMapping("/rest/dashboard")
@PreAuthorize("hasAuthority('ADMIN')")
public class DashboardService {

    @GetMapping("/overview")
    public DashboardMetaData overview() {
        DashboardMetaData dashboardMetaData = new DashboardMetaData();
        Random random = new Random();
        dashboardMetaData.setUsersCount(10 + random.nextInt(100));
        dashboardMetaData.setOrdersCount(10 + random.nextInt(100));
        dashboardMetaData.setWorkersCount(11);
        dashboardMetaData.setTotalAmount(56500);
        return dashboardMetaData;
    }
}
