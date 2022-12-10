package com.crunch.service;

import com.crunch.domain.WorkDTO;

import java.util.HashMap;
import java.util.List;

public interface WorkService {

    void insert(WorkDTO workDTO);

    int selectCount();

    List<WorkDTO> selectList(HashMap<String, Integer> hashMap);

    List<WorkDTO> selectPriority();

    WorkDTO selectByWorkID(int workID);

    boolean delete(int workID);

    boolean update(WorkDTO workDTO);

}
