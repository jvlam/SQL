use Cartesian

SELECT * FROM EnDict
SELECT * FROM VnDict
--BÔI ĐEN CẢ 2 LỆNH NÀY CHẠY, THÌ NÓ KO PHẢI LÀ JOIN, NÓ LÀ 2 CÂU RIÊNG BIỆT CHẠY
--CÙNG LÚC, CHO 2 TẬP KẾT QUẢ RIÊNG BIỆT!!!
--JOIN LÀ GỘP CHUNG 1 THÀNH 1 BẢNG TẠM TRONG RAM, KO ẢNH HƯỞNG DỮ LIỆU GỐC CỦA MỖI TABLE
--JOIN LÀ SELECT CÙNG LÚC NHIỀU TABLE


--================================================ CROSS JOIN =========================================================================================
-- Cách Viết 1
select * from EnDict,VnDict order by EnDesc

select * from EnDict, VnDict order by Nmbr --có hai cột Numbr không biết sort theo cột nào nên báo lỗi Ambigous

--GHÉP TABLE, JOIN BỊ TRÙNG TÊN CỘT, DÙNG ALIAS (AS), ĐẶT TÊN GIẢ ĐỂ THAM CHIẾU
--                                   CHỈ ĐỊNH CỘT THUỘC TABLE TRÁNH NHẦM

select * from EnDict, VnDict order by EnDict.Nmbr -- tham chieu cot qua ten table

select * from EnDict en, VnDict vn order by en.Nmbr -- dat ten gia de tham chieu

select vn.Nmbr, vn.VnDesc, en.EnDesc from EnDict en, VnDict vn order by en.Nmbr -- dat ten gia de tham chieu

select vn.Nmbr, vn.VnDesc, en.* from EnDict en, VnDict vn order by en.Nmbr -- en.* lấy hết cột trong enDict

select vn.*, en.* from EnDict [en], VnDict vn order by en.Nmbr 

--Cách viết 2

select * from EnDict cross join  VnDict order by EnDict.Nmbr -- tham chieu cot qua ten table

--TUI BIẾT RẲNG CÓ CẶP GHÉP XÀI ĐƯỢC, VÌ CÓ TƯƠNG HỢP TRONG CELL NÀO ĐÓ, HERE NMBR
select * from EnDict,VnDict 
	where EnDict.Nmbr = VnDict.Nmbr
	--GHÉP CÓ CHỌN LỌC KHI TÌM TƯƠNG QUAN CỘT/CELL ĐỂ GHÉP -> INNER JOIN/OUTER
		                     --EQUI JOIN
							 --ĐA PHẦN TƯƠNG GHÉP THEO TOÁN TỬ =
							 --CÒN CÓ THỂ GHÉP THEO > >= < <= !=

--================================================ INNER JOIN =========================================================================================
-- ghép một cách thực dụng
select * from EnDict,VnDict 
	where EnDict.Nmbr = VnDict.Nmbr

select * from EnDict,VnDict 
	where EnDict.Nmbr > VnDict.Nmbr

-- chuẩn thế giới 1
select * from EnDict en inner join VnDict vn 
		on en.Nmbr = vn.Nmbr

-- chuẩn thế giới 2 - co the bo inner
select * from EnDict en join VnDict vn 
		on en.Nmbr = vn.Nmbr

--================================================ OUTER JOIN =========================================================================================

----------------------------------------------------------------------------------
-- FULL OUTER JOIN, THỨ TỰ TABLE KO QUAN TRỌNG, VIẾT TRƯỚC SAU ĐỀU ĐC
-- LEFT, RIGH JOIN THỨ TỰ TABLE LÀ CÓ CHUYỆN KHÁC NHAU

-- OUTER JOIN SINH RA ĐỂ ĐẢM BẢO VIỆC KẾT NỐI GHÉP BẢNG 
-- KO BỊ MẤT MÁT DATA!!!!!!!
-- DO INNER JOIN, JOIN = CHỈ TÌM CÁI CHUNG 2 BÊN

-- SAU KHI TÌM RA ĐƯỢC DATA CHUNG RIÊNG, TA CÓ QUYỀN FILTER TRÊN LOẠI
-- CELL NÀO ĐÓ, WHERE NHƯ BÌNH THƯỜNG
----------------------------------------------------------------------------------

--1. Liệt kê cho tôi các cặp từ điển Anh-Việt
select * from EnDict e, VnDict v
		 where e.Nmbr = v.Nmbr -- có bằng cell thì mới ghép

select * from EnDict e join  VnDict v
		 on e.Nmbr = v.Nmbr 

--2. hụt mất 4 và 5  -- vậy lôi cross join để xem tất
select * from EnDict cross join VnDict

SELECT * FROM EnDict
SELECT * FROM VnDict

--3. muốn tiếng anh làm chuẩn tìm các nghĩa tiếng việt tương đương
--lấy trái làm gốc nhìn sang bên bảng bên kia , bên này không có thì null
select * from EnDict e left join VnDict v
		 on e.Nmbr = v.Nmbr

select * from EnDict e left outer join VnDict v
		 on e.Nmbr = v.Nmbr

--4. muốn lấy tiếng việt làm chuẩn tìm nghĩa tiếng anh tương đương
select * from  VnDict v left outer join EnDict e
		 on v.Nmbr = e.Nmbr

--5. vẫn lấy tiếng việt làm chuẩn , nhưng để  bên tay phải

select * from EnDict e right outer join VnDict v  --lấy thằng bên phải làm chuẩn nhìn xang bên kia 
		 on e.Nmbr = v.Nmbr 

--6. dù chung và riêng của mỗi bên , nhưng chấp nhận lấy tất 
select * from EnDict e full outer join VnDict v 
		 on e.Nmbr = v.Nmbr 

select * from EnDict e full join VnDict v  -- bỏ outer
		 on e.Nmbr = v.Nmbr 

--7. In ra bộ từ điển Anh Việt (Anh làm chuẩn) của những con số
-- từ 3 trở lên

select * from EnDict e left join VnDict v
		 on e.Nmbr = v.Nmbr
		 where e.Nmbr >= 3

--7. In ra bộ từ điển Anh Việt Việt Anh của những con số
-- từ 3 trở lên

select * from EnDict e full join VnDict v 
		 on e.Nmbr = v.Nmbr
		 where e.Nmbr >= 3 --sai

select * from EnDict e full join VnDict v 
		 on e.Nmbr = v.Nmbr
		 where e.Nmbr >= 3 or v.Nmbr >=3


