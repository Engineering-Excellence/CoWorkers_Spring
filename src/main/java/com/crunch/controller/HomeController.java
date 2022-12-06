package com.crunch.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Locale;

@Controller
@Slf4j
public class HomeController {

    @GetMapping(value = "/")
    public String home(Locale locale, Model model) {
        log.info("Welcome home! The client locale is {}.", locale);

        return "home";
    }

}
