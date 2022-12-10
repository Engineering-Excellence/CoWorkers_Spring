package com.crunch.service;

import com.crunch.domain.BoardDTO;
import com.crunch.mapper.BoardMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

    // 인스턴스 변수(mapper)에 알맞은 타입의 객체(BoardMapper)를 자동으로 주입하는 어노테이션
    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Override
    public int selectCount() {

        log.info("BoardServiceImpl의 selectCount() 실행");

        return mapper.boardSelectCount();
    }

    @Override
    public List<BoardDTO> selectList(HashMap<String, Integer> hashMap) {

        log.info("BoardServiceImpl의 selectList() 실행");

        return mapper.boardSelectList(hashMap);
    }

    @Override
    public BoardDTO selectByPostID(int postID) {

        log.info("BoardServiceImpl의 selectByPostID() 실행");

        return mapper.boardSelectByPostID(postID);
    }

    @Override
    public List<BoardDTO> selectNotice() {

        log.info("BoardServiceImpl의 selectNotice() 실행");

        return mapper.boardSelectNotice();
    }

    @Override
    public void hit(int postID) {

        log.info("BoardServiceImpl의 hit() 실행");

        mapper.boardHit(postID);
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
