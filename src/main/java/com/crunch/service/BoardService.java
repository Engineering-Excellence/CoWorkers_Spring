package com.crunch.service;

import com.crunch.domain.BoardDTO;

import java.util.HashMap;
import java.util.List;

public interface BoardService {

    int selectCount();

    List<BoardDTO> selectList(HashMap<String, Integer> hashMap);

    BoardDTO selectByPostID(int postID);

    List<BoardDTO> selectNotice();

    void hit(int postID);

    void insert(BoardDTO boardDTO);

    boolean update(BoardDTO boardDTO);

    boolean delete(int postID);

}
