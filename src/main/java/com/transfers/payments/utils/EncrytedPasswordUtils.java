package com.transfers.payments.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.text.DateFormat;
import java.util.Date;

public class EncrytedPasswordUtils {

    // Encryte Password with BCryptPasswordEncoder
    public static String encrytePassword(String password) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.encode(password);
    }

    public static void main(String[] args) {
        Date now = new Date();
        DateFormat time = DateFormat.getDateInstance(DateFormat.DATE_FIELD);
        DateFormat dfm = DateFormat.getTimeInstance();
        System.out.println(time.format(now) + " " + dfm.format(now));
    }

}
