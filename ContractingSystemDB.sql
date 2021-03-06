USE [master]
GO
/****** Object:  Database [ContractingSystem]    Script Date: 17/08/2014 05:57:21 م ******/
CREATE DATABASE [ContractingSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ContractingSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ContractingSystem.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ContractingSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ContractingSystem_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ContractingSystem] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ContractingSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ContractingSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ContractingSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ContractingSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ContractingSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ContractingSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [ContractingSystem] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ContractingSystem] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ContractingSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ContractingSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ContractingSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ContractingSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ContractingSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ContractingSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ContractingSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ContractingSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ContractingSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ContractingSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ContractingSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ContractingSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ContractingSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ContractingSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ContractingSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ContractingSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ContractingSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ContractingSystem] SET  MULTI_USER 
GO
ALTER DATABASE [ContractingSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ContractingSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ContractingSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ContractingSystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ContractingSystem]
GO
/****** Object:  User [NT AUTHORITY\NETWORK SERVICE]    Script Date: 17/08/2014 05:57:21 م ******/
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
/****** Object:  StoredProcedure [dbo].[CompanyExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CompanyExtract] 
@ExractOrder int , @ProjectID int 
AS
BEGIN
SELECT        
dbo.Tbl_CompanyExract.PK_ID AS CompanyExractID, 
dbo.Tbl_Project.Name AS ProjectName, 
dbo.Tbl_CompanyExract.ExractOrder, 
dbo.Tbl_CompanyExract.FK_ProjectID, 
dbo.Tbl_CompanyExract.ExtractTotalPrice, 
dbo.Tbl_CompanyExract.LastPaid, 
dbo.Tbl_CompanyExract.Deductions, 
dbo.Tbl_CompanyExract.BusinessGuarantee, 
dbo.Tbl_CompanyExract.NetDue, 
dbo.Tbl_CompanyExract.Supervisor, 
dbo.Tbl_CompanyExract.DateFrom, 
dbo.Tbl_CompanyExract.DateTo, 
dbo.Tbl_CompanyExractItems.PK_ID as CompanyExractItemID, 
dbo.Tbl_CompanyExractItems.EstimationName, 
dbo.Tbl_CompanyExractItems.EstimationQTY, 
dbo.Tbl_CompanyExractItems.ProjectEstimationID, 
dbo.Tbl_CompanyExractItems.Price, 
dbo.Tbl_CompanyExractItems.Unit, 
dbo.Tbl_CompanyExractItems.LastExecutedQTY, 
dbo.Tbl_CompanyExractItems.CurrentExecutedQTY, 
dbo.Tbl_CompanyExractItems.TotalExecutedQTY, 
dbo.Tbl_CompanyExractItems.TotalPrice
FROM            
dbo.Tbl_CompanyExract 
INNER JOIN dbo.Tbl_CompanyExractItems ON dbo.Tbl_CompanyExract.PK_ID = dbo.Tbl_CompanyExractItems.FK_CompanyExractID
INNER JOIN dbo.Tbl_Project ON dbo.Tbl_Project.PK_ID = dbo.Tbl_CompanyExract.FK_ProjectID
where dbo.Tbl_CompanyExract.ExractOrder = @ExractOrder and dbo.Tbl_CompanyExract.FK_ProjectID = @ProjectID
END





GO
/****** Object:  StoredProcedure [dbo].[DailyWorkerExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DailyWorkerExtract] 
@ExractOrder int , @ProjectID int, @WorkerId int
AS
BEGIN

SELECT        
dbo.Tbl_Project.Name as ProjectName, 
dbo.Tbl_DailyWorkerExtract.FK_ProjectID, 
dbo.Tbl_DailyWorkerExtract.ExractOrder, 
dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, 
dbo.Tbl_DailyWorkerExtract.LastPaid, 
dbo.Tbl_DailyWorkerExtract.Deductions, 
dbo.Tbl_DailyWorkerExtract.WorkerId, 
dbo.Tbl_DailyWorkerExtract.WorkerName, 
dbo.Tbl_DailyWorkerExtract.NetDue, 
dbo.Tbl_DailyWorkerExtract.DateFrom, 
dbo.Tbl_DailyWorkerExtract.DateTo, 
'فتره ' + CONVERT(nvarchar,ExractOrder) as WorkDurationName,
SUM(dbo.Tbl_DailyWorkerExtractItems.Price) AS Price, 
SUM(dbo.Tbl_DailyWorkerExtractItems.ExchangeRatio) AS ExchangeRatio, 
SUM(dbo.Tbl_DailyWorkerExtractItems.TotalDays) AS TotalDays, 
SUM(dbo.Tbl_DailyWorkerExtractItems.DeductionsDays) AS DeductionsDays, 
SUM(dbo.Tbl_DailyWorkerExtractItems.NetDays) AS NetDays, 
SUM(dbo.Tbl_DailyWorkerExtractItems.TotalPrice) AS TotalPrice, 
dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
FROM            
dbo.Tbl_Project 
INNER JOIN dbo.Tbl_DailyWorkerExtract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_DailyWorkerExtract.FK_ProjectID 
INNER JOIN dbo.Tbl_DailyWorkerExtractItems ON dbo.Tbl_DailyWorkerExtract.PK_ID = dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
where ExractOrder < @ExractOrder and FK_ProjectID = @ProjectID and WorkerId = @WorkerId
GROUP BY 
dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID, 
dbo.Tbl_Project.Name, 
dbo.Tbl_DailyWorkerExtract.FK_ProjectID, 
dbo.Tbl_DailyWorkerExtract.ExractOrder, 
dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, 
dbo.Tbl_DailyWorkerExtract.LastPaid, 
dbo.Tbl_DailyWorkerExtract.Deductions, 
dbo.Tbl_DailyWorkerExtract.WorkerId, 
dbo.Tbl_DailyWorkerExtract.WorkerName, 
dbo.Tbl_DailyWorkerExtract.NetDue, 
dbo.Tbl_DailyWorkerExtract.DateFrom, 
dbo.Tbl_DailyWorkerExtract.DateTo, 
WorkDurationName
UNION ALL
SELECT        
dbo.Tbl_Project.Name as ProjectName, 
dbo.Tbl_DailyWorkerExtract.FK_ProjectID, 
dbo.Tbl_DailyWorkerExtract.ExractOrder, 
dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, 
dbo.Tbl_DailyWorkerExtract.LastPaid, 
dbo.Tbl_DailyWorkerExtract.Deductions, 
dbo.Tbl_DailyWorkerExtract.WorkerId, 
dbo.Tbl_DailyWorkerExtract.WorkerName, 
dbo.Tbl_DailyWorkerExtract.NetDue, 
dbo.Tbl_DailyWorkerExtract.DateFrom, 
dbo.Tbl_DailyWorkerExtract.DateTo, 
dbo.Tbl_DailyWorkerExtractItems.WorkDurationName,
dbo.Tbl_DailyWorkerExtractItems.Price, 
dbo.Tbl_DailyWorkerExtractItems.ExchangeRatio, 
dbo.Tbl_DailyWorkerExtractItems.TotalDays, 
dbo.Tbl_DailyWorkerExtractItems.DeductionsDays, 
dbo.Tbl_DailyWorkerExtractItems.NetDays, 
dbo.Tbl_DailyWorkerExtractItems.TotalPrice, 
dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
FROM            
dbo.Tbl_Project 
INNER JOIN dbo.Tbl_DailyWorkerExtract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_DailyWorkerExtract.FK_ProjectID 
INNER JOIN dbo.Tbl_DailyWorkerExtractItems ON dbo.Tbl_DailyWorkerExtract.PK_ID = dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
where ExractOrder = @ExractOrder and FK_ProjectID = @ProjectID and WorkerId = @WorkerId
END


GO
/****** Object:  StoredProcedure [dbo].[DailyWorkerLastExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DailyWorkerLastExtract] 
@ExractOrder int , @ProjectID int, @WorkerId int
AS
BEGIN
SELECT        
dbo.Tbl_Project.Name, 
dbo.Tbl_DailyWorkerExtract.FK_ProjectID, 
dbo.Tbl_DailyWorkerExtract.ExractOrder, 
dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, 
dbo.Tbl_DailyWorkerExtract.LastPaid, 
dbo.Tbl_DailyWorkerExtract.Deductions, 
dbo.Tbl_DailyWorkerExtract.WorkerId, 
dbo.Tbl_DailyWorkerExtract.WorkerName, 
SUM(dbo.Tbl_DailyWorkerExtractItems.Price) AS Price, 
SUM(dbo.Tbl_DailyWorkerExtractItems.ExchangeRatio) AS ExchangeRatio, 
SUM(dbo.Tbl_DailyWorkerExtractItems.TotalDays) AS TotalDays, 
SUM(dbo.Tbl_DailyWorkerExtractItems.DeductionsDays) AS DeductionsDays, 
SUM(dbo.Tbl_DailyWorkerExtractItems.NetDays) AS NetDays, 
SUM(dbo.Tbl_DailyWorkerExtractItems.TotalPrice) AS TotalPrice, 
dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
FROM            
dbo.Tbl_Project 
INNER JOIN dbo.Tbl_DailyWorkerExtract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_DailyWorkerExtract.FK_ProjectID 
INNER JOIN dbo.Tbl_DailyWorkerExtractItems ON dbo.Tbl_DailyWorkerExtract.PK_ID = dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
where ExractOrder < @ExractOrder and FK_ProjectID = @ProjectID and WorkerId = @WorkerId
GROUP BY 
dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID, 
dbo.Tbl_Project.Name, 
dbo.Tbl_DailyWorkerExtract.FK_ProjectID, 
dbo.Tbl_DailyWorkerExtract.ExractOrder, 
dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, 
dbo.Tbl_DailyWorkerExtract.LastPaid, 
dbo.Tbl_DailyWorkerExtract.Deductions, 
dbo.Tbl_DailyWorkerExtract.WorkerId, 
dbo.Tbl_DailyWorkerExtract.WorkerName
END


GO
/****** Object:  StoredProcedure [dbo].[SubContractorExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SubContractorExtract] 
@ExractOrder int , @ProjectID int, @SubContractorId int
AS
BEGIN
SELECT        
dbo.Tbl_SubContractorExtract.PK_ID as SubContractorExtractD,
dbo.Tbl_Project.Name AS ProjectName,  
dbo.Tbl_SubContractorExtract.FK_ProjectID, dbo.Tbl_SubContractorExtract.ExractOrder, 
                         dbo.Tbl_SubContractorExtract.ExtractTotalPrice, dbo.Tbl_SubContractorExtract.LastPaid, dbo.Tbl_SubContractorExtract.BusinessGuarantee, 
                         dbo.Tbl_SubContractorExtract.Deductions, dbo.Tbl_SubContractorExtract.SubContractorId, dbo.Tbl_SubContractorExtract.SubContractorName, 
                         dbo.Tbl_SubContractorExtract.NetDue, dbo.Tbl_SubContractorExtract.DateFrom, dbo.Tbl_SubContractorExtract.DateTo, 
                         dbo.Tbl_SubContractorExtractItems.PK_ID AS SubContractorExtractItemsID, dbo.Tbl_SubContractorExtractItems.WorkName, dbo.Tbl_SubContractorExtractItems.WorkNameID, 
                         dbo.Tbl_SubContractorExtractItems.Price, dbo.Tbl_SubContractorExtractItems.ExchangeRatio, dbo.Tbl_SubContractorExtractItems.LastExecutedQTY, 
                         dbo.Tbl_SubContractorExtractItems.CurrentExecutedQTY, dbo.Tbl_SubContractorExtractItems.TotalExecutedQTY, dbo.Tbl_SubContractorExtractItems.TotalPrice, 
                         dbo.Tbl_SubContractorExtractItems.FK_SubContractorExractID
FROM            dbo.Tbl_SubContractorExtract INNER JOIN
                         dbo.Tbl_SubContractorExtractItems ON dbo.Tbl_SubContractorExtract.PK_ID = dbo.Tbl_SubContractorExtractItems.FK_SubContractorExractID
INNER JOIN dbo.Tbl_Project ON dbo.Tbl_Project.PK_ID = dbo.Tbl_SubContractorExtract.FK_ProjectID
where dbo.Tbl_SubContractorExtract.ExractOrder = @ExractOrder and dbo.Tbl_SubContractorExtract.FK_ProjectID = @ProjectID and dbo.Tbl_SubContractorExtract.SubContractorId = @SubContractorId
END





GO
/****** Object:  StoredProcedure [dbo].[SupplierExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SupplierExtract] 
@ExractOrder int , @ProjectID int, @SupplierID int
AS
BEGIN
SELECT        
dbo.Tbl_SupplierExtractItems.PK_ID as SupplierExtractItemsID,
dbo.Tbl_Project.Name AS ProjectName,  dbo.Tbl_SupplierExtractItems.SupplyName, dbo.Tbl_SupplierExtractItems.SupplyNameID, dbo.Tbl_SupplierExtractItems.Price, 
                         dbo.Tbl_SupplierExtractItems.ExchangeRatio, dbo.Tbl_SupplierExtractItems.LastExecutedQTY, dbo.Tbl_SupplierExtractItems.CurrentExecutedQTY, 
                         dbo.Tbl_SupplierExtractItems.TotalExecutedQTY, dbo.Tbl_SupplierExtractItems.TotalPrice, dbo.Tbl_SupplierExtractItems.FK_SupplierExractID, 
                         dbo.Tbl_SupplierExtract.PK_ID AS SupplierExtractID, dbo.Tbl_SupplierExtract.FK_ProjectID, dbo.Tbl_SupplierExtract.ExractOrder, dbo.Tbl_SupplierExtract.ExtractTotalPrice, 
                         dbo.Tbl_SupplierExtract.LastPaid, dbo.Tbl_SupplierExtract.Deductions, dbo.Tbl_SupplierExtract.BusinessGuarantee, dbo.Tbl_SupplierExtract.SupplierId, 
                         dbo.Tbl_SupplierExtract.SupplierName, dbo.Tbl_SupplierExtract.NetDue, dbo.Tbl_SupplierExtract.DateFrom, dbo.Tbl_SupplierExtract.DateTo
FROM            dbo.Tbl_SupplierExtract 
INNER JOIN dbo.Tbl_SupplierExtractItems ON dbo.Tbl_SupplierExtract.PK_ID = dbo.Tbl_SupplierExtractItems.FK_SupplierExractID
INNER JOIN dbo.Tbl_Project ON dbo.Tbl_Project.PK_ID = dbo.Tbl_SupplierExtract.FK_ProjectID
where dbo.Tbl_SupplierExtract.ExractOrder = @ExractOrder and dbo.Tbl_SupplierExtract.FK_ProjectID = @ProjectID and Tbl_SupplierExtract.SupplierId = @SupplierID
END





GO
/****** Object:  UserDefinedFunction [dbo].[GetPersonName]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPersonName]
(
	@PersonID int,
	@PersonTypeID int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(MAX)

	-- Add the T-SQL statements to compute the return value here
	--Subcontractor = -4, Supplier = -3, Daily Worker = -2
	if ( @PersonTypeID = -4) SELECT @Result = (select Name from Tbl_Subcontractor where PK_ID = @PersonID);
	if ( @PersonTypeID = -3) SELECT @Result = (select Name from Tbl_Supplier where PK_ID = @PersonID);
	if ( @PersonTypeID = -2) SELECT @Result = (select Name from Tbl_DailyWorker where PK_ID = @PersonID);
	-- Return the result of the function
	RETURN @Result

END




GO
/****** Object:  UserDefinedFunction [dbo].[GetWorkTypeName]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetWorkTypeName]
(
	@PersonID int,
	@PersonTypeID int,
	@WorkTypeId int
)
RETURNS nvarchar(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(MAX)

	-- Add the T-SQL statements to compute the return value here
	--Subcontractor = -4, Supplier = -3, Daily Worker = -2
	if ( @PersonTypeID = -4) SELECT @Result = (select top(1) View_ProjectContractor.FullWorkName from View_ProjectContractor where View_ProjectContractor.FK_WorkID = @WorkTypeId);
	if ( @PersonTypeID = -3) SELECT @Result = (select top(1) View_ProjectSuppliers.FullItemName from View_ProjectSuppliers where View_ProjectSuppliers.ItemID = @WorkTypeId);
	if ( @PersonTypeID = -2) SELECT @Result = null;
	-- Return the result of the function
	RETURN @Result

END




GO
/****** Object:  Table [dbo].[Tbl_Category]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Category](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
 CONSTRAINT [PK_Tbl_Category] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_CompanyExract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_CompanyExract](
	[PK_ID] [int] NOT NULL,
	[ExractOrder] [int] NULL,
	[FK_ProjectID] [int] NULL,
	[ExtractTotalPrice] [money] NULL,
	[LastPaid] [money] NULL,
	[Deductions] [money] NULL,
	[BusinessGuarantee] [money] NULL,
	[NetDue] [money] NULL,
	[Supervisor] [nvarchar](max) NULL,
	[DateFrom] [smalldatetime] NULL,
	[DateTo] [smalldatetime] NULL,
 CONSTRAINT [PK_Tbl_CompanyExract] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_CompanyExractItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_CompanyExractItems](
	[PK_ID] [int] NOT NULL,
	[EstimationName] [nvarchar](max) NULL,
	[EstimationQTY] [nvarchar](max) NULL,
	[ProjectEstimationID] [int] NULL,
	[Price] [money] NULL,
	[Unit] [int] NULL,
	[LastExitExecutedQTY] [int] NULL,
	[LastExecutedQTY] [int] NULL,
	[CurrentExecutedQTY] [int] NULL,
	[TotalExecutedQTY] [int] NULL,
	[TotalPrice] [money] NULL,
	[FK_CompanyExractID] [int] NULL,
 CONSTRAINT [PK_Tbl_CompanyExractItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_DailyWorker]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_DailyWorker](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Mobile] [nchar](20) NULL,
	[WorkerID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_DailyWorker] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_DailyWorkerExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_DailyWorkerExtract](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectID] [int] NULL,
	[ExractOrder] [int] NULL,
	[ExtractTotalPrice] [money] NULL,
	[LastPaid] [money] NULL,
	[Deductions] [money] NULL,
	[NetDue] [money] NULL,
	[WorkerId] [int] NULL,
	[WorkerName] [nvarchar](max) NULL,
	[DateFrom] [smalldatetime] NULL,
	[DateTo] [smalldatetime] NULL,
 CONSTRAINT [PK_Tbl_DailyWorkerExtract] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_DailyWorkerExtractItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_DailyWorkerExtractItems](
	[PK_ID] [int] NOT NULL,
	[WorkDurationName] [nvarchar](max) NULL,
	[Price] [money] NULL,
	[ExchangeRatio] [int] NULL,
	[TotalDays] [int] NULL,
	[DeductionsDays] [int] NULL,
	[NetDays] [int] NULL,
	[TotalPrice] [money] NULL,
	[FK_DailyWorkerExractID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_DailyWorkerTime]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_DailyWorkerTime](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectDailyWorker] [int] NULL,
	[WorkStartDate] [smalldatetime] NULL,
	[WorkEndDate] [smalldatetime] NULL,
	[WorkWageDay] [float] NULL,
 CONSTRAINT [PK_Tbl_DailyWorkerTime] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Employees]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Employees](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Mobile] [nvarchar](max) NULL,
	[ID] [nvarchar](max) NULL,
	[Salary] [money] NULL,
	[JobName] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[FK_RoleID] [int] NULL,
 CONSTRAINT [PK_Tbl_Employees] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_EquationItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_EquationItems](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[FK_EstimationItemEquationID] [int] NULL,
	[FK_ItemID] [int] NULL,
	[ItemBY] [float] NULL,
	[ItemDevid] [float] NULL,
 CONSTRAINT [PK_Tbl_EquationItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_EstimationItemEquations]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_EstimationItemEquations](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[EquationName] [nvarchar](max) NULL,
	[FK_EstimationItemID] [int] NULL,
	[HasEquationItems] [bit] NULL,
 CONSTRAINT [PK_Tbl_EstimationItemEquations] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_EstimationItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_EstimationItems](
	[PK_ID] [int] NOT NULL,
	[BusinessStatement] [nvarchar](max) NULL,
	[Unit] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_EstimationItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ExpensesCategories]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ExpensesCategories](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_ExpensesCategories] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ExpensesItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ExpensesItems](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[FK_ExpenseCategory] [int] NULL,
 CONSTRAINT [PK_Tbl_ExpensesItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_GuardianshipItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_GuardianshipItems](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectGuardianshipID] [int] NULL,
	[Amount] [money] NULL,
	[FK_ExpenseItemID] [int] NULL,
	[PersonID] [int] NULL,
	[PersonTypeID] [int] NULL,
	[Date] [smalldatetime] NULL,
	[WorkTypeId] [int] NULL,
 CONSTRAINT [PK_Tbl_GuardianshipItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Items]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Items](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[FK_CategoryID] [int] NULL,
	[ItemType] [nvarchar](max) NULL,
	[FK_MeasurementUnitID] [int] NULL,
 CONSTRAINT [PK_Tbl_Items] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_MeasurementUnit]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_MeasurementUnit](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[Unit] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_MeasurementUnit] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Pages]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Pages](
	[PK_ID] [int] NOT NULL,
	[PageName] [nvarchar](max) NULL,
	[ArabicName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_Pages] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Project]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Project](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Supervisor] [nvarchar](max) NULL,
	[ProjectPeriodPerMonth] [int] NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[DateOfReceiptOfTheSite] [smalldatetime] NULL,
	[TechnicalOpenDate] [smalldatetime] NULL,
	[ProjectCost] [money] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Tbl_Project] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectDailyWorker]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectDailyWorker](
	[PK_ID] [int] NOT NULL,
	[FK_DailyWorker_ID] [int] NULL,
	[FK_Project_ID] [int] NULL,
 CONSTRAINT [PK_Tbl_ProjectDailyWorker] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectEmployees]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectEmployees](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectID] [int] NULL,
	[FK_EmployeeID] [int] NULL,
 CONSTRAINT [PK_Tbl_ProjectEmployees] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectEstimation]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectEstimation](
	[PK_ID] [int] NOT NULL,
	[Price] [money] NULL,
	[Quantity] [int] NULL,
	[Notes] [nvarchar](max) NULL,
	[FK_ProjectID] [int] NULL,
	[FK_EstimationItemsID] [int] NULL,
 CONSTRAINT [PK_Tbl_ProjectEstimation] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectGuardianship]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectGuardianship](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectID] [int] NULL,
	[FK_EmployeeID] [int] NULL,
	[Date] [smalldatetime] NULL,
	[DateFrom] [smalldatetime] NULL,
	[DateTo] [smalldatetime] NULL,
	[Amount] [money] NULL,
	[FK_SaverID] [int] NULL,
	[Rest] [money] NULL,
	[Surplus] [money] NULL,
 CONSTRAINT [PK_Tbl_ProjectGuardianship] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectSaverDeposits]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectSaverDeposits](
	[PK_ID] [int] NOT NULL,
	[FK_SaverItemID] [int] NULL,
	[Date] [smalldatetime] NULL,
	[FK_ProjectID] [int] NULL,
	[Amount] [money] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_ProjectSaverDeposits] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectSubContractor]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectSubContractor](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectID] [int] NULL,
	[FK_SubContractorWorkID] [int] NULL,
 CONSTRAINT [PK_Tbl_ProjectSubContractor] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_ProjectSupplies]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProjectSupplies](
	[PK_ID] [int] NOT NULL,
	[FK_ItemsID] [int] NULL,
	[QTY] [decimal](18, 0) NULL,
	[FK_ProjectEstimationItemID] [int] NULL,
	[FK_ProjectID] [int] NULL,
	[WasSupplied] [bit] NULL,
	[Rest] [int] NULL,
 CONSTRAINT [PK_Tbl_ProjectSupplies] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_RolePermissions]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_RolePermissions](
	[PK_ID] [int] NOT NULL,
	[FK_RoleID] [int] NULL,
	[FK_PageID] [int] NULL,
	[Access] [bit] NULL,
 CONSTRAINT [PK_Tbl_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Roles]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Roles](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_Roles] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SaverAmountActions]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SaverAmountActions](
	[PK_ID] [int] NOT NULL,
	[FK_SaverItemID] [int] NULL,
	[FK_SaverID] [int] NULL,
	[Date] [smalldatetime] NULL,
	[ActionType] [bit] NULL,
	[Amount] [money] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_ProjectAmountActions] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SaverCategory]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SaverCategory](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_SaverCategory] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SaverItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SaverItems](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[FK_SaverCategory] [int] NULL,
 CONSTRAINT [PK_Tbl_ProjectSaverItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Savers]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Savers](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Amount] [money] NULL,
 CONSTRAINT [PK_Tbl_Savers] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Subcontractor]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Subcontractor](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Mobile] [nchar](15) NULL,
	[LandLine] [nchar](15) NULL,
	[Address] [nvarchar](100) NULL,
	[FK_WorkTypeID] [int] NULL,
 CONSTRAINT [PK_Tbl_Subcontractor] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SubContractorExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SubContractorExtract](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectID] [int] NULL,
	[ExractOrder] [int] NULL,
	[ExtractTotalPrice] [money] NULL,
	[LastPaid] [money] NULL,
	[Deductions] [money] NULL,
	[BusinessGuarantee] [money] NULL,
	[SubContractorId] [int] NULL,
	[SubContractorName] [nvarchar](max) NULL,
	[NetDue] [money] NULL,
	[DateFrom] [smalldatetime] NULL,
	[DateTo] [smalldatetime] NULL,
 CONSTRAINT [PK_Tbl_SubContractorExract] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SubContractorExtractItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SubContractorExtractItems](
	[PK_ID] [int] NOT NULL,
	[WorkName] [nvarchar](max) NULL,
	[WorkNameID] [int] NULL,
	[Price] [money] NULL,
	[ExchangeRatio] [float] NULL,
	[LastExitExecutedQTY] [int] NULL,
	[LastExecutedQTY] [int] NULL,
	[CurrentExecutedQTY] [int] NULL,
	[TotalExecutedQTY] [int] NULL,
	[TotalPrice] [money] NULL,
	[FK_SubContractorExractID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SubContractorWorks]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SubContractorWorks](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[FK_WorkID] [int] NULL,
	[FK_SubContractorID] [int] NULL,
 CONSTRAINT [PK_Tbl_SubContractorWorks] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Supplier]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Supplier](
	[PK_ID] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Mobile] [nchar](15) NULL,
	[LandLine] [nchar](15) NULL,
	[Address] [nvarchar](100) NULL,
 CONSTRAINT [PK_Tbl_Supplier] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SupplierExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SupplierExtract](
	[PK_ID] [int] NOT NULL,
	[FK_ProjectID] [int] NULL,
	[ExractOrder] [int] NULL,
	[ExtractTotalPrice] [money] NULL,
	[LastPaid] [money] NULL,
	[Deductions] [money] NULL,
	[BusinessGuarantee] [money] NULL,
	[SupplierId] [int] NULL,
	[SupplierName] [nvarchar](max) NULL,
	[NetDue] [money] NULL,
	[DateFrom] [smalldatetime] NULL,
	[DateTo] [smalldatetime] NULL,
 CONSTRAINT [PK_Tbl_SupplierExtract] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SupplierExtractItems]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SupplierExtractItems](
	[PK_ID] [int] NOT NULL,
	[SupplyName] [nvarchar](max) NULL,
	[SupplyNameID] [int] NULL,
	[Price] [money] NULL,
	[ExchangeRatio] [int] NULL,
	[LastExitExecutedQTY] [int] NULL,
	[LastExecutedQTY] [int] NULL,
	[CurrentExecutedQTY] [int] NULL,
	[TotalExecutedQTY] [int] NULL,
	[TotalPrice] [money] NULL,
	[FK_SupplierExractID] [int] NULL,
 CONSTRAINT [PK_Tbl_SupplierExtractItems] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SupplierSupplies]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SupplierSupplies](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[FK_CategoryID] [int] NULL,
	[FK_SupplierID] [int] NULL,
 CONSTRAINT [PK_Tbl_SupplierSupplies] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_SuppliesEvent]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_SuppliesEvent](
	[PK_ID] [bigint] NOT NULL,
	[FK_ProjectSuppliesID] [int] NULL,
	[UnitPrice] [money] NULL,
	[QTY] [decimal](18, 0) NULL,
	[TotalPrice] [money] NULL,
	[FK_SupplierID] [int] NULL,
	[SuppliesDate] [smalldatetime] NULL,
	[ReceiptNO] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tbl_SuppliesEvent] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_WorkCategories]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_WorkCategories](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_WorkCategories] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_WorkType]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_WorkType](
	[PK_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[FK_WorkCategory] [int] NULL,
 CONSTRAINT [PK_Tbl_WorkType] PRIMARY KEY CLUSTERED 
(
	[PK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_AddedStimation]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_AddedStimation]
AS
SELECT        dbo.Tbl_ProjectEstimation.PK_ID, dbo.Tbl_EstimationItems.BusinessStatement AS Name, dbo.Tbl_ProjectEstimation.FK_ProjectID, 
                         dbo.Tbl_ProjectEstimation.Quantity, dbo.Tbl_EstimationItemEquations.HasEquationItems, dbo.Tbl_EstimationItemEquations.PK_ID AS EquationItemPK_ID, 
                         dbo.Tbl_EstimationItemEquations.FK_EstimationItemID
FROM            dbo.Tbl_EstimationItems LEFT OUTER JOIN
                         dbo.Tbl_EstimationItemEquations ON dbo.Tbl_EstimationItems.PK_ID = dbo.Tbl_EstimationItemEquations.FK_EstimationItemID LEFT OUTER JOIN
                         dbo.Tbl_ProjectEstimation ON dbo.Tbl_EstimationItems.PK_ID = dbo.Tbl_ProjectEstimation.FK_EstimationItemsID






GO
/****** Object:  View [dbo].[View_CompanyExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_CompanyExtract]
AS
SELECT        
dbo.Tbl_CompanyExractItems.ProjectEstimationID, 
sum(dbo.Tbl_CompanyExractItems.LastExecutedQTY) as 'ExecutedQTY',
dbo.Tbl_CompanyExract.FK_ProjectID
FROM            
dbo.Tbl_Project 
INNER JOIN dbo.Tbl_CompanyExract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_CompanyExract.FK_ProjectID 
INNER JOIN dbo.Tbl_CompanyExractItems ON dbo.Tbl_CompanyExract.PK_ID = dbo.Tbl_CompanyExractItems.FK_CompanyExractID
group by  
dbo.Tbl_CompanyExractItems.ProjectEstimationID, 
dbo.Tbl_CompanyExract.FK_ProjectID






GO
/****** Object:  View [dbo].[View_CompanyExtractNewOrder]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_CompanyExtractNewOrder]
AS
select (MAX(ExractOrder) + 1) as 'NewExtractOrder', FK_ProjectID, sum(NetDue) as 'LastPaid' from Tbl_CompanyExract group by FK_ProjectID






GO
/****** Object:  View [dbo].[View_DailySuppliesbook]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_DailySuppliesbook]
AS
SELECT        dbo.Tbl_ProjectSupplies.FK_ItemsID AS ItemID, dbo.Tbl_Items.ItemType AS ItemName, dbo.Tbl_Category.Name AS CategoryName, dbo.Tbl_Category.Name + ' - ' + dbo.Tbl_Items.ItemType AS FullItemName, 
                         dbo.Tbl_ProjectSupplies.WasSupplied, dbo.Tbl_ProjectSupplies.Rest, dbo.Tbl_ProjectSupplies.QTY, dbo.Tbl_ProjectSupplies.QTY - dbo.Tbl_ProjectSupplies.Rest AS TotalSupplied, 
                         dbo.Tbl_ProjectSupplies.PK_ID, dbo.Tbl_ProjectSupplies.FK_ProjectEstimationItemID, dbo.Tbl_ProjectSupplies.FK_ProjectID, dbo.Tbl_SuppliesEvent.PK_ID AS SuppliesEventID, 
                         dbo.Tbl_SuppliesEvent.FK_ProjectSuppliesID, dbo.Tbl_SuppliesEvent.UnitPrice, dbo.Tbl_SuppliesEvent.QTY AS SuppliesEventQTY, dbo.Tbl_SuppliesEvent.TotalPrice, dbo.Tbl_SuppliesEvent.FK_SupplierID, 
                         dbo.Tbl_SuppliesEvent.SuppliesDate, dbo.Tbl_SuppliesEvent.ReceiptNO, dbo.Tbl_Category.PK_ID AS CategoryID, dbo.Tbl_Project.Name AS ProjectName, dbo.Tbl_Supplier.Name AS SupplierName, 
                         dbo.Tbl_Project.IsActive
FROM            dbo.Tbl_ProjectSupplies INNER JOIN
                         dbo.Tbl_Items ON dbo.Tbl_ProjectSupplies.FK_ItemsID = dbo.Tbl_Items.PK_ID INNER JOIN
                         dbo.Tbl_Category ON dbo.Tbl_Items.FK_CategoryID = dbo.Tbl_Category.PK_ID INNER JOIN
                         dbo.Tbl_SuppliesEvent ON dbo.Tbl_ProjectSupplies.PK_ID = dbo.Tbl_SuppliesEvent.FK_ProjectSuppliesID INNER JOIN
                         dbo.Tbl_Project ON dbo.Tbl_ProjectSupplies.FK_ProjectID = dbo.Tbl_Project.PK_ID INNER JOIN
                         dbo.Tbl_Supplier ON dbo.Tbl_SuppliesEvent.FK_SupplierID = dbo.Tbl_Supplier.PK_ID

GO
/****** Object:  View [dbo].[View_DailyWorkerExract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_DailyWorkerExract]
AS
SELECT        dbo.Tbl_Project.Name, dbo.Tbl_DailyWorkerExtract.FK_ProjectID, dbo.Tbl_DailyWorkerExtract.ExractOrder, dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, dbo.Tbl_DailyWorkerExtract.LastPaid, 
                         dbo.Tbl_DailyWorkerExtract.Deductions, dbo.Tbl_DailyWorkerExtract.WorkerId, dbo.Tbl_DailyWorkerExtract.WorkerName, SUM(dbo.Tbl_DailyWorkerExtractItems.Price) AS Price, 
                         SUM(dbo.Tbl_DailyWorkerExtractItems.ExchangeRatio) AS ExchangeRatio, SUM(dbo.Tbl_DailyWorkerExtractItems.TotalDays) AS TotalDays, SUM(dbo.Tbl_DailyWorkerExtractItems.DeductionsDays) 
                         AS DeductionsDays, SUM(dbo.Tbl_DailyWorkerExtractItems.NetDays) AS NetDays, SUM(dbo.Tbl_DailyWorkerExtractItems.TotalPrice) AS TotalPrice, 
                         dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_DailyWorkerExtract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_DailyWorkerExtract.FK_ProjectID INNER JOIN
                         dbo.Tbl_DailyWorkerExtractItems ON dbo.Tbl_DailyWorkerExtract.PK_ID = dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID
GROUP BY dbo.Tbl_DailyWorkerExtractItems.FK_DailyWorkerExractID, dbo.Tbl_Project.Name, dbo.Tbl_DailyWorkerExtract.FK_ProjectID, dbo.Tbl_DailyWorkerExtract.ExractOrder, 
                         dbo.Tbl_DailyWorkerExtract.ExtractTotalPrice, dbo.Tbl_DailyWorkerExtract.LastPaid, dbo.Tbl_DailyWorkerExtract.Deductions, dbo.Tbl_DailyWorkerExtract.WorkerId, dbo.Tbl_DailyWorkerExtract.WorkerName


GO
/****** Object:  View [dbo].[View_DailyWorkerExtractNewOrder]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_DailyWorkerExtractNewOrder]
AS
SELECT        MAX(ExractOrder) + 1 AS NewExtractOrder, FK_ProjectID, SUM(NetDue) AS LastPaid
FROM            dbo.Tbl_DailyWorkerExtract
GROUP BY FK_ProjectID


GO
/****** Object:  View [dbo].[View_EmpolyeePaid]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_EmpolyeePaid] 
AS
select SUM(Amount) as Last_Paid, PersonID, PersonTypeID from Tbl_GuardianshipItems group by PersonID, PersonTypeID






GO
/****** Object:  View [dbo].[View_Guradianship]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Guradianship]
AS
SELECT        dbo.Tbl_Project.Name, dbo.Tbl_Project.Supervisor, dbo.Tbl_Project.ProjectPeriodPerMonth, dbo.Tbl_Project.StartDate, dbo.Tbl_Project.EndDate, dbo.Tbl_Project.DateOfReceiptOfTheSite, 
                         dbo.Tbl_Project.TechnicalOpenDate, dbo.Tbl_Project.ProjectCost, dbo.Tbl_Project.IsActive, dbo.Tbl_ProjectGuardianship.FK_ProjectID, dbo.Tbl_ProjectGuardianship.FK_EmployeeID, 
                         dbo.Tbl_ProjectGuardianship.DateFrom, dbo.Tbl_ProjectGuardianship.Date, dbo.Tbl_ProjectGuardianship.DateTo, dbo.Tbl_ProjectGuardianship.Amount, dbo.Tbl_ProjectGuardianship.FK_SaverID, 
                         dbo.Tbl_ProjectGuardianship.Rest, dbo.Tbl_ProjectGuardianship.Surplus, dbo.Tbl_GuardianshipItems.FK_ProjectGuardianshipID, dbo.Tbl_GuardianshipItems.Amount AS GuardianshipItemAmount, 
                         dbo.Tbl_GuardianshipItems.FK_ExpenseItemID, dbo.Tbl_GuardianshipItems.PersonID, dbo.Tbl_GuardianshipItems.PersonTypeID, dbo.GetPersonName(dbo.Tbl_GuardianshipItems.PersonID, 
                         dbo.Tbl_GuardianshipItems.PersonTypeID) AS PersonName, dbo.Tbl_GuardianshipItems.Date AS GuardianshipItemDate, dbo.Tbl_GuardianshipItems.WorkTypeId, 
                         dbo.GetWorkTypeName(dbo.Tbl_GuardianshipItems.PersonID, dbo.Tbl_GuardianshipItems.PersonTypeID, dbo.Tbl_GuardianshipItems.WorkTypeId) AS WorkFullName, 
                         dbo.Tbl_ExpensesItems.Name AS ExpensesItemName, dbo.Tbl_ExpensesItems.FK_ExpenseCategory, dbo.Tbl_ExpensesCategories.Name AS ExpensesCategoryName, 
                         dbo.Tbl_GuardianshipItems.PK_ID AS GuardianshipItemsId, dbo.Tbl_Employees.Name AS Expr1, dbo.Tbl_Employees.Mobile, dbo.Tbl_Employees.JobName, dbo.Tbl_Employees.FK_RoleID, 
                         dbo.Tbl_Employees.UserName
FROM            dbo.Tbl_Employees RIGHT OUTER JOIN
                         dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectGuardianship ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectGuardianship.FK_ProjectID INNER JOIN
                         dbo.Tbl_GuardianshipItems ON dbo.Tbl_ProjectGuardianship.PK_ID = dbo.Tbl_GuardianshipItems.FK_ProjectGuardianshipID ON 
                         dbo.Tbl_Employees.PK_ID = dbo.Tbl_ProjectGuardianship.FK_EmployeeID LEFT OUTER JOIN
                         dbo.Tbl_ExpensesCategories INNER JOIN
                         dbo.Tbl_ExpensesItems ON dbo.Tbl_ExpensesCategories.PK_ID = dbo.Tbl_ExpensesItems.FK_ExpenseCategory ON dbo.Tbl_GuardianshipItems.FK_ExpenseItemID = dbo.Tbl_ExpensesItems.PK_ID

GO
/****** Object:  View [dbo].[View_ProjectContractor]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[View_ProjectContractor]
AS
SELECT        
dbo.Tbl_Project.PK_ID AS ProjectId, 
dbo.Tbl_Project.Name AS ProjectName, 
dbo.Tbl_Subcontractor.Name AS SubContractorName, 
dbo.Tbl_Subcontractor.PK_ID AS SubContractorId, 
dbo.Tbl_Subcontractor.FK_WorkTypeID, 
dbo.Tbl_WorkType.Name AS WorkTypeName, 
dbo.Tbl_WorkType.FK_WorkCategory, 
dbo.Tbl_WorkCategories.Name AS WorkCategoriesName, 
(dbo.Tbl_WorkCategories.Name + ' - ' + dbo.Tbl_WorkType.Name) As FullWorkName,
dbo.Tbl_SubContractorWorks.FK_WorkID
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectSubContractor ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectSubContractor.FK_ProjectID INNER JOIN
                         dbo.Tbl_SubContractorWorks ON dbo.Tbl_ProjectSubContractor.FK_SubContractorWorkID = dbo.Tbl_SubContractorWorks.PK_ID INNER JOIN
                         dbo.Tbl_Subcontractor ON dbo.Tbl_SubContractorWorks.FK_SubContractorID = dbo.Tbl_Subcontractor.PK_ID INNER JOIN
                         dbo.Tbl_WorkType ON dbo.Tbl_SubContractorWorks.FK_WorkID = dbo.Tbl_WorkType.PK_ID INNER JOIN
                         dbo.Tbl_WorkCategories ON dbo.Tbl_WorkType.FK_WorkCategory = dbo.Tbl_WorkCategories.PK_ID








GO
/****** Object:  View [dbo].[View_ProjectDeposits]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ProjectDeposits]
AS
SELECT        dbo.Tbl_Project.Name AS ProjectName, dbo.Tbl_Project.Supervisor, dbo.Tbl_Project.ProjectPeriodPerMonth, dbo.Tbl_Project.StartDate, dbo.Tbl_Project.EndDate, dbo.Tbl_Project.DateOfReceiptOfTheSite, 
                         dbo.Tbl_Project.TechnicalOpenDate, dbo.Tbl_Project.ProjectCost, dbo.Tbl_Project.IsActive, dbo.Tbl_ProjectSaverDeposits.FK_SaverItemID, dbo.Tbl_ProjectSaverDeposits.Date, 
                         dbo.Tbl_ProjectSaverDeposits.FK_ProjectID, dbo.Tbl_ProjectSaverDeposits.Amount, dbo.Tbl_ProjectSaverDeposits.Description, dbo.Tbl_SaverItems.Name AS ItemName, dbo.Tbl_SaverItems.FK_SaverCategory, 
                         dbo.Tbl_ProjectSaverDeposits.PK_ID
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectSaverDeposits ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectSaverDeposits.FK_ProjectID INNER JOIN
                         dbo.Tbl_SaverItems ON dbo.Tbl_ProjectSaverDeposits.FK_SaverItemID = dbo.Tbl_SaverItems.PK_ID




GO
/****** Object:  View [dbo].[View_ProjectEstimation]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_ProjectEstimation]
AS
SELECT        
dbo.Tbl_ProjectEstimation.Price, 
dbo.Tbl_ProjectEstimation.Quantity, 
dbo.Tbl_ProjectEstimation.Notes, 
dbo.Tbl_ProjectEstimation.FK_ProjectID, 
dbo.Tbl_ProjectEstimation.FK_EstimationItemsID, 
dbo.Tbl_EstimationItems.BusinessStatement, 
dbo.Tbl_EstimationItems.Unit, dbo.Tbl_Project.Name AS ProjectName
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectEstimation ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectEstimation.FK_ProjectID INNER JOIN
                         dbo.Tbl_EstimationItems ON dbo.Tbl_ProjectEstimation.FK_EstimationItemsID = dbo.Tbl_EstimationItems.PK_ID






GO
/****** Object:  View [dbo].[View_ProjectGurdianship]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ProjectGurdianship]
AS
SELECT        dbo.Tbl_ProjectGuardianship.FK_ProjectID, dbo.Tbl_ProjectGuardianship.FK_EmployeeID, dbo.Tbl_ProjectGuardianship.Date, dbo.Tbl_ProjectGuardianship.DateFrom, dbo.Tbl_ProjectGuardianship.DateTo, 
                         dbo.Tbl_ProjectGuardianship.Amount, dbo.Tbl_ProjectGuardianship.FK_SaverID, dbo.Tbl_ProjectGuardianship.Rest, dbo.Tbl_ProjectGuardianship.Surplus, dbo.Tbl_Employees.Name, dbo.Tbl_Employees.Mobile, 
                         dbo.Tbl_Employees.ID, dbo.Tbl_Employees.Salary, dbo.Tbl_Employees.JobName, dbo.Tbl_ProjectGuardianship.PK_ID, 'عهدة الموظف : ' + dbo.Tbl_Employees.Name + ' , التاريخ من: ' + CONVERT(NVARCHAR, 
                         dbo.Tbl_ProjectGuardianship.DateFrom, 103) + ' , الى: ' + CONVERT(NVARCHAR, dbo.Tbl_ProjectGuardianship.DateTo, 103) + '' AS GurdianshipName
FROM            dbo.Tbl_Employees INNER JOIN
                         dbo.Tbl_ProjectGuardianship ON dbo.Tbl_Employees.PK_ID = dbo.Tbl_ProjectGuardianship.FK_EmployeeID

GO
/****** Object:  View [dbo].[View_ProjectSuppliers]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ProjectSuppliers]
AS
SELECT DISTINCT 
                         dbo.Tbl_Project.Name AS ProjectName, dbo.Tbl_Supplier.Name AS SupplierName, dbo.Tbl_ProjectEstimation.FK_ProjectID AS ProjectID, 
                         dbo.Tbl_SuppliesEvent.FK_SupplierID AS SupplierID, dbo.Tbl_Items.FK_CategoryID AS CategoryID, dbo.Tbl_ProjectSupplies.FK_ItemsID AS ItemID, 
                         dbo.Tbl_Items.ItemType AS ItemName, dbo.Tbl_Category.Name AS CategoryName, dbo.Tbl_Category.Name + ' - ' + dbo.Tbl_Items.ItemType AS FullItemName, 
                         dbo.Tbl_ProjectSupplies.WasSupplied, dbo.Tbl_ProjectSupplies.Rest
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectEstimation ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectEstimation.FK_ProjectID INNER JOIN
                         dbo.Tbl_ProjectSupplies ON dbo.Tbl_ProjectEstimation.PK_ID = dbo.Tbl_ProjectSupplies.FK_ProjectEstimationItemID INNER JOIN
                         dbo.Tbl_SuppliesEvent ON dbo.Tbl_ProjectSupplies.PK_ID = dbo.Tbl_SuppliesEvent.FK_ProjectSuppliesID INNER JOIN
                         dbo.Tbl_Supplier ON dbo.Tbl_SuppliesEvent.FK_SupplierID = dbo.Tbl_Supplier.PK_ID INNER JOIN
                         dbo.Tbl_Items ON dbo.Tbl_ProjectSupplies.FK_ItemsID = dbo.Tbl_Items.PK_ID INNER JOIN
                         dbo.Tbl_Category ON dbo.Tbl_Items.FK_CategoryID = dbo.Tbl_Category.PK_ID





GO
/****** Object:  View [dbo].[View_ProjectSupplies]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ProjectSupplies]
AS
SELECT DISTINCT 
                         dbo.Tbl_Project.Name AS ProjectName, dbo.Tbl_ProjectEstimation.FK_ProjectID AS ProjectID, dbo.Tbl_Items.FK_CategoryID AS CategoryID, 
                         dbo.Tbl_ProjectSupplies.FK_ItemsID AS ItemID, dbo.Tbl_Items.ItemType AS ItemName, dbo.Tbl_Category.Name AS CategoryName, 
                         dbo.Tbl_Category.Name + ' - ' + dbo.Tbl_Items.ItemType AS FullItemName, dbo.Tbl_ProjectSupplies.WasSupplied, dbo.Tbl_ProjectSupplies.Rest, 
                         dbo.Tbl_ProjectSupplies.QTY, dbo.Tbl_ProjectSupplies.QTY - dbo.Tbl_ProjectSupplies.Rest AS TotalSupplied, dbo.Tbl_ProjectSupplies.PK_ID
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectEstimation ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectEstimation.FK_ProjectID INNER JOIN
                         dbo.Tbl_ProjectSupplies ON dbo.Tbl_ProjectEstimation.PK_ID = dbo.Tbl_ProjectSupplies.FK_ProjectEstimationItemID INNER JOIN
                         dbo.Tbl_Items ON dbo.Tbl_ProjectSupplies.FK_ItemsID = dbo.Tbl_Items.PK_ID INNER JOIN
                         dbo.Tbl_Category ON dbo.Tbl_Items.FK_CategoryID = dbo.Tbl_Category.PK_ID





GO
/****** Object:  View [dbo].[View_ProjectWorker]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ProjectWorker]
AS
SELECT        dbo.Tbl_Project.PK_ID AS ProjectId, dbo.Tbl_Project.Name AS ProjectName, dbo.Tbl_DailyWorker.PK_ID AS WorkerId, 
                         dbo.Tbl_DailyWorker.Name AS WorkerName
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_ProjectDailyWorker ON dbo.Tbl_Project.PK_ID = dbo.Tbl_ProjectDailyWorker.FK_Project_ID INNER JOIN
                         dbo.Tbl_DailyWorker ON dbo.Tbl_ProjectDailyWorker.FK_DailyWorker_ID = dbo.Tbl_DailyWorker.PK_ID





GO
/****** Object:  View [dbo].[View_Security]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Security]
AS
SELECT        dbo.Tbl_Employees.Name AS EmployeeName, dbo.Tbl_Employees.Mobile, dbo.Tbl_Employees.ID, dbo.Tbl_Employees.JobName, dbo.Tbl_Employees.Salary, dbo.Tbl_Employees.UserName, 
                         dbo.Tbl_Employees.Password, dbo.Tbl_Employees.FK_RoleID, dbo.Tbl_Employees.PK_ID AS EmployeePK_ID, dbo.Tbl_Roles.Name AS RoleName, dbo.Tbl_Pages.PageName, dbo.Tbl_Pages.ArabicName, 
                         dbo.Tbl_Pages.PK_ID AS PagePK_ID, dbo.Tbl_RolePermissions.Access, dbo.Tbl_RolePermissions.PK_ID AS Tbl_RolePermissionPK_ID
FROM            dbo.Tbl_Employees INNER JOIN
                         dbo.Tbl_Roles ON dbo.Tbl_Employees.FK_RoleID = dbo.Tbl_Roles.PK_ID INNER JOIN
                         dbo.Tbl_RolePermissions ON dbo.Tbl_Roles.PK_ID = dbo.Tbl_RolePermissions.FK_RoleID INNER JOIN
                         dbo.Tbl_Pages ON dbo.Tbl_RolePermissions.FK_PageID = dbo.Tbl_Pages.PK_ID




GO
/****** Object:  View [dbo].[View_SubContractorExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SubContractorExtract]
AS
SELECT        dbo.Tbl_SubContractorExtractItems.WorkNameID, SUM(dbo.Tbl_SubContractorExtractItems.LastExecutedQTY) AS ExecutedQTY, dbo.Tbl_SubContractorExtract.FK_ProjectID
FROM            dbo.Tbl_Project INNER JOIN
                         dbo.Tbl_SubContractorExtract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_SubContractorExtract.FK_ProjectID INNER JOIN
                         dbo.Tbl_SubContractorExtractItems ON dbo.Tbl_SubContractorExtract.PK_ID = dbo.Tbl_SubContractorExtractItems.FK_SubContractorExractID
GROUP BY dbo.Tbl_SubContractorExtractItems.WorkNameID, dbo.Tbl_SubContractorExtract.FK_ProjectID


GO
/****** Object:  View [dbo].[View_SubContractorExtractNewOrder]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[View_SubContractorExtractNewOrder]
AS
select (MAX(ExractOrder) + 1) as 'NewExtractOrder', FK_ProjectID, sum(NetDue) as 'LastPaid' from Tbl_SubContractorExtract group by FK_ProjectID








GO
/****** Object:  View [dbo].[view_subcontractorWork]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_subcontractorWork]
AS
SELECT     dbo.Tbl_Subcontractor.PK_ID AS SubContractorId, dbo.Tbl_Subcontractor.Name AS SubContractorName, dbo.Tbl_WorkType.Name AS WorkName
FROM         dbo.Tbl_Subcontractor INNER JOIN
                      dbo.Tbl_WorkType ON dbo.Tbl_Subcontractor.FK_WorkTypeID = dbo.Tbl_WorkType.PK_ID









GO
/****** Object:  View [dbo].[View_SubContractorWorkNames]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SubContractorWorkNames]
AS
SELECT        dbo.Tbl_SubContractorWorks.FK_SubContractorID AS SubContractorID, dbo.Tbl_WorkType.Name AS WorkName, dbo.Tbl_WorkType.PK_ID AS WorkId
FROM            dbo.Tbl_WorkCategories INNER JOIN
                         dbo.Tbl_WorkType ON dbo.Tbl_WorkCategories.PK_ID = dbo.Tbl_WorkType.FK_WorkCategory INNER JOIN
                         dbo.Tbl_SubContractorWorks ON dbo.Tbl_WorkType.PK_ID = dbo.Tbl_SubContractorWorks.FK_WorkID





GO
/****** Object:  View [dbo].[View_SupplierExtract]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_SupplierExtract]
AS
SELECT        
dbo.Tbl_SupplierExtractItems.SupplyNameID, 
sum(dbo.Tbl_SupplierExtractItems.LastExecutedQTY) as 'ExecutedQTY',
dbo.Tbl_SupplierExtract.FK_ProjectID
FROM            
dbo.Tbl_Project 
INNER JOIN dbo.Tbl_SupplierExtract ON dbo.Tbl_Project.PK_ID = dbo.Tbl_SupplierExtract.FK_ProjectID 
INNER JOIN dbo.Tbl_SupplierExtractItems ON dbo.Tbl_SupplierExtract.PK_ID = dbo.Tbl_SupplierExtractItems.FK_SupplierExractID
group by  
dbo.Tbl_SupplierExtractItems.SupplyNameID, 
dbo.Tbl_SupplierExtract.FK_ProjectID






GO
/****** Object:  View [dbo].[View_SupplierExtractNewOrder]    Script Date: 17/08/2014 05:57:21 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[View_SupplierExtractNewOrder]
AS
select (MAX(ExractOrder) + 1) as 'NewExtractOrder', FK_ProjectID, sum(NetDue) as 'LastPaid' from Tbl_SupplierExtract group by FK_ProjectID







GO
SET IDENTITY_INSERT [dbo].[Tbl_Category] ON 

GO
INSERT [dbo].[Tbl_Category] ([PK_ID], [Name]) VALUES (1, N'حديد')
GO
INSERT [dbo].[Tbl_Category] ([PK_ID], [Name]) VALUES (2, N'خشب')
GO
INSERT [dbo].[Tbl_Category] ([PK_ID], [Name]) VALUES (3, N'رمل')
GO
INSERT [dbo].[Tbl_Category] ([PK_ID], [Name]) VALUES (4, N'زلط')
GO
SET IDENTITY_INSERT [dbo].[Tbl_Category] OFF
GO
INSERT [dbo].[Tbl_DailyWorker] ([PK_ID], [Name], [Mobile], [WorkerID]) VALUES (1, N'ffff', N'012                 ', N'7654')
GO
INSERT [dbo].[Tbl_Employees] ([PK_ID], [Name], [Mobile], [ID], [Salary], [JobName], [UserName], [Password], [FK_RoleID]) VALUES (1, N'admin', N'012', N'2', 25000.0000, N'1', N'admin', N'admin', 1)
GO
INSERT [dbo].[Tbl_Employees] ([PK_ID], [Name], [Mobile], [ID], [Salary], [JobName], [UserName], [Password], [FK_RoleID]) VALUES (2, N'محمد', N'12', N'12', 12.0000, N'12', N'mz', N'3606397', 2)
GO
INSERT [dbo].[Tbl_Employees] ([PK_ID], [Name], [Mobile], [ID], [Salary], [JobName], [UserName], [Password], [FK_RoleID]) VALUES (3, N'محمد زكى', N'22', N'222', 22.0000, N'22', N'mz', N'123456', 2)
GO
SET IDENTITY_INSERT [dbo].[Tbl_EquationItems] ON 

GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (1, 18, 1, 20, 1)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (2, 104, 1, 2, 1)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (3, 2, 5, 1, 1)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (4, 7, 1, 3, 564)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (5, 7, 5, 4, 564)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (6, 1, 5, 1, 1)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (8, 112, 3, 1, 1)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (9, 21, 1, 20, 1)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (10, 3, 5, 20, 5)
GO
INSERT [dbo].[Tbl_EquationItems] ([PK_ID], [FK_EstimationItemEquationID], [FK_ItemID], [ItemBY], [ItemDevid]) VALUES (11, 12, 1, 20, 20)
GO
SET IDENTITY_INSERT [dbo].[Tbl_EquationItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_EstimationItemEquations] ON 

GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (1, N'نقل مخلفات  معادلة', 1, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (2, N'حفر  معادلة', 2, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (3, N'ردم برمال من ناتج الحفر  معادلة', 3, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (4, N'ردم من ناتج حفر مورد معادلة', 4, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (5, N'احلال زلط : رمل 1:1 معادلة', 5, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (6, N'خ . ع اساسات لبشة معادلة', 6, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (7, N'خ . م مسلحة اساسات  معادلة', 7, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (8, N'م2 خ . ع ارضيات 12 سم معادلة', 8, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (9, N'م/ط بردورات (50*/30) معادلة', 9, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (10, N'م2 خ . ع دورات المياه معادلة', 10, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (11, N'م2 دكة ميول للاسطح معادلة', 11, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (12, N'م3 خ . م هيكل معادلة', 12, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (13, N'م2 طبقة عازلة اسفللت معادلة', 13, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (14, N'م2 دهانات طبقة عازلة اساسات معادلة', 14, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (15, N'م2 طبقة عازلة للاسطح ودورات المياه  + بيتومين ساخن انسومات ( رقتين )  معادلة', 15, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (16, N'م2 طبقة عازلة اللحرارة  معادلة', 16, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (17, N'م3 مباني حطة الردم معادلة', 17, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (18, N'م2 مباني حطة الردم معادلة', 18, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (19, N'م2 مباني مصمت  معادلة', 19, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (20, N'م2 مباني بلوك مفرغ معادلة', 20, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (21, N'بياض حوائط داخلية  معادلة', 21, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (22, N'بياض اسقف معادلة', 22, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (23, N'بياض حوائط مناور معادلة', 23, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (24, N'بياض واجهات  معادلة', 24, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (25, N'بياض اسفال للمناور معادلة', 25, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (26, N'م2 دهانات للاسقف والحوائط بلاستيك معادلة', 26, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (27, N'م2 دهانات جير للمناور والدراوي  معادلة', 27, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (28, N'م/ط كسوة درج جلالة معادلة', 28, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (29, N'م2 طوب حراري معادلة', 29, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (30, N'م2 كسوة رخام جلالة  معادلة', 30, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (31, N'م2 سيراميك حوائط معادلة', 31, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (32, N'م2 قرميد مرسيليا معادلة', 32, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (33, N'م2 سيراميك ارضيات حمامات معادلة', 33, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (34, N'م2 سيراميك ارضيات للغرف والصالات  معادلة', 34, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (35, N'م2 بلاط موزايكو للاسطح معادلة', 35, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (36, N'م2 ترابيع رخام جلالة للارضيات  معادلة', 36, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (37, N'م2 انترلوك للارصفة معادلة', 37, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (38, N'ب1(1*2.2) معادلة', 38, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (39, N'ب2(0.9*2.2) معادلة', 39, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (40, N'ب3(0.8*2.2) معادلة', 40, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (41, N'ب4(1.2*2.2 ) معادلة', 41, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (42, N'ب5( 0.9*2.2) معادلة', 42, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (43, N'ب7(0.8*2.2) معادلة', 43, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (44, N'ش1(1.2*1.2) معادلة', 44, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (45, N'ش2(0.6*0.8) معادلة', 45, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (46, N'ب4/(1.2*2.2) معادلة', 46, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (47, N'ب5/(0.9*2.2) معادلة', 47, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (48, N'زوج مناشر  معادلة', 48, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (49, N'كجم حديد بوابات معادلة', 49, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (50, N'كجم دولاب صاج معادلة', 50, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (51, N'مرحاض افرنجي معادلة', 51, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (52, N'حوض غسيل ايدي معادلة', 52, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (53, N'حوض غسيل اواني  معادلة', 53, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (54, N'دش بلدي معادلة', 54, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (55, N'سيفون ارضية بلاستيك معادلة', 55, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (56, N'جاليتراب  معادلة', 56, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (57, N'جرجوري  معادلة', 57, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (58, N'جرجوري + ميزراب معادلة', 58, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (59, N'مواسير بولي قطر 2" معادلة', 59, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (60, N'مواسير صرف 4" معادلة', 60, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (61, N'مواسير صرف 3" معادلة', 61, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (62, N'مواسير صرف2" معادلة', 62, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (63, N'محبس بلية 2" معادلة', 63, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (64, N'مواسير حديد مجلفن 0.75 "  معادلة', 64, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (65, N'مواسير صرف  4"تحت الارض  معادلة', 65, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (66, N'مواسير صرف  6"تحت الارض  معادلة', 66, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (67, N'غ . ت 60*60 معادلة', 67, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (68, N'غ . ت 60*90 معادلة', 68, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (69, N'غ . محابس  معادلة', 69, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (70, N'مجموعة بطاريات  معادلة', 70, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (71, N'عداد مياه معادلة', 71, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (72, N'مواسير حريق مجلفن 3" معادلة', 72, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (73, N'وصلة لاكور سريع معادلة', 73, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (74, N'صندوق حريق معادلة', 74, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (75, N'لوحة عمومية  معادلة', 75, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (76, N'لوحة فرعية معادلة', 76, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (77, N'لوحة خدمات معادلة', 77, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (78, N'كوفريه للشقق معادلة', 78, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (79, N'كوفريىه الخدمات معادلة', 79, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (80, N'لوحة عداد معادلة', 80, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (81, N'ارضي معادلة', 81, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (82, N'م/ط كابل (3*185+95) معادلة', 82, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (83, N'م/ط موصلات (3*70+35(1*25) معادلة', 83, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (84, N'موصلات (3*6) معادلة', 84, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (85, N'موصلات (3*10) معادلة', 85, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (86, N'موصلات (3*16) معادلة', 86, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (87, N'دائرة فرعية بالسقف معادلة', 87, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (88, N'دائرة انارة  معادلة', 88, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (89, N'نازلة  معادلة', 89, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (90, N'دائرة بريزة معادلة', 90, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (91, N'مخرج تليفزين معادلة', 91, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (92, N'مخرج تليفون معادلة', 92, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (93, N'بوكس تليفونات معادلة', 93, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (94, N'زر جرس الشقة معادلة', 94, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (95, N'وحدة اضاءة معادلة', 95, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (96, N'مفتاح انارة معادلة', 96, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (97, N'مجموعة حبات معادلة', 97, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (98, N'ماخذ كهربي مفرد معادلة', 98, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (99, N'زر جرس ماجيك معادلة', 99, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (100, N'مفتاح بتشينو معادلة', 100, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (101, N'ماخذ تليفون معادلة', 101, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (102, N'عدد (2) قطر 2" بلاستيك معادلة', 102, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (103, N'تيست معادلة', 103, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (104, N'حديد معادلة', 104, 1)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (105, N'حذف مرموم معادلة', 105, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (106, N'عجينة حائط معادلة', 106, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (107, N'غشيل وشطف معادلة', 107, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (108, N'خياطة معادلة', 108, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (109, N'خياطة 2 معادلة', 109, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (110, N'خياطة 4  معادلة', 110, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (111, N'تجربى معادلة', 111, 0)
GO
INSERT [dbo].[Tbl_EstimationItemEquations] ([PK_ID], [EquationName], [FK_EstimationItemID], [HasEquationItems]) VALUES (112, N'بب معادلة', 112, 1)
GO
SET IDENTITY_INSERT [dbo].[Tbl_EstimationItemEquations] OFF
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (0, N' ', N' ')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (1, N'نقل مخلفات ', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (2, N'حفر ', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (3, N'ردم برمال من ناتج الحفر ', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (4, N'ردم من ناتج حفر مورد', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (5, N'احلال زلط : رمل 1:1', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (6, N'خ . ع اساسات لبشة', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (7, N'خ . م مسلحة اساسات ', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (8, N'م2 خ . ع ارضيات 12 سم', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (9, N'م/ط بردورات (50*/30)', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (10, N'م2 خ . ع دورات المياه', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (11, N'م2 دكة ميول للاسطح', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (12, N'م3 خ . م هيكل', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (13, N'م2 طبقة عازلة اسفللت', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (14, N'م2 دهانات طبقة عازلة اساسات', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (15, N'م2 طبقة عازلة للاسطح ودورات المياه  + بيتومين ساخن انسومات ( رقتين ) ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (16, N'م2 طبقة عازلة اللحرارة ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (17, N'م3 مباني حطة الردم', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (18, N'م2 مباني حطة الردم', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (19, N'م2 مباني مصمت ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (20, N'م2 مباني بلوك مفرغ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (21, N'بياض حوائط داخلية ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (22, N'بياض اسقف', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (23, N'بياض حوائط مناور', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (24, N'بياض واجهات ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (25, N'بياض اسفال للمناور', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (26, N'م2 دهانات للاسقف والحوائط بلاستيك', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (27, N'م2 دهانات جير للمناور والدراوي ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (28, N'م/ط كسوة درج جلالة', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (29, N'م2 طوب حراري', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (30, N'م2 كسوة رخام جلالة ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (31, N'م2 سيراميك حوائط', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (32, N'م2 قرميد مرسيليا', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (33, N'م2 سيراميك ارضيات حمامات', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (34, N'م2 سيراميك ارضيات للغرف والصالات ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (35, N'م2 بلاط موزايكو للاسطح', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (36, N'م2 ترابيع رخام جلالة للارضيات ', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (37, N'م2 انترلوك للارصفة', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (38, N'ب1(1*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (39, N'ب2(0.9*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (40, N'ب3(0.8*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (41, N'ب4(1.2*2.2 )', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (42, N'ب5( 0.9*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (43, N'ب7(0.8*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (44, N'ش1(1.2*1.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (45, N'ش2(0.6*0.8)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (46, N'ب4/(1.2*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (47, N'ب5/(0.9*2.2)', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (48, N'زوج مناشر ', N'بالزوج')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (49, N'كجم حديد بوابات', N'كجم')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (50, N'كجم دولاب صاج', N'كجم')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (51, N'مرحاض افرنجي', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (52, N'حوض غسيل ايدي', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (53, N'حوض غسيل اواني ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (54, N'دش بلدي', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (55, N'سيفون ارضية بلاستيك', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (56, N'جاليتراب ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (57, N'جرجوري ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (58, N'جرجوري + ميزراب', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (59, N'مواسير بولي قطر 2"', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (60, N'مواسير صرف 4"', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (61, N'مواسير صرف 3"', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (62, N'مواسير صرف2"', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (63, N'محبس بلية 2"', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (64, N'مواسير حديد مجلفن 0.75 " ', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (65, N'مواسير صرف  4"تحت الارض ', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (66, N'مواسير صرف  6"تحت الارض ', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (67, N'غ . ت 60*60', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (68, N'غ . ت 60*90', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (69, N'غ . محابس ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (70, N'مجموعة بطاريات ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (71, N'عداد مياه', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (72, N'مواسير حريق مجلفن 3"', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (73, N'وصلة لاكور سريع', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (74, N'صندوق حريق', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (75, N'لوحة عمومية ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (76, N'لوحة فرعية', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (77, N'لوحة خدمات', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (78, N'كوفريه للشقق', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (79, N'كوفريىه الخدمات', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (80, N'لوحة عداد', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (81, N'ارضي', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (82, N'م/ط كابل (3*185+95)', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (83, N'م/ط موصلات (3*70+35(1*25)', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (84, N'موصلات (3*6)', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (85, N'موصلات (3*10)', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (86, N'موصلات (3*16)', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (87, N'دائرة فرعية بالسقف', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (88, N'دائرة انارة ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (89, N'نازلة ', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (90, N'دائرة بريزة', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (91, N'مخرج تليفزين', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (92, N'مخرج تليفون', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (93, N'بوكس تليفونات', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (94, N'زر جرس الشقة', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (95, N'وحدة اضاءة', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (96, N'مفتاح انارة', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (97, N'مجموعة حبات', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (98, N'ماخذ كهربي مفرد', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (99, N'زر جرس ماجيك', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (100, N'مفتاح بتشينو', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (101, N'ماخذ تليفون', N'عدد')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (102, N'عدد (2) قطر 2" بلاستيك', N'م/ط')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (103, N'تيست', N'تيست')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (104, N'حديد', N'20')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (105, N'حذف مرموم', N'م2')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (106, N'عجينة حائط', N'كيلو')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (107, N'غشيل وشطف', N'م3')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (108, N'خياطة', N'م')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (109, N'خياطة 2', N'م')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (110, N'خياطة 4 ', N'م')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (111, N'تجربى', N'ت')
GO
INSERT [dbo].[Tbl_EstimationItems] ([PK_ID], [BusinessStatement], [Unit]) VALUES (112, N'بب', N'ك')
GO
INSERT [dbo].[Tbl_ExpensesCategories] ([PK_ID], [Name]) VALUES (1, N'ب         ')
GO
INSERT [dbo].[Tbl_ExpensesCategories] ([PK_ID], [Name]) VALUES (2, N'ف 22      ')
GO
INSERT [dbo].[Tbl_ExpensesCategories] ([PK_ID], [Name]) VALUES (3, N'كهرباء')
GO
INSERT [dbo].[Tbl_ExpensesCategories] ([PK_ID], [Name]) VALUES (4, N'مياه')
GO
INSERT [dbo].[Tbl_ExpensesCategories] ([PK_ID], [Name]) VALUES (5, N'ايجار')
GO
INSERT [dbo].[Tbl_ExpensesCategories] ([PK_ID], [Name]) VALUES (6, N'أعانة')
GO
INSERT [dbo].[Tbl_ExpensesItems] ([PK_ID], [Name], [FK_ExpenseCategory]) VALUES (1, N'لاىلاىلا', 1)
GO
INSERT [dbo].[Tbl_ExpensesItems] ([PK_ID], [Name], [FK_ExpenseCategory]) VALUES (2, N'بللبلببلبلب', 2)
GO
INSERT [dbo].[Tbl_ExpensesItems] ([PK_ID], [Name], [FK_ExpenseCategory]) VALUES (3, N'مياه', 4)
GO
INSERT [dbo].[Tbl_GuardianshipItems] ([PK_ID], [FK_ProjectGuardianshipID], [Amount], [FK_ExpenseItemID], [PersonID], [PersonTypeID], [Date], [WorkTypeId]) VALUES (1, 1, 120.0000, 1, NULL, NULL, CAST(0xA34E0000 AS SmallDateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Tbl_Items] ON 

GO
INSERT [dbo].[Tbl_Items] ([PK_ID], [FK_CategoryID], [ItemType], [FK_MeasurementUnitID]) VALUES (1, 1, N'حديد 5 مم', 1)
GO
INSERT [dbo].[Tbl_Items] ([PK_ID], [FK_CategoryID], [ItemType], [FK_MeasurementUnitID]) VALUES (2, 1, N'5 ممم ل', 1)
GO
INSERT [dbo].[Tbl_Items] ([PK_ID], [FK_CategoryID], [ItemType], [FK_MeasurementUnitID]) VALUES (3, 2, N'خ زان', 5)
GO
INSERT [dbo].[Tbl_Items] ([PK_ID], [FK_CategoryID], [ItemType], [FK_MeasurementUnitID]) VALUES (4, 2, N'خ ابيض', 5)
GO
INSERT [dbo].[Tbl_Items] ([PK_ID], [FK_CategoryID], [ItemType], [FK_MeasurementUnitID]) VALUES (5, 3, N'رمل', 4)
GO
SET IDENTITY_INSERT [dbo].[Tbl_Items] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_MeasurementUnit] ON 

GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (1, N'كيلو')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (2, N'م')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (3, N'م2')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (4, N'م3')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (5, N'سم')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (6, N'سم2')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (7, N'سم3')
GO
INSERT [dbo].[Tbl_MeasurementUnit] ([PK_ID], [Unit]) VALUES (8, N'طن')
GO
SET IDENTITY_INSERT [dbo].[Tbl_MeasurementUnit] OFF
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (1, N'AddSupplier.aspx', N'إضافة موردين')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (2, N'EditSupplier.aspx', N'تعديل الموردين')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (3, N'AddSubcontractor.aspx', N'إضافة مقاولى الباطن')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (4, N'EditSubcontractors.aspx', N'تعديل مقاولى الباطن')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (5, N'AddDailyWorker.aspx', N'إضافة العمالة اليومية')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (6, N'EditDailyWorker.aspx', N'تعديل العمالة اليومية')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (7, N'AddEmployee.aspx', N'إضافة الموظفين')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (8, N'EditEmployee.aspx', N'تعديل الموظفين')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (9, N'ProjectSaver.aspx', N'إيداع لخزنة المشروع')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (10, N'AddSaverItem.aspx', N'إضافة بنود الخزن')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (11, N'EditSaverItem.aspx', N'تعديل بنود الخزن')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (12, N'CompanyExtract.aspx', N'مستخلص الشركة')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (13, N'SupplierExtract.aspx', N'مستخلص موردين')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (14, N'SubContractorExtract.aspx', N'مستخلص مقاولين الباطن')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (15, N'DailyWorkerExtract.aspx', N'مستخلص العماله اليوميه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (16, N'AddCategory.aspx', N'إضافة فئات الاصناف')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (17, N'EditCategory.aspx', N'تعديل فئات الاصناف')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (18, N'AddItems.aspx', N'إضافة أصناف')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (19, N'EditItems.aspx', N'تعديل أصناف')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (20, N'AddWorkCategory.aspx', N'إضافة فئات أنواع العمل')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (21, N'EditWorkCategory.aspx', N'تعديل فئات أنواع العمل')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (22, N'AddWorkType.aspx', N'إضافة أنواع العمل')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (23, N'EditWorkType.aspx', N'تعديل أنواع العمل')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (24, N'AddMeasurementUnit.aspx', N'إضافة وحدات القياس')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (25, N'AddExpenseCategory.aspx', N'إضافة فئات المصروفات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (26, N'EditExpenseCategory.aspx', N'تعديل فئات المصروفات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (27, N'AddExpenseItem.aspx', N'إضافة بنود المصروفات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (28, N'EditExpenseItem.aspx', N'تعديل بنود المصروفات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (29, N'DailyCashbook.aspx', N'دفتر اليومية النقدى')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (30, N'DailySuppliesbook.aspx', N'دفتر يومية التوريدات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (31, N'NewProject.aspx', N'مشروع جديد')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (32, N'SelectProject.aspx', N'مشاريع جارية')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (33, N'ReportFillterProject.aspx', N'أرشيف المشروعات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (34, N'EditDailyCashbook.aspx', N'تعديل دفتر اليوميه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (35, N'EditDailySuppliesbook.aspx', N'تعديل دفتر التوريدات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (36, N'EditProjectSaver.aspx', N'تعديل سحب/ايداع خزنة')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (37, N'EditCompanyExtract.aspx', N'تعديل مستخلص الشركة')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (38, N'EditSupplierExtract.aspx', N'تعديل مستخلص موردين')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (39, N'EditSubContractorExtract.aspx', N'تعديل مستخلص مقاولين الباطن')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (40, N'EditDailyWorkerExtract.aspx', N'تعديل مستخلص العماله اليوميه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (41, N'ReportFillterCompany.aspx', N'تقرير مستخلص شركه ')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (42, N'ReportFillterSupplier.aspx', N'تقرير مستخلص مورد')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (43, N'ReportFillterSub.aspx', N'تقرير مستخلص مقاول')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (44, N'ReportFillterProject.aspx', N'تقرير أرشيف المشروعات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (45, N'ReportFillterDailyCashbook.aspx', N'تقرير دفتر اليوميه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (46, N'ReportFillterDailySuppliesbook.aspx', N'تقرير دفتر التوريدات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (47, N'EditUserAndPassword.aspx', N'اضافة وتعديل اسم مستخدم')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (48, N'SelectRoles.aspx', N'اسناد الصلاحيات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (49, N'SetRoles.aspx', N'تصنيف الصلاحيات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (50, N'ReportFillterWorkerExtract.aspx', N'مستخلص العماله اليوميه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (51, N'EditRoles.aspx', N'تعديل تصنيف الصلاحيات')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (52, N'BackupDatabase.aspx', N'عمل نسخة احتياطية')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (53, N'RestoreDatabase.aspx', N'استرجاع من نسخة محفوظه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (55, N'EditProjects.aspx', N'المشاريع الجاريه')
GO
INSERT [dbo].[Tbl_Pages] ([PK_ID], [PageName], [ArabicName]) VALUES (56, N'AddEstimationItems.aspx', N'إضافة مقايسة')
GO
INSERT [dbo].[Tbl_Project] ([PK_ID], [Name], [Supervisor], [ProjectPeriodPerMonth], [StartDate], [EndDate], [DateOfReceiptOfTheSite], [TechnicalOpenDate], [ProjectCost], [IsActive]) VALUES (1, N'test', N'test', 12, CAST(0xA34F0000 AS SmallDateTime), CAST(0xA34F0000 AS SmallDateTime), CAST(0xA34F0000 AS SmallDateTime), CAST(0xA34F0000 AS SmallDateTime), 12.0000, 1)
GO
INSERT [dbo].[Tbl_Project] ([PK_ID], [Name], [Supervisor], [ProjectPeriodPerMonth], [StartDate], [EndDate], [DateOfReceiptOfTheSite], [TechnicalOpenDate], [ProjectCost], [IsActive]) VALUES (2, N'tets', N'tets', 12, CAST(0xA34F0000 AS SmallDateTime), CAST(0xA34F0000 AS SmallDateTime), CAST(0xA34F0000 AS SmallDateTime), CAST(0xA34F0000 AS SmallDateTime), 12.0000, 1)
GO
INSERT [dbo].[Tbl_Project] ([PK_ID], [Name], [Supervisor], [ProjectPeriodPerMonth], [StartDate], [EndDate], [DateOfReceiptOfTheSite], [TechnicalOpenDate], [ProjectCost], [IsActive]) VALUES (3, N'test', N'12', 12, CAST(0xA3600000 AS SmallDateTime), CAST(0xA3600000 AS SmallDateTime), CAST(0xA3600000 AS SmallDateTime), CAST(0xA3600000 AS SmallDateTime), 12.0000, 1)
GO
INSERT [dbo].[Tbl_ProjectDailyWorker] ([PK_ID], [FK_DailyWorker_ID], [FK_Project_ID]) VALUES (1, 1, 3)
GO
INSERT [dbo].[Tbl_ProjectDailyWorker] ([PK_ID], [FK_DailyWorker_ID], [FK_Project_ID]) VALUES (2, 1, 3)
GO
INSERT [dbo].[Tbl_ProjectDailyWorker] ([PK_ID], [FK_DailyWorker_ID], [FK_Project_ID]) VALUES (3, 1, 2)
GO
INSERT [dbo].[Tbl_ProjectEmployees] ([PK_ID], [FK_ProjectID], [FK_EmployeeID]) VALUES (1, 3, 1)
GO
INSERT [dbo].[Tbl_ProjectEmployees] ([PK_ID], [FK_ProjectID], [FK_EmployeeID]) VALUES (2, 2, 1)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (1, 2.0000, 1350, N'2700', 1, 1)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (2, 0.0000, 2500, N'0', 1, 2)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (3, 0.0000, 775, N'0', 1, 3)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (4, 0.0000, 200, N'0', 1, 4)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (5, 0.0000, 1560, N'0', 1, 5)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (6, 0.0000, 285, N'0', 1, 6)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (7, 0.0000, 410, N'0', 1, 7)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (8, 0.0000, 615, N'0', 1, 8)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (9, 0.0000, 115, N'0', 1, 9)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (10, 0.0000, 125, N'0', 1, 10)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (11, 0.0000, 585, N'0', 1, 11)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (12, 0.0000, 625, N'0', 1, 12)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (13, 0.0000, 45, N'0', 1, 13)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (14, 0.0000, 525, N'0', 1, 14)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (15, 0.0000, 710, N'0', 1, 15)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (16, 0.0000, 585, N'0', 1, 16)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (17, 0.0000, 37, N'0', 1, 17)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (18, 0.0000, 322, N'0', 1, 18)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (19, 0.0000, 1465, N'0', 1, 19)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (20, 0.0000, 2235, N'0', 1, 20)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (21, 0.0000, 5460, N'0', 1, 21)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (22, 0.0000, 2520, N'0', 1, 22)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (23, 0.0000, 685, N'0', 1, 23)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (24, 0.0000, 2700, N'0', 1, 24)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (25, 0.0000, 26, N'0', 1, 25)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (26, 0.0000, 7800, N'0', 1, 26)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (27, 0.0000, 900, N'0', 1, 27)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (28, 0.0000, 170, N'0', 1, 28)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (29, 0.0000, 90, N'0', 1, 29)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (30, 0.0000, 7, N'0', 1, 30)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (31, 0.0000, 1350, N'0', 1, 31)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (32, 0.0000, 30, N'0', 1, 32)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (33, 0.0000, 290, N'0', 1, 33)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (34, 0.0000, 2085, N'0', 1, 34)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (35, 0.0000, 625, N'0', 1, 35)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (36, 0.0000, 275, N'0', 1, 36)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (37, 0.0000, 105, N'0', 1, 37)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (38, 0.0000, 30, N'0', 1, 38)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (39, 0.0000, 90, N'0', 1, 39)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (40, 0.0000, 60, N'0', 1, 40)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (41, 0.0000, 12, N'0', 1, 41)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (42, 0.0000, 6, N'0', 1, 42)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (43, 0.0000, 4, N'0', 1, 43)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (44, 0.0000, 40, N'0', 1, 44)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (45, 0.0000, 60, N'0', 1, 45)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (46, 0.0000, 48, N'0', 1, 46)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (47, 0.0000, 24, N'0', 1, 47)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (48, 0.0000, 30, N'0', 1, 48)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (49, 0.0000, 240, N'0', 1, 49)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (50, 0.0000, 270, N'0', 1, 50)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (51, 0.0000, 30, N'0', 1, 51)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (52, 0.0000, 30, N'0', 1, 52)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (53, 0.0000, 30, N'0', 1, 53)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (54, 0.0000, 30, N'0', 1, 54)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (55, 0.0000, 30, N'0', 1, 55)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (56, 0.0000, 12, N'0', 1, 56)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (57, 0.0000, 6, N'0', 1, 57)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (58, 0.0000, 1, N'0', 1, 58)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (59, 0.0000, 50, N'0', 1, 59)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (60, 0.0000, 105, N'0', 1, 60)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (61, 0.0000, 210, N'0', 1, 61)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (62, 0.0000, 85, N'0', 1, 62)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (63, 0.0000, 6, N'0', 1, 63)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (64, 0.0000, 245, N'0', 1, 64)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (65, 0.0000, 7, N'0', 1, 65)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (66, 0.0000, 95, N'0', 1, 66)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (67, 0.0000, 7, N'0', 1, 67)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (68, 0.0000, 5, N'0', 1, 68)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (69, 0.0000, 1, N'0', 1, 69)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (70, 0.0000, 6, N'0', 1, 70)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (71, 0.0000, 30, N'0', 1, 71)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (72, 0.0000, 25, N'0', 1, 72)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (73, 0.0000, 1, N'0', 1, 73)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (74, 0.0000, 5, N'0', 1, 74)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (75, 0.0000, 1, N'0', 1, 75)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (76, 0.0000, 30, N'0', 1, 76)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (77, 0.0000, 1, N'0', 1, 77)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (78, 0.0000, 30, N'0', 1, 78)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (79, 0.0000, 1, N'0', 1, 79)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (80, 0.0000, 30, N'0', 1, 80)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (81, 0.0000, 1, N'0', 1, 77)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (82, 0.0000, 1, N'0', 1, 81)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (83, 0.0000, 12, N'0', 1, 82)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (84, 0.0000, 60, N'0', 1, 83)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (85, 0.0000, 22, N'0', 1, 84)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (86, 0.0000, 12, N'0', 1, 85)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (87, 0.0000, 300, N'0', 1, 86)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (88, 0.0000, 300, N'0', 1, 87)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (89, 0.0000, 60, N'0', 1, 88)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (90, 0.0000, 60, N'0', 1, 88)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (91, 0.0000, 1, N'0', 1, 88)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (92, 0.0000, 5, N'0', 1, 88)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (93, 0.0000, 1, N'0', 1, 88)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (94, 0.0000, 60, N'0', 1, 89)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (95, 0.0000, 90, N'0', 1, 90)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (96, 0.0000, 60, N'0', 1, 90)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (97, 0.0000, 30, N'0', 1, 90)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (98, 0.0000, 30, N'0', 1, 90)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (99, 0.0000, 30, N'0', 1, 91)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (100, 0.0000, 30, N'0', 1, 92)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (101, 0.0000, 1, N'0', 1, 93)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (102, 0.0000, 5, N'0', 1, 93)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (103, 0.0000, 30, N'0', 1, 94)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (104, 0.0000, 57, N'0', 1, 95)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (105, 0.0000, 30, N'0', 1, 95)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (106, 0.0000, 131, N'0', 1, 96)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (107, 0.0000, 60, N'0', 1, 97)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (108, 0.0000, 90, N'0', 1, 97)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (109, 0.0000, 300, N'0', 1, 98)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (110, 0.0000, 60, N'0', 1, 98)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (111, 0.0000, 30, N'0', 1, 99)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (112, 0.0000, 30, N'0', 1, 100)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (113, 0.0000, 60, N'0', 1, 101)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (114, 0.0000, 8, N'0', 1, 102)
GO
INSERT [dbo].[Tbl_ProjectEstimation] ([PK_ID], [Price], [Quantity], [Notes], [FK_ProjectID], [FK_EstimationItemsID]) VALUES (115, 0.0000, 8, N'0', 1, 102)
GO
INSERT [dbo].[Tbl_ProjectGuardianship] ([PK_ID], [FK_ProjectID], [FK_EmployeeID], [Date], [DateFrom], [DateTo], [Amount], [FK_SaverID], [Rest], [Surplus]) VALUES (1, 1, 1, NULL, CAST(0xA3400000 AS SmallDateTime), CAST(0xA3400000 AS SmallDateTime), 120.0000, NULL, 120.0000, 120.0000)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (1, 1, CAST(6440 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (2, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (3, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (4, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (5, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (6, 5, CAST(2500 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (7, 1, CAST(2 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (8, 5, CAST(3 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (9, 1, CAST(6440 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (10, 5, CAST(2500 AS Decimal(18, 0)), NULL, 3, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (11, 1, CAST(2 AS Decimal(18, 0)), NULL, 3, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (12, 5, CAST(3 AS Decimal(18, 0)), NULL, 3, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (13, 1, CAST(6440 AS Decimal(18, 0)), NULL, 3, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (14, 5, CAST(2500 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (15, 1, CAST(2 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (16, 5, CAST(3 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (17, 1, CAST(6440 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (18, 5, CAST(2500 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (19, 1, CAST(2 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (20, 5, CAST(3 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (21, 1, CAST(6440 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (22, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (23, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (24, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (25, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (26, 5, CAST(1350 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (27, 5, CAST(1350 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (28, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (29, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (30, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (31, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (32, 5, CAST(1350 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (33, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (34, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (35, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (36, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (37, 5, CAST(1350 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (38, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (39, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (40, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (41, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (42, 5, CAST(1350 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (43, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (44, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (45, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (46, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (47, 3, CAST(552 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (48, 5, CAST(1350 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (49, 5, CAST(2500 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (50, 1, CAST(2 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (51, 5, CAST(3 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (52, 1, CAST(6440 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (53, 1, CAST(109200 AS Decimal(18, 0)), NULL, 4, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (54, 5, CAST(1350 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (55, 5, CAST(2500 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (56, 5, CAST(3100 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (57, 1, CAST(2 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (58, 5, CAST(3 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (59, 1, CAST(625 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (60, 1, CAST(6440 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (61, 1, CAST(109200 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (62, 5, CAST(1350 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (63, 5, CAST(2500 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (64, 5, CAST(3100 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (65, 1, CAST(2 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (66, 5, CAST(3 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (67, 1, CAST(625 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (68, 1, CAST(6440 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (69, 1, CAST(109200 AS Decimal(18, 0)), NULL, 2, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (70, 5, CAST(1350 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (71, 5, CAST(2500 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (72, 5, CAST(3100 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (73, 1, CAST(2 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (74, 5, CAST(3 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (75, 1, CAST(625 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (76, 1, CAST(6440 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_ProjectSupplies] ([PK_ID], [FK_ItemsID], [QTY], [FK_ProjectEstimationItemID], [FK_ProjectID], [WasSupplied], [Rest]) VALUES (77, 1, CAST(109200 AS Decimal(18, 0)), NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (2, 1, 2, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (3, 1, 3, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (4, 1, 4, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (5, 1, 5, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (6, 1, 6, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (7, 1, 7, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (8, 1, 8, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (9, 1, 9, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (10, 1, 10, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (11, 1, 11, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (12, 1, 12, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (13, 1, 13, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (14, 1, 14, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (15, 1, 15, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (16, 1, 16, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (17, 1, 17, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (18, 1, 18, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (19, 1, 19, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (20, 1, 20, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (21, 1, 21, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (22, 1, 22, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (23, 1, 23, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (24, 1, 24, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (25, 1, 25, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (26, 1, 26, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (27, 1, 27, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (28, 1, 28, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (29, 1, 29, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (30, 1, 30, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (31, 1, 31, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (32, 1, 32, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (33, 1, 33, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (34, 1, 34, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (35, 1, 35, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (36, 1, 36, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (37, 1, 37, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (38, 1, 38, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (39, 1, 39, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (40, 1, 40, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (41, 1, 41, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (42, 1, 42, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (43, 1, 43, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (44, 1, 44, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (45, 1, 45, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (46, 1, 46, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (47, 1, 47, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (48, 1, 48, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (49, 1, 49, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (50, 1, 50, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (51, 1, 51, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (52, 1, 52, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (53, 1, 53, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (55, 1, 55, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (56, 1, 56, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (57, 2, 33, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (58, 2, 27, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (59, 2, 20, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (60, 2, 16, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (61, 2, 25, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (62, 2, 3, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (63, 2, 56, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (64, 2, 1, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (65, 2, 24, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (66, 2, 9, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (67, 2, 53, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (68, 2, 48, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (69, 2, 47, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (70, 2, 55, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (71, 2, 49, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (72, 2, 19, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (73, 2, 23, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (74, 2, 6, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (75, 2, 2, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (76, 2, 8, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (77, 2, 11, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (78, 2, 28, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (79, 2, 51, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (80, 2, 35, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (81, 2, 34, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (82, 2, 36, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (83, 2, 21, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (84, 2, 17, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (85, 2, 26, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (86, 2, 37, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (87, 2, 40, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (88, 2, 39, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (89, 2, 38, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (90, 2, 4, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (91, 2, 44, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (92, 2, 46, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (93, 2, 45, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (94, 2, 41, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (95, 2, 43, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (96, 2, 42, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (97, 2, 29, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (98, 2, 30, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (99, 2, 52, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (100, 2, 12, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (101, 2, 15, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (102, 2, 50, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (103, 2, 14, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (104, 2, 13, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (105, 2, 32, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (106, 2, 31, 0)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (107, 2, 5, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (108, 2, 22, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (109, 2, 18, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (110, 2, 10, 1)
GO
INSERT [dbo].[Tbl_RolePermissions] ([PK_ID], [FK_RoleID], [FK_PageID], [Access]) VALUES (111, 2, 7, 1)
GO
INSERT [dbo].[Tbl_Roles] ([PK_ID], [Name]) VALUES (1, N'المدير')
GO
INSERT [dbo].[Tbl_Roles] ([PK_ID], [Name]) VALUES (2, N'محدود')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (1, 1, 1, CAST(0xA2F90000 AS SmallDateTime), 1, 2500.0000, N'121')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (2, 1, 1, CAST(0xA2E60000 AS SmallDateTime), 1, 250000.0000, N'121212')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (3, 1, 1, CAST(0xA2FA0000 AS SmallDateTime), 1, 25000.0000, N'2222222')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (4, 1, 1, CAST(0xA2E60000 AS SmallDateTime), 0, 1.0000, N'121212121')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (5, 1, 1, CAST(0xA2E60000 AS SmallDateTime), 1, 25000.0000, N'kkj')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (6, 1, 1, CAST(0xA2E80000 AS SmallDateTime), 1, 2.0000, N'2')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (7, 1, 1, CAST(0xA2E50000 AS SmallDateTime), 1, 1.0000, N'1')
GO
INSERT [dbo].[Tbl_SaverAmountActions] ([PK_ID], [FK_SaverItemID], [FK_SaverID], [Date], [ActionType], [Amount], [Description]) VALUES (8, 1, 1, CAST(0xA2ED0000 AS SmallDateTime), 1, 12.0000, N'12')
GO
INSERT [dbo].[Tbl_SaverItems] ([PK_ID], [Name], [FK_SaverCategory]) VALUES (1, N'بند22', NULL)
GO
INSERT [dbo].[Tbl_Savers] ([PK_ID], [Name], [Amount]) VALUES (1, N'121212', 50266.0000)
GO
INSERT [dbo].[Tbl_Subcontractor] ([PK_ID], [Name], [Mobile], [LandLine], [Address], [FK_WorkTypeID]) VALUES (1, N'احمد حجازى', N'012            ', N'012            ', N'لال', NULL)
GO
INSERT [dbo].[Tbl_Subcontractor] ([PK_ID], [Name], [Mobile], [LandLine], [Address], [FK_WorkTypeID]) VALUES (2, N'احمد داوود', N'456454         ', N'5454           ', N'نىتحن حه', NULL)
GO
SET IDENTITY_INSERT [dbo].[Tbl_SubContractorWorks] ON 

GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (12, 2, 1)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (13, 1, 1)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (14, 2, 1)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (15, 1, 1)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (16, 1, 1)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (17, 2, 1)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (18, 3, 2)
GO
INSERT [dbo].[Tbl_SubContractorWorks] ([PK_ID], [FK_WorkID], [FK_SubContractorID]) VALUES (19, 4, 2)
GO
SET IDENTITY_INSERT [dbo].[Tbl_SubContractorWorks] OFF
GO
INSERT [dbo].[Tbl_Supplier] ([PK_ID], [Name], [Mobile], [LandLine], [Address]) VALUES (1, N'احمد عوض', N'012            ', N'12             ', N'121')
GO
INSERT [dbo].[Tbl_Supplier] ([PK_ID], [Name], [Mobile], [LandLine], [Address]) VALUES (2, N'مورد واحد', N'12             ', N'12             ', N'12')
GO
INSERT [dbo].[Tbl_Supplier] ([PK_ID], [Name], [Mobile], [LandLine], [Address]) VALUES (3, N'test', N'012            ', N'012            ', N'122')
GO
SET IDENTITY_INSERT [dbo].[Tbl_SupplierSupplies] ON 

GO
INSERT [dbo].[Tbl_SupplierSupplies] ([PK_ID], [FK_CategoryID], [FK_SupplierID]) VALUES (2, 1, 1)
GO
INSERT [dbo].[Tbl_SupplierSupplies] ([PK_ID], [FK_CategoryID], [FK_SupplierID]) VALUES (3, 3, 2)
GO
INSERT [dbo].[Tbl_SupplierSupplies] ([PK_ID], [FK_CategoryID], [FK_SupplierID]) VALUES (4, 1, 2)
GO
INSERT [dbo].[Tbl_SupplierSupplies] ([PK_ID], [FK_CategoryID], [FK_SupplierID]) VALUES (5, 4, 2)
GO
INSERT [dbo].[Tbl_SupplierSupplies] ([PK_ID], [FK_CategoryID], [FK_SupplierID]) VALUES (6, 3, 3)
GO
INSERT [dbo].[Tbl_SupplierSupplies] ([PK_ID], [FK_CategoryID], [FK_SupplierID]) VALUES (7, 2, 3)
GO
SET IDENTITY_INSERT [dbo].[Tbl_SupplierSupplies] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_WorkCategories] ON 

GO
INSERT [dbo].[Tbl_WorkCategories] ([PK_ID], [Name]) VALUES (1, N'خرسانه')
GO
INSERT [dbo].[Tbl_WorkCategories] ([PK_ID], [Name]) VALUES (2, N'محارة')
GO
SET IDENTITY_INSERT [dbo].[Tbl_WorkCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_WorkType] ON 

GO
INSERT [dbo].[Tbl_WorkType] ([PK_ID], [Name], [FK_WorkCategory]) VALUES (1, N'مسلح 250 ', 1)
GO
INSERT [dbo].[Tbl_WorkType] ([PK_ID], [Name], [FK_WorkCategory]) VALUES (2, N'مسح', 1)
GO
INSERT [dbo].[Tbl_WorkType] ([PK_ID], [Name], [FK_WorkCategory]) VALUES (3, N'بياض', 2)
GO
INSERT [dbo].[Tbl_WorkType] ([PK_ID], [Name], [FK_WorkCategory]) VALUES (4, N'نقاشة', 2)
GO
INSERT [dbo].[Tbl_WorkType] ([PK_ID], [Name], [FK_WorkCategory]) VALUES (5, N'dfsdfs', 2)
GO
SET IDENTITY_INSERT [dbo].[Tbl_WorkType] OFF
GO
ALTER TABLE [dbo].[Tbl_Project] ADD  CONSTRAINT [DF_Tbl_Project_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Tbl_CompanyExract]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_CompanyExract_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_CompanyExract] CHECK CONSTRAINT [FK_Tbl_CompanyExract_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_CompanyExractItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_CompanyExractItems_Tbl_CompanyExract] FOREIGN KEY([FK_CompanyExractID])
REFERENCES [dbo].[Tbl_CompanyExract] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_CompanyExractItems] CHECK CONSTRAINT [FK_Tbl_CompanyExractItems_Tbl_CompanyExract]
GO
ALTER TABLE [dbo].[Tbl_DailyWorkerExtract]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_DailyWorkerExtract_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_DailyWorkerExtract] CHECK CONSTRAINT [FK_Tbl_DailyWorkerExtract_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_DailyWorkerExtractItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_DailyWorkerExtractItems_Tbl_DailyWorkerExtract] FOREIGN KEY([FK_DailyWorkerExractID])
REFERENCES [dbo].[Tbl_DailyWorkerExtract] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_DailyWorkerExtractItems] CHECK CONSTRAINT [FK_Tbl_DailyWorkerExtractItems_Tbl_DailyWorkerExtract]
GO
ALTER TABLE [dbo].[Tbl_DailyWorkerTime]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_DailyWorkerTime_Tbl_ProjectDailyWorker] FOREIGN KEY([FK_ProjectDailyWorker])
REFERENCES [dbo].[Tbl_ProjectDailyWorker] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_DailyWorkerTime] CHECK CONSTRAINT [FK_Tbl_DailyWorkerTime_Tbl_ProjectDailyWorker]
GO
ALTER TABLE [dbo].[Tbl_Employees]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Employees_Tbl_Roles] FOREIGN KEY([FK_RoleID])
REFERENCES [dbo].[Tbl_Roles] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_Employees] CHECK CONSTRAINT [FK_Tbl_Employees_Tbl_Roles]
GO
ALTER TABLE [dbo].[Tbl_EquationItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_EquationItems_Tbl_EstimationItemEquations] FOREIGN KEY([FK_EstimationItemEquationID])
REFERENCES [dbo].[Tbl_EstimationItemEquations] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_EquationItems] CHECK CONSTRAINT [FK_Tbl_EquationItems_Tbl_EstimationItemEquations]
GO
ALTER TABLE [dbo].[Tbl_EquationItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_EquationItems_Tbl_Items] FOREIGN KEY([FK_ItemID])
REFERENCES [dbo].[Tbl_Items] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_EquationItems] CHECK CONSTRAINT [FK_Tbl_EquationItems_Tbl_Items]
GO
ALTER TABLE [dbo].[Tbl_EstimationItemEquations]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_EstimationItemEquations_Tbl_EstimationItems] FOREIGN KEY([FK_EstimationItemID])
REFERENCES [dbo].[Tbl_EstimationItems] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_EstimationItemEquations] CHECK CONSTRAINT [FK_Tbl_EstimationItemEquations_Tbl_EstimationItems]
GO
ALTER TABLE [dbo].[Tbl_ExpensesItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ExpensesItems_Tbl_ExpensesCategories] FOREIGN KEY([FK_ExpenseCategory])
REFERENCES [dbo].[Tbl_ExpensesCategories] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ExpensesItems] CHECK CONSTRAINT [FK_Tbl_ExpensesItems_Tbl_ExpensesCategories]
GO
ALTER TABLE [dbo].[Tbl_GuardianshipItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_GuardianshipItems_Tbl_ExpensesItems] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Tbl_ExpensesItems] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_GuardianshipItems] CHECK CONSTRAINT [FK_Tbl_GuardianshipItems_Tbl_ExpensesItems]
GO
ALTER TABLE [dbo].[Tbl_GuardianshipItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_GuardianshipItems_Tbl_ProjectGuardianship] FOREIGN KEY([FK_ProjectGuardianshipID])
REFERENCES [dbo].[Tbl_ProjectGuardianship] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_GuardianshipItems] CHECK CONSTRAINT [FK_Tbl_GuardianshipItems_Tbl_ProjectGuardianship]
GO
ALTER TABLE [dbo].[Tbl_Items]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Items_Tbl_Category] FOREIGN KEY([FK_CategoryID])
REFERENCES [dbo].[Tbl_Category] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_Items] CHECK CONSTRAINT [FK_Tbl_Items_Tbl_Category]
GO
ALTER TABLE [dbo].[Tbl_Items]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Items_Tbl_MeasurementUnit] FOREIGN KEY([FK_MeasurementUnitID])
REFERENCES [dbo].[Tbl_MeasurementUnit] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_Items] CHECK CONSTRAINT [FK_Tbl_Items_Tbl_MeasurementUnit]
GO
ALTER TABLE [dbo].[Tbl_ProjectDailyWorker]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectDailyWorker_Tbl_DailyWorker] FOREIGN KEY([FK_DailyWorker_ID])
REFERENCES [dbo].[Tbl_DailyWorker] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectDailyWorker] CHECK CONSTRAINT [FK_Tbl_ProjectDailyWorker_Tbl_DailyWorker]
GO
ALTER TABLE [dbo].[Tbl_ProjectDailyWorker]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectDailyWorker_Tbl_Project] FOREIGN KEY([FK_Project_ID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectDailyWorker] CHECK CONSTRAINT [FK_Tbl_ProjectDailyWorker_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_ProjectEmployees]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectEmployees_Tbl_Employees] FOREIGN KEY([FK_EmployeeID])
REFERENCES [dbo].[Tbl_Employees] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectEmployees] CHECK CONSTRAINT [FK_Tbl_ProjectEmployees_Tbl_Employees]
GO
ALTER TABLE [dbo].[Tbl_ProjectEmployees]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectEmployees_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectEmployees] CHECK CONSTRAINT [FK_Tbl_ProjectEmployees_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_ProjectEstimation]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectEstimation_Tbl_EstimationItems] FOREIGN KEY([FK_EstimationItemsID])
REFERENCES [dbo].[Tbl_EstimationItems] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectEstimation] CHECK CONSTRAINT [FK_Tbl_ProjectEstimation_Tbl_EstimationItems]
GO
ALTER TABLE [dbo].[Tbl_ProjectEstimation]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectEstimation_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectEstimation] CHECK CONSTRAINT [FK_Tbl_ProjectEstimation_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_ProjectGuardianship]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectGuardianship_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectGuardianship] CHECK CONSTRAINT [FK_Tbl_ProjectGuardianship_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_ProjectSaverDeposits]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectSaverDeposits_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectSaverDeposits] CHECK CONSTRAINT [FK_Tbl_ProjectSaverDeposits_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_ProjectSaverDeposits]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectSaverDeposits_Tbl_SaverItems] FOREIGN KEY([FK_SaverItemID])
REFERENCES [dbo].[Tbl_SaverItems] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectSaverDeposits] CHECK CONSTRAINT [FK_Tbl_ProjectSaverDeposits_Tbl_SaverItems]
GO
ALTER TABLE [dbo].[Tbl_ProjectSubContractor]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectSubContractor_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectSubContractor] CHECK CONSTRAINT [FK_Tbl_ProjectSubContractor_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_ProjectSubContractor]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectSubContractor_Tbl_SubContractorWorks] FOREIGN KEY([FK_SubContractorWorkID])
REFERENCES [dbo].[Tbl_SubContractorWorks] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectSubContractor] CHECK CONSTRAINT [FK_Tbl_ProjectSubContractor_Tbl_SubContractorWorks]
GO
ALTER TABLE [dbo].[Tbl_ProjectSupplies]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectSupplies_Tbl_Items] FOREIGN KEY([FK_ItemsID])
REFERENCES [dbo].[Tbl_Items] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectSupplies] CHECK CONSTRAINT [FK_Tbl_ProjectSupplies_Tbl_Items]
GO
ALTER TABLE [dbo].[Tbl_ProjectSupplies]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectSupplies_Tbl_ProjectEstimation] FOREIGN KEY([FK_ProjectEstimationItemID])
REFERENCES [dbo].[Tbl_ProjectEstimation] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_ProjectSupplies] CHECK CONSTRAINT [FK_Tbl_ProjectSupplies_Tbl_ProjectEstimation]
GO
ALTER TABLE [dbo].[Tbl_RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_RolePermissions_Tbl_Pages] FOREIGN KEY([FK_PageID])
REFERENCES [dbo].[Tbl_Pages] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_RolePermissions] CHECK CONSTRAINT [FK_Tbl_RolePermissions_Tbl_Pages]
GO
ALTER TABLE [dbo].[Tbl_RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_RolePermissions_Tbl_Roles] FOREIGN KEY([FK_RoleID])
REFERENCES [dbo].[Tbl_Roles] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_RolePermissions] CHECK CONSTRAINT [FK_Tbl_RolePermissions_Tbl_Roles]
GO
ALTER TABLE [dbo].[Tbl_SaverAmountActions]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_ProjectAmountActions_Tbl_ProjectSaverItems] FOREIGN KEY([FK_SaverItemID])
REFERENCES [dbo].[Tbl_SaverItems] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SaverAmountActions] CHECK CONSTRAINT [FK_Tbl_ProjectAmountActions_Tbl_ProjectSaverItems]
GO
ALTER TABLE [dbo].[Tbl_SaverAmountActions]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SaverAmountActions_Tbl_Savers] FOREIGN KEY([FK_SaverID])
REFERENCES [dbo].[Tbl_Savers] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SaverAmountActions] CHECK CONSTRAINT [FK_Tbl_SaverAmountActions_Tbl_Savers]
GO
ALTER TABLE [dbo].[Tbl_SaverItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SaverItems_Tbl_SaverCategory] FOREIGN KEY([FK_SaverCategory])
REFERENCES [dbo].[Tbl_SaverCategory] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SaverItems] CHECK CONSTRAINT [FK_Tbl_SaverItems_Tbl_SaverCategory]
GO
ALTER TABLE [dbo].[Tbl_SubContractorExtract]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SubContractorExract_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SubContractorExtract] CHECK CONSTRAINT [FK_Tbl_SubContractorExract_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_SubContractorExtractItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SubContractorExractItems_Tbl_SubContractorExract] FOREIGN KEY([FK_SubContractorExractID])
REFERENCES [dbo].[Tbl_SubContractorExtract] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SubContractorExtractItems] CHECK CONSTRAINT [FK_Tbl_SubContractorExractItems_Tbl_SubContractorExract]
GO
ALTER TABLE [dbo].[Tbl_SubContractorWorks]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SubContractorWorks_Tbl_Subcontractor] FOREIGN KEY([FK_SubContractorID])
REFERENCES [dbo].[Tbl_Subcontractor] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SubContractorWorks] CHECK CONSTRAINT [FK_Tbl_SubContractorWorks_Tbl_Subcontractor]
GO
ALTER TABLE [dbo].[Tbl_SubContractorWorks]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SubContractorWorks_Tbl_WorkType] FOREIGN KEY([FK_WorkID])
REFERENCES [dbo].[Tbl_WorkType] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SubContractorWorks] CHECK CONSTRAINT [FK_Tbl_SubContractorWorks_Tbl_WorkType]
GO
ALTER TABLE [dbo].[Tbl_SupplierExtract]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SupplierExtract_Tbl_Project] FOREIGN KEY([FK_ProjectID])
REFERENCES [dbo].[Tbl_Project] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SupplierExtract] CHECK CONSTRAINT [FK_Tbl_SupplierExtract_Tbl_Project]
GO
ALTER TABLE [dbo].[Tbl_SupplierExtractItems]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SupplierExtractItems_Tbl_SupplierExtract] FOREIGN KEY([FK_SupplierExractID])
REFERENCES [dbo].[Tbl_SupplierExtract] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SupplierExtractItems] CHECK CONSTRAINT [FK_Tbl_SupplierExtractItems_Tbl_SupplierExtract]
GO
ALTER TABLE [dbo].[Tbl_SupplierSupplies]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SupplierSupplies_Tbl_Supplier] FOREIGN KEY([FK_SupplierID])
REFERENCES [dbo].[Tbl_Supplier] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SupplierSupplies] CHECK CONSTRAINT [FK_Tbl_SupplierSupplies_Tbl_Supplier]
GO
ALTER TABLE [dbo].[Tbl_SuppliesEvent]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SuppliesEvent_Tbl_ProjectSupplies1] FOREIGN KEY([FK_ProjectSuppliesID])
REFERENCES [dbo].[Tbl_ProjectSupplies] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SuppliesEvent] CHECK CONSTRAINT [FK_Tbl_SuppliesEvent_Tbl_ProjectSupplies1]
GO
ALTER TABLE [dbo].[Tbl_SuppliesEvent]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_SuppliesEvent_Tbl_Supplier] FOREIGN KEY([FK_SupplierID])
REFERENCES [dbo].[Tbl_Supplier] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_SuppliesEvent] CHECK CONSTRAINT [FK_Tbl_SuppliesEvent_Tbl_Supplier]
GO
ALTER TABLE [dbo].[Tbl_WorkType]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_WorkType_Tbl_WorkCategories] FOREIGN KEY([FK_WorkCategory])
REFERENCES [dbo].[Tbl_WorkCategories] ([PK_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_WorkType] CHECK CONSTRAINT [FK_Tbl_WorkType_Tbl_WorkCategories]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subcontractor = -4, Supplier = -3, Daily Worker = -2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tbl_GuardianshipItems', @level2type=N'COLUMN',@level2name=N'PersonTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[29] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_EstimationItems"
            Begin Extent = 
               Top = 14
               Left = 540
               Bottom = 127
               Right = 758
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectEstimation"
            Begin Extent = 
               Top = 6
               Left = 264
               Bottom = 136
               Right = 467
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Tbl_EstimationItemEquations"
            Begin Extent = 
               Top = 2
               Left = 815
               Bottom = 150
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1860
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_AddedStimation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_AddedStimation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[6] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 235
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_CompanyExract"
            Begin Extent = 
               Top = 6
               Left = 293
               Bottom = 213
               Right = 481
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_CompanyExractItems"
            Begin Extent = 
               Top = 6
               Left = 519
               Bottom = 264
               Right = 720
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CompanyExtract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CompanyExtract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[35] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_ProjectSupplies"
            Begin Extent = 
               Top = 7
               Left = 2
               Bottom = 213
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Items"
            Begin Extent = 
               Top = 113
               Left = 566
               Bottom = 252
               Right = 779
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Category"
            Begin Extent = 
               Top = 60
               Left = 837
               Bottom = 168
               Right = 1007
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_SuppliesEvent"
            Begin Extent = 
               Top = 0
               Left = 316
               Bottom = 215
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 226
               Left = 295
               Bottom = 416
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Tbl_Supplier"
            Begin Extent = 
               Top = 0
               Left = 609
               Bottom = 130
               Right = 779
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Wid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailySuppliesbook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'th = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3540
         Alias = 2445
         Table = 2880
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailySuppliesbook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailySuppliesbook'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[6] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 242
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_DailyWorkerExtract"
            Begin Extent = 
               Top = 0
               Left = 365
               Bottom = 205
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_DailyWorkerExtractItems"
            Begin Extent = 
               Top = 4
               Left = 640
               Bottom = 225
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailyWorkerExract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailyWorkerExract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_DailyWorkerExtract"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailyWorkerExtractNewOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_DailyWorkerExtractNewOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[41] 3[5] 2) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Employees"
            Begin Extent = 
               Top = 143
               Left = 780
               Bottom = 375
               Right = 950
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 307
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectGuardianship"
            Begin Extent = 
               Top = 5
               Left = 288
               Bottom = 270
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_GuardianshipItems"
            Begin Extent = 
               Top = 7
               Left = 488
               Bottom = 247
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ExpensesCategories"
            Begin Extent = 
               Top = 88
               Left = 1022
               Bottom = 267
               Right = 1192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ExpensesItems"
            Begin Extent = 
               Top = 6
               Left = 764
               Bottom = 128
               Right = 961
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 31
         W' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Guradianship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'idth = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3240
         Alias = 4980
         Table = 1620
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Guradianship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Guradianship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[45] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 0
               Left = 26
               Bottom = 226
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectSubContractor"
            Begin Extent = 
               Top = 5
               Left = 277
               Bottom = 145
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Subcontractor"
            Begin Extent = 
               Top = 9
               Left = 858
               Bottom = 194
               Right = 1030
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_SubContractorWorks"
            Begin Extent = 
               Top = 2
               Left = 610
               Bottom = 134
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_WorkType"
            Begin Extent = 
               Top = 154
               Left = 297
               Bottom = 280
               Right = 480
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_WorkCategories"
            Begin Extent = 
               Top = 166
               Left = 618
               Bottom = 277
               Right = 788
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Widt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectContractor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'h = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1710
         Alias = 1980
         Table = 2385
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectContractor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectContractor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[11] 4[77] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 249
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectSaverDeposits"
            Begin Extent = 
               Top = 8
               Left = 287
               Bottom = 185
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Tbl_SaverItems"
            Begin Extent = 
               Top = 13
               Left = 602
               Bottom = 183
               Right = 785
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3045
         Alias = 3045
         Table = 3210
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectDeposits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectDeposits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[53] 4[37] 2[1] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 4
               Left = 20
               Bottom = 251
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectEstimation"
            Begin Extent = 
               Top = 68
               Left = 290
               Bottom = 255
               Right = 493
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_EstimationItems"
            Begin Extent = 
               Top = 6
               Left = 531
               Bottom = 132
               Right = 719
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectEstimation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectEstimation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[68] 4[21] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Employees"
            Begin Extent = 
               Top = 64
               Left = 444
               Bottom = 306
               Right = 614
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectGuardianship"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 314
               Right = 297
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2415
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectGurdianship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectGurdianship'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[40] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -124
         Left = -175
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectEstimation"
            Begin Extent = 
               Top = 6
               Left = 293
               Bottom = 191
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectSupplies"
            Begin Extent = 
               Top = 0
               Left = 747
               Bottom = 185
               Right = 917
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_SuppliesEvent"
            Begin Extent = 
               Top = 158
               Left = 470
               Bottom = 367
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Supplier"
            Begin Extent = 
               Top = 200
               Left = 225
               Bottom = 359
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Items"
            Begin Extent = 
               Top = 233
               Left = 676
               Bottom = 382
               Right = 889
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Category"
            Begin Extent = 
               Top = 125
               Left = 936
               Bottom = 246
               Rig' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectSuppliers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ht = 1106
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2355
         Table = 2535
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectSuppliers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectSuppliers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[6] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectEstimation"
            Begin Extent = 
               Top = 6
               Left = 293
               Bottom = 135
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_ProjectSupplies"
            Begin Extent = 
               Top = 6
               Left = 534
               Bottom = 197
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Items"
            Begin Extent = 
               Top = 138
               Left = 275
               Bottom = 267
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Category"
            Begin Extent = 
               Top = 214
               Left = 510
               Bottom = 309
               Right = 680
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectSupplies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectSupplies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectSupplies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[47] 4[9] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_ProjectDailyWorker"
            Begin Extent = 
               Top = 12
               Left = 399
               Bottom = 156
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_DailyWorker"
            Begin Extent = 
               Top = 10
               Left = 672
               Bottom = 184
               Right = 842
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 234
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectWorker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ProjectWorker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[21] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Employees"
            Begin Extent = 
               Top = 0
               Left = 45
               Bottom = 223
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Roles"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 116
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_RolePermissions"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 148
               Right = 660
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_Pages"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 137
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Security'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Security'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Security'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[58] 4[4] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_SubContractorExtract"
            Begin Extent = 
               Top = 8
               Left = 333
               Bottom = 280
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_SubContractorExtractItems"
            Begin Extent = 
               Top = 26
               Left = 615
               Bottom = 273
               Right = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SubContractorExtract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SubContractorExtract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_Subcontractor"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 189
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_WorkType"
            Begin Extent = 
               Top = 0
               Left = 362
               Bottom = 141
               Right = 522
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1740
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_subcontractorWork'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_subcontractorWork'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Tbl_WorkCategories"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 156
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_WorkType"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 175
               Right = 429
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tbl_SubContractorWorks"
            Begin Extent = 
               Top = 28
               Left = 599
               Bottom = 173
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SubContractorWorkNames'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SubContractorWorkNames'
GO
USE [master]
GO
ALTER DATABASE [ContractingSystem] SET  READ_WRITE 
GO
