package com.crunch.service;

import com.crunch.domain.FileDTO;
import com.crunch.mapper.FileMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class FileServiceImpl implements FileService {

    @Setter(onMethod_ = @Autowired)
    private FileMapper mapper;

    @Override
    public int selectCount() {

        log.info("FileServiceImpl의 selectCount() 실행");

        return mapper.fileSelectCount();
    }

    @Override
    public List<FileDTO> selectList(HashMap<String, Integer> hashMap) {

        log.info("FileServiceImpl의 selectList() 실행");

        return mapper.fileSelectList(hashMap);
    }

    @Override
    public FileDTO selectByFileID(int fileID) {

        log.info("FileServiceImpl의 selectByFileID() 실행");

        return mapper.fileSelectByFileID(fileID);
    }

    @Override
    public List<FileDTO> selectNotice() {

        log.info("FileServiceImpl의 selectNotice() 실행");

        return mapper.fileSelectNotice();
    }

    @Override
    public void hit(int fileID) {

        log.info("FileServiceImpl의 hit() 실행");

        mapper.fileHit(fileID);
    }

    @Override
    public void insert(FileDTO fileDTO) {

        log.info("FileServiceImpl의 insert() 실행");

        mapper.fileInsert(fileDTO);
    }

    @Override
    public boolean update(FileDTO fileDTO) {
        return false;
    }

    @Override
    public boolean delete(int fileID) {
        return false;
    }

    @Override
    public void downloadCount(FileDTO fileDTO) {

        log.info("FileServiceImpl의 downloadCount() 실행");

        mapper.fileDownloadCount(fileDTO);
    }

}
