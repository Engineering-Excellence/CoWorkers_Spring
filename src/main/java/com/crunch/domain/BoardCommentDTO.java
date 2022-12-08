package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class BoardCommentDTO {

    private int commentID;    // PK, 댓글번호
    private String userName;    // 이름
    private String content;  // 덧글 내용
    private java.sql.Date writeDate; // 입력일
    private java.sql.Date updateDate;    // 수정일
    private java.sql.Date deleteDate;    // 삭제일
    private String ip;      // IP 주소
    private int postID;    // FK, 메인글의 글번호
    private int userID;    // FK, 아이디

}
