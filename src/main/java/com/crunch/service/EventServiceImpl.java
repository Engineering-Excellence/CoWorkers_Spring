package com.crunch.service;

import com.crunch.domain.EventDTO;
import com.crunch.domain.WorkDTO;
import com.crunch.mapper.EventMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class EventServiceImpl implements EventService {

    @Setter(onMethod_ = @Autowired)
    private EventMapper mapper;

    @Override
    public void insert(EventDTO eventDTO) {

        log.info("EventServiceImpl의 insert() 실행");

        log.info("insert : {}", eventDTO);
        mapper.insert(eventDTO);
    }

    @Override
    public int selectCount() {

        log.info("EventServiceImpl의 selectCount() 실행");

        return mapper.selectCount();
    }


    @Override
    public List<EventDTO> selectEList() {

        log.info("EventServiceImpl의 selectEList() 실행");

        return mapper.selectEList();
    }

    @Override
    public List<WorkDTO> selectWList() {

        log.info("EventServiceImpl의 selectEList() 실행");

        return mapper.selectWList();
    }

    @Override
    public EventDTO selectByEventID(int eventID) {
        return mapper.selectByEventID(eventID);
    }

    @Override
    public boolean update(EventDTO eventDTO) {
        return mapper.update(eventDTO);
    }

    @Override
    public boolean delete(int eventID) {
        return mapper.delete(eventID);
    }

    // 페이징 작업이 필요한 경우 작성. (댓글 기능 추가시)
//    @Override
//    public List<EventDTO> selectArrayList() {
//        return null;
//    }

}
