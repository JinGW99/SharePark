<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.ShareDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="img/logo/logo.png?ver=3" rel="icon">
    <title>SP_MAP</title>
    <link href="vendor/fontawesome-free/css/all.min.css?ver=3" rel="stylesheet" type="text/css">
    <link href="vendor/bootstrap/css/bootstrap.min.css?ver=3" rel="stylesheet" type="text/css">
    <link href="css/ruang-admin.min.css?ver=3" rel="stylesheet">
    <script type="text/javascript">
        function doDetail(seq){
            location.href="/share/ParkInfo?sp_seq=" + seq;
        }
    </script>
    <style>
        .customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
        .customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
        .customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
        .customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
        .customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    </style>
</head>

<body id="page-top">
<div id="wrapper">
    <!-- Sidebar -->
    <ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/PRJmain">
            <div class="sidebar-brand-icon">
                <img src="../img/logo/logoback.jpg">
            </div>
            <div class="sidebar-brand-text mx-3">ShareParking</div>
        </a>
        <hr class="sidebar-divider my-0">
        <li class="nav-item active">
            <a class="nav-link" href="/PRJmain">
                <img src="img/home.jpg">
                <span>Home</span></a>
        </li>
        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Features
        </div>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseBootstrap"
               aria-expanded="true" aria-controls="collapseBootstrap">
                <i class="far fa-fw fa-window-maximize"></i>
                <span>주차장 보기</span>
            </a>
            <div id="collapseBootstrap" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">주차장 보기</h6>
                    <a class="collapse-item" href="/spMap_test">공유주차장 보기</a>
                    <a class="collapse-item" href="/PRJ/pubParkMap">공영주차장 보기</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseForm" aria-expanded="true"
               aria-controls="collapseForm">
                <i class="fab fa-fw fa-wpforms"></i>
                <span>CCTV위치확인</span>
            </a>
            <div id="collapseForm" class="collapse" aria-labelledby="headingForm" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">CCTV위치확인</h6>
                    <a class="collapse-item" href="/PRJ/CCTV">주차단속 CCTV</a>

                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTable" aria-expanded="true"
               aria-controls="collapseTable">
                <i class="fas fa-fw fa-table"></i>
                <span>My Page</span>
            </a>
            <div id="collapseTable" class="collapse" aria-labelledby="headingTable" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">My Page</h6>
                    <a class="collapse-item" href="/PRJ/myPage">회원정보수정</a>
                    <a class="collapse-item" href="/Share/RegPark">주차장 공유하기</a>
                    <a class="collapse-item" href="/PRJ/myPage2">예약 내역 보기</a>
                    <a class="collapse-item" href="/PRJ/myPage3">공유 내역 보기</a>
                    <a class="collapse-item" href="/PRJ/deleteUser" data-toggle="modal" data-target="#deleteUserModal">회원 탈퇴</a>

                </div>
            </div>
        </li>
        <hr class="sidebar-divider">

    </ul>
    <!-- Sidebar -->
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <!-- TopBar -->
            <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
                <ul class="navbar-nav ml-auto">



                    <div class="topbar-divider d-none d-sm-block"></div>
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            <img class="img-profile rounded-circle" src="img/boy.png" style="max-width: 60px">
                            <span class="ml-2 d-none d-lg-inline text-white small"><%=SS_USER_ID%></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                            <div class="dropdown-divider"></div>
                            <a type="submit" class="dropdown-item" href="javascript:void(0);" data-toggle="modal" data-target="#logoutModal">
                                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                Logout
                            </a>
                            </form>
                        </div>
                    </li>
                </ul>
            </nav>
            <!-- Topbar -->

            <!-- Container Fluid-->
            <div class="container-fluid" id="container-wrapper">
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">공유주차장 보기</h1>
                </div>

                <div id="map" style="width:1200px;height:500px;"></div>

                <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=3eaf5b2da4931b0cb10a1266b1502421&libraries=services"></script>

                <script>

                    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                        mapOption = {
                            center: new kakao.maps.LatLng( 37.54992, 126.84220), // 지도의 중심좌표
                            level: 5, // 지도의 확대 레벨
                            mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
                        };

                    // 지도를 생성한다
                    var map = new kakao.maps.Map(mapContainer, mapOption);


                    <%
                   for (int i = 0; i < rList.size(); i++){
                       ShareDTO rDTO = rList.get(i);

                       if (rDTO == null){
                           rDTO = new ShareDTO();
                       }
                  %>

                    // 주소-좌표 변환 객체를 생성합니다
                    var geocoder = new kakao.maps.services.Geocoder();
                    // 주소로 좌표를 검색합니다
                    geocoder.addressSearch('<%=CmmUtil.nvl(rDTO.getSp_place())%>', function(result, status) {

                        // 정상적으로 검색이 완료됐으면
                        if (status === kakao.maps.services.Status.OK) {

                            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                            // 결과값으로 받은 위치를 마커로 표시합니다
                            var marker = new kakao.maps.Marker({
                                map: map,
                                position: coords,
                                clickable: true
                            });


                            marker.setMap(map);


                        }
                        var iwContent = '<div style="padding: 5px;"><%=CmmUtil.nvl(rDTO.getSp_title())%></div> <br> <a href="/share/ParkInfo?sp_seq=<%=CmmUtil.nvl(rDTO.getSp_seq())%>";>상세보기</a>',
                            iwRemoveable = true;

                        var infowindow = new kakao.maps.InfoWindow({
                            content : iwContent,
                            removable : iwRemoveable
                        });

                        kakao.maps.event.addListener(marker, 'click', function (){
                            infowindow.open(map, marker);
                        })

                    });



                    <% } %>


                </script>


                <!-- Modal Logout -->
                <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabelLogout"
                     aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabelLogout">Ohh No!</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to logout?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Cancel</button>
                                <a href="PRJ/Logout" class="btn btn-primary">Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade" id="deleteUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabelLogout"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabelDeleteUser">Ohh No!</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>회원탈퇴를 할 경우 모든 정보가 사라집니다. 탈퇴하시겠습니까?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Cancel</button>
                            <a href="PRJ/deleteUser" class="btn btn-primary">Delete User</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!---Container Fluid-->
</div>

</div>
</div>


<!-- Scroll to top -->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>



<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="../js/ruang-admin.min.js"></script>
<script src="../vendor/chart.js/Chart.min.js"></script>
<script src="../js/demo/chart-area-demo.js"></script>
</body>

</html>