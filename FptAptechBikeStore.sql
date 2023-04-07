USE FptAptechBikeStore
GO

SELECT * FROM sales.customers
GO

--LẤY KÍ TỰ TƯƠNG ĐỐI = %
SELECT last_name as L , first_name as F, phone as P from sales.customers as C
WHERE state like 'C%'
GO

--FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY
SELECT city AS CITY,COUNT(city) AS NUMBER 
FROM sales.customers AS C 
WHERE state LIKE 'CA'
GROUP BY city 
ORDER BY CITY ASC
GO

SELECT COUNT(city) FROM sales.customers

--ORDER BY
SELECT * FROM sales.customers
ORDER BY last_name DESC, city ASC
GO

--JOIN
SELECT C.last_name , C.first_name, O.order_id, O.order_date, S.staff_id, S.first_name, S.last_name
FROM sales.customers AS C
INNER JOIN sales.orders AS O
ON C.customer_id = O.customer_id

INNER JOIN sales.staffs AS S
ON O.staff_id = S.staff_id

ORDER BY O.order_date DESC

GO

--SELECT VS WHERE
SELECT * FROM sales.customers 
WHERE phone IS NOT NULL
GO

--SELECT VS WHERE BETWEEN
SELECT * FROM production.products 
WHERE list_price BETWEEN 100 AND 200
ORDER BY list_price

SELECT * FROM sales.orders
WHERE order_date BETWEEN '2017-01-01' AND '2018-01-01'
ORDER BY order_date desc

--WHERE VS DATE 
SELECT * FROM sales.orders
WHERE order_date > '2018-01-01'
ORDER BY order_date
GO

--ALIAS
SELECT first_name + ' ' + last_name AS FULLNAME
FROM sales.customers
GO

--WHERE VS IN 
SELECT * FROM production.products
WHERE list_price IN(89.99, 149.99, 269.99, 299.99)
ORDER BY list_price
GO

SELECT * FROM production.products
WHERE product_id  IN(SELECT product_id FROM sales.order_items)
ORDER BY list_price
GO

SELECT product_id FROM production.products
--WHERE product_id
ORDER BY product_id
GO


--				28-3-2023				28-3-2023				28-3-2023			28-3-2023

SELECT product_name, list_price FROM production.products

--OFFSET BỎ QUA 20 BẢN GHI ĐẦU TIÊN
SELECT product_name, list_price FROM production.products
ORDER BY list_price, product_name OFFSET 20 ROWS
GO

--OFFSET BỎ QUA 20 BẢN GHI ĐẦU TIÊN, LẤY 20 BẢN GHI TIẾP THEO 
SELECT product_name, list_price FROM production.products
ORDER BY list_price, product_name OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY
GO

--OFFSET TÌM KIẾM 20 SP GIÁ RẺ NHẤT
SELECT product_name, list_price FROM production.products
ORDER BY list_price, product_name OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY
GO

--OFFSET TÌM KIẾM 20 SP GIÁ ĐẮT NHẤT
SELECT product_name, list_price FROM production.products
ORDER BY list_price DESC, product_name OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY
GO

--STORE PROCEDURE: NHÓM CÁC LỆNH T-SQL, DÙNG LẠI, TĂNG BẢO MẬT
--tăng hiệu suất ( lưu thao tác trong bộ nhớ ĐỆM /buffer -> Lần truy cập tiếp theo sẽ được đọc từ vùng nhớ ĐỆM)
CREATE PROCEDURE Find20MostExpensiveProduct
AS BEGIN
	SELECT product_name, list_price FROM production.products
	ORDER BY list_price DESC, product_name OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY
END
GO
--EXECUTE
EXEC Find20MostExpensiveProduct
GO

--ALTER PROCEDURE
ALTER PROCEDURE Find20MostExpensiveProduct
AS BEGIN
	SELECT product_name, list_price FROM production.products
	ORDER BY list_price DESC, product_name OFFSET 10 ROWS FETCH NEXT 20 ROWS ONLY
END
GO
--EXCEUTE
EXEC Find20MostExpensiveProduct
GO

--DROP PROCEDURE
DROP PROC Find20MostExpensiveProduct
GO

--PROCEDURE WITH PARAMETER --GIÁ TRỊ MẶC ĐỊNH CỦA PARAMETER, GIÚP CHÚNG TA "BỎ QUA"
ALTER PROCEDURE Find20MostExpensiveProduct (@price AS DECIMAL = NULL, @name AS VARCHAR(50))
AS BEGIN
	SELECT product_name, list_price FROM production.products
	WHERE (list_price IS NULL OR list_price >= @price) or product_name like @name
	ORDER BY list_price ASC, product_name
END
GO
--EXCEUTE
EXEC Find20MostExpensiveProduct  @name = '%ek%'
GO

--GET ORDER BY STATUS
SELECT * FROM sales.orders

CREATE PROC GetOrderByStatus @status integer
AS BEGIN
	SELECT * FROM sales.orders
	WHERE order_status = @status
END
GO

EXEC GetOrderByStatus @status = 1
GO

--KHAI BÁO BIẾN TRONG STORE PROCEDURE CÓ THỂ LƯU SP TRONG BIẾN 
DECLARE @var_name int;
--phải chạy khai báo và gọi tên biến trong cùng 1 thời điểm
DECLARE @var1 AS INT, @var2 AS VARCHAR(50);
SET @var1 = 20;

SELECT * FROM production.products WHERE list_price >= @var1

--LƯU KẾT QUẢ TRUY VẤN TRONG CÁC BIẾN
DECLARE @productCount int;
SET @productCount = (
		SELECT COUNT(*) FROM production.products);
SELECT @productCount

--TRIGGER: LÀ MỘT DẠNG STORE PROCEDURE 
--ĐẢM BẢO VALIDATE CỦA THAO TÁC:
-- 1. TRIGGER-DML : INSERT, UPDATE, DELETE
-- 2. TRIGGER-DDL : CREATE, ALTER, DROP
-- Inserted: insert, update
-- Deleted: delete
