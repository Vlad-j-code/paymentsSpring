package com.transfers.payments.service.impl;

import com.transfers.payments.entity.Card;
import com.transfers.payments.entity.Payment;
import com.transfers.payments.repository.CardRepository;
import com.transfers.payments.repository.PaymentRepository;
import com.transfers.payments.service.CardService;
import com.transfers.payments.utils.CardNumber;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class CardServiceImpl implements CardService {

    @Autowired
    private CardRepository cardRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Override
    public void addCard(int userId, Card card) {
        card.setUserId(userId);
        card.setName(card.getName());
        card.setNumber(CardNumber.createCardNumber());
        cardRepository.save(card);
    }

    @Override
    public void updateCard(Card card) {
        cardRepository.save(card);
    }

    @Override
    public void deleteCard(int cardId) {

    }

    @Override
    public Card findCard(int cardId) {
        return null;
    }

    @Override
    public List<Card> getAllCards() {
        return cardRepository.findAll();
    }

    @Override
    public List<Card> findCardByUserId(int userId) {
        return cardRepository.findByUserId(userId);
    }

    @Override
    public Card findCardById(int cardId) {
        return cardRepository.findById(cardId);
    }

    @Override
    public Card findCardByNumber(long cardNumber) {
        return cardRepository.findByNumber(cardNumber);
    }

    @Override
    public void replenishBalance(int value, long cardNumber) {
        Card currentCard = cardRepository.findByNumber(cardNumber);
        currentCard.setMoney(currentCard.getMoney() + value);
        Payment payment = new Payment();
        payment.setCardDestinationId(currentCard.getId());
        payment.setMoney(value);
        payment.setBalance(currentCard.getMoney());
        Date now = new Date();
        DateFormat date = DateFormat.getDateInstance(DateFormat.DATE_FIELD);
        DateFormat time = DateFormat.getTimeInstance();
        payment.setDate(date.format(now) + " " + time.format(now));
        cardRepository.save(currentCard);
        paymentRepository.save(payment);
    }

    @Override
    public void withdraw(int value, long cardNumber) {
        Card currentCard = cardRepository.findByNumber(cardNumber);
        currentCard.setMoney(currentCard.getMoney() - value);
        cardRepository.save(currentCard);
    }

    @Override
    public void sendPayment(int value, Card from, Card to) {
        withdraw(value, from.getNumber());
        replenishBalance(value, to.getNumber());
    }

//    @Override
//    public void sendPayment(int value, long cardNumberFrom, long cardNumberTo) {
//        Card from = cardRepository.findByNumber(cardNumberFrom);
//        from.setMoney(from.getMoney() - value);
//        cardRepository.save(from);
//        Card to = cardRepository.findByNumber(cardNumberTo);
//        to.setMoney(from.getMoney() + value);
//        cardRepository.save(to);
//    }
}
