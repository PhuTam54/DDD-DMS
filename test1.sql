use FptAptechBikeStore
GO

SELECT * FROM sales.customers
GO

SELECT city, COUNT(city) as 'number of city'
FROM sales.customers
--WHERE phone is null
group by city
go

select AVG(list_price) AS 'AVERAGE PRICE' from sales.order_items
GO
select SUM(list_price) AS 'SUM PRICE' from sales.order_items
GO

create table student_2 (
	student_id varchar(25),
	first_name varchar(25),
	last_name varchar(25),
	date_of_birth date,
	year_enrolled int
);

CREATE TABLE student_3 AS
	SELECT student_id, first_name, last_name 
	FROM student_2;

DROP TABLE IF EXISTS Student

TRUNCATE TABLE student_2

ALTER TABLE student_2 
	ADD [address] varchar(50)

ALTER TABLE student_2 
	DROP COLUMN [address]

ALTER TABLE student_2 
	MODIFY COLUMN [address] INT

-- STUDENT 3

CREATE TABLE student_3 AS
	SELECT student_id, first_name, last_name 
	FROM student_2;

DROP TABLE IF EXISTS Student

TRUNCATE TABLE student_2

ALTER TABLE student_2 
	ADD [address] varchar(50)

ALTER TABLE student_2 
	DROP COLUMN [address]

ALTER TABLE student_2 
	MODIFY COLUMN [address] INT