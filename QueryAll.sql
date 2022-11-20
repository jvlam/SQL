use Northwind

--========================================= Select Only ===============================================================================================

select getdate()
select getdate() as [hôm nay là ngày]
select month(getdate()) as [current month]
select day(getdate()) as [current day]
select 1 + 5 as [result]

select N'Vũ ' + N'Anh' + N' Lãm' as [tên tôi là]

select year(getdate()) - 2002 as [my birthday]

select N'Vũ ' + N'Anh' + N'Lãm ' + convert(varchar,year(getdate()) - 2002) + N'Tuổi' as [my profile]

select N'Vũ ' + N'Anh' + N'Lãm ' + cast(year(getdate()) - 2002 as nvarchar) + N'Tuổi' as [my profile]

--======================================= Select One Table ============================================================================================
select * from Customers

insert into Customers(CustomerID, CompanyName,ContactName) values ('fpt', 'hahaha', 'ben')


select * from Customers
		where CustomerID like '%f%'

select * from shippers
select * from Products
select * from Orders
select * from [Order Details]

select CustomerID,  CompanyName, ContactName, Country from Customers
select * from employees

select  LastName + ' '+  FirstName as [fullName], Title from Employees

select LastName + ' '+  FirstName as [fullName], year(getdate()) - year(birthdate) as age  from Employees

--======================================= Select Distinct =============================================================================================
-- lọc trùng data 
select * from Employees

select TitleOfCourtesy from Employees

select distinct TitleOfCourtesy from Employees

select distinct EmployeeID, TitleOfCourtesy from Employees -- vô dụng vì employeeid không trùng  nên không loại trừ được

select * from Customers

select distinct  city from Customers

--======================================= Select Sorting [Order]  =====================================================================================
select * from Employees

select * from Employees order by BirthDate asc  -- ascending by year
select * from Employees order by BirthDate      -- default increasing

select * from Employees order by BirthDate desc -- descending by year

select * from [Order Details]
--tính tiền phải trả và sắp xếp theo thứ tự giảm dần 
select *, UnitPrice * Quantity * ( 1- Discount )  as Total from [Order Details]
order by Total desc

--in ra danh sách nhân viên giảm dần theo tuổi
select * from Employees
select LastName + ' ' + FirstName, year(getdate()) - year(BirthDate) as age  from Employees
order by age desc

--======================================= Select WHERE  ===============================================================================================
-- LÍ THUYẾT
-- CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- MỆNH ĐỀ WHERE: DÙNG LÀM BỘ LỌC/FILTER/NHẶT RA NHỮNG DỮ LIỆU TA CẦN THEO 1 TIÊU CHÍ NÀO ĐÓ
-- VÍ DỤ: Lọc ra những sv có quê ở Bình Dương
--        Lọc ra những sv có quê ở Tiền Giang và điểm tb >= 8

-- CÚ PHÁP DÙNG BỘ LỌC
-- SELECT * (cột bạn muốn in ra) FROM <TÊN-TABLE> WHERE <ĐIỀU KIỆN LỌC>
-- * ĐIỀU KIỆN LỌC: TÌM TỪNG DÒNG, VỚI CÁI-CỘT CÓ GIÁ TRỊ CẦN LỌC
--                  LỌC THEO TÊN CỘT VỚI VALUE THẾ NÀO, LẤY TÊN CỘT, XEM VALUE TRONG CELL 
--                  CÓ THỎA ĐIỀU KIỆN LỌC HAY KO?

select * from Customers

select * from Customers where country = N'italy'

select * from Customers where Country = 'usa'

select * from Customers where country = 'italy' or 'usa'  -- sai vì không biết usa là thể hiện ý nghĩa gì ????
select * from Customers where Country = 'italy' and Country = 'usa' -- sai do điều kiện
select * from Customers where Country = 'italy' or Country = 'usa' -- đúng chuẩn

select * from Customers where Country = 'italy' or Country =  'usa' order by Country

select * from Customers where Country = 'usa' and city = 'san francisco'

------- lấy dữ liệu từ bảng Employees kèm điều kiện theo WHERE--------

select * from Employees

select * from Employees where year(BirthDate) >= 1960

select * from Employees where year(getdate()) - year(BirthDate) >= 60

