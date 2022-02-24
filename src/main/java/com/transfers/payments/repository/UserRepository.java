package com.transfers.payments.repository;

import com.transfers.payments.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Integer> {

    @Query(value = "SELECT * FROM users WHERE login = ?", nativeQuery = true)
    User findByLogin(String login);

    @Query(value = "select * from users where id = ?", nativeQuery = true)
    User findUserById(int userId);

    @Query(value = "UPDATE users SET active = ? WHERE login = ?", nativeQuery = true)
    void setBlock(int active, String login);
}
