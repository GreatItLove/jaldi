package com.jaldi.services.common;

import com.google.common.collect.Lists;
import com.jaldi.services.model.User;
import it.ozimov.springboot.mail.model.Email;
import it.ozimov.springboot.mail.model.defaultimpl.DefaultEmail;
import it.ozimov.springboot.mail.service.EmailService;
import it.ozimov.springboot.mail.service.exception.CannotSendEmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.mail.internet.InternetAddress;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/29/17
 * Time: 12:22 AM
 */
@Service
public class MailSenderService {

    @Value("${application.noreply.address}")
    private String noreplyAddress;

    @Value("${application.noreply.from}")
    private String noreplyFrom;

    @Autowired
    public EmailService emailService;

    public void sendWelcomeEmail(User toUser){
        try {
            final Email email = DefaultEmail.builder()
                    .from(new InternetAddress(noreplyAddress, noreplyFrom))
                    .to(Lists.newArrayList(new InternetAddress(toUser.getEmail(), toUser.getName())))
                    .subject("Registration complete")
                    .body("")
                    .encoding("UTF-8").build();
            final Map<String, Object> params = new HashMap<>();
            params.put("name", toUser.getName());
            emailService.send(email, "email/welcome.ftl", params);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (CannotSendEmailException e) {
            e.printStackTrace();
        }
    }

    public void sendResetPasswordEmail(User toUser, String url){
        try {
            final Email email = DefaultEmail.builder()
                    .from(new InternetAddress(noreplyAddress, noreplyFrom))
                    .to(Lists.newArrayList(new InternetAddress(toUser.getEmail(), toUser.getName())))
                    .subject("Password changing confirmation")
                    .body("")
                    .encoding("UTF-8").build();
            final Map<String, Object> params = new HashMap<>();
            params.put("name", toUser.getName());
            params.put("url", url);
            emailService.send(email, "email/reset_password.ftl", params);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (CannotSendEmailException e) {
            e.printStackTrace();
        }
    }
}
