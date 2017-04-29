package com.jaldi.services.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/31/17
 * Time: 1:30 PM
 */
@RestController
public class HeartbeatController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/heartbeat")
    public Date getDbTime() {
        return jdbcTemplate.queryForObject("select current_timestamp()", Date.class);
    }
}
