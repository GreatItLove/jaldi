package com.jaldi.services.controller;

import com.jaldi.services.common.MailSenderService;
import com.jaldi.services.dao.TokenDaoImpl;
import com.jaldi.services.dao.UserDaoImpl;
import com.jaldi.services.model.Token;
import com.jaldi.services.model.User;
import com.jaldi.services.model.request.ResetPassword;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.UUID;

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
    private TokenDaoImpl tokenDao;

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

    @PostMapping("/forgot")
    public ModelAndView resetPassword(@ModelAttribute User user) {
        ModelAndView model = new ModelAndView();
        User innerUser = userDao.loadUserByUsername(user.getEmail());
        if(innerUser != null) {
            Token token = new Token();
            token.setToken(UUID.randomUUID().toString());
            token.setUserId(innerUser.getId());
            token.setType(Token.Type.RESET_PASSWORD);
            tokenDao.create(token);
            mailSender.sendResetPasswordEmail(innerUser, "reset-password/" + token.getToken());
        }
        model.addObject("msg", "We'll send you instructions for resetting your password.");
        model.setViewName("forgot");
        return model;
    }

    @GetMapping("/reset-password/{token}")
    public ModelAndView resetPassword(@PathVariable("token") String tokenStr) {
        if(tokenDao.getToken(tokenStr, Token.Type.RESET_PASSWORD) == null) {
            return new ModelAndView("redirect:/404");
        }
        ModelAndView model = new ModelAndView();
        model.addObject("token", tokenStr);
        model.setViewName("reset-password");
        return model;
    }

    @PostMapping("/reset-password")
    public ModelAndView updatePassword(@ModelAttribute ResetPassword resetPassword, HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.addObject("token", resetPassword.getToken());
        if(!resetPassword.getPassword().equals(resetPassword.getPassword2())) {
            model.addObject("doesntMatch", "Password does not match!");
        } else {
            Token token = tokenDao.getToken(resetPassword.getToken(), Token.Type.RESET_PASSWORD);
            User user = new User();
            user.setId(token.getUserId());
            user.setPassword(resetPassword.getPassword());
            userDao.updateUserPassword(user);
            tokenDao.removeToken(token.getId());
            model.addObject("successfullyChanged", "Your password has been successfully updated. You will be redirected to the login page.");
        }
        model.setViewName("reset-password");
        return model;
    }

}
