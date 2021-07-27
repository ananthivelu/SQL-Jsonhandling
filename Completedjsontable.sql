drop table customers1
drop table products1
create table customers1(id int identity(1,1),firstname nvarchar(50),lastname nvarchar(50),phonenumber nvarchar(30),
	address nvarchar(30),city nvarchar(30))
create table products1
(
 customerid int,
 productid int identity(1,1),
 object NVARCHAR(30),
 quantity NVARCHAR(30) ,
 rate NVARCHAR(30),
 pricevalue NVARCHAR(30),
 purchasedate date)
 -------------------
 --drop PROCEDURE InsertdataFromjson
--create
--use ananthi
 /*
 truncate table customers1
  truncate table products1
 */

