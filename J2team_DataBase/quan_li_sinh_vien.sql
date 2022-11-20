create database quan_ly_sinh_vien
use quan_ly_sinh_vien

drop table sinh_vien
create table sinh_vien(
	ten nvarchar(50),
	gioi_tinh bit,
	ma_lop nvarchar(10)
)


insert into sinh_vien(ten,gioi_tinh,ma_lop) 
values (N'Tuấn',1,1),(N'Long','2000-01-01',1) --cách insert nhiều thông tin 

--Select * là bản chất select tất cả các cột 

select * from sinh_vien
where ten = 'Long' or N'Tuấn' --nếu select chứa chiều or thì nên dùng in như câu lệnh phía dưới 

select * from sinh_vien
where ten in ('Long',N'Tuấn')

select * from sinh_vien
where ten in ('Long',N'Tuấn') and gioi_tinh = 1


delete from sinh_vien
where ma = 3

update sinh_vien
set ten = 'Long'
where ma = 2

--null
--nghĩa là chưa từng được khai báo hay chưa tồn tại bao giờ
--còn 0 
--nghĩa là nó vẫn chó giá trị = 0

create procedure them_va_hien_thi_sinh_vien
@ten nvarchar(50),
@gioitinh bit,
@malop nvarchar(10)
as
begin
	insert into sinh_vien(ten,gioi_tinh,ma_lop)
	values (@ten,@gioitinh,@malop)

	select * from sinh_vien
end

exec them_va_hien_thi_sinh_vien @ten = N'Long' , @gioitinh = 1, @malop = 2

--==========================================================================

create procedure xem_sinh_vien
as
begin 
	select * from sinh_vien
end

xem_sinh_vien

--==========================================================================

