select (u.FirstName+' '+u.LastName),art.ArtistName,g.GenreName,a.Title,od.Price from Users u
inner join Orders o on u.UserID=o.UserID
inner join OrderDetails od on o.OrderID=od.OrderID
inner join Shippers s on s.ShipperID=o.ShipperID
inner join Albums a on od.AlbumID=a.AlbumID
inner join	Genres g on a.GenreID=g.GenreID
inner join Artists art on a.AlbumID=art.ArtistID 