/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

public class Notification {
    private int idThongBao;
    private Date ngayGui;
    private String noiDung;
    private String mssv;

    public void setIdThongBao(int idThongBao) {
        this.idThongBao = idThongBao;
    }

    public void setNgayGui(Date ngayGui) {
        this.ngayGui = ngayGui;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public void setMssv(String mssv) {
        this.mssv = mssv;
    }
    
    public int getIdThongBao() {
        return idThongBao;
    }

    public Date getNgayGui() {
        return ngayGui;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public String getMssv() {
        return mssv;
    }
    
}
