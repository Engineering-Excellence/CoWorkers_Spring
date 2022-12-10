package com.crunch.controller;

import com.crunch.service.EventService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
@Slf4j
public class EventController {

    private EventService service;

    @RequestMapping("event")
    public String event(Model model) {

        log.info("EventController의 Event() 실행");

        return "event/event";
    }



}
