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
public class Request {
    private int idYeuCau;
    private Date ngayGui;
    private Date ngayTraLoi;
    private String noiDung;
    private String ghiChu;
    private String trangThai;
    private String MSSV;

    public void setMSSV(String MSSV) {
        this.MSSV = MSSV;
    }

    public String getMSSV() {
        return MSSV;
    }

   

    public void setIdYeuCau(int idYeuCau) {
        this.idYeuCau = idYeuCau;
    }

    public void setNgayGui(Date ngayGui) {
        this.ngayGui = ngayGui;
    }

    public void setNgayTraLoi(Date ngayTraLoi) {
        this.ngayTraLoi = ngayTraLoi;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public int getIdYeuCau() {
        return idYeuCau;
    }

    public Date getNgayGui() {
        return ngayGui;
    }

    public Date getNgayTraLoi() {
        return ngayTraLoi;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public String getTrangThai() {
        return trangThai;
    }
    
    
}
