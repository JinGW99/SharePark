<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주차 등록</title>
    <title>Drag and Drop File Upload</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <link rel="shortcut icon" href="/assets/favicon.ico">
    <link rel="stylesheet" href="./src/main.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style> body {
        min-height: 100vh;
        background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
        background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
        background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
        background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
        background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }
    .input-form {
        max-width: 680px;
        margin-top: 80px;
        padding: 32px;
        background: #fff;
        -webkit-border-radius: 10px;
        -moz-border-radius: 10px;
        border-radius: 10px;
        -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
        -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
        box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }

    .drop-zone {
        max-width: 200px;
        height: 200px;
        padding: 25px;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        font-family: "Quicksand", sans-serif;
        font-weight: 500;
        font-size: 20px;
        cursor: pointer;
        color: #cccccc;
        border: 4px dashed #009578;
        border-radius: 10px;
    }

    .drop-zone--over {
        border-style: solid;
    }

    .drop-zone__input {
        display: none;
    }

    .drop-zone__thumb {
        width: 100%;
        height: 100%;
        border-radius: 10px;
        overflow: hidden;
        background-color: #cccccc;
        background-size: cover;
        position: relative;
    }

    .drop-zone__thumb::after {
        content: attr(data-label);
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        padding: 5px 0;
        color: #ffffff;
        background: rgba(0, 0, 0, 0.75);
        font-size: 14px;
        text-align: center;
    }


    </style>

    <script type="text/javascript">

        console.log("script");


        function doSubmit(f) {


            if (f.pro_image.value === "") {
                f.pro_image.focus();
                alert("null입니다.");
                return false;
            }else{

                console.log(f.pro_image.value);
            }


            if (f.sp_title.value === "") {
                alert("이름를 입력하세요");
                f.sp_title.focus();
                return false;
            }
            if (f.sp_contents.value === "") {
                alert("내용을 입력하세요");
                f.sp_contents.focus();
                return false;
            }
            if (f.start_time.value === "") {
                alert("시작시간을 입력하세요");
                f.start_time.focus();
                return false;
            }

            if (f.end_time.value === "") {
                alert("끝시간을 입력하세요");
                f.end_time.focus();
                return false;
            }
            if (f.sp_place.value === "") {
                alert("주소를 입력하세요");
                f.sp_place.focus();
                return false;
            }

        }


    </script>
</head>

<body>

<div class="container">
    <div class="input-form-backgroud row">
        <div class="input-form col-md-12 mx-auto">
            <h4 class="mb-3">주차장 등록</h4>
            <form class="validation-form"  name="f" method="post" enctype="multipart/form-data" action="/boardInsert" onsubmit="return doSubmit(this);" >

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <div>주차장이름</div>
                        <input type="text" name="sp_title" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <div>주차장설명</div>
                        <input type="text" name="sp_contents" class="form-control">

                    </div>
                </div>
                <div class="mb-3">
                    <div>시작시간</div>
                    <input type="datetime-local" name="start_time" class="form-control">

                </div>

                <div class="mb-3">
                    <div>끝시간</div>
                    <input type="datetime-local" name="end_time" class="form-control" placeholder="Seoul">

                </div>
                <div class="mb-3">
                    <div>주차장 위치</div>
                    <input type="text" name="sp_place" class="form-control">
                </div>
                <hr class="mb-4">



                <div class="mb-4">
                    <div>주차장 사진등록</div>
                <div class="drop-zone">

                    <span class="drop-zone__prompt">Drop file here or click to upload</span>
                    <input type="file" name="pro_image" class="drop-zone__input" id="imageInput">
                </div>

                <script>
                    document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
                        const dropZoneElement = inputElement.closest(".drop-zone");
                        console.log("click")

                        dropZoneElement.addEventListener("click", (e) => {
                            inputElement.click();

                        });

                        inputElement.addEventListener("change", (e) => {
                            if (inputElement.files.length) {
                                updateThumbnail(dropZoneElement, inputElement.files[0]);
                            }
                        });

                        dropZoneElement.addEventListener("dragover", (e) => {
                            e.preventDefault();
                            dropZoneElement.classList.add("drop-zone--over");
                        });

                        ["dragleave", "dragend"].forEach((type) => {
                            dropZoneElement.addEventListener(type, (e) => {
                                dropZoneElement.classList.remove("drop-zone--over");
                            });
                        });

                        dropZoneElement.addEventListener("drop", (e) => {
                            e.preventDefault();

                            if (e.dataTransfer.files.length) {
                                inputElement.files = e.dataTransfer.files;
                                updateThumbnail(dropZoneElement, e.dataTransfer.files[0]);
                            }

                            dropZoneElement.classList.remove("drop-zone--over");
                        });
                    });

                    /**
                     * Updates the thumbnail on a drop zone element.
                     *
                     * @param {HTMLElement} dropZoneElement
                     * @param {File} file
                     */
                    function updateThumbnail(dropZoneElement, file) {
                        let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");

                        // First time - remove the prompt
                        if (dropZoneElement.querySelector(".drop-zone__prompt")) {
                            dropZoneElement.querySelector(".drop-zone__prompt").remove();
                        }

                        // First time - there is no thumbnail element, so lets create it
                        if (!thumbnailElement) {
                            thumbnailElement = document.createElement("div");
                            thumbnailElement.classList.add("drop-zone__thumb");
                            dropZoneElement.appendChild(thumbnailElement);
                        }

                        thumbnailElement.dataset.label = file.name;

                        // Show thumbnail for image files
                        if (file.type.startsWith("image/")) {
                            const reader = new FileReader();

                            reader.readAsDataURL(file);
                            reader.onload = () => {
                                thumbnailElement.style.backgroundImage = `url('${reader.result}')`;
                            };
                        } else {
                            thumbnailElement.style.backgroundImage = null;
                        }
                    }

                </script>

                </div>

                <input type="submit" class="btn btn-primary btn-lg btn-block"/>
            </form>
        </div>
    </div>

</div>

</body>


</html>

