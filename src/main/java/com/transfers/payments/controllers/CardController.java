package com.transfers.payments.controllers;

import com.transfers.payments.entity.Card;
import com.transfers.payments.entity.User;
import com.transfers.payments.service.CardService;
import com.transfers.payments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.List;

@Controller
public class CardController {

    @Autowired
    private CardService cardService;

    @Autowired
    private UserService userService;

    @GetMapping(value = "/cards")
    public ModelAndView userCards() {
        ModelAndView modelAndView = new ModelAndView();
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String login = ((UserDetails) principal).getUsername();
            User user = userService.findUserByLogin(login);
            List<Card> cards = cardService.findCardByUserId(user.getUserId());
            modelAndView.addObject("cards", cards);
        }
        modelAndView.setViewName("userCards");
        return modelAndView;
    }

    @GetMapping("/refill")
    public ModelAndView refillPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("refill");
        return modelAndView;
    }

    @PostMapping("/refill")
    public ModelAndView refill(int value, long numberCard) {
        ModelAndView modelAndView = new ModelAndView();
        cardService.replenishBalance(value, numberCard);
        modelAndView.addObject("message", "Balance replenishment completed successfully");
        modelAndView.setViewName("refill");
        return modelAndView;
    }

    @GetMapping("/transfer")
    public ModelAndView transferPage() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("transfer");
        return modelAndView;
    }

    @PostMapping("/transfer")
    public ModelAndView transfer(int value, long numberCardFrom, long numberCardTo) {
        ModelAndView modelAndView = new ModelAndView();

        Card from = cardService.findCardByNumber(numberCardFrom);
        Card to = cardService.findCardByNumber(numberCardTo);

        cardService.sendPayment(value, from, to);
        modelAndView.addObject("message", "Money transfer completed successfully");
        modelAndView.setViewName("transfer");
        return modelAndView;
    }

    @GetMapping("/createCard")
    public String creditCardPage(Model model) {
        Card card = new Card();

        model.addAttribute("card", card);

        return "createCard";
    }

    @PostMapping("/createCard")
    public String createCard(@Valid @ModelAttribute("card") Card card, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "createCard";
        } else {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (principal instanceof UserDetails) {
                String login = ((UserDetails) principal).getUsername();
                User user = userService.findUserByLogin(login);
                cardService.addCard(user.getUserId(), card);
                model.addAttribute("message", "Card created successfully");
            }
        }
        return "createCard";
    }

//    private void userDataCards(Model model) {
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        if (principal instanceof UserDetails) {
//            String login = ((UserDetails) principal).getUsername();
//            User user = userService.findUserByLogin(login);
//            List<Card> cards = cardService.findCardByUserId(user.getUserId());
//            model.addAttribute("cards", cards);
//        }
//    }
}
