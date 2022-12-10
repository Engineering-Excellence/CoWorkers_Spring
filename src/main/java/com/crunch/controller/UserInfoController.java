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
import org.springframework.web.bind.support.SessionStatus;

import java.util.List;

@Controller
@AllArgsConstructor
@SessionAttributes("userInfo")
@Slf4j
@RequestMapping("/")
public class UserInfoController {

    private UserInfoService service;
    private UserInfoDTO userInfoDTO;

    @RequestMapping(value = "")
    public String login() {

        log.info("UserInfoController의 login() 실행");

        return "/userInfo/login";
    }

    @RequestMapping(value = "loginOK")
    public String loginOK(Model model,
                          @RequestParam("accountID") String accountID,
                          @RequestParam("accountPassword") String accountPassword) {

        log.info("UserInfoController의 loginOK() 실행");

        String originID = service.compareID(accountID);
        String originPassword = service.comparePW(accountID);

        if (accountID != null && accountID.equals(originID)) {

            if (accountPassword != null && accountPassword.equals(originPassword)) {

                userInfoDTO.setAccountID(accountID);
                List<UserInfoDTO> userInfo = service.select(accountID);

                model.addAttribute("userInfoDTO", userInfoDTO);
                model.addAttribute("userInfo", userInfo);

                return "userInfo/mainView";
            } else {

                model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");

                return "redirect:/";
            }
        } else {

            model.addAttribute("msg", "아이디가 틀렸습니다.");

            return "redirect:/";
        }

    }

    @RequestMapping(value = "logout")
    public String logout(SessionStatus sessionStatus) {

        log.info("UserInfoController의 logout() 실행");

        sessionStatus.setComplete();    // 세션 제거

        return "redirect:/";
    }

    @RequestMapping(value = "registerForm")
    public String registerForm() {

        log.info("UserInfoController의 registerForm() 실행");

        return "userInfo/registerForm";
    }

    @RequestMapping(value = "registerOK")
    public String registerOK(UserInfoDTO userInfoDTO) {

        log.info("UserInfoController의 registerOK() 실행");

        service.insert(userInfoDTO);

        return "redirect:/";
    }

}
