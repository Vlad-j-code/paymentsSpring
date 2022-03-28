package com.transfers.payments.db;

import com.transfers.payments.entity.User;
import com.transfers.payments.repository.UserRepository;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Rollback(false)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UserRepositoryTests {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private UserRepository repo;

    @Test
    @Order(1)
    public void testCreateUser() {
        User user = new User();
        user.setLogin("petr");
        user.setPassword("12345");

        User savedUser = repo.save(user);

        User existUser = entityManager.find(User.class, savedUser.getUserId());

        assertThat(user.getLogin()).isEqualTo(existUser.getLogin());

    }

    @Test
    @Order(2)
    public void findUserById() {
        int userId = 29;
        User user = repo.findUserById(userId);
        assertThat(user.getUserId()).isEqualTo(userId);
    }

    @Test
    @Order(3)
    public void findUserByLogin() {
        String login = "petr";
        User user = repo.findByLogin(login);
        assertThat(user.getLogin()).isEqualTo(login);
    }

    @Test
    @Order(4)
    public void updateUser() {
        String login = "petr";
        String newPassword = "54321";
        User user = repo.findByLogin(login);
        user.setPassword(newPassword);
        User savedUser = repo.save(user);
        User existUser = entityManager.find(User.class, savedUser.getUserId());
        assertThat(newPassword).isEqualTo(existUser.getPassword());
    }

    @Test
    @Order(5)
    public void deleteUser() {
        String login = "petr";
        User user = repo.findByLogin(login);
        if (user != null) {
            repo.delete(user);
        }
        User deleted = repo.findByLogin(login);
        assertNull(deleted);
    }
}