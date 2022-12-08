package com.crunch.mapper;

import com.crunch.domain.BoardCommentDTO;

import java.util.List;

public interface BoardCommentMapper {

    int boardCommentCount(int postID);

    List<BoardCommentDTO> boardSelectCommentList(int postID);

    void boardCommentInsert(BoardCommentDTO commentDTO);

    int boardCommentDelete(int commentID);

    int boardCommentUpdate(BoardCommentDTO commentDTO);

}
