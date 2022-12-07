package com.crunch.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Locale;

@Controller
@Slf4j
@RequestMapping("/")
public class HomeController {

    @GetMapping("")
    public String home(Locale locale, Model model) {
        log.info("Welcome home! The client locale is {}.", locale);

        return "index";
    }

}
