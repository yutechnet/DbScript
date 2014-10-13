--part of the script is from http://technet.microsoft.com/en-us/library/ms186243(v=sql.105).aspx

-- Create an Employee table, can change it to temp table to avoid permanent tables
CREATE TABLE dbo.MyEmployees
(
	EmployeeID smallint NOT NULL,
	FirstName nvarchar(30)  NOT NULL,
	LastName  nvarchar(40) NOT NULL,
	Title nvarchar(50) NOT NULL,
	DeptID smallint NOT NULL,
	ManagerID int NULL,
 CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC) 
);
-- Populate the table with values.
INSERT INTO dbo.MyEmployees VALUES 
 (1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273)
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274)
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285)
,(16,  N'David',N'Bradley', N'Marketing Manager', 4, 273)
,(23,  N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);

select * from dbo.MyEmployees;

--the script below shows direct reports (level=1) and indirect reports (level>1)
With ReportTo (EmployeeId, ManagerId, level)
AS 
(
	select EmployeeId, ManagerId, 1 as level
	from dbo.MyEmployees M
	--where M.ManagerID is null
	union all
	select M.EmployeeId, R.ManagerId, level + 1
	from MyEmployees M 
	inner join ReportTo R
		on M.ManagerId = R.EmployeeId
)
select ManagerId, EmployeeId, level
from ReportTo
where managerid =273
order by  Managerid, level;
