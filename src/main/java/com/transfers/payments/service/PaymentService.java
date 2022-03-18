package com.transfers.payments.service;

import com.itextpdf.text.DocumentException;
import com.transfers.payments.entity.Payment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public interface PaymentService {

    List<Payment> findIncomeByUserId(int userId);

    Payment findPaymentById(int paymentId);

    String getPdf(int paymentId) throws IOException, DocumentException;

    Page<Payment> listIncomeByUserId(int userId, Pageable pageable);

    Page<Payment> listPaymentByUserIdDesc(int userId, Pageable pageable);

    Page<Payment> listPaymentByUserIdAsc(int userId, Pageable pageable);

    Page<Payment> findIncomePaginated(int userId, int pageNo, int pageSize, String sortField, String sortDirection);

    Page<Payment> findPaymentsPaginated(int userId, int pageNo, int pageSize, String sortField, String sortDirection);
}
