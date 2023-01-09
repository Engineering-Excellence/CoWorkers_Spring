package com.crunch.mapper;

import com.crunch.domain.BoardAttachDTO;

import java.util.List;

public interface BoardAttachMapper {

    void boardAttachInsert(BoardAttachDTO attachDTO);

    void boardAttachDelete(String uuid);

    List<BoardAttachDTO> boardSelectAttachList(int postID);
}
