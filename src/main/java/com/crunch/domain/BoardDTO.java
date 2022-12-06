package com.crunch.domain;

import lombok.Data;

@Data
public class BoardDTO {

    private int postID; // PK, 글번호
    private String subject; // 제목
    private String userName;    // 이름
    private String content; // 내용
    private java.sql.Date writeDate; // 입력일
    private java.sql.Date updateDate;    // 수정일
    private java.sql.Date deleteDate;    // 삭제일
    private int hit = 0;    // 조회수
    private int commentCount = 0;   // 덧글 수
    private String notice = "false";    // 공지글 여부
    private String ip;  // IP 주소
    private int userID; // FK, 사원번호

}
