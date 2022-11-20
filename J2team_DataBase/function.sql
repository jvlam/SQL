drop table sinh_vien1
create table sinh_vien1(
	ma int identity,
	ten varchar(50),
	gioi_tinh bit,
	ngay_sinh date,
	primary key(ma)
)
----------------------Trong function không sử dụng được DML và DDL-----------------------------------------------------
insert into sinh_vien1(ten,gioi_tinh, ngay_sinh)
values ('Long', 1, '1997-01-01'),('Tuan',0, '2000-01-01')

select * from sinh_vien1

go
select
ma,
ten,
dbo.function_ten_gioi_tinh(gioi_tinh) as gioi_tinh,
dbo.function_lay_tuoi1(ngay_sinh) as tuoi
from sinh_vien1
go

------------------------------hàm trả về tên giới tính  thay vì 1 hoặc 0---------------------------------------------
--function trả về một chữ 
go
create function function_ten_gioi_tinh(@gioi_tinh bit)
returns  nvarchar(50)
as
begin
	return case 
	when @gioi_tinh = 1 
	then 
		 N'Nam' 
	else
		 N'Nu' 
	end 
end
go
------------------------------hàm trả về tuổi thông qua tham số @ngay_sinh-------------------------------------------
--function trả về một số
go
create function function_lay_tuoi1(@ngay_sinh date)
returns int
as
begin
	return year(getdate()) - year(@ngay_sinh)
	--return datediff(year, @ngay_sinh, getdate())
end
go
------------------------------hàm trả về một table thông qua @ma------------------------------------------
--function trả về một table 
--Data Query Language là câu lệnh truy vấn với dữ liệu như Select
--khi return trả về một bảng sẽ không được dùng as, begin , end
go
create function func_xem_sinh_vien(@ma int)
returns table 
return select * from sinh_vien1
where ma = @ma
go

select * from func_xem_sinh_vien(1) 

select * from func_xem_sinh_vien(1) as t1
join sinh_vien on sinh_vien.ma = t1.ma


-------------------------------------------------------------------------
