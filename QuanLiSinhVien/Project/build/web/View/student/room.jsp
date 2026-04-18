<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Student Room</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student/room.css">
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
                       href="<%=request.getContextPath()%>/student/home">
                        <i class="bi bi-house me-2"></i>Trang chủ
                    </a>
                    <a class="menu-item"
                       href="${pageContext.request.contextPath}/student/infor">
                        <i class="bi bi-info-circle me-2"></i>Thông tin
                    </a>

                    <a class="menu-item"
                       href="<%=request.getContextPath()%>/student/notification">
                        <i class="bi bi-info-circle me-2"></i>Thông báo 
                    </a>

                    <a class="menu-item"
                       href="${pageContext.request.contextPath}/student/room">
                        <i class="bi bi-people me-2"></i>Phòng trọ
                    </a>

                    <!-- FIX lỗi href trùng -->
                    <a class="menu-item"
                       href="${pageContext.request.contextPath}/student/payment">
                        <i class="bi bi-cash me-2"></i>Theo dõi tiền trọ
                    </a>

                    <a href="<%=request.getContextPath()%>/student/request" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Yêu cầu
                    </a>
                </div>
            </div>

        </div>


        <!-- CONTENT -->

        <div class="flex-grow-1 p-4 content-area">

            <button class="btn btn-secondary mb-3" onclick="history.back()">
                <i class="bi bi-arrow-left"></i> Quay lại
            </button>
            <!-- THÔNG TIN PHÒNG -->
            <div class="card custom-card mb-4">
                <div class="card-header header-primary">
                    <i class="bi bi-door-open me-2"></i>Thông tin phòng
                </div>

                <div class="card-body">
                    <div class="row text-center">

                        <div class="col-md-4 mb-3">
                            <div class="info-box">
                                <small>ID Phòng</small>
                                <h4>${room.id}</h4>
                            </div>
                        </div>

                        <div class="col-md-4 mb-3">
                            <div class="info-box">
                                <small>Sức chứa</small>
                                <h4>${room.roomType.gioiHanNguoi} người</h4>
                            </div>
                        </div>

                        <div class="col-md-4 mb-3">
                            <div class="info-box">
                                <small>Tình trạng</small>
                                <h4>
                                    ${fn:length(studentList)}
                                    /
                                    ${room.roomType.gioiHanNguoi}
                                </h4>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <div class="row">

                <!-- DANH SÁCH -->
                <div class="col-lg-7 mb-4">
                    <div class="card custom-card h-100">

                        <div class="card-header header-dark">
                            <i class="bi bi-people-fill me-2"></i>
                            Thành viên trong phòng
                        </div>

                        <div class="card-body p-0">
                            <table class="table table-hover mb-0">

                                <thead class="table-light">
                                    <tr>
                                        <th>MSSV</th>
                                        <th>Họ tên</th>
                                        <th>Ngày sinh</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:forEach var="s" items="${studentList}">
                                        <tr>
                                            <td>${s.MSSV}</td>
                                            <td>${s.hoTen}</td>
                                            <td>
                                                <fmt:formatDate value="${s.ngaySinh}" pattern="dd/MM/yyyy"/>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty studentList}">
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-4">
                                                Chưa có sinh viên nào trong phòng
                                            </td>
                                        </tr>
                                    </c:if>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <!-- CƠ SỞ VẬT CHẤT -->
                <div class="col-lg-5 mb-4">
                    <div class="card custom-card h-100">

                        <div class="card-header header-secondary">
                            <i class="bi bi-house-gear-fill me-2"></i>
                            Cơ sở vật chất
                        </div>

                        <div class="card-body facility-box">

                            <div class="facility-item">
                                <span>Giường tầng</span>
                                <span class="badge bg-info">${room.facility.soGiuongTang}</span>
                            </div>

                            <div class="facility-item">
                                <span>Bàn học</span>
                                <span class="badge bg-info">${room.facility.soBanHoc}</span>
                            </div>

                            <div class="facility-item">
                                <span>Tủ quần áo</span>
                                <span class="badge bg-info">${room.facility.soTuQuanAo}</span>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>