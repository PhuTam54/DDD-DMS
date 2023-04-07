DROP DATABASE IF EXISTS OrderDetails
GO

CREATE DATABASE OrderDetails
GO

USE OrderDetails
GO

--1, 2
CREATE TABLE [Order] (
	orderID integer NOT NULL,
	customerID integer NOT NULL,
	order_date date NOT NULL,
	order_status integer NOT NULL,
  CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED
  (
  [orderID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Customer] (
	customerID integer NOT NULL,
	c_name varchar(50) NOT NULL,
	c_address varchar(50) NOT NULL,
	c_phone integer NOT NULL,
  CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED
  (
  [customerID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [OrderDetails] (
	orderID integer NOT NULL,
	productID integer NOT NULL,
	sold_price float NOT NULL,
	sold_qty integer NOT NULL,
  CONSTRAINT [PK_ORDERDETAILS] PRIMARY KEY CLUSTERED
  (
  [orderID], [productID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Product] (
	productID integer NOT NULL,
	p_name varchar(25) NOT NULL,
	p_description varchar(50),
	p_unit varchar(15) NOT NULL,
	p_price float NOT NULL,
	p_qty integer NOT NULL,
	p_status integer NOT NULL,
  CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED
  (
  [productID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
ALTER TABLE [Order] WITH CHECK ADD CONSTRAINT [Order_fk0] FOREIGN KEY ([customerID]) REFERENCES [Customer]([customerID])
ON UPDATE CASCADE
GO
ALTER TABLE [Order] CHECK CONSTRAINT [Order_fk0]
GO

ALTER TABLE [OrderDetails] WITH CHECK ADD CONSTRAINT [OrderDetails_fk0] FOREIGN KEY ([orderID]) REFERENCES [Order]([orderID])
ON UPDATE CASCADE
GO
ALTER TABLE [OrderDetails] CHECK CONSTRAINT [OrderDetails_fk0]
GO
ALTER TABLE [OrderDetails] WITH CHECK ADD CONSTRAINT [OrderDetails_fk1] FOREIGN KEY ([productID]) REFERENCES [Product]([productID])
ON UPDATE CASCADE
GO
ALTER TABLE [OrderDetails] CHECK CONSTRAINT [OrderDetails_fk1]
GO

--3 INSERT DATA
INSERT INTO Customer VALUES
(1, 'Nguyễn Văn An', '111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 987654321)
GO
INSERT INTO Customer VALUES
(2, 'Nguyễn Phú Tâm', 'Từ Sơn, Bắc Ninh', 123456789)
GO

/*
DELETE FROM Customer
WHERE customerID = 123
GO
*/

INSERT INTO [Order] VALUES
(123, 1, '11/18/09', 1)
GO
INSERT INTO [Order] VALUES
(999, 2, '11/19/09', 1)
GO

INSERT INTO Product VALUES
(1, 'Máy tính T450', 'Máy nhập mới', 'Chiếc', 1000, 99, 1),
(2, 'Điện Thoại Nokia5670', 'Điện thoại đang hot', 'Chiếc', 200, 99, 1),
(3, 'Máy In Samsung 450', 'Máy in đang ế', 'Chiếc', 100, 99, 1)
GO
INSERT INTO Product VALUES
(4, 'Laptop MSI modern 15', 'Máy nguyên seal', 'Máy', 739, 69, 0)
GO

INSERT INTO OrderDetails VALUES
(123, 1, 1000, 1),
(123, 2, 200, 2),
(123, 3, 100, 1)
GO
INSERT INTO OrderDetails VALUES
(999, 4, 699, 54)
GO

--4 a) RESULT 1
SELECT * FROM Customer
GO
--4 b) RESULT 2
SELECT * FROM Product
GO
--4 c) RESULT 3
SELECT * FROM [Order]
GO

--5 a) ALPHABET
SELECT * FROM Customer
ORDER BY c_name ASC
GO
--5 b) DESC
SELECT * FROM Product
ORDER BY p_price DESC
GO
	
--5 c) Nguyen Van An's order
SELECT O.orderID, O.customerID, O.order_date, C.c_name, P.productID, P.p_name, OD.sold_price, OD.sold_qty FROM [Order] AS O
INNER JOIN OrderDetails AS OD
ON O.orderID = OD.orderID
INNER JOIN Customer AS C
ON O.customerID = C.customerID
INNER JOIN Product AS P
ON OD.productID = P.productID
WHERE C.customerID IN(1, 2)
GO

--6 a) NUMBER OF CUSTOMERS
SELECT COUNT(customerID) AS 'Number of customer' FROM Customer
GO

--6 b) NUMBER OF PRODUCTS THAT SOLD
SELECT COUNT(productID) AS 'Number of products that sold' FROM OrderDetails
GO

--6 c) SUM
SELECT SUM(sold_price) AS 'TOTAL PRICE' FROM OrderDetails
GO

select * from OrderDetails

-- 7 a)
ALTER TABLE Product
ADD CONSTRAINT CHK_Price CHECK (p_price > 0)
GO

--7 b)
ALTER TABLE [Order]
ADD CONSTRAINT CHEK_Date CHECK (order_date < GETDATE())
GO

/*
ALTER TABLE [Order]
DROP CONSTRAINT CHEK_Date
*/

--7 c)
ALTER TABLE Product
ADD created_date date
GO

UPDATE Product
SET created_date = '2023-3-7'
GO
Select * From Product

--8 a) Index
CREATE INDEX idx_product
ON Product(p_name)
GO

CREATE INDEX idx_customer
ON Customer(c_name)
GO

--8 b) View
CREATE VIEW View_Customer AS
SELECT c_name, c_address, c_phone
FROM Customer

SELECT * FROM View_Customer

CREATE VIEW View_Product AS
SELECT p_name, p_price
FROM Product

SELECT * FROM View_Product

CREATE VIEW View_Customer_Product AS
SELECT c_name, c_phone, p_name, p_qty, created_date
FROM Customer, Product
GO

SELECT * FROM View_Customer_Product

DROP VIEW View_Customer_Product

--8 c) Store Procedure
/*
CREATE PROCEDURE SP_FindCus_CusID
AS
SELECT 
EXEC SP_FindCus_CusID 
GO

CREATE PROCEDURE SP_FindCus_OrderID
AS
SELECT 
EXEC SP_FindCus_OrderID
GO
*/
--LIET KE SP DUOC MUA BOI KH CO MA DUOC TRUYEN VAO STORE
CREATE PROCEDURE SP_SanPham_MaKH @CID integer
AS
SELECT O.customerID, C.c_name, P.productID, P.p_name, OD.sold_price FROM [Order] AS O
INNER JOIN OrderDetails AS OD
ON O.orderID = OD.orderID
INNER JOIN Customer AS C
ON O.customerID = C.customerID
INNER JOIN Product AS P
ON OD.productID = P.productID
WHERE C.customerID = @CID
GO

EXEC SP_SanPham_MaKH @CID = 2
GO
