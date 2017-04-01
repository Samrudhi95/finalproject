use Training_18Jan2017_Talwade

Create Schema [EcommerceShoppingStore]

CREATE TABLE [EcommerceShoppingStore].[Category]
(
	[Category Id] INT NOT NULL PRIMARY KEY, 
    [Category Name] NVARCHAR(MAX) NOT NULL, 
    [Category Description] NVARCHAR(MAX) NOT NULL
)




CREATE TABLE [EcommerceShoppingStore].[Customer]
(
	[Customer Id] INT NOT NULL , 
    [First Name] NVARCHAR(MAX) NOT NULL, 
    [Last Name] NVARCHAR(MAX) NOT NULL, 
    [Email ID] NVARCHAR(MAX) NOT NULL, 
    [Mobile No.] NVARCHAR(50) NOT NULL, 
    [User ID] NVARCHAR(50) NOT NULL, 
    [Password] NVARCHAR(MAX) NOT NULL, 
    CONSTRAINT [PK_Customer] PRIMARY KEY ([Customer Id]) 
);

DROP TABLE [EcommerceShoppingStore].[Order]

CREATE TABLE [EcommerceShoppingStore].[Order] (
    [Order ID]        INT          NOT NULL,
    [Order Date]      DATETIME     NOT NULL,
    [Customer ID]     int     NOT NULL,
    [Product ID]      int     NOT NULL,
	[Price]           int      NOT NULL,
    [Quantity]        int          NOT NULL,
    [Total]           INT          NOT NULL,
    [BARoomNo]        nvarchar(MAX)         ,
    [BACity]          nvarchar(MAX)         ,
    [BAState]         nvarchar(MAX)    ,
    [BAPincode]       nvarchar(MAX)    ,
    [SARoomNo]        nvarchar(MAX)     ,
    [SACity]          nvarchar(MAX)          ,
    [SAState]		  nvarchar(MAX)           ,
    [SAPincode]		  nvarchar(MAX)           ,
    
    PRIMARY KEY CLUSTERED ([Order ID] ASC),
    CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([Customer ID]) REFERENCES [EcommerceShoppingStore].[Customer] ([Customer Id]), 
    CONSTRAINT [FK_Order_Product] FOREIGN KEY ([Product ID]) REFERENCES [EcommerceShoppingStore].[Product]([Product ID]), 
    
);


/******
CREATE TABLE [EcommerceShoppingStore].[Supplier]
(
	[Supplier ID] INT NOT NULL PRIMARY KEY, 
    [Comapany Name] NVARCHAR(MAX) NOT NULL, 
    [Address 1] NVARCHAR(MAX) NOT NULL, 
    [Address 2] NVARCHAR(MAX) NOT NULL, 
    [City] NVARCHAR(MAX) NOT NULL, 
    [State] NVARCHAR(MAX) NOT NULL, 
    [Postal Code] NVARCHAR(MAX) NOT NULL, 
    [Mobile No] NVARCHAR(50) NOT NULL, 
    [Email ID] NVARCHAR(50) NOT NULL, 
    [Web Site] NVARCHAR(50) NOT NULL, 
    [Logo] IMAGE NOT NULL, 
    [Ranking] INT NOT NULL, 
    [Note] NVARCHAR(MAX) NOT NULL
);
******/

drop table [EcommerceShoppingStore].[Product]

CREATE TABLE [EcommerceShoppingStore].[Product]
(
	[Product ID] INT NOT NULL , 
    [Product Name] NVARCHAR(50) NOT NULL, 
    [Category Id] INT NOT NULL, 
	[Product Desc] NVARCHAR(MAX) NOT NULL, 
    [Units] INT NOT NULL, 
    [Unit Price] INT NOT NULL, 
    [MRP] INT NOT NULL, 
    [Discount] DECIMAL NOT NULL, 
    [Picture] IMAGE NOT NULL, 
	[DateOfModification] Datetime ,
	[Category Description] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY ([Product ID]), 
    CONSTRAINT [FK_Product_Category] FOREIGN KEY ([Category Id]) REFERENCES [EcommerceShoppingStore].[Category]([Category Id]) 
)



--Stored Procedures

/****** Object:  StoredProcedure [EcommerceShoppingStore].[AddProduct]  ******/
create PROCEDURE [EcommerceShoppingStore].[AddProduct]
(
@ProductID Int,
@ProductName NVARCHAR(Max),
@CategoryID INT,
@ProductDesc NVARCHAR(MAX),
@Units INT, 
@UnitPrice INT , 
@MRP INT,
@Discount DECIMAL,
@Picture Image,
@DateOfModification datetime,
@CategoryDescription NVARCHAR(MAX)
)
As
BEGIN
insert into [EcommerceShoppingStore].[Product]
([Product ID],[Product Name],[Category Id],[Product Desc],[Units],[Unit Price],[MRP],[Discount],[Picture],[DateOfModification],[Category Description]) 
values(@ProductID,@ProductName,@CategoryID,@ProductDesc,@Units,@UnitPrice,@MRP,@Discount,@Picture,@DateOfModification,@CategoryDescription)
END



