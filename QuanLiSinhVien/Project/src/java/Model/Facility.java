/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class Facility {

    private int maCSVC;
    private int soGiuongTang;
    private int soBanHoc;
    private int soTuQuanAo;

    // Constructor rỗng
    public Facility() {
    }

    // Constructor đầy đủ
    public Facility(int maCSVC, int soGiuongTang, int soBanHoc, int soTuQuanAo) {
        this.maCSVC = maCSVC;
        this.soGiuongTang = soGiuongTang;
        this.soBanHoc = soBanHoc;
        this.soTuQuanAo = soTuQuanAo;
    }

    // Getter & Setter
    public int getMaCSVC() {
        return maCSVC;
    }

    public void setMaCSVC(int maCSVC) {
        this.maCSVC = maCSVC;
    }

    public int getSoGiuongTang() {
        return soGiuongTang;
    }

    public void setSoGiuongTang(int soGiuongTang) {
        this.soGiuongTang = soGiuongTang;
    }

    public int getSoBanHoc() {
        return soBanHoc;
    }

    public void setSoBanHoc(int soBanHoc) {
        this.soBanHoc = soBanHoc;
    }

    public int getSoTuQuanAo() {
        return soTuQuanAo;
    }

    public void setSoTuQuanAo(int soTuQuanAo) {
        this.soTuQuanAo = soTuQuanAo;
    }
}
