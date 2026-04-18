<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông báo</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student/notification.css">
    </head>

    <body> 
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
        </div>
        <!--Content -->               
        <div class="notification-page" >

            <!-- ===== PAGE TITLE ===== -->
            <div class="notification-header">
                <h2>🔔 Thông báo</h2>
                <p>Cập nhật mới nhất từ quản lí tòa nhà</p>
            </div>

            <!-- ===== LIST ===== -->
            <div class="fb-container">

                <c:forEach var="n" items="${notificationList}">
                    <div class="fb-card">

                        <!-- Header Card -->
                        <div class="fb-header">

                            <div class="fb-avatar">     
                                ${n.mssv.substring(0,1)}
                            </div>

                            <div class="fb-author-info">
                                <div class="fb-author-name">
                                    Võ Quốc Bảo
                                </div>
                                <div class="fb-time">
                                    <fmt:formatDate value="${n.ngayGui}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>

                        </div>

                        <!-- Content -->
                        <div class="fb-content">
                            ${n.noiDung}
                        </div>

                    </div>
                </c:forEach>

                <c:if test="${empty notificationList}">
                    <div class="fb-empty">
                        Chưa có thông báo nào.
                    </div>
                </c:if>

                <c:set var="limit" value="2"/>
                <c:set var="offset" value="${empty param.offset ? 0 : param.offset}" />

                <div class="text-center my-4">

                    <!-- Trang trước -->
                    <c:if test="${offset > 0}">
                        <a href="notification?offset=${offset - limit}"
                           class="btn btn-outline-secondary">
                            ← Trang trước
                        </a>
                    </c:if>

                    <!-- Trang sau -->
                    <c:if test="${hasMore}">
                        <a href="notification?offset=${offset + limit}"
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