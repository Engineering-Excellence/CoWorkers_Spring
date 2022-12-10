package com.crunch.controller;

import com.crunch.domain.WorkDTO;
import com.crunch.domain.WorkList;
import com.crunch.service.WorkService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

@Controller
@AllArgsConstructor
@Slf4j
public class WorkController {

    private WorkService service;
    private WorkList workList;

    @RequestMapping(value = "work")
    public String work(Model model,
                       @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

        log.info("WorkController의 work() 실행");

        int pageSize = 10;
        int totalCount = service.selectCount();

        List<WorkDTO> priority = service.selectPriority();
        workList.initWorkList(pageSize, totalCount, currentPage);

        HashMap<String, Integer> hashMap = new HashMap<>();
        hashMap.put("startNo", workList.getStartNo());
        hashMap.put("endNo", workList.getEndNo());
        workList.setList(service.selectList(hashMap));

        model.addAttribute("workList", workList);
        model.addAttribute("priority", priority);

        return "work/work";
    }

    @RequestMapping(value = "workView")
    public String workView(Model model,
                           @RequestParam("workID") int workID,
                           @RequestParam("currentPage") int currenPage) {

        log.info("WorkController의 workView() 실행");

        WorkDTO workDTO = service.selectByWorkID(workID);

        model.addAttribute("dto", workDTO);
        model.addAttribute("currentPage", currenPage);
        model.addAttribute("enter", "\r\n");

        return "work/workView";
    }

    @RequestMapping(value = "workInsert")
    public String workInsert() {

        log.info("WorkController의 workInsert() 실행");

        return "work/workInsert";
    }

    @RequestMapping(value = "workInsertOK")
    public String workInsertOK(WorkDTO workDTO) {

        log.info("WorkController의 workInsertOK() 실행");

        service.insert(workDTO);

        return "redirect:work";
    }

    @RequestMapping(value = "workUpdate")
    public String workUpdate(Model model,
                             @RequestParam("workID") int workID,
                             @RequestParam("currentPage") int currentPage) {

        log.info("WorkController의 workUpdate() 실행");

        WorkDTO workDTO = service.selectByWorkID(workID);

        model.addAttribute("dto", workDTO);
        model.addAttribute("currentPage", currentPage);

        return "work/workUpdate";
    }

    @RequestMapping(value = "workUpdateOK")
    public String workUpdateOK(Model model, WorkDTO workDTO,
                               @RequestParam("currentPage") int currentPage) {

        log.info("WorkController의 workUpdateOK() 실행");

        service.update(workDTO);

        model.addAttribute("workID", workDTO.getWorkID());
        model.addAttribute("currentPage", currentPage);

        return "redirect:workView";
    }

    @RequestMapping(value = "workDelete")
    public String workDelete(Model model,
                             @RequestParam("workID") int workID,
                             @RequestParam("currentPage") int currentPage) {

        log.info("WorkController의 workDelete() 실행");

        service.delete(workID);

        model.addAttribute("currentPage", currentPage);

        return "redirect:work";
    }

}