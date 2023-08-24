CREATE DATABASE Library

USE Library

CREATE TABLE Books(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) CHECK(LEN(Name)>=2),
PageCount INT CHECK(PageCount>=10),
AuthorId INT FOREIGN KEY REFERENCES Authors(Id)
)

CREATE TABLE Authors(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(100) CHECK(LEN(Name)>=2),
Surname NVARCHAR(100) CHECK(LEN(Surname)>=2)
)

INSERT INTO Books VALUES('Kecel qizin naqillari',120,1),('Almanlar',250,2),('System',240,3)

INSERT INTO Authors(Name,Surname) VALUES('Mustafa','Melikov'),('Amrah','Nasirov'),('Ahmad','Mehdiyev')



--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde
--olan Book-lari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin
CREATE VIEW usv_Books_Authors
AS
SELECT b.Id, b.Name, b.PageCount, (a.Name + ' '+ a.Surname) 'AuthorFullName' FROM Books as b 
JOIN Authors as a
On b.AuthorId = a.Id


--Authors tableinin insert, update ve deleti ucun (her biri ucun ayrica) procedure yaradin
alter Procedure usp_GetStuGroupTeacherByAge
(@age tinyint)
as
begin
	select * from usv_GetStuGroupTeachers where Age > @age
end

exec usp_GetStuGroupTeacherByAge 20


--Authorslari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz Id-author id-si,
--FullName - Name ve Surname birlesmesi, BooksCount - Hemin authorun elaqeli oldugu kitablarin sayi,
--MaxPageCount - hemin authorun elaqeli oldugu kitablarin icerisindeki max pagecount deyeri


SELECT a.Id, (a.Name +' '+ a.Surname) 'AuthorFullName', (select Max(b.PageCount) from Books where b.AuthorId=a.Id)
FROM Books AS b
JOIN Authors AS a
ON b.AuthorId = a.Id