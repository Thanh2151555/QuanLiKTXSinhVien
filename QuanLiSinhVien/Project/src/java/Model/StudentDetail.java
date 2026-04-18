/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class StudentDetail {

    // SinhVien
    private String mssv;
    private String hoTen;
    private Date ngaySinh;
    private String diaChi;
    private String thongTinLienLac;

    // Phong
    private String idPhong;
    private int soNguoiHienTai;

    // ToaNha
    private String tenToa;

    // LoaiPhong
    private int gioiHanNguoi;
    private double giaThuePhong;
    private double tienDienCoDinh;
    private double tienNuocCoDinh;

    // HopDong
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private String trangThaiHopDong;

    public StudentDetail() {
    }

    public String getMssv() {
        return mssv;
    }

    public void setMssv(String mssv) {
        this.mssv = mssv;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public Date getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getThongTinLienLac() {
        return thongTinLienLac;
    }

    public void setThongTinLienLac(String thongTinLienLac) {
        this.thongTinLienLac = thongTinLienLac;
    }

    public String getIdPhong() {
        return idPhong;
    }

    public void setIdPhong(String idPhong) {
        this.idPhong = idPhong;
    }

    public int getSoNguoiHienTai() {
        return soNguoiHienTai;
    }

    public void setSoNguoiHienTai(int soNguoiHienTai) {
        this.soNguoiHienTai = soNguoiHienTai;
    }

    public String getTenToa() {
        return tenToa;
    }

    public void setTenToa(String tenToa) {
        this.tenToa = tenToa;
    }

    public int getGioiHanNguoi() {
        return gioiHanNguoi;
    }

    public void setGioiHanNguoi(int gioiHanNguoi) {
        this.gioiHanNguoi = gioiHanNguoi;
    }

    public double getGiaThuePhong() {
        return giaThuePhong;
    }

    public void setGiaThuePhong(double giaThuePhong) {
        this.giaThuePhong = giaThuePhong;
    }

    public double getTienDienCoDinh() {
        return tienDienCoDinh;
    }

    public void setTienDienCoDinh(double tienDienCoDinh) {
        this.tienDienCoDinh = tienDienCoDinh;
    }

    public double getTienNuocCoDinh() {
        return tienNuocCoDinh;
    }

    public void setTienNuocCoDinh(double tienNuocCoDinh) {
        this.tienNuocCoDinh = tienNuocCoDinh;
    }

    public Date getNgayBatDau() {
        return ngayBatDau;
    }

    public void setNgayBatDau(Date ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    public Date getNgayKetThuc() {
        return ngayKetThuc;
    }

    public void setNgayKetThuc(Date ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    public String getTrangThaiHopDong() {
        return trangThaiHopDong;
    }

    public void setTrangThaiHopDong(String trangThaiHopDong) {
        this.trangThaiHopDong = trangThaiHopDong;
    }
}
