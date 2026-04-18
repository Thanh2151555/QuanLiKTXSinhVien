<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lí Sinh Viên</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/students.css">
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

        <!-- CONTENT -->
        <div class="content d-flex justify-content-center">


            <div class="container mt-4" style="max-width:1000px">
                
                <!-- TITLE -->
                <div class="mb-4 text-center">
                    <h2 class="fw-bold">Quản Lí Sinh Viên</h2>
                    <p class="text-muted">Tìm kiếm và quản lí thông tin của sinh viên</p>
                </div>
                <!-- NÚT TẠO SINH VIÊN -->
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/manager/create-student"
                       class="btn btn-success">
                        <i class="bi bi-person-plus"></i>
                        Tạo tài khoản sinh viên
                    </a>
                </div>
                <!-- SEARCH -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">

                        <form action="${pageContext.request.contextPath}/manager/students" method="get" class="row g-2">

                            <div class="col-md-10">
                                <input
                                    type="text"
                                    name="MSSV"
                                    class="form-control"
                                    placeholder="Nhập MSSV để tìm"
                                    value="${param.MSSV}"
                                    >
                            </div>

                            <div class="col-md-2 d-grid">
                                <button class="btn btn-primary">
                                    Tìm kiếm
                                </button>
                            </div>

                        </form>

                    </div>
                </div>

                <!-- TABLE -->
                <div class="card shadow-sm">

                    <div class="card-header bg-primary text-white">
                        Danh sách sinh viên
                    </div>

                    <div class="card-body p-0">

                        <div class="table-responsive">

                            <table class="table table-hover mb-0 text-center">

                                <thead class="table-light">
                                    <tr>
                                        <th>MSSV</th>
                                        <th>Họ Tên</th>
                                        <th>Ngày Sinh</th>
                                        <th>Liên Lạc</th>
                                        <th>Địa Chỉ</th>
                                        <th>Hành Động</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:choose>

                                        <c:when test="${not empty students}">

                                            <c:forEach var="s" items="${students}">

                                                <tr>

                                                    <td>${s.MSSV}</td>

                                                    <td>${s.hoTen}</td>

                                                    <td>${s.ngaySinh}</td>

                                                    <td>${s.thongTinLienLac}</td>

                                                    <td>${s.diaChi}</td>

                                                    <td>

                                                        <a href="students/student-detail?mssv=${s.MSSV}"
                                                           class="btn btn-sm btn-warning">
                                                            Chi tiết
                                                        </a>
                                                    </td>

                                                </tr>

                                            </c:forEach>

                                        </c:when>

                                        <c:otherwise>

                                            <tr>
                                                <td colspan="6" class="text-muted p-4 text-center">
                                                    No students found
                                                </td>
                                            </tr>

                                        </c:otherwise>

                                    </c:choose>

                                </tbody>

                            </table>

                        </div>

                    </div>

                </div>

                <c:set var="limit" value="4"/>
                <c:set var="offset" value="${empty param.offset ? 0 : param.offset}" />

                <div class="text-center my-4">

                    <!-- Trang trước -->
                    <c:if test="${offset > 0}">
                        <a href="students?offset=${offset - limit}"
                           class="btn btn-outline-secondary">
                            ← Trang trước
                        </a>
                    </c:if>

                    <!-- Trang sau -->
                    <c:if test="${hasMore}">
                        <a href="students?offset=${offset + limit}"
                           class="btn btn-outline-primary">
                            Trang sau →
                        </a>
                    </c:if>

                </div>


            </div>

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
