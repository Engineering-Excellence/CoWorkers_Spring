package com.crunch.domain;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class BoardCommentList {

    private List<BoardCommentDTO> list = new ArrayList<>();

}
