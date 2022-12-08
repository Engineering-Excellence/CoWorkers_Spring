package com.crunch.controller;

import com.crunch.domain.BoardCommentList;
import com.crunch.domain.BoardDTO;
import com.crunch.domain.BoardList;
import com.crunch.service.BoardCommentService;
import com.crunch.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

@Controller
@Slf4j
@AllArgsConstructor
public class BoardController {

    private BoardService service;
    private BoardCommentService commentService;
    private BoardCommentList boardCommentList;


    // 글 목록 불러오기
    @RequestMapping("/board")
    public String board(Model model,
                        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

        log.info("BoardController의 board() 실행");
//        log.info("model: {}", model);
//        log.info("currentPage: {}", currentPage);

        // 페이지 당 표시할 글 개수, 전체 글 개수 저장
        int pageSize = 10;
        int totalCount = service.selectCount();

        // 한 페이지 분량의 글과 페이징 작업에 사용할 변수 초기화
        List<BoardDTO> notice = service.selectNotice();
        BoardList boardList = new BoardList(pageSize, totalCount, currentPage);

        // 한 페이지 분량의 글 목록을 얻어온다.
        HashMap<String, Integer> hashMap = new HashMap<>();
        hashMap.put("startNo", boardList.getStartNo());
        hashMap.put("endNo", boardList.getEndNo());
        boardList.setList(service.selectList(hashMap));

        for (BoardDTO boardDTO : notice) {
            boardDTO.setCommentCount(commentService.commentCount(boardDTO.getPostID()));
        }
        for (BoardDTO boardDTO : boardList.getList()) {
            boardDTO.setCommentCount(commentService.commentCount(boardDTO.getPostID()));
        }

        model.addAttribute("notice", notice);
        model.addAttribute("boardList", boardList);
//        log.info("{}", notice);
//        log.info("{}", boardList);

        return "board/board";
    }

    // 글 조회 수 증가
    @RequestMapping("/boardHit")
    public String boardHit(Model model,
                           @RequestParam("postID") int postID,
                           @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardHit() 실행");
//        log.info("postID: {}, currentPage: {}", postID, currentPage);

        service.hit(postID);

        model.addAttribute("postID", postID);
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

    // 글 조회
    @RequestMapping("/boardView")
    public String boardSelectByPostID(Model model,
                                      @RequestParam("postID") int postID,
                                      @RequestParam("currentPage") int currenPage) {

        log.info("BoardController의 boardView() 실행");
//        log.info("postID: {}, currentPage: {}", postID, currenPage);

        BoardDTO boardDTO = service.selectByPostID(postID);

        boardCommentList.setList(commentService.selectCommentList(postID));

        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("currentPage", currenPage);
        model.addAttribute("enter", "\r\n");
        model.addAttribute("boardCommentList", boardCommentList);
        boardDTO.setCommentCount(commentService.commentCount(postID));

        return "board/boardView";
    }

    // 글쓰기 페이지 진입
    @RequestMapping("/boardInsert")
    public String boardInsert(Model model) {

        log.info("BoardController의 boardInsert() 실행");

        return "board/boardInsert";
    }

    // 신규 글 작성
    @RequestMapping("/boardInsertOK")
    public String boardInsertOK(Model model, BoardDTO boardDTO) {

        log.info("BoardController의 boardInsertOK() 실행");
        log.info("model: {}", model);
        log.info("boardDTO: {}", boardDTO);

        service.insert(boardDTO);

        return "redirect:board";
    }

    // 글 수정

    // 글 삭제


}
