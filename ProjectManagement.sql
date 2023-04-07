DROP DATABASE IF EXISTS ProjectManagement
GO

CREATE DATABASE ProjectManagement
GO

USE ProjectManagement
GO

CREATE TABLE [PERSON] (
	Person_ID integer NOT NULL,
	LName varchar(25) NOT NULL,
	Project_ID varchar(15) NOT NULL,
	Dept_Name varchar(15) NOT NULL,
  CONSTRAINT [PK_PERSON] PRIMARY KEY CLUSTERED
  (
  [Person_ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [DEPARTMENT] (
	Dept_Name varchar(15) NOT NULL,
  CONSTRAINT [PK_DEPARTMENT] PRIMARY KEY CLUSTERED
  (
  [Dept_Name] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PROJECT] (
	Project_ID varchar(15) NOT NULL,
	Budget decimal NOT NULL,
	Dept_Name varchar(15) NOT NULL,
  CONSTRAINT [PK_PROJECT] PRIMARY KEY CLUSTERED
  (
  [Project_ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Works_On] (
	Person_ID integer NOT NULL,
	Project_ID varchar(15) NOT NULL,
	Working_Time date NOT NULL,
	Status varchar(25) NOT NULL)
GO
CREATE TABLE [Assigned_To] (
	Person_ID integer NOT NULL,
	Dept_Name varchar(15) NOT NULL,
	Roll varchar(25) NOT NULL)
GO
CREATE TABLE [Manages] (
	Dept_Name varchar(15) NOT NULL,
	Project_ID varchar(15) NOT NULL,
	Manage_Name varchar(25) NOT NULL,
	Working_Time date NOT NULL,
	Status varchar(15) NOT NULL)
GO

ALTER TABLE [Works_On] WITH CHECK ADD CONSTRAINT [Works_On_fk0] FOREIGN KEY ([Person_ID]) REFERENCES [PERSON]([Person_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [Works_On] CHECK CONSTRAINT [Works_On_fk0]
GO
ALTER TABLE [Works_On] WITH CHECK ADD CONSTRAINT [Works_On_fk1] FOREIGN KEY ([Project_ID]) REFERENCES [PROJECT]([Project_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [Works_On] CHECK CONSTRAINT [Works_On_fk1]
GO

ALTER TABLE [Assigned_To] WITH CHECK ADD CONSTRAINT [Assigned_To_fk0] FOREIGN KEY ([Person_ID]) REFERENCES [PERSON]([Person_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [Assigned_To] CHECK CONSTRAINT [Assigned_To_fk0]
GO
ALTER TABLE [Assigned_To] WITH CHECK ADD CONSTRAINT [Assigned_To_fk1] FOREIGN KEY ([Dept_Name]) REFERENCES [DEPARTMENT]([Dept_Name])
ON UPDATE CASCADE
GO
ALTER TABLE [Assigned_To] CHECK CONSTRAINT [Assigned_To_fk1]
GO

ALTER TABLE [Manages] WITH CHECK ADD CONSTRAINT [Manages_fk0] FOREIGN KEY ([Dept_Name]) REFERENCES [DEPARTMENT]([Dept_Name])
ON UPDATE CASCADE
GO
ALTER TABLE [Manages] CHECK CONSTRAINT [Manages_fk0]
GO
ALTER TABLE [Manages] WITH CHECK ADD CONSTRAINT [Manages_fk1] FOREIGN KEY ([Project_ID]) REFERENCES [PROJECT]([Project_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [Manages] CHECK CONSTRAINT [Manages_fk1]
GO