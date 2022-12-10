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
    System.out.println(pageContext.findAttribute("boardDTO"));

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
                            ${boardDTO.postID}
                        </td>
                        <td align="center">
                            <c:set var="userName" value="${fn:replace(boardDTO.userName, '<', '&lt;')}"/>
                            <c:set var="userName" value="${fn:replace(userName, '>', '&gt;')}"/>
                            ${userName}
                        </td>
                        <td align="center">
                            <jsp:useBean id="date" class="java.util.Date"/>
                            <c:if test="${date.year == boardDTO.writeDate.year && date.month == boardDTO.writeDate.month &&
						date.date == boardDTO.writeDate.date && boardDTO.deleteDate == null && boardDTO.updateDate == null}">
                                <fmt:formatDate value="${boardDTO.writeDate}" pattern="a h:mm"/>
                            </c:if>
                            <c:if test="${date.year != boardDTO.writeDate.year || date.month != boardDTO.writeDate.month ||
						date.date != boardDTO.writeDate.date && boardDTO.deleteDate == null && boardDTO.updateDate == null}">
                                <fmt:formatDate value="${boardDTO.writeDate}" pattern="yyyy.MM.dd(E)"/>
                            </c:if>
                        </td>
                        <td align="center">
                            ${boardDTO.hit}
                        </td>
                    </tr>
                    <tr>
                        <th style="text-align: center">제목</th>
                        <td colspan="3">
                            <c:if test="${boardDTO.deleteDate == null}">
                                <c:set var="subject" value="${fn:replace(boardDTO.subject, '<', '&lt;')}"/>
                                <c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
                                ${subject}
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th class="align-middle" style="text-align: center; height: 300px;">내용</th>
                        <td colspan="3">
                            <c:if test="${boardDTO.deleteDate == null}">
                                <c:set var="content" value="${fn:replace(boardDTO.content, '<', '&lt;')}"/>
                                <c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
                                <c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
                                ${content}
                            </c:if>
                        </td>
                    </tr>
                    <tr class="table-secondary">
                        <td colspan="4" align="center">
                            <c:if test="${userInfo.get(0).getUserID() == boardDTO.userID}">
                                <input
                                        class="btn btn btn-primary btn-sm btn-sm"
                                        type="button"
                                        value="수정하기"
                                        style="font-size: 13px;"
                                        onclick="location.href=('boardUpdate?postID=${boardDTO.postID}&currentPage=${currentPage}')"/>
                                <input
                                        class="btn btn-danger btn-sm"
                                        type="button"
                                        value="삭제하기"
                                        style="font-size: 13px;"
                                        onclick="deleteCheck('boardDelete?postID=${boardDTO.postID}&currentPage=${currentPage}&userID=${userInfo.get(0).getUserID()}')"/>
                            </c:if>
                            <input
                                    class="btn btn-info btn-sm"
                                    type="button"
                                    value="돌아가기"
                                    style="font-size: 13px;"
                                    onclick="location.href='board?currentPage=${currentPage}'"
                            />
                        </td>
                    </tr>
                </table>
            </div>

            <hr style="margin-left: auto; margin-right: auto;"/>

            <!-- 댓글 폼 -->
            <form class="m-3" action="boardCommentOK" method="post" name="commentForm">
                <table class="table table-striped" style="width: 100%; margin-left: auto; margin-right: auto;">
                    <tr class="table-success">
                        <th colspan="4" style="font-size: 30px; text-align: center;">댓글 보기(${boardDTO.commentCount}개)
                        </th>
                    </tr>

                    <!-- 이 줄은 원래 보이면 안되는 줄로 작업이 완료되면 화면에 표시되지 않게 한다. -->
                    <tr style="display: none;">
                        <td colspan="4">
                            <!-- 수정 또는 삭제할 댓글의 글번호를 넘겨준다. -->
                            commentID: <input type="text" name="commentID" value="0" size="4"/>
                            <!-- 현재 댓글이 어떤 메인글의 댓글인가 넘겨준다. -->
                            postID: <input type="text" name="postID" value="${boardDTO.postID}" size="4"/>
                            <!-- 작업 모드, 1 => 댓글 저장, 2 => 댓글 수정 -->
                            mode: <input type="text" name="mode" value="insert" size="1"/>
                            <!-- 메인글이 표시되던 페이지 번호를 넘겨준다. -->
                            currentPage: <input type="text" name="currentPage" value="${currentPage}" size="4"/>
                            <!-- 댓글 작성자의 ip 주소를 넘겨준다. -->
                            ip: <input type="text" name="ip" value="${pageContext.request.remoteAddr}" size="10"/>
                        </td>
                    </tr>

                    <!-- 이 줄 부터 댓글 입력, 수정, 삭제에 사용된다. -->
                    <tr>
                        <th class="align-middle" style="width: 100px; text-align: center;">
                            <label for="userName">이름</label>
                        </th>
                        <th style="width: 250px;">
                            <input autocomplete="off" id="userName" class="form-control form-control-sm" type="text"
                                   value="${userInfo.get(0).getUserName()}"
                                   name="userName" readonly/>
                        </th>
                    </tr>
                    <tr>
                        <th class="align-middle" style="width: 100px; text-align: center;">
                            <label for="content">내용</label>
                        </th>
                        <th colspan="3" style="width: 600px;">
					<textarea
                            id="content"
                            class="form-control form-control-sm"
                            rows="3"
                            name="content"
                            style="resize: none;"
                    ></textarea>
                        </th>
                    </tr>
                    <tr class="table-info">
                        <td colspan="4" align="center">
                            <input
                                    class="btn btn-primary btn-sm"
                                    type="submit"
                                    value="댓글 작성"
                                    style="font-size: 13px;"
                                    name="commentBtn"
                            />
                            <input
                                    class="btn btn-danger btn-sm"
                                    type="button"
                                    value="다시쓰기"
                                    style="font-size: 13px;"
                                    onclick="setting(0, 'insert', '댓글 작성', '${userInfo.get(0).getUserName()}', '')"
                            />
                        </td>
                    </tr>

                    <!-- 댓글을 출력한다. -->
                    <c:set var="boardCommentList" value="${boardCommentList.list}"/>

                    <!-- 댓글이 없는 경우 -->
                    <c:if test="${boardCommentList.size() == 0}">
                        <tr>
                            <td colspan="4" height="85" style="vertical-align: middle">
                                <p align="center">댓글이 존재하지 않습니다.</p>
                            </td>
                        </tr>
                    </c:if>

                    <!-- 댓글이 있는 경우 -->
                    <c:if test="${boardCommentList.size() != 0}">
                        <c:forEach var="boardCommentDTO" items="${boardCommentList}">
                            <tr class="table-dark">
                                <c:if test="${boardCommentDTO.deleteDate == null}">
                                    <td colspan="4" style="vertical-align: middle">
                                            <%--${boardCommentDTO.commentID}.--%>
                                        <c:set var="userName" value="${fn:replace(boardCommentDTO.userName, '<', '&lt;')}"/>
                                        <c:set var="userName" value="${fn:replace(userName, '>', '&gt;')}"/>
                                            ${userName}님이
                                        <fmt:formatDate value="${boardCommentDTO.writeDate}"
                                                        pattern="yyyy.MM.dd(E) HH:mm:ss"/>에
                                        남긴 댓글:<br/>
                                        <c:set var="content" value="${fn:replace(boardCommentDTO.content, '<', '&lt;')}"/>
                                        <c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
                                        <c:set var="content" value="${fn:replace(content, enter, '<br/>')}"/>
                                            ${content}<br/>
                                        <div align="right">
                                            <c:if test="${userInfo.get(0).getUserID() == boardCommentDTO.userID}">
                                                <input
                                                        class="btn btn-primary btn-sm"
                                                        type="button"
                                                        value="수정"
                                                        style="font-size: 13px;"
                                                        onclick="setting(${boardCommentDTO.commentID}, 'update', '댓글 수정', '${boardCommentDTO.userName}', '${boardCommentDTO.content}')"
                                                />
                                                <input
                                                        class="btn btn-danger btn-sm"
                                                        type="button"
                                                        value="삭제"
                                                        style="font-size: 13px;"
                                                        onclick="deleteCheck('boardCommentDelete?commentID=${boardCommentDTO.commentID}&postID=${boardDTO.postID}&currentPage=${currentPage}&userID=${userInfo.get(0).getUserID()}')"
                                                />
                                            </c:if>
                                        </div>
                                    </td>
                                </c:if>
                                <c:if test="${boardCommentDTO.deleteDate != null}">
                                    <td colspan="4" height="60" style="vertical-align: middle">
                                        <p>삭제된 댓글입니다.</p>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </c:if>

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
