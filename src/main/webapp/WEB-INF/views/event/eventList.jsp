<%@page import="java.util.Date" %>
<%@page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>The list of events</title>
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
            <a class="navbar-brand" href="mainView.sil">coWorkers</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">프로필</a></li>
                <li><a href="#">환경설정</a></li>
                <li><a href="logout.sil">로그아웃</a></li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- 좌측 사이드 -->
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li><a href="board.sil">게시글</a></li>
                <li><a href="work.sil">업무관리</a></li>
                <li><a href="event.sil">일정관리</a></li>
                <li><a href="file">자료실</a></li>
            </ul>
        </div>


        <!-- 리스트 제목 -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <!-- 업무_긴급 일정 테이블 -->
            <br/>
            <div style="float: right">
                <button type="button" class="btn btn-default" onclick="location.href='event.sil'">캘린더</button>
            </div>
            <h1 class="page-header">일정리스트</h1>
            <br/>
            <h3 class="sub-header">긴급 일정</h3>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th style="text-align: center;">업무No.</th>
                        <th style="text-align: center;">제목</th>
                        <th style="text-align: center;">색상</th>
                        <th style="text-align: center;">작성자</th>
                        <th style="text-align: center;">구분</th>
                        <th style="text-align: center;">시작일</th>
                        <th style="text-align: center;">종료일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 테이블이 비어있는 경우 -->
                    <c:if test="${wList.size() == 0}">
                        <tr>
                            <td colspan="7">
                                <marquee>일정이 없습니다.</marquee>
                            </td>
                        </tr>
                    </c:if>
                    <!-- 업무 글 출력. -->
                    <c:if test="${wList.size() != 0}">


                        <!-- 110행 실행을 위해 107행 어제날짜를 구한다. (오늘 날짜로 대입하면 deadline이 오늘 날짜인 것도 표시하지 않기 때문. -->
                        <c:set var="yesterday" value="<%= new Date(new Date().getTime() - 60*60*24*1000) %>"/>
                        <c:forEach var="wDTO" items="${wList}">
                            <c:if test="${dto.deleteDate!=null}">
                            </c:if>
                            <c:if test="${wDTO.priority == 1 && wDTO.deleteDate ==null}">
                                <c:if test="${wDTO.deadline.after(yesterday)}">
                                    <tr>
                                        <td align="center">
                                            <c:out value="${wDTO.workID}"/>
                                        </td>
                                        <td>
                                            <c:set var="wSubject" value="${fn:replace(wDTO.subject, '<', '&lt;')}"/>
                                            <c:set var="wSubject" value="${fn:replace(wSubject, '>', '&gt;')}"/>
                                            <a href="workView.sil?workID=${wDTO.workID}&currentPage=1">${wSubject}</a>
                                        </td>
                                        <td align="center">
                                            <c:if test="${wDTO.priority == 1}">
                                                <span style="color: tomato">[긴급]</span><img name="#DC143C" alt="red"
                                                                                            src="images/impt_DC143C.png"
                                                                                            width="15px">
                                            </c:if>
                                            <c:if test="${wDTO.priority == 2}">
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img name="#FAFFCD" alt="yellow" src="images/yellow_FAFFCD.png" width="15px">
                                            </c:if>
                                            <c:if test="${wDTO.priority == 3}">
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img name="#CDFFBE" alt="green" src="images/green_CDFFBE.png" width="15px">
                                            </c:if>
                                            <c:if test="${wDTO.priority == 4}">
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img name="#E1E1E0" alt="gray" src="images/gray_E1E1E0.png" width="15px">
                                            </c:if>
                                        </td>

                                        <td align="center">
                                            <c:set var="userName" value="${fn:replace(wDTO.userName, '<', '&lt;')}"/>
                                            <c:set var="userName" value="${fn:replace(userName, '>', '&gt;')}"/>
                                                ${userName}
                                        </td>
                                        <td align="center">
                                            <c:if test="${wDTO.priority == 1}">
                                                업무
                                            </c:if>
                                        </td>
                                        <td align="center">
                                            <fmt:formatDate value="${wDTO.startDate}" pattern="MM.dd(E)"/>
                                                ${startDate}
                                        </td>
                                        <td align="center">
                                            <fmt:formatDate value="${wDTO.deadline}" pattern="MM.dd(E)"/>
                                                ${deadline}
                                        </td>
                                    </tr>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <br/>
            <!-- 일정 리스트 테이블. -->
            <h3 class="sub-header">일정 리스트</h3>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th style="text-align: center;">#</th>
                        <th style="text-align: center;">제목</th>
                        <th style="text-align: center;">색상</th>
                        <th style="text-align: center;">작성자</th>
                        <th style="text-align: center;">구분</th>
                        <th style="text-align: center;">시작일</th>
                        <th style="text-align: center;">종료일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="eDTO" items="${eList}" varStatus="status">
                        <c:if test="${eDTO.deleteDate!=null}">
                        </c:if>
                        <c:if test="${eDTO.deleteDate==null}">
                            <tr>
                                <td align="center">
                                        ${status.count}
                                </td>
                                <td>
                                    <c:if test="${eDTO.deleteDate!=null}"></c:if>
                                    <c:if test="${eDTO.deleteDate==null}">
                                        <c:set var="eSubject" value="${fn:replace(eDTO.subject, '<', '&lt;')}"/>
                                        <c:set var="eSubject" value="${fn:replace(eSubject, '>', '&gt;')}"/>
                                        <a href="eventView.sil?eventID=${eDTO.eventID}">${eSubject}</a>
                                    </c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${eDTO.deleteDate!=null}"></c:if>
                                    <c:if test="${eDTO.deleteDate==null}">
                                        <c:if test="${eDTO.eventColor.equals('#E1E1E0')}">
                                            <span style="color: darkgray; ">[낮음]</span> <img name="#E1E1E0" alt="gray"
                                                                                             src="images/gray_E1E1E0.png"
                                                                                             width="15px">
                                        </c:if>
                                        <c:if test="${eDTO.eventColor.equals('#CDFFBE')}">
                                            <span style="color: #CDFFBE; ">[보통]</span> <img name="#CDFFBE" alt="green"
                                                                                            src="images/green_CDFFBE.png"
                                                                                            width="15px">
                                        </c:if>
                                        <c:if test="${eDTO.eventColor.equals('#FFCDCD')}">
                                            <span style="color: #FFCDCD; font-weight: bold;">[긴급]</span> <img
                                                name="#FFCDCD" alt="red" src="images/red_FFCDCD.png" width="15px">
                                        </c:if>
                                        <c:if test="${eDTO.eventColor.equals('#FAFFCD')}">
                                            <span style="color: yellow; ">[높음]</span> <img name="#FAFFCD" alt="yellow"
                                                                                           src="images/yellow_FAFFCD.png"
                                                                                           width="15px">
                                        </c:if>
                                    </c:if>
                                </td>

                                <td align="center">
                                    <c:if test="${eDTO.deleteDate!=null}"></c:if>
                                    <c:if test="${eDTO.deleteDate==null}">
                                        <c:set var="userName" value="${fn:replace(eDTO.userName, '<', '&lt;')}"/>
                                        <c:set var="userName" value="${fn:replace(userName, '>', '&gt;')}"/>
                                        ${userName}
                                    </c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${eDTO.deleteDate!=null}"></c:if>
                                    <c:if test="${eDTO.deleteDate==null}">
                                        <c:if test="${ eDTO.allDay == 'true'}">
                                            종일
                                        </c:if>
                                    </c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${eDTO.deleteDate!=null}"></c:if>
                                    <c:if test="${eDTO.deleteDate==null}">
                                        <fmt:formatDate value="${eDTO.startDate}" pattern="MM.dd(E)"/>
                                        ${startDate}
                                    </c:if>
                                </td>
                                <td align="center">
                                    <c:if test="${eDTO.deleteDate!=null}"></c:if>
                                    <c:if test="${eDTO.deleteDate==null}">
                                        <fmt:formatDate value="${eDTO.endDate}" pattern="MM.dd(E)"/>
                                        ${endDate}
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
                <br/>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/event/event.js"></script>
</body>
</html>