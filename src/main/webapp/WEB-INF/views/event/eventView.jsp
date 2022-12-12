<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>The event</title>
    <link rel="icon" href="/images/favicon_16.png">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/coWorkers.css" rel="stylesheet">

</head>
<body>
<!-- 상단 네비게이션 -->
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

<!-- 좌측 사이드 -->
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

        <c:set var="eList" value="${eList}"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">일정 보기</h1>
            <br/>
            <br/>
            <div style="float: right ">
                <button type="button" class="btn btn-default" onclick="location.href='event'">캘린더</button>
                <button type="button" class="btn btn-primary" onclick="location.href='eventList'">리스트</button>
            </div>
            <div><br/></div>
            <br/>
            <div class="table-reponsive">
                <br/>
                <table class="table">
                    <tr class="table-primary">
                        <th colspan="3" style="font-size: 30px; text-align: center; color: gray">일정</th>
                    </tr>

                    <tr>
                        <th style="font-size: 20px; text-align: center; width: 100px;">
                            제목
                        </th>
                        <td colspan="2" style="font-size: 18px;">
                            <c:set var="eSubject" value="${fn:replace(eDTO.subject, '<', '&lt;')}"/>
                            <c:set var="eSubject" value="${fn:replace(eSubject, '>', '&gt;')}"/>
                            ${eSubject}
                        </td>
                    </tr>
                    <tr>
                        <th style="font-size: 20px; text-align: center; width: 100px;">
                            색상
                        </th>
                        <td colspan="2" style="font-size: 20px; text-align: left; width: 100px;">
                            <c:if test="${eDTO.eventColor=='#E1E1E0'}">
                                <span style="font-weight: bold;">[낮음]</span> <img alt="gray"
                                                                                  src="images/gray_E1E1E0.png"
                                                                                  width="80px" height="20px">
                            </c:if>
                            <c:if test="${eDTO.eventColor=='#CDFFBE'}">
                                <span style="font-weight: bold;">[보통]</span> <img alt="green"
                                                                                  src="images/green_CDFFBE.png"
                                                                                  width="80px" height="20px">
                            </c:if>
                            <c:if test="${eDTO.eventColor=='#FFCDCD'}">
                                <span style="color: tomato; font-weight: bold;">[긴급]</span> <img alt="red"
                                                                                                 src="images/red_FFCDCD.png"
                                                                                                 width="80px"
                                                                                                 height="20px">
                            </c:if>
                            <c:if test="${eDTO.eventColor=='#FAFFCD'}">
                                <span style="font-weight: bold;">[높음]</span> <img alt="yellow"
                                                                                  src="images/yellow_FAFFCD.png"
                                                                                  width="80px" height="20px">
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th style="font-size: 20px; text-align: center; width: 100px;">
                            기간
                        </th>
                        <td colspan="2" style="font-size: 15px; text-align: left; width: 100px;">
                            ${eDTO.startDate}&nbsp; ~ &nbsp;${eDTO.endDate} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <c:if test="${eDTO.allDay == 'true'}">
                                종일 <input class="form-check-input"
                                          type="checkbox"
                                          name="allDay"
                                          value="true"
                                          id="allDay"
                                          checked="checked"
                                          disabled="disabled"
                            />
                            </c:if>
                            <c:if test="${eDTO.allDay != 'true'}">
                                종일 <input class="form-check-input"
                                          type="checkbox"
                                          name="allDay"
                                          value="true"
                                          id="allDay"
                                          disabled="disabled"
                            />
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <th style="font-size: 20px; text-align: center; width: 100px;">
                            내용
                        </th>
                        <td colspan="2" style="font-size: 15px; text-align: left; width: 100px;">
                            <c:set var="eContent" value="${fn:replace(eDTO.content, '<', '&lt;')}"/>
                            <c:set var="eContent" value="${fn:replace(eContent, '>', '&gt;')}"/>
                            ${eContent}
                        </td>

                    </tr>
                    <tr class="table-secondary">
                        <td colspan="3" align="center">
                            <button
                                    class="btn btn-primary btn-sm"
                                    type="button"
                                    style="font-size: 13px;"
                                    onclick="location.href='eventUpdate?eventID=${eDTO.eventID}'"
                            >수정하기
                            </button>
                            <button
                                    class="btn btn-danger btn-sm"
                                    type="button"
                                    style="font-size: 13px;"
                                    onclick="location.href='eventDelete?eventID=${eDTO.eventID}'"
                            >삭제하기
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>