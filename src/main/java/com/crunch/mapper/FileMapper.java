package com.crunch.mapper;

import com.crunch.domain.FileDTO;

import java.util.HashMap;
import java.util.List;

public interface FileMapper {

    int fileSelectCount();

    List<FileDTO> fileSelectList(HashMap<String, Integer> hashMap);

    FileDTO fileSelectByFileID(int fileID);

    List<FileDTO> fileSelectNotice();

    void fileHit(int fileID);

    void fileInsert(FileDTO fileDTO);

    int fileDelete(int fileID);

    int fileUpdate(FileDTO fileDTO);
    
}
