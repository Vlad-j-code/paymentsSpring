package com.transfers.payments.repository;

import com.transfers.payments.entity.Card;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CardRepository extends JpaRepository<Card, Integer> {

    @Query(value = "SELECT * FROM cards WHERE user_id = ?", nativeQuery = true)
    List<Card> findByUserId(int userId);

    @Query(value = "SELECT * FROM cards WHERE id = ?", nativeQuery = true)
    Card findById(int id);

    @Query(value = "SELECT * FROM cards WHERE number = ?", nativeQuery = true)
    Card findByNumber(long number);

    @Query(value = "SELECT * FROM cards WHERE request = 1", nativeQuery = true)
    List<Card> findByRequest(int request);

}
