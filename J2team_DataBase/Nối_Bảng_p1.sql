drop table lop
create table lop(
	ma int identity,
	ten nvarchar(50) not null unique,
	primary key(ma)
)

insert into lop(ten)
values ('LT'),('ATTT')
insert into lop(ten)
values ('hacker mu trang')

select *from lop


drop table sinh_vien
create table sinh_vien(
	ma int identity,
	ten nvarchar(50) not null,
	gioi_tinh bit not null default 0,
	ma_lop int,
	foreign key(ma_lop) references lop(ma),
	primary key(ma)
)

insert into sinh_vien(ten, gioi_tinh, ma_lop)
values ('Long', default,1),(N'Tuấn', 1, 1),(N'Tuấn', 1, 2)

insert into sinh_vien(ten)
values ('Longsky')

select *from sinh_vien
join lop on lop.ma = sinh_vien.ma_lop --bảng sinh_vien được gọi trước và bảng lop nối theo sau	
--khi ghi join thì cũng được hiểu là inner join 

select *from sinh_vien
left join lop on sinh_vien.ma_lop = lop.ma --lop.ma = sinh_vien.ma_lop <=> sinh_vien.ma_lop = lop.ma

--đếm số lượng sinh viên trong lớp lập trình
select count(*) from sinh_vien
join lop on lop.ma = sinh_vien.ma_lop
where lop.ten = 'LT'

--đế số lượng sinh viên không thuộc lớp nào
select count(*) from sinh_vien
left join lop on lop.ma = sinh_vien.ma_lop
where lop.ten is null

--======================================================
--Chỉ lấy được lớp có sinh viên , còn lớp không có sinh viên thì không lấy được 
select lop.ma, 
count(*)  as 'số sinh viên'
from sinh_vien
join lop on lop.ma = sinh_vien.ma_lop
group by lop.ma
--=====================================================
--Lỗi vì count(*) sẽ đếm cả nếu nó là null
select lop.ma, 
count(*)  as 'số sinh viên'
from sinh_vien
right join lop on lop.ma = sinh_vien.ma_lop
group by lop.ma
--=====================================================
select lop.ma, 
count(sinh_vien.ma_lop)  as 'số sinh viên'
from sinh_vien
right join lop on lop.ma = sinh_vien.ma_lop
group by lop.ma