select * from Employees where city = 'london'
select * from Employees where city != 'london' -- same
select * from Employees where city <> 'london' -- same

select * from Employees where not(city = 'london')
--select * from Employees where !(city = 'london')  -- wrong statement	

select * from Employees where EmployeeID = 1

------- lấy dữ liệu từ bảng Orders kèm điều kiện theo WHERE--------

select * from Orders

select * from orders where freight >= 500 
order by Freight desc 


select * from Orders where Freight >= 100 and freight <= 500
order by Freight desc

select * from Orders where Freight between 100 and 500 
order by Freight desc

--In thông tin bên Đơn hàng sắp xếp giảm dần theo trọng lượng, trọng lượng nằm trong khoảng từ
--100 đến 500 và ship bởi cty giao vận số 1
select * from Orders where (freight >= 100 and Freight <= 500 ) and ShipVia = 1

select * from Orders where (freight >= 100 and Freight <= 500 ) and ShipVia = 1 and ShipCity != 'london'
select * from Orders where (freight >= 100 and Freight <= 500 ) and ShipVia = 1 and ShipCity <> 'london'
select * from Orders where (freight >= 100 and Freight <= 500 ) and ShipVia = 1 and not (ShipCity = 'london')
-- RẤT RẤT CẨN THẬN KHI TRONG MỆNH ĐỀ WHERE LẠI CÓ AND OR TRỘN VỚI NHAU, TA PHẢI XÀI THÊM ()
-- ĐỂ PHÂN TÁCH THỨ TỰ FILTER... (SS AND OR KHÁC NỮA) AND (SS KHÁC)


--======================================= Select RANGE  ===============================================================================================
---------------------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP MỞ RỘNG LỆNH SELECT
-- KHI CẦN LỌC DỮ LIỆU TRONG 1 ĐOẠN CHO TRƯỚC, THAY VÌ DÙNG >= ... AND <= ..., TA CÓ THỂ THAY THẾ
-- BẰNG MỆNH ĐỀ BETWEEN, IN
-- * Cú pháp: CỘT BETWEEN VALUE-1 AND VALUE-2
--                        >>>>>>> BETWEEN THAY THẾ CHO 2 MỆNH ĐỀ >= <= AND

-- * Cú pháp: CỘT IN (MỘT tập các giá trị đc liệt kê cách nhau dấu phẩy)
--                        >>>>>>> IN THAY THẾ CHO 1 LOẠT OR
---------------------------------------------------------------
-- 1. Liệt kê danh sách nhân viên sinh trong năm 1960...1970

select * from Employees

select * from Employees where year(BirthDate) between 1960 and 1970

select * from orders where ShipCountry = 'UK' or ShipCountry =  'france' or ShipCountry = 'usa'   --too long 

select * from orders where ShipCountry in ('uk', 'usa', 'france')

select * from orders where ShipCountry not in ('uk', 'usa', 'france')

-- 5. Liệt kê các đơn hàng trong năm 1996 loại trừ các tháng 6 7 8 9
select * from Orders where year(OrderDate) = 1996 and month(OrderDate) not in (6,7,8,9)

-- LƯU Ý IN: CHỈ KHI TA LIỆT KÊ ĐC TẬP GIÁ TRỊ THÌ MỚI CHƠI IN
-- KHOẢNG SỐ THỰC THÌ KO LÀM ĐC

--======================================= Select NULL  ================================================================================================
---------------------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP MỞ RỘNG CỦA SELECT
-- Trong thực tế có những lúc dữ liệu/info chưa xác định đc nó là gì???
-- kí tên danh sách thi, danh sách kí tên có cột điểm, điểm ngay lúc kí tên
-- chưa xđ đc. Từ từ sẽ có, sẽ update sau
-- Hiện tượng dữ liệu chưa xđ, chưa biết, từ từ đưa vào sau, hiện nhìn vào
-- chưa thấy có data, thì ta gọi giá trị chưa xđ này là NULL
-- NULL ĐẠI DIỆN CHO THỨ CHƯA XĐ, CHƯA XĐ TỨC LÀ KO CÓ GIÁ TRỊ, KO GIÁ TRỊ
-- THÌ KO THỂ SO SÁNH > >= < <= = !=
-- CẤM TUYỆT ĐỐI XÀI CÁC TOÁN TỬ SO SÁNH KÈM VỚI GIÁ TRỊ NULL
-- TA DÙNG TOÁN TỬ, IS NULL, IS NOT NULL, NOT (IS NULL) ĐỂ FILTER CELL CÓ
-- GIÁ TRỊ NULL
---------------------------------------------------------------

