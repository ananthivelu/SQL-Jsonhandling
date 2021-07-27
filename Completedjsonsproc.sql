/*alter PROCEDURE InsertdataFromjson
       -- Add the parameters for the stored procedure here
       @json nvarchar(max)
	   AS
--Declaration of variables
declare @customerid int,@i int=0,@length int,@phno nvarchar(30);

SET @length = 
        (SELECT COUNT(*) 
         FROM OPENJSON(@json,'$.customer'))
		  WHILE @i < @length
        BEGIN
	    SELECT @customerID = NULL, @phno = NULL
        SELECT @phno = (select
        phonenumber from OPENJSON(@json) with(phonenumber varchar(30) '$.customer.phonenumber'))        
        SELECT @customerid = Id From customers1 where phonenumber = @phno
        if (@customerid is not null)
        Begin

     Insert into products1 
	 (customerid,object,quantity,rate,pricevalue,purchasedate)
	 select @customerid,object,quantity,rate,pricevalue,purchasedate from  openjson(@json,'$.customer') with (
	 object nvarchar(30) ,quantity nvarchar(30),rate nvarchar(30),pricevalue nvarchar(30),purchasedate date)
          set @i = @i +1;
		  end
		 else
begin
  insert into customers1
  (firstname,lastname,phonenumber,address,city)
  SELECT firstName,lastName,phonenumber,address,city FROM openjson(@json,'$.customer') with
   (firstName nvarchar(30),lastName nvarchar(30),phonenumber nvarchar(30),address nvarchar(30),city nvarchar(30))
   
   select @customerid= @@IDENTITY 
   
   Insert into products1
   (customerid,object,quantity,rate,pricevalue,purchasedate)
   
	 select @customerid,object,quantity,rate,pricevalue,purchasedate from openjson(@json,'$.customer') with (
	 object nvarchar(30) ,quantity nvarchar(30),rate nvarchar(30),pricevalue nvarchar(30),purchasedate date)
 end
	set @i = @i +1;

END 
 
 select * from customers1
 select * from products1
 
 */
 --use ananthi

 alter PROCEDURE InsertdataFromjson
       -- Add the parameters for the stored procedure here
       @json nvarchar(max)
	   AS
--Declaration of variables
declare @customerID int,@i int=0,@j int=0,@customerlength int,@phno nvarchar(30),@productlength int;

SET @customerlength = 
        (SELECT COUNT(*) 
         FROM OPENJSON(@json,'$.customer'))

WHILE @i < @customerlength
        BEGIN
        
	    SELECT @customerID = NULL, @phno = NULL
        SELECT @phno = (select JSON_VALUE(@json,CONCAT('$.customer[',@i,'].phonenumber')) )      
        SELECT @customerID = Id From customers1 where phonenumber = @phno
        if (@customerID is not null)
        Begin
		SET @productlength = 
        (SELECT COUNT(*) 
         FROM OPENJSON(@json,CONCAT('$.customer[',@i,'].product')))
		WHILE @j < @productlength
		  begin
     Insert into products1 
	 (customerid,object,quantity,rate,pricevalue,purchasedate)
	 select @customerid,
	 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].object'))),
	 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].quantity'))),
	 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].rate'))),
	  (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].pricevalue'))),
	 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].purchasedate')))
           set @j = @j +1;
 
 end
 set @i = @i +1;
 set @j = 0;
	end
	
	
		 else
begin
		  insert into customers1
		  (firstname,lastname,phonenumber,address,city)
		  VALUES( 
		  (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','firstName'))),
		  (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','lastName'))),
		  (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','phonenumber'))),
		  (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','address'))),
		  (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','city'))))

		  select @customerid= @@IDENTITY 
		  
		  SET @productlength = 
		 (SELECT COUNT(*) 
         FROM OPENJSON(@json,CONCAT('$.customer[',@i,'].product')))
   
WHILE @j < @productlength
begin
		 
		 Insert into products1 
		 (customerid,object,quantity,rate,pricevalue,purchasedate)
		 select @customerid,
		 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].object'))),
		 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].quantity'))),
		 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].rate'))),
		 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].pricevalue'))),
		 (JSON_VALUE(@json, CONCAT('$.customer[',@i,'].','product[',@j,'].purchasedate')))
          
		  set @j = @j +1;
 
 end
 set @i = @i +1;
	end
	
	set @j = 0;
END 
 select * from products1
 select * from customers1

