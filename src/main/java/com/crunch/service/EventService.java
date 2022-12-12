package com.crunch.service;

import com.crunch.domain.EventDTO;
import com.crunch.domain.WorkDTO;

import java.util.List;

public interface EventService {

    void insert(EventDTO eventDTO);

    int selectCount();

    List<EventDTO> selectEList();

    List<WorkDTO> selectWList();

    EventDTO selectByEventID(int eventID);

    boolean update(EventDTO eventDTO);

    boolean delete(int eventID);

    // 페이징 작업이 필요한 경우의 selectList
//    List<EventDTO> selectArrayList();

}
