package com.crunch.service;

import com.crunch.domain.EventDTO;
import com.crunch.domain.WorkDTO;

import java.util.HashMap;
import java.util.List;

public interface EventService {

    void insert(EventDTO eventDTO);

    int selectCount();

    List<EventDTO> selectList(HashMap<String, Integer> hashMap);

    List<EventDTO> selectArrayList();

    List<EventDTO> selectEList();

    List<WorkDTO> workSelectArrayList();

    EventDTO selectByEventID(int eventID);

    boolean update(EventDTO eventDTO);

    boolean delete(int eventID);

}
