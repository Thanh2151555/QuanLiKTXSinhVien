/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

public class Student {

    private String MSSV;
    private String hoTen;
    private Date ngaySinh;
    private String diaChi;
    private String thongTinLienLac;
    private int idUser;

    // Constructor rỗng
    public Student() {
    }
    
    public Student(String MSSV, String hoTen, Date ngaySinh,
                    String diaChi, String thongTinLienLac, int idUser) {
        this.MSSV = MSSV;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.diaChi = diaChi;
        this.thongTinLienLac = thongTinLienLac;
        this.idUser = idUser;
    }

    // Constructor không cần idUser (dùng khi hiển thị)
    public Student(String MSSV, String hoTen, Date ngaySinh,
                    String diaChi, String thongTinLienLac) {
        this.MSSV = MSSV;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.diaChi = diaChi;
        this.thongTinLienLac = thongTinLienLac;
    }

    // Getter & Setter

    public String getMSSV() {
        return MSSV;
    }

    public void setMSSV(String MSSV) {
        this.MSSV = MSSV;
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

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }
}
