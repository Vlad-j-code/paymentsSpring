package com.transfers.payments.service;

import com.transfers.payments.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserService {

    void addUser(User user);

    void updateUser(User user);

    void deleteUser(int userId);

    User findUser(int userId);

    List<User> getAllUsers();

    User findUserByLogin(String login);

    void blockUnblockUserByLogin(String login);

    Page<User> listUsers(Pageable pageable);
}
