-- CREATE DATABASE
CREATE DATABASE TestDb

-- DROP DATABASE
drop database if exists TestDb

--STORE PROCEDURE SYSTEM
exec sp_databases

--SCHEMAL: phân vùng dữ liệu và gán quyền truy cập.
USE TestDb
go

CREATE schema customer_services
go

CREATE schema production
go

--CREATE TABLE
CREATE TABLE customer_services.customer(
	CID int primary key identity(1,1),
	[name] nvarchar(200),
	create_at date,
)

CREATE TABLE production.product(
	PID int primary key identity(100,10),
	pname nvarchar(255),
)