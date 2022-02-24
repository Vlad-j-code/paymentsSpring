package com.transfers.payments.controllers;

import com.transfers.payments.entity.User;
import com.transfers.payments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private UserService userService;


    @GetMapping(value = "/admin")
    public ModelAndView adminPage() {
        ModelAndView modelAndView = new ModelAndView();
//        User loginedUser = (User) ((Authentication) principal).getPrincipal();
//
//        String userInfo = WebUtils.toString(loginedUser);
//        model.addAttribute("userInfo", userInfo);

        List<User> users = userService.getAllUsers();
        modelAndView.addObject("user", new User());
        modelAndView.addObject("users", users);
        modelAndView.setViewName("adminPage");
        return modelAndView;
    }

    @PostMapping(value = "/admin")
    public ModelAndView adminBlockUnblock(@ModelAttribute("Login") User user) {
        ModelAndView modelAndView = new ModelAndView();
        userService.blockUnblockUserByLogin(user.getLogin());
        modelAndView.addObject("message", "User activity changed");
        modelAndView.setViewName("adminPage");
        return modelAndView;
    }
}
