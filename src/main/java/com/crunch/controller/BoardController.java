package com.crunch.controller;

import com.crunch.domain.BoardList;
import com.crunch.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;

@Controller
@Slf4j
@AllArgsConstructor
public class BoardController {

    private BoardService service;

    // 게시글 목록 불러오기
    @RequestMapping("/board")
    public String board(Model model, @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

        log.info("BoardController의 board() 실행");

        // 페이지 당 표시할 글 개수, 전체 글 개수 저장
        int pageSize = 10;
        int totalCount = service.selectCount();

        // 한 페이지 분량의 글과 페이징 작업에 사용할 변수 초기화
        BoardList boardList = new BoardList(pageSize, totalCount, currentPage);

        // 한 페이지 분량의 글 목록을 얻어온다.
        HashMap<String, Integer> hashMap = new HashMap<>();
        hashMap.put("startNo", boardList.getStartNo());
        hashMap.put("endNo", boardList.getEndNo());
        boardList.setList(service.selectList(hashMap));

        model.addAttribute("boardList", boardList);
//        log.info("{}", boardList);

        return "board/board";
    }

}
