<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Student Home</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/student/home.css">
    </head>

    <body>

        <!-- TOP BAR -->
        <nav class="navbar bg-white border-bottom px-3">
            <button class="btn btn-outline-primary"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#sidebar">
                <i class="bi bi-list"></i>
            </button>
            <span class="navbar-brand ms-2">KÝ TÚC XÁ FPT CƠ SỞ HÒA LẠC</span>
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


        <div class="dashboard-container">

            <!-- LỊCH -->
            <div class="card-box">
                <div class="card shadow-lg">

                    <h5 class="card-title text-center"
                        id="calendar-title"></h5>

                    <table class="table table-bordered text-center calendar">
                        <thead>
                            <tr>
                                <th>CN</th>
                                <th>T2</th>
                                <th>T3</th>
                                <th>T4</th>
                                <th>T5</th>
                                <th>T6</th>
                                <th>T7</th>
                            </tr>
                        </thead>

                        <tbody id="calendar-body"></tbody>

                    </table>

                </div>
            </div>


            <!-- NỘI QUY -->
            <div class="card-box">
                <div class="card shadow-lg rules-card">

                    <h5 class="rules-title">
                        <i class="bi bi-exclamation-circle"></i>
                        Nội quy ký túc xá
                    </h5>

                    <ul class="rules-list">

                        <li>🕒 Không gây ồn sau 22h</li>
                        <li>🚭 Không hút thuốc trong phòng</li>
                        <li>🧹 Giữ vệ sinh phòng</li>
                        <li>👥 Không cho người ngoài ở lại</li>
                        <li>⚡ Tắt điện khi ra khỏi phòng</li>

                    </ul>
                    <!-- Link chi tiết -->
                    <div class="rules-link">
                        <a href="https://fap.fpt.edu.vn/temp/Regulations/QD%20272_new.pdf" target="_blank">
                            Xem nội quy đầy đủ
                            <i class="bi bi-box-arrow-up-right"></i>
                        </a>
                    </div>
                </div>
            </div>

        </div>
        <c:if test="${!active}">
            <div class="contract-expired-warning">
                ⚠ Hợp đồng đã hết hạn! 
                Các chức năng 'Thực Hiện Thay Đổi' sẽ không hoạt động.
            </div>
        </c:if>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const today = new Date();
        const year = today.getFullYear();
        const month = today.getMonth();
        const date = today.getDate();

        const firstDay = new Date(year, month, 1).getDay();
        const lastDate = new Date(year, month + 1, 0).getDate();

        const monthNames = [
            "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4",
            "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8",
            "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"
        ];

        document.getElementById("calendar-title").innerText =
                monthNames[month] + " " + year;

        const calendarBody = document.getElementById("calendar-body");
        calendarBody.innerHTML = "";

        let row = document.createElement("tr");

        for (let i = 0; i < firstDay; i++) {
            row.appendChild(document.createElement("td"));
        }

        for (let d = 1; d <= lastDate; d++) {
            const cell = document.createElement("td");
            cell.innerText = d;

            if (d === date) {
                cell.classList.add("today");
            }

            row.appendChild(cell);

            if ((firstDay + d) % 7 === 0) {
                calendarBody.appendChild(row);
                row = document.createElement("tr");
            }
        }

        calendarBody.appendChild(row);
    </script>

</html>
