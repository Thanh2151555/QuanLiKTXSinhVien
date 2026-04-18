/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Payment {

    private int idHoaDon;
    private Date ngayThanhToan;
    private Date hanChot;
    private BigDecimal soTien;
    private String trangThai;
    

    // Constructor rỗng
    public Payment() {
    }

    // Constructor đầy đủ
    public Payment(int idHoaDon, Date ngayThanhToan,
            BigDecimal soTien, String trangThai) {
        this.idHoaDon = idHoaDon;
        this.ngayThanhToan = ngayThanhToan;
        this.soTien = soTien;
        this.trangThai = trangThai;
    }

    // Getter & Setter
    public int getIdHoaDon() {
        return idHoaDon;
    }

    public void setIdHoaDon(int idHoaDon) {
        this.idHoaDon = idHoaDon;
    }

    public Date getNgayThanhToan() {
        return ngayThanhToan;
    }

    public void setNgayThanhToan(Date ngayThanhToan) {
        this.ngayThanhToan = ngayThanhToan;
    }

    public BigDecimal getSoTien() {
        return soTien;
    }

    public void setSoTien(BigDecimal soTien) {
        this.soTien = soTien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public Date getHanChot() {
        return hanChot;
    }

    public void setHanChot(Date hanChot) {
        this.hanChot = hanChot;
    }
    
}
