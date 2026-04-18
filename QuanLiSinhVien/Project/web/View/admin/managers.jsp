<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách quản lí</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/managers.css">
    </head>
    <body>
        <nav class="navbar bg-white border-bottom px-3 d-flex justify-content-between">
            <div class="d-flex align-items-center">

                <span class="navbar-brand ms-2">KÝ TÚC XÁ</span>
            </div>

            <form action="${pageContext.request.contextPath}/logout" method="post" class="mb-0">
                <button class="btn btn-outline-danger">
                    <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                </button>
            </form>
        </nav>   

        <!--Content-->
        <div class="container manager-container">

            <div class="card manager-card">

                <!-- HEADER -->
                <div class="manager-header d-flex justify-content-between align-items-center">

                    <h4>
                        <i class="bi bi-people-fill"></i>
                        Quản lý Manager
                    </h4>

                    <a href="#"
                       class="btn btn-primary create-btn"
                       data-bs-toggle="modal"
                       data-bs-target="#createManagerModal">

                        <i class="bi bi-plus-circle"></i>
                        Tạo Manager
                    </a>

                </div>


                <!-- TOOLBAR -->
                <form action="managers" method="get" class="manager-toolbar">

                    <input
                        type="text"
                        name="hoTen"
                        class="form-control search-box"
                        placeholder="🔍 Tìm theo họ tên..."
                        value="${param.hoTen}">

                    <button class="btn btn-search">
                        <i class="bi bi-search"></i>
                        Tìm
                    </button>

                </form>


                <!-- TABLE -->

                <div class="table-responsive">

                    <table class="table table-hover manager-table">

                        <thead>

                            <tr>

                                <th>Username</th>
                                <th>Họ tên</th>
                                <th>Thông tin liên lạc</th>
                                <th>Tòa quản lý</th>
                                <th width="150">Action</th>

                            </tr>

                        </thead>

                        <tbody>

                            <c:forEach var="m" items="${managers}">

                                <tr>

                                    <td class="username">
                                        ${m.username}
                                    </td>

                                    <td>
                                        ${m.hoTen}
                                    </td>

                                    <td>
                                        ${m.thongTinLienLac}

                                    </td>

                                    <td>
                                        ${m.tenToa}
                                    </td>



                                    <td>
                                        <a href="#"
                                           class="btn btn-sm btn-warning"
                                           data-bs-toggle="modal"
                                           data-bs-target="#editManagerModal"

                                           data-id="${m.idUser}"
                                           data-username="${m.username}"
                                           data-hoten="${m.hoTen}"
                                           data-contact="${m.thongTinLienLac}"
                                           data-idToaNha="${m.idToaNha}"
                                           data-password="${m.password}">

                                            <i class="bi bi-pencil-square"></i>
                                            Chỉnh sửa
                                        </a>


                                    </td>


                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>
                <a class="btn btn-primary"
                   data-bs-toggle="modal"
                   data-bs-target="#createBuildingModal">

                    <i class="bi bi-building-add"></i>
                    Tạo Tòa Nhà

                </a>

            </div>

        </div>
        <hr>                
        <!--Quản lí phòng -->               
        <div class="container room-management">

            <div class="page-header">
                <h2>
                    <i class="bi bi-building"></i>
                    Quản lý phòng
                </h2>
            </div>

            <button class="btn btn-primary"
                    data-bs-toggle="modal"
                    data-bs-target="#createRoomModal">

                <i class="bi bi-plus-circle"></i>
                Tạo phòng

            </button>
            <button class="btn btn-primary"
                    data-bs-toggle="modal"
                    data-bs-target="#editPriceModal">

                <i class="bi bi-cash"></i>
                Chỉnh sửa giá phòng
            </button>

        </div>   
        <!--Sửa giá phòng-->
        <div class="modal fade" id="editPriceModal" tabindex="-1">

            <div class="modal-dialog">
                <div class="modal-content">

                    <form action="managers" method="post">

                        <input type="hidden" name="action" value="updatePrice">

                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa giá phòng</h5>

                            <!-- nút X -->
                            <button type="button"
                                    class="btn-close"
                                    data-bs-dismiss="modal">
                            </button>
                        </div>

                        <div class="modal-body">

                            <div class="mb-3">
                                <label>Loại phòng</label>

                                <select name="maLoaiPhong" class="form-select">
                                    <option value="1">Phòng 2 người</option>
                                    <option value="2">Phòng 4 người</option>
                                    <option value="3">Phòng 6 người</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label>Giá phòng</label>

                                <input type="number"
                                       name="giaThuePhong"
                                       class="form-control"
                                       placeholder="Nhập giá phòng">
                            </div>

                        </div>

                        <div class="modal-footer">

                            <!-- nút hủy -->
                            <button type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Hủy
                            </button>

                            <!-- nút submit -->
                            <button type="submit"
                                    class="btn btn-success">
                                Cập nhật
                            </button>

                        </div>

                    </form>

                </div>
            </div>

        </div>


        <!--create room -->    
        <div class="modal fade" id="createRoomModal">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form action="managers" method="post">

                        <input type="hidden" name="action" value="createRoom">

                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-door-open"></i>
                                Tạo phòng
                            </h5>
                            <button class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">

                            <div class="mb-3">
                                <label>Tên phòng</label>
                                <input type="text"
                                       name="idPhong"
                                       class="form-control"
                                       placeholder="Ví dụ: A101" required>
                            </div>

                            <div class="mb-3">
                                <label>Tòa nhà</label>

                                <select name="idToaNha" class="form-select" size="5" required>
                                    <option value="">Chọn tòa</option>
                                    <c:forEach var="b" items="${buildings}">
                                        <option value="${b.idToaNha}">
                                            ${b.tenToa}
                                        </option>
                                    </c:forEach>

                                </select>

                            </div>

                            <div class="mb-3">
                                <label>Loại phòng</label>

                                <select name="maLoaiPhong" class="form-select" required>
                                    <option value="">Chọn loại phòng</option>
                                    <option value="1">2 người</option>
                                    <option value="2">4 người</option>
                                    <option value="3">6 người</option>

                                </select>

                            </div>

                            <div class="mb-3">
                                <label>Cơ sở vật chất</label>

                                <select name="maCSVC" class="form-select" required>
                                    <option value="">Chọn CSVC</option>
                                    <option value="1">2 giường - 2 bàn học - 2 tủ quần áo(Phòng 2 người)</option>
                                    <option value="2">4 giường - 4 bàn học - 4 tủ quần áo(Phòng 4 người)</option>
                                    <option value="3">6 giường - 6 bàn học - 6 tủ quần áo(Phòng 6 người)</option>

                                </select>

                            </div>

                        </div>

                        <div class="modal-footer">

                            <button class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Hủy
                            </button>

                            <button class="btn btn-success">
                                Tạo phòng
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

        <!--Edit manager -->                
        <div class="modal fade" id="editManagerModal">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form action="managers" method="post">
                        <input type="hidden" name="action" value="update">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-pencil"></i> Chỉnh sửa Manager
                            </h5>
                            <button class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">

                            <input type="hidden" name="idUser" id="edit-id">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" name="username" class="form-control"
                                       id="edit-username" readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="text" name="password"
                                       class="form-control"
                                       id="edit-password" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Họ tên</label>
                                <input type="text" name="hoTen"
                                       class="form-control"
                                       id="edit-hoten" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Thông tin liên lạc</label>
                                <input type="text" name="thongTinLienLac"
                                       class="form-control"
                                       id="edit-contact" required>
                            </div>

                            <div class="mb-3">

                                <label class="form-label">Tòa nhà</label>

                                <select name="idToaNha" class="form-select">

                                    <option value="">-- Chọn tòa nhà --</option>

                                    <c:forEach var="b" items="${buildings}">
                                        <option value="${b.idToaNha}">
                                            ${b.tenToa}
                                        </option>
                                    </c:forEach>
                                </select>

                            </div>

                        </div>

                        <div class="modal-footer">
                            <button class="btn btn-primary">
                                Lưu thay đổi
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>


        <!--Create manager -->  
        <div class="modal fade" id="createManagerModal">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form action="managers" method="post">
                        <input type="hidden" name="action" value="createManager">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-person-plus"></i>
                                Tạo Manager
                            </h5>

                            <button class="btn-close" data-bs-dismiss="modal"></button>
                        </div>


                        <div class="modal-body">

                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" name="username"
                                       class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password"
                                       class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Họ tên</label>
                                <input type="text" name="hoTen"
                                       class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Thông tin liên lạc</label>
                                <input type="text" name="thongTinLienLac"
                                       class="form-control">
                            </div>

                            <div class="mb-3">

                                <label class="form-label">Tòa nhà</label>

                                <select name="idToaNha" class="form-select" size="5">
                                    <option value="">-- Chọn tòa nhà --</option>
                                    <c:forEach var="b" items="${buildings}">
                                        <option value="${b.idToaNha}">
                                            ${b.tenToa}
                                        </option>
                                    </c:forEach>

                                </select>

                            </div>

                        </div>


                        <div class="modal-footer">

                            <button class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Hủy
                            </button>

                            <button class="btn btn-success">
                                <i class="bi bi-check-circle"></i>
                                Tạo Manager
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>
        <!-- Tạo tòa-->
        <div class="modal fade" id="createBuildingModal">

            <div class="modal-dialog">

                <div class="modal-content">

                    <form action="managers" method="post">

                        <input type="hidden" name="action" value="createBuilding">

                        <div class="modal-header">

                            <h5 class="modal-title">
                                <i class="bi bi-building"></i>
                                Tạo Tòa Nhà
                            </h5>

                            <button class="btn-close"
                                    data-bs-dismiss="modal">
                            </button>

                        </div>


                        <div class="modal-body">

                            <div class="mb-3">

                                <label class="form-label">Tên tòa</label>

                                <input type="text"
                                       name="tenToa"
                                       class="form-control"
                                       placeholder="Ví dụ: Tòa A"
                                       required>

                            </div>

                        </div>


                        <div class="modal-footer">

                            <button class="btn btn-secondary"
                                    data-bs-dismiss="modal">
                                Hủy
                            </button>

                            <button class="btn btn-success">
                                <i class="bi bi-check-circle"></i>
                                Tạo
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>
        <table class="table table-hover manager-table">

            <thead>

                <tr>

                    <th>Id tòa</th>
                    <th>Tên tòa</th>
                    <th>Trạng thái</th>

                </tr>

            </thead>

            <tbody>

                <c:forEach var="b" items="${building1}">

                    <tr>

                        <td class="username">
                            ${b.idToaNha}
                        </td>

                        <td>
                            ${b.tenToa}
                        </td>
                        
                        <td>
                            ${b.tenToa}
                        </td>

                    </tr>

                </c:forEach>

            </tbody>

        </table>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>

            const editModal = document.getElementById('editManagerModal');

            editModal.addEventListener('show.bs.modal', function (event) {

                const button = event.relatedTarget;

                document.getElementById("edit-id").value =
                        button.getAttribute("data-id");

                document.getElementById("edit-username").value =
                        button.getAttribute("data-username");



                document.getElementById("edit-hoten").value =
                        button.getAttribute("data-hoten");

                document.getElementById("edit-contact").value =
                        button.getAttribute("data-contact");
                document.getElementById("edit-toa").value =
                        button.getAttribute("data-idToaNha");


            });

        </script>
    </body>
</html>
