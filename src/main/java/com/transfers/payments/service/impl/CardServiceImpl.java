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

import java.text.SimpleDateFormat;
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
        payment.setCardDestinationNumber(currentCard.getNumber());
        payment.setMoney(value);
        payment.setBalance(currentCard.getMoney());
        String date = getDate();
        payment.setDate(date);
        cardRepository.save(currentCard);
        paymentRepository.save(payment);
    }

    private String getDate() {
        String pattern = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        return simpleDateFormat.format(new Date());
    }

    @Override
    public void sendPayment(int value, long cardNumberFrom, long cardNumberTo) {
        Card from = cardRepository.findByNumber(cardNumberFrom);
        Card to = cardRepository.findByNumber(cardNumberTo);
        from.setMoney(from.getMoney() - value);
        to.setMoney(to.getMoney() + value);
        Payment payment = new Payment();
        payment.setCardId(from.getId());
        payment.setCardDestinationId(to.getId());
        payment.setCardNumber(from.getNumber());
        payment.setCardDestinationNumber(to.getNumber());
        payment.setMoney(value);
        payment.setBalance(from.getMoney());
        String date = getDate();
        payment.setDate(date);
        cardRepository.save(from);
        cardRepository.save(to);
        paymentRepository.save(payment);
    }

    @Override
    public void blockUnblockCardById(int cardId) {
        Card card = cardRepository.findById(cardId);
        if (card.getActive() == 1) {
            card.setActive(0);
        } else card.setActive(1);
        cardRepository.save(card);
    }

    @Override
    public List<Card> findCardsByRequest(int request) {
        return cardRepository.findByRequest(request);
    }

    @Override
    public void acceptRequest(int cardId) {
        Card card = cardRepository.findById(cardId);
        card.setActive(1);
        card.setRequest(0);
        cardRepository.save(card);
    }

    @Override
    public void rejectRequest(int cardId) {
        Card card = cardRepository.findById(cardId);
        card.setRequest(0);
        cardRepository.save(card);
    }

    @Override
    public void userUnblockRequest(int cardId) {
        Card card = cardRepository.findById(cardId);
        card.setRequest(1);
        cardRepository.save(card);
    }
}
