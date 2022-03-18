package com.transfers.payments.repository;

import com.transfers.payments.entity.Payment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ?) order by date desc", nativeQuery = true)
    List<Payment> findIncByUserId(int userId);

    @Query(value = "SELECT * FROM payments WHERE id = ?", nativeQuery = true)
    Payment findById(int id);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ?) order by date desc", nativeQuery = true)
    Page<Payment> pageIncByUserIdDescDate(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ?) order by date asc", nativeQuery = true)
    Page<Payment> pageIncByUserIdAscDate(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ?) order by id desc", nativeQuery = true)
    Page<Payment> pageIncByUserIdDescId(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ?) order by id asc", nativeQuery = true)
    Page<Payment> pageIncByUserIdAscId(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ? and card_id != 0) order by id desc", nativeQuery = true)
    Page<Payment> pagePayByUserIdDescId(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ? and card_id != 0) order by id asc", nativeQuery = true)
    Page<Payment> pagePayByUserIdAscId(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ? and card_id != 0) order by balance desc", nativeQuery = true)
    Page<Payment> pagePayByUserIdDescBalance(int userId, Pageable pageable);

    @Query(value = "select * from payments where card_destination_id in (SELECT id from cards where user_id = ? and card_id != 0) order by balance asc", nativeQuery = true)
    Page<Payment> pagePayByUserIdAscBalance(int userId, Pageable pageable);
}
