package com.crunch.service;

import com.crunch.domain.EventDTO;
import com.crunch.domain.WorkDTO;
import com.crunch.mapper.EventMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class EventServiceImpl implements EventService {

    @Setter(onMethod_ = @Autowired)
    private EventMapper mapper;

    @Override
    public void insert(EventDTO eventDTO) {

    }

    @Override
    public int selectCount() {
        return 0;
    }

    @Override
    public List<EventDTO> selectList(HashMap<String, Integer> hashMap) {
        return null;
    }

    @Override
    public List<EventDTO> selectArrayList() {
        return null;
    }

    @Override
    public List<EventDTO> selectEList() {
        return null;
    }

    @Override
    public List<WorkDTO> workSelectArrayList() {
        return null;
    }

    @Override
    public EventDTO selectByEventID(int eventID) {
        return null;
    }

    @Override
    public boolean update(EventDTO eventDTO) {
        return false;
    }

    @Override
    public boolean delete(int eventID) {
        return false;
    }

}
