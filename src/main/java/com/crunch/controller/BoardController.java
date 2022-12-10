package com.crunch.controller;

import com.crunch.domain.BoardCommentDTO;
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
@AllArgsConstructor
@Slf4j
public class BoardController {

    private BoardService service;
    private BoardCommentService commentService;
    private BoardList boardList;
    private BoardCommentList boardCommentList;


    // 게시글 목록 불러오기
    @RequestMapping(value = "board")
    public String board(Model model,
                        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

        log.info("BoardController의 board() 실행");

        // 페이지 당 표시할 글 개수, 전체 글 개수 저장
        int pageSize = 10;
        int totalCount = service.selectCount();

        // 한 페이지 분량의 글과 페이징 작업에 사용할 변수 초기화
        List<BoardDTO> notice = service.selectNotice();
        boardList.initBoardList(pageSize, totalCount, currentPage);

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

        return "board/board";
    }

    // 게시글 조회 수 증가
    @RequestMapping(value = "boardHit")
    public String boardHit(Model model,
                           @RequestParam("postID") int postID,
                           @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardHit() 실행");

        service.hit(postID);

        model.addAttribute("postID", postID);
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

    // 게시글 조회
    @RequestMapping(value = "boardView")
    public String boardSelectByPostID(Model model,
                                      @RequestParam("postID") int postID,
                                      @RequestParam("currentPage") int currenPage) {

        log.info("BoardController의 boardView() 실행");

        BoardDTO boardDTO = service.selectByPostID(postID);
        boardDTO.setCommentCount(commentService.commentCount(postID));
        boardCommentList.setList(commentService.selectCommentList(postID));

        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("currentPage", currenPage);
        model.addAttribute("enter", "\r\n");
        model.addAttribute("boardCommentList", boardCommentList);

        return "board/boardView";
    }

    // 게시글 쓰기 페이지 진입
    @RequestMapping(value = "boardInsert")
    public String boardInsert() {

        log.info("BoardController의 boardInsert() 실행");

        return "board/boardInsert";
    }

    // 신규 게시글 작성
    @RequestMapping(value = "boardInsertOK")
    public String boardInsertOK(BoardDTO boardDTO) {

        log.info("BoardController의 boardInsertOK() 실행");

        service.insert(boardDTO);

        return "redirect:board";
    }

    // 게시글 수정 페이지 호출
    @RequestMapping(value = "boardUpdate")
    public String boardUpdate(Model model,
                              @RequestParam("postID") int postID,
                              @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardUpdate() 실행");

        BoardDTO boardDTO = service.selectByPostID(postID);

        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("currentPage", currentPage);

        return "board/boardUpdate";
    }

    // 게시글 수정
    @RequestMapping(value = "boardUpdateOK")
    public String boardUpdateOK(Model model, BoardDTO boardDTO,
                                @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardUpdateOK() 실행");

        service.update(boardDTO);

        model.addAttribute("postID", boardDTO.getPostID());
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

    // 게시글 삭제
    @RequestMapping(value = "boardDelete")
    public String boardDelete(Model model,
                              @RequestParam("postID") int postID,
                              @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardDelete() 실행");

        service.delete(postID);

        model.addAttribute("currentPage", currentPage);

        return "redirect:board";
    }

    // 신규 덧글 작성 및 수정
    @RequestMapping(value = "boardCommentOK")
    public String boardCommentOK(Model model,
                                 BoardCommentDTO boardCommentDTO,
                                 @RequestParam("mode") String mode,
                                 @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardCommentOK() 실행");

        switch (mode) {
            case "insert":
                commentService.commentInsert(boardCommentDTO);
                break;
            case "update":
                commentService.commentUpdate(boardCommentDTO);
                break;
            default:
                break;
        }

        model.addAttribute("postID", boardCommentDTO.getPostID());
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

    // 댓글 삭제
    @RequestMapping(value = "boardCommentDelete")
    public String boardCommentDelete(Model model,
                                     @RequestParam("commentID") int commentID,
                                     @RequestParam("postID") int postID,
                                     @RequestParam("currentPage") int currentPage) {

        log.info("BoardController의 boardCommentDelete() 실행");

        commentService.commentDelete(commentID);

        model.addAttribute("postID", postID);
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

}
