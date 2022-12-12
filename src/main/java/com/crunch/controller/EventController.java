package com.crunch.controller;

import com.crunch.domain.EventDTO;
import com.crunch.service.EventService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@Controller
@AllArgsConstructor
@Slf4j
public class EventController {

    private EventService service;

    // 캘린더 뷰 호출
    @RequestMapping(value = "event")
    public String event() {

        log.info("EventController의 event() 실행");

        return "event/event";
    }

    // 캘린더 뷰에서 필요한 처리를 위함.
    @RequestMapping(value = "AjaxGetEventList")
    public void actionDo(HttpServletRequest request, HttpServletResponse response) throws IOException {

        log.info("EventController의 actionDo() 실행");

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        response.getWriter().write(getJSON());
    }

    private String getJSON() {

        ArrayList<EventDTO> eList = (ArrayList<EventDTO>) service.selectEList();
        StringBuilder result = new StringBuilder();
			/*
			 	{"result" : [
			 		[
			 		]
			 	]}
			 */
        result.append("{\"eList\":[");    //json 시작부분
//		데이터의 개수만큼 반복하며 json 형태의 문자열을 만든다.
        for (EventDTO eDTO : eList) {
            result.append("[{\"eventID\":\"").append(eDTO.getEventID()).append("\"}, ");
            result.append("{\"startDate\":\"").append(eDTO.getStartDate()).append("\"}, ");
            result.append("{\"endDate\":\"").append(eDTO.getEndDate()).append("\"}, ");
            result.append("{\"subject\":\"").append(eDTO.getSubject()).append("\"}, ");
            result.append("{\"eventColor\":\"").append(eDTO.getEventColor()).append("\"}, ");
            result.append("{\"deleteDate\":\"").append(eDTO.getDeleteDate()).append("\"}, ");
            result.append("{\"writeDate\":\"").append(eDTO.getWriteDate()).append("\"}], ");
        }
        result.append("]}");    //json 끝부분

//		StringBuffer 타입의 객체를 String 타입으로 리턴시키기 위해
//		toString()  메서드를 실행하여 리턴시킨다.
        return result.toString();
    }


    // 일정 추가
    @RequestMapping("/eventInsertOK")
    public String eventInsertOK(EventDTO eDTO) {

        log.info("EventController의 eventInsertOK() 실행");

        service.insert(eDTO);

        return "redirect:event";
    }

    // 일정 목록 호출
    @RequestMapping(value = "eventList")
    public String eventSelectArrayList(Model model) {

        log.info("EventController의 eventSelectArrayList() 실행");

        ArrayList<EventDTO> eList = (ArrayList<EventDTO>) service.selectEList();

        model.addAttribute("eList", eList);

        return "event/eventList";
    }

    // 일정 페이지 호출
    @RequestMapping(value = "eventView")
    public String eventView(Model model, @RequestParam("eventID") int eventID) {

        log.info("EventController의 eventView() 실행");

        EventDTO eventDTO = service.selectByEventID(eventID);

        model.addAttribute("eDTO", eventDTO);
        model.addAttribute("enter", "\r\n");

        return "event/eventView";
    }

    // 일정 수정
    @RequestMapping(value = "eventUpdate")
    public String update(Model model, @RequestParam("eventID") int eventID) {

        log.info("EventController의 update() 실행");

        EventDTO eventDTO = service.selectByEventID(eventID);

        model.addAttribute("eDTO", eventDTO);
        model.addAttribute("enter", "\r\n");

        return "event/eventUpdate";
    }

    // 일정 삭제
    @RequestMapping(value = "eventDelete")
    public String delete(Model model, @RequestParam("eventID") int eventID) {

        log.info("EventController의 delete() 실행");

        service.delete(eventID);

        return "redirect:eventList";
    }

}
