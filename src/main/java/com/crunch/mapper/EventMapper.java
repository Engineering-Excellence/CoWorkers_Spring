package com.crunch.mapper;

import com.crunch.domain.EventDTO;
import com.crunch.domain.WorkDTO;

import java.util.HashMap;
import java.util.List;

public interface EventMapper {

    void eventInsert(EventDTO eventDTO);

    int eventSelectCount();

    List<EventDTO> eventSelectList(HashMap<String, Integer> hashMap);

    List<EventDTO> eventSelectEList();

    List<WorkDTO> eventSelectWList();

    EventDTO eventSelectByEventID(int eventID);

    int eventUpdate(EventDTO eventDTO);

    int eventDelete(int eventID);

    // 페이징 작업이 필요한 경우의 selectList
//	List<EventDTO> selectArrayList();

}
