
drop table lop
create  table lop(
	ma int identity,
	ten nvarchar(50),
	so_luong_sinh_vien int default 0,
	primary key(ma)
)

insert into lop(ten)
values ('SQL'), ('Wed')

drop table sinh_vien
create table sinh_vien(
	ma int identity,
	ten nvarchar(50),
	ma_lop int,
	foreign key(ma_lop) references lop(ma),
	primary key(ma)
)

insert into sinh_vien(ten, ma_lop)
values ('Long',1)

select * from lop
select * from sinh_vien
delete from sinh_vien
--==================================================================================
-- có 3 phương thức tạo ra trigger
-- DML insert, update, delete
-- bất kì trigger insert, update, delete : khi nó chạy sẽ luôn có hai bảng được sinh ra
-- là Inserted sẽ lưu lại thông tin sẽ insert TRƯỚC KHI mà insert vào trong bảng 
-- và Deleted cũng như vậy 

--=============================================================================================
--|       với số lượng khi insert ,delete , update là một                                     |
--=============================================================================================

--================
--| after insert | --với số lượng khi insert ,delete , update là một 
--================
----------thêm sinh viên mới trong bảng sinh_vien theo mã lớp vào trong bảng lớp và cập nhật lại số lượng ---------------
drop trigger trigger_them_sinh_vien
--có thể dùng create hay alter để thay thê drop

--go
--create or alter trigger trigger_them_sinh_vien
--on sinh_vien
--after insert
--as
--begin
--	--lấy mã lớp đã insert trong bảng sinh_vien
--	declare @ma_lop int = (select ma_lop from inserted)    --KHi insert nhiều giá trị một lúc sẽ sảy ra lỗi vì câu select bên trong
--	update lop                                             --chỉ trả về một giá trị cho kiểu int
--	set so_luong_sinh_vien = so_luong_sinh_vien + 1
--	--lấy mã của bảng lớp so sánh với bảng ma_lop sinh vien
--	where ma = @ma_lop
--end
--go

--sau khi thực thi trigger 
--thì sau câu lệnh insert này chính là sinh viên thuộc trong bảng INSERTED và tương tự như các câu lệnh insert khác
--nếu đã tạo trigger insert 
insert into sinh_vien(ten, ma_lop)
values ('Long',1)

insert into sinh_vien(ten, ma_lop)
values ('Thien',1),('Tuan',2)

insert into sinh_vien(ten, ma_lop)
values ('Tuan',2)

--================
--| after delete |
--================
-------------------xóa sinh viên trong bảng sinh_viên và cập nhật lại số lượng trong bảng lớp--------------------------------
go
create or alter trigger trigger_xoa_sinh_vien
on sinh_vien
after delete
as
begin
	declare @ma_lop int = (select ma_lop from deleted)
	update lop
	set so_luong_sinh_vien = so_luong_sinh_vien - 1
	where ma  = @ma_lop

	select * from lop
	select * from sinh_vien
end
go

delete from sinh_vien
where ma = 6

go
create trigger trigger_xoa
on sinh_vien
after delete
as
begin
	select * from deleted
end
go

delete from sinh_vien
where ma = 8


--Nâng Cao Hơn
--================
--| after update | --
--================
-----------------------------------------------------------------------------------
--sinh viên muốn đổi lớp sang lớp khác
--ta sẽ lấy [mã_lớp_cũ] 
--để trừ đi số [lượng sinh viên] của lớp đó khi sinh viên này chuyển sang lớp khác
--khi sinh viên chuyển qua lớp mới sẽ lấy mã lớp mới để cập nhật lại số lượng sinh_vien 
go
create or alter trigger thay_doi_thong_tin
on sinh_vien
after update 
as
begin
	declare @ma_lop_moi int = (select ma_lop from inserted)
	update lop
	set so_luong_sinh_vien = so_luong_sinh_vien + 1
	where ma = @ma_lop_moi

	declare @ma_lop_cu int= (select ma_lop from deleted)
	update lop
	set so_luong_sinh_vien = so_luong_sinh_vien - 1
	where ma = @ma_lop_cu

	select * from lop
	where ma = @ma_lop_cu

	select * from lop
	where ma = @ma_lop_moi
end
go

select * from lop
select * from sinh_vien

update sinh_vien
set ma_lop = 1 --bản chất của update là luôn xóa toàn bộ  đi và insert lại 
where ma = 2   --CHỨ KHÔNG PHẢI LÀ SỬA Riêng CỘT NÀO 

--nếu thay cột set kia thành ten = 'long' thì bản chất vẫn là XÓA  đi và INSERT lại


--=============================================================================================
--|       với số lượng khi insert ,delete , update nhiều                                      |
--=============================================================================================

-----------------------------------------------------------------------------------------
-- Insert nhiều data cùng một lúc 
--và cập nhật  tương ứng với số lượng sinh viên trong bao nhiêu lớp đấy
--====================
--|      Insert      |
--====================

go
create or alter trigger trigger_them_sinh_vien
on sinh_vien
after insert
as
begin
	update lop
	set so_luong_sinh_vien = so_luong_sinh_vien + tmp.so_luong_sinh_vien_moi
	from lop
	join (select ma_lop, count(ma_lop) as so_luong_sinh_vien_moi from inserted
		  group by ma_lop) tmp
 	on lop.ma = tmp.ma_lop

	select * from lop
	select * from sinh_vien
end
go

insert into sinh_vien(ten, ma_lop)
values ('Thien',1),('Tuan',2),('lam hacker', 1)

--====================
--|      delete      |
--====================

go
create or alter trigger trigger_xoa_sinh_vien
on sinh_vien
after delete
as
begin
	update lop
	set so_luong_sinh_vien = so_luong_sinh_vien - tmp_delete.so_luong_sinh_vien_moi
	from lop
	join (select ma_lop, count(ma_lop) as so_luong_sinh_vien_moi from deleted
		  group by ma_lop) tmp_delete
 	on lop.ma = tmp_delete.ma_lop

	select * from lop
	select * from sinh_vien
end
go

delete from sinh_vien
where ma <= 6

-- bản chất thật của trigger update là xóa và thêm 
go
create trigger trigger_after_update
on sinh_vien
after update 
as
begin
	select * from inserted  --giá trị vừa được thêm vào thông qua lệnh update
	select * from deleted   --giá trị vừa bị xóa thông qua câu update
end
go