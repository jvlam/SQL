use quan_ly_sinh_vien
--Tạo bảng lưu thông tin khách hàng (mã, họ tên, số điện thoại, địa chỉ, giới tính, ngày sinh)
--Thêm 5 khách hàng
--Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng
--Cập nhật khách có mã là 2 sang tên Tuấn
--Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam
--(*) Lấy ra khách hàng sinh tháng 1
--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
--(**) Lấy ra khách hàng có tuổi lớn hơn 18
--(**) Lấy ra 3 khách hàng mới nhất
--(**) Lấy ra khách hàng có tên chứa chữ T
--(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại

create table customers (
	ma int identity,
	ho_ten nvarchar(50)not null,
	dia_chi ntext not null,-- khong can khai bao co bnh ki tu, khong ho tro unique
	sdt char(15) unique not null,
	gioi_tinh bit not null,
	ngay_sinh date not null,
	primary key(ma)
)

insert into customers values ('Quang Anh',N'Obere Str. 57','030-0074321', 1,'2002/2/20')
insert into customers values (N'Vũ Văn Minh',N'Obere Str. 57','030-1074321', 0,'1996/2/20')
insert into customers values (N'Nguyễn Văn Minh Đức',N'Walserweg 21','090-0074321', 1,'1993/2/20')
insert into customers values (N'Vũ Anh Lãm',N'Fauntleroy Circus','090-0079321', 0,'2004/2/20')
insert into customers values (N'Đỗ Thiện',N'OMataderos  2312','030-1074821', 1,'2005/2/20')

--======================================== check, datediff, update, =====================================================================
select * from customers
--Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng
select c.ho_ten, c.sdt from customers c

--Cập nhật khách có mã là 2 sang tên Tuấn
update customers 
		set ho_ten = N'Tuấn'
		where ma = 12

update customers
	   set ngay_sinh = '1991-1-30'
	   where ma = 11

--Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam
delete customers 
		where ma > 3 and gioi_tinh = 1

--(*) Lấy ra khách hàng sinh tháng 1
select * from customers where month(ngay_sinh) = 1

--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
select * from customers 
		 where ho_ten like '%Anh' or ho_ten like '%Minh' or ho_ten like N'%Đức%'
		 and (gioi_tinh = 1 or year(ngay_sinh) < 2000)

--(**) Lấy ra khách hàng có tuổi lớn hơn 18
select * from customers where year(GETDATE()) -  year(ngay_sinh) > 18
select * from customers where DATEDIFF(year, ngay_sinh, getdate()) > 18

--(**) Lấy ra 3 khách hàng mới nhất
select top 3 * from customers order by ma desc

--(**) Lấy ra khách hàng có tên chứa chữ T
select * from customers where ho_ten like '%t%'  

--(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại
ALTER TABLE CUSTOMERS 
add check(ngay_sinh < getdate())


select * from sinh_vien
delete from sinh_vien

--================================================== Bài 3, check, count =================================================================
------------------------------------------------------------------
-- Đặt tên cho check để báo lỗi đúng nội dung 
-- khi mà check được tạo sau khi data có sẵn thì nó vẫn sẽ kiểm tra hết lại các data đã inserted xem có thỏa mãn 
-- check vừa mới tạo hay không , nếu không thỏa mãn thì phải xóa data đó đi thì mới tạo ra được check đó 
------------------------------------------------------------------	

--Tạo bảng lưu thông tin điểm của sinh viên (mã, họ tên, điểm lần 1, điểm lần 2)
--Với điều kiện:
--điểm không được phép nhỏ hơn 0 và lớn hơn 10
--điểm lần 1 nếu không nhập mặc định sẽ là 5


--(*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5
alter table sinh_vien
add constraint check_diem_lan_1 check((diem_lan_1 >= 5 and diem_lan_2 is null) or diem_lan_1 < 5)

insert into sinh_vien(ho_ten, diem_lan_1, diem_lan_2) values 
(N'Nguyễn Vũ Thiện',6,7)
--NOTE: TRONG TRƯỜNG HỢP DỮ LIỆU TRƯỚC KHI CÓ CHECK ĐƯỢC TẠO RA , MÀ KHÔNG THỎA ĐIỀU KIỆN CỦA CHECK , THÌ PHẢI XÓA
--      DỮ LIỆU ĐÓ ĐI MỚI TẠO ĐƯỢC CÁI CHECK ĐÓ

--(**) tên không được phép ngắn hơn 2 ký tự
alter table sinh_vien 
add constraint check_do_dai_ten check(len(ho_ten) >=2)

insert into sinh_vien(ho_ten, diem_lan_1, diem_lan_2) values
(N'h', 4,9) -- sai do ten ngan hon hai ki tuw

drop table sinh_vien
create table sinh_vien (
	ma int identity,
	ho_ten nvarchar(50),
	diem_lan_1 float default 5,
	diem_lan_2 float,
	primary key(ma),
	--check(diem_lan_1 >= 0 and diem_lan_1 <= 10),
	--check(diem_lan_2 >= 0 and diem_lan_2 <= 10),
	constraint check_limit_mark check(diem_lan_1 >= 0 and diem_lan_1 <= 10 and diem_lan_2 >= 0 and diem_lan_2 <= 10)
)
select * from sinh_vien
--Điền 5 sinh viên kèm điểm
insert into sinh_vien(ho_ten, diem_lan_1, diem_lan_2) values 
(N'Vũ Anh Lãm',null,8.9),
(N'Nguyễn Đình Vũ',7.5,null),
(N'Trần Minh Quang',4.3,2.9),
(N'Đỗ An',10,null)

--Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5
select * from sinh_vien where diem_lan_1 >= 5 or  diem_lan_2 >=5
--Lấy ra các bạn qua môn ngay từ lần 1
select * from sinh_vien where diem_lan_1 >= 5

--Lấy ra các bạn trượt môn
select * from sinh_vien where  diem_lan_1 <=5 and diem_lan_2 <=5
--(*) Đếm số bạn qua môn sau khi thi lần 2
select count(*) as [passed] from sinh_vien where diem_lan_2 >=5

--(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)
select count(*) as [not passed diem_lan_1] from sinh_vien s where diem_lan_1 is null or (diem_lan_1 < 5 and diem_lan_2 is null)


--================================================== Bài 4, check, count =================================================================
--Sếp yêu cầu bạn thiết kế cơ sở dữ liệu quản lý lương nhân viên

--Với điều kiện:

--mã nhân viên không được phép trùng
--lương là số nguyên dương
--tên không được phép ngắn hơn 2 ký tự
--tuổi phải lớn hơn 18
--giới tính mặc định là nữ
--ngày vào làm mặc định là hôm nay
--(*) nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
--tất cả các cột không được để trống
--Công ty có 5 nhân viên
--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)
--Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
--Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
--Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
--(*) Lấy ra các bạn mới vào làm hôm nay
--(*) Lấy ra 3 bạn nhân viên cũ nhất
--(**) Tách những thông tin trên thành nhiều bảng cho dễ quản lý, lương 1 nhân viên có thể nhập nhiều lần
drop table salary
create table salary (
	ma int identity,
	ten nvarchar(50) not null,
	luong int not null, 
	ngay_sinh date not null,
	gioi_tinh bit default 0 not null,
	ngay_vao_lam_viec date default getdate() not null,
	nghe_nghiep nvarchar(50) not null,
	primary key(ma),
	foreign key (nghe_nghiep) references job(job_title),
	constraint ck_luong_nguyen_duong check(luong >= 0),
	constraint ck_do_dai_ten check(len(ten) >= 2),	
	constraint ck_do_tuoi_lon_hon_18 check(year(getdate()) - year(ngay_sinh) >= 18),	
)

create  table job (
	job_title nvarchar(50),
	primary key(job_title)
)

insert into job values (N'IT'),(N'doanh nhân thành đạt'),(N'kế toán')
insert into salary(luong, ten, ngay_sinh,nghe_nghiep) values (40, N'Nguyễn Tùng Sơn', '2002-08-10', N'IT')

insert into salary(luong, ten, ngay_sinh,nghe_nghiep) values(100, N'Đào Nguyên Tùng', '1998-02-01', N'doanh nhân thành đạt')

insert into salary(luong, ten, ngay_sinh,nghe_nghiep) values(70, N'Trần Mạnh Quang', '1990-02-04', N'kế toán')

insert into salary(luong, ten, ngay_sinh,nghe_nghiep) values(65, N'Vũ Thiên Long', '2001-12-28', N'IT')

insert into salary(luong, ten, ngay_sinh,nghe_nghiep) values(20, N'Hoàng Mạnh Cường', '1975-06-20', N'doanh nhân thành đạt')

insert into salary(luong, ten, ngay_sinh,nghe_nghiep) values(19, N'Hoàng Mạnh Dung', '1975-06-20', N'doanh nhân thành đạt')


select * from salary

--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)
update salary 
set luong += 100
where month(ngay_sinh) = month(getdate())


--Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. 
delete from salary 
where luong < 50
--(*): xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). 
delete from salary 
where 
luong < 50 + 100
and month(ngay_sinh) = month(getdate())

