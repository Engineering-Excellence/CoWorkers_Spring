package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class FileDTO {

    private int fileID; // 파일번호, PK
    private String userName;    // 이름
    private String subject; // 제목
    private String content; // 내용
    private String fileName;    // 파일명
    private int downloadCount = 0;  // 다운로드 횟수
    private java.sql.Date writeDate;    // 작성일
    private java.sql.Date updateDate;    // 수정일
    private java.sql.Date deleteDate;    // 삭제일
    private int hit = 0;    // 조회수
    private String notice = "false";  // 공지글 여부
    private String ip;  // IP 주소
    private int userID; // 사원번호, FK
//    private MultipartFile uploadFile;

}
