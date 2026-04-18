<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/student-detail.css">
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
                    <a href="<%=request.getContextPath()%>/manager/notifications" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Thông báo chung
                    </a>



                </div>
            </div>

        </div>

        <div class="container mt-5 student-container">
            <button class="btn btn-secondary mb-3" onclick="history.back()">
                <i class="bi bi-arrow-left"></i> Quay lại
            </button>
            <div class="card shadow-lg student-card">

                <!-- HEADER -->

                <div class="student-header text-center">

                    <div class="avatar">
                        SV
                    </div>

                    <h4>${detail.hoTen}</h4>

                    <p class="text-muted">
                        MSSV: ${detail.mssv}
                    </p>

                </div>


                <div class="card-body">

                    <div class="row g-4">

                        <!-- LEFT SIDE -->

                        <div class="col-md-6">

                            <div class="info-box">

                                <h5 class="section-title">
                                    Thông tin cá nhân
                                </h5>

                                <div class="info-row">
                                    <span>Ngày sinh</span>
                                    <p>${detail.ngaySinh}</p>
                                </div>

                                <div class="info-row">
                                    <span>Địa chỉ</span>
                                    <p>${detail.diaChi}</p>
                                </div>

                                <div class="info-row">
                                    <span>Liên lạc</span>
                                    <p>${detail.thongTinLienLac}</p>
                                </div>

                            </div>

                        </div>


                        <!-- RIGHT SIDE -->

                        <div class="col-md-6">

                            <div class="info-box">

                                <h5 class="section-title">
                                    Thông tin phòng
                                </h5>

                                <div class="info-row">
                                    <span>Phòng</span>
                                    <p>${detail.idPhong}</p>
                                </div>

                                <div class="info-row">
                                    <span>Tòa</span>
                                    <p>${detail.tenToa}</p>
                                </div>



                                <div class="info-row">
                                    <span>Giá phòng</span>
                                    <p class="price">
                                        ${detail.giaThuePhong} VND
                                    </p>
                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- CONTRACT -->

                    <div class="contract-box mt-4">

                        <h5>Hợp đồng</h5>

                        <p>

                            ${detail.ngayBatDau}

                            →

                            ${detail.ngayKetThuc}

                        </p>

                        <c:choose>

                            <c:when test="${detail.trangThaiHopDong=='ACTIVE'}">

                                <span class="badge bg-success">
                                    ACTIVE
                                </span>

                            </c:when>

                            <c:otherwise>

                                <span class="badge bg-danger">
                                    CANCELLED
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </div>

        </div>              

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>