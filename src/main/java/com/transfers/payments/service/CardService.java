package com.transfers.payments.service;

import com.transfers.payments.entity.Card;

import java.util.List;

public interface CardService {

    void addCard(int userId, Card card);

    void updateCard(Card card);

    void deleteCard(int cardId);

    List<Card> getAllCards();

    List<Card> findCardByUserId(int userId);

    Card findCardById(int cardId);

    Card findCardByNumber(long cardNumber);

    void replenishBalance(int value, long cardNumber);

    void sendPayment(int value, long cardNumberFrom, long cardNumberTo);

    void blockUnblockCardById(int cardId);

    List<Card> findCardsByRequest(int request);

    void acceptRequest(int cardId);

    void rejectRequest(int cardId);

    void userUnblockRequest(int cardId);

    List<Card> sortingCards(int userId, String sortField, String sortDirection);
}