select * from Employees

select * from Employees where Region == null -- fully wrong, totally wrong
select * from Employees where Region is null

select * from Employees where Region is not null
select * from Employees where not(Region is null)

select * from Employees where Title = 'Sales Representative' and Region is not null

--5. Liệt kê danh sách khách hàng đến từ Anh Pháp Mĩ, có cả thông tin số fax và region
select * from Customers where country in ('uk', 'france', 'usa') and (fax is not null) and not(Region  is null)

--======================================= Select LIKE  ================================================================================================
---------------------------------------------------------------
-- LÍ THUYẾT
-- CÚ PHÁP MỞ RỘNG CỦA SELECT
-- Trong thực tế có những lúc ta muốn tìm dữ liệu/filter theo kiểu gần đúng
-- gần đúng trên kiểu chuỗi, ví dụ, liệt kê ai đó có tên là AN, khác câu
-- liệt kê ai đó tên bắt đầu bằng chữ A
-- Tìm đúng, TOÁN TỬ = 'AN'
-- Tìm gần đúng, tìm có sự xuất hiện, KO DÙNG =, DÙNG TOÁN TỬ LIKE
--                   LIKE 'A...'...
-- ĐỂ SỬ DỤNG TOÁN TỬ LIKE, TA CẦN THÊM 2 THỨ TRỢ GIÚP, DẤU % VÀ DẤU _
-- % đại diện cho 1 chuỗi bất kì nào đó
-- _ đại diện cho 1 kí tự bất kì nào đó
-- VÍ DỤ: Name LIKE 'A%', bất kì ai có tên xh bằng chữ A, phần còn lại là gì ko care
--        Name LIKE 'A_', bất kì ai có tên là 2 kí tự, trong đó kí tự đầu phải là A
-----------------------------------------------------------------------------

SELECT * from Employees

select * from Employees where FirstName = 'A%' -- wrong query , do not allowed  '='
select * from Employees where FirstName like 'A%'

select FirstName + ' ' + LastName as fullName, Title from Employees where FirstName like 'A%' 
select concat(FirstName ,' ', LastName) as fullName, Title from Employees where FirstName like 'A%' 

select FirstName + ' ' + LastName as fullName, Title  from Employees where FirstName like '%A'

-- tìm những nhân nhân viên có 4 kí tự
select * from Employees where FirstName like '_____'

SELECT * from Products

select * from Products where ProductName like 'ch%' 

select * from Products where ProductName like '%ch'

select * from Products where ProductName like '%ch%'

--sản phẩm tên có chứa 5 kí tự

select * from Products where ProductName like '_____' 
-- Những sản phẩm trong tên sp mà từ cuối cùng là 5 kí tự

select * from Products where ProductName like '%_____' -- sẽ chứa những tên có từ 5 kí tự trở lên 

select * from Products where ProductName like '% _____' -- sẽ chứa từ cuối cùng trong tên chỉ đúng 5 kí tự
														-- vô tình loại đi thằng tên chỉ có đúng 5 kí tự


select * from Products where ProductName like '% _____' or ProductName like '_____'

--======================================= Select subQuery [single value]===============================================================================

---------------------------------------------------------------
-- LÍ THUYẾT
--	Cú pháp chuẩn của lệnh SELECT
-- SELECT * FROM <TABLE> WHERE...

-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT LIKE PATTERN NÀO ĐÓ e.g. '_____'
-- WHERE CỘT BETWEEN RANGE
-- WHERE CỘT IN (TẬP HỢP GIÁ TRỊ ĐC LIỆT KÊ)

-- MỘT CÂU SELECT TÙY CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 VALUE/CELL
-- MỘT CÂU SELECT TÙY CÁCH VIẾT CÓ THỂ TRẢ VỀ ĐÚNG 1 TẬP GIÁ TRỊ/CELL
-- TẬP KẾT QUẢ NÀY ĐỒNG NHẤT (CÁC GIÁ TRỊ KHÁC NHAU CỦA 1 BIẾN)

