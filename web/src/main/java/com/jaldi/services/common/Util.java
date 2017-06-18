package com.jaldi.services.common;

import com.jaldi.services.common.security.CustomAuthenticationToken;
import com.jaldi.services.model.Worker;
import org.springframework.security.core.GrantedAuthority;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import java.util.Collection;
import java.util.List;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 3/27/17
 * Time: 4:48 PM
 */
public class Util {

    public static boolean isValidEmailAddress(String email) {
        boolean result = true;
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
        } catch (AddressException ex) {
            result = false;
        }
        return result;
    }

    public static boolean isAdmin(CustomAuthenticationToken token) {
        Collection<GrantedAuthority> authorities = token.getAuthorities();
        for (GrantedAuthority authority : authorities) {
            if(authority.getAuthority().equals(Constants.ADMIN_PERMISSION_NAME)) {
                return true;
            }
        }
        return false;
    }

    public static boolean isOperator(CustomAuthenticationToken token) {
        Collection<GrantedAuthority> authorities = token.getAuthorities();
        for (GrantedAuthority authority : authorities) {
            if(authority.getAuthority().equals(Constants.OPERATOR_PERMISSION_NAME)) {
                return true;
            }
        }
        return false;
    }

    public static String formatPhone(String phone) {
        if(phone == null) return null;
        return "+" + phone.replaceAll("[^0-9]","");
    }

    public static boolean containsWorker(List<Worker> workers, long workerId) {
        for (Worker worker : workers) {
            if(worker.getUser().getId() == workerId) {
                return true;
            }
        }
        return false;
    }
}
