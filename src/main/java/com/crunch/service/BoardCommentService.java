package com.crunch.service;

import com.crunch.domain.BoardCommentDTO;

import java.util.List;

public interface BoardCommentService {

    int commentCount(int postID);

    List<BoardCommentDTO> selectCommentList(int postID);

    void commentInsert(BoardCommentDTO commentDTO);

    boolean commentDelete(int commentID);

    boolean commentUpdate(BoardCommentDTO commentDTO);

}
