package com.transfers.payments.service.impl;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.CMYKColor;
import com.itextpdf.text.pdf.PdfWriter;
import com.transfers.payments.entity.Payment;
import com.transfers.payments.repository.PaymentRepository;
import com.transfers.payments.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Override
    public List<Payment> findIncomeByUserId(int userId) {
        return paymentRepository.findIncByUserId(userId);
    }

    @Override
    public Payment findPaymentById(int paymentId) {
        return paymentRepository.findById(paymentId);
    }

    @Override
    public String getPdf(int paymentId) throws IOException, DocumentException {
        Document document = new Document(PageSize.A4, 50, 50, 50, 50);

        Payment payment = paymentRepository.findById(paymentId);

        String pdfPaymentId = "Id of your payment - " + payment.getId();
        String pdfCardNumber = "Number of your card with which payment was made - " + payment.getCardNumber();
        String pdfCardDestinationNumber = "Beneficiary card number - " + payment.getCardDestinationNumber();
        String pdfDate = "Date of your payment - " + payment.getDate();
        String pdfMoney = "Sum of your payment - " + payment.getMoney() + " UAH";
        String pdfBalance = "Balance of your card after sending payment - " + payment.getBalance();

        String filename = "reportPayment" + paymentId + ".pdf";
        // Listing 2. Creation of PdfWriter object
        PdfWriter writer = PdfWriter.getInstance(document,
                new FileOutputStream(filename));

        document.open();

        document.add(new Paragraph("MONEY TRANSFER",
                FontFactory.getFont(FontFactory.TIMES_ROMAN, 30, Font.BOLD,
                        new CMYKColor(0, 255, 0, 0))));
        Image image2 = Image.getInstance("E:\\JavaAndTesting\\JavaCodeVariants\\payments\\src\\main\\webapp\\img\\money.png");
        image2.scaleAbsolute(120f, 120f);
        document.add(image2);
        Anchor anchorTarget = new Anchor("Your successfully send payment!\n");
        anchorTarget.setName("BackToTop");
        Paragraph paragraph1 = new Paragraph();
        paragraph1.setSpacingBefore(50);
        paragraph1.add(anchorTarget);
        document.add(paragraph1);
        document.add(new Paragraph("Date of forming report: " + new Date().toString()));
        document.add(new Paragraph(pdfPaymentId));
        document.add(new Paragraph(pdfCardNumber));
        document.add(new Paragraph(pdfCardDestinationNumber));
        document.add(new Paragraph(pdfDate));
        document.add(new Paragraph(pdfMoney));
        document.add(new Paragraph(pdfBalance));
        document.add(new Paragraph("Thank you for choosing us."));
        document.close();
        return filename;
    }

    @Override
    public Page<Payment> listIncomeByUserId(int userId, Pageable pageable) {
        return paymentRepository.pageIncByUserId(userId, pageable);
    }

    @Override
    public Page<Payment> listPaymentByUserId(int userId, Pageable pageable) {
        return paymentRepository.pagePayByUserId(userId, pageable);
    }
}
