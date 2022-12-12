<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Event updating</title>
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
            </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">일정 보기</h1>
            <br/>
            <br/>
            <div style="float: right ">
                <button type="button" class="btn btn-default" onclick="location.href='event'">캘린더</button>
                <button type="button" class="btn btn-primary" onclick="location.href='eventList'">리스트</button>
            </div>
            <div><br/></div>
            <div class="table-reponsive">
                <form action="eventUpdateOK?eventID=${eDTO.eventID}" method="post">
                    <table class="table">
                        <tr class="table-primary">
                            <th colspan="3" style="font-size: 30px; text-align: center;">일정 작성</th>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input id="subject" type="text"
                                       class="form-control"
                                       width="80%"
                                       name="subject" autocomplete="none"
                                       value="${eDTO.subject}"/>
                            </td>
                        </tr>
                        <tr>
                            <th class="align-middle table-dark" width="30px">
                                <label for="eventColor">색상</label>
                            </th>
                            <td class="align-middle" colspan="2">
                                <c:if test="${eDTO.eventColor.equals('#E1E1E0')}">
                                    <select id="eventColor" name="eventColor"
                                    >
                                        <option value="#E1E1E0" selected="selected">
                                            gray<img name="#E1E1E0" alt="gray" src="images/gray_E1E1E0.png"
                                                     width="15px">
                                        </option>
                                        <option value="#CDFFBE">
                                            green<img name="#CDFFBE" alt="green" src="images/green_CDFFBE.png"
                                                      width="15px">
                                        </option>
                                        <option value="#FFCDCD">
                                            red<img name="#FFCDCD" alt="red" src="images/red_FFCDCD.png" width="15px">
                                        </option>
                                        <option value="#FAFFCD">
                                            yellow<img name="#FAFFCD" alt="yellow" src="images/yellow_FAFFCD.png"
                                                       width="15px">
                                        </option>
                                    </select>
                                    <img alt="gray" src="images/gray_E1E1E0.png" width="15px">
                                </c:if>
                                <c:if test="${eDTO.eventColor.equals('#CDFFBE')}">
                                    <select id="eventColor" name="eventColor"
                                    >
                                        <option value="#E1E1E0">
                                            gray<img name="#E1E1E0" alt="gray" src="images/gray_E1E1E0.png"
                                                     width="15px">
                                        </option>
                                        <option value="#CDFFBE" selected="selected">
                                            green<img name="#CDFFBE" alt="green" src="images/green_CDFFBE.png"
                                                      width="15px">
                                        </option>
                                        <option value="#FFCDCD">
                                            red<img name="#FFCDCD" alt="red" src="images/red_FFCDCD.png" width="15px">
                                        </option>
                                        <option value="#FAFFCD">
                                            yellow<img name="#FAFFCD" alt="yellow" src="images/yellow_FAFFCD.png"
                                                       width="15px">
                                        </option>
                                    </select>
                                    <img alt="green" src="images/green_CDFFBE.png" width="15px">
                                </c:if>
                                <c:if test="${eDTO.eventColor.equals('#FFCDCD')}">
                                    <select id="eventColor" name="eventColor"
                                    >
                                        <option value="#E1E1E0">
                                            gray<img name="#E1E1E0" alt="gray" src="images/gray_E1E1E0.png"
                                                     width="15px">
                                        </option>
                                        <option value="#CDFFBE">
                                            green<img name="#CDFFBE" alt="green" src="images/green_CDFFBE.png"
                                                      width="15px">
                                        </option>
                                        <option value="#FFCDCD" selected="selected">
                                            red<img name="#FFCDCD" alt="red" src="images/red_FFCDCD.png" width="15px">
                                        </option>
                                        <option value="#FAFFCD">
                                            yellow<img name="#FAFFCD" alt="yellow" src="images/yellow_FAFFCD.png"
                                                       width="15px">
                                        </option>
                                    </select>
                                    <img alt="red" src="images/red_FFCDCD.png" width="15px">
                                </c:if>
                                <c:if test="${eDTO.eventColor.equals('#FAFFCD')}">
                                    <select id="eventColor" name="eventColor"
                                    >
                                        <option value="#E1E1E0">
                                            gray<img name="#E1E1E0" alt="gray" src="images/gray_E1E1E0.png"
                                                     width="15px">
                                        </option>
                                        <option value="#CDFFBE">
                                            green<img name="#CDFFBE" alt="green" src="images/green_CDFFBE.png"
                                                      width="15px">
                                        </option>
                                        <option value="#FFCDCD">
                                            red<img name="#FFCDCD" alt="red" src="images/red_FFCDCD.png" width="15px">
                                        </option>
                                        <option value="#FAFFCD" selected="selected">
                                            yellow<img name="#FAFFCD" alt="yellow" src="images/yellow_FAFFCD.png"
                                                       width="15px">
                                        </option>
                                    </select>
                                    <img alt="yellow" src="images/yellow_FAFFCD.png" width="15px">
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="form-check-input"
                                       type="date"
                                       name="startDate"
                                       min="2000-01-01"
                                       max="2050-12-31"
                                       value="${eDTO.startDate}"
                                       id="startDate"
                                />
                                <!-- <input type="button" onclick="starDateChk()"> -->
                            </td>
                            <td>
                                <input id="endDate"
                                       type="date"
                                       name="endDate"
                                       min="2000-01-01"
                                       max="2050-12-31"
                                       value="${eDTO.endDate}"
                                />
                                &nbsp;&nbsp;&nbsp;
                                <c:if test="${eDTO.allDay='true'}">
                                    종일 <input class="form-check-input"
                                              type="checkbox"
                                              name="allDay"
                                              value="true"
                                              id="allDay"
                                              checked="checked"
                                />
                                </c:if>
                                <c:if test="${eDTO.allDay='false'}">
                                    종일 <input class="form-check-input"
                                              type="checkbox"
                                              name="allDay"
                                              value="true"
                                              id="allDay"
                                />
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td colspan="3">
									<textarea
                                            id="content"
                                            class="form-control form-control-sm"
                                            rows="10"
                                            name="content"
                                            style="resize: none;"
                                            placeholder="내용을 입력하세요."
                                    >${eDTO.content}</textarea>
                                <!-- <input type="button" onclick="checkConent()"> -->
                            </td>

                        </tr>
                        <tr class="table-secondary">
                            <td colspan="3" align="center">
                                <input
                                        class="btn btn-primary btn-sm"
                                        type="submit"
                                        value="저장하기"
                                        style="font-size: 13px;"
                                />
                                <input class="btn btn-default btn-sm"
                                       type="reset"
                                       value="다시쓰기"
                                       style="font-size: 13px;"
                                />
                                <input class="btn btn-default btn-sm"
                                       type="button"
                                       value="돌아가기"
                                       style="font-size: 13px;"
                                       onclick="history.back()"
                                />
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="eventID" value="${eDTO.eventID}"/>
                    <input type="hidden" name="ip" value="${pageContext.request.remoteAddr}"/>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>