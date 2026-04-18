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
public class BillView {
    private int idHoaDon;
    private Date ngayThanhToan;
    private Date hanChot;
    private double soTien;
    private String trangThai;
    private String MSSV;

    public int getIdHoaDon() {
        return idHoaDon;
    }

    public Date getNgayThanhToan() {
        return ngayThanhToan;
    }

    public Date getHanChot() {
        return hanChot;
    }

    public double getSoTien() {
        return soTien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public String getMSSV() {
        return MSSV;
    }

    public void setIdHoaDon(int idHoaDon) {
        this.idHoaDon = idHoaDon;
    }

    public void setNgayThanhToan(Date ngayThanhToan) {
        this.ngayThanhToan = ngayThanhToan;
    }

    public void setHanChot(Date hanChot) {
        this.hanChot = hanChot;
    }

    public void setSoTien(double soTien) {
        this.soTien = soTien;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public void setMSSV(String MSSV) {
        this.MSSV = MSSV;
    }
}
