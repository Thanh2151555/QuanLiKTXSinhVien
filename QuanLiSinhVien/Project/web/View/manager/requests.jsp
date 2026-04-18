<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Yêu cầu của sinh viên</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manager/requests.css">
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

        <!--Content-->
        <div class="page-wrapper">

            <h1 class="page-title">Quản lý yêu cầu sinh viên</h1>

            <!-- FILTER -->
            <form action="requests" method="get" class="filter-box">

                <input type="text"
                       name="MSSV"
                       placeholder="Tìm MSSV..."
                       value="${param.MSSV}"
                       class="input-search">

                <select name="status" class="select-status">

                    <option value="">Tất cả</option>
                    <option value="PENDING" ${param.status=='PENDING'?'selected':''}>Pending</option>
                    <option value="APPROVED" ${param.status=='APPROVED'?'selected':''}>Approved</option>
                    <option value="REJECTED" ${param.status=='REJECTED'?'selected':''}>Rejected</option>

                </select>

                <button class="btn-search">Lọc</button>

            </form>


            <!-- TABLE -->
            <div class="table-wrapper">

                <table class="request-table">

                    <thead>
                        <tr>


                            <th>MSSV</th>
                            <th>Nội dung</th>
                            <th>Ngày gửi</th>
                            <th>Ngày trả lời</th>
                            <th>Ghi chú</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>

                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach items="${requests}" var="r">

                            <tr>


                                <td>${r.MSSV}</td>
                                <td>${r.noiDung}</td>
                                <td>${r.ngayGui}</td>
                                <td>${r.ngayTraLoi}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty r.ghiChu}">
                                            ${r.ghiChu}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="note-empty">Chưa có</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <span class="status ${r.trangThai}">
                                        ${r.trangThai}
                                    </span>
                                </td>

                                <td>

                                    <c:if test="${r.trangThai == 'PENDING'}">

                                        <button
                                            class="btn-handle"
                                            onclick="openModal(
                                                            '${r.idYeuCau}',
                                                            '${r.MSSV}',
                                                            '${r.noiDung}',
                                                            '${r.ngayGui}'
                                                            )">
                                            Xử lí
                                        </button>

                                    </c:if>

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
                    <a href="requests?offset=${offset - limit}&MSSV=${param.MSSV}&status=${param.status}"
                       class="btn btn-outline-secondary">
                        ← Trang trước
                    </a>
                </c:if>

                <!-- Trang sau -->
                <c:if test="${hasMore}">
                    <a href="requests?offset=${offset + limit}&MSSV=${param.MSSV}&status=${param.status}"
                       class="btn btn-outline-primary">
                        Trang sau →
                    </a>
                </c:if>
            </div>

        </div>

        <!--Popup Model-->
        <div id="requestModal" class="modal">

            <div class="modal-content">

                <span class="close" onclick="closeModal()">×</span>

                <h2>Xử lí yêu cầu</h2>

                <form action="requests" method="post">

                    <input type="hidden" id="modalId" name="idYeuCau">

                    <p><b>MSSV:</b> <span id="modalMSSV"></span></p>
                    <p><b>Nội dung:</b> <span id="modalNoiDung"></span></p>
                    <p><b>Ngày gửi:</b> <span id="modalNgay"></span></p>

                    <label>Ghi chú </label>

                    <textarea name="ghiChu" class="note-box"></textarea>

                    <div class="modal-actions">

                        <button type="submit" name="action" value="APPROVED" class="btn-approve">
                            Approve
                        </button>

                        <button type="submit" name="action" value="REJECTED" class="btn-reject">
                            Reject
                        </button>

                    </div>

                </form>

            </div>

        </div>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>function openModal(id, mssv, noiDung, ngay) {

                        document.getElementById("requestModal").style.display = "block";

                        document.getElementById("modalId").value = id;
                        document.getElementById("modalMSSV").innerText = mssv;
                        document.getElementById("modalNoiDung").innerText = noiDung;
                        document.getElementById("modalNgay").innerText = ngay;

                    }

                    function closeModal() {
                        document.getElementById("requestModal").style.display = "none";
                    }
        </script>
    </body>
</html>
