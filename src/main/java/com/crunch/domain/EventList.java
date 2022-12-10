package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Data
public class EventList {

    private List<EventDTO> list = new ArrayList<>();
    private int pageSize = 10; // 1페이지에 표시할 글 개수
    private int totalCount = 0; // 테이블에 저장된 전체 글 개수
    private int totalPage = 0; // 전체 페이지 개수
    private int currentPage = 1; // 현재 브라우저에 표시되는 페이지 번호
    private int startNo = 0; // 현재 브라우저에 표시되는 글 목록의 시작 인덱스 번호
    private int endNo = 0; // 현재 브라우저에 표시되는 글 목록의 마지막 인덱스 번호
    private int startPage = 0; // 페이지 이동 버튼의 표시될 시작 페이지 번호
    private int endPage = 0; // 페이지 이동 버튼의 표시될 마지막 페이지 번호

    public void initEventList(int pageSize, int totalCount, int currentPage) {
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        calculator();
    }

    private void calculator() {
        totalPage = (totalCount - 1) / pageSize + 1;
        currentPage = Math.min(currentPage, totalPage);
        startNo = (currentPage - 1) * pageSize + 1;
        endNo = startNo + pageSize - 1;
        endNo = Math.min(endNo, totalCount);
        startPage = (currentPage - 1) / 10 * 10 + 1;
        endPage = startPage + 9;
        endPage = Math.min(endPage, totalPage);
    }

}