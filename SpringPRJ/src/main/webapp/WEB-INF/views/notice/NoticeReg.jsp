<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="kopo.poly.util.CmmUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String SS_USER_ID = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
%>
<html>
<head>
    <title>게시판 글쓰기</title>

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
        //전송시 유효성 체크
        function doSubmit(f){
            if(f.title.value == ""){
                alert("제목을 입력하시기 바랍니다.");
                f.title.focus();
                return false;
            }

            if(calBytes(f.title.value) > 200){
                alert("최대 200Bytes까지 입력 가능합니다.");
                f.title.focus();
                return false;
            }



            if(f.contents.value == ""){
                alert("내용을 입력하시기 바랍니다.");
                f.contents.focus();
                return false;
            }

            if(calBytes(f.contents.value) > 4000){
                alert("최대 4000Bytes까지 입력 가능합니다.");
                f.contents.focus();
                return false;
            }


        }
        //글자 길이 바이트 단위로 체크하기(바이트값 전달)
        function calBytes(str){

            var tcount = 0;
            var tmpStr = new String(str);
            var strCnt = tmpStr.length;
            var onechar;
            for (i=0;i<strCnt;i++){
                onechar = tmpStr.charAt(i);

                if (escape(onechar).length > 4){
                    tcount += 2;
                }else{
                    tcount += 1;
                }
            }

            return tcount;
        }
    </script>
</head>
<body class="pc" onload="doOnload();" >
<form name="f" method="post" action="/notice/NoticeInsert" target= "ifrPrc" onsubmit="return doSubmit(this);">
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
                        <a href="/PRJ/PRJmain">HOME</a>
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
                            <input type="text" name="title" maxlength="100" style="width: 450px" />
                        </div>

                        <div>
                            <span>내용</span>
                        </div>

                        <div>
                            <textarea name="contents" placeholder="내용를 작성해주세요."></textarea>
                        </div>
                    </div>
                    <input type="submit" value="등록" />
                </div>
            </div>
        </div>
    </div>
</form>
<iframe name="ifrPrc" style="display:none"></iframe>
</body>
</html>