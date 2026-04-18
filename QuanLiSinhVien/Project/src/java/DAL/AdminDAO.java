/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Model.Building;
import Model.Manager;
import Model.ManagerView;
import Model.RoomType;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.*;

public class AdminDAO {

    DBContext context = new DBContext();

    public List<ManagerView> getManagers(String hoTen) {

        List<ManagerView> list = new ArrayList<>();

        String sql = """
        SELECT 
        u.*,     
        ql.*,
        t.TenToa
        FROM Users u
        JOIN NguoiQuanLi ql ON u.IdUser = ql.IdUser
        JOIN ToaNha t ON ql.IdToaNha = t.IdToaNha
        WHERE u.Role = 'MANAGER'
        AND ql.HoTen LIKE ?
        ORDER BY u.Username
        """;

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ps.setString(1, "%" + (hoTen == null ? "" : hoTen) + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ManagerView m = new ManagerView();

                m.setIdUser(rs.getInt("IdUser"));
                m.setUsername(rs.getString("Username"));
                m.setHoTen(rs.getString("HoTen"));
                m.setThongTinLienLac(rs.getString("ThongTinLienLac"));
                m.setTenToa(rs.getString("TenToa"));
                m.setPassword(rs.getString("Password"));
                m.setIdToaNha(rs.getString("IdToaNha"));

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void deleteManager(int idQuanLi) {

        String sql = """
        update NguoiQuanLi
        set TrangThai = 'LOCKED'
        where IdQuanLi = ?
    """;

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ps.setInt(1, idQuanLi);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateManager(int idUser, String password,
            String hoTen, String thongTinLienLac, int idToaNha) {

        PreparedStatement psUser = null;
        PreparedStatement psManager = null;

        try {

            context.connection.setAutoCommit(false);

            // update Users
            String sqlUser = """
            UPDATE Users
            SET Password = ?
            WHERE IdUser = ?
        """;

            psUser = context.connection.prepareStatement(sqlUser);
            psUser.setString(1, password);
            psUser.setInt(2, idUser);
            psUser.executeUpdate();

            // update NguoiQuanLi
            String sqlManager = """
            UPDATE NguoiQuanLi
            SET HoTen = ?, ThongTinLienLac = ?, IdToaNha = ?
            WHERE IdUser = ?
        """;

            psManager = context.connection.prepareStatement(sqlManager);
            psManager.setString(1, hoTen);
            psManager.setString(2, thongTinLienLac);
            psManager.setInt(3, idToaNha);
            psManager.setInt(4, idUser);
            psManager.executeUpdate();

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
                if (psUser != null) {
                    psUser.close();
                }
                if (psManager != null) {
                    psManager.close();
                }
                context.connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Building> getBuilding() {
        List<Building> list = new ArrayList<>();
        String sql = """
                     SELECT *
                     From ToaNha
                     """;
        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Building b = new Building();

                b.setIdToaNha(rs.getInt("IdToaNha"));
                b.setTenToa(rs.getString("TenToa"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void createManager(String username, String password,
            String hoTen, String thongTinLienLac, int idToaNha) {

        try {

            context.connection.setAutoCommit(false);

            // 1. Insert User
            String sqlUser = """
            INSERT INTO Users (Username, Password, Role)
            VALUES (?, ?, 'MANAGER')
        """;

            PreparedStatement psUser = context.connection.prepareStatement(sqlUser);

            psUser.setString(1, username);
            psUser.setString(2, password);

            psUser.executeUpdate();

            // lấy idUser vừa tạo
            String getId = "SELECT IdUser FROM Users WHERE Username = ?";
            PreparedStatement psGet = context.connection.prepareStatement(getId);
            psGet.setString(1, username);

            ResultSet rs = psGet.executeQuery();

            int idUser = -1;

            if (rs.next()) {
                idUser = rs.getInt("IdUser");
            }

            // 2. Insert Manager
            String sqlManager = """
            INSERT INTO NguoiQuanLi (HoTen, ThongTinLienLac, IdToaNha, IdUser)
            VALUES (?, ?, ?, ?)
        """;

            PreparedStatement psManager = context.connection.prepareStatement(sqlManager);

            psManager.setString(1, hoTen);
            psManager.setString(2, thongTinLienLac);
            psManager.setInt(3, idToaNha);
            psManager.setInt(4, idUser);

            psManager.executeUpdate();

            context.connection.commit();

        } catch (Exception e) {

            try {
                context.connection.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
        }
    }

    public boolean createBuilding(String tenToa) {

        String checkSql = """
        SELECT 1 FROM ToaNha WHERE TenToa = ?
    """;

        String insertSql = """
        INSERT INTO ToaNha (TenToa)
        VALUES (?)
    """;

        try {
            // check tồn tại
            PreparedStatement psCheck = context.connection.prepareStatement(checkSql);
            psCheck.setString(1, tenToa.trim());

            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                // đã tồn tại
                return false;
            }

            // insert
            PreparedStatement psInsert = context.connection.prepareStatement(insertSql);
            psInsert.setString(1, tenToa.trim());
            psInsert.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean createRoom(String idPhong, int idToaNha, int maLoaiPhong, int maCSVC) {

        String checkSql = "SELECT 1 FROM Phong WHERE IdPhong = ?";
        String insertSql = """
            INSERT INTO Phong (IdPhong, IdToaNha, MaLoaiPhong, MaCSVC)
            VALUES (?, ?, ?, ?)
            """;

        try {

            // kiểm tra phòng đã tồn tại chưa
            PreparedStatement check = context.connection.prepareStatement(checkSql);
            check.setString(1, idPhong);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                return false; // phòng đã tồn tại
            }

            // insert phòng
            PreparedStatement ps = context.connection.prepareStatement(insertSql);
            ps.setString(1, idPhong);
            ps.setInt(2, idToaNha);
            ps.setInt(3, maLoaiPhong);
            ps.setInt(4, maCSVC);

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<RoomType> getRoomType() {
        List<RoomType> list = new ArrayList<>();
        String sql = """
                     SELECT *
                     From LoaiPhong
                     """;
        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                RoomType rt = new RoomType();

                rt.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
                rt.setGiaThuePhong(rs.getInt("GiaThuePhong"));
                rt.setTienDienCoDinh(rs.getInt("TienDienCoDinh"));
                rt.setTienNuocCoDinh(rs.getInt("TienNuocCoDinh"));

                list.add(rt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateRoomPrice(int maLoaiPhong, int giaThuePhong) {

        String sql = """
        UPDATE LoaiPhong
        SET GiaThuePhong = ?
        WHERE MaLoaiPhong = ?
    """;

        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ps.setInt(1, giaThuePhong);
            ps.setInt(2, maLoaiPhong);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void cancelExpiredContractsFull() {

        try {
            context.connection.setAutoCommit(false);

            // 1. Lấy danh sách hợp đồng hết hạn
            String select = """
            SELECT IdPhong
            FROM HopDong
            WHERE TrangThai = 'ACTIVE'
            AND NgayKetThuc < CAST(GETDATE() AS DATE)
        """;

            PreparedStatement ps1 = context.connection.prepareStatement(select);
            ResultSet rs = ps1.executeQuery();

            List<String> rooms = new ArrayList<>();

            while (rs.next()) {
                rooms.add(rs.getString("IdPhong"));
            }

            // 2. Update hợp đồng
            String updateContract = """
            UPDATE HopDong
            SET TrangThai = 'CANCELLED'
            WHERE TrangThai = 'ACTIVE'
            AND NgayKetThuc < CAST(GETDATE() AS DATE)
        """;

            PreparedStatement ps2 = context.connection.prepareStatement(updateContract);
            ps2.executeUpdate();

            // 3. Giảm số người phòng
            String updateRoom = """
            UPDATE Phong
            SET SoNguoiHienTai = SoNguoiHienTai - 1
            WHERE IdPhong = ?
        """;

            PreparedStatement ps3 = context.connection.prepareStatement(updateRoom);

            for (String roomId : rooms) {
                ps3.setString(1, roomId);
                ps3.executeUpdate();
            }

            context.connection.commit();

        } catch (Exception e) {

            try {
                context.connection.rollback();
            } catch (Exception ex) {
            }

            e.printStackTrace();
        }
    }
    
    public List<Building> getBuildings() {
        List<Building> list = new ArrayList<>();
        String sql = """
                     Select  *
                     from ToaNha
                     """;
        try (PreparedStatement ps = context.connection.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Building b = new Building();
                b.setIdToaNha(rs.getInt("IdToaNha"));
                b.setTenToa(rs.getString("TenToa"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
}
