package com.crunch.controller;

import com.crunch.domain.FileDTO;
import com.crunch.domain.FileList;
import com.crunch.service.FileService;
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
public class FileController {

    private FileService service;
    private FileList list;

    @RequestMapping("file")
    public String file(Model model,
                       @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

        log.info("FileController의 file() 실행");

        // 페이지 당 표시할 글 개수, 전체 글 개수 저장
        int pageSize = 10;
        int totalCount = service.selectCount();

        // 한 페이지 분량의 글과 페이징 작업에 사용할 변수 초기화
        List<FileDTO> notice = service.selectNotice();
        list.initFileList(pageSize, totalCount, currentPage);

        // 한 페이지 분량의 글 목록을 얻어온다.
        HashMap<String, Integer> hashMap = new HashMap<>();
        hashMap.put("startNo", list.getStartNo());
        hashMap.put("endNo", list.getEndNo());
        list.setList(service.selectList(hashMap));

        model.addAttribute("notice", notice);
        model.addAttribute("fileList", list);

        return "file/file";
    }

    @RequestMapping(value = "fileHit")
    public String fileHit(Model model,
                          @RequestParam("fileID") int fileID,
                          @RequestParam("currentPage") int currentPage) {

        log.info("FileController의 fileHit() 실행");

        service.hit(fileID);

        model.addAttribute("fileID", fileID);
        model.addAttribute("currentPage", currentPage);

        return "redirect:fileView";
    }

    @RequestMapping(value = "fileView")
    public String fileView(Model model,
                           @RequestParam("fileID") int fileID,
                           @RequestParam("currentPage") int currenPage) {

        log.info("fileController의 fileView() 실행");

        FileDTO fileDTO = service.selectByFileID(fileID);

        model.addAttribute("fileDTO", fileDTO);
        model.addAttribute("currentPage", currenPage);
        model.addAttribute("enter", "\r\n");

        return "file/fileView";
    }



}
