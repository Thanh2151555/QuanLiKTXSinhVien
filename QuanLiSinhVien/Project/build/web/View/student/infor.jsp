<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin sinh viên</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student/infor.css">
    </head>

    <body>

        <!-- ===== TOAST SUCCESS ===== -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="toast-container position-fixed top-0 end-0 p-3">
                <div id="successToast"
                     class="toast align-items-center text-bg-success border-0"
                     role="alert">

                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="bi bi-check-circle me-2"></i>
                            ${sessionScope.successMessage}
                        </div>
                        <button type="button"
                                class="btn-close btn-close-white me-2 m-auto"
                                data-bs-dismiss="toast"></button>
                    </div>
                </div>
            </div>

            <c:remove var="successMessage" scope="session"/>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var toastEl = document.getElementById("successToast");
                    var toast = new bootstrap.Toast(toastEl, {delay: 1500});
                    toast.show();
                });
            </script>
        </c:if>

        <!-- ===== NAVBAR ===== -->
        <nav class="navbar bg-white border-bottom px-3 d-flex justify-content-between">
            <div class="d-flex align-items-center">
                <button class="btn btn-outline-primary"
                        data-bs-toggle="offcanvas"
                        data-bs-target="#sidebar">
                    <i class="bi bi-list"></i>
                </button>
                <span class="navbar-brand ms-2">KÝ TÚC XÁ</span>
            </div>

            <form action="${pageContext.request.contextPath}/logout" method="post">
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


            <!-- ===== CONTENT ===== -->
            <div class="flex-grow-1 content-area py-4">

                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-md-10">

                            <div class="card custom-card shadow-sm">

                                <div class="card-header header-primary">
                                    <i class="bi bi-person-circle me-2"></i>
                                    Hồ sơ sinh viên
                                </div>

                                <div class="card-body p-4">

                                    <form action="${pageContext.request.contextPath}/student/infor" method="post">

                                        <!-- MSSV -->
                                        <div class="mb-4 text-center">
                                            <small class="text-muted">Mã số sinh viên</small>
                                            <h4 class="mt-2 text-primary fw-bold">${student.MSSV}</h4>
                                        </div>

                                        <!-- ROW 1 -->
                                        <div class="row g-4">

                                            <div class="col-md-6">
                                                <label class="form-label">Họ và tên</label>
                                                <c:choose>
                                                    <c:when test="${edit == 'true'}">
                                                        <input type="text"
                                                               name="hoTen"
                                                               class="form-control"
                                                               value="${student.hoTen}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="form-control bg-light">
                                                            ${student.hoTen}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Ngày sinh</label>
                                                <c:choose>
                                                    <c:when test="${edit == 'true'}">
                                                        <input type="date"
                                                               name="ngaySinh"
                                                               class="form-control"
                                                               value="${student.ngaySinh}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="form-control bg-light">
                                                            <fmt:formatDate value="${student.ngaySinh}" pattern="dd/MM/yyyy"/>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                        </div>

                                        <!-- ROW 2 -->
                                        <div class="row g-4 mt-1">

                                            <div class="col-md-6">
                                                <label class="form-label">Địa chỉ</label>
                                                <c:choose>
                                                    <c:when test="${edit == 'true'}">
                                                        <input type="text"
                                                               name="diaChi"
                                                               class="form-control"
                                                               value="${student.diaChi}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="form-control bg-light">
                                                            ${student.diaChi}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label">Thông tin liên lạc</label>
                                                <c:choose>
                                                    <c:when test="${edit == 'true'}">
                                                        <input type="text"
                                                               name="thongTinLienLac"
                                                               class="form-control"
                                                               value="${student.thongTinLienLac}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="form-control bg-light">
                                                            ${student.thongTinLienLac}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                        </div>

                                        <!-- BUTTON -->
                                        <c:if test="${active}">
                                            <div class="text-end mt-4">
                                                <c:choose>
                                                    <c:when test="${edit == 'true'}">
                                                        <button class="btn btn-success px-4">
                                                            <i class="bi bi-check-circle me-1"></i> Lưu thay đổi
                                                        </button>
                                                        <a href="infor" class="btn btn-outline-secondary ms-2">
                                                            Hủy
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="infor?edit=true" class="btn btn-primary px-4">
                                                            <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:if>

                                    </form>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>