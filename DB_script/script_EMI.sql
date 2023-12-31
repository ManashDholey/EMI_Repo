USE [EMI_DB]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUpdateSelectGenerateEMISchedule]    Script Date: 11-11-2023 09:52:33 ******/
DROP PROCEDURE [dbo].[SP_InsertUpdateSelectGenerateEMISchedule]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUpdateSelectEMI_Plan]    Script Date: 11-11-2023 09:52:33 ******/
DROP PROCEDURE [dbo].[SP_InsertUpdateSelectEMI_Plan]
GO
ALTER TABLE [dbo].[GenerateEMISchedule] DROP CONSTRAINT [DF__GenerateE__LoanD__412EB0B6]
GO
/****** Object:  Table [dbo].[GenerateEMISchedule]    Script Date: 11-11-2023 09:52:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GenerateEMISchedule]') AND type in (N'U'))
DROP TABLE [dbo].[GenerateEMISchedule]
GO
/****** Object:  Table [dbo].[EmiPlanMaster]    Script Date: 11-11-2023 09:52:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmiPlanMaster]') AND type in (N'U'))
DROP TABLE [dbo].[EmiPlanMaster]
GO
USE [master]
GO
/****** Object:  Database [EMI_DB]    Script Date: 11-11-2023 09:52:33 ******/
DROP DATABASE [EMI_DB]
GO
/****** Object:  Database [EMI_DB]    Script Date: 11-11-2023 09:52:33 ******/
CREATE DATABASE [EMI_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EMI_DB', FILENAME = N'F:\InstallAllProgram\MSSQL16.MSSQLSERVER\MSSQL\DATA\EMI_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EMI_DB_log', FILENAME = N'F:\InstallAllProgram\MSSQL16.MSSQLSERVER\MSSQL\DATA\EMI_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EMI_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EMI_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EMI_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EMI_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EMI_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EMI_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EMI_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EMI_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EMI_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EMI_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EMI_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EMI_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EMI_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EMI_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EMI_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EMI_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EMI_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EMI_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EMI_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EMI_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EMI_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EMI_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EMI_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EMI_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [EMI_DB] SET  MULTI_USER 
GO
ALTER DATABASE [EMI_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EMI_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EMI_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EMI_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EMI_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EMI_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'EMI_DB', N'ON'
GO
ALTER DATABASE [EMI_DB] SET QUERY_STORE = ON
GO
ALTER DATABASE [EMI_DB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EMI_DB]
GO
/****** Object:  Table [dbo].[EmiPlanMaster]    Script Date: 11-11-2023 09:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmiPlanMaster](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PlanName] [varchar](250) NOT NULL,
	[Status] [bit] NOT NULL,
	[Tenure] [int] NULL,
	[ROI] [varchar](25) NULL,
 CONSTRAINT [PK_EmiPlanMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GenerateEMISchedule]    Script Date: 11-11-2023 09:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenerateEMISchedule](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmiPlanMasterId] [bigint] NULL,
	[LoanAmount] [decimal](18, 2) NOT NULL,
	[Status] [bit] NOT NULL,
	[LoanDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[EmiAmount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_GenerateEMISchedule] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EmiPlanMaster] ON 

INSERT [dbo].[EmiPlanMaster] ([Id], [PlanName], [Status], [Tenure], [ROI]) VALUES (1, N'Personal Loan', 1, 12, N'12')
INSERT [dbo].[EmiPlanMaster] ([Id], [PlanName], [Status], [Tenure], [ROI]) VALUES (2, N'Personal Loan', 1, 24, N'12')
SET IDENTITY_INSERT [dbo].[EmiPlanMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[GenerateEMISchedule] ON 

INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (1, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (2, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-12-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (3, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-01-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (4, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-02-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (5, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-03-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (6, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-04-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (7, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-05-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (8, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-06-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (9, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-07-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (10, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-08-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (11, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-09-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (12, 1, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(1400.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (13, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (14, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-12-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (15, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-01-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (16, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-02-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (17, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-03-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (18, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-04-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (19, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-05-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (20, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-06-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (21, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-07-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (22, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-08-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (23, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-09-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (24, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (25, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-11-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (26, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-12-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (27, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-01-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (28, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-02-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (29, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-03-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (30, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-04-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (31, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-05-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (32, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (33, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-07-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (34, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-08-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (35, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-09-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (36, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-10-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (37, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (38, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-12-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (39, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-01-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (40, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-02-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (41, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-03-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (42, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-04-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (43, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-05-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (44, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-06-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (45, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-07-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (46, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-08-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (47, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-09-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (48, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (49, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-11-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (50, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-12-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (51, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-01-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (52, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-02-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (53, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-03-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (54, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-04-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (55, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-05-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (56, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (57, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-07-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (58, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-08-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (59, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-09-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (60, 2, CAST(15000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-10-04T00:00:00.000' AS DateTime), CAST(700.00 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (61, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (62, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2023-12-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (63, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-01-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (64, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-02-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (65, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-03-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (66, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-04-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (67, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-05-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (68, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-06-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (69, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-07-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (70, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-08-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (71, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-09-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (72, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (73, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-11-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (74, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2024-12-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (75, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-01-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (76, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-02-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (77, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-03-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (78, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-04-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (79, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-05-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (80, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (81, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-07-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (82, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-08-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (83, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-09-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
INSERT [dbo].[GenerateEMISchedule] ([Id], [EmiPlanMasterId], [LoanAmount], [Status], [LoanDate], [DueDate], [EmiAmount]) VALUES (84, 2, CAST(16000.00 AS Decimal(18, 2)), 1, CAST(N'2023-11-04T00:00:00.000' AS DateTime), CAST(N'2025-10-04T00:00:00.000' AS DateTime), CAST(746.67 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[GenerateEMISchedule] OFF
GO
ALTER TABLE [dbo].[GenerateEMISchedule] ADD  DEFAULT (getdate()) FOR [LoanDate]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUpdateSelectEMI_Plan]    Script Date: 11-11-2023 09:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertUpdateSelectEMI_Plan]    
   @id INTEGER=null,    
   @PlanName VARCHAR(250)=null,    
   @Status BIT=null,  
   @Tenure int=null,
   @ROI VARCHAR(25)=null,
   @StatementType nvarchar(20) = ''    
AS    
BEGIN    
BEGIN TRY  
IF @StatementType = 'Insert'    
BEGIN  
  IF NOT EXISTS (SELECT 1 FROM [dbo].[EmiPlanMaster] WHERE [PlanName] =@PlanName AND Tenure=@Tenure) 
   BEGIN
    INSERT INTO [dbo].[EmiPlanMaster]
           ([PlanName]
           ,[Status]
           ,[Tenure]
           ,[ROI])
     VALUES
           (@PlanName
           ,1
           ,@Tenure
           ,@ROI)

   END
END    
IF @StatementType = 'Select'    
BEGIN   
   IF(@id IS NULL)
    BEGIN 
	   SELECT [Id]
      ,[PlanName]
      ,[Status]
      ,[Tenure]
      ,[ROI]
  FROM [dbo].[EmiPlanMaster] WHERE  Status=1
	END
   ELSE
      BEGIN 
	      SELECT [Id]
      ,[PlanName]
      ,[Status]
      ,[Tenure]
      ,[ROI]
  FROM [dbo].[EmiPlanMaster]
  WHERE Id=@id and Status=1

	  END

END    
IF @StatementType = 'Update'    
BEGIN    
UPDATE [dbo].[EmiPlanMaster]
   SET [PlanName] = @PlanName
      ,[Status] = @Status
      ,[Tenure] = @Tenure
      ,[ROI] = @ROI
 WHERE Id = @id    
END    
END TRY    
BEGIN CATCH    
  
 DECLARE @ErrorNumber INT ,@ErrorState INT,@ErrorSeverity INT ,@ErrorLine INT,@ErrorProcedure VARCHAR(MAX),@ErrorMessage VARCHAR(MAX),@SUSER_SNAME NVARCHAR(256)  
SELECT @ErrorNumber= ERROR_NUMBER(),@ErrorState=ERROR_STATE(),@ErrorSeverity=ERROR_SEVERITY(),@ErrorLine=  ERROR_LINE(),@ErrorProcedure=ERROR_PROCEDURE(),@ErrorMessage=ERROR_MESSAGE(),@SUSER_SNAME=SUSER_SNAME()  
   SELECT @ErrorMessage  
   
END CATCH  
end 
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUpdateSelectGenerateEMISchedule]    Script Date: 11-11-2023 09:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertUpdateSelectGenerateEMISchedule]    
   @id INTEGER=null,    
   @EmiPlanMasterId BIGINT=null,    
   @Status BIT=null,  
   @LoanMount decimal(18,2)=null,
   @EmiAmount decimal(18,2)=null,
   @LoanDate DATETIME=null,
   @DueDate DATETIME=null,
   @StatementType nvarchar(20) = ''    
AS    
BEGIN    
BEGIN TRY  
IF @StatementType = 'Insert'    
BEGIN  
  
   INSERT INTO [dbo].[GenerateEMISchedule]
           ([EmiPlanMasterId]
           ,[LoanAmount]
           ,[Status]
           ,[LoanDate]
           ,[EmiAmount]
		   ,[DueDate])
     VALUES
           (@EmiPlanMasterId
           ,@LoanMount
           ,@Status
           ,@LoanDate
           ,@EmiAmount
		   ,@DueDate)

  
END    
IF @StatementType = 'Select'    
BEGIN   
   IF(@id IS NULL)
    BEGIN 
	   SELECT [Id]
      ,[EmiPlanMasterId]
      ,[LoanAmount]
      ,[Status]
      ,[LoanDate]
      ,[EmiAmount]
	  ,[DueDate]
  FROM [dbo].[GenerateEMISchedule] WHERE Status=1 AND EmiPlanMasterId=@EmiPlanMasterId
	END
   ELSE
      BEGIN 
	      SELECT [Id]
      ,[EmiPlanMasterId]
      ,[LoanAmount]
      ,[Status]
      ,[LoanDate]
      ,[EmiAmount]
	  ,[DueDate]
  FROM [dbo].[GenerateEMISchedule]
  WHERE Id=@id AND Status=1 AND EmiPlanMasterId=@EmiPlanMasterId AND LoanAmount=@LoanMount

	  END

END    
IF @StatementType = 'Update'    
BEGIN    
UPDATE [dbo].[GenerateEMISchedule]
   SET [EmiPlanMasterId] = @EmiPlanMasterId
      ,[LoanAmount] = @LoanMount
      ,[Status] = @Status
      ,[LoanDate] = @LoanDate
      ,[EmiAmount] = @EmiAmount
	  ,[DueDate]=@DueDate
 WHERE Id = @id    
END    
END TRY    
BEGIN CATCH    
  
 DECLARE @ErrorNumber INT ,@ErrorState INT,@ErrorSeverity INT ,@ErrorLine INT,@ErrorProcedure VARCHAR(MAX),@ErrorMessage VARCHAR(MAX),@SUSER_SNAME NVARCHAR(256)  
SELECT @ErrorNumber= ERROR_NUMBER(),@ErrorState=ERROR_STATE(),@ErrorSeverity=ERROR_SEVERITY(),@ErrorLine=  ERROR_LINE(),@ErrorProcedure=ERROR_PROCEDURE(),@ErrorMessage=ERROR_MESSAGE(),@SUSER_SNAME=SUSER_SNAME()  
   SELECT @ErrorMessage  
   
END CATCH  
end 
GO
USE [master]
GO
ALTER DATABASE [EMI_DB] SET  READ_WRITE 
GO
