package com.crunch.mapper;

import com.crunch.domain.BoardDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface BoardMapper {

    int boardSelectCount();

    List<BoardDTO> boardSelectList(HashMap<String, Integer> hashMap);

    BoardDTO boardSelectByPostID(int postID);

    ArrayList<BoardDTO> boardSelectNotice();

    void boardHit(int postID);

    void boardInsert(BoardDTO boardDTO);

    int boardDelete(int postID);

    int boardUpdate(BoardDTO boardDTO);

}
