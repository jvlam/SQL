drop table lop
create  table lop(
	ma int,
	ten nvarchar(50),
	so_cho_trong int,
	primary key(ma)
)

insert into lop(ma,ten,so_cho_trong)
values (3,'WEB',0),(1,'PHP',1),(2,'SQL',4)

drop table sinh_vien
create table sinh_vien(
	ma int,
	ten nvarchar(50),
	ma_lop int,
	primary key(ma),
	foreign key(ma_lop) references lop(ma)
)

insert into sinh_vien(ma, ten, ma_lop)
values (1,'Long',1),(2,'Tuan',1)

select * from sinh_vien
select * from lop

delete from sinh_vien
delete from lop


go
create or alter trigger them_sinh_vien
on sinh_vien
instead of insert 
as 
begin
	declare @ma_lop int = (select ma_lop from inserted)
	declare @so_cho_trong_cu int = (select so_cho_trong from lop where ma = @ma_lop)
	if(@so_cho_trong_cu = 0)
	begin
		print (N'Lop het cho')
	end
	else
	begin
		print ('insert thanh cong')
		update lop
		set so_cho_trong = so_cho_trong - 1
		where ma = @ma_lop

		declare @ma int= (select ma from inserted)
		declare @ten nvarchar(50)= (select ten from inserted)

		insert into sinh_vien(ma, ten, ma_lop)
		values(@ma, @ten, @ma_lop)
	end
end
go

insert into sinh_vien(ma, ten, ma_lop)
values (1,'Long',2)

select * from sinh_vien
select * from lop

