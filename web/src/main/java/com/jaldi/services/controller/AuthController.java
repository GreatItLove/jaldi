package com.jaldi.services.controller;

import com.jaldi.services.common.MailSenderService;
import com.jaldi.services.dao.UserDaoImpl;
import com.jaldi.services.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
    private MailSenderService mailSender;

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

    @PostMapping("/signup")
    public ModelAndView signup(@ModelAttribute User user) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("signup");
        modelAndView.addObject("user", user);
        boolean emailExists = userDao.checkEmail(user.getEmail());
        if(emailExists) {
            modelAndView.addObject("emailExist", "User with specified email already exists.");
        }
        if(!emailExists) {
            user.setType(User.Type.CUSTOMER);
            user.setRole(User.Role.USER);
            user.setActive(true);
            user.setPhone(user.getPhone().replaceAll("[^0-9]",""));
            userDao.create(user);
            mailSender.sendWelcomeEmail(user);
            modelAndView.addObject("createdSuccessfully", "Registration complete. You will be redirected to the login page.");
        }
        return modelAndView;
    }

    @GetMapping("/forgot")
    public String forgot() {
        return "forgot";
    }

}
