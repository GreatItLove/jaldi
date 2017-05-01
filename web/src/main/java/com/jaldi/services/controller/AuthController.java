package com.jaldi.services.controller;

import com.jaldi.services.dao.UserDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/28/17
 * Time: 2:17 PM
 */
@Controller
public class AuthController {

    @Autowired
    private UserDaoImpl userDao;

    @Autowired
    private MessageSource messageSource;

    @GetMapping("/login")
    public ModelAndView login(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            @RequestParam(value = "ref", required = false) String refUrl,
            javax.servlet.http.HttpServletRequest request) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "The username or password you entered is incorrect");
        }

        if (logout != null) {
            model.addObject("msg", "You have successfully logged out.");
        }
        model.setViewName("login");
        return model;

    }

    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }

    @GetMapping("/forgot")
    public String forgot() {
        return "forgot";
    }

}