--*****
-- WHERE CỘT = VALUE NÀO ĐÓ - đã học, e.g YEAR(DOB) = 2003
--           = THAY VALUE NÀY = 1 CÂU SQL KHÁC MIỄN TRẢ VỀ 1 CELL
-- KĨ THUẬT VIẾT CÂU SQL THEO KIỂU HỎI GIÁN TIẾP, LỒNG NHAU, TRONG
-- CÂU SQL CHỨA CÂU SQL KHÁC

---------------------------------------------------------------

select * from Employees

-- Liệt kê các nhân viên cùng quê với King Robert
select city from Employees where FirstName like 'robert'

-- phân tích
-- đầu tiên phải tìm city của thằng tên là Robert nó ở
-- sau đó tìm những city nào có tên giống như city của thằng robert để tìm những thằng cùng quê 

select * from Employees where city in (
	select city from Employees where FirstName like 'robert' 
) -- kết quả này vẫn có robert ở trong do đó bị thừa 

select * from Employees where city in (
	select city from Employees where FirstName like 'robert' 
) and FirstName not like 'robert' -- chuẩn cơm mẹ nấu

select * from Employees where city like 'london'


-------Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn 252kg------
select * from Orders

 select * from Orders where Freight >= 252

-------Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn = trọng lượng đơn hàng 10555

select * from Orders where freight >= (

select freight from Orders where OrderID = 10555

) -- xuất hiện luôn cả 10555

select * from Orders where freight >= (
select freight from Orders where OrderID = 10555
) and OrderID <> 10555

 select * from Shippers
 --1. Liệt kê danh sách các công ty vận chuyển hàng
 select CompanyName from Shippers 
 --2. Liệt kdanh sách các đơn hàng đc vận chuyển bởi công ty giao vận
 --   có mã số 1
 select * from Shippers where ShipperID = 1
 --3. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận
 --   có tên Speedy Express
 select ShipperID from Shippers  where CompanyName like 'speedy express'

 select * from Orders where ShipVia = (
	select ShipperID from Shippers  where CompanyName like 'speedy express'
 )
 --4. Liệt kê danh sách các đơn hàng đc vận chuyển bởi cty giao vận
 --   có tên Speedy Express và trọng lượng từ 50-100
 select * from Orders where ShipVia = (
	select ShipperID from Shippers  where CompanyName like 'speedy express'
 ) and Freight between 50 and 100
 --5. Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix
select * from Products where CategoryID in (
	select CategoryID from Products where ProductName = 'filo mix'
)
 --6. Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet
select  year(getdate()) - year(BirthDate)  as age from Employees where FirstName like 'janet'

select * from Employees where year(getdate()) - year(BirthDate) < (
	select  year(getdate()) - year(BirthDate)  as age from Employees where FirstName like 'janet'
)

--======================================= Select subQuery [multiple value]=============================================================================
---------------------------------------------------------------
-- LÍ THUYẾT
--	Cú pháp chuẩn của lệnh SELECT
-- SELECT * FROM <TABLE> WHERE...

-- WHERE CỘT = VALUE NÀO ĐÓ
-- WHERE CỘT IN (MỘT TẬP HỢP NÀO ĐÓ)
-- ví dụ: City IN ('London', 'Berlin', 'NewYork') -- thay bằng OR OR OR
--                                                   City = 'London' OR City = 'Berlin'...
-- NẾU CÓ 1 CÂU SQL MÀ TRẢ VỀ ĐƯỢC 1 CỘT, NHIỀU DÒNG
-- MỘT CỘT VÀ NHIỀU DÒNG THÌ TA CÓ THỂ XEM NÓ TƯƠNG ĐƯƠNG MỘT TẬP HỢP
-- SELECT CITY FROM EMPLOYEES, BẠN ĐC 1 LOẠT CÁC T/P 
-- TA CÓ THỂ NHÉT/LỒNG CÂU 1 CỘT/NHIỀU DÒNG VÀO TRONG MỆNH ĐỀ IN CỦA CÂU SQL BÊN NGOÀI
-- * CÚ PHÁP
-- WHERE CỘT IN (MỘT CÂU SELECT TRẢ VỀ 1 CỘT NHIỀU DÒNG - NHIỀU VALUE CÙNG KIỂU - TẬP HỢP)
----------------------------------------------------------------

