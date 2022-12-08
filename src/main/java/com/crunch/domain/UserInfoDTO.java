package com.crunch.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class UserInfoDTO {

    // Terry 로그인 및 계정 관련 DTO

    private int userID; // PK, 사원번호 - 퇴사 및 탈퇴처리 시 활용
    private String accountID; // UK, 로그인용 ID -- User간 ID 중복 불가
    private String accountPassword; // 로그인용 Password -- 개인정보 수정 + 탈퇴 시 활용 목적
    private String userName; // 사원명
    private String registerNumber; // UK, 주민등록번호 -- 회원가입 시 주민등록번호 유효성 검사 + 탈퇴 시 이용
    private String mobileNumber; // UK, 휴대폰 번호 -- 회원가입 시 인증 및 ID/PW 찾기 용도
    private String gender; // 사원 성별
    private String email; // 사원 메일 -- 임시비밀번호 설정 메일 송부에 사용
    private java.sql.Date joinDate; // 계정 입사일자
    private java.sql.Date retireDate; // 계정 탈퇴일자 -- 개인정보 보존 용도(결제 관련 5년, 일반 정보는 보존기간 3년)
    private int positionCode; // FK, 직급코드

}
