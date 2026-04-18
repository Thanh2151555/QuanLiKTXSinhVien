<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lí Phòng</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/rooms.css">
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
        <div class="container room-container">

            <div class="card room-card">

                <!-- HEADER -->
                <div class="room-header d-flex justify-content-between align-items-center">
                    <h4>Quản Lí Phòng Của Sinh Viên</h4>
                </div>

                <!-- FILTER BAR -->
                <form action="rooms" method="get" class="room-toolbar">

                    <input 
                        type="text"
                        name="roomId"
                        class="form-control search-box"
                        placeholder="🔍 Tìm phòng bằng id..."
                        value="${param.roomId}">

                    <select name="price" class="form-select filter-box">
                        <option value="">Tất cả giá</option>

                        <option value="1" ${param.price == '1' ? 'selected' : ''}>
                            < 700k
                        </option>

                        <option value="2" ${param.price == '2' ? 'selected' : ''}>
                            700k - 900k
                        </option>

                        <option value="3" ${param.price == '3' ? 'selected' : ''}>
                            > 900k
                        </option>
                    </select>

                    <select name="slot" class="form-select filter-box">
                        <option value="">Còn trống</option>

                        <option value="1" ${param.slot == '1' ? 'selected' : ''}>
                            ≥ 1 chỗ
                        </option>

                        <option value="2" ${param.slot == '2' ? 'selected' : ''}>
                            ≥ 2 chỗ
                        </option>
                    </select>

                    Số Người:
                    <select name="capacity">

                        <option value="">Tất cả</option>

                        <option value="2" ${param.capacity == '2' ? 'selected' : ''}>
                            2 người
                        </option>

                        <option value="4" ${param.capacity == '4' ? 'selected' : ''}>
                            4 người
                        </option>

                        <option value="6" ${param.capacity == '6' ? 'selected' : ''}>
                            6 người
                        </option>

                    </select>

                    <button class="btn btn-search">
                        Lọc
                    </button>

                </form>
                <!-- TABLE -->
                <div class="table-responsive">

                    <table class="table table-hover room-table">

                        <thead>
                            <tr>
                                <th>Phòng</th>
                                <th>Sức chứa</th>
                                <th>Tình trạng</th>
                                <th>Giá phòng</th>
                                <th width="120">Hành động</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach var="r" items="${rooms}">

                                <tr>

                                    <td class="room-id">
                                        ${r.id}
                                    </td>

                                    <td>
                                        ${r.roomType.gioiHanNguoi} People
                                    </td>

                                    <td>
                                        ${r.soNguoiHienTai}/${r.roomType.gioiHanNguoi} People

                                        <c:choose>
                                            <c:when test="${r.soNguoiHienTai < r.roomType.gioiHanNguoi}">
                                                <span style="color:green;">(Còn trống)</span>
                                            </c:when>

                                            <c:otherwise>
                                                <span style="color:red;">(Đầy)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="price">
                                        ${r.roomType.giaThuePhong} VND
                                    </td>

                                    <td>

                                        <a href="rooms/room-detail?roomId=${r.id}">
                                            <button class="btn btn-sm btn-view">
                                                Xem chi tiết
                                            </button>
                                        </a>

                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
