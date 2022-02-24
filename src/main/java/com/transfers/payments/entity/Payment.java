package com.transfers.payments.entity;

import javax.persistence.*;

@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name = "card_id")
    private int cardId;

    @Column(name = "card_destination_id")
    private int cardDestinationId;

    @Column(name = "money")
    private int money;

    @Column(name = "balance")
    private int balance;

    @Column(name = "date")
    private String date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public int getCardDestinationId() {
        return cardDestinationId;
    }

    public void setCardDestinationId(int cardDestinationId) {
        this.cardDestinationId = cardDestinationId;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }

    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