--(**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
delete from salary 
where DATEDIFF(month, ngay_vao_lam_viec, getdate()) < 2
and ngay_vao_lam_viec < getdate()

--Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
select * from salary
select nghe_nghiep, sum(luong) from salary group by nghe_nghiep

--Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
select nghe_nghiep, avg(luong) from salary group by nghe_nghiep

--(*) Lấy ra các bạn mới vào làm hôm nay
select * from salary 
where datediff(day, ngay_vao_lam_viec, getdate()) < 0

select * from salary 
where ngay_vao_lam_viec = CAST( GETDATE() AS Date )

--(*) Lấy ra 3 bạn nhân viên cũ nhất
select top 3* from salary
order by ngay_vao_lam_viec asc

--(**) Tách những thông tin trên thành nhiều bảng cho dễ quản lý, lương 1 nhân viên có thể nhập nhiều lần


select * from salary

--offset bỏ qua số lượng rows theo yêu cầu
--fetch next lấy những rows đằng sau , sau khi bỏ qua
select * from salary
order by ngay_vao_lam_viec asc
OFFSET 3 rows
fetch next 3 rows only

select * from salary
order by ngay_vao_lam_viec asc


--================================================== Bài 4, check, count =================================================================
--Ban lãnh đạo thành phố yêu cầu bạn tạo bảng lưu các con vật trong sở thú
--Với điều kiện tự bạn quy ước (hãy áp dụng check và default)
drop table zoo
create table zoo (
	ma int identity,
	ten nvarchar(50) not null unique,
	so_chan int not null default 0,
	moi_truong_song int not null,
	tuoi_tho int not null,
	primary key(ma),
	constraint check_so_chan check(so_chan >=0 and so_chan % 2 = 0),
	constraint check_tuoi_tho check(tuoi_tho >=0),
	constraint check_ten check(len(ten) > 2),
	foreign key (moi_truong_song) references moi_truong(ma)
)	

insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'Hổss',4,N'trong rừng',16)
insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'Mèo',4,N'trong Nhà',7)
insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'Khỉ',2,N'trong chuồng',18)
insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'Cáss',default,N'dưới nước',24)
insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'hà mã',4,N'dưới nước',15)
insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'sư tử',4,N'trong rừng',26)
insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'cá sấu',4,N'dưới nước',8)

