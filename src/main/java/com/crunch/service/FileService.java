package com.crunch.service;

import com.crunch.domain.FileDTO;

import java.util.HashMap;
import java.util.List;

public interface FileService {

    int selectCount();

    List<FileDTO> selectList(HashMap<String, Integer> hashMap);

    FileDTO selectByFileID(int fileID);

    List<FileDTO> selectNotice();

    void hit(int fileID);

    void insert(FileDTO fileDTO);

    boolean update(FileDTO fileDTO);

    boolean delete(int fileID);

}
