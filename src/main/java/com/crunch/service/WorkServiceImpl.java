package com.crunch.service;

import com.crunch.domain.WorkDTO;
import com.crunch.mapper.WorkMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class WorkServiceImpl implements WorkService {

    @Setter(onMethod_ = @Autowired)
    private WorkMapper mapper;

    @Override
    public void insert(WorkDTO workDTO) {

        log.info("WorkServiceImpl의 insert() 실행");

        mapper.workInsert(workDTO);
    }

    @Override
    public int selectCount() {

        log.info("WorkServiceImpl의 selectCount() 실행");

        return mapper.workSelectCount();
    }

    @Override
    public List<WorkDTO> selectList(HashMap<String, Integer> hashMap) {

        log.info("WorkServiceImpl의 selectList() 실행");

        return mapper.workSelectList(hashMap);
    }

    @Override
    public List<WorkDTO> selectPriority() {

        log.info("WorkServiceImpl의 selectPriority() 실행");

        return mapper.workSelectPriority();
    }

    @Override
    public WorkDTO selectByWorkID(int workID) {

        log.info("WorkServiceImpl의 selectByWorkID() 실행");

        return mapper.workSelectByWorkID(workID);
    }

    @Override
    public boolean delete(int workID) {

        log.info("WorkServiceImpl의 delete() 실행");

        return mapper.workDelete(workID) == 1;
    }

    @Override
    public boolean update(WorkDTO workDTO) {

        log.info("WorkServiceImpl의 update() 실행");

        return mapper.workUpdate(workDTO) == 1;
    }
}