select * from Categories
--2. In ra các món hàng/mặt hàng thuộc nhóm 1, 6, 8
select * from Products where CategoryID in (1,6,8)
--3. In ra các món hàng thuộc nhóm bia/rượu, thịt, và hải sản
select * from Products where CategoryID in (
	select CategoryID from Categories where CategoryName in ('Beverages', 'Meat/Poultry', 'Seafood')
)

--4. Nhân viên quê London phụ trách những đơn hàng nào
select * from Orders where EmployeeID in (
	select EmployeeID from Employees where City = 'london'
)

--BTVN
--
--1. Các nhà cung cấp đến từ Mĩ cung cấp những mặt hàng nào?
select * from Suppliers
select * from Products
select * from Products where SupplierID in (
	select SupplierID from suppliers where Country = 'usa'
)
--2. Các nhà cung cấp đến từ Mĩ cung cấp những nhóm hàng?
select * from Categories where CategoryID in (
select CategoryID from Products where SupplierID in (
		select SupplierID from suppliers where Country = 'usa'
	)
)

select * from Categories
select * from Products
select * from Suppliers
--3. Các đơn hàng vận chuyển tới thành phố Sao Paulo đc vận chuyển bởi những hãng nào
--   Các cty nào đã vc hàng tới Sao Paulo
select * from Orders
select * from Shippers

select CompanyName from Shippers where ShipperID in (
	select ShipVia from Orders where ShipCity = 'sao paulo'
)
--4. Khách hàng đến từ thành phố Berlin, London, Madrid có những đơn hàng nào
--   Liệt kê các đơn hàng của khách hàng đến từ Berlin, London, Madrid
select * from Customers
select * from Orders

select * from Orders where CustomerID in (
select CustomerID from Customers where city in ('Berlin','London','Madrid')
)

select * from Orders where CustomerID in (
select CustomerID from Customers where city in ('Berlin','London','Madrid')
) and ShipCity <> 'Colchester'

select CustomerID from Customers where city in ('Berlin','London','Madrid')
select CustomerID from Customers where city = 'Berlin'
select CustomerID from Customers where city = 'London'
select CustomerID from Customers where city = 'Madrid'

select distinct CustomerID from Orders where ShipCity = 'Colchester'

--======================================= Select subQuery [all any]====================================================================================

---------------------------------------------------------------
-- LÍ THUYẾT
-- Cú pháp chuẩn của lệnh SELECT
-- SELECT * FROM <TABLE> WHERE...
-- WHERE CỘT TOÁN-TỬ-SO-SÁNH VỚI-VALUE-CẦN-LỌC
--       CỘT > >= < <= = !=  VALUE
--                           DÙNG CÂU SUB-QUERY TÙY NGỮ CẢNH
--       CỘT              = (SUB CHỈ CÓ 1 VALUE)
--       CỘT              IN (SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)

--       CỘT              > >= < <= ALL (1 CÂU SUB 1 CỘT NHIỀU VALUE)
--                                  ANY (1 CÂU SUB 1 CỘT NHIỀU VALUE)
---------------------------------------------------------------

CREATE TABLE Num
(
	Numbr int
)

SELECT * FROM Num
INSERT INTO Num values (1)
INSERT INTO Num values (1)
INSERT INTO Num values (2)
INSERT INTO Num values (9)
INSERT INTO Num values (5)
INSERT INTO Num values (100)
INSERT INTO Num values (101)

select * from num

select * from num where Numbr > 5

--2. In ra số lớn nhất trong các số đã nhập
--SỐ LỚN NHẤT TRONG 1 ĐÁM ĐC ĐỊNH NGHĨA LÀ: MÀY LỚN HƠN HẾT CẢ ĐÁM ĐÓ, VÀ MÀY BẰNG CHÍNH MÀY
--lớn hơn tất cả, ngoại trừ chính mình -> mình là MAX CỦA ĐÁM
select * from num where Numbr  >= all (select * from Num)
select * from num where Numbr  > all (select * from Num)


