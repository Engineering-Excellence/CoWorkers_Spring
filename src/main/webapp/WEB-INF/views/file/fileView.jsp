<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Kyle --%>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/images/favicon_16.png">

    <title>CoWorkers</title>

    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/coWorkers.css" rel="stylesheet">

</head>

<body>

<%
    request.setCharacterEncoding("UTF-8");
    System.out.println(pageContext.findAttribute("fileDTO"));

    Map<String, String[]> map = request.getParameterMap();
    for (Map.Entry<String, String[]> entry : map.entrySet()) {
        System.out.printf("%s : %s%n", entry.getKey(), String.join(", ", entry.getValue()));
    }
%>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="mainView">coWorkers</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">프로필</a></li>
                <li><a href="#">환경설정</a></li>
                <li><a href="logout">로그아웃</a></li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li><a href="board">게시글</a></li>
                <li><a href="work">업무관리</a></li>
                <li><a href="event">일정관리</a></li>
                <li><a href="file">자료실</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">게시판</h1>

            <div class="table table-responsive">
                <table class="table table-striped" style="width: 100%; margin-left: auto; margin-right: auto;">
                    <tr class="table-primary">
                        <th colspan="4" style="font-size: 30px; text-align: center;">게시글 보기</th>
                    </tr>
                    <tr class="table-dark">
                        <th style="width: 100px; text-align: center;">글번호</th>
                        <th style="width: 350px; text-align: center;">이름</th>
                        <th style="width: 150px; text-align: center;">작성일</th>
                        <th style="width: 100px; text-align: center;">조회수</th>
                    </tr>
                    <tr>
                        <td align="center">
                            ${fileDTO.fileID}
                        </td>
                        <td align="center">
                            <c:set var="userName" value="${fn:replace(fileDTO.userName, '<', '&lt;')}"/>
                            <c:set var="userName" value="${fn:replace(userName, '>', '&gt;')}"/>
                            ${userName}
                        </td>
                        <td align="center">
                            <jsp:useBean id="date" class="java.util.Date"/>
                            <c:if test="${date.year == fileDTO.writeDate.year && date.month == fileDTO.writeDate.month &&
						date.date == fileDTO.writeDate.date && fileDTO.deleteDate == null && fileDTO.updateDate == null}">
                                <fmt:formatDate value="${fileDTO.writeDate}" pattern="a h:mm"/>
                            </c:if>
                            <c:if test="${date.year != fileDTO.writeDate.year || date.month != fileDTO.writeDate.month ||
						date.date != fileDTO.writeDate.date && fileDTO.deleteDate == null && fileDTO.updateDate == null}">
                                <fmt:formatDate value="${fileDTO.writeDate}" pattern="yyyy.MM.dd(E)"/>
                            </c:if>
                        </td>
                        <td align="center">
                            ${fileDTO.hit}
                        </td>
                    </tr>
                    <tr>
                        <th style="text-align: center">제목</th>
                        <td colspan="3">
                            <c:if test="${fileDTO.deleteDate == null}">
                                <c:set var="subject" value="${fn:replace(fileDTO.subject, '<', '&lt;')}"/>
                                <c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
                                ${subject}
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th class="align-middle" style="text-align: center; height: 300px;">내용</th>
                        <td colspan="3">
                            <c:if test="${fileDTO.deleteDate == null}">
                                <c:set var="content" value="${fn:replace(fileDTO.content, '<', '&lt;')}"/>
                                <c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
                                <c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
                                ${content}
                            </c:if>
                        </td>
                    </tr>
                    <tr class="table-secondary">
                        <td colspan="4" align="center">
                            <c:if test="${userInfo.get(0).getUserID() == fileDTO.userID}">
                                <input
                                        class="btn btn btn-primary btn-sm btn-sm"
                                        type="button"
                                        value="수정하기"
                                        style="font-size: 13px;"
                                        onclick="location.href=('fileUpdate?fileID=${fileDTO.fileID}&currentPage=${currentPage}')"/>
                                <input
                                        class="btn btn-danger btn-sm"
                                        type="button"
                                        value="삭제하기"
                                        style="font-size: 13px;"
                                        onclick="deleteCheck('fileDelete?fileID=${fileDTO.fileID}&currentPage=${currentPage}&userID=${userInfo.get(0).getUserID()}')"/>
                            </c:if>
                            <input
                                    class="btn btn-info btn-sm"
                                    type="button"
                                    value="돌아가기"
                                    style="font-size: 13px;"
                                    onclick="location.href='file?currentPage=${currentPage}'"
                            />
                        </td>
                    </tr>
                </table>
            </div>

            <hr style="margin-left: auto; margin-right: auto;"/>

                </table>
                <input type="hidden" id="userID" name="userID" value="${userInfo.get(0).getUserID()}">
            </form>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/board.js"></script>
</body>

</html>