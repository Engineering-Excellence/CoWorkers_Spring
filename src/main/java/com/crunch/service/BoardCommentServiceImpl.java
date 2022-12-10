package com.crunch.service;

import com.crunch.domain.BoardCommentDTO;
import com.crunch.mapper.BoardCommentMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class BoardCommentServiceImpl implements BoardCommentService {

    // 인스턴스 변수(mapper)에 알맞은 타입의 객체(BoardCommentMapper)를 자동으로 주입하는 어노테이션
    @Setter(onMethod_ = @Autowired)
    private BoardCommentMapper mapper;

    @Override
    public int commentCount(int postID) {

        log.info("BoardCommentServiceImple의 commentCount() 실행");

        return mapper.boardCommentCount(postID);
    }

    @Override
    public List<BoardCommentDTO> selectCommentList(int postID) {

        log.info("BoardCommentServiceImple의 selectCommentList() 실행");

        return mapper.boardSelectCommentList(postID);
    }

    @Override
    public void commentInsert(BoardCommentDTO commentDTO) {

        log.info("BoardCommentServiceImple의 commentInsert() 실행");

        mapper.boardCommentInsert(commentDTO);
    }

    @Override
    public boolean commentDelete(int commentID) {

        log.info("BoardCommentServiceImple의 commentDelete() 실행");

        return mapper.boardCommentDelete(commentID) == 1;
    }

    @Override
    public boolean commentUpdate(BoardCommentDTO commentDTO) {

        log.info("BoardCommentServiceImple의 commentUpdate() 실행");

        return mapper.boardCommentUpdate(commentDTO) == 1;
    }
}
