package com.jaldi.services.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class MainController {


    @GetMapping("/")
    public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView model = new ModelAndView();
        model.setViewName("landing-new");
        return model;
    }

    @GetMapping("/landing")
    public ModelAndView landing(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView model = new ModelAndView();
        model.setViewName("landing-new");
        return model;
    }

    @GetMapping("/portal")
    public String portal() {
        return "main";
    }

    @GetMapping("/404")
    public String pageNotFound() {
        return "error/404";
    }

    @GetMapping("/500")
    public String internalServerError() {
        return "error/500";
    }
}
