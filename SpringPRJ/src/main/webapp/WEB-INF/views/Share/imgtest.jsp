<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%

    //전달받은 메시지
    String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>SeoGram - SEO Agency Template</title>




    <link rel="stylesheet" href="../assets/css/maicons.css">

    <link rel="stylesheet" href="../assets/css/bootstrap.css">

    <link rel="stylesheet" href="../assets/vendor/animate/animate.css">

    <link rel="stylesheet" href="../assets/css/theme.css">
    <link rel="stylesheet" href="../assets/css/inputImg.css">


    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


</head>
<script>

    //이전페이지로 돌아가기
    function back(){
        history.go(-1);
    }


</script>

<body>



<header>
    <!--nav bar-->
    <%@include file="../../views/inc/navbar.jsp"%>
    <!--nav bar-->

    <div class="container">
        <div class="page-banner">
            <div class="row justify-content-center align-items-center h-100">
                <div class="col-md-6">
                    <nav aria-label="Breadcrumb">
                        <ul class="breadcrumb justify-content-center py-0 bg-transparent">
                            <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                            <li class="breadcrumb-item active">About</li>
                        </ul>
                    </nav>
                    <h1 class="text-center">중고나라</h1>

                </div>
            </div>
        </div>
    </div>
</header>





<div class="page-section">

    <div class="container">

        <form id="uploadForm" enctype="multipart/form-data" action="/boardInsert" method="post">

            <h2 class="post-title" style="color:#52734D"  >제목</h2></span>

            <div class="col-sm-15">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <select id="categories" class="custom-select bg-light" name="category">
                            <option>All Categories</option>
                            <option value="Cloth">Cloth</option>
                            <option value="Device">Device</option>
                            <option value="Book">Book</option>
                            <option value="etc">etc</option>
                        </select>
                    </div>
                    <input type="text" class="form-control" placeholder="Enter keyword.." name="title" required="required" >
                </div>
            </div>
            <h2 style="color:#52734D">내용</h2>

            <textarea name="contents" id="message" cols="30" rows="20" class="form-control" placeholder="Write your notes or questions here..." required="required"></textarea>
            <fieldset class="form-group">
                <a href="javascript:void(0)" onclick=$('#pro_image').click() style="color:#52734D;">ImageUpload</a>
                <input type="file" multiple id="pro_image" name="pro_image" style="display:none" class="form-control"  multiple>
            </fieldset>
            <div class="preview-images-zone"> </div>
            <hr>
            <div style="float: right;">
                <button class="btn btn-secondary"  >등록</button>&nbsp;&nbsp;<button class="btn btn-secondary" onclick="history.go(-1)">목록</button>
            </div>
        </form>

    </div><!-- .container -->



</div> <!-- .section -->


<!--footer-->

<%@include file="../../views/inc/footbar.jsp"%>

<!--footer-->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script>

    $(document).ready(function() {
        document.getElementById('pro_image').addEventListener('change', readImage, false);
        $( ".preview-images-zone" ).sortable();
        console.log("ready start");

        $(document).on('click', '.image-cancel', function() {
            let no = $(this).data('no');
            $(".preview-image.preview-show-"+no).remove();
        });
    });

    function test() {
        console.log("test");
    }

    var num = 4;
    function readImage() {
        console.log("readImage STart")
        if (window.File && window.FileList && window.FileReader) {
            var files = event.target.files; //FileList object
            console.log("files : " + files);
            var output = $(".preview-images-zone");
            console.log("outputs : " + output);
            for (let i = 0; i < files.length; i++) {
                var file = files[i];
                if (!file.type.match('image')) continue;
                console.log("count : " + file)
                var picReader = new FileReader();

                picReader.addEventListener('load', function (event) {
                    var picFile = event.target;
                    var html =  '<div class="preview-image preview-show-' + num + '">' +
                        '<div class="image-cancel" data-no="' + num + '">x</div>' +
                        '<div class="image-zone"><img id="pro-img-' + num + '" src="' + picFile.result + '"></div>' +
                        '<div class="tools-edit-image"><a href="javascript:void(0)" data-no="' + num + '" class="btn btn-light btn-edit-image">edit</a></div>' +
                        '</div>';

                    output.append(html);
                    console.log("output : " + output);
                    num = num + 1;
                });
                picReader.readAsDataURL(file);
            }

        } else {
            console.log('Browser not support');
        }
    }




</script>

</body>
</html>