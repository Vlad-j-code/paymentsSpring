package com.transfers.payments.controllers;

import com.transfers.payments.entity.User;
import com.transfers.payments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @RequestMapping("/registration")
    public String registrationGet(Model model){
        User user = new User();

        model.addAttribute("user", user);

        return "registration";
    }

    @PostMapping("/registration")
    public String registrationPOST(@Valid @ModelAttribute("user") User user, BindingResult bindingResult, Model model) {

        User userExists = userService.findUserByLogin(user.getLogin());
        if (userExists != null) {
            model.addAttribute("loginMsg", "There is already a user registered with the username provided");
            return "registration";
        }
        if (bindingResult.hasErrors()) {
            return "registration";
        } else {

//            notificationService.sendRegistrationNotification(user);
            userService.addUser(user);


        }
        return "loginPage";
    }
}
