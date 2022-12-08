package com.crunch.service;

import com.crunch.domain.UserInfoDTO;
import com.crunch.mapper.UserInfoMapper;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class UserInfoServiceImpl implements UserInfoService {

    // 인스턴스 변수(mapper)에 알맞은 타입의 객체(UserInfoMapper)를 자동으로 주입하는 어노테이션
    @Setter(onMethod_ = @Autowired)
    private UserInfoMapper mapper;

    @Override
    public void userInfoInsert(UserInfoDTO userInfoDTO) {

        log.info("UserInfoServiceImpl의 userInfoInsert() 실행");

        mapper.userInfoInsert(userInfoDTO);
    }

    @Override
    public String userInfoCompareID(String accountID) {

        log.info("UserInfoServiceImpl의 userInfoCompareID() 실행");

        return mapper.userInfoCompareID(accountID);
    }

    @Override
    public String userInfoComparePW(String accountPassword) {

        log.info("UserInfoServiceImpl의 userInfoComparePW() 실행");

        return mapper.userInfoComparePW(accountPassword);
    }

    @Override
    public List<UserInfoDTO> userInfoSelect(String accountID) {

        log.info("UserInfoServiceImpl의 userInfoComparePW() 실행");

        return mapper.userInfoSelect(accountID);
    }
}
