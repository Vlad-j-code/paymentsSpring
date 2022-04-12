package com.transfers.payments.controllers;

import com.itextpdf.text.DocumentException;
import com.transfers.payments.entity.Payment;
import com.transfers.payments.entity.User;
import com.transfers.payments.service.PaymentService;
import com.transfers.payments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@Controller
public class PaymentsController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private UserService userService;

    @GetMapping("/income")
    public String showIncome(Model model) {
        return findPaginatedIncome(1, "id", "desc", model);
    }

    @GetMapping("/income/{pageNo}")
    public String findPaginatedIncome(@PathVariable(value = "pageNo") int pageNo,
                                @RequestParam("sortField") String sortField,
                                @RequestParam("sortDir") String sortDir,
                                Model model) {
        int pageSize = 5;

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String login = ((UserDetails) principal).getUsername();
            User user = userService.findUserByLogin(login);
            Page<Payment> page = paymentService.findIncomePaginated(user.getUserId(), pageNo, pageSize, sortField, sortDir);
            List<Payment> listPayments = page.getContent();

            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", page.getTotalPages());
            model.addAttribute("totalItems", page.getTotalElements());

            model.addAttribute("sortField", sortField);
            model.addAttribute("sortDir", sortDir);
            model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");

            model.addAttribute("listPayments", listPayments);
        }

        return "income";
    }

    @GetMapping("/payments")
    public String showPayments(Model model) {
        return findPaginatedPayments(1, "id", "desc", model);
    }

    @GetMapping("/payments/{pageNo}")
    public String findPaginatedPayments(@PathVariable(value = "pageNo") int pageNo,
                                      @RequestParam("sortField") String sortField,
                                      @RequestParam("sortDir") String sortDir,
                                      Model model) {
        int pageSize = 5;

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String login = ((UserDetails) principal).getUsername();
            User user = userService.findUserByLogin(login);
            Page<Payment> page = paymentService.findPaymentsPaginated(user.getUserId(), pageNo, pageSize, sortField, sortDir);
            List<Payment> listPayments = page.getContent();

            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", page.getTotalPages());
            model.addAttribute("totalItems", page.getTotalElements());

            model.addAttribute("sortField", sortField);
            model.addAttribute("sortDir", sortDir);
            model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");

            model.addAttribute("payment", new Payment());
            model.addAttribute("listPayments", listPayments);
        }

        return "payments";
    }

    @GetMapping(value = "/payments",
            produces = MediaType.APPLICATION_PDF_VALUE, params = "download")
    public ResponseEntity<InputStreamResource> downloadPdf(@ModelAttribute("Id") Payment payment, final HttpServletResponse response) throws IOException, DocumentException {

        ByteArrayInputStream bis = new ByteArrayInputStream(paymentService.getPdf(payment.getId()).getBytes());

        //InputStream targetStream = new ByteArrayInputStream(paymentService.getPdf(payment.getId()).getBytes());

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=payments.pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(bis));


//        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
//        response.setHeader("Content-Disposition", "attachment; filename=payments.pdf");
//
//        StreamingResponseBody stream = out -> {
//            String fileName = null;
//            try {
//                fileName = paymentService.getPdf(payment.getId());
//            } catch (DocumentException e) {
//                e.printStackTrace();
//            }
//
//            File file = new File(fileName);
//            ServletOutputStream outputStream = null;
//            BufferedInputStream inputStream = null;
//
//                try {
//                    outputStream = response.getOutputStream();
//                    response.setContentLength((int) file.length());
//                    FileInputStream fileInputStream = new FileInputStream(file);
//                    inputStream = new BufferedInputStream(fileInputStream);
//                    int readBytes;
//                    while ((readBytes = inputStream.read()) != -1)
//                        outputStream.write(readBytes);
//                } catch (ExportException e) {
//                    e.printStackTrace();
//                } finally {
//                    outputStream.flush();
//                    outputStream.close();
//                    inputStream.close();
//                }
//
//        };
//        return new ResponseEntity(stream, HttpStatus.OK);
    }
}
