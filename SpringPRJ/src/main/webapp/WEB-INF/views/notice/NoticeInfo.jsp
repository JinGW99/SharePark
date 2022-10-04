<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.NoticeDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    NoticeDTO rDTO = (NoticeDTO)request.getAttribute("rDTO");
//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO==null){
        rDTO = new NoticeDTO();
    }

    String SS_USER_ID = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

    int access = 1; //(작성자 : 2 / 다른 사용자: 1)
    if (CmmUtil.nvl((String)session.getAttribute("SS_USER_ID")).equals(
            CmmUtil.nvl(rDTO.getUser_id()))){
        access = 2;
    }

    System.out.println("rDTO" + rDTO);
    System.out.println("user_id : " + CmmUtil.nvl(rDTO.getUser_id()));
    System.out.println("SS_USER_ID : " + SS_USER_ID);
%>
<html>
<head>
    <title>게시판 글보기</title>

    <style type="text/css">
        body{
            font-size: 14px;
        }
        .wrap.show{
            opacity: 1;
            visibility: visible;
        }

        .wrap{
            width: 100%;
            background:#fff;
        }


        ul,
        li {
            list-style: none;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        html, body, div, span, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, address, cite, code, del, dfn, em, img, ins, kbd, q, samp, small, strong, sub, sup, var, b, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
            box-sizing: border-box;
        }


        .sub_wrap .align_rt {
            float: right;
            width: 750px;
            margin-right: 31px;
            margin-top:20px;
        }

        .sub_wrap nav {
            display: block;
            float: left;
            width: 238px;
            padding-top:32px;
        }

        .wrap{
            width:100%;
            background:#fff;
        }

        .sub_top_wrap{
            height: 120px;
            background:rgb(112,173,71);
        }

        .sub_top{
            position:relative;
            width:1024px;
            height:120px;
            margin:0 auto;
            border-radius:0;
            text-align:left;
        }

        .sub_top a{
            position: absolute;
            color: white;
            font-weight: 500;
            font-size: 32px;
            bottom:20px;
        }


        .content{
            overflow:hidden;
        }

        .sub_wrap{
            width: 1024px;
            margin:0 auto 0 auto;
            padding-top:54px;
            padding-bottom:54px;
        }

        .show_list li .list_que span {
            font-size: 16px;
            color: black;
        }

        .show_list li{
            display: block;
            position: relative;
            height: auto;
            margin-bottom: 0;
            padding: 0px 24px 0px 0px;
            border-radius: 0;
            background: #fff;
            font-size: 18px;
            line-height: normal;
            cursor: pointer;
        }

        .show_list li .list_que p {
            padding-bottom: 0px;
            overflow: visible;
            white-space: normal;
            text-overflow: initial;
            line-height: normal;
            word-wrap: break-word;
        }

        .show_list li a p {
            overflow: hidden;
            width: 100%;
            padding-bottom: 3px;
            white-space: nowrap;
            text-overflow: ellipsis;
            color:black;
        }


        .tab_each {
            clear: both;
            display:block;
            padding-top:8px;
            text-align:left;
            border-top:1px solid black;
        }

        div {
            display: block;
        }

        p {
            display: block;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
        }

        .show_list {
            margin-bottom: 0;
            padding: 0 0;
        }

        .sub_wrap nav ul li a{
            display:block;
            font-size:20px;
            color:black;
        }

        .sub_wrap nav{
            padding-right:20px;
            text-align:left;
        }

        .sub_wrap nav ul li a.active{
            font-size:20px;
            color:rgb(112,173,71);
            font-weight:bold;
        }

        .wrap.show, footer.show {
            opacity: 1;
            visibility: visible;
        }

        .wrap {
            width: 100%;
            background: #fff;
            opacity: 0;
            visibility: hidden;
        }

        .sub_wrap nav ul li {
            margin-bottom: 26px;
        }

        .tab{
            text-align:left;
        }
        .tab span.tab_btn {
            display: inline-block;
            float: none;
            position: relative;
            width: auto;
            height: 30px;
            margin-right: 22px;
            font-size: 20px;
            line-height: normal;
            color: black;
            text-align: left;
            cursor: pointer;
            font-weight:bold;
            padding-left:5px;
        }

        .sub_wrap{
        }

        textarea{
            width:650px;
            height:250px;
            border-radius:7px;
            margin-top:10px;
        }

        .tab_each ul li{
            display: inline-block;
        }

        .tab_each ul li span{
            position:relative;
            font-size:18px;
            font-weight:bold;
            top:3px;
        }

        .tab_each ul li input{
            width:70px;
            border-radius:4px;
            height:18px;
            margin-top:0px;
        }

        .tab_each ul li .input2{
            width:120px;
        }
    </style>
    <script type="text/javascript">
        //수정하기
        function doEdit(){

            if ("<%=access%>"=="1"){
                alert("작성자만 수정할 수 있습니다.");
            }else {
                location.href="/notice/NoticeEditInfo?notice_seq=<%=CmmUtil.nvl(rDTO.getNotice_seq())%>"
            }
        }
        //삭제하기
        function doDelete(){
            if ("<%=access%>" == 2){
                if (confirm("작성한 글을 삭제하시겠습니까?")){
                    location.href="/notice/NoticeDelete?notice_seq=<%=CmmUtil.nvl(rDTO.getNotice_seq())%>";

                }
            }else {
                alert("본인이 작성한 게시글만 삭제할 수 있습니다.");
            }
        }

        //목록으로 이동
        function doList() {
            location.href = "/notice/NoticeList";
        }

    </script>


</head>
<body class="pc" onload="doOnload();" >

    <div class="wrap show">
        <div class="sub_top_wrap">
            <div class="sub_top">
                <a><i class="fas fa-phone-alt fa-lg"></i> 게시판 글쓰기</a>
            </div>
        </div>
        <div id="content" class="sub_wrap">
            <nav>
                <ul>
                    <li>
                        <a href="/notice/NoticeList" class="active">게시판</a>
                    </li>
                    <li>
                        <a href="/PRJmain">HOME</a>
                    </li>
                </ul>
            </nav>
            <div class="align_rt">
                <div class="notice">
                    <!-- Tab -->
                    <div class="tab">
              <span class="tab_btn">
                게시판 작성
              </span>
                    </div>
                    <!-- 공지사항  -->
                    <div class="tab_each">

                        <div>
                            <span>제목</span>
                        </div>
                        <div>
                            <input type="text" name="title" maxlength="100" value="<%=CmmUtil.nvl(rDTO.getTitle()) %>" readonly style="width: 450px" />
                        </div>

                        <div>
                            <span>내용</span>
                        </div>

                        <div>
                           <textarea
                                   name="contents" style="width: 550px; height: 400px" readonly
                           ><%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %></textarea>
                        </div>
                    </div>
                    <a href="javascript:doEdit();">[수정]</a>
                    <a href="javascript:doDelete()">[삭제]</a>


                </div>
            </div>
        </div>
    </div>


</body>
</html>