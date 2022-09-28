<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%
    String SS_ADDRESS = CmmUtil.nvl((String) session.getAttribute("SS_ADDRESS"));
    String SS_USER_PHONE = CmmUtil.nvl((String) session.getAttribute("SS_USER_PHONE"));

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 </title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/myPage.css">
</head>
<body class="pc">

<div class="wrap show">
    <div class="sub_top_wrap">
        <div class="sub_top">
            <h1>MY페이지</h1>
        </div>
    </div>
    <div id="content" class="sub_wrap">
        <nav>
            <ul>
                <li>
                    <a href="/PRJ/myPage" class="active">회원정보 수정</a>
                </li>
                <li>
                    <a href="/PRJ/myPage2">예약 내역</a>
                </li>
                <li>
                    <a href="/PRJ/myPage3">공유 내역</a>
                </li>
                <li>
                    <a href="/PRJ/PRJmain">Home</a>
                </li>
            </ul>
        </nav>
        <div class="align_rt">
            <div class="notice">
                <!-- Tab -->
                <div class="tab">
                    <div class="tab_btn">
                        <ul>
                            <li>회원정보</li>
                        </ul>
                    </div>
                </div>
                <div class="tab_each">
                    <ul>
                        <li>
                            <div>
                                <span>주소  :</span>
                                <a1><%=SS_ADDRESS%></a1>
                            </div>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <div>
                                <span>휴대폰 번호  :</span>
                                <a1><%=SS_USER_PHONE%></a1>
                            </div>
                        </li>
                        <br>


                        <button type="button" onclick="location.href='/PRJ/updateUserMove'">수정하기</button>
                        <button type="button" onclick="location.href='/updatePwPage'">비밀번호 변경하기</button>

                    </ul>


                </div>
            </div>
        </div>
    </div>
</div>



</body>