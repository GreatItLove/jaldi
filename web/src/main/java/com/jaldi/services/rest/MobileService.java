package com.jaldi.services.rest;

import com.jaldi.services.common.MailSenderService;
import com.jaldi.services.common.MessageService;
import com.jaldi.services.common.security.CustomAuthenticationToken;
import com.jaldi.services.dao.TokenDaoImpl;
import com.jaldi.services.dao.UserDaoImpl;
import com.jaldi.services.dao.VerificationDao;
import com.jaldi.services.model.Token;
import com.jaldi.services.model.User;
import com.jaldi.services.model.Verification;
import com.jaldi.services.model.request.MobileCreateUserRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.Random;

@RestController
@RequestMapping("/rest/mobile/")
public class MobileService {


    @Autowired
    private VerificationDao verificationDao;

    @Autowired
    private MessageService messageService;

    @Autowired
    private UserDaoImpl userDao;

    @Autowired
    private TokenDaoImpl tokenDao;

    @Autowired
    private MailSenderService mailSender;

    @GetMapping("/date")
    public Date date() {
        return new Date();
    }

    @PostMapping("/sendVerification")
    public ResponseEntity verifyPhoneNumber(@RequestBody Verification verification) {
        if(StringUtils.isEmpty(verification.getRecipient())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
        Random random = new Random();
        String code = String.format("%04d", random.nextInt(10000));
        verification.setCode(code);
        verification = verificationDao.create(verification);
        messageService.sendVerificationSms(verification.getRecipient(), verification.getCode());
        return ResponseEntity.ok(verification);
    }

    @PostMapping("/register")
    public ResponseEntity register(@RequestBody MobileCreateUserRequest request) {
        Verification verification = verificationDao.getById(request.getVerificationId());
        User user = request.getUser();
        if(verification == null || !verification.getCode().equals(request.getVerificationCode())
                || user == null || !user.getPhone().equals(verification.getRecipient())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
        boolean emailExists = userDao.checkEmail(user.getEmail());
        if(emailExists) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
        user.setType(User.Type.CUSTOMER);
        user.setRole(User.Role.USER);
        user.setActive(true);
        user.setPhone(user.getPhone().replaceAll("[^0-9]",""));
        user = userDao.create(user);
        mailSender.sendWelcomeEmail(user);
        return ResponseEntity.ok(user);
    }

    @PutMapping("/updateDeviceToken")
    @PreAuthorize("isAuthenticated()")
    public void create(@RequestBody Token deviceToken) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        deviceToken.setUserId(currentUser.getId());
        tokenDao.update(deviceToken);
    }
}