insert into zoo(ten, so_chan, moi_truong_song, tuoi_tho) values (N'cá sấu',4,2,8)

select * from moi_truong
insert into moi_truong values(N'dưới nước')

drop table moi_truong
create table moi_truong (
	ma int identity,
	moi_truong_song nvarchar(50) not null unique,
	primary key (ma)
)

--Thống kê có bao nhiêu con 4 chân
select * from zoo
select count(*) from(
	select * from zoo where so_chan = 4
) as tmp

select moi_truong_song,count(*) from zoo
where so_chan = 4
group by moi_truong_song

select count(*) from zoo where so_chan = 4

--Thống kê số con tương ứng với số chân
select * from zoo
select so_chan,count(*) from zoo z group by so_chan

--Thống kê số con theo môi trường sống
select moi_truong_song,count(*) as [so_moi_truong] from zoo group by moi_truong_song

--Thống kê tuổi thọ trung bình theo môi trường sống
select moi_truong_song,avg(tuoi_tho) as [tuoi_tho_trung_binh] from zoo group by moi_truong_song

--Lấy ra 3 con có tuổi thọ thọ cao nhất
select * from zoo 
order by tuoi_tho desc
offset 0 rows
fetch next 3 rows only

--(*) Tách những thông tin trên thành 2 bảng cho dễ quản lý (1 môi trường sống gồm nhiều con)

--================================================== Bài 4, tách, nối bảng =================================================================
--cột: đơn trị
--loại bỏ trùng lặp sang bảng mới
--cột : loại bỏ những cái có thể tính toán - chỉ dùng hàm để tính (select)
--không lưu lại cột có thể tính từ các cột khác 


--Tạo cơ sở dữ liệu để quản lý sinh viên

--Yêu cầu:

