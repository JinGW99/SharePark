<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR" %>
<%
    String SS_USER_SEQ = CmmUtil.nvl((String) session.getAttribute("SS_USER_SEQ"));
%>
<%
    UserInfoDTO rDTO = (UserInfoDTO) request.getAttribute("rDTO");
%>
<%
    if (rDTO==null){
        rDTO = new UserInfoDTO();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/myPage.css">
    <script type="javascript">
        function doSubmit(f){
            if (f.address.value == ""){
                alert("주소를 입력하세요.");
                f.address.focus();
                return false;
            }

            if (f.user_phone.value == ""){
                alert("전화번호를 입력하세요.");
                f.user_phone.focus();
                return false;
            }
        }
    </script>

</head>
<body class="pc">

<div class="wrap show">
    <div class="sub_top_wrap">
        <div class="sub_top">
            <h1>회원정보 수정</h1>
        </div>
    </div>
    <div id="content" class="sub_wrap">
        <nav>
            <ul>
                <li>
                    <a href="PRJ/myPage" class="active">회원정보 수정</a>
                </li>
                <li>
                    <a href="PRJ/myPage2">예약 내역</a>
                </li>
            </ul>
        </nav>
        <div class="align_rt">
            <div class="notice">
                <!-- Tab -->
                <div class="tab">
                    <div class="tab_btn">
                        <ul>
                            <li>새 정보입력</li>
                        </ul>
                    </div>
                </div>
                <div class="tab_each">

                    <form name="f" method="post" action="/PRJ/updateUser" onsubmit="return doSubmit(this)";>
                    <input type="hidden" name="user_seq" value="<%=SS_USER_SEQ%>" />
                    <ul>
                        <li>
                            <div>
                                <span>Address :</span>
                                <input type="text" name="address" maxlength="100" class="mod" placeholder="주소를 입력하세요" value=<%=CmmUtil.nvl(rDTO.getAddress())%>>
                            </div>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <div>
                                <span>휴대폰 번호 :</span>
                                <input type="text"name="user_phone" maxlength="100" class="mod"  placeholder="번호를 입력하세요" value=<%=CmmUtil.nvl(rDTO.getUser_phone())%>>
                            </div>
                        </li>
                        <br>
                        <li>

                        </li>
                        <li>
                            <input type="submit" class="modify" />

                        </li>
                    </ul>

                    </form>


                </div>
            </div>
        </div>
    </div>
</div>



</body>