--lấy số nhỏ nhất
select * from num where Numbr  <= all (select * from Num)
-- nhân viên có tuổi lớn nhất
select * from Employees where BirthDate <= all (select BirthDate from Employees) 
-- đơn hàng có trọng lượng nặng nhất
select * from Orders where Freight >= all (select Freight from Orders)

select top 1 * from num order by Numbr asc

--======================================= Select  aggregate function - Count ==========================================================================
-------------------------------------------------------------------------------------
-- LÍ THUYẾT
-- DB ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- * CÚ PHÁP CHUẨN
-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>

-- * CÚ PHÁP MỞ RỘNG

-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO CỤM CỘT NÀO)

-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO CỤM CỘT NÀO) HAVING...

-- * HÀM COUNT(???) ĐẾM SỐ LẦN XUẤT HIỆN CỦA 1 CÁI GÌ ĐÓ???
--       COUNT(*):  ĐẾM SỐ DÒNG TRONG TABLE, ĐẾM TẤT CẢ CÁC DÒNG KO CARE TIÊU CHUẨN NÀO KHÁC
--       COUNT(*) FROM... WHERE ...
--                  CHỌN RA NHỮNG DÒNG THỎA TIÊU CHÍ WHERE NÀO ĐÓ TRƯỚC ĐÃ, RỒI MỚI ĐẾM
--                  FILTER RỒI ĐẾM  
--
--       COUNT(CỘT NÀO ĐÓ): đếm theo cột , cell nào trong cột null thì không đếm 

-------------------------------------------------------------------------------------
select * from Employees

--1. đếm xem có bao nhiêu nhân viên 
select count(*) from Employees
select count(*) as [NumberOfEmployees] from Employees

--2. có bao nhiêu nhân viên ở london  , filter roi dem
select count(*) as [employee_In_London] from Employees where city = 'london'

--3. có bao nhiêu lượt thành phố xuất hiện - cứ xuất hiện thành phố là đếm, không care lặp lại hay không
select count(city) from Employees

--4. đếm xem có bao nhiêu region - count cột chứa null , thì nó không tính, không đếm
select count(region) from Employees

--5. đếm xem có bao nhiêu dòng region là  null
select count(*) from Employees where Region is null

--6. có bao nhiêu thành phố trong table nhân viên
select count(distinct City) from Employees 
select * from Employees

--SUB QUERY MỚI, COI 1 CÂU SELECT LÀ 1 TABLE, BIẾN TABLE NÀY VÀO TRONG MỆNH ĐỀ FROM
select distinct City from Employees 

select * from (
		select distinct City from Employees 
) as city

select count(*) as city from (
			select distinct City from Employees 
) as countCity

--======================================= Select  aggregate function- Group By ========================================================================
-------------------------------------------------------------------------------------------------------
--CHỐT HẠ: KHI XÀI HÀM GOM NHÓM, BẠN CÓ QUYỀN LIỆT KÊ TÊN CỘT LẺ Ở SELECT 
--         NHƯNG CỘT LẺ ĐÓ BẮT BUỘC PHẢI XUẤT HIỆN TRONG MỆNH ĐỀ GROUP BY 
--         ĐỂ ĐẢM BẢO LOGIC: CỘT HIỂN THỊ | SỐ LƯỢNG ĐI KÈM, ĐẾM GOM THEO CỘT HIỂN THỊ MỚI LOGIC
-- CỨ THEO CỘT CITY MÀ GOM, CỘT CITY NẰM Ở SELECT HỢP LÍ 
-- MUỐN HIỂN THỊ SỐ LƯỢNG CỦA AI ĐÓ, GÌ ĐÓ, GOM NHÓM THEO CÁI GÌ ĐÓ 

-- NẾU BẠN GOM THEO KEY/PK, VÔ NGHĨA HENG, VÌ KEY HOK TRÙNG, MỖI THẰNG 1 NHÓM, ĐẾM CÁI GÌ???
-- NHƯNG ĐIỀU ĐÓ CHỈ XUẤT HIỆN KHI ĐẾM KEY TRONG 1 bảng , VÌ TRONG 1 BẢNG ĐÓ THÌ key sẽ không được phép trung =>>> count(*) vô nghĩa  
-- CÒN KHI KEY ĐÓ LÀ KHÓA NGOẠI CỦA BẢNG KHÁC THÌ VẪN GROUP BY KEY ĐÓ ĐƯỢC,  VÌ KEY TRONG BẢNG KHÁC NÀY ĐƯỢC PHÉP TRÙNG .
-- nên GROUP BY bình thường.
--------------------------------------------------------------------------------------------------------

--8. Đếm xem MỖI thành phố có bao nhiêu nhân viên
-- KHI CÂU HỎI CÓ TÍNH TOÁN GOM DATA (HÀM AGGREGATE) MÀ LẠI CHỨA TỪ KHÓA MỖI....
-- GẶP TỪ "MỖI", CHÍNH LÀ CHIA ĐỂ ĐẾM, CHIA ĐỂ TRỊ, CHIA CỤM ĐỂ GOM ĐẾM
select * from Employees
--Seatle 2 | Tacoma 1 | Kirland 1 | Redmon 1 | London 4
--đếm cái lần xuất hiện của nó trong nhóm đó , sang nhóm khác reset đếm lại 
--vd Seatle là 2, Tacoma là 1

select count(city) from Employees group by city -- đếm value của city , cùng tên thì vào 1 nhóm 
select city,count(city) as [No employees] from Employees group by city 

--sai bét vì employee là id không trùng 
select EmployeeID,city,count(city) as [No employees] from Employees group by city,EmployeeID 

--đếm xem mỗi nước có bao nhiêu nhân viên
select country, count(Country) from Employees group by Country


--9. HÃY CHO TUI BIẾT TP NÀO CÓ TỪ 2 NV TRỞ LÊN
-- 2 chặng làm
-- 9.1 Các tp có bao nhiêu nhân viên
-- 9.2 Đếm xong mỗi tp, ta bắt đầu lọc lại kết quả sau đếm
-- FILTER SAU ĐẾM, WHERE SAU ĐẾM, WHERE SAU KHI ĐÃ GOM NHÓM, AGGREGATE THÌ GỌI LÀ HAVING
select City ,count(city) as[NoCity] from Employees group by city  --đếm theo cột
having count(city) >= 2 
select City ,count(*) as[NoCity] from Employees group by city   -- đếm theo dòng
having count(*) >= 2

--10. Đếm số nhân viên của 2 thành phố Seatle và London
select city,count(*) from Employees where city = 'london' or city = 'seattle' 
group by city

--11. Trong 2 tp, London Seattle, tp nào có nhiều hơn 3 nv
select city,count(*) from Employees 
where city = 'london' or city = 'seattle' 
group by city 
having count(*) >= 3

--12. Đếm xem có bao nhiêu đơn hàng đã bán ra
select * from Orders
select count(*) from Orders where ShipCity is null
select count(ShipCity) from Orders

--12.1. Nước Mĩ có bao nhiêu đơn hàng
select count(*) from Orders where ShipCountry = 'USA'

--12.2. Mĩ Anh Pháp chiếm tổng cộng bao nhiêu đơn hàng - WHERE GOM CHUNG
select ShipCountry,count(*) from Orders 
where ShipCountry in ('usa', 'france', 'uk')
group by ShipCountry

--12.4. Trong 3 quốc gia A P M, quốc gia nào có từ 100 đơn hàng trở lên
select ShipCountry,count(*) from Orders 
where ShipCountry in ('usa', 'france', 'uk')
group by ShipCountry
having count(*) >=100


--13. Đếm xem có bao nhiêu mặt hàng có trong kho
--====================================
--|--------BÀI TẬP LÀM THÊM----------|
--====================================

--14. Đếm xem có bao nhiêu lượt quốc gia đã mua hàng 
select count(ShipCity) from Orders

--15. Đếm xem có bao nhiêu quốc gia đã mua hàng (mỗi quốc gia đếm một lần)
select count(*) as TotalOrderOfCountry from (
	select ShipCountry ,count(*) as orders from Orders group by ShipCountry
) as [country]

--16. Đếm số lượng đơn hàng của mỗi quốc gia
select ShipCountry ,count(*) as orders from Orders group by ShipCountry -- 21

--17. Quốc gia nào có từ 10 đơn hàng trở lên
select ShipCountry ,count(*) as orders from Orders group by ShipCountry -- 19
having count(*) >= 10
 
--18. Đếm xem mỗi chủng loại hàng có bao nhiêu mặt hàng (bia rượu có 5 sp, thủy sản 10 sp)
select CategoryID,count(*) as[NoProduct] from Products group by CategoryID
select * from Products
select * from Categories

--19. Trong 3 quốc gia A P M, quốc gia nào có nhiều đơn hàng nhất
select ShipCountry,count(*) [NoOrders] from Orders where ShipCountry in ('uk', 'france', 'usa')
group by ShipCountry
having count(*) >= all (select count(*) [NoOrders] from Orders where ShipCountry in ('uk', 'france', 'usa')
group by ShipCountry)

select * from Orders

--20. Quốc gia nào có nhiều đơn hàng nhất
select ShipCountry,count(*) as [NoOrders] from Orders group by ShipCountry
having count(*) >= all (
	select count(*) as [NoOrders] from Orders group by ShipCountry
)

--21. Thành phố nào có nhiều nhân viên nhất???
select city ,count(*) as [NoEmployee] from Employees
where city is not null
group by City 
having count(*) >= all (
	select count(*) as [NoEmployee] from Employees
	where city is not null
	group by City 
)

--======================================= Select  aggregate function -COUNT() SUM() MIN() MAX() AVG() ======================================================================
-------------------------------------------------------------------------------------
-- LÍ THUYẾT
-- DB ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- * CÚ PHÁP CHUẨN
-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>
-- SELECT CỘT,... HÀM GOM NHÓM(), ... FROM <TABLE> WHERE ... GROUP BY... HAVING (WHERE THỨ 2) 
-------------------------------------------------------------------------------------

-- 1. Liệt kê danh sách nhân viên
select * from Employees
--2. Năm sinh nào là bé nhất (tuổi max)
select year(BirthDate) as minB from Employees where year(BirthDate)  <= all (
	select year(BirthDate) from Employees 
) 

select year(BirthDate) as maxB from Employees where year(BirthDate)  >= all (
	select year(BirthDate) from Employees 
) 

select min(year(BirthDate)) from Employees

select max(year(BirthDate)) from Employees

--3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
select * from Employees where year(BirthDate) in (
	select min(year(BirthDate)) from Employees
)

select * from Employees where year(BirthDate) in (
	select max(year(BirthDate)) from Employees
)

--4.1. Trọng lượng nào là lớn nhất trong các đơn hàng đã bán
select max(freight) from Orders
select * from Orders
--4.2. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
select * from Orders where Freight = (
	select max(freight) from Orders
)

select * from Orders where Freight <= (
	select min(freight) from Orders
)

--5. Tính tổng khối lượng của các đơn hàng đã vận chuyển
select sum(Freight) from Orders 

--6. TRUNG BÌNH CÁC ĐƠN HÀNG NẶNG BAO NHIÊU???
select avg(freight) from Orders

--7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
select * from Orders where Freight >= (
		select avg(freight) from Orders
) 

--8. Có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
select count(*) from (
	select * from Orders where Freight >= (
		select avg(freight) from Orders
	) 
) as [avg]

--====================================
--|--------BÀI TẬP LÀM THÊM----------|
--====================================
--1. In danh sách nhân viên
select * from Employees

--2. Đếm xem mỗi khu vực có bao nhiêu nv
select * from Employees
select * from Region
select Region, count(Region) from Employees group by Region

select Region, count(*) from Employees group by Region

--5. Quốc gia nào có NHIỀU ĐƠN HÀNG NHẤT
select max([NoOrder]) from (
select ShipCountry,count(*) as [NoOrder] from Orders group by ShipCountry
) as tmp

--6. LIỆT KÊ CÁC ĐƠN HÀNG CỦA K/H MÃ SỐ VINET
select * from Customers where CustomerID = 'VINET'

--7. K/H VINET đã mua bao nhiêu lần???
select count(*) from (
	select * from Orders as [NoOrder] where CustomerID = 'VINET'
) as tmp

select CustomerID,count(*) from Orders group by CustomerID
having CustomerID = 'VINET'

