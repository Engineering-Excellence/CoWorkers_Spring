package com.crunch.service;

import com.crunch.domain.BoardDTO;

import java.util.HashMap;
import java.util.List;

public interface BoardService {

    int selectCount();

    BoardDTO selectByPostID(int postID);

    List<BoardDTO> selectList(HashMap<String, Integer> hashMap);

    void insert(BoardDTO boardDTO);

    boolean update(BoardDTO boardDTO);

    boolean delete(int postID);

}
