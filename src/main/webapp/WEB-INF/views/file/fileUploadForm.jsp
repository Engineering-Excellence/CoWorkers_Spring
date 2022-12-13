<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- Kyle 파일 추가 --%>
<!DOCTYPE html>
<html lang="ko">

<!-- head 시작 -->
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
<!-- head 끝 -->

<!-- body 시작 -->
<body>

<fmt:requestEncoding value="UTF-8"/>
<%
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
            <h1 class="page-header">자료실</h1>

            <div class="table-responsive">

                <!-- 글 작성 부분 -->
                <form class="m-" action="fileUploadFormAction" method="post" enctype="multipart/form-data">
                <table class="table table-striped" style="width:1500px; margin-left: auto; margin-right: auto;">
                    <tr class="table-primary">
                        <th colspan="15" style="font-size: 30px; text-align: center;">글 작성</th>
                    </tr>

                    <tr>
                        <th class="align-middle table-dark">제목
                        </th>
                        <td colspan="2">
                            <input id="subject" type="text" class="form-control form-control-sm" name="subject"/>
                        </td>
                    </tr>

                    <tr>
                        <th class="align-middle table-dark">이름
                        </th>
                        <td>
                            <input id="userName" type="text" class="form-control form-control-sm" name="userName"
                                   style="width: 80%" value="${userInfo.get(0).getUserName()}" readonly/>
                        </td>

                        <!-- 공지글 여부 -->
                        <th class="align-left table-dark">
                            공지글 <input class="form-check-input" type="checkbox" name="notice" value="true">
                        </th>
                    </tr>

                    <tr>
                        <th class="align-middle table-dark">내용
                        </th>
                        <td colspan="2">
                <textarea id="content" class="form-control form-control-sm" rows="10" name="content"
                          style="resize: none"></textarea>
                        </td>
                    </tr>

                    <tr class="uploadTr">
                        <th class="align-middle table-dark">파일첨부
                        <td colspan="2">
                            <input type="file" name="uploadFile" multiple="multiple">
                        </td>
                    </tr>

                    <tr class="table-secondary">
                        <td colspan="3" align="center">
                            <%--<button id="uploadBtn" class="btn btn-primary btn-sm" type="button" style="font-size: 13px">저장하기</button>--%>
                                <input type="submit" class="btn btn-primary btn-sm" value="저장하기" style="font-size: 13px"/>
                            <input class="btn btn-danger btn-sm" type="reset" value="다시쓰기" style="font-size: 13px"/>
                            <input class="btn btn-info btn-sm" type="button" value="돌아가기" style="font-size: 13px"
                                   onclick="history.back()"/>
                        </td>
                    </tr>

                </table>

                <input type="hidden" name="ip" value="${pageContext.request.remoteAddr}"/>
                <input type="hidden" name="userID" value="${userInfo.get(0).getUserID()}">
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<%--<script>
    $(document).ready(function () {
        $('#uploadBtn').on("click", function (e) {
            let formData = new FormData()
            let inputFile = $("input[name='uploadFile']")
            let files = inputFile[0].files

            console.log(files)

            // add File Data to formData
            for (let i = 0; i < files.length; i++) {
                formData.append("uploadFile", files[i])
            }

            $.ajax({
                url: '/fileUploadAjaxAction',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                success: function (result) {
                    alert("Uploaded")
                }
            })  // $.ajax
        })
    })
</script>--%>

</body>
<!-- body 끝 -->

</html>