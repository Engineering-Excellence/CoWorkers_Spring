<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, height=device-height initial-scale=1">
    <title>회원가입</title>
    <link rel="icon" href="/images/favicon_16.png">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/registerForm.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

</head>
<body>

<!-- Terry - registerForm(회원가입) jsp 파일 -->

<div id="container" class="container">
    <form action="registerOK" method="post" onsubmit="return joinCheck(this)">
        <table class="table table-hover table-bordered" style="border: 1px solid gray">
            <thead>
            <tr>
                <th colspan="3">
                    <h2 id="h2">회원가입</h2>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th class="th1">아이디</th>
                <td>
                    <input id="accountID" class="form-control" type="text" name="accountID"
                           placeholder="가입할 ID를 입력해주세요." autocomplete="off">
                    <button id="btnId" class="btn btn-primary" type="button" onclick="idCheck()">ID 체크</button>
                </td>
            </tr>
            <tr>
                <th class="th1">비밀번호</th>
                <td colspan="2">
                    <input id="accountPassword" class="form-control" type="password" name="accountPassword"
                           placeholder="비밀번호를 입력해주세요." maxlength="18" onkeyup="pwCheck()">
                </td>
            </tr>
            <tr>
                <th class="th1">비밀번호 확인</th>
                <td colspan="2">
                    <input id="accountPassword2" class="form-control" type="password" name="accountPassword2"
                           placeholder="비밀번호를 한번 더 입력해주세요." maxlength="18" onkeyup="pwCheck()">
                </td>
            </tr>
            <tr>
                <th class="th1">성함</th>
                <td colspan="2">
                    <input id="userName" class="form-control" type="text" name="userName" placeholder="이름을 입력해주세요."
                           autocomplete="off" onkeyup="nameCheck()">
                </td>
            </tr>
            <tr>
                <th class="th1">주민등록번호</th>
                <td colspan="2">
                    <input id="registerNumber" class="form-control" type="text" name="registerNumber" maxlength="13"
                           placeholder="주민등록번호 13자리를 입력해주세요" autocomplete="off">
                    <button id="registerCheck" class="btn btn-primary" type="button" name="registerCheck"
                            onclick="regCheck()">유효검사
                    </button>
                </td>
            </tr>
            <tr>
                <th class="th1">휴대전화 번호</th>
                <td colspan="2">
                    <input id="mobileNumber" class="form-control" type="text" name="mobileNumber"
                           placeholder="' - ' 을 제외한 휴대전화 번호를 입력해주세요." autocomplete="off" onkeyup="mobileCheck()">
                </td>
            </tr>
            <tr>
                <th class="th1">성별</th>
                <td colspan="2" align="center">
                    <input class="gender" type="radio" name="gender" value="male" autocomplete="off" checked="checked">남자
                    <input class="gender" type="radio" name="gender" value="female" autocomplete="off">여자
                </td>
            </tr>
            <tr>
                <th class="th1">이메일</th>
                <td colspan="2">
                    <input id="email" class="form-control" type="text" name="email" placeholder="이메일을 입력해주세요."
                           autocomplete="off">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <h5 id="idCheckMsg" style="color: green; font-weight: bold;"></h5>
                    <h5 id="pwCheckMsg" style="color: red; font-weight: bold;"></h5>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button class="btn btn-success" type="submit">가입하기</button>
                    <button class="btn btn-warning" type="reset">다시쓰기</button>
                    <button class="btn btn-secondary" type="button" onclick="history.back()">돌아가기</button>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>

<script type="text/javascript" src="/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/registerForm.js"></script>
</body>
</html>