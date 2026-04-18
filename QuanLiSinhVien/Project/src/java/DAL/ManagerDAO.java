/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.BillView;
import Model.Contract;
import Model.ContractView;
import Model.Facility;
import Model.ManagerDashboard;
import Model.Notification;
import Model.Request;
import Model.Room;
import Model.RoomType;
import Model.Student;
import Model.StudentDetail;
import java.beans.Statement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class ManagerDAO {

    DBContext context = new DBContext();

    public ManagerDAO() {
    }

    public int getTotalRooms(int idUser) {

        int total = 0;

        String sql = """
        SELECT COUNT(*)
            FROM Phong p
            JOIN NguoiQuanLi q ON p.IdToaNha = q.IdToaNha
            WHERE q.IdUser = ?    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getEmptyRooms(int idUser) {

        int total = 0;

        String sql = """
        SELECT COUNT(*)
        FROM (
            SELECT p.IdPhong
            FROM Phong p
            JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong
            JOIN NguoiQuanLi q ON p.IdToaNha = q.IdToaNha
            LEFT JOIN HopDong h 
                ON p.IdPhong = h.IdPhong 
                AND h.TrangThai = 'ACTIVE'
            WHERE q.IdUser = ?
            GROUP BY p.IdPhong, lp.GioiHanNguoi
            HAVING COUNT(h.IdHopDong) < lp.GioiHanNguoi
        ) AS RoomsAvailable
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getPendingRequests(int idUser) {
        int count = 0;

        String sql = """
        SELECT COUNT(*)
        FROM YeuCau y
        JOIN SinhVien sv ON y.MSSV = sv.MSSV
        JOIN HopDong hd ON sv.MSSV = hd.MSSV
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN NguoiQuanLi q ON p.IdToaNha = q.IdToaNha
        WHERE q.IdUser = ?
        AND y.TrangThai = 'PENDING'
        AND hd.TrangThai = 'ACTIVE';
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getUnpaidBills(int idUser) {
        int count = 0;

        String sql = """
        SELECT COUNT(*)
        FROM HoaDon h
        JOIN HopDong hd ON h.IdHopDong = hd.IdHopDong
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN NguoiQuanLi q ON p.IdToaNha = q.IdToaNha
        WHERE q.IdUser = ?
        AND h.TrangThai = 'UNPAID'
        AND hd.TrangThai = 'ACTIVE';
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public double getCurrentMonthRevenue(int idUser) {
        double revenue = 0;

        String sql = """
        SELECT SUM(h.SoTien)
        FROM HoaDon h
        JOIN HopDong hd ON h.IdHopDong = hd.IdHopDong
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN NguoiQuanLi q ON p.IdToaNha = q.IdToaNha
        WHERE q.IdUser = ?
        AND h.TrangThai = 'PAID'
        AND MONTH(h.NgayThanhToan) = MONTH(GETDATE())
        AND YEAR(h.NgayThanhToan) = YEAR(GETDATE());
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }

    public ManagerDashboard getManagerDashboard(int idUser) {

        ManagerDashboard dashboard = new ManagerDashboard();

        try {
            dashboard.setTongPhong(getTotalRooms(idUser));
            dashboard.setPhongConCho(getEmptyRooms(idUser));
            dashboard.setYeuCauCho(getPendingRequests(idUser));
            dashboard.setHoaDonChuaTra(getUnpaidBills(idUser));
            dashboard.setDoanhThuThang(getCurrentMonthRevenue(idUser));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dashboard;
    }

    public List<Student> getListStudent(int idUser, int offset) {

        List<Student> list = new ArrayList<>();

        String sql = """
        SELECT sv.MSSV, sv.HoTen, sv.NgaySinh,
               sv.ThongTinLienLac, sv.DiaChi, p.IdPhong
        FROM SinhVien sv
        JOIN HopDong hd ON sv.MSSV = hd.MSSV
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha
        WHERE ql.IdUser = ?
        AND hd.IdHopDong = (
                SELECT MAX(IdHopDong)
                FROM HopDong
                WHERE MSSV = sv.MSSV
        )
        ORDER BY sv.MSSV
        OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);
            st.setInt(2, offset);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                Student s = new Student();

                s.setMSSV(rs.getString("MSSV"));
                s.setHoTen(rs.getString("HoTen"));
                s.setNgaySinh(rs.getDate("NgaySinh"));
                s.setThongTinLienLac(rs.getString("ThongTinLienLac"));
                s.setDiaChi(rs.getString("DiaChi"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Student> findStudentByMSSV(int idUser, String mssv) {

        String sql = """
        SELECT sv.MSSV, sv.HoTen, sv.NgaySinh,
               sv.ThongTinLienLac, sv.DiaChi
        FROM SinhVien sv
        JOIN HopDong hd ON sv.MSSV = hd.MSSV
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha
        WHERE ql.IdUser = ?
        AND sv.MSSV = ?
    """;
        List<Student> list = new ArrayList<>();
        try (PreparedStatement st = context.connection.prepareStatement(sql)) {
            st.setInt(1, idUser);
            st.setString(2, mssv);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setMSSV(rs.getString("MSSV"));
                s.setHoTen(rs.getString("HoTen"));
                s.setNgaySinh(rs.getDate("NgaySinh"));
                s.setThongTinLienLac(rs.getString("ThongTinLienLac"));
                s.setDiaChi(rs.getString("DiaChi"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public StudentDetail getStudentDetail(int idUser, String mssv) {

        StudentDetail s = null;

        String sql = """
  SELECT 
        sv.MSSV,
        sv.HoTen,
        sv.NgaySinh,
        sv.DiaChi,
        sv.ThongTinLienLac,
    
        p.IdPhong,
        p.SoNguoiHienTai,
    
        t.TenToa,
    
        lp.GioiHanNguoi,
        lp.GiaThuePhong,
        lp.TienDienCoDinh,
        lp.TienNuocCoDinh,
    
        hd.NgayBatDau,
        hd.NgayKetThuc,
        hd.TrangThai
    
    FROM SinhVien sv
    JOIN HopDong hd ON sv.MSSV = hd.MSSV
    JOIN Phong p ON hd.IdPhong = p.IdPhong
    JOIN ToaNha t ON p.IdToaNha = t.IdToaNha
    JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong
    JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha
    
    WHERE ql.IdUser = ?
    AND sv.MSSV = ?
    AND hd.IdHopDong = (
            SELECT MAX(IdHopDong)
            FROM HopDong
            WHERE MSSV = sv.MSSV
    );
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);
            st.setString(2, mssv);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {

                s = new StudentDetail();

                s.setMssv(rs.getString("MSSV"));
                s.setHoTen(rs.getString("HoTen"));
                s.setNgaySinh(rs.getDate("NgaySinh"));
                s.setDiaChi(rs.getString("DiaChi"));
                s.setThongTinLienLac(rs.getString("ThongTinLienLac"));

                s.setSoNguoiHienTai(countStudentInRoom(mssv, idUser));
                s.setIdPhong(rs.getString("IdPhong"));

                s.setTenToa(rs.getString("TenToa"));

                s.setGioiHanNguoi(rs.getInt("GioiHanNguoi"));
                s.setGiaThuePhong(rs.getDouble("GiaThuePhong"));
                s.setTienDienCoDinh(rs.getDouble("TienDienCoDinh"));
                s.setTienNuocCoDinh(rs.getDouble("TienNuocCoDinh"));

                s.setNgayBatDau(rs.getDate("NgayBatDau"));
                s.setNgayKetThuc(rs.getDate("NgayKetThuc"));
                s.setTrangThaiHopDong(rs.getString("TrangThai"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return s;
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT 1 FROM Users WHERE Username = ?";

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // có dòng → đã tồn tại
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public void createStudent(String username, String password, String role,
            String MSSV, String hoTen, String ngaySinh,
            String gioiTinh, String thongTinLienLac, String diaChi) {

        String sqlUser = "INSERT INTO Users(Username, Password, Role) OUTPUT INSERTED.IdUser VALUES (?, ?, ?)";
        String sqlStudent = "INSERT INTO SinhVien(MSSV, HoTen, NgaySinh, ThongTinLienLac, DiaChi, IdUser) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            context.connection.setAutoCommit(false);

            int idUser;

            // ===== insert user =====
            try (PreparedStatement psUser = context.connection.prepareStatement(sqlUser)) {

                psUser.setString(1, username);
                psUser.setString(2, password);
                psUser.setString(3, role);

                try (ResultSet rs = psUser.executeQuery()) {
                    if (rs.next()) {
                        idUser = rs.getInt(1);
                    } else {
                        throw new RuntimeException("Insert User failed");
                    }
                }
            }

            // ===== insert student =====
            try (PreparedStatement psStu = context.connection.prepareStatement(sqlStudent)) {

                psStu.setString(1, MSSV);
                psStu.setString(2, hoTen);
                psStu.setDate(3, java.sql.Date.valueOf(ngaySinh));
                psStu.setString(4, thongTinLienLac);
                psStu.setString(5, diaChi);
                psStu.setInt(6, idUser);

                psStu.executeUpdate();
            }

            context.connection.commit();

        } catch (Exception e) {
            try {
                context.connection.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                context.connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public int countStudentInRoom(String mssv, int idUser) {

        int count = 0;

        String sql = """
        SELECT COUNT(*) AS SoNguoi
        FROM HopDong hd
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha

        WHERE hd.TrangThai = 'ACTIVE'
        AND hd.IdPhong = (
            SELECT IdPhong
            FROM HopDong
            WHERE MSSV = ?
        )

        AND ql.IdUser = ?
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setString(1, mssv);
            st.setInt(2, idUser);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                count = rs.getInt("SoNguoi");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public List<Room> filterRooms(int idUser, String roomId, String price, String slot, String capacity) {

        List<Room> list = new ArrayList<>();

        String sql
                = "SELECT p.IdPhong, lp.GioiHanNguoi, p.SoNguoiHienTai, lp.GiaThuePhong "
                + "FROM Phong p "
                + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                + "JOIN ToaNha tn ON p.IdToaNha = tn.IdToaNha "
                + "JOIN NguoiQuanLi ql ON tn.IdToaNha = ql.IdToaNha "
                + "WHERE ql.IdUser = ? ";

        if (roomId != null && !roomId.isEmpty()) {
            sql += " AND p.IdPhong LIKE ? ";
        }

        if (price != null && !price.isEmpty()) {

            if (price.equals("1")) {
                sql += " AND lp.GiaThuePhong < 500000 ";
            }

            if (price.equals("2")) {
                sql += " AND lp.GiaThuePhong BETWEEN 500000 AND 600000 ";
            }

            if (price.equals("3")) {
                sql += " AND lp.GiaThuePhong > 600000 ";
            }
        }

        if (slot != null && !slot.isEmpty()) {

            if (slot.equals("1")) {
                sql += " AND (lp.GioiHanNguoi - p.SoNguoiHienTai) >= 1 ";
            }

            if (slot.equals("2")) {
                sql += " AND (lp.GioiHanNguoi - p.SoNguoiHienTai) >= 2 ";
            }
        }

        // filter sức chứa
        if (capacity != null && !capacity.isEmpty()) {
            sql += " AND lp.GioiHanNguoi = ? ";
        }

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            int index = 1;

            st.setInt(index++, idUser);

            if (roomId != null && !roomId.isEmpty()) {
                st.setString(index++, "%" + roomId + "%");
            }

            if (capacity != null && !capacity.isEmpty()) {
                st.setInt(index++, Integer.parseInt(capacity));
            }

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                Room r = new Room();
                RoomType rt = new RoomType();

                rt.setGioiHanNguoi(rs.getInt("GioiHanNguoi"));
                rt.setGiaThuePhong(rs.getInt("GiaThuePhong"));
                r.setId(rs.getString("IdPhong"));
                r.setRoomType(rt);
                r.setSoNguoiHienTai(rs.getInt("SoNguoiHienTai"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Room getFullRoomByIdUser(int idUser, String idRoom) {

        String sql = """
        SELECT p.*, lp.*, c.*
        FROM Phong p
        JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong
        JOIN CSVC c ON p.MaCSVC = c.MaCSVC
        JOIN ToaNha t ON p.IdToaNha = t.IdToaNha
        JOIN NguoiQuanLi ql ON ql.IdToaNha = t.IdToaNha
        WHERE ql.IdUser = ?
        AND p.IdPhong = ?
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);
            st.setString(2, idRoom);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    Room room = new Room();
                    room.setId(rs.getString("IdPhong"));

                    // RoomType
                    RoomType rt = new RoomType();
                    rt.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                    rt.setGioiHanNguoi(rs.getInt("GioiHanNguoi"));
                    rt.setGiaThuePhong(rs.getInt("GiaThuePhong"));

                    // Facility
                    Facility f = new Facility();
                    f.setMaCSVC(rs.getInt("MaCSVC"));
                    f.setSoGiuongTang(rs.getInt("SoGiuongTang"));
                    f.setSoBanHoc(rs.getInt("SoBanHoc"));
                    f.setSoTuQuanAo(rs.getInt("SoTuQuanAo"));

                    room.setRoomType(rt);
                    room.setFacility(f);

                    return room;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Student> getStudentsByRoom(String idPhong, int idUser) {

        List<Student> list = new ArrayList<>();

        String sql = """
        SELECT s.*
        FROM SinhVien s
        JOIN HopDong h ON s.MSSV = h.MSSV
        JOIN Phong p ON h.IdPhong = p.IdPhong
        JOIN ToaNha t ON p.IdToaNha = t.IdToaNha
        JOIN NguoiQuanLi ql ON ql.IdToaNha = t.IdToaNha
        WHERE h.IdPhong = ?
        AND h.TrangThai = 'ACTIVE'
        AND ql.IdUser = ?
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setString(1, idPhong);
            st.setInt(2, idUser);

            try (ResultSet rs = st.executeQuery()) {

                while (rs.next()) {

                    Student s = new Student();
                    s.setMSSV(rs.getString("MSSV"));
                    s.setHoTen(rs.getString("HoTen"));
                    s.setNgaySinh(rs.getDate("NgaySinh"));
                    s.setThongTinLienLac(rs.getString("ThongTinLienLac"));

                    list.add(s);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<ContractView> filterContracts(int offset, String mssv, String status, int idUser) {

        List<ContractView> list = new ArrayList<>();

        String sql = """
        SELECT hd.*, sv.HoTen
        FROM HopDong hd
        JOIN SinhVien sv ON hd.MSSV = sv.MSSV
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN ToaNha tn ON p.IdToaNha = tn.IdToaNha
        JOIN NguoiQuanLi ql ON tn.IdToaNha = ql.IdToaNha
        WHERE ql.IdUser = ?
        
    """;

        if (mssv != null && !mssv.isEmpty()) {
            sql += " AND sv.MSSV LIKE ?";
        }

        if (status != null && !status.isEmpty()) {
            sql += " AND hd.TrangThai = ?";
        }
        sql += " ORDER BY hd.IdHopDong OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            int index = 1;

            st.setInt(index++, idUser);

            if (mssv != null && !mssv.isEmpty()) {
                st.setString(index++, "%" + mssv + "%");
            }

            if (status != null && !status.isEmpty()) {
                st.setString(index++, status);
            }
            st.setInt(index++, offset);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                ContractView c = new ContractView();

                c.setMSSV(rs.getString("MSSV"));
                c.setHoTen(rs.getString("HoTen"));
                c.setIdPhong(rs.getString("IdPhong"));
                c.setNgayBatDau(rs.getDate("NgayBatDau"));
                c.setNgayKetThuc(rs.getDate("NgayKetThuc"));
                c.setTrangThai(rs.getString("TrangThai"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean cancelContract(String mssv, int idUser) {

        try {

            context.connection.setAutoCommit(false);

            // giảm số người trong phòng
            String updateRoom = """
            UPDATE p
            SET SoNguoiHienTai = SoNguoiHienTai - 1
            FROM Phong p
            JOIN HopDong hd ON p.IdPhong = hd.IdPhong
            JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha
            WHERE hd.MSSV = ?
            AND ql.IdUser = ?
            AND hd.TrangThai = 'ACTIVE'
        """;

            PreparedStatement st1 = context.connection.prepareStatement(updateRoom);
            st1.setString(1, mssv);
            st1.setInt(2, idUser);

            st1.executeUpdate();

            // update trạng thái hợp đồng
            String cancelContract = """
            UPDATE hd
            SET TrangThai = 'CANCELLED'
            FROM HopDong hd
            JOIN Phong p ON hd.IdPhong = p.IdPhong
            JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha
            WHERE hd.MSSV = ?
            AND ql.IdUser = ?
            AND hd.TrangThai = 'ACTIVE'
        """;

            PreparedStatement st2 = context.connection.prepareStatement(cancelContract);

            st2.setString(1, mssv);
            st2.setInt(2, idUser);

            int rows = st2.executeUpdate();

            context.connection.commit();

            return rows > 0;

        } catch (Exception e) {

            try {
                context.connection.rollback();
            } catch (Exception ex) {
            }

            e.printStackTrace();
        }

        return false;
    }

    public boolean isStudentExists(String mssv) {
        String sql = "SELECT 1 FROM SinhVien WHERE MSSV = ?";

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {
            ps.setString(1, mssv);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isRoomExists(String roomId) {
        String sql = "SELECT 1 FROM Phong WHERE IdPhong = ?";

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {
            ps.setString(1, roomId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isRoomAvailable(String roomId) {
        String sql = """
        SELECT 1
        FROM Phong p
        JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong
        WHERE p.IdPhong = ?
        AND p.SoNguoiHienTai < lp.GioiHanNguoi
    """;

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {
            ps.setString(1, roomId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean createContract(String mssv,
            String roomId,
            String ngayBatDau,
            String ngayKetThuc,
            int idUser) {

        try {
            if (!isStudentExists(mssv) || !isRoomExists(roomId)) {
                return false;
            }

            if (!isRoomAvailable(roomId)) {
                return false;
            }
            context.connection.setAutoCommit(false);

            // tạo hợp đồng
            String insert = """
            INSERT INTO HopDong (NgayBatDau, NgayKetThuc, TrangThai, MSSV, IdPhong)
            SELECT ?, ?, 'ACTIVE', ?, p.IdPhong
            FROM Phong p
            JOIN NguoiQuanLi ql ON p.IdToaNha = ql.IdToaNha
            WHERE p.IdPhong = ?
            AND ql.IdUser = ?
        """;

            PreparedStatement st1 = context.connection.prepareStatement(insert);

            st1.setString(1, ngayBatDau);
            st1.setString(2, ngayKetThuc);
            st1.setString(3, mssv);
            st1.setString(4, roomId);
            st1.setInt(5, idUser);

            int rows = st1.executeUpdate();

            if (rows == 0) {
                context.connection.rollback();
                return false;
            }

            // tăng số người phòng
            String updateRoom = """
            UPDATE Phong
            SET SoNguoiHienTai = SoNguoiHienTai + 1
            WHERE IdPhong = ?
        """;

            PreparedStatement st2 = context.connection.prepareStatement(updateRoom);
            st2.setString(1, roomId);
            st2.executeUpdate();

            context.connection.commit();

            return true;

        } catch (Exception e) {

            try {
                context.connection.rollback();
            } catch (Exception ex) {
            }

            e.printStackTrace();
        }

        return false;
    }

    public List<BillView> filterBills(int offset, String mssv, String status, int idUser) {

        List<BillView> list = new ArrayList<>();

        String sql = """
        SELECT hdon.*, sv.MSSV, sv.HoTen
        FROM HoaDon hdon
        JOIN HopDong hd ON hdon.IdHopDong = hd.IdHopDong
        JOIN SinhVien sv ON hd.MSSV = sv.MSSV
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN ToaNha tn ON p.IdToaNha = tn.IdToaNha
        JOIN NguoiQuanLi ql ON tn.IdToaNha = ql.IdToaNha
        WHERE ql.IdUser = ?
    """;

        if (mssv != null && !mssv.isEmpty()) {
            sql += " AND sv.MSSV LIKE ?";
        }

        if (status != null && !status.isEmpty()) {
            sql += " AND hdon.TrangThai = ?";
        }

        sql += " ORDER BY hdon.IdHoaDon OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            int index = 1;

            st.setInt(index++, idUser);

            if (mssv != null && !mssv.isEmpty()) {
                st.setString(index++, "%" + mssv + "%");
            }

            if (status != null && !status.isEmpty()) {
                st.setString(index++, status);
            }

            st.setInt(index++, offset);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                BillView b = new BillView();

                b.setIdHoaDon(rs.getInt("IdHoaDon"));
                b.setMSSV(rs.getString("MSSV"));
                b.setSoTien(rs.getDouble("SoTien"));
                b.setNgayThanhToan(rs.getDate("NgayThanhToan"));
                b.setHanChot(rs.getDate("HanChot"));
                b.setTrangThai(rs.getString("TrangThai"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void createMonthlyInvoice(int idUser) {

        String sql = """
        INSERT INTO HoaDon (HanChot, SoTien, TrangThai, IdHopDong)
        SELECT 
            EOMONTH(GETDATE()),
            lp.GiaThuePhong + lp.TienDienCoDinh + lp.TienNuocCoDinh,
            'UNPAID',
            hd.IdHopDong
        FROM HopDong hd
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong
        JOIN ToaNha tn ON p.IdToaNha = tn.IdToaNha
        JOIN NguoiQuanLi ql ON tn.IdToaNha = ql.IdToaNha
        WHERE hd.TrangThai = 'ACTIVE'
        AND ql.IdUser = ?
        AND NOT EXISTS (
            SELECT 1
            FROM HoaDon h
            WHERE h.IdHopDong = hd.IdHopDong
            AND MONTH(h.HanChot) = MONTH(GETDATE())
            AND YEAR(h.HanChot) = YEAR(GETDATE())
        )
        """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Request> getRequests(String mssv, String status, int idUser, int offset) {

        List<Request> list = new ArrayList<>();

        String sql = """
        SELECT y.*
        FROM YeuCau y
        JOIN SinhVien sv ON y.MSSV = sv.MSSV
        JOIN HopDong hd ON sv.MSSV = hd.MSSV
        JOIN Phong p ON hd.IdPhong = p.IdPhong
        JOIN ToaNha tn ON p.IdToaNha = tn.IdToaNha
        JOIN NguoiQuanLi ql ON tn.IdToaNha = ql.IdToaNha
        WHERE ql.IdUser = ?
        """;

        if (mssv != null && !mssv.isEmpty()) {
            sql += " AND y.MSSV LIKE ?";
        }

        if (status != null && !status.isEmpty()) {
            sql += " AND y.TrangThai = ?";
        }

        sql += " ORDER BY y.NgayGui DESC OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            int i = 1;

            st.setInt(i++, idUser);

            if (mssv != null && !mssv.isEmpty()) {
                st.setString(i++, "%" + mssv + "%");
            }

            if (status != null && !status.isEmpty()) {
                st.setString(i++, status);
            }

            st.setInt(i++, offset);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                Request y = new Request();
                y.setIdYeuCau(rs.getInt("IdYeuCau"));
                y.setMSSV(rs.getString("MSSV"));
                y.setNoiDung(rs.getString("NoiDung"));
                y.setNgayGui(rs.getTimestamp("NgayGui"));
                y.setNgayTraLoi(rs.getTimestamp("NgayTraLoi"));
                y.setTrangThai(rs.getString("TrangThai"));
                y.setGhiChu(rs.getString("GhiChu"));

                list.add(y);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateRequest(String ghiChu, String status, int idYeuCau) {
        String sql = """
                    UPDATE YeuCau
                    SET TrangThai = ?,
                    GhiChu = ?,
                    NgayTraLoi = GETDATE()
                    WHERE IdYeuCau = ?
                    """;
        try (PreparedStatement st = context.connection.prepareStatement(sql)) {
            st.setString(1, status);
            st.setString(2, ghiChu);
            st.setInt(3, idYeuCau);

            st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Notification> getNotificationsByUserId(int idUser) {

        List<Notification> list = new ArrayList<>();

        String sql = """
                 SELECT *
                 FROM (
                     SELECT t.*, 
                            ROW_NUMBER() OVER (PARTITION BY t.NoiDung ORDER BY t.NgayGui DESC) AS rn
                     FROM ThongBao t
                     JOIN NguoiQuanLi n ON t.IdQuanLi = n.IdQuanLi
                     JOIN Users u ON u.IdUser = n.IdUser
                     WHERE u.IdUser = ?
                 ) x
                 WHERE x.rn = 1
                 ORDER BY x.NgayGui DESC
                 """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                Notification n = new Notification();

                n.setNoiDung(rs.getString("NoiDung"));
                n.setNgayGui(rs.getDate("NgayGui"));

                list.add(n);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean insertNotificationByUserId(int idUser, String noiDung) {

        String sql = """
        INSERT INTO ThongBao (NgayGui, NoiDung, MSSV, IdQuanLi)
        SELECT 
            GETDATE(),
            ?,
            sv.MSSV,
            ql.IdQuanLi
        FROM NguoiQuanLi ql
        JOIN ToaNha tn ON ql.IdToaNha = tn.IdToaNha
        JOIN Phong p ON p.IdToaNha = tn.IdToaNha
        JOIN HopDong hd ON hd.IdPhong = p.IdPhong
        JOIN SinhVien sv ON sv.MSSV = hd.MSSV
        WHERE ql.IdUser = ?
        AND hd.TrangThai = 'ACTIVE'
        """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setString(1, noiDung);
            st.setInt(2, idUser);

            int rows = st.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
