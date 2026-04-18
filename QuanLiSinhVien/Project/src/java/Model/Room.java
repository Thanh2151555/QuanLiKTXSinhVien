/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class Room {
    private String id;
    private int soNguoiHienTai;

    public void setSoNguoiHienTai(int soNguoiHienTai) {
        this.soNguoiHienTai = soNguoiHienTai;
    }

    public int getSoNguoiHienTai() {
        return soNguoiHienTai;
    }
    private RoomType roomType;
    private Facility facility;

    public Room() {
    }

    public void setRoomType(RoomType roomType) {
        this.roomType = roomType;
    }

    public void setFacility(Facility facility) {
        this.facility = facility;
    }

    public RoomType getRoomType() {
        return roomType;
    }

    public Facility getFacility() {
        return facility;
    }
  
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
}
