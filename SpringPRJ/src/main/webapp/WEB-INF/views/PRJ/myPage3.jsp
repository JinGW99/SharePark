<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.ShareDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String SS_USER_ID = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

    List<ShareDTO> rList = (List<ShareDTO>) request.getAttribute("rList");

    if (rList == null) {
        rList = new ArrayList<ShareDTO>();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공유내역</title>
    <link rel="stylesheet" href="/css/myPage3.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
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
                    <a href="/PRJ/myPage">회원정보 수정</a>
                </li>
                <li>
                    <a href="/PRJ/myPage2">예약 내역</a>
                </li>

                <li>
                    <a href="/PRJ/myPage3" class="active">공유 내역</a>
                </li>
                <li>
                    <a href="/PRJmain">Home</a>
                </li>

            </ul>
        </nav>
        <div class="align_rt">
            <div class="notice">
                <!-- Tab -->
                <div class="tab">
                    <div class="tab_btn">
                        <ul>
                            <li><a href="#"><%=CmmUtil.nvl(SS_USER_ID)%>님의 공유 내역</a></li>

                        </ul>
                    </div>
                </div>
                <%

                    for (int i = 0; i < rList.size(); i++) {
                        ShareDTO rDTO = rList.get(i);

                        if (rDTO == null) {
                            rDTO = new ShareDTO();
                        }

                %>
                <div class="tab_each">
                    <div class="reservation">
                        <img src="<%=CmmUtil.nvl(rDTO.getSave_file_path())%>">
                        <script>
                            console.log(<%=rDTO.getSave_file_path()%>);
                        </script>
                        <div class="descript">
                            <a1>주차장 이름 : <%=CmmUtil.nvl(rDTO.getSp_title())%></a1>
                            <a2>주차장 주소 : <%=CmmUtil.nvl(rDTO.getSp_place())%></a2>
                            <a3>시작시간 : <%=CmmUtil.nvl(rDTO.getStart_time())%></a3><a3>끝 시간 :
                            <%=CmmUtil.nvl(rDTO.getEnd_time())%></a3>
                            <br>
                            <button class="cancel" onclick="location.href='/share/ParkDelete?sp_seq=<%=CmmUtil.nvl(rDTO.getSp_seq())%>';">주차장 삭제</button>
                            <button class="cancel" onclick="location.href='/share/ParkEditInfo?sp_seq=<%=CmmUtil.nvl(rDTO.getSp_seq())%>';">주차장 수정</button>


                        </div>
                        <div class="map">
                        </div>
                    </div>

                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>