package com.transfers.payments.service;

import com.transfers.payments.entity.Card;
import com.transfers.payments.entity.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CardServiceTest {

    @Autowired
    private CardService cardService;

    @Autowired
    private UserService userService;

    final static long cardForm2 = 404921749251L;
    final static long cardForm3 = 404974853588L;

    @Test
    public void findCardByNumber() {
        Card form2 = cardService.findCardByNumber(cardForm2);
        Assert.assertNotNull(form2);
    }

    @Test
    public void findCardsByUserId() {
        User user = userService.findUserByLogin("igorek");
        List<Card> cards = cardService.findCardByUserId(user.getUserId());
        Assert.assertFalse(cards.isEmpty());
    }

    @Test
    public void replenishBalance() {
        int value = 500;
        Card prev = cardService.findCardByNumber(cardForm2);
        cardService.replenishBalance(value, cardForm2);
        Card after = cardService.findCardByNumber(cardForm2);
        Assert.assertEquals((prev.getMoney() + value), after.getMoney());
    }

    @Test
    public void sendPayment() {
        int value = 200;
        Card prev1 = cardService.findCardByNumber(cardForm2);
        Card prev2 = cardService.findCardByNumber(cardForm3);
        cardService.sendPayment(value, cardForm2, cardForm3);
        Card after1 = cardService.findCardByNumber(cardForm2);
        Card after2 = cardService.findCardByNumber(cardForm3);
        Assert.assertEquals((prev1.getMoney() - value), after1.getMoney());
        Assert.assertEquals((prev2.getMoney() + value), after2.getMoney());
    }

    @Test
    public void blockAndUnblockCard() {
        Card prev = cardService.findCardByNumber(cardForm2);
        cardService.blockUnblockCardById(prev.getId());
        Card after = cardService.findCardByNumber(cardForm2);
        cardService.blockUnblockCardById(after.getId());
        if (prev.getActive() == 1) {
            Assert.assertEquals(0, after.getActive());
        } else Assert.assertEquals(1, after.getActive());
    }


}
