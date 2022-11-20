drop table sinh_vien
create table sinh_vien(
	ma int identity, -- tự động tăng nên không cần insert 
	ho_ten nvarchar(10) ,
	diem_lan_1 float default  5.0,
	diem_lan_2 float,
	primary key(ma),
    constraint check_gioi_han_diem check (diem_lan_1 >= 0 and  diem_lan_1 <= 10 and diem_lan_2 >= 0 and diem_lan_2 <= 10) 
)

--alter table sinh_vien 
--add constraint CK__sinh_vien__diem_lan1_and_diem_lan2 check(diem_lan_1 > 0 and  diem_lan_1 < 10 and diem_lan_2 < 0 and diem_lan_2 > 10) 
	
select *from sinh_vien



--điểm không được phép nhỏ hơn 0 và lớn hơn 10
--dùng check
--điểm lần 1 nếu không nhập mặc định sẽ là 5
--dùng default

--===================================================================================================
--(*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5
alter table sinh_vien
add constraint check_nhap_diem_lan2 check ((diem_lan_1 >= 5 and diem_lan_2 is null) or diem_lan_1 < 5)

insert into sinh_vien(ho_ten,diem_lan_1,diem_lan_2) 
values(N'Tung',5,null)
--====================================================================================================
--(**) tên không được phép ngắn hơn 2 ký tự
alter table sinh_vien
add constraint check_ten_ngan_hon_2_kitu check(len(ho_ten) >= 2)
insert into sinh_vien(ho_ten,diem_lan_1,diem_lan_2) 
values(N'T',5,null)
--====================================================================================================
--ĐIỀN 5 SINH VIÊN KÈM ĐIỂM 
insert into sinh_vien(ho_ten,diem_lan_1,diem_lan_2) 
values(N'Lam',2,4),(N'Tuan',3,7),(N'Long',1,7),(N'Tuan',2,NULL)
--====================================================================================================
--Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5
select ho_ten, diem_lan_1, diem_lan_2 from sinh_vien
where 
--(diem_lan_1 or diem_lan_2) > 5   -- SAI HOAN TOÀN KHÔNG ĐƯỢC VIẾT TẮT NHƯ VẬY PHẢI VIẾT RÕ RÀNG 
diem_lan_1 > 5 or diem_lan_2 > 5
--====================================================================================================
--Lấy ra các bạn qua môn ngay từ lần 1
select ho_ten, diem_lan_1 from sinh_vien
where diem_lan_1 >= 5
--=================================================================================================
--LẤY RA CÁC BẠN TRƯỢT MÔN (LẦN 1 VÀ LẦN 2 ĐỀU DƯỚI 5)
select ho_ten, diem_lan_1, diem_lan_2 from sinh_vien
where diem_lan_1 < 5 and diem_lan_2 < 5
--=================================================================================================
--(*) Đếm số bạn qua môn sau khi thi lần 2
select count(*) as 'qua môn lần 2' --hàm count mặc định sẽ không có tên nên ta sẽ đặt tên thông qua as	
from sinh_vien
where diem_lan_2 >= 5
--=================================================================================================
--(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)
insert into sinh_vien(ho_ten,diem_lan_1,diem_lan_2) 
values(N'Van',3,null)

select count(*) from sinh_vien
where diem_lan_1 < 5 and diem_lan_2 is null

--Lấy RA NHỮNG SINH VIÊN ĐÃ THI LẦN 2
select * from sinh_vien
where diem_lan_2 is not null

select count(*) from sinh_vien
where diem_lan_2 is not null

select count(diem_lan_2) from sinh_vien

select * from sinh_vien

select avg(diem_lan_1) from sinh_vien

select diem_lan_2 from sinh_vien
select sum(diem_lan_2) as 'Tổng điểm lần 2' from sinh_vien
select avg(diem_lan_2) as 'điểm trung bình lần 2 ' from sinh_vien

select count(*) from sinh_vien
where ho_ten = 'Tuan'--đếm tất cả các bạn sinh viên mà không phân biệt trùng

select count(distinct ho_ten) from sinh_vien

select distinct ho_ten from sinh_vien -- distinct loc trung và có thứ tự tăng dần