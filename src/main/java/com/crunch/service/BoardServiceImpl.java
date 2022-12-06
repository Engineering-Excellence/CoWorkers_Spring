package com.crunch.service;

import com.crunch.domain.BoardDTO;
import com.crunch.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@AllArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Override
    public int selectCount() {

        log.info("BoardServiceImpl의 selectCount() 실행");

        return mapper.boardSelectCount();
    }

    @Override
    public BoardDTO selectByPostID(int postID) {

        log.info("BoardServiceImpl의 select() 실행");

        return mapper.boardSelectByPostID(postID);
    }

    @Override
    public List<BoardDTO> selectList(HashMap<String, Integer> hashMap) {

        log.info("BoardServiceImpl의 selectList() 실행");

        return mapper.boardSelectList(hashMap);
    }

    @Override
    public void insert(BoardDTO boardDTO) {

        log.info("BoardServiceImpl의 insert() 실행");

        log.info("insert({})", boardDTO);
        mapper.boardInsert(boardDTO);
    }

    @Override
    public boolean update(BoardDTO boardDTO) {

        log.info("BoardServiceImpl의 update() 실행");

        return mapper.boardUpdate(boardDTO) == 1;
    }

    @Override
    public boolean delete(int postID) {

        log.info("BoardServiceImpl의 delete() 실행");

        return mapper.boardDelete(postID) == 1;
    }


}
