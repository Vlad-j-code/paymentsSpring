package com.transfers.payments.service;

import com.transfers.payments.entity.User;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @Before
    public void addUser() {
        User user = new User();
        user.setLogin("vasyl");
        user.setPassword("12345");
        userService.addUser(user);
    }

    @Test
    public void findUserByLogin() {
        User user = userService.findUserByLogin("vasyl");
        Assert.assertNotNull(user);
    }

    @Test
    public void findAllUsers() {
        List<User> users = userService.getAllUsers();
        Assert.assertFalse(users.isEmpty());
    }

    @Test
    public void blockUser() {
        String login = "vasyl";
        userService.blockUnblockUserByLogin(login);
        User user = userService.findUserByLogin(login);
        Assert.assertEquals(0, user.getActive());
    }

    @After
    public void deleteUser() {
        User user = userService.findUserByLogin("vasyl");
        userService.deleteUser(user.getUserId());
    }

}
