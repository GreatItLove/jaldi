package com.jaldi.services.rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("/rest/mobile/")
public class MobileService {


    @GetMapping("/date")
    public Date findOne() {
        return new Date();
    }
}
