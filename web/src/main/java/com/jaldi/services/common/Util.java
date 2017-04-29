package com.jaldi.services.common;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

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
}
