package com.transfers.payments.service;

import com.transfers.payments.entity.Payment;
import com.transfers.payments.entity.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PaymentServiceTest {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private UserService userService;

    @Test
    public void findIncomeList() {
        User user = userService.findUserByLogin("igorek");
        List<Payment> incomeList = paymentService.findIncomeByUserId(user.getUserId());
        Assert.assertFalse(incomeList.isEmpty());
    }

    @Test
    public void findIncomePage() {
        User user = userService.findUserByLogin("igorek");
        Page<Payment> page = paymentService.findIncomePaginated(user.getUserId(), 1, 5, "date", "desc");
        Assert.assertEquals(5, page.getNumberOfElements());
    }

    @Test
    public void findPaymentsPage() {
        User user = userService.findUserByLogin("igorek");
        Page<Payment> page = paymentService.findPaymentsPaginated(user.getUserId(), 1, 5, "balance", "asc");
        Assert.assertEquals(5, page.getNumberOfElements());
    }

}
