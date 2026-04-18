<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản Lí Hợp Đồng</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/contracts.css">
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
                    <a href="<%=request.getContextPath()%>/manager/notifications" 
                       class="menu-item">
                        <i class="bi bi-send me-2"></i>Thông báo chung
                    </a>



                </div>
            </div>

        </div>

        <div class="page">

            <!-- HEADER -->
            <div class="top-bar">

                <div class="title">
                    <h1>Quản Lí Hợp Đồng</h1>                 
                </div>

                <button class="btn-create" onclick="openModal()">
                    + Tạo hợp đồng mới
                </button>

            </div>


            <!-- FILTER -->
            <form class="filter-box"
                  action="${pageContext.request.contextPath}/manager/contracts"
                  method="get">

                <input type="text"
                       name="MSSV"
                       placeholder="Nhập MSSV để tìm..."
                       value="${param.MSSV}">

                <select name="status">
                    <option value="">Tất cả</option>

                    <option value="ACTIVE"
                            ${param.status == 'ACTIVE' ? 'selected' : ''}>
                        Đang Thuê
                    </option>

                    <option value="CANCELLED"
                            ${param.status == 'CANCELLED' ? 'selected' : ''}>
                        Đã Hủy
                    </option>

                </select>

                <button type="submit">Lọc</button>

            </form>


            <!-- TABLE -->
            <div class="table-card">

                <table>

                    <thead>
                        <tr>
                            <th>MSSV</th>
                            <th>Họ tên</th>
                            <th>Phòng</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach items="${contracts}" var="c">

                            <tr>

                                <td>${c.MSSV}</td>
                                <td>${c.hoTen}</td>
                                <td>${c.idPhong}</td>
                                <td>${c.ngayBatDau}</td>
                                <td>${c.ngayKetThuc}</td>

                                <td>
                                    <span class="status ${c.trangThai}">
                                        ${c.trangThai}
                                    </span>
                                </td>

                                <td>

                                    <c:if test="${c.trangThai == 'ACTIVE'}">

                                        <form action="${pageContext.request.contextPath}/manager/contracts" method="post">

                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="MSSV" value="${c.MSSV}">

                                            <button type="submit"
                                                    class="btn-cancel"
                                                    onclick="return confirm('Bạn chắc chắn muốn hủy hợp đồng?')">
                                                Hủy hợp đồng
                                            </button>

                                        </form>

                                    </c:if>

                                </td>

                            </tr>

                        </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

        <c:set var="limit" value="2"/>
        <c:set var="offset" value="${empty param.offset ? 0 : param.offset}" />

        <div class="text-center my-4">
            <!-- Trang trước -->
            <c:if test="${offset > 0}">
                <a href="contracts?offset=${offset - limit}&MSSV=${param.MSSV}&status=${param.status}"
                   class="btn btn-outline-secondary">
                    ← Trang trước
                </a>
            </c:if>

            <!-- Trang sau -->
            <c:if test="${hasMore}">
                <a href="contracts?offset=${offset + limit}&MSSV=${param.MSSV}&status=${param.status}"
                   class="btn btn-outline-primary">
                    Trang sau →
                </a>
            </c:if>
        </div>
        <div id="contractModal" class="modal">

            <div class="modal-content">

                <span class="close" onclick="closeModal()">&times;</span>

                <h2>Tạo hợp đồng</h2>

                <form action="${pageContext.request.contextPath}/manager/contracts" method="post">
                    <input type="hidden" name="action" value="create">

                    <input type="text" name="mssv" placeholder="MSSV" required>

                    <input type="text" name="idPhong" placeholder="ID phòng" required>

                    <label>Ngày bắt đầu</label>
                    <input type="date" name="ngayBatDau" required>

                    <label>Ngày kết thúc</label>
                    <input type="date" name="ngayKetThuc" required>

                    <button type="submit" class="btn-submit">
                        Tạo hợp đồng
                    </button>

                </form>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>

                    function openModal() {
                        document.getElementById("contractModal").style.display = "flex";
                    }

                    function closeModal() {
                        document.getElementById("contractModal").style.display = "none";
                    }

        </script>
    </body>
</html>
