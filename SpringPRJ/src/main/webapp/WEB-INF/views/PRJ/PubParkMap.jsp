<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.PubParkDTO" %>
<%@ page import="java.util.ArrayList" %>
<%
    String SS_USER_ID = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

    List<PubParkDTO> rList = (List<PubParkDTO>) request.getAttribute("rList");

    if (rList == null){
        rList = new ArrayList<PubParkDTO>();
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
    <link href="../img/logo/logo.png" rel="icon">
    <title>Public Parkinglot</title>
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="../css/ruang-admin.min.css" rel="stylesheet">
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
                <img src="../img/home.jpg">
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
                <span>????????? ??????</span>
            </a>
            <div id="collapseBootstrap" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">????????? ??????</h6>
                    <a class="collapse-item" href="/spMap_test">??????????????? ??????</a>
                    <a class="collapse-item" href="/PRJ/PubPark">??????????????? ??????</a>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseForm" aria-expanded="true"
               aria-controls="collapseForm">
                <i class="fab fa-fw fa-wpforms"></i>
                <span>CCTV????????????</span>
            </a>
            <div id="collapseForm" class="collapse" aria-labelledby="headingForm" data-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <h6 class="collapse-header">CCTV????????????</h6>
                    <a class="collapse-item" href="/cctvMap/test">???????????? CCTV</a>

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
                    <a class="collapse-item" href="/PRJ/myPage">??????????????????</a>
                    <a class="collapse-item" href="/Share/RegPark">????????? ????????????</a>
                    <a class="collapse-item" href="/PRJ/myPage2">?????? ?????? ??????</a>
                    <a class="collapse-item" href="/PRJ/myPage3">?????? ?????? ??????</a>
                    <a class="collapse-item" href="/PRJ/deleteUser" data-toggle="modal" data-target="#deleteUserModal">?????? ??????</a>

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
                            <img class="img-profile rounded-circle" src="../img/boy.png" style="max-width: 60px">
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
                    <h1 class="h3 mb-0 text-gray-800">??????????????? ??????</h1>
                </div>

                <div id="map" style="width:1200px;height:500px;"></div>

                <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=3eaf5b2da4931b0cb10a1266b1502421"></script>
                <script>
                    var mapContainer = document.getElementById('map'), // ????????? ????????? div
                        mapOption = {
                            center: new kakao.maps.LatLng(37.56521, 126.98024), // ????????? ????????????
                            level: 5, // ????????? ?????? ??????
                            mapTypeId : kakao.maps.MapTypeId.ROADMAP // ????????????
                        };

                    // ????????? ????????????
                    var map = new kakao.maps.Map(mapContainer, mapOption);

                    // ????????? ????????? ???????????????
                    <%
                    for (int i = 0; i < rList.size(); i++){
                        PubParkDTO rDTO = rList.get(i);
                        if (rDTO == null){
                            rDTO = new PubParkDTO();
                        }
                    %>
                    var markerPosition = new kakao.maps.LatLng(<%=CmmUtil.nvl(rDTO.getLat())%>, <%=CmmUtil.nvl(rDTO.getLng())%>);

                    // ????????? ???????????????
                    var marker= new kakao.maps.Marker({
                        position: markerPosition,
                        map : map,
                        clickable: true
                    });

                    map.setCenter(markerPosition);
                    marker.setMap(map);


                    <% } %>
                    // ?????? ?????? ?????? ???????????? ????????????
                    var mapTypeControl = new kakao.maps.MapTypeControl();

                    // ????????? ?????? ????????? ?????? ?????? ?????? ???????????? ????????????
                    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

                    // ????????? ?????? ?????? ???????????? ????????????
                    var zoomControl = new kakao.maps.ZoomControl();

                    // ????????? ????????? ?????? ?????? ???????????? ????????????
                    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

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
                                <a href="/PRJ/Logout" class="btn btn-primary">Logout</a>
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
                            <p>??????????????? ??? ?????? ?????? ????????? ???????????????. ?????????????????????????</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Cancel</button>
                            <a href="/PRJ/deleteUser" class="btn btn-primary">Delete User</a>
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
