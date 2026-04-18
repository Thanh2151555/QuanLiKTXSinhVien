package Model;

import java.math.BigDecimal;

/**
 *
 * @author Admin
 */
public class RoomType {

    private int maLoaiPhong;
    private int gioiHanNguoi;
    private int giaThuePhong;
    private int tienDienCoDinh;
    private int tienNuocCoDinh;

    // Constructor rỗng
    public RoomType() {
    }

    // Constructor đầy đủ
    public RoomType(int maLoaiPhong, int gioiHanNguoi,
            int giaThuePhong) {
        this.maLoaiPhong = maLoaiPhong;
        this.gioiHanNguoi = gioiHanNguoi;
        this.giaThuePhong = giaThuePhong;
    }

    public int getMaLoaiPhong() {
        return maLoaiPhong;
    }

    public void setMaLoaiPhong(int maLoaiPhong) {
        this.maLoaiPhong = maLoaiPhong;
    }

    public int getGioiHanNguoi() {
        return gioiHanNguoi;
    }

    public void setGioiHanNguoi(int gioiHanNguoi) {
        this.gioiHanNguoi = gioiHanNguoi;
    }

    public int getGiaThuePhong() {
        return giaThuePhong;
    }

    public void setGiaThuePhong(int giaThuePhong) {
        this.giaThuePhong = giaThuePhong;
    }

    public void setTienDienCoDinh(int tienDienCoDinh) {
        this.tienDienCoDinh = tienDienCoDinh;
    }

    public void setTienNuocCoDinh(int tienNuocCoDinh) {
        this.tienNuocCoDinh = tienNuocCoDinh;
    }

    public int getTienDienCoDinh() {
        return tienDienCoDinh;
    }

    public int getTienNuocCoDinh() {
        return tienNuocCoDinh;
    }

}