--có thông tin sinh viên, lớp (*: môn, điểm)
--có kiểm tra ràng buộc
--Thêm mỗi bảng số bản ghi nhất định

create table lop_hoc (
	ma int identity,
	ten_lop_hoc nvarchar(50) not null,
	primary key(ma),
	--foreign key (ma) references diem(ma_mon_hoc)
)
insert into lop_hoc(ten_lop_hoc) values ('LT')
insert into lop_hoc(ten_lop_hoc) values ('ATTT')
insert into lop_hoc(ten_lop_hoc) values ('BTMT')

select * from lop_hoc

drop table hoc_sinh
create table hoc_sinh (
	ma int identity,
	ten nvarchar(50) not null,
	ma_lop int,
	constraint check_ten_sinh_vien check(len(ten) >= 2),
	primary key(ma),
	foreign key (ma_lop) references lop_hoc(ma)
)
insert into hoc_sinh (ten, ma_lop) values ('Long',1),(N'Tuấn',1),(N'Anh',2)
insert into hoc_sinh (ten, ma_lop) values ('quan', null)
delete from hoc_sinh
where ten = 'quan'

drop table mon_hoc
create table mon_hoc (
	ma int identity,
	ten_mon_hoc nvarchar(50) not null unique,
	primary key(ma),
)
insert into mon_hoc values('SQL'),('PHP'),('HTML')

drop table diem
create table diem (
	ma_sinh_vien int not null,
	ma_mon_hoc int not null, 
	diem float not null,
	constraint check_diem_duong check(diem >= 0 and diem <= 10),
	primary key(ma_sinh_vien, ma_mon_hoc),
	foreign key (ma_sinh_vien) references hoc_sinh(ma),
	foreign key (ma_mon_hoc) references mon_hoc(ma),
)

select * from mon_hoc
select * from hoc_sinh
select * from diem
select * from lop_hoc

insert into diem values(1,1,3)
insert into diem values(1,2,5)
insert into diem values(2,1,10)

--Lấy ra tất cả sinh viên kèm thông tin lớp
select * from hoc_sinh h left join lop_hoc l on h.ma_lop = l.ma

--Lấy sinh viên kèm thông tin điểm và tên môn
select * from hoc_sinh h join diem d on h.ma = d.ma_sinh_vien
						 join mon_hoc m on m.ma = d.ma_mon_hoc

--Lấy sinh viên kèm thông tin điểm và tên môn(nếu có)
select h.ten, d.diem, m.ten_mon_hoc from hoc_sinh h left join diem d on h.ma = d.ma_sinh_vien
	                                 left join mon_hoc m on d.ma_mon_hoc =m.ma 
--Đếm số sinh viên theo từng lớp
select * from hoc_sinh
select * from lop_hoc
select * from diem
select * from mon_hoc
select *  from hoc_sinh h full join lop_hoc l on h.ma_lop = l.ma

select l.ten_lop_hoc, count(h.ma_lop) as[so_sinh_vien]  from hoc_sinh h right join lop_hoc l on h.ma_lop = l.ma
group by h.ma_lop, l.ten_lop_hoc

--(*) Lấy điểm trung bình của sinh viên của lớp LT
select avg(d.diem) from hoc_sinh h join lop_hoc l on 
h.ma_lop = l.ma join diem d on d.ma_sinh_vien = h.ma
group by l.ten_lop_hoc
having l.ten_lop_hoc = 'LT'

select l.ma,avg(diem) from hoc_sinh h join diem d on h.ma = d.ma_sinh_vien
						right join lop_hoc l on l.ma = h.ma_lop
					    group by l.ma


--(*) Lấy điểm trung bình của sinh viên của môn SQL
select avg(diem) from hoc_sinh h join diem d on h.ma = d.ma_sinh_vien 
						 join mon_hoc m on m.ma = d.ma_mon_hoc
						 where m.ten_mon_hoc = 'SQL'
						 group by m.ten_mon_hoc

select m.ten_mon_hoc,avg(diem) as[tb] from hoc_sinh h join diem d on h.ma = d.ma_sinh_vien
						 join mon_hoc m on d.ma_mon_hoc = m.ma
						 group by m.ten_mon_hoc
select * from hoc_sinh 
select * from mon_hoc
select * from diem

--(*) Lấy điểm trung bình của sinh viên theo từng lớp
select * from hoc_sinh h join diem d on h.ma = d.ma_sinh_vien
						 join lop_hoc l on l.ma = h.ma_lop
						