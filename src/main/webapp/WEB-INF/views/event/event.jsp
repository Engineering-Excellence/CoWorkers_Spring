<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.Date" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">

    <link rel="icon" href="/images/favicon_16.png">
    <title>Event</title>

    <link href="/css/event.css" rel="stylesheet">
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <style>
        td {
            padding: 0px;
        }
    </style>
</head>

<body onload="javascript:autoReload()">

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
        <!-- 좌측 사이드 -->
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li><a href="board">게시글</a></li>
                <li><a href="work">업무관리</a></li>
                <li><a href="event">일정관리</a></li>
            </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">일정 관리</h1>
            <div class="table-reponsive">
                <div style="display: inline;">
                    <a id="before" href="javascript:lastMonth()"><img width="30px" alt="지난달"
                                                                      src="/images/arrow_left.png"></a>
                </div>
                <div id="yearmonth" style="display: inline; font-size: 30px"></div>

                <div style="display: inline;">
                    <a id="next" title="다음달" href="javascript:nextMonth()"><img width="30px" alt="다음달"
                                                                                src="/images/arrow_right.png"></a>
                </div>
                <div style="float: right ">
                    <!-- 모달 실행 버튼 -->
                    <button type="button" class="btn btn-default" onclick="showWork(${wDTO})">긴급업무</button>
                    <button type="button" class="btn btn-default" onclick="showEvent(${eDTO})">일정</button>
                    <button type="button" class="btn btn-default" onclick="thisMonth()">오늘</button>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">일정추가
                    </button>
                    <button type="button" class="btn btn-default" onclick="location.href='eventList'">리스트보기</button>
                </div>
            </div>

            <br/>
            <br/>

            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th id="sunday" width="100" height="40"><span
                                style="font-weight: bold; font-size: 15px;">일</span></th>
                        <th width="100px"><span style="font-weight: bold; font-size: 15px;">월</span></th>
                        <th width="100px"><span style="font-weight: bold; font-size: 15px;">화</span></th>
                        <th width="100px"><span style="font-weight: bold; font-size: 15px;">수</span></th>
                        <th width="100px"><span style="font-weight: bold; font-size: 15px;">목</span></th>
                        <th width="100px"><span style="font-weight: bold; font-size: 15px;">금</span></th>
                        <th width="100px" id="saturday" style="font-weight: bold;"><span>토</span></th>
                    </tr>
                    </thead>
                    <tbody id="calendar">
                    <!-- event.js 파일로 날짜 출력 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<br/><br/>


<!-- Modal_insert -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form action="event" method="post">
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
                                       placeholder="제목을 입력하세요."/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="text" name="userName" value="${userInfo.get(0).getUserName()}" readonly/>
                            </td>
                        </tr>
                        <tr>
                            <th class="align-middle table-dark" width="30px">
                                <label for="eventColor">색상</label>
                            </th>
                            <td class="align-middle" colspan="2">
                                <select id="eventColor" name="eventColor"
                                        onchange="selectBoxChgColor(value);">
                                    <option value="#E1E1E0">
                                        낮음<img name="#E1E1E0" alt="gray" src="/images/gray_E1E1E0.png" width="15px">
                                    </option>
                                    <option value="#CDFFBE">
                                        보통<img name="#CDFFBE" alt="green" src="/images/green_CDFFBE.png" width="15px">
                                    </option>
                                    <option value="#FAFFCD">
                                        높음<img name="#FAFFCD" alt="yellow" src="/images/yellow_FAFFCD.png"
                                               width="15px">
                                    </option>
                                    <option value="#FFCDCD">
                                        긴급<img name="#FFCDCD" alt="red" src="/images/red_FFCDCD.png" width="15px">
                                    </option>
                                </select>

                                <img alt="gray" src="/images/gray_E1E1E0.png" width="15px">
                                <img alt="green" src="/images/green_CDFFBE.png" width="15px">
                                <img alt="yellow" src="/images/yellow_FAFFCD.png" width="15px">
                                <img alt="red" src="/images/red_FFCDCD.png" width="15px">
                                <!-- <input class="form-check-input"
                                        type="checkbox"
                                        name="isAllDay"
                                        value="yes"
                                /> -->
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="form-check-input"
                                       type="date"
                                       name="startDate"
                                       min="2000-01-01"
                                       max="2050-12-31"
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
                                />
                                &nbsp;&nbsp;&nbsp;
                                종일 <input class="form-check-input"
                                          type="checkbox"
                                          name="allDay"
                                          value="true"
                                          id="allDay"
                            />
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
                     ></textarea>
                                <!-- <input type="button" onclick="checkConent()"> -->
                            </td>

                        </tr>
                        <tr class="table-secondary">
                            <td colspan="3" align="center">
                                <input
                                        class="btn btn-outline-primary btn-sm"
                                        type="submit"
                                        value="등록하기"
                                        style="font-size: 13px;"
                                />
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="ip" value="${pageContext.request.remoteAddr}"/>
                    <input type="hidden" name="userID" value="${userInfo.get(0).getUserID()}"/>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/event/event.js"></script>

<!--        // 사이 날짜 배열로 반환 함수
       function BetweenDates( startDate, endDate ) {
          let result = [];
          let btdate = new Date(startDate);
          while(btdate <= new Date(endDate)){
             result.push(btdate.toISOString().split("T")[0]);
             btdate.setDate(btdate.getDate() + 1);
             //console.log(result);
          }
          return result
       }  -->
</body>
</html>