<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tạo tài khoản sinh viên</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/create-student.css">
    </head>
    <body>
        <!-- ===== TOAST SUCCESS ===== -->
        <c:if test="${not empty requestScope.message}">
            <div class="toast-container position-fixed top-0 end-0 p-3">
                <div id="successToast"
                     class="toast align-items-center text-bg-success border-0"
                     role="alert">

                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="bi bi-check-circle me-2"></i>
                            ${requestScope.message}
                        </div>
                        <button type="button"
                                class="btn-close btn-close-white me-2 m-auto"
                                data-bs-dismiss="toast"></button>
                    </div>
                </div>
            </div>

            <c:remove var="message" scope="request"/>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var toastEl = document.getElementById("successToast");
                    var toast = new bootstrap.Toast(toastEl, {delay: 1500});
                    toast.show();
                });
            </script>
        </c:if>
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

        <div class="container create-student-container">

            <div class="card create-student-card">

                <div class="card-header">
                    <h4>
                        <i class="bi bi-person-plus"></i>
                        Tạo tài khoản sinh viên
                    </h4>
                </div>

                <div class="card-body">

                    <form action="create-student" method="post">

                        <!-- role ẩn -->
                        <input type="hidden" name="role" value="STUDENT">

                        <!-- ================= LOGIN INFO ================= -->
                        <div class="form-section">
                            <h5 class="section-title">
                                <i class="bi bi-person-lock"></i> Thông tin đăng nhập
                            </h5>

                            <div class="row">

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Tài khoản</label>
                                    <input type="text" name="username" class="form-control" required>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Mật khẩu</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>

                            </div>
                        </div>


                        <!-- ================= STUDENT INFO ================= -->
                        <div class="form-section mt-4">
                            <h5 class="section-title">
                                <i class="bi bi-person-vcard"></i> Thông tin sinh viên
                            </h5>

                            <div class="row">

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">MSSV</label>
                                    <input type="text" name="MSSV" class="form-control" required>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Họ tên</label>
                                    <input type="text" name="hoTen" class="form-control" required>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" name="ngaySinh" class="form-control">
                                </div>



                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Thông tin liên lạc</label>
                                    <input type="text" name="thongTinLienLac" class="form-control">
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Địa chỉ</label>
                                    <input type="text" name="diaChi" class="form-control">
                                </div>

                            </div>
                        </div>


                        <div class="text-center mt-4">
                            <button class="btn btn-success create-btn">
                                <i class="bi bi-check-circle"></i>
                                Tạo tài khoản
                            </button>

                            <a href="students" class="btn btn-secondary ms-2">
                                Quay lại
                            </a>
                        </div>

                    </form>

                </div>

            </div>

        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
