package com.transfers.payments.service;

import com.transfers.payments.entity.Card;

import java.util.List;

public interface CardService {

    void addCard(int userId, Card card);

    void updateCard(Card card);

    void deleteCard(int cardId);

    Card findCard(int cardId);

    List<Card> getAllCards();

    List<Card> findCardByUserId(int userId);

    Card findCardById(int cardId);

    Card findCardByNumber(long cardNumber);

    void replenishBalance(int value, long cardNumber);

    void withdraw(int value, long cardNumber);

    void sendPayment(int value, Card from, Card to);
}
