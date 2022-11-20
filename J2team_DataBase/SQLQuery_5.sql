--Bài tập tổng hợp kiến thức (sau mỗi 3 buổi mình sẽ đăng 1 bài thế này.

--Sếp yêu cầu bạn thiết kế cơ sở dữ liệu quản lý lương nhân viên

--Với điều kiện:

-- 1. mã nhân viên không được phép trùng
-- 2. lương là số nguyên dương
-- 3. tên không được phép ngắn hơn 2 ký tự
-- 4. tuổi phải lớn hơn 18
-- 5. giới tính mặc định là nữ
-- 6. ngày vào làm mặc định là hôm nay
-- 7. (*) nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
-- 8. tất cả các cột không được để trống
-- 9. Công ty có 5 nhân viên
-- 10. Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)
-- 11. Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
-- 12. Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
-- 13. Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
-- 14. (*) Lấy ra các bạn mới vào làm hôm nay
-- 15. (*) Lấy ra 3 bạn nhân viên cũ nhất
-- 16. (**) Tách những thông tin trên thành nhiều bảng cho dễ quản lý, lương 1 nhân viên có thể nhập nhiều lần

drop table nhan_vien
create table nhan_vien(
	ma int identity,
	ten nvarchar(50) not null,
	ngay_sinh date not null,
	gioi_tinh bit default 0 not null,
	ngay_vao_lam  date default getdate() not null,
	nghe_nghiep nvarchar(50) not null,
	luong int not null,
	--lương là số nguyên dương
	constraint check_luong check(luong >= 0),
	--tên không được phép ngắn hơn 2 ký tự
	constraint check_do_dai_ten check(len(ten) >= 2),
	--tuổi phải lớn hơn 18
	constraint check_tuoi check(year(getdate()) - year(ngay_sinh) > 18),
	--nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
	constraint check_nge_nghiep check(nghe_nghiep in ('IT',N'kế toán',N'doanh nhân thành đạt')),
	primary key(ma)
)

-- 9. Công ty có 5 nhân viên
insert into nhan_vien(ten, ngay_sinh, gioi_tinh,ngay_vao_lam,nghe_nghiep,luong)
values 
('Long','1997-01-01',1,'2021-10-01','IT',100),
(N'Tuấn','2000-01-01',0,'2000-09-01',N'doanh nhân thành đạt',9000),
('Anh','2000-02-01',0,default,N'kế toán',300),
('Lam','2000-04-07',0,default,N'IT',700),
('Vuong','2002-01-01',0,default,N'IT',400)

select *from nhan_vien

--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100.
update nhan_vien
set luong = 100
where month(ngay_sinh) = month(getdate())

select *from nhan_vien
where month(ngay_sinh) = month(getdate())

--(*: tăng lương cho mỗi bạn thêm 100)
update nhan_vien
set luong += 100

-- 11. Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. 
delete from nhan_vien
where luong <= 50

--(*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). 
delete from nhan_vien
where  luong <= 50 and month(ngay_sinh) = month(getdate())


--(**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
--month(getdate) - month(ngay_vao_lam)  --SAI VÌ NẾU NGÀY VÀO LÀM CỦA BẠN LÀ THÁNG 5 NHƯNG LÀ THÁNG NĂM CỦA NĂM TRƯỚC THÌ TRỪ ĐI SẼ = 0

delete from nhan_vien
where datediff(month, ngay_vao_lam, getdate()) < 2
and ngay_vao_lam < getdate()

-- 12. Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
select sum(luong) as 'tong_luong' from nhan_vien

select nghe_nghiep,sum(luong) as tong_luong from nhan_vien
group by nghe_nghiep

-- 13. Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
select avg(luong) as 'trung_binh_luong' from nhan_vien

select nghe_nghiep, avg(luong) as luong_trung_binh
from nhan_vien
group by nghe_nghiep

--(*) Lấy ra các bạn mới vào làm hôm nay
select * from nhan_vien
where day(ngay_vao_lam) = day(getdate())

select * from nhan_vien
where ngay_vao_lam = cast(getdate() as date)

--select getdate() chính xác là nó sẽ lấy (năm-tháng-ngày giờ-phút-giây)

--limit giới hạn số kết quả trả về 
--15. (*) Lấy ra 3 bạn nhân viên cũ nhất
select top 3  * from nhan_vien
order by ngay_vao_lam asc

--=============================================================================
--Chuyên Sâu Về Group By
select ten,gioi_tinh, sum(luong) from nhan_vien
group by ten, gioi_tinh