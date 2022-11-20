use StudentManagement
--================================================ Student Management =========================================================================================
select * from Major
select * from Student

-- TỪ TỪ HÃY THÊM VÀO ĐỂ XEM FULL-OUTER JOIN RA SAO
select * from Major m full join Student s
		  on m.MajorID = s.MajorID

--1. In ra thông tin chi tiết của SV kèm thông tin chuyên ngành
select * from Student s join Major m
		 on s.MajorID = m.MajorID --dư cột id

select s.*, m.MajorName, m.Hotline from Student s join Major m
		 on s.MajorID = m.MajorID

--2. In ra thông tin chi tiết của sv kèm info chuyên ngành. Chỉ quan tâm sv SE và IA
select s.*, m.MajorName, m.Hotline from Student s join Major m 
		 on s.MajorID = m.MajorID
		 where m.MajorID in ('SE', 'IA')

--3. In ra thông tin các sinh viên kèm chuyên ngành. Chuyên ngành nào chưa có sv cũng in ra luôn
-- phân tích: căn theo sv mà in, thì HÀN QUỐC tèo ko xuất hiện
select s.*, m.MajorName, m.Hotline from Student s right join Major m
		 on s.MajorID = m.MajorID 

select s.*, m.MajorName, m.Hotline from Major m left join Student s
		 on s.MajorID = m.MajorID 

--4. Có bao nhiêu chuyên ngành???
select count(*) as [NoMajor] from Major
select count(MajorID) as [NoMajor] from Major

--5. Mỗi chuyên ngành có bao nhiêu sinh viên???
--output 0: số lượng sv đang theo học của từng chuyên ngành 
--output 1: mã cn | số lượng sv đang theo học
--phân tích: hỏi sv, bao nhiêu sv, đếm sv sure!!!
--           gặp thêm từ mỗi!!!!!!!
--           mỗi cn có 1 con số đếm, đếm theo chuyên ngành, chia nhóm chuyên ngành mà đếm
select m.MajorName, count(s.MajorID) as [NoMajor] from Major m full join Student s 
			 on m.MajorID = s.MajorID
			 group by m.MajorID, m.MajorName

select * from Major 
select * from Student
--6. Chuyên ngành nào có từ 3 sv trở lên???
--phân tích: chia chặng rồi
--           đầu tiên phải đếm chuyên ngành đã, quét qua bảng 1 lần để đếm ra sv
--           đếm xong, dợt lại kết quả, lọc thêm cái từ 3 sv trở lên
--           phải đếm xong từng ngành rồi mới tính tiếp
--           ???
select m.MajorName, count(s.MajorID) as [NoMajor] from Major m full join Student s 
			 on m.MajorID = s.MajorID
			 group by m.MajorID, m.MajorName
		     having count(s.MajorID) >= 3

--7. CHUYÊN NGÀNH NÀO CÓ ÍT SV NHẤT
select m.MajorName, count(s.MajorID) as [NoMajor] from Major m full join Student s 
			 on m.MajorID = s.MajorID
			 group by m.MajorID, m.MajorName
		     having count(s.MajorID)  <= all (
						select count(s.MajorID) as [NoMajor] from Major m full join Student s 
						on m.MajorID = s.MajorID
						group by m.MajorID
			 )

--8. Đếm số sv của chuyên ngành SE
--phân tích: câu này éo hỏi đếm các chuyên ngành
-- CỨ TÌM SE MÀ ĐẾM HOY

select count(*) from Student where MajorID = 'SE' --cau nay chay nhanh

select count(*) from Major m join Student s 
				on m.MajorID = s.MajorID
				where s.MajorID = 'SE' -- cau nay chay cham

--9. ĐẾM SỐ SV CỦA MỖI CN
--output: mã chuyên ngành, tên cn, số lượng sv
--phân tích: đáp án cần có info của 2 table
--           đếm trên 2 table
--           đếm trong Major hok có info sv
--           đếm trong SV chỉ có đc mã cn
--           mún có mã cn, tên cn, số lượng sv -> JOIN 2 BẢNG RỒI MỚI ĐẾM

select m.MajorID,m.MajorName,count(s.MajorID) from Student s right join Major m
		 on s.MajorID = m.MajorID 
		 group by m.MajorID,m.MajorName






