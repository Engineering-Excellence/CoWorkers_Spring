package com.crunch.controller;

import com.crunch.domain.FileDTO;
import com.crunch.domain.FileList;
import com.crunch.service.FileService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@AllArgsConstructor
@Slf4j
public class FileController {

    private FileService service;
    private FileList list;
    private FileDTO fileDTO;

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

        log.info("FileController의 fileView() 실행");

        fileDTO = service.selectByFileID(fileID);

        model.addAttribute("fileDTO", fileDTO);
        model.addAttribute("currentPage", currenPage);
        model.addAttribute("enter", "\r\n");

        return "file/fileView";
    }

    @RequestMapping("fileUploadForm")
    public String fileUploadForm() {

        log.info("FileController의 fileUploadForm() 실행");

        return "file/fileUploadForm";
    }

    @RequestMapping("fileUploadFormAction")
    public String fileUploadFormAction(@RequestParam Map<String, Object> map,
                                       @RequestParam("uploadFile") MultipartFile[] uploadFile) {

        log.info("FileController의 fileUploadFormAction() 실행");

        String uploadFolder = "/Users/kyle/Documents/Study/CRUNCH/CoWorkers_Spring/upload";

        for (MultipartFile multipartFile : uploadFile) {

            log.info("-----------------------------------------------------------------------------------------------");
            log.info("fileName: {}", multipartFile.getOriginalFilename());
            log.info("fileSize: {}", multipartFile.getSize());

            File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

            try {
                multipartFile.transferTo(saveFile);
            } catch (Exception ignored) {
            }

            fileDTO.setUserName((String) map.get("userName"));
            fileDTO.setSubject((String) map.get("subject"));
            fileDTO.setContent((String) map.get("content"));
            fileDTO.setFileName(multipartFile.getOriginalFilename());
            if (map.get("notice") != null) {
                fileDTO.setNotice((String) map.get("notice"));
            }
            fileDTO.setIp((String) map.get("ip"));
            fileDTO.setUserID(Integer.parseInt((String) map.get("userID")));
        }

        service.insert(fileDTO);

        return "redirect:file";
    }

    /*@RequestMapping(value = "fileUploadAjax")
    public String fileUploadAjax() {

        log.info("FileController의 fileUploadAjax() 실행");

        return "fileUploadForm";
    }

    @PostMapping("fileUploadAjaxAction")
    public String fileUploadAjaxAction(MultipartFile[] fileName) {

        log.info("FileController의 fileUploadAjaxAction() 실행");

        String uploadFolder = "/Users/kyle/Documents/Study/CRUNCH/CoWorkers_Spring/upload";

        for (MultipartFile multipartFile : fileName) {

            log.info("-----------------------------------------------------------------------------------------------");
            log.info("fileName: {}", multipartFile.getOriginalFilename());
            log.info("fileSize: {}", multipartFile.getSize());

            String originalFileName = multipartFile.getOriginalFilename();

            // IE has file path
            originalFileName = originalFileName.substring(originalFileName.lastIndexOf("/") + 1);
            log.info("fileRealName: {}", originalFileName);

            File fileRealName = new File(uploadFolder, originalFileName);

            try {
                multipartFile.transferTo(fileRealName);
            } catch (Exception ignored) {
            }
        }

        return "redirect:file";
    }*/

    @RequestMapping(value = "fileDownload", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    @ResponseBody
    public ResponseEntity<Resource> fileDownload(FileDTO fileDTO) {

        log.info("FileController의 fileDownload() 실행");

        Resource resource = new FileSystemResource("/Users/kyle/Documents/Study/CRUNCH/CoWorkers_Spring/upload/" + fileDTO.getFileName());
        String resourceName = resource.getFilename();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; fileName=" + new String(resourceName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));

        service.downloadCount(fileDTO);

        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }

}
