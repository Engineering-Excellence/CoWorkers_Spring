package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Data
public class BoardCommentList {

    private List<BoardCommentDTO> list = new ArrayList<>();

}
