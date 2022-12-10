package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class WorkDTO {

    private int workID; // 글번호 // pk // not null
    private String subject; // 제목 // not null
    private String userName; // 작성자(담당자) // not null
    private String content; // 내용 // not null
    private int priority; // 우선순위 1(긴급), 2(높음), 3(보통), 4(낮음)
    private int currentProgress; // 업무 상태 1(요청), 2(진행), 3(완료)
    private int workProgress; // 업무 진척도 ((0~10)*10)%
    private java.sql.Date writeDate; // 작성일
    private java.sql.Date updateDate; // 수정일
    private java.sql.Date deleteDate; // 삭제일
    private java.sql.Date startDate; // 시작일 // not null
    private java.sql.Date deadline; // 마감일 // not null
    private String ip; // ip
    private String admin; // 관리자
    private int userID; // 작성자(담당자) // fk // not null

}
