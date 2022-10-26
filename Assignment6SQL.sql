create table Categories(
    Id int primary key identity(1,1),
    Name nvarchar(100) not null unique
);
create table Authors(
    Id int primary key identity(1,1),
    Name nVARCHAR(100),
);
create table Publishers(
    Id int primary key identity(1,1),
    Name nvarchar(100) not null unique,
    Address nvarchar(100) not null
);
create table Books(
    Code varchar(20) primary key,
    Name varchar(100) not null unique,
    Description text,
    PublishYear int not null,
    NumberOfPublish int,
    Price decimal(12,4),
    Qty int not null default 0,
    CategoryId int not null foreign key references Categories(Id),
    PublisherId int not null foreign key references Publishers(Id)
);
create table BookAuthors(
    BookCode varchar(20) foreign key references Books(Code),
    AuthorId int foreign key references Authors(Id)
);

-- Nhap du lieu

insert into Categories(Name)
values (N'Khoa học xã hội'),
       (N'Văn học nghê thuật'),
	   (N'Khoa học công nghệ');
select * from Categories;

insert into Publishers(Name,Address)
values (N'Tri thức',N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
       (N'NXB Kim Đồng',N'54 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
	   (N'NXB Giáo dục',N'55 Nguyễn Trãi, Hai Bà Trưng, Hà Nội');
select * from Publishers;

insert into Authors(Name)
values (N'Eran Katz'),
       (N'Nguyễn Du'),
	   (N'Nguyễn Nhật Ánh');
select * from Authors;

insert into Books(Code,Name,Description,PublishYear,NumberOfPublish,Price,Qty,CategoryId,PublisherId)
values ('B001',N'Trí tuệ Do Thái',N'Sách về người Do Thái',2010,1,79000,100,1,1),
       ('B002',N'Truyện Kiều',N'Văn học Việt Nam',1814,11,300000,1000,2,2),
	   ('B003',N'Tin học đại cương',N'Lập trình cơ bản với C++',2002,3,60000,3200,3,3);
select * from Books;

insert into BookAuthors(BookCode,AuthorId)
values ('B001',1),
       ('B002',2),
	   ('B003',3);
select * from BookAuthors;

-- Bai tap

--3. Liệt kê các cuốn sách có năm xuất bản từ 2008 đến nay
select Name from Books where PublishYear>2008 and PublishYear<getdate();

--4. Liệt kê 10 cuốn sách có giá bán cao nhất
select top 10 * from Books order by Price desc;

--5. Tìm những cuốn sách có tiêu đề chứa từ “Tin học”
select * from Books where Name like N'Tin học %';

--6. Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần


--7. Liệt kê các cuốn sách của nhà xuất bản Tri thức
select Name from Books where PublisherId in
   (select Id from Publishers where Name like N'Tri thức');

--8. Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
select * from Publishers where Id in
   (select PublisherId from Books where Name like N'Trí tuệ Do Thái');

--9. Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản,Loại sách
select d.Code,d.Name,d.PublishYear,b.Name,a.Name from Books d
right join Publishers b on d.PublisherId =b.Id        --Lấy bên Books và Name của cả 2 cái
left join Categories a on d.CategoryId=a.Id;          --Lấy bên Categories và Name của cả hai cái

--10. Tìm cuốn sách có giá bán đắt nhất
select top 1 Name from Books order by Price desc;

--11. Tìm cuốn sách có số lượng lớn nhất trong kho
select top 1 Name from Books order by Qty desc;

--13. Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước
--update Books set Price = Price - 10 percent Price where PublishYear < 2008;

--14. Thống kê số đầu sách của mỗi nhà xuất bản
--select count(*),Name from Books where PublisherId in
   (select Id from Publishers);

--15. Thống kê số đầu sách của mỗi loại sách


--16. Đặt chỉ mục (Index) cho trường tên sách
create index chi_muc_phi_vat_ly on Books(Code);
select * from Books;
drop index chi_muc_phi_vat_ly on Books;             --xóa chỉ mục phi vật lý



