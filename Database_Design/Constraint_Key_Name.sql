create database Student_Management

use Student_Management

create table student (
	studentID char(8) primary key, -- bắt buộc phải nhập dữ liệu , cấm trùng
	lastName nvarchar(40) not null,
	firstName nvarchar(10) not null,
	dob datetime,
	[Address] nvarchar(50)
)

insert into student(studentID, lastName, firstName, dob, [Address])
values('SE1', N'lãm', N'Vũ', '4/7/2002', N'Hồ Chí Minh')

insert into student
values('SE3', N'lãm', N'Vũ')

select * from student	

create table student_V1 (
	studentID char(8), -- bắt buộc phải nhập dữ liệu , cấm trùng
	lastName nvarchar(40) not null,
	firstName nvarchar(10) not null,
	dob datetime,
	[Address] nvarchar(50),
	PRIMARY KEY(studentID)
)

insert into student_V1(studentID, lastName, firstName, dob, [Address])
values(null, N'lãm', N'Vũ', '4/7/2002', N'Hồ Chí Minh')

----học thêm về ràng buộc - constraint name 
----DB engine mặc định đặt tên cho các ràng buộc mà nó thấy 
---- vì vậy nên tự đặt tên ràng buộc cho dễ dàng quản lý các primary key

create table student_V2 (
	studentID char(8), -- bắt buộc phải nhập dữ liệu , cấm trùng
	lastName nvarchar(40) not null,
	firstName nvarchar(10) not null,
	dob datetime,
	[Address] nvarchar(50),
	--PRIMARY KEY(studentID) tự động đặt tên cho ràng buộc
	constraint PK_student_V2 primary key(studentID)
)

alter table student_V2 add constraint PK_stuedent_V2 primary key(sutdentID) -- tạo key bằng alter 

alter table student_V2 drop constraint PK_stuedent_V2 -- xóa một ràng buộc