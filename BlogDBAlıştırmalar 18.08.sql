--Yazar ekleme sp.
ALTER proc [dbo].[YazarEkle]
@autname nvarchar(50),
@autsurname nvarchar(50),
@birthdate datetime,
@rolid int
as
insert into Authors(AuthorName,AuthorSurname,Birthdate,RolID) values (@autname,@autsurname,@birthdate,@rolid)

exec YazarEkle 'eda','zeynep','12-12-1997',2
select * from Authors

--User detail ekleyen
create proc UserEkle
@mail nvarchar(150)
as
insert into UserDetails(Mail) values (@mail)

exec UserEkle 'eda.gucuk@hotmail.com'
select * from UserDetails

--yorum ekleyen sp
create proc YorumEkle
@comment nvarchar (550),
@userid int
as
insert into Comments(Comment,UserID) values (@comment,@userid)

exec YorumEkle 'gadhsbsjklhþ',1
select * from Comments

--KAtegori ekle
create proc KategoriEkle
@catname nvarchar(50)
as
insert into Categories (CategoryName) values (@catname)

exec KategoriEkle 'sanat'
select * from Categories

--rol ekle
create proc RolEkle
@rolname nvarchar(50)
as
insert into Rol(RolName) values (@rolname)

exec RolEkle 'admin'
select * from Rol

--yeni içerik hazýrlayan sp.
create proc IcerikEkle
@subname nvarchar(50),
@catid int,
@autid int
as
insert into Contents (SubjectName,CategoryID,AuthorID) values (@subname,@catid,@autid)

exec IcerikEkle 'saðlýklý yaþam',1,4
select * from Contents

--view tüm tablolar
alter view vwBlog
as
select r.RolID,r.RolName,r.RolExp,a.AuthorID,a.AuthorName,a.AuthorSurname,a.Birthdate,a.Follower,c.ContentID,c.SubjectName,cat.CategoryID,cat.CategoryName,com.CommentID,com.Comment,com.CommentTime,ud.Mail,ud.Phone,ud.Adress from Rol r 
inner join Authors a on r.RolID=a.RolID 
inner join Contents c on c.AuthorID=a.AuthorID
inner join Categories cat on cat.CategoryID=c.CategoryID
inner join Comments com on com.CommentID=c.CommentID
inner join UserDetails ud on ud.UserID=com.UserID

select * from vwBlog