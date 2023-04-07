Use StudentDemo
GO

CREATE TABLE [StudentInfo] (
	sid integer NOT NULL,
	sname varchar(50) NOT NULL,
	gpa decimal NOT NULL,
	major varchar(50) NOT NULL,
  CONSTRAINT [PK_STUDENTINFO] PRIMARY KEY CLUSTERED
  (
  [sid] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [CourseInfo] (
	cid integer NOT NULL,
	cname varchar(50) NOT NULL,
	fid integer NOT NULL,
  CONSTRAINT [PK_COURSEINFO] PRIMARY KEY CLUSTERED
  (
  [cid] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Facaulty] (
	fid integer NOT NULL,
	fname varchar(50) NOT NULL,
	fphone varchar(20) NOT NULL,
	salary decimal NOT NULL,
	joinDate date NOT NULL,
	dept varchar(10) NOT NULL,
  CONSTRAINT [PK_FACAULTY] PRIMARY KEY CLUSTERED
  (
  [fid] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [CourseGrade] (
	sid integer NOT NULL,
	cid integer NOT NULL,
	grade varchar(2) NOT NULL,
  CONSTRAINT [PK_COURSEGRADE] PRIMARY KEY CLUSTERED
  (
  [sid], [cid] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

ALTER TABLE [CourseInfo] WITH CHECK ADD CONSTRAINT [CourseInfo_fk0] FOREIGN KEY ([fid]) REFERENCES [Facaulty]([fid])
ON UPDATE CASCADE
GO
ALTER TABLE [CourseInfo] CHECK CONSTRAINT [CourseInfo_fk0]
GO


ALTER TABLE [CourseGrade] WITH CHECK ADD CONSTRAINT [CourseGrade_fk0] FOREIGN KEY ([sid]) REFERENCES [StudentInfo]([sid])
ON UPDATE CASCADE
GO
ALTER TABLE [CourseGrade] CHECK CONSTRAINT [CourseGrade_fk0]
GO
ALTER TABLE [CourseGrade] WITH CHECK ADD CONSTRAINT [CourseGrade_fk1] FOREIGN KEY ([cid]) REFERENCES [CourseInfo]([cid])
ON UPDATE CASCADE
GO
ALTER TABLE [CourseGrade] CHECK CONSTRAINT [CourseGrade_fk1]
GO
