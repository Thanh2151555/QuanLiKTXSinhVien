/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

public class ContractView {
    private String MSSV;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private String trangThai;
    private String hoTen;
    private String idPhong;

    public String getMSSV() {
        return MSSV;
    }

    public void setMSSV(String MSSV) {
        this.MSSV = MSSV;
    }

   

    public Date getNgayBatDau() {
        return ngayBatDau;
    }

    public Date getNgayKetThuc() {
        return ngayKetThuc;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public String getHoTen() {
        return hoTen;
    }

    public String getIdPhong() {
        return idPhong;
    }

    

    public void setNgayBatDau(Date ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    public void setNgayKetThuc(Date ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public void setIdPhong(String idPhong) {
        this.idPhong = idPhong;
    }
}
