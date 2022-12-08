package com.crunch.controller;

import com.crunch.domain.UserInfoDTO;
import com.crunch.service.UserInfoService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.List;

@Controller
@AllArgsConstructor
@SessionAttributes("userInfo")
@Slf4j
public class UserInfoController {

    private UserInfoService service;
    private UserInfoDTO userInfoDTO;

    @RequestMapping(value = "/")
    public String login(Model model) {

        log.info("UserInfoController의 login() 실행");

        return "/userInfo/login";
    }

    @RequestMapping(value = "loginOK")
    public String loginOK(Model model,
                          @RequestParam("accountID") String accountID,
                          @RequestParam("accountPassword") String accountPassword) {

        log.info("UserInfoController의 loginOK() 실행");

        log.info("accountID: {}, accountPassword: {}", accountID, accountPassword);
        String originID = service.userInfoCompareID(accountID);
        log.info("originID: {}", originID);
        String originPassword = service.userInfoComparePW(accountID);
        log.info("originPassword: {}", originPassword);

        if (accountID !=null && accountID.equals(originID)) {
            log.info("accountID.equals(originID)");
            if (accountPassword !=null && accountPassword.equals(originPassword)) {
                log.info("accountPassword.equals(originPassword)");

                userInfoDTO.setAccountID(accountID);
                log.info("userInfoDTO: {}", userInfoDTO);

                List<UserInfoDTO> userInfo = service.userInfoSelect(accountID);

                model.addAttribute("userInfoDTO", userInfoDTO);
                model.addAttribute("userInfo", userInfo);

                log.info("userInfo: {}", userInfo);
                log.info("model: {}", model);


                return "userInfo/mainView";
            } else {
                model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
                return "userInfo/login";
            }
        } else {
            model.addAttribute("msg", "아이디가 틀렸습니다.");
            return "redirect:login";
        }

    }



}
