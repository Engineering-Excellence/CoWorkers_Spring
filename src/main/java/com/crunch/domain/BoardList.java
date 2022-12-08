package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Data
public class BoardList {

    private List<BoardDTO> list = new ArrayList<>();
    private int pageSize;
    private int totalCount;
    private int currentPage;
    private int totalPage = 0;
    private int startNo = 0;
    private int endNo = 0;
    private int startPage = 0;
    private int endPage = 0;

    public BoardList() {
    }

    public BoardList(int pageSize, int totalCount, int currentPage) {
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
