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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student/request.css">
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

                    <a href="<%=request.getContextPath()%>/student/request/create" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Yêu cầu
                    </a>



                </div>
            </div>

        </div>
        <!--Content-->
        <div class="container mt-4">

            <!-- ===== PAGE TITLE ===== -->
            <div class="mb-4">
                <h3 class="page-title">
                    <i class="bi bi-chat-dots me-2"></i>
                    Quản lý yêu cầu
                </h3>
            </div>

            <!-- ================= FORM CARD ================= -->
            <div class="card custom-card mb-4">
                <div class="card-body p-4">

                    <h5 class="fw-semibold mb-3">
                        <i class="bi bi-send me-2"></i>Gửi yêu cầu mới
                    </h5>

                    <form method="post"
                          action="${pageContext.request.contextPath}/student/request">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                Nội dung yêu cầu
                            </label>
                            <textarea name="noiDung"
                                      class="form-control rounded-3"
                                      rows="3"
                                      placeholder="Nhập nội dung yêu cầu..."
                                      required></textarea>
                        </div>
                        
                        <c:if test="${active}">
                        <div class="text-end">
                            <button type="submit"
                                    class="btn btn-primary btn-rounded px-4">
                                <i class="bi bi-send me-2"></i>Gửi yêu cầu
                            </button>
                        </div>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- ================= LIST CARD ================= -->
            <div class="card custom-card">

                <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="fw-semibold mb-0">
                        <i class="bi bi-clock-history me-2"></i>
                        Yêu cầu đã gửi
                    </h5>

                    <!-- FILTER -->
                    <form method="get"
                          action="${pageContext.request.contextPath}/student/request"
                          class="d-flex gap-2">

                        <input type="hidden" name="offset" value="0"/>

                        <select name="status" class="form-select">
                            <option value="">Tất cả</option>
                            <option value="PENDING"
                                    ${status == 'PENDING' ? 'selected' : ''}>
                                Đang chờ
                            </option>
                            <option value="APPROVED"
                                    ${status == 'APPROVED' ? 'selected' : ''}>
                                Đã duyệt
                            </option>
                            <option value="REJECTED"
                                    ${status == 'REJECTED' ? 'selected' : ''}>
                                Từ chối
                            </option>
                        </select>

                        <button class="btn btn-outline-primary btn-rounded">
                            Lọc
                        </button>
                    </form>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Ngày gửi</th>
                                <th>Nội dung</th>
                                <th>Trạng thái</th>
                                <th>Ngày trả lời</th>
                                <th>Ghi chú</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="yc" items="${requests}">
                                <tr>
                                    <td>
                                        <fmt:formatDate value="${yc.ngayGui}" pattern="dd/MM/yyyy"/>
                                    </td>

                                    <td>${yc.noiDung}</td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${yc.trangThai == 'PENDING'}">
                                                <span class="badge bg-warning text-dark">
                                                    Đang chờ
                                                </span>
                                            </c:when>
                                            <c:when test="${yc.trangThai == 'APPROVED'}">
                                                <span class="badge bg-success">
                                                    Đã duyệt
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">
                                                    Từ chối
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <fmt:formatDate value="${yc.ngayTraLoi}" pattern="dd/MM/yyyy"/>
                                    </td>

                                    <td>${yc.ghiChu}</td>
                                </tr>
                            </c:forEach>

                            <!-- EMPTY STATE -->
                            <c:if test="${empty requests}">
                                <tr>
                                    <td colspan="5" class="text-center empty-state">
                                        <i class="bi bi-inbox fs-4 d-block mb-2"></i>
                                        Bạn chưa gửi yêu cầu nào
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <c:set var="limit" value="2"/>
            <c:set var="offset" value="${empty param.offset ? 0 : param.offset}" />

            <div class="text-center my-4">

                <!-- Trang trước -->
                <c:if test="${offset > 0}">
                    <a href="request?offset=${offset - limit}"
                       class="btn btn-outline-secondary">
                        ← Trang trước
                    </a>
                </c:if>

                <!-- Trang sau -->
                <c:if test="${hasMore}">
                    <a href="request?offset=${offset + limit}"
                       class="btn btn-outline-primary">
                        Trang sau →
                    </a>
                </c:if>

            </div>

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
