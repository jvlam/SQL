--Tạo cơ sở dữ liệu để quản lý sinh viên

--Yêu cầu:

--có thông tin sinh viên, lớp (*: môn, điểm)
--có kiểm tra ràng buộc
--Thêm mỗi bảng số bản ghi nhất định
--Lấy ra tất cả sinh viên kèm thông tin lớp
--Đếm số sinh viên theo từng lớp
--Lấy sinh viên kèm thông tin điểm và tên môn
--(*) Lấy điểm trung bình của sinh viên của lớp LT
--(*) Lấy điểm trung bình của sinh viên của môn SQL
--(*) Lấy điểm trung bình của sinh viên theo từng lớp

create database buoi_cuoi
use  buoi_cuoi

drop table lop
create table lop(
	ma_lop int identity,
	ten nvarchar(50) not null unique,
	primary key(ma_lop)
)

insert into lop(ten)
values (N'LT'),(N'BTMT'),(N'ATTT')

select *from lop

drop table hoc_sinh
create table hoc_sinh(
	ma_sv int identity,
	ten_hs nvarchar(50) not null,
	ma_lop int,
	primary key(ma_sv),
	foreign key(ma_lop) references lop(ma_lop),
	constraint check_ten check(len(ten_hs) >= 2)
)

insert into hoc_sinh(ten_hs,ma_lop)
values (N'Long',1),(N'Tuấn',1),(N'Anh',2)
--sinh vien khong thuoc lop nao
insert into hoc_sinh(ten_hs,ma_lop)
values (N'Long KH',null)

drop table mon
create table mon(
	ma_mon int identity,
	ten nvarchar(50),
	primary key(ma_mon)
)

insert into mon(ten)
values ('SQL'),('PHP'),('HTML')

drop table diem
create table diem(
	ma_mon int not null,
	ma_sinh_vien int not null,
	diem float,
	constraint check_diem check(diem >= 0 and diem <= 10),
	primary key(ma_mon, ma_sinh_vien),
	foreign key(ma_mon) references mon(ma_mon),
	foreign key(ma_sinh_vien) references  hoc_sinh(ma_sv)
)

insert into diem
values (1,1,3),(1,2,5)
insert into diem
values (2,1,10)

select *from diem

--Lấy ra tất cả sinh viên kèm thông tin lớp
select *from hoc_sinh
left join lop on hoc_sinh.ma_lop = lop.ma_lop

--Đếm số sinh viên theo từng lớp
select lop.ma_lop,lop.ten, -- Phải group by ở dưới thì mới được cho lên đây 
count(hoc_sinh.ma_lop) as'so luong sinh vien'
from hoc_sinh
right join lop on hoc_sinh.ma_lop = lop.ma_lop
group by lop.ma_lop,lop.ten 

--Lấy sinh viên có điểm kèm tên môn 
select hoc_sinh.ten_hs, diem.diem,mon.ten
from hoc_sinh
join diem on hoc_sinh.ma_sv = diem.ma_mon
join mon on diem.ma_mon = mon.ma_mon

select *from hoc_sinh

--Lấy tất cả sin viên kèm điểm nếu có
select hoc_sinh.ten_hs, diem.diem
from hoc_sinh
left join diem on hoc_sinh.ma_sv = diem.ma_sinh_vien

--(*) Lấy điểm trung bình của sinh viên của lớp LT
select * from hoc_sinh
join diem on diem.ma_sinh_vien = hoc_sinh.ma_lop
join mon on diem.ma_mon = mon.ma_mon


--(*) Lấy điểm trung bình của sinh viên của môn SQL
--(*) Lấy điểm trung bình của sinh viên theo từng lớp