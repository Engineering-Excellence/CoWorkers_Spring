package com.crunch.mapper;

import com.crunch.domain.WorkDTO;

import java.util.HashMap;
import java.util.List;

public interface WorkMapper {

    void workInsert(WorkDTO workDTO);

    int workSelectCount();

    List<WorkDTO> workSelectList(HashMap<String, Integer> hashMap);

    List<WorkDTO> workSelectPriority();

    WorkDTO workSelectByWorkID(int workID);

    int workDelete(int workID);

    int workUpdate(WorkDTO workDTO);

}