<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 조우철 --%>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CoWorkers</title>

    <link rel="icon" href="images/favicon_16.png">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/coWorkers.css" rel="stylesheet">
</head>

<body>

<fmt:requestEncoding value="UTF-8"/>
<c:set var="date" value="${Date(Date().getTime()-60*60*24*1000)}"/>
<c:set var="dday" value="${Date(Date().getTime()+60*60*24*1000)}"/>
<%
    //    System.out.println(pageContext.findAttribute("dto"));
//
//    Map<String, String[]> map = request.getParameterMap();
//    Iterator<Map.Entry<String, String[]>> itr = map.entrySet().iterator();
//    while (itr.hasNext()) {
//        Map.Entry<String, String[]> entry = itr.next();
//        System.out.println(String.format("%s : %s", entry.getKey(), String.join(", ", entry.getValue())));
//    }
    pageContext.setAttribute("enter", "\r\n");
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
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="table-responsive">
                <form action="workUpdate" method="post">
                    <table class="table" style="width:1500px; margin-left: auto; margin-right: auto;">
                        <c:if test="${dto.deleteDate!=null}">
                            <b style="font-size: 50px; color: crimson">삭제된 글입니다.</b>
                            </br>
                            <img src="images/thief.png" alt="thief" style="width: 600px">
                        </c:if>
                        <c:if test="${dto.deleteDate==null}">
                        <tr class="bg-info">
                            <th colspan="15" style="font-size: 30px; text-align: center;">업무</th>
                        </tr>
                        <tr class="bg-primary">
                            <th class="align-middle table-dark" style="width: 100px; text-align: center;">글번호</th>
                            <th class="align-middle table-dark" style="width: 100px; text-align: center;">우선순위</th>
                            <th class="align-middle table-dark" style="width: 100px; text-align: center;">상태</th>
                            <th class="align-middle table-dark" style="width: 200px; text-align: center;">담당자</th>
                            <th class="align-middle table-dark" style="width: 200px; text-align: center;">진척도</th>
                            <th class="align-middle table-dark" style="width: 300px; text-align: center;">작성(수정)일</th>
                            <th class="align-middle table-dark" style="width: 200px; text-align: center;">시작일</th>
                            <th class="align-middle table-dark" style="width: 200px; text-align: center;">마감일</th>
                        </tr>
                        <c:set var="list" value="${workList.list}"/>

                        <tr>
                            <td align="center">${dto.workID}</td>
                            <td align="center">
                                <c:if test="${dto.priority==1}">
                                    <b style="color: crimson">긴급</b>
                                </c:if>
                                <c:if test="${dto.priority==2}">
                                    <b style="color: violet">높음</b>
                                </c:if>
                                <c:if test="${dto.priority==3}">
                                    <b style="color: limegreen">보통</b>
                                </c:if>
                                <c:if test="${dto.priority==4}">
                                    <b style="color: darkgray">낮음</b>
                                </c:if>
                            </td>
                            <td align="center">
                                <c:if test="${dto.currentProgress==1}">
                                    <img width="15" src="images/sug.png">요청됨
                                </c:if>
                                <c:if test="${dto.currentProgress==2}">
                                    <img width="15" src="images/on.png">진행중
                                </c:if>
                                <c:if test="${dto.currentProgress==3}">
                                    <img width="15" src="images/fin.png">완료됨
                                </c:if>
                            </td>
                            </td>
                            </td>
                            <td align="center">
                                <c:set var="userName" value="${fn:replace(dto.userName, '<', '&lt;')}"/>
                                <c:set var="userName" value="${fn:replace(userName, '>', '&gt;')}"/>
                                    ${userName}
                            </td>
                            <td align="center">
                                <c:if test="${dto.workProgress!=10}">
                                    <c:if test="${dto.workProgress<5}">
                                        <div style="height: 5px;width:${dto.workProgress*10}px;background-color:red;"></div>
                                    </c:if>
                                </c:if>
                                <c:if test="${dto.workProgress!=10}">
                                    <c:if test="${dto.workProgress>=5}">
                                        <div style="height: 5px;width:${dto.workProgress*10}px;background-color:orange;"></div>
                                    </c:if>
                                </c:if>
                                <c:if test="${dto.workProgress==10}">
                                    <div style="height: 5px;width: ${dto.workProgress*10}px;background-color:springgreen;"></div>
                                </c:if>
                                    ${dto.workProgress*10}%
                            </td>
                            </td>
                            <td align="center">
                                <c:if test="${dto.deleteDate==null}">
                                    <c:if test="${dto.updateDate == null}">
                                        <c:if test="${dto.writeDate.year==date.year&&dto.writeDate.month==date.month&&dto.writeDate.date==date.date}">
                                            <fmt:formatDate value="${dto.writeDate}" pattern="a h:mm:ss"/>
                                        </c:if>
                                        <c:if test="${dto.writeDate.year!=date.year||dto.writeDate.month!=date.month||dto.writeDate.date!=date.date}">
                                            <fmt:formatDate value="${dto.writeDate}" pattern="yyyy.MM.dd.(E)"/>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${dto.updateDate != null}">
                                        <c:if test="${dto.updateDate.year==date.year&&dto.updateDate.month==date.month&&dto.updateDate.date==date.date}">
                                            (수정됨)
                                            <fmt:formatDate value="${dto.updateDate}" pattern="a h:mm:ss"/>
                                        </c:if>
                                        <c:if test="${dto.updateDate.year!=date.year||dto.updateDate.month!=date.month||dto.updateDate.date!=date.date}">
                                            (수정됨)
                                            <fmt:formatDate value="${dto.updateDate}" pattern="yyyy.MM.dd.(E)"/>
                                        </c:if>
                                    </c:if>
                                </c:if>
                            </td>
                            </td>
                            <td align="center">
                                <fmt:formatDate value="${dto.startDate}" pattern="yyyy.MM.dd.(E)"/>
                            </td>
                            <td align="center">
                                <c:if test="${dto.deleteDate!=null}"></c:if>
                                <c:if test="${dto.deleteDate==null}">
                                    <c:if test="${dto.deadline>=date}">
                                        <fmt:formatDate value="${dto.deadline}" pattern="yyyy.MM.dd.(E)"/>
                                    </c:if>
                                    <%--마감일 초과--%>
                                    <c:if test="${dto.deadline<date}">
                                        <b style="color: crimson"><fmt:formatDate value="${dto.deadline}"
                                                                                  pattern="yyyy.MM.dd.(E)"/></b>
                                    </c:if>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>제목
                            </th>
                            <td colspan="9">
                                <c:set var="subject" value="${fn:replace(dto.subject, '<', '&lt;')}"/>
                                <c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
                                    ${subject}
                            </td>
                        </tr>
                        <tr>
                            <th>내용
                            </th>
                            <td colspan="9">
                                <c:set var="content" value="${fn:replace(dto.content, '<', '&lt;')}"/>
                                <c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
                                <c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
                                    ${content}
                            </td>
                        </tr>

                    </table>
                    </c:if>

                    <table class="table" width="600" align="center" cellpadding="5" cellspacing="0">
                        <tr class="table-secondary">
                            <td align="center">
                                <c:if test="${userInfo.get(0).getUserName()==dto.userName}">
                                    <input class="btn btn-primary btn-sm" type="submit" value="수정"
                                           style="font-size: 13px; width: 80px"/>
                                    <input class="btn btn-danger btn-sm" type="button" value="삭제"
                                           style="font-size: 13px; width: 80px"
                                           onclick="deleteCheck('workDelete?workID=${dto.workID}&currentPage=${currentPage}','${userInfo.get(0).getUserID()==dto.userID}')"/>
                                </c:if>
                                <input class="btn btn-info btn-sm" type="button" value="돌아가기"
                                       style="font-size: 13px; width: 80px"
                                       onclick="history.back()"/>
                                <input type="hidden" name="workID" value="${dto.workID}"/>
                                <input type="hidden" name="currentPage" value="${currentPage}"/>
                                <input type="hidden" name="ip" value="${pageContext.request.remoteAddr}"/>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</div>

<script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="js/workDelete.js"></script>
</body>

</html>