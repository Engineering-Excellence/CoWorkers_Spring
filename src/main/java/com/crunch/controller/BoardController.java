package com.crunch.controller;

import com.crunch.domain.*;
import com.crunch.service.BoardCommentService;
import com.crunch.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@AllArgsConstructor
@Slf4j
public class BoardController {

    private BoardService service;
    private BoardCommentService commentService;
    private BoardList boardList;
    private BoardCommentList boardCommentList;


    // 게시글 목록 불러오기
    @GetMapping(value = "board")
    public String board(Model model,
                        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

        log.info("board() 실행");

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
    @GetMapping(value = "boardHit")
    public String boardHit(Model model,
                           @RequestParam("postID") int postID,
                           @RequestParam("currentPage") int currentPage) {

        log.info("boardHit() 실행");

        service.hit(postID);

        model.addAttribute("postID", postID);
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

    // 게시글 조회
    @GetMapping(value = "boardView")
    public String boardView(Model model,
                            @RequestParam("postID") int postID,
                            @RequestParam("currentPage") int currenPage) {

        log.info("boardView() 실행");

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
    @GetMapping(value = "boardInsert")
    public String boardInsert() {

        log.info("boardInsert() 실행");

        return "board/boardInsert";
    }

    // 파일 업로드 AJAX
    @PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<BoardAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

        log.info("uploadAjaxPost() 실행 → uploadFile: {}", uploadFile);

        List<BoardAttachDTO> attachList = new ArrayList<>();
        String uploadFolder = "/Users/kyle/Documents/Study/CRUNCH/CoWorkers_Spring/upload";

        String uploadFolderPath = getFolder();
        // 폴더 생성
        File uploadPath = new File(uploadFolder, uploadFolderPath);
        log.info("upload path: {}", uploadPath);

        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        for (MultipartFile multipartFile : uploadFile) {

            log.info("-----------------------------------------------------------------------------------------------");
            log.info("Upload File Name: {}", multipartFile.getOriginalFilename());
            log.info("Upload File Size: {}", multipartFile.getSize());

            BoardAttachDTO attachDTO = new BoardAttachDTO();

            String uploadFileName = multipartFile.getOriginalFilename();

            // IE has file path
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
            log.info("only file name: {}", uploadFileName);

            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid + "_" + uploadFileName;

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setFileName(multipartFile.getOriginalFilename());
                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);

                // 파일 이미지 타입 체크
                if (checkImageType(saveFile)) {

                    attachDTO.setImage(true);

                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

                    thumbnail.close();
                }

                // 리스트에 추가
                attachList.add(attachDTO);

            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }   // end for

        return new ResponseEntity<>(attachList, HttpStatus.OK);
    }

    // 년월일 폴더 생성
    private String getFolder() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);
    }

    // 이미지 여부 확인
    private boolean checkImageType(File file) {

        log.info("checkImageType() 실행 → file: {}", file);

        try {
            String contentType = Files.probeContentType(file.toPath());

            return contentType.startsWith("image");

        } catch (IOException e) {
            e.printStackTrace();
        }

        return false;
    }

    // 섬네일 전송
    @GetMapping(value = "display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName) {

        log.info("getFile() 실행 → fileName: {}", fileName);

        String uploadFolder = "/Users/kyle/Documents/Study/CRUNCH/CoWorkers_Spring/upload/";
        File file = new File(uploadFolder + fileName);
        log.info("file: {}", file);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();

            header.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 신규 게시글 작성
    @PostMapping(value = "boardInsertOK")
    public String boardInsertOK(BoardDTO boardDTO, RedirectAttributes rttr) {

        log.info("boardInsertOK() 실행 → boardDTO: {}", boardDTO);

        if (boardDTO.getAttachList() != null) {
            boardDTO.getAttachList().forEach(attachDTO -> log.info("{}", attachDTO));
        }

//        service.insert(boardDTO);
//        rttr.addFlashAttribute("result", boardDTO.getPostID());

        return "redirect:board";
    }

    // 게시글 수정 페이지 호출
    @GetMapping(value = "boardUpdate")
    public String boardUpdate(Model model,
                              @RequestParam("postID") int postID,
                              @RequestParam("currentPage") int currentPage) {

        log.info("boardUpdate() 실행");

        BoardDTO boardDTO = service.selectByPostID(postID);

        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("currentPage", currentPage);

        return "board/boardUpdate";
    }

    // 게시글 수정
    @PostMapping(value = "boardUpdateOK")
    public String boardUpdateOK(Model model, BoardDTO boardDTO,
                                @RequestParam("currentPage") int currentPage) {

        log.info("boardUpdateOK() 실행");

        service.update(boardDTO);

        model.addAttribute("postID", boardDTO.getPostID());
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

    // 게시글 삭제
    @GetMapping(value = "boardDelete")
    public String boardDelete(Model model,
                              @RequestParam("postID") int postID,
                              @RequestParam("currentPage") int currentPage) {

        log.info("boardDelete() 실행");

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

        log.info("boardCommentOK() 실행");

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
    @GetMapping(value = "boardCommentDelete")
    public String boardCommentDelete(Model model,
                                     @RequestParam("commentID") int commentID,
                                     @RequestParam("postID") int postID,
                                     @RequestParam("currentPage") int currentPage) {

        log.info("boardCommentDelete() 실행");

        commentService.commentDelete(commentID);

        model.addAttribute("postID", postID);
        model.addAttribute("currentPage", currentPage);

        return "redirect:boardView";
    }

}
