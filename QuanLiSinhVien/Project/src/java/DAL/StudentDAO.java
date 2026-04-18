/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Facility;
import Model.Notification;
import Model.Payment;
import Model.Request;
import Model.Room;
import Model.RoomType;
import Model.Student;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    DBContext context = new DBContext();

    public StudentDAO() {
    }

    public User checkUser(String username, String password) {
        User user = null;
        try {
            String sql = "SELECT * FROM Users WHERE Username = ? AND Password = ?";

            PreparedStatement st = context.connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("IdUser");
                String role = rs.getString("Role");

                user = new User(id, username, password, role);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public Student getStudentByIdUser(int idUser) {

        String sql = """
        SELECT *
        FROM SinhVien
        WHERE IdUser = ?
    """;

        try {
            PreparedStatement st = context.connection.prepareStatement(sql);
            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Student student = new Student();

                student.setMSSV(rs.getString("MSSV"));
                student.setHoTen(rs.getString("HoTen"));
                student.setNgaySinh(rs.getDate("NgaySinh"));
                student.setDiaChi(rs.getString("DiaChi"));
                student.setThongTinLienLac(rs.getString("ThongTinLienLac"));
                student.setIdUser(rs.getInt("IdUser"));

                return student;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void updateStudent(String MSSV, String hoTen,
            String ngaySinh, String diaChi, String lienLac) {

        String sql = """
        UPDATE SinhVien
        SET hoTen = ?, 
            ngaySinh = ?, 
            diaChi = ?, 
            thongTinLienLac = ?
        WHERE MSSV = ?
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql);) {

            st.setString(1, hoTen);
            st.setString(2, ngaySinh);
            st.setString(3, diaChi);
            st.setString(4, lienLac);
            st.setString(5, MSSV);

            st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Room getFullRoomByIdUser(int idUser) {

        String sql = """
        SELECT p.*, lp.*, c.*
        FROM Users u
        JOIN SinhVien s ON u.IdUser = s.IdUser
        JOIN HopDong h ON s.MSSV = h.MSSV
        JOIN Phong p ON h.IdPhong = p.IdPhong
        JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong
        JOIN CSVC c ON p.MaCSVC = c.MaCSVC
        WHERE u.IdUser = ? AND h.TrangThai = 'ACTIVE'
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            try (ResultSet rs = st.executeQuery()) {

                if (rs.next()) {

                    // ===== Room =====
                    Room room = new Room();
                    room.setId(rs.getString("IdPhong"));

                    // ===== RoomType =====
                    RoomType rt = new RoomType();
                    rt.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                    rt.setGioiHanNguoi(rs.getInt("GioiHanNguoi"));
                    rt.setGiaThuePhong(rs.getInt("GiaThuePhong"));

                    // ===== Facility =====
                    Facility f = new Facility();
                    f.setMaCSVC(rs.getInt("MaCSVC"));
                    f.setSoGiuongTang(rs.getInt("SoGiuongTang"));
                    f.setSoBanHoc(rs.getInt("SoBanHoc"));
                    f.setSoTuQuanAo(rs.getInt("SoTuQuanAo"));

                    // Gắn vào Room
                    room.setRoomType(rt);
                    room.setFacility(f);

                    return room;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Student> getStudentsByRoom(String idPhong) {

        List<Student> list = new ArrayList<>();

        String sql = """
        SELECT s.*
        FROM SinhVien s
        JOIN HopDong h ON s.MSSV = h.MSSV
        WHERE h.IdPhong = ? AND h.TrangThai = 'ACTIVE'
    """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setString(1, idPhong);

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

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Payment> getPaymentByUser(int idUser, String status, int offset) {

        List<Payment> list = new ArrayList<>();
        String sql;

        if (status == null || status.isEmpty()) {
            sql = """
            SELECT hd.*
            FROM HoaDon hd
            JOIN HopDong h ON hd.IdHopDong = h.IdHopDong
            JOIN SinhVien sv ON h.MSSV = sv.MSSV
            WHERE sv.IdUser = ?
            ORDER BY hd.IdHoaDon DESC
            OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY
        """;
        } else {
            sql = """
            SELECT hd.*
            FROM HoaDon hd
            JOIN HopDong h ON hd.IdHopDong = h.IdHopDong
            JOIN SinhVien sv ON h.MSSV = sv.MSSV
            WHERE sv.IdUser = ?
              AND hd.TrangThai = ?
            ORDER BY hd.IdHoaDon DESC
            OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY
        """;
        }

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            if (status == null || status.isEmpty()) {
                st.setInt(1, idUser);
                st.setInt(2, offset);
            } else {
                st.setInt(1, idUser);
                st.setString(2, status);
                st.setInt(3, offset);
            }

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Payment hd = new Payment();
                hd.setIdHoaDon(rs.getInt("IdHoaDon"));
                hd.setNgayThanhToan(rs.getDate("NgayThanhToan"));
                hd.setSoTien(rs.getBigDecimal("SoTien"));
                hd.setTrangThai(rs.getString("TrangThai"));
                list.add(hd);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
        
    public boolean isContractActive(int idUser) {

        String sql = """
        SELECT 1
        FROM HopDong hd
        JOIN SinhVien sv ON sv.MSSV = hd.MSSV
        WHERE sv.IdUser = ?
        AND hd.TrangThai = 'ACTIVE'
        """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public void payInvoiceByStudent(int idHoaDon, int idUser) {

        String sql = """
        UPDATE HoaDon
        SET TrangThai = 'PAID',
            NgayThanhToan = GETDATE()
        WHERE IdHoaDon = ?
        AND IdHopDong IN (
            SELECT hd.IdHopDong
            FROM HopDong hd
            JOIN SinhVien sv ON sv.MSSV = hd.MSSV
            WHERE sv.IdUser = ?
            AND hd.TrangThai = 'ACTIVE'
        )
        """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idHoaDon);
            st.setInt(2, idUser);

            st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public RoomType getPaymentItem(int idUser) {

        String sql = """
                    SELECT lp.*
                    FROM LoaiPhong lp
                    JOIN Phong p ON p.MaLoaiPhong = lp.MaLoaiPhong
                    JOIN HopDong hp ON hp.IdPhong = p.IdPhong
                    JOIN SinhVien sv ON sv.MSSV = hp.MSSV
                    JOIN Users u ON u.IdUser = sv.IdUser
                    WHERE sv.IdUser = ?                 
                     """;

        RoomType rt = new RoomType();
        try {
            PreparedStatement st = context.connection.prepareStatement(sql);
            st.setInt(1, idUser);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                rt.setGiaThuePhong(rs.getInt("GiaThuePhong"));
                rt.setTienDienCoDinh(rs.getInt("TienDienCoDinh"));
                rt.setTienNuocCoDinh(rs.getInt("TienNuocCoDinh"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rt;
    }

    public List<Request> getRequestByUserId(int idUser, String status, int offset) {

        List<Request> list = new ArrayList<>();
        String sql;

        if (status == null || status.isEmpty()) {
            sql = """
                SELECT yc.*
                FROM YeuCau yc
                JOIN SinhVien sv ON yc.MSSV = sv.MSSV
                JOIN Users u ON sv.IdUser = u.IdUser
                WHERE u.IdUser = ?
                ORDER BY yc.NgayGui DESC
                OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY             
                  """;
        } else {
            sql = """
                SELECT yc.*
                FROM YeuCau yc
                JOIN SinhVien sv ON yc.MSSV = sv.MSSV
                JOIN Users u ON sv.IdUser = u.IdUser
                WHERE u.IdUser = ? And yc.TrangThai = ?             
                ORDER BY yc.NgayGui DESC
                OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY             
                  """;
        }

        try (PreparedStatement st = context.connection.prepareStatement(sql);) {
            if (status == null || status.isEmpty()) {
                st.setInt(1, idUser);
                st.setInt(2, offset);
            } else {
                st.setInt(1, idUser);
                st.setString(2, status);
                st.setInt(3, offset);
            }

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Request yc = new Request();
                yc.setIdYeuCau(rs.getInt("IdYeuCau"));
                yc.setNgayGui(rs.getTimestamp("NgayGui"));
                yc.setNgayTraLoi(rs.getTimestamp("NgayTraLoi"));
                yc.setNoiDung(rs.getString("NoiDung"));
                yc.setTrangThai(rs.getString("TrangThai"));
                yc.setGhiChu(rs.getString("GhiChu"));
                list.add(yc);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean insertByUserId(int idUser, String noiDung) {

        String sql = """
        INSERT INTO YeuCau (NgayGui, NoiDung, TrangThai, MSSV, IdQuanLi)
                SELECT GETDATE(), ?, 'PENDING', sv.MSSV, ql.IdQuanLi
                FROM SinhVien sv
                JOIN HopDong hd ON sv.MSSV = hd.MSSV
                JOIN Phong p ON hd.IdPhong = p.IdPhong
                JOIN ToaNha tn ON p.IdToaNha = tn.IdToaNha
                JOIN NguoiQuanLi ql ON tn.IdToaNha = ql.IdToaNha
                WHERE sv.IdUser = ?
                AND hd.TrangThai = 'ACTIVE'
        """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setString(1, noiDung);
            st.setInt(2, idUser);

            int rows = st.executeUpdate();

            return rows > 0; // true nếu insert thành công

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Notification> getNotificationByIdUser(int idUser, int offset) {

        List<Notification> list = new ArrayList<>();

        String sql = """
                SELECT tb.IdThongBao, tb.NgayGui, tb.NoiDung, tb.MSSV
                FROM ThongBao tb
                JOIN SinhVien sv ON tb.MSSV = sv.MSSV
                WHERE sv.IdUser = ?
                ORDER BY tb.NgayGui DESC
                OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY    
                """;

        try (PreparedStatement st = context.connection.prepareStatement(sql)) {

            st.setInt(1, idUser);
            st.setInt(2, offset);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                Notification tb = new Notification();
                tb.setIdThongBao(rs.getInt("IdThongBao"));
                tb.setNgayGui(rs.getTimestamp("NgayGui"));
                tb.setNoiDung(rs.getString("NoiDung"));
                tb.setMssv(rs.getString("MSSV"));

                list.add(tb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
