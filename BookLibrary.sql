--CREATE DB
DROP DATABASE IF EXISTS BookLibrary
GO

create database BookLibrary
go

use BookLibrary
go

-- dbdesigner
CREATE TABLE [Book] (
	BookCode int NOT NULL identity(1,1),
	BookTitle varchar(100) NOT NULL,
	Author varchar(50) NOT NULL,
	Edition int NOT NULL,
	BookPrice money NOT NULL,
	Copies int NOT NULL,
  CONSTRAINT [PK_BOOK] PRIMARY KEY CLUSTERED
  (
  [BookCode] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Member] (
	MemberCode int NOT NULL,
	Name varchar(50) NOT NULL,
	Address varchar(100) NOT NULL,
	PhoneNumber int NOT NULL,
  CONSTRAINT [PK_MEMBER] PRIMARY KEY CLUSTERED
  (
  [MemberCode] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [IssueDetails] (
	BookCode int NOT NULL,
	MemberCode int NOT NULL,
	Issuedate datetime NOT NULL,
	ReturnTime datetime NOT NULL,
  CONSTRAINT [PK_ISSUEDETAILS] PRIMARY KEY CLUSTERED
  (
  [BookCode], [MemberCode] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO


ALTER TABLE [IssueDetails] WITH CHECK ADD CONSTRAINT [IssueDetails_fk0] FOREIGN KEY ([BookCode]) REFERENCES [Book]([BookCode])
ON UPDATE CASCADE
GO
ALTER TABLE [IssueDetails] CHECK CONSTRAINT [IssueDetails_fk0]
GO
ALTER TABLE [IssueDetails] WITH CHECK ADD CONSTRAINT [IssueDetails_fk1] FOREIGN KEY ([MemberCode]) REFERENCES [Member]([MemberCode])
ON UPDATE CASCADE
GO
ALTER TABLE [IssueDetails] CHECK CONSTRAINT [IssueDetails_fk1]
GO

-- ALTER TABLE
INSERT INTO Book VALUES 
('Dac nhan tam', 'Tran Thuy', 02, 999999, 10000 ),
('Dac nhan tam', 'PT', 03, 999999, 40000 ),
('Dac nhan tam', 'Tran Thuy', 02, 999999, 20000 ),
('Dac nhan tam', 'PT', 03, 999999, 50000 )
GO
INSERT INTO Book VALUES 
('Dac nhan tam', 'Tran Thuy', 05, 199, 100000 )
GO

-- Insert Into
INSERT INTO Member VALUES 
(3, 'Nguyen Phu Tam', 'Bac Ninh', 0865630471),
(4, 'Tran Thi Thuy', 'Ha Noi', 0344288541)
GO

INSERT INTO IssueDetails VALUES
(3, 4, 2023-28-2, 1-3-2023),
(4, 3, 2023-28-2, 1-3-2023)
GO

UPDATE Book
SET Author='Phu Tam'
WHERE Edition = 3

UPDATE Book
SET Edition = 3
WHERE BookCode= 3

UPDATE Book
SET BookPrice= 199

--XOA BO RANG BUOC FK
ALTER TABLE IssueDetails
DROP CONSTRAINT [IssueDetails_fk0], [IssueDetails_fk1]
GO

--XOA BO RANG BUOC PK
ALTER TABLE Member
DROP CONSTRAINT PK_MEMBER
GO

ALTER TABLE Book
DROP CONSTRAINT PK_BOOK
GO

--THEM MOI RANG BUOC PK
ALTER TABLE Member
ADD CONSTRAINT PK_MEMBER PRIMARY KEY (MemberCode)
GO

ALTER TABLE Book
ADD CONSTRAINT PK_BOOK PRIMARY KEY (BookCode)
GO

--THEM MOI RANG BUOC FK
ALTER TABLE IssueDetails
ADD CONSTRAINT FK_IssueDetails1 FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
ON UPDATE CASCADE
GO

ALTER TABLE IssueDetails
ADD CONSTRAINT FK_IssueDetails2 FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode)
ON UPDATE CASCADE
GO

--BO SUNG RANG BUOC GIA BAN SACH > 0 VA <200
ALTER TABLE Book
ADD CONSTRAINT CHK_Book CHECK (BookPrice>0 AND BookPrice<200)
GO

--MAX MIN
select * from Book where Edition=(SELECT max(Edition)
FROM Book
WHERE Author = 'Phu Tam')

SELECT min(Edition), max(Edition)
FROM Book
WHERE Author = 'Phu Tam'

--RESULT
SELECT * FROM Book
GO
SELECT * FROM Member
GO
SELECT * FROM IssueDetails
GO

