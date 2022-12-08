package com.crunch.service;

import com.crunch.domain.UserInfoDTO;

import java.util.List;

public interface UserInfoService {

    void userInfoInsert(UserInfoDTO userInfoDTO);

    String userInfoCompareID(String accountID);

    String userInfoComparePW(String accountPassword);

    List<UserInfoDTO> userInfoSelect(String accountID);

}
