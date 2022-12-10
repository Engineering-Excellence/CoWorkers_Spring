package com.crunch.service;

import com.crunch.domain.UserInfoDTO;

import java.util.List;

public interface UserInfoService {

    void insert(UserInfoDTO userInfoDTO);

    String compareID(String accountID);

    String comparePW(String accountPassword);

    List<UserInfoDTO> select(String accountID);

}
