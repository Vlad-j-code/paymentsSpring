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
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Stream;

@Controller
public class CardController {

    @Autowired
    private CardService cardService;

    @Autowired
    private UserService userService;

    @GetMapping("/cards")
    public ModelAndView showCards(ModelAndView modelAndView) {
        return sortCards(1, "number", "asc", modelAndView);
    }

    @GetMapping(value = "/cards/{pageNo}")
    public ModelAndView sortCards(@PathVariable(value = "pageNo") int pageNo,
                                  @RequestParam("sortField") String sortField,
                                  @RequestParam("sortDir") String sortDir,
                                  ModelAndView modelAndView) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String login = ((UserDetails) principal).getUsername();
            User user = userService.findUserByLogin(login);
            List<Card> cards = cardService.sortingCards(user.getUserId(), sortField, sortDir);
            modelAndView.addObject("card", new Card());
            modelAndView.addObject("cards", cards);

            modelAndView.addObject("currentPage", pageNo);

            modelAndView.addObject("sortField", sortField);
            modelAndView.addObject("sortDir", sortDir);
            modelAndView.addObject("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");
        }
        modelAndView.setViewName("userCards");
        return modelAndView;
    }

    @PostMapping(value = "/cards", params = "activity")
    public ModelAndView userBlockCard(@ModelAttribute("Id") Card card) {
        ModelAndView modelAndView = new ModelAndView();
        cardService.blockUnblockCardById(card.getId());
        modelAndView.addObject("message", "Card blocked");
        modelAndView.setViewName("userCards");
        return modelAndView;
    }

    @PostMapping(value = "/cards", params = "unblock")
    public ModelAndView userRequestUnblockCard(@ModelAttribute("Id") Card card) {
        ModelAndView modelAndView = new ModelAndView();
        cardService.userUnblockRequest(card.getId());
        modelAndView.addObject("message", "Request has been sent");
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
        Card card = cardService.findCardByNumber(numberCard);

        if (card == null) {
            modelAndView.addObject("warning", "Card does not exist");
        }
        Optional.ofNullable(card).filter(f -> card.getActive() == 0)
                .ifPresent(mv -> modelAndView.addObject("warning", "Card was blocked!"));
        Optional.of(modelAndView).filter(v -> value <= 0).ifPresent(mv ->
                mv.addObject("warning", "Sum cannot be negative or equal to zero"));

        if (card != null && value > 0 && card.getActive() == 1) {
            cardService.replenishBalance(value, numberCard);
            modelAndView.addObject("message", "Balance replenishment completed successfully");
        }
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

        if (from == null || to == null) {
            modelAndView.addObject("warning", "Card does not exist");
        }
        Optional.ofNullable(from).filter(f -> from.getActive() == 0)
                .ifPresent(mv -> modelAndView.addObject("warning", "Your card was blocked!"));
        Optional.ofNullable(to).filter(t -> to.getActive() == 0).ifPresent(mv ->
                modelAndView.addObject("warning", "Destination card was blocked!"));
        Optional.of(modelAndView).filter(v -> value <= 0).ifPresent(mv ->
                mv.addObject("warning", "Sum cannot be negative or equal to zero"));
        Optional.ofNullable(from).filter(f -> from.getMoney() < value)
                .ifPresent(mv -> modelAndView.addObject("warning", "Sum higher then money"));

        if (from != null && to != null && value > 0 && from.getMoney() > value
                && from.getActive() == 1 && to.getActive() == 1) {
            cardService.sendPayment(value, from.getNumber(), to.getNumber());
            modelAndView.addObject("message", "Money transfer completed successfully");
        }
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

}
