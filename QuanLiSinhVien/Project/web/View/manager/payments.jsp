<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hóa đơn</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/payments.css">
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


        <div class="page-wrapper">

            <h1 class="page-title">Quản lí hóa đơn</h1>

            <!-- FILTER -->
            <form action="payments" method="get" class="filter-box">

                <input type="text" name="MSSV" placeholder="Tìm kiếm bằng MSSV"
                       value="${param.MSSV}" class="input-search">

                <select name="status" class="select-status">
                    <option value="">Tất cả</option>
                    <option value="PAID" ${param.status=='PAID'?'selected':''}>Đã trả</option>
                    <option value="UNPAID" ${param.status=='UNPAID'?'selected':''}>Chưa Trả</option>
                </select>


                <button class="btn-search">Lọc</button>



            </form>
            <form action="payments" method="post" style="display:inline;">
                <button type="submit" class="btn-create">
                    Tạo hóa đơn theo tháng
                </button>
            </form>

            <br>
            <br>

            <!-- TABLE -->

            <div class="table-wrapper">

                <table class="invoice-table">

                    <thead>
                        <tr>
                            <th>ID hóa đơn</th>
                            <th>MSSV</th>
                            <th>Ngày thanh toán</th>
                            <th>Hạn chót</th>
                            <th>Số tiền</th>
                            <th>Trạng thái</th>

                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach items="${payments}" var="i">

                            <tr>

                                <td>${i.idHoaDon}</td>
                                <td>${i.MSSV}</td>
                                <td>${i.ngayThanhToan}</td>
                                <td>${i.hanChot}</td>
                                <td>${i.soTien}</td>

                                <td>
                                    <span class="status ${i.trangThai}">
                                        ${i.trangThai}
                                    </span>
                                </td>
                            </tr>

                        </c:forEach>

                    </tbody>

                </table>

            </div>
            <c:set var="limit" value="2"/>
            <c:set var="offset" value="${empty param.offset ? 0 : param.offset}" />

            <div class="text-center my-4">
                <!-- Trang trước -->
                <c:if test="${offset > 0}">
                    <a href="payments?offset=${offset - limit}&MSSV=${param.MSSV}&status=${param.status}"
                       class="btn btn-outline-secondary">
                        ← Trang trước
                    </a>
                </c:if>

                <!-- Trang sau -->
                <c:if test="${hasMore}">
                    <a href="payments?offset=${offset + limit}&MSSV=${param.MSSV}&status=${param.status}"
                       class="btn btn-outline-primary">
                        Trang sau →
                    </a>
                </c:if>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