/****** Object:  StoredProcedure [EcommerceShoppingStore].[viewProduct]  ******/
create PROCEDURE [EcommerceShoppingStore].[viewProduct]
As
BEGIN
select * from [EcommerceShoppingStore].[Product]
END

/****** Object:  StoredProcedure [EcommerceShoppingStore].[viewOrder]  ******/
create PROCEDURE [EcommerceShoppingStore].[viewOrder]
As
BEGIN
select * from [EcommerceShoppingStore].[Order]
END

/****** Object:  StoredProcedure [EcommerceShoppingStore].[viewCustomer]  ******/
create PROCEDURE [EcommerceShoppingStore].[viewCustomer]
As
BEGIN
select * from [EcommerceShoppingStore].[Customer]  
END

/****** Object:  StoredProcedure [EcommerceShoppingStore].[UpdateProduct]  ******/
create PROCEDURE [EcommerceShoppingStore].[UpdateProduct]
(
@ProductID int,
@ProductDesc  NVARCHAR(MAX),
@UnitPrice INT , 
@Discount DECIMAL,
@Picture IMAGE 
)
As
BEGIN
UPDATE [EcommerceShoppingStore].[Product]
SET 
[Product Desc]=@ProductDesc,
[Unit Price]=@UnitPrice, 
[Discount]=@Discount,
[Picture]=@Picture
where [Product ID]=@ProductID
END



/****** Object:  StoredProcedure [EcommerceShoppingStore].[DeleteProduct]  ******/
create PROCEDURE [EcommerceShoppingStore].[DeleteProduct]
(
@ProductID INT
)
AS
BEGIN
 DELETE FROM [EcommerceShoppingStore].[Product]
 WHERE [Product ID]=@ProductID
 END


/****** Object:  StoredProcedure [EcommerceShoppingStore].[authenticateCustomer]  ******/
CREATE PROCEDURE [EcommerceShoppingStore].[authenticateCustomer]
	@UID nvarchar(max),
	@Pass nvarchar(max)
AS
	SELECT * from [EcommerceShoppingStore].Customer 
	where Customer.[User ID]=@UID and Customer.Password=@Pass


/****** Object:  StoredProcedure  [EcommerceShoppingStore].[addCustomer]  ******/
CREATE PROCEDURE  [EcommerceShoppingStore].[addCustomer]
	@FirstName nvarchar(max),
	@LastName nvarchar(max),
	@EmailID nvarchar(max),
	@MobileNo nvarchar(50),
	@UserID nvarchar(50),
	@Password nvarchar(max)
AS
	INSERT INTO  [EcommerceShoppingStore].[Customer]
           ([First Name]
           ,[Last Name]
           ,[Email ID]
           ,[Mobile No.]
           ,[User ID]
           ,[Password])
     VALUES
           (@FirstName,@LastName,@EmailID,@MobileNo,@UserID,@Password)


/****** Object:  StoredProcedure  [EcommerceShoppingStore].[addOrder]  ******/

CREATE PROCEDURE [EcommerceShoppingStore].[addOrder]
	@ODate datetime,
	@CID int,
	@PID int,
	@Price int,
	@Quantity int,
	@Total int,
	@BARNo nvarchar(max),
	@BACity nvarchar(max),
	@BAState nvarchar(max),
	@BAPincode nvarchar(max),
	@SARNo nvarchar(max),
	@SACity nvarchar(max),
	@SAState nvarchar(max),
	@SPincode nvarchar(max)
AS
	INSERT INTO [EcommerceShoppingStore].[Order]
           (
		   [Order Date]
           ,[Customer ID]
           ,[Product ID]
           ,[Price]
           ,[Quantity]
           ,[Total],
		   [BARoomNo], 
		   [BACity],   
		   [BAState] , 
		   [BAPincode],
		   [SARoomNo] ,
		   [SACity]  , 
		   [SAState],	
		   [SAPincode]
		   )
		  		
     VALUES
           (@ODate,@CID,@PID,@Price,@Quantity,@Total,@BARNo,@BACity,@BAState,@BAPincode,@SARNo,@SACity,@SAState,@SPincode)


CREATE PROCEDURE [EcommerceShoppingStore].[getCategory]
AS
Select * from EcommerceShoppingStore.Category



CREATE PROCEDURE [EcommerceShoppingStore].[getProductByName]
	@Type nvarchar(max)
AS
	Select * from [EcommerceShoppingStore].[Product] where [EcommerceShoppingStore].[Product].[Product Name]=@Type


CREATE PROCEDURE [EcommerceShoppingStore].[searchCategory]
	@Type nvarchar(max)
AS
	SELECT [EcommerceShoppingStore].Category.[Category Name] from [EcommerceShoppingStore].Category where [EcommerceShoppingStore].Category.[Category Description]=@Type;


alter PROCEDURE [EcommerceShoppingStore].[searchProduct]
	@Type nvarchar(max),
	@Type1 nvarchar(max)
AS
	Select * from [EcommerceShoppingStore].[Product] join [EcommerceShoppingStore].[Category] on [EcommerceShoppingStore].[Product].[Category Id]=[EcommerceShoppingStore].[Category].[Category Id] where[EcommerceShoppingStore].[Category].[Category Name]=@Type and [EcommerceShoppingStore].Product.[Category Description]=@Type1