CREATE DATABASE Project


CREATE TABLE Users (
    IdUser INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL 
        CHECK (Role IN ('ADMIN','MANAGER','STUDENT'))
);

CREATE TABLE ToaNha (
    IdToaNha INT PRIMARY KEY IDENTITY(1,1),
    TenToa NVARCHAR(100) NOT NULL
);

CREATE TABLE NguoiQuanLi (
    IdQuanLi INT PRIMARY KEY IDENTITY(1,1),
    HoTen NVARCHAR(100) NOT NULL,
    ThongTinLienLac NVARCHAR(100),
    IdToaNha INT NOT NULL,
    IdUser INT UNIQUE NOT NULL,

    CONSTRAINT FK_QuanLi_ToaNha 
        FOREIGN KEY (IdToaNha) REFERENCES ToaNha(IdToaNha),

    CONSTRAINT FK_QuanLi_User 
        FOREIGN KEY (IdUser) REFERENCES Users(IdUser) 
        ON DELETE CASCADE
);

CREATE TABLE SinhVien (
    MSSV VARCHAR(20) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    DiaChi NVARCHAR(255),
    ThongTinLienLac NVARCHAR(100),
    IdUser INT UNIQUE,

    CONSTRAINT FK_SinhVien_User 
        FOREIGN KEY (IdUser) REFERENCES Users(IdUser) 
        ON DELETE CASCADE
);

CREATE TABLE LoaiPhong (
    MaLoaiPhong INT PRIMARY KEY,
    GioiHanNguoi INT NOT NULL,
    GiaThuePhong DECIMAL(12,2) NOT NULL,
    TienDienCoDinh DECIMAL(12,2) NOT NULL,
    TienNuocCoDinh DECIMAL(12,2) NOT NULL
);

CREATE TABLE CSVC (
    MaCSVC INT PRIMARY KEY,
    SoGiuongTang INT NOT NULL DEFAULT 0,
    SoBanHoc INT NOT NULL DEFAULT 0,
    SoTuQuanAo INT NOT NULL DEFAULT 0
);

CREATE TABLE Phong (
    IdPhong VARCHAR(20) PRIMARY KEY,
    MaLoaiPhong INT NOT NULL,
    MaCSVC INT NOT NULL,
    IdToaNha INT NOT NULL,
    SoNguoiHienTai INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Phong_LoaiPhong 
        FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong),

    CONSTRAINT FK_Phong_CSVC 
        FOREIGN KEY (MaCSVC) REFERENCES CSVC(MaCSVC),

    CONSTRAINT FK_Phong_ToaNha 
        FOREIGN KEY (IdToaNha) REFERENCES ToaNha(IdToaNha)
);

CREATE TABLE HopDong (
    IdHopDong INT PRIMARY KEY IDENTITY(1,1),
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    TrangThai VARCHAR(20) NOT NULL 
        CHECK (TrangThai IN ('ACTIVE','CANCELLED')),
    MSSV VARCHAR(20) NOT NULL,
    IdPhong VARCHAR(20) NOT NULL,

    CONSTRAINT FK_HopDong_SinhVien 
        FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV),

    CONSTRAINT FK_HopDong_Phong 
        FOREIGN KEY (IdPhong) REFERENCES Phong(IdPhong)
);

CREATE TABLE HoaDon (
    IdHoaDon INT PRIMARY KEY IDENTITY(1,1),
    NgayThanhToan DATE,
    HanChot DATE,
    SoTien DECIMAL(12,2) NOT NULL,
    TrangThai VARCHAR(20) NOT NULL 
        CHECK (TrangThai IN ('UNPAID','PAID')),
    IdHopDong INT NOT NULL,

    CONSTRAINT FK_HoaDon_HopDong 
        FOREIGN KEY (IdHopDong) REFERENCES HopDong(IdHopDong) 
        ON DELETE CASCADE
);

CREATE TABLE YeuCau (
    IdYeuCau INT PRIMARY KEY IDENTITY(1,1),
    NgayGui DATETIME,
    NgayTraLoi DATETIME,
    NoiDung NVARCHAR(500) NOT NULL,
    GhiChu NVARCHAR(500),
    TrangThai VARCHAR(20) NOT NULL DEFAULT 'PENDING'
        CHECK (TrangThai IN ('PENDING','APPROVED','REJECTED')),
    MSSV VARCHAR(20) NOT NULL,
    IdQuanLi INT,

    CONSTRAINT FK_YeuCau_SinhVien 
        FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV),

    CONSTRAINT FK_YeuCau_QuanLi 
        FOREIGN KEY (IdQuanLi) REFERENCES NguoiQuanLi(IdQuanLi)
);

CREATE TABLE ThongBao (
    IdThongBao INT PRIMARY KEY IDENTITY(1,1),
    NgayGui DATETIME,
    NoiDung NVARCHAR(500) NOT NULL,
    MSSV VARCHAR(20) NOT NULL,
    IdQuanLi INT NOT NULL,

    CONSTRAINT FK_ThongBao_SinhVien 
        FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV),

    CONSTRAINT FK_ThongBao_QuanLi 
        FOREIGN KEY (IdQuanLi) REFERENCES NguoiQuanLi(IdQuanLi)
);


INSERT INTO Users (Username, Password, Role) VALUES
('admin', '123', 'ADMIN'),

