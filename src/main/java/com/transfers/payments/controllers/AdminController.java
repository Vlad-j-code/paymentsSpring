package com.transfers.payments.controllers;

import com.transfers.payments.entity.Card;
import com.transfers.payments.entity.User;
import com.transfers.payments.service.CardService;
import com.transfers.payments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private CardService cardService;


    @GetMapping(value = "/activity")
    public ModelAndView adminActivity(@RequestParam(value = "page", defaultValue = "0", required = false) Integer page,
                                      @RequestParam(value = "size", defaultValue = "5", required = false) Integer size) {
        ModelAndView modelAndView = new ModelAndView();
        Page<User> users = userService.listUsers(PageRequest.of(page, size, Sort.by("login")));
        modelAndView.addObject("user", new User());
        modelAndView.addObject("users", users);
        modelAndView.addObject("maxTraySize", size);
        modelAndView.addObject("currentPage", page);
        modelAndView.setViewName("adminUserActivity");
        return modelAndView;
    }

    @PostMapping(value = "/activity", params = "block")
    public ModelAndView adminBlockUnblock(@ModelAttribute("Login") User user) {
        ModelAndView modelAndView = new ModelAndView();
        userService.blockUnblockUserByLogin(user.getLogin());
        modelAndView.addObject("message", "User activity changed");
        modelAndView.setViewName("adminUserActivity");
        return modelAndView;
    }

    @PostMapping(value = "/activity", params = "cards")
    public ModelAndView adminUserCards(@ModelAttribute("UserId") User user) {
        ModelAndView modelAndView = new ModelAndView();
        List<Card> cards = cardService.findCardByUserId(user.getUserId());
        modelAndView.addObject("card", new Card());
        modelAndView.addObject("cards", cards);
        modelAndView.setViewName("adminUserCards");
        return modelAndView;
    }

    @PostMapping(value = "/activity", params = "activity")
    public ModelAndView adminBlockUnblockCard(@ModelAttribute("Id") Card card) {
        ModelAndView modelAndView = new ModelAndView();
        cardService.blockUnblockCardById(card.getId());
        modelAndView.addObject("message", "Card activity changed");
        modelAndView.setViewName("adminUserCards");
        return modelAndView;
    }

    @GetMapping(value = "/requests")
    public ModelAndView adminRequests(Card card) {
        ModelAndView modelAndView = new ModelAndView();
        List<Card> cards = cardService.findCardsByRequest(card.getRequest());
        modelAndView.addObject("card", new Card());
        modelAndView.addObject("cards", cards);
        modelAndView.setViewName("adminRequests");
        return modelAndView;
    }

    @PostMapping(value = "/requests", params = "accept")
    public ModelAndView adminAcceptRequest(@ModelAttribute("Id") Card card) {
        ModelAndView modelAndView = new ModelAndView();
        cardService.acceptRequest(card.getId());
        modelAndView.addObject("message", "Card user unblocked");
        modelAndView.setViewName("adminRequests");
        return modelAndView;
    }

    @PostMapping(value = "/requests", params = "reject")
    public ModelAndView adminRejectRequest(@ModelAttribute("Id") Card card) {
        ModelAndView modelAndView = new ModelAndView();
        cardService.rejectRequest(card.getId());
        modelAndView.addObject("message", "Request rejected");
        modelAndView.setViewName("adminRequests");
        return modelAndView;
    }
}
