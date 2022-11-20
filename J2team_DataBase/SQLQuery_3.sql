use quan_ly_khach_hang

drop table khach_hang

create table khach_hang(
	ma int identity,
	ho_ten nvarchar(50) not null,
	so_dien_thoai char(15) unique not null,
	dia_chi ntext not null,
	gioi_tinh bit not null,
	ngay_sinh date not null,
	primary key(ma)
)

--Thêm 5 khách hàng
insert into khach_hang(ho_ten,so_dien_thoai,dia_chi,gioi_tinh,ngay_sinh)
values  
(N'Long','1234','HN',0,'1997-07-01'),
(N'Tuấn','1235','HP',1,'2000-01-01'),
(N'Anh','1236','HCM',1,'1996-05-01'),
(N'Đức','1237','HN',1,'2000-01-01')

select *from khach_hang
--Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng
select ho_ten, so_dien_thoai 
from khach_hang

--Cập nhật khách có mã là 2 sang tên Tuấn
update  khach_hang
set ho_ten = N'Tuấn'
where ma = 2

--Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam
delete from khach_hang 
where ma > 1 and gioi_tinh = 1

--(*) Lấy ra khách hàng sinh tháng 1
select * from khach_hang
where Month(ngay_sinh) = 1 

--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
select * from khach_hang 
where (ho_ten in ('Anh', N'Minh', 'Đức') and gioi_tinh = 1) or year(ngay_sinh) < 2000


--(**) Lấy ra khách hàng có tuổi lớn hơn 18
select * from khach_hang 
where year(GETDATE()) - year(ngay_sinh) > 18

--(**) Lấy ra 3 khách hàng mới nhất
select  top 2 * 
from khach_hang
order by ma  desc

--(**) Lấy ra khách hàng có tên chứa chữ T
select * from khach_hang
where ho_ten  like '%T%'
--where ho_ten  like '%t%'   like sẽ phân biệt hoa thường



--(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại
alter table khach_hang
add check(ngay_sinh < getdate());

--(***) Thay đổi bảng sao cho chỉ nhập được giới tính nam với bạn tên long
alter table khach_hang
add constraint Check_gioi_tinh_kem_ten_long check((gioi_tinh = 1 and ho_ten = 'Long') or ho_ten != 'long')
	
insert into khach_hang(ho_ten,so_dien_thoai,dia_chi,gioi_tinh,ngay_sinh)
values  (N'Long','1234','HN',0,'1997-07-01') --SẼ BÁO LỖI 

ALTER TABLE khach_hang
DROP CONSTRAINT UQ__khach_ha__BD03D94C7F703AF4;



