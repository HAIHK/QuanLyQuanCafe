USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 31/8/2022 10:19:42 AM ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE = OFF
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL
RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) 
SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208)
SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1
WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) 
BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE 
SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END
SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[DisplayName] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([DisplayName], [UserName], [PassWord], [Type]) VALUES (N'J', N'HK', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([DisplayName], [UserName], [PassWord], [Type]) VALUES (N'J', N'HK1', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([DisplayName], [UserName], [PassWord], [Type]) VALUES (N'JJ', N'HKA', N'1962026656160185351301320480154111117132155', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (43, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 123, 1, 0, 150000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (44, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 132, 1, 10, 90000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (45, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 133, 1, 50, 524999)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (46, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 142, 1, 50, 205000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (47, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 127, 1, 50, 180000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (48, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 126, 1, 50, 30000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (49, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 128, 1, 50, 7500)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (50, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 135, 1, 100, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (51, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 122, 1, 100, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (52, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 127, 1, 100, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (53, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 128, 1, 100, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (54, CAST(N'2022-08-30' AS Date), NULL, 132, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (55, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 122, 1, 0, 185000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (56, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 133, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (57, CAST(N'2022-08-30' AS Date), NULL, 130, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (58, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 127, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (59, CAST(N'2022-08-30' AS Date), NULL, 131, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (60, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 133, 1, 0, 170000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (61, CAST(N'2022-08-30' AS Date), NULL, 137, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (62, CAST(N'2022-08-30' AS Date), NULL, 137, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (63, CAST(N'2022-08-30' AS Date), NULL, 141, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (64, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 128, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (65, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 128, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (66, CAST(N'2022-08-30' AS Date), NULL, 136, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (67, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 133, 1, 0, 87000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (68, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 129, 1, 0, 185000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (69, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 142, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (70, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 134, 1, 0, 170000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (71, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 129, 1, 0, 147000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (72, CAST(N'2022-08-30' AS Date), NULL, 123, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (73, CAST(N'2022-08-30' AS Date), NULL, 128, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (74, CAST(N'2022-08-30' AS Date), NULL, 133, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (75, CAST(N'2022-08-30' AS Date), NULL, 134, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (76, CAST(N'2022-08-30' AS Date), NULL, 135, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (77, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 126, 1, 0, 222000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (78, CAST(N'2022-08-30' AS Date), NULL, 122, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (79, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 129, 1, 0, 230000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (80, CAST(N'2022-08-30' AS Date), CAST(N'2022-08-30' AS Date), 127, 1, 0, 150000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (81, CAST(N'2022-08-30' AS Date), NULL, 129, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (82, CAST(N'2022-08-30' AS Date), NULL, 126, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (83, CAST(N'2022-08-30' AS Date), NULL, 124, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (84, CAST(N'2022-08-30' AS Date), NULL, 138, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (85, CAST(N'2022-08-30' AS Date), NULL, 127, 0, NULL, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (86, CAST(N'2022-08-30' AS Date), NULL, 125, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (42, 47, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (43, 46, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (44, 46, 30, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (45, 44, 30, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (46, 45, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (47, 45, 33, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (48, 50, 33, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (49, 48, 31, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (50, 49, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (51, 51, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (52, 52, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (53, 53, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (57, 64, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (58, 60, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (59, 60, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (60, 69, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (61, 70, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (62, 70, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (63, 68, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (64, 68, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (65, 68, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (66, 67, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (67, 67, 35, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (68, 67, 31, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (69, 43, 31, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (70, 43, 32, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (71, 43, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (72, 71, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (73, 71, 35, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (74, 71, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (75, 55, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (76, 55, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (77, 55, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (78, 77, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (79, 77, 35, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (80, 77, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (81, 77, 32, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (82, 79, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (83, 79, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (84, 79, 31, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (85, 80, 31, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (86, 80, 32, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (87, 80, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (88, 85, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (89, 85, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (90, 85, 34, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (91, 85, 35, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (92, 72, 35, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (93, 72, 34, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (94, 72, 31, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (95, 72, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (96, 75, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (97, 84, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (98, 84, 30, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (99, 86, 29, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (100, 86, 30, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (29, N'Mực một nắng sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (30, N'Nghiêu hấp sả', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (31, N'Dê nướng sữa', 2, 60000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (32, N'Heo rừng nướng muối ớt', 3, 75000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (33, N'Cơm chiên mushi', 4, 999999)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (34, N'7Up', 5, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (35, N'Cafe', 5, 12000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Hải sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Nông sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Lâm sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Sản sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Nước')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (122, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (123, N'Bàn 1', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (124, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (125, N'Bàn 3', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (126, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (127, N'Bàn 5', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (128, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (129, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (130, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (131, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (132, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (133, N'Bàn 11', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (134, N'Bàn 12', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (135, N'Bàn 13', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (136, N'Bàn 14', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (137, N'Bàn 15', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (138, N'Bàn 16', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (139, N'Bàn 17', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (140, N'Bàn 18', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (141, N'Bàn 19', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (142, N'Bàn 20', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Hk') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa dặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin
	select t.name as [Tên bàn], b.totalPrice as [Tổng tiền], DatecheckIn as [Ngày vào], DatecheckOut as [Ngày ra], discount as [Giảm giá]
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1 and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDateAndPage]
@checkIn date,  @checkOut date, @page int
as
begin	
	declare @pageRows int = 10
	declare @selectRows int = @pageRows 
	declare @exceptRows int = (@page - 1) * @pageRows
	
	;with BillShow as (select b.id, t.name as [Tên bàn], b.totalPrice as [Tổng tiền], DatecheckIn as [Ngày vào], DatecheckOut as [Ngày ra], discount as [Giảm giá]
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1 and t.id = b.idTable)

	select top (@selectRows) * from BillShow where id not in ( select top (@exceptRows) id from BillShow)
	
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateForReport]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetListBillByDateForReport]
@checkIn date, @checkOut date
as
begin
	select t.name , b.totalPrice , DatecheckIn , DatecheckOut , discount
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1 and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
as
begin
	select count (*)
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1 and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetTableList]
as select * from dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertBill]
@idTable int
as
begin
	insert dbo.Bill
		(DateCheckIn,
		DateCheckOut,
		idTable,
		status,
		discount)
	values ( GETDATE(),
			null,
			@idTable,
			0,
			0)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertBillInfo]
@idBill int, @idFood int, @count int
as
begin

	declare @isExitsBillInfo int
	declare @foodCount int = 1

	select @isExitsBillInfo = id, @foodCount = count from dbo.BillInfo where idBill = @idBill and idFood = @idFood 

	if(@isExitsBillInfo > 0)
	begin
		declare @newCount int = @foodCount + @count
		if(@newCount > 0)
			update dbo.BillInfo set count = @foodCount + @count where idFood = @idFood
		else
			delete dbo.BillInfo where idBill = @idBill and idFood = @idFood
	end
	else
	begin
			insert dbo.BillInfo
				   (idBill , idFood , count)
			values (@idBill,
					@idFood,
					@count)
	end	
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login]
@userName nvarchar(100) , @passWord nvarchar (100)
as
begin
	select * from dbo.Account where UserName = @userName and PassWord = @passWord
end
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_SwitchTable]
@idTable1 int, @idTable2 int
as begin
 
	declare @idFirstBill int
	declare @idSeconrdBill int

	declare @isFirstTablEmty int = 1
	declare @isSecondTablEmty int = 1

	select @idSeconrdBill = id from dbo.Bill where idTable = @idTable2 and status = 0
	select @idFirstBill = id from dbo.Bill where idTable = @idTable1 and status = 0



	if (@idFirstBill is null)
	begin
        insert dbo.Bill
				( DateCheckIn,
                  DateCheckOut,
                  idTable,
                  status
				)
		values(GETDATE(),
                  null,
                  @idTable1,
                  0
                )


        select @idFirstBill = MAX(id) from dbo.Bill where idTable = @idTable1 and status = 0

		end

		select @isFirstTablEmty = COUNT (*) from dbo.BillInfo where idBill = @idFirstBill



        if (@idSeconrdBill is null)
    begin
        insert dbo.Bill
                (DateCheckIn,
                  DateCheckOut,
                  idTable,
                  status
                )

            values(GETDATE(),
                      null,
                      @idTable2,
                      0
                    )

        select @idSeconrdBill = MAX(id) from dbo.Bill where idTable = @idTable2 and status = 0

	end

		select @isSecondTablEmty = COUNT (*) from dbo.BillInfo where idBill = @idSeconrdBill


        select id into IDBillInfoTable from dbo.BillInfo where idBill = @idSeconrdBill


        update dbo.BillInfo set idBill = @idSeconrdBill where idBill = @idFirstBill


        update dbo.BillInfo set idBill = @idFirstBill where id in (select* from IDBillInfoTable)


        drop table IDBillInfoTable

		if(@isFirstTablEmty = 0)
			update dbo.TableFood set status = N'Trống' where id = @idTable2
	
		if(@isSecondTablEmty = 0)

            update dbo.TableFood set status = N'Trống' where id = @idTable1
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 31/8/2022 10:19:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[USP_UpdateAccount]
@userName nvarchar(100), @displayName nvarchar(100), @password nvarchar(100), @newPassword nvarchar(100)
as
begin
	declare @isRightPass int = 0

	select @isRightPass = count (*) from dbo.Account where UserName = @userName and PassWord = @password

	if(@isRightPass = 1)
	begin
		if(@newPassword = null or @newPassword = '')
		begin 
			update dbo.Account set DisplayName = @displayName where UserName = @userName
			end
			else
				update dbo.Account set DisplayName = @displayName, PassWord = @newPassword where UserName = @userName
			end
end
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO
