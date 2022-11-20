use Northwind
 
--1. In ra thông tin các sản phẩm (nhãn hàng/mặt hàng) có trong hệ thống
-- - Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, mã chủng loại, đơn giá, số lượng trong kho 
-- - Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp (quốc gia)
-- - Output 3: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại
-- - Output 4: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp
select * from Products
select p.ProductID, p.ProductName, p.SupplierID, p.CategoryID, p.UnitPrice, p.UnitsInStock from Products p

select p.ProductID, p.ProductName, p.SupplierID, s.CompanyName, s.Country from Products p join Suppliers s
	     on p.SupplierID = s.SupplierID

select p.ProductID, p.ProductName, c.CategoryID ,c.CategoryName from Products p full join Categories c
		 on p.CategoryID = c.CategoryID

select p.ProductID, p.ProductName, c.CategoryID ,c.CategoryName, s.SupplierID, s.CompanyName, s.Country from Products p join Suppliers s
		 on p.SupplierID = s.SupplierID join Categories c
		 on c.CategoryID = p.CategoryID

--2. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Mỹ
-- - Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 
-- - Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, đơn giá, số lượng trong kho, mã chủng loại, tên chủng loại

select p.ProductID, p.ProductName, s.SupplierID, s.CompanyName, s.Country, p.UnitPrice, p.UnitsInStock from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
		 where s.Country = 'usa'

select p.ProductID, p.ProductName, s.SupplierID, s.CompanyName, p.UnitPrice, p.UnitsInStock, c.CategoryID, c.CategoryName from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID join Categories c
		 on c.CategoryID = p.CategoryID
		 where s.Country = 'usa'

--3. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Anh, Pháp, Mỹ
-- - Output: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 
select p.ProductID, p.ProductName, s.SupplierID, s.CompanyName, s.Country, p.UnitPrice, p.UnitsInStock from Products p join Suppliers s
		 on p.SupplierID = s.SupplierID
		 where s.Country in ('uk','france', 'usa')

-- 4. Có bao nhiêu nhà cung cấp?
select count(*) from Suppliers s

-- 5. Có bao nhiêu nhà cung cấp đến từ Mỹ
select count(*) from Suppliers where Country = 'usa'

-- 6. Nhà cung cấp Exotic Liquids cung cấp những sản phẩm nào
-- - Output 1: mã sản phẩm, tên sản phẩm, đơn giá, số lượng trong kho
-- - Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
-- - Output 3: mã nhà cung cấp, tên nhà cung cấp, mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng

select p.ProductID, p.ProductName ,p.UnitPrice , p.UnitsInStock, s.CompanyName from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
		 where s.CompanyName = 'Exotic Liquids' 

select p.ProductID, p.ProductName , c.CategoryID ,c.CategoryName ,s.CompanyName from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID join Categories c
		 on c.CategoryID = p.CategoryID
		 where s.CompanyName = 'Exotic Liquids' 

select s.SupplierID, s.CompanyName , p.ProductID , p.ProductName ,c.CategoryID, c.CategoryName from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID join Categories c
		 on c.CategoryID = p.CategoryID
		 where s.CompanyName = 'Exotic Liquids' 

--7. Mỗi nhà cung cấp cung cấp bao nhiêu mặt hàng (nhãn hàng)
-- - Output 1: mã nhà cung cấp, số lượng mặt hàng
-- - Output 2: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
select * from Suppliers
select * from Products

select s.SupplierID,count(*) as [NoProducts] from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
		 group by s.SupplierID

select s.SupplierID,s.CompanyName ,count(*) as [NoProducts] from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
			group by s.SupplierID, s.CompanyName

--8. Nhà cung cấp Exotic Liquids cung cấp bao nhiêu nhãn hàng?
-- - Output: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
select s.SupplierID,s.CompanyName ,count(*) as [NoProducts] from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
			group by s.SupplierID, s.CompanyName
			having s.CompanyName = 'Exotic Liquids'
	
--9. Nhà cung cấp nào cung cấp nhiều nhãn hàng nhất?
-- - Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
select s.SupplierID,s.CompanyName ,count(*) as [NoProducts] from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
			group by s.SupplierID, s.CompanyName 
			having count(*) >= all (
							select count(*) as [NoProducts] from Products p join Suppliers s 
							on p.SupplierID = s.SupplierID
							group by s.SupplierID
			)

--10. Liệt kê các nhà cung cấp cung cấp từ 3 nhãn hàng trở lên
-- - Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
select s.SupplierID,s.CompanyName ,count(*) as [NoProducts] from Products p join Suppliers s 
		 on p.SupplierID = s.SupplierID
			group by s.SupplierID, s.CompanyName
			having count(*) >= 3

--11. Có bao nhiêu nhóm hàng/chủng loại hàng
select count(*) from Categories

--12. In ra thông tin các sản phẩm (mặt hàng) kèm thông tin nhóm hàng
-- - Output: mã nhóm hàng, tên nhóm hàng, mã sản phẩm, tên sản phẩm
select c.CategoryID, c.CategoryName ,p.ProductID, p.ProductName from Products p join Categories c
		 on p.CategoryID = c.CategoryID

--13. Liệt kê các sản phẩm thuộc nhóm hàng Seafood
-- - Output 1: mã sản phẩm, tên sản phẩm
-- - Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
select p.ProductID, p.ProductName from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 where c.CategoryName = 'Seafood'

select p.ProductID, p.ProductName,c.CategoryID,c.CategoryName from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 where c.CategoryName = 'Seafood'

--14. Liệt kê các sản phẩm thuộc nhóm hàng Seafood và Beverages, sắp xếp theo nhóm hàng
-- - Output 1: mã sản phẩm, tên sản phẩm
-- - Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
select p.ProductID, p.ProductName from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 where c.CategoryName in ('Seafood', 'Beverages')
		 order by CategoryName 

select p.ProductID, p.ProductName,c.CategoryID,c.CategoryName from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 where c.CategoryName in ('Seafood', 'Beverages')
		 order by CategoryName

--15. Mỗi nhóm hàng có bao nhiêu nhãn hàng/mặt hàng
-- - Output 1: mã nhóm hàng số lượng nhãn hàng 
-- - Output 2: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng

select p.CategoryID ,count(*) as [NoProduct] from Categories c join Products p 
		 on c.CategoryID = p.CategoryID
		 group by p.CategoryID

select p.CategoryID ,c.CategoryName,  count(*) as [NoProduct] from Categories c join Products p 
		 on c.CategoryID = p.CategoryID
		 group by p.CategoryID,c.CategoryName

select sum([NoProduct]) from (select p.CategoryID ,c.CategoryName,  count(*) as [NoProduct] from Categories c join Products p 
		 on c.CategoryID = p.CategoryID
		 group by p.CategoryID,c.CategoryName) as tmp

--16. Nhóm hàng nào có nhiều nhãn hàng/mặt hàng nhất
-- - Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 
select c.CategoryID,c.CategoryName,count(*) [NoProduct] from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 group by p.CategoryID,c.CategoryID,c.CategoryName


--17. Nhóm hàng nào có từ 10 nhãn hàng/mặt trở lên
-- - Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 
select c.CategoryID,c.CategoryName,count(*) [NoProduct] from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 group by p.CategoryID,c.CategoryID,c.CategoryName
		 having count(*) >= 10

--18. In ra số lượng nhãn hàng/mặt hàng của 2 nhóm hàng Seafood và Beverages 
-- - Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng
select c.CategoryID,c.CategoryName,count(*) from Products p join Categories c
		 on p.CategoryID = c.CategoryID
		 where c.CategoryName in ('Seafood','Beverages')
		 group by p.CategoryID,c.CategoryID,c.CategoryName
		 
--19. In ra tất cả các đơn hàng
-- - Output 1: Mã đơn hàng, mã khách hàng, mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- - Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- - Output 3: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, mã công ty vận chuyển, tên công ty vận chuyển, gửi tới quốc gia nào
select o.OrderID, o.CustomerID, o.EmployeeID,o.OrderDate,o.ShipCountry from Orders o

select o.OrderID, o.CustomerID, o.EmployeeID, e.FirstName+' '+e.LastName as [employee Name], o.OrderDate, o.ShipCountry from Orders o join Employees e
				on o.EmployeeID = e.EmployeeID

select o.OrderID, o.CustomerID, o.EmployeeID, e.FirstName+' '+e.LastName as [employee Name], o.OrderDate, o.ShipCountry,s.ShipperID,o.ShipCountry from Orders o join Employees e
				on o.EmployeeID = e.EmployeeID join Shippers s
				on s.ShipperID = o.ShipVia

--20. In ra các đơn hàng gửi tới Mỹ
-- - Output 1: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- - Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
select o.OrderID, o.CustomerID, c.ContactName, e.EmployeeID, e.FirstName+' '+e.LastName as [employee Name],o.OrderDate,o.ShipCountry from Orders o join Customers c
		on o.CustomerID = c.CustomerID join Employees e
		on o.EmployeeID = e.EmployeeID
		where o.ShipCountry = 'usa'


select o.OrderID, o.CustomerID, c.ContactName,e.FirstName+' '+e.LastName as [employee Name], e.EmployeeID, o.OrderDate, o.ShipCountry from Orders o join Employees e
				on o.EmployeeID = e.EmployeeID join Customers c
				on c.CustomerID = o.CustomerID
				where o.ShipCountry = 'usa'

--21. In ra các đơn hàng gửi tới Anh, Pháp, Mỹ
-- - Output 1: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
-- - Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
select o.OrderID, o.CustomerID, c.ContactName, e.EmployeeID,o.OrderDate,o.ShipCountry from Orders o join Customers c
		on o.CustomerID = c.CustomerID join Employees e
		on o.EmployeeID = e.EmployeeID
		where o.ShipCountry in ('uk','france','usa')


--22. Có tổng cộng bao nhiêu đơn hàng?
select count(*) from Orders

--23. In ra tổng số chi tiết của mỗi đơn hàng (mỗi đơn hàng có bao nhiêu dòng chi tiết)
-- - Output 1: Mã đơn hàng, số lượng chi tiết đơn hàng
-- - Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, số lượng chi tiết đơn hàng
select count(*) from [Order Details]

select count(*) from Orders
			
select o.OrderID,count(*) from Orders o join [Order Details] od
		 on o.OrderID = od.OrderID
		 group by o.OrderID

select o.OrderID,c.CustomerID,c.ContactName,count(*) as [NoDetail] from Orders o join [Order Details] od
		 on o.OrderID = od.OrderID join Customers c
		 on c.CustomerID = o.CustomerID
		 group by o.OrderID,c.CustomerID,c.ContactName

-- 24. HẮC NÃO!!!!! - Tính tổng tiền của mỗi đơn hàng (nhớ trừ tiền giảm giá tùy theo từng đơn)
-- - Output 1: mã đơn hàng, tổng tiền (830 dòng) 
-- - Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, tổng tiền
select * from [Order Details]

select OrderID,sum([total]) as[final Price] from (
		select *, od.UnitPrice * od.Quantity * (1 - od.Discount) as [total] from [Order Details] od 
) as tmp
group by OrderID

select od.OrderID,sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID 
		group by od.OrderID


select od.OrderID, c.CustomerID, c.ContactName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID join Customers c
		on o.CustomerID = c.CustomerID
		group by od.OrderID, c.CustomerID, c.ContactName

--25. In ra các đơn hàng có tổng tiền từ 1000$ trở lên
-- - Output 1: mã đơn hàng, tổng tiền
-- - Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, tổng tiền
select od.OrderID,sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID 
		group by od.OrderID
		having sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) >= 1000

select od.OrderID, c.CustomerID, c.ContactName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID join Customers c
		on o.CustomerID = c.CustomerID
		group by od.OrderID, c.CustomerID, c.ContactName
		having sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) >= 1000

--26. Tính tiền của các đơn hàng gửi tới Mỹ (tính riêng cho từng đơn hàng)
-- - Output: mã đơn hàng, quốc gia, tổng tiền
select od.OrderID, o.ShipCountry,sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID 
		where o.ShipCountry = 'usa'
		group by od.OrderID, o.ShipCountry
		
--27. Tính tổng tiền của tất cả các đơn hàng gửi tới Mỹ (gom tổng)
-- - Output: quốc gia, tổng tiền

select o.ShipCountry,sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID 
		where o.ShipCountry = 'usa'
		group by o.ShipCountry

--28. Tính tiền của các đơn hàng gửi tới Anh, Pháp, Mỹ (tính riêng cho từng đơn hàng)
-- - Output: quốc gia, mã đơn hàng, tổng tiền
select od.OrderID, o.ShipCountry,sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID 
		where o.ShipCountry in ('uk','france','usa')
		group by od.OrderID, o.ShipCountry

--29. Tổng số tiền thu được từ tất cả các đơn hàng là bao nhiêu?
select sum([total]) from (
select od.OrderID, o.ShipCountry,sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [total] from [Order Details] od  join Orders o
		on od.OrderID = o.OrderID 
		group by od.OrderID, o.ShipCountry
) as tmp

--30. In ra số lượng đơn hàng của mỗi khách hàng
-- - Output: Mã khách hàng, tên khách hàng, số lượng đơn hàng đã mua
select c.CustomerID, c.ContactName ,count(*) [NoOrders] from Orders o join Customers c
		 on o.CustomerID = c.CustomerID
		 group by c.CustomerID, c.ContactName

--31. Khách hàng nào có nhiều đơn hàng nhất?
--- Output: Mã khách hàng, tên khách hàng, số lượng đơn hàng đã mua

select c.CustomerID, c.ContactName ,count(*) [NoOrders] from Orders o join Customers c
		 on o.CustomerID = c.CustomerID
		 group by c.CustomerID, c.ContactName
		 having count(*)  >= all (
				select count(*) [NoOrders] from Orders o join Customers c
				on o.CustomerID = c.CustomerID
				group by c.CustomerID
		 )

--32. Có bao nhiêu công ty giao hàng?
select count(*) as [NoShipCompany] from Shippers

--33. In ra số lượng đơn hàng mỗi công ty đã vận chuyển
-- - Output: Mã công ty giao hàng, tên công ty giao hàng, số lượng đơn đã vận chuyển
select  s.ShipperID,s.CompanyName,count(*) as [NoOrders] from Orders o join Shippers s 
		 on o.ShipVia = s.ShipperID
		 group by s.CompanyName, s.ShipperID,s.CompanyName

--34. Công ty nào vận chuyển nhiều đơn hàng nhất?
-- - Output: Mã công ty giao hàng, tên công ty giao hàng, số lượng đơn đã vận chuyển
select  s.ShipperID,s.CompanyName,count(*) as [NoOrders] from Orders o join Shippers s 
		 on o.ShipVia = s.ShipperID
		 group by s.CompanyName, s.ShipperID,s.CompanyName
		 having count(*) >= all (
				select  count(*) as [NoOrders] from Orders o join Shippers s 
				on o.ShipVia = s.ShipperID
				group by s.CompanyName
		 )

--35. In ra các đơn hàng vận chuyển bởi công ty Speedy Express
-- - Output 1: Mã đơn hàng, ngày đặt hàng, mã công ty giao hàng
-- - Output 2: Mã đơn hàng, ngày đặt hàng, gửi tới quốc gia nào, mã công ty giao hàng, tên công ty giao hàng
select  o.OrderID,o.OrderDate,s.ShipperID from Orders o join Shippers s 
		 on o.ShipVia = s.ShipperID
		 where s.CompanyName = 'Speedy Express'

select  o.OrderID,o.OrderDate,o.ShipCountry, s.ShipperID, s.CompanyName from Orders o join Shippers s 
		 on o.ShipVia = s.ShipperID
		 where s.CompanyName = 'Speedy Express'


--36. Công ty Speedy Express đã vận chuyển bao nhiêu đơn hàng 
-- - Output: Mã công ty giao hàng, tên công ty, số lượng đơn đã vận chuyển
select  s.ShipperID, s.CompanyName, count(ShipperID) as[totalShipOrders] from Orders o join Shippers s 
		 on o.ShipVia = s.ShipperID
		 where s.CompanyName = 'Speedy Express'
		 group by s.ShipperID, s.CompanyName
		 

--37. Thêm công ty giao hàng sau vào database bằng cách chạy lệnh sau
    INSERT INTO Shippers VALUES('UPS Vietnam', '(+84) 909...')
    
--sau đó in ra số lượng đơn hàng mỗi công ty đã vận chuyển
-- Output: Mã công ty giao hàng, tên công ty giao hàng, số lượng đơn đã vận chuyển
select * from Shippers
select  s.ShipperID,s.CompanyName,count(o.ShipVia) as [NoOrders] from Orders o right join Shippers s 
		 on o.ShipVia = s.ShipperID
		 group by s.CompanyName, s.ShipperID,s.CompanyName	

--38. Tiếp nối câu trên, in ra thông tin vận chuyển hàng của các công ty giao vận, sắp xếp theo mã số công ty giao vận
-- - Output: Mã công ty giao hàng, tên công ty giao hàng, mã đơn hàng, ngày đặt hàng
select  s.ShipperID,s.CompanyName,o.OrderID, o.OrderDate  from Orders o right join Shippers s 
		 on o.ShipVia = s.ShipperID
		 order by s.ShipperID asc

--39. Tiếp nối câu trên, công ty UPS Vietnam vận chuyển những đơn hàng nào?
-- - Output: Mã công ty giao hàng, tên công ty giao hàng, mã đơn hàng, ngày đặt hàng
select  s.ShipperID,s.CompanyName,o.OrderID, o.OrderDate  from Orders o right join Shippers s 
		 on o.ShipVia = s.ShipperID
		 where s.CompanyName like '%UPS Vietnam'
		 order by s.ShipperID asc
		
select * from Products
order by UnitPrice desc
offset 0 rows
fetch next 3 rows only

select * from Products
order by CategoryID asc