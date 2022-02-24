package com.transfers.payments.utils;

import java.security.SecureRandom;

public final class CardNumber {

    /**
     * Prefix for card.
     */
    private static final int head = 4049;

    /**
     * For Utility class.
     */
    private CardNumber() {
        throw new IllegalStateException("Utility class.");
    }

    /**
     * @return string with four numbers.
     */
    private static String getRandom() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            sb.append(plus());
        }
        return sb.toString();
    }

    /**
     * @return number from 0 to 9.
     */
    private static int plus() {
        return new SecureRandom().nextInt(10);
    }

    /**
     * @return get long card number by appending results last methods.
     */
    public static long createCardNumber() {
        StringBuilder sb = new StringBuilder();
        sb.append(head).append(getRandom()).append(getRandom());
        return Long.parseLong(sb.toString());
    }

}
