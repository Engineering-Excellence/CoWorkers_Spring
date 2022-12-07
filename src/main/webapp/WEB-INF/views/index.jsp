<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, height=device-height initial-scale=1">
    <title>CoWorkers</title>
    <link rel="icon" href="./images/favicon_16.png">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
</head>
<body>
<fmt:requestEncoding value="UTF-8"/>
<!-- Terry - index(로그인) jsp 파일 -->

<div id="wrap" class="wrap">
    <div class="main-top">
        <header id="header" class="header">Crunch Mode</header>
    </div>
    <div id="container" class="container">
        <form action="loginOK.sil" method="post">
            <p>CO-WORKERS</p>
            <hr width="650">
            <table width="650" border="2" cellpadding="5" cellspacing="0">
                <tr>
                    <th class="thTag">아이디</th>
                    <td class="tdTag">
                        <input id="accountID" class="form-control" type="text" name="accountID"
                               autocomplete="off"></input>
                    </td>
                </tr>
                <tr>
                    <th class="thTag">비밀번호</th>
                    <td class="tdTag">
                        <input id="accountPassword" class="form-control" type="password" name="accountPassword">
                    </td>
                </tr>
                <tr>
                    <td id="tdTag2" colspan="2" width="500" align="center">
                        <input id="submit" class="btn btn-primary" type="submit" value="로그인"></input>
                        <input class="btn btn-success" type="button" value="회원가입" width="120"
                               onclick="location.href='registerForm.sil'"></input>
                        <!-- <input class="btn btn-warning" type="button" value="ID/PW 찾기" width="120" onclick="location.href='idPwFind.sil'"></input> -->
                        <!-- ID/PW찾기 추후 업데이트 -->
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<script type="text/javascript" src="./js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
</body>
</html>