('manager1', '123', 'MANAGER'),
('manager2', '123', 'MANAGER'),
('manager3', '123', 'MANAGER'),

('sv1', '123', 'STUDENT'),
('sv2', '123', 'STUDENT'),
('sv3', '123', 'STUDENT'),
('sv4', '123', 'STUDENT'),
('sv5', '123', 'STUDENT'),
('sv6', '123', 'STUDENT'),
('sv7', '123', 'STUDENT'),
('sv8', '123', 'STUDENT'),
('sv9', '123', 'STUDENT'),
('sv10', '123', 'STUDENT');

INSERT INTO ToaNha (TenToa) VALUES
(N'Tòa A'),
(N'Tòa B'),
(N'Tòa C');

INSERT INTO LoaiPhong 
(MaLoaiPhong, GioiHanNguoi, GiaThuePhong, TienDienCoDinh, TienNuocCoDinh) VALUES
(1, 2, 1000000, 50000, 50000),
(2, 4, 800000, 50000, 50000),
(3, 6, 600000, 50000, 50000);

INSERT INTO CSVC 
(MaCSVC, SoGiuongTang, SoBanHoc, SoTuQuanAo) VALUES
(1, 2, 2, 2),
(2, 4, 4, 4),
(3, 6, 6, 6);

INSERT INTO NguoiQuanLi 
(HoTen, ThongTinLienLac, IdToaNha, IdUser) VALUES
(N'Quản lí 1', '090000001', 1, 2),
(N'Quản lí 2', '090000002', 2, 3),
(N'Quản lí 3', '090000003', 3, 4);

INSERT INTO SinhVien 
(MSSV, HoTen, NgaySinh, DiaChi, ThongTinLienLac, IdUser) VALUES

('SV001', N'Sinh viên 1', '2003-01-01', N'Hà Nội', '0910000001', 5),
('SV002', N'Sinh viên 2', '2003-02-02', N'Hà Nội', '0910000002', 6),
('SV003', N'Sinh viên 3', '2003-03-03', N'Hà Nội', '0910000003', 7),
('SV004', N'Sinh viên 4', '2003-04-04', N'Hà Nội', '0910000004', 8),
('SV005', N'Sinh viên 5', '2003-05-05', N'Hà Nội', '0910000005', 9),

('SV006', N'Sinh viên 6', '2003-06-06', N'Hà Nội', '0910000006', 10),
('SV007', N'Sinh viên 7', '2003-07-07', N'Hà Nội', '0910000007', 11),
('SV008', N'Sinh viên 8', '2003-08-08', N'Hà Nội', '0910000008', 12),
('SV009', N'Sinh viên 9', '2003-09-09', N'Hà Nội', '0910000009', 13),
('SV010', N'Sinh viên 10', '2003-10-10', N'Hà Nội', '0910000010', 14);

INSERT INTO Phong 
(IdPhong, MaLoaiPhong, MaCSVC, IdToaNha, SoNguoiHienTai) VALUES

('A101', 1, 1, 1, 2),
('A102', 1, 1, 1, 2),
('A103', 1, 1, 1, 2),

('B201', 2, 2, 2, 2),
('B202', 2, 2, 2, 2);

INSERT INTO HopDong 
(NgayBatDau, NgayKetThuc, TrangThai, MSSV, IdPhong) VALUES

('2025-01-01','2026-12-31','ACTIVE','SV001','A101'),
('2025-01-01','2026-12-31','ACTIVE','SV002','A101'),

('2025-01-01','2026-12-31','ACTIVE','SV003','A102'),
('2025-01-01','2026-12-31','ACTIVE','SV004','A102'),

('2025-01-01','2026-12-31','ACTIVE','SV005','A103'),
('2025-01-01','2026-12-31','ACTIVE','SV006','A103'),

('2025-01-01','2026-12-31','ACTIVE','SV007','B201'),
('2025-01-01','2026-12-31','ACTIVE','SV008','B201'),

('2025-01-01','2026-12-31','ACTIVE','SV009','B202'),
('2025-01-01','2026-12-31','ACTIVE','SV010','B202');

INSERT INTO YeuCau (NgayGui, NgayTraLoi, NoiDung, GhiChu, TrangThai, MSSV, IdQuanLi) VALUES
(GETDATE(), NULL, N'Hỏng bóng đèn trong phòng', NULL, 'PENDING', 'SV001', 1),
(GETDATE(), NULL, N'Điều hòa không hoạt động', NULL, 'PENDING', 'SV002', 1),

(GETDATE(), GETDATE(), N'Xin đổi phòng', N'Đã duyệt chuyển sang phòng khác', 'APPROVED', 'SV003', 1),
(GETDATE(), GETDATE(), N'Xin gia hạn hợp đồng', N'Không đủ điều kiện', 'REJECTED', 'SV004', 1),

(GETDATE(), NULL, N'Nước yếu', NULL, 'PENDING', 'SV007', 2),
(GETDATE(), GETDATE(), N'Hỏng quạt', N'Đã sửa xong', 'APPROVED', 'SV008', 2),

(GETDATE(), NULL, N'Cửa bị hỏng khóa', NULL, 'PENDING', 'SV009', 3),
(GETDATE(), GETDATE(), N'Xin thêm giường', N'Không đủ diện tích', 'REJECTED', 'SV010', 3);





