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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student/payment.css">
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
        <!--Content-->
        <div class="main-content">
            <div class="container-fluid">

                <div class="page-title mb-4">
                    <h2><i class="bi bi-receipt me-2"></i>Quản lý hóa đơn</h2>
                </div>

                <!-- FILTER BAR -->
                <div class="filter-bar mb-3">

                    <form method="get" action="${pageContext.request.contextPath}/student/payment">
                        <input type="hidden" name="offset" value="0"/>

                        <select name="status" class="form-select">
                            <option value="">Tất cả trạng thái</option>
                            <option value="UNPAID"
                                    ${status == 'UNPAID' ? 'selected' : ''}>
                                Chưa thanh toán
                            </option>
                            <option value="PAID"
                                    ${status == 'PAID' ? 'selected' : ''}>
                                Đã thanh toán
                            </option>
                        </select>
                        <br>        
                        <button class="btn btn-primary">Lọc</button>
                    </form>

                </div>

                <!-- TABLE -->

                <div class="card shadow-sm rounded-4 border-0">
                    <div class="card-body p-0">

                        <table class="table table-hover align-middle mb-0">

                            <thead class="table-light">
                                <tr>
                                    <th>Mã Hóa Đơn</th>
                                    <th>Ngày Thanh Toán </th>
                                    <th>Hạn Chót</th>
                                    <th>Số Tiền</th>
                                    <th>Trạng Thái</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>

                            <tbody id="invoiceTable">

                                <c:forEach var="hd" items="${payments}" >
                                    <tr class="invoice-row">

                                        <td><strong>#${hd.idHoaDon}</strong></td>

                                        <td>
                                            <fmt:formatDate value="${hd.ngayThanhToan}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${hd.hanChot}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${hd.soTien}" type="number" groupingUsed="true"/> VNĐ
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${hd.trangThai == 'UNPAID'}">
                                                    <span class="badge bg-danger">
                                                        Chưa thanh toán
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">
                                                        Đã thanh toán
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="text-center action-buttons">

                                            <button class="btn btn-sm btn-outline-primary"
                                                    data-bs-toggle="collapse"
                                                    data-bs-target="#detail-${hd.idHoaDon}">
                                                Chi tiết
                                            </button>

                                            <c:if test="${active and hd.trangThai == 'UNPAID'}">
                                                <form action="${pageContext.request.contextPath}/student/payment" method="post">
                                                    <input type="hidden" name="idHoaDon" value="${hd.idHoaDon}">
                                                    <button class="btn-pay">
                                                        💳 Thanh toán
                                                    </button>
                                                </form>
                                            </c:if>

                                        </td>

                                    </tr>
                                    <!-- DÒNG ẨN -->
                                    <tr class="collapse" id="detail-${hd.idHoaDon}">
                                        <td colspan="5" class="bg-light p-3">

                                            <div class="row">
                                                <div class="col-md-4">
                                                    💰 <strong>Giá phòng: ${roomType.giaThuePhong}</strong> 
                                                </div>

                                                <div class="col-md-4">
                                                    ⚡ <strong>Tiền điện: ${roomType.tienDienCoDinh}</strong> 
                                                </div>
                                                <div class="col-md-4">
                                                    💧 <strong>Tiền CSVC: ${roomType.tienNuocCoDinh}</strong> 
                                                </div>
                                            </div>                                          
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty payments}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            Không có hóa đơn
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
                        <a href="payement?offset=${offset - limit}"
                           class="btn btn-outline-secondary">
                            ← Trang trước
                        </a>
                    </c:if>

                    <!-- Trang sau -->
                    <c:if test="${hasMore}">
                        <a href="payment?offset=${offset + limit}"
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
