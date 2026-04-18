<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/home.css">
    </head>
    <body>
        <nav class="navbar bg-white border-bottom px-3 d-flex justify-content-between">
            <div class="d-flex align-items-center">
                <button class="btn btn-outline-primary"
                        data-bs-toggle="offcanvas"
                        data-bs-target="#sidebar">
                    <i class="bi bi-list"></i>
                </button>
                <span class="navbar-brand ms-2">KÝ TÚC XÁ</span>
            </div>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="mb-0">
                <button class="btn btn-outline-danger">
                    <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                </button>
            </form>
        </nav>


        <div class="d-flex">

            <!-- SIDEBAR -->
            <div class="offcanvas offcanvas-start sidebar" tabindex="-1" id="sidebar">

                <div class="offcanvas-header">
                    <h5 class="offcanvas-title">Menu</h5>
                    <button class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>

                <div class="offcanvas-body p-0">
                    <a class="menu-item"
                       href="<%=request.getContextPath()%>/manager/home">
                        <i class="bi bi-house me-2"></i>Trang chủ
                    </a>
                    <a class="menu-item"
                       href="<%=request.getContextPath()%>/manager/students">
                        <i class="bi bi-info-circle me-2"></i>Quản Lí Sinh Viên
                    </a>

                    <a class="menu-item"
                       href="${pageContext.request.contextPath}/manager/rooms">
                        <i class="bi bi-people me-2"></i>Quản Lí Phòng
                    </a>
                    <a class="menu-item"
                       href="${pageContext.request.contextPath}/manager/contracts">
                        <i class="bi bi-cash me-2"></i>Quản Lí Hợp Đồng
                    </a>

                    <a href="<%=request.getContextPath()%>/manager/payments" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Quản Lí Hóa Đơn
                    </a>

                    <a href="<%=request.getContextPath()%>/manager/requests" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Xử Lí Yêu Cầu
                    </a>
                    </a>
                    <a href="<%=request.getContextPath()%>/manager/notifications" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Thông báo chung
                    </a>



                </div>
            </div>

        </div>

        <div class="dashboard-wrapper">

            <div class="container manager-dashboard">

                <!-- TITLE -->
                <h2 class="dashboard-title">
                    📊 Tổng quan quản lí
                </h2>

                <!-- ===== STATS ===== -->
                <div class="stats-grid">

                    <div class="stat-card bi bi-building">
                        <p>Tổng phòng</p>
                        <h3>${md.tongPhong} </h3>

                    </div>


                    <div class="stat-card bi bi-door-open">
                        <p>Phòng còn chỗ</p>
                        <h3>${md.phongConCho}</h3>

                    </div>

                    <div class="stat-card bi bi-receipt">
                        <p>Yêu cầu chờ</p>
                        <h3>${md.yeuCauCho} </h3>

                    </div>

                    <div class="stat-card unpaid bi bi-clock-history">
                        <p>Hóa đơn chưa trả</p>
                        <h3>${md.hoaDonChuaTra} </h3>

                    </div>



                </div>


                <!-- ===== CHART ===== -->
                <div class="chart-wrapper">

                    <div class="dashboard-card stat-card revenue-card">

                        <div class="revenue-title">
                            📈 Doanh thu tháng này
                        </div>

                        <div class="revenue-value">
                            ${md.doanhThuThang} VNĐ
                        </div>

                        <div class="revenue-sub">
                            Cập nhật theo các hóa đơn đã thanh toán
                        </div>

                    </div>

                </div>

            </div>

        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
