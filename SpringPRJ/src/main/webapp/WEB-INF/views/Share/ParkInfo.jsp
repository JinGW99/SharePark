<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.dto.ShareDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%
    ShareDTO rDTO = (ShareDTO) request.getAttribute("rDTO");

    if (rDTO==null){
        rDTO = new ShareDTO();
    }

    String ss_user_id = CmmUtil.nvl((String)session.getAttribute("SS_USER_ID"));

    //(1: 예약가능 // 2: 예약불가)
    int reser;

    if (CmmUtil.nvl(rDTO.getReser_id()).equals("")){
        reser = 1;
    }else {
        reser = 2;
    }

    System.out.println("user_id :" + CmmUtil.nvl(rDTO.getReser_id()));
    System.out.println("ss_user_id:" +ss_user_id);
    System.out.println("reser" + reser);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주차장 상세보기</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
    <link rel="stylesheet" href="..//css/myPage.css">
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="../css/ruang-admin.min.css" rel="stylesheet">

    <script>
        function doReser(){

            if ("<%=reser%>" == "1"){

                alert("예약하였습니다.");
                location.href = "/share/reservation";

            }else {

                alert("이미예약된 주차장입니다.");
                return false;
            }

        }
    </script>

    <style>
        .w-btn {
            position: relative;
            border: none;
            display: inline-block;
            padding: 15px 30px;
            border-radius: 15px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 600;
            transition: 0.25s;
        }
        .w-btn-blue {
            background-color: #6aafe6;
            color: #d4dfe6;
        }
    </style>


</head>
<body class="pc">

<div class="wrap show">
    <div class="sub_top_wrap">
        <div class="sub_top">
            <h1>주차장 정보</h1>
        </div>
    </div>
    <div id="content" class="sub_wrap">
        <div class="align_rt">
            <div class="notice">
                <!-- Tab -->
                <div class="tab">
                    <div class="tab_btn">
                        <ul>
                            <li><%=CmmUtil.nvl(rDTO.getSp_title())%>의 정보</li>
                        </ul>
                    </div>
                </div>
                <div class="tab_each">

                    <img src="<%=CmmUtil.nvl(rDTO.getSave_file_path())%>" >

                    <br>
                    <br>
                    <ul>
                        <li>
                            <div>
                                <span>설명  :</span>
                                <a1><%=CmmUtil.nvl(rDTO.getSp_contents())%></a1>
                            </div>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <div>
                                <span>주소  :</span>
                                <a1><%=CmmUtil.nvl(rDTO.getSp_place())%></a1>
                            </div>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <div>
                                <span>주차 가능시간  :</span>
                                <a1><%=CmmUtil.nvl(rDTO.getStart_time())%> ~ <%=CmmUtil.nvl(rDTO.getEnd_time())%></a1>
                            </div>
                        </li>
                    </ul>

                    <div>
                        <form name="f" action="/share/reservation" method="post" onsubmit="return doReser(this)">

                        <input type="hidden" id="sp_seq" name="sp_seq" value="<%=CmmUtil.nvl(rDTO.getSp_seq())%>">
                        <input type="hidden" id="reser_id" name="sp_seq" value="<%=CmmUtil.nvl(rDTO.getReser_id())%>">

                            <button class="w-btn w-btn-blue" type="submit">예약하기</button>

                        </form>

                        <br>

                        <button class="w-btn w-btn-blue" onclick="location.href='/spMap_test'">목록으로 돌아가기</button >
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>


<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="../js/ruang-admin.min.js"></script>
<script src="../vendor/chart.js/Chart.min.js"></script>
<script src="../js/demo/chart-area-demo.js"></script>
</body>

</html>
