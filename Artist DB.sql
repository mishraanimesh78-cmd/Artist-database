create database ArtistDB;
use artistdb;

-- 1.All Records
SELECT * FROM ARTIST;
SELECT * FROM CUSTOMER;
SELECT * FROM EMPLOYEE;
SELECT * FROM GENRE;
SELECT * FROM INVOICE;
SELECT * FROM INVOICELINE;
SELECT * FROM MEDIATYPE;
SELECT * FROM PLAYLIST;
SELECT * FROM PLAYLISTTRACK;
SELECT * FROM TRACK;

-- 2.Names from Artist table
select name from Artist;

-- 3.customers from india
select * from customer where country='INDIA';

-- 4.employees with title sales support agent
select * from employee where title='sales support agent';

-- 5.genres shorted alphabetically
select * from genre order by Name ASC;

-- 6.Invoices where total more than 100
select * from invoice where total>10;

-- 7.cutomers from delhi and mumbai
select * from customer where city ='delhi'or 'mumbai';

-- 8.tracks longer than 5 minutes
select * from track where milliseconds >300000;

-- 9.top 10 most expensive tracks
select * from track order by unitprice desc limit  10; 

select I.total,I.invoiceid,IL.trackid,T.name from Invoice I inner join Invoiceline IL inner join Track t on 
I.invoiceid=IL.invoiceid=IL.trackid=T.trackid order by I.total desc limit 10;

-- 10.invoices with latest date
select * from invoice order by invoicedate desc;

-- 11.total customers
select count(customerid) from customer;

-- 12.total sales
select count(invoiceid) from invoice;

-- 13.calculate avg track duration
select avg(milliseconds) from track;

-- 14.max and min invoice total
select max(total),min(total) from invoice;

-- 15.NO. of tracks in genre
select genreid, count(*) from track group by genreid;

-- 16.customers with their invouces
select c.customerid,c.firstname,c.lastname,i.invoiceid,i.invoicedate,i.total from customer c inner join invoice i 
on c.customerid=i.invoiceid ;

-- 17.invoice details with track names
select Il.invoiceid,t.trackid,Il.unitprice,Il.quantity,t.name,I.total from Invoiceline Il inner join Invoice I  on 
I.invoiceid=IL.Invoiceid
inner join track t on Il.trackid=t.trackid;

-- 18.tracks with their genre names
select t.trackid,t.name,t.genreid,g.name from track t inner join genre g 
on t.genreid=g.genreid;

-- 19.playlist with their tracks
select t.trackid,p.playlistid,p.name,t.name from track t 
inner join playlisttrack pt on t.trackid=pt.playlistid
inner join playlist p on p.playlistid=pt.playlistid;

-- 20.employees and supported customers
select e.employeeid,e.firstname,e.lastname,c.customerid,c.firstname,c.lastname,c.supportrepid from employee e
inner join customer c ;

-- 21.total sales per country
select billingcountry ,sum(total) from invoice group by billingcountry;

-- 22.customers per country
select country,count(customerid) from customer group by country;

-- 23.tracks per playlist
select playlistid ,count(trackid) from playlisttrack group by playlistid;

-- 24.genres with more than 50 tracks
select genreid ,count(trackid) from track   
 group by genreid having count(trackid) > 50; 
 
 -- 25.customer spending more than 10
 select customerid,sum(total) from invoice
 group by customerid
 having sum(total) >10;
 
 -- 26.customer spent more than average
 select customerid,sum(total)
 from invoice group by customerid
 having sum(total) > (select avg(total) from invoice);
 
 -- 27.track priced above average
 select *  from track 
 
 where unitprice > (select avg(unitprice) from track);
 
 
-- 28.most expensive track
select * from track
where unitprice= (select max(unitprice) from track);

-- 29.customers with no purchase
SELECT * FROM Customer
WHERE CustomerId NOT IN (SELECT CustomerId FROM Invoice);

-- 30.genre with highest track
SELECT GenreId, COUNT(*) 
FROM Track GROUP BY GenreId
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 31.top 5 customer by spending
select customerid, sum(total) as spending from invoice
group by customerid
order by spending desc limit 5;

-- 32.most purchased track
 select t.name , count(*) as count from invoiceline il
 join track t on t.trackid=il.trackid
 group by t.name
 order by count desc
 limit 1;
 
 -- 33.most popular genre
 select g.name , count(*) as purchases from invoiceline il 
 join track t on il.trackid = t.trackid
 join genre g on t.genreid = g.genreid
 group by g.name order by purchases desc limit 1;
 
 -- 34.employee handling most customers
 SELECT SupportRepId, COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY SupportRepId
ORDER BY TotalCustomers DESC
LIMIT 1;

-- 35.playlist with more than 20 tracks
select playlistid ,count(*) from playlisttrack group by playlistid
having  count(*) > 20; 

-- 36.insert new customer
insert into customer (firstname,lastname,country)
values ('Animesh', 'Mishra', 'India');
select firstname from customer;

-- 39.ADD a new genre
INSERT INTO Genre (Name) VALUES ('Podcast');
select name from genre;

-- 40.increase track price by 10%
set sql_safe_updates=0;
UPDATE Track
SET UnitPrice = UnitPrice * 1.10;

-- 41. View for top customers
CREATE VIEW TopCustomers AS
SELECT CustomerId, SUM(Total) AS Spending
FROM Invoice
GROUP BY CustomerId;

-- 42. Stored procedure
DELIMITER //
CREATE PROCEDURE GetInvoices(IN cid INT)
BEGIN
    SELECT * FROM Invoice WHERE CustomerId = cid;
END //
DELIMITER ;

-- 43. Index
CREATE INDEX idx_customer ON Invoice(CustomerId);

-- 44. Monthly sales
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
       SUM(Total)
FROM Invoice
GROUP BY Month;

-- 45. Inactive customers (example logic)
SELECT * FROM Customer
WHERE CustomerId NOT IN (
    SELECT CustomerId
    FROM Invoice
    WHERE InvoiceDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);




 
 
 
 
 
 


