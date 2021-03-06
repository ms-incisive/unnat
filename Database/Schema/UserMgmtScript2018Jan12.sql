USE [master]
GO
/****** Object:  Database [TestDB]    Script Date: 1/12/2018 5:16:04 PM ******/
CREATE DATABASE [TestDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDB', FILENAME = N'D:\DB_Files\TestDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestDB_log', FILENAME = N'E:\Log_Files\TestDB_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TestDB] SET  MULTI_USER 
GO
ALTER DATABASE [TestDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TestDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestDB', N'ON'
GO
USE [TestDB]
GO
/****** Object:  Schema [Alert]    Script Date: 1/12/2018 5:16:04 PM ******/
CREATE SCHEMA [Alert]
GO
/****** Object:  Schema [User]    Script Date: 1/12/2018 5:16:04 PM ******/
CREATE SCHEMA [User]
GO
/****** Object:  Table [Alert].[NotificationType]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Alert].[NotificationType](
	[NotificationTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[NotificationName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NotificationType] PRIMARY KEY CLUSTERED 
(
	[NotificationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Alert].[Notify]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Alert].[Notify](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[NotificationTypeId] [tinyint] NOT NULL,
	[Title] [nvarchar](1000) NULL,
	[Description] [nvarchar](1000) NULL,
	[CreatedDate] [datetime] NULL,
	[ExternalLink] [nvarchar](1000) NULL,
	[ExpiryDate] [datetime] NULL,
	[TriggerOn] [datetime] NULL,
	[Uri] [nchar](10) NULL,
 CONSTRAINT [PK_Notify] PRIMARY KEY CLUSTERED 
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Alert].[UserNotification]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Alert].[UserNotification](
	[UserNotificationId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[NotificationId] [int] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
 CONSTRAINT [PK_UserNotification] PRIMARY KEY CLUSTERED 
(
	[UserNotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[ParentCategoryId] [int] NOT NULL,
	[CategoryType] [nvarchar](50) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[IsParent] [bit] NOT NULL,
	[Depth] [tinyint] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[Credential]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[Credential](
	[CredentialId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](300) NOT NULL,
	[PIN] [smallint] NULL,
	[PasswordSalt] [nvarchar](100) NULL,
	[PasswordHash] [nvarchar](100) NULL,
	[Email] [nvarchar](200) NOT NULL,
	[IsIntruder] [bit] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLDAPUser] [bit] NULL,
	[PasswordPolicyID] [tinyint] NOT NULL,
	[AccessFailedCount] [tinyint] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LastLoginDate] [datetime] NULL,
	[LastPasswordChangedDate] [datetime] NULL,
	[LastBlockedDate] [datetime] NULL,
 CONSTRAINT [PK_Credential] PRIMARY KEY CLUSTERED 
(
	[CredentialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[PasswordPolicy]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[PasswordPolicy](
	[PasswordPolicyId] [tinyint] IDENTITY(1,1) NOT NULL,
	[MinimumPasswordAge] [smallint] NULL,
	[MaximumPasswordAge] [smallint] NULL,
	[MinimumPasswordLength] [tinyint] NOT NULL,
	[MaxPasswordLength] [tinyint] NOT NULL,
	[MinUppercaseCharacter] [tinyint] NOT NULL,
	[MinLowercaseCharacter] [tinyint] NOT NULL,
	[MinSpecialCharacter] [tinyint] NOT NULL,
	[PasswordExpiryDate] [datetime] NULL,
	[IsPasswordExpired] [bit] NOT NULL,
	[AddedBy] [nvarchar](256) NULL,
	[UpdatedBy] [nvarchar](256) NULL,
	[DeletedBy] [nvarchar](256) NULL,
	[AddedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[DeletedOn] [datetime] NULL,
 CONSTRAINT [PK_PasswordPolicy] PRIMARY KEY CLUSTERED 
(
	[PasswordPolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[Profile]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[Profile](
	[ProfileId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Email] [varchar](200) NOT NULL,
	[FirstName] [nvarchar](200) NOT NULL,
	[MiddleName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NOT NULL,
	[ContactNo] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedOn] [datetime2](3) NOT NULL,
	[CreatedBy] [nvarchar](200) NOT NULL,
	[EditedOn] [datetime2](7) NULL,
	[EditedBy] [nvarchar](200) NULL,
	[Designation] [nvarchar](100) NULL,
	[Department] [nvarchar](100) NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[ProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[ResourcePool]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[ResourcePool](
	[ResourcePoolId] [uniqueidentifier] NOT NULL,
	[ResourceName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ResourcePool] PRIMARY KEY CLUSTERED 
(
	[ResourcePoolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[ResourcePoolRole]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[ResourcePoolRole](
	[ResourceRoleId] [int] IDENTITY(1,1) NOT NULL,
	[ResourcePoolId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[CanView] [bit] NOT NULL,
	[CanEdit] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
	[CanApprove] [bit] NOT NULL,
	[CanPrint] [bit] NOT NULL,
 CONSTRAINT [PK_ResourcePoolRole] PRIMARY KEY CLUSTERED 
(
	[ResourceRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[Roles]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[Roles](
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[Session]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[Session](
	[LogId] [bigint] IDENTITY(1,1) NOT NULL,
	[CredentialId] [int] NOT NULL,
	[DeviceType] [nvarchar](100) NULL,
	[DeviceModel] [nvarchar](100) NULL,
	[BrowserName] [nvarchar](100) NULL,
	[LoggedOn] [datetime2](7) NULL,
	[LoggedOut] [datetime2](7) NULL,
	[IpAddress] [nvarchar](50) NULL,
	[SessionId] [nvarchar](300) NOT NULL,
	[AppIdentifier] [nvarchar](100) NULL,
	[ActiveUrl] [nvarchar](300) NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [User].[UserRole]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [User].[UserRole](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAllEmployeeOfADepartment]    Script Date: 1/12/2018 5:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_GetAllEmployeeOfADepartment](@DeptID AS INT) 
RETURNS TABLE
AS
RETURN
   (
   SELECT * FROM Employee E
   WHERE E.DepartmentID = @DeptID
   )

GO
SET IDENTITY_INSERT [Alert].[NotificationType] ON 

INSERT [Alert].[NotificationType] ([NotificationTypeId], [NotificationName]) VALUES (1, N'Bell')
INSERT [Alert].[NotificationType] ([NotificationTypeId], [NotificationName]) VALUES (2, N'Message')
INSERT [Alert].[NotificationType] ([NotificationTypeId], [NotificationName]) VALUES (3, N'Email')
INSERT [Alert].[NotificationType] ([NotificationTypeId], [NotificationName]) VALUES (4, N'SMS')
SET IDENTITY_INSERT [Alert].[NotificationType] OFF
SET IDENTITY_INSERT [Alert].[Notify] ON 

INSERT [Alert].[Notify] ([NotificationId], [NotificationTypeId], [Title], [Description], [CreatedDate], [ExternalLink], [ExpiryDate], [TriggerOn], [Uri]) VALUES (1, 1, N'Registered New User', N'New Employee registered into system', CAST(N'2018-01-11T17:27:21.770' AS DateTime), N'', CAST(N'2018-01-11T17:27:21.770' AS DateTime), CAST(N'2018-01-11T17:27:21.770' AS DateTime), N'          ')
INSERT [Alert].[Notify] ([NotificationId], [NotificationTypeId], [Title], [Description], [CreatedDate], [ExternalLink], [ExpiryDate], [TriggerOn], [Uri]) VALUES (2, 3, N'Circular', N'Circular for all employees', CAST(N'2018-01-11T17:28:21.093' AS DateTime), N'', CAST(N'2018-01-11T17:28:21.093' AS DateTime), CAST(N'2018-01-11T17:28:21.093' AS DateTime), N'          ')
SET IDENTITY_INSERT [Alert].[Notify] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [ParentCategoryId], [CategoryType], [CategoryName], [IsParent], [Depth]) VALUES (1, 1, N'Notification', N'Bell', 1, 0)
INSERT [dbo].[Category] ([CategoryId], [ParentCategoryId], [CategoryType], [CategoryName], [IsParent], [Depth]) VALUES (2, 1, N'Notification', N'E-Mail', 0, 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [User].[Credential] ON 

INSERT [User].[Credential] ([CredentialId], [UserId], [UserName], [Password], [PIN], [PasswordSalt], [PasswordHash], [Email], [IsIntruder], [IsApproved], [IsLDAPUser], [PasswordPolicyID], [AccessFailedCount], [TwoFactorEnabled], [LastLoginDate], [LastPasswordChangedDate], [LastBlockedDate]) VALUES (1, N'909782ab-d09f-4c18-b228-802410fd5888', N'Stefen', N'********', 1234, N'#@#$2saf', N'41234=%d', N'stefen@yopmail.com', 0, 1, 0, 1, 0, 0, CAST(N'2018-01-11T17:33:38.093' AS DateTime), CAST(N'2018-01-11T17:33:38.093' AS DateTime), NULL)
INSERT [User].[Credential] ([CredentialId], [UserId], [UserName], [Password], [PIN], [PasswordSalt], [PasswordHash], [Email], [IsIntruder], [IsApproved], [IsLDAPUser], [PasswordPolicyID], [AccessFailedCount], [TwoFactorEnabled], [LastLoginDate], [LastPasswordChangedDate], [LastBlockedDate]) VALUES (2, N'6fecd992-d977-431c-abfe-3d34bb64e8dc', N'Olwen', N'********', 1024, N'34#@#$2saf', N'ACS4^1234=%d', N'olwen@yopmail.com', 0, 1, 0, 2, 0, 0, CAST(N'2018-01-11T17:36:21.170' AS DateTime), CAST(N'2018-01-11T17:36:21.170' AS DateTime), NULL)
SET IDENTITY_INSERT [User].[Credential] OFF
SET IDENTITY_INSERT [User].[PasswordPolicy] ON 

INSERT [User].[PasswordPolicy] ([PasswordPolicyId], [MinimumPasswordAge], [MaximumPasswordAge], [MinimumPasswordLength], [MaxPasswordLength], [MinUppercaseCharacter], [MinLowercaseCharacter], [MinSpecialCharacter], [PasswordExpiryDate], [IsPasswordExpired], [AddedBy], [UpdatedBy], [DeletedBy], [AddedOn], [UpdatedOn], [DeletedOn]) VALUES (1, 60, 365, 8, 15, 1, 2, 1, CAST(N'2018-01-11T17:37:52.907' AS DateTime), 0, N'Admin', N'', N'', CAST(N'2018-01-11T17:37:52.907' AS DateTime), NULL, NULL)
INSERT [User].[PasswordPolicy] ([PasswordPolicyId], [MinimumPasswordAge], [MaximumPasswordAge], [MinimumPasswordLength], [MaxPasswordLength], [MinUppercaseCharacter], [MinLowercaseCharacter], [MinSpecialCharacter], [PasswordExpiryDate], [IsPasswordExpired], [AddedBy], [UpdatedBy], [DeletedBy], [AddedOn], [UpdatedOn], [DeletedOn]) VALUES (2, 365, 500, 10, 20, 2, 5, 3, CAST(N'2018-01-11T17:38:52.590' AS DateTime), 0, N'Admin', N'', N'', CAST(N'2018-01-11T17:38:52.590' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [User].[PasswordPolicy] OFF
SET IDENTITY_INSERT [User].[Profile] ON 

INSERT [User].[Profile] ([ProfileId], [UserId], [Email], [FirstName], [MiddleName], [LastName], [ContactNo], [IsActive], [IsDeleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy], [Designation], [Department]) VALUES (1, N'909782ab-d09f-4c18-b228-802410fd5888', N'stefen@yopmail.com', N'Stefen', N'Junior', N'Cook', N'+180330293', 1, 0, CAST(N'2018-01-11T17:30:41.3870000' AS DateTime2), N'Admin', CAST(N'2018-01-11T17:30:41.3873861' AS DateTime2), N'', N'Admin', N'Administration')
INSERT [User].[Profile] ([ProfileId], [UserId], [Email], [FirstName], [MiddleName], [LastName], [ContactNo], [IsActive], [IsDeleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy], [Designation], [Department]) VALUES (2, N'6fecd992-d977-431c-abfe-3d34bb64e8dc', N'Olwen@yopmail.com', N'Olwen', N'Mark', N'Kano', N'+52080330293', 1, 0, CAST(N'2018-01-11T17:35:36.6530000' AS DateTime2), N'Admin', CAST(N'2018-01-11T17:35:36.6526465' AS DateTime2), N'', N'Admin', N'Teller')
SET IDENTITY_INSERT [User].[Profile] OFF
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'c2681f28-e699-4d57-840e-00eef44b9544', N'Batch Entry')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'84e74cb1-9461-4980-a69b-0a70e519b7e2', N'Disbursement')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'79d65210-f162-4b64-9a5c-113da5056111', N'AccountOpening')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'7335923c-8c6e-4a53-af8a-1777416abf30', N'Loan Directory')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'd501a9b3-5363-4a60-b711-21bfc52071cf', N'AccountEdit')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'f4159b2d-58ad-419e-8cbe-3cab26a6a237', N'ChequePrint')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'5e17bf14-1fb3-4797-96e0-414d595d7830', N'Payment')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'1d82f8dd-ab34-44f6-bd4d-7ecc6d039835', N'Voucher Entry')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'5dff01a4-b64c-4e58-ba12-89be07effbc5', N'ChequeInventory')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'593328bc-4be7-4dfe-b82f-a0087e633545', N'Fast Entry')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'b70ffa36-b79e-44cd-a37e-aaf9c78175fa', N'FixedDeposit')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'de33e051-2189-4f62-8a2c-b59d36c72c4c', N'Recurring Deposit')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'602573f6-a4d9-485d-a3f2-df0733c91f78', N'Configuration')
INSERT [User].[ResourcePool] ([ResourcePoolId], [ResourceName]) VALUES (N'30fac222-c6f5-4b31-95e0-f6d3308f83e8', N'Daily Operation')
SET IDENTITY_INSERT [User].[ResourcePoolRole] ON 

INSERT [User].[ResourcePoolRole] ([ResourceRoleId], [ResourcePoolId], [RoleId], [CanView], [CanEdit], [CanDelete], [CanApprove], [CanPrint]) VALUES (1, N'79d65210-f162-4b64-9a5c-113da5056111', N'b6b70d66-361f-425f-bd69-3b07f12dbb44', 1, 1, 0, 0, 1)
INSERT [User].[ResourcePoolRole] ([ResourceRoleId], [ResourcePoolId], [RoleId], [CanView], [CanEdit], [CanDelete], [CanApprove], [CanPrint]) VALUES (2, N'79d65210-f162-4b64-9a5c-113da5056111', N'1d59fd2e-823f-4ec6-914f-38f5598bd312', 1, 1, 1, 1, 1)
INSERT [User].[ResourcePoolRole] ([ResourceRoleId], [ResourcePoolId], [RoleId], [CanView], [CanEdit], [CanDelete], [CanApprove], [CanPrint]) VALUES (3, N'593328bc-4be7-4dfe-b82f-a0087e633545', N'9a04dcab-4cd6-4522-beb1-e723309bafe8', 1, 1, 0, 0, 1)
SET IDENTITY_INSERT [User].[ResourcePoolRole] OFF
INSERT [User].[Roles] ([RoleId], [RoleName]) VALUES (N'4ce80ad1-8e0d-4216-a6db-2ca474886de6', N'Operation')
INSERT [User].[Roles] ([RoleId], [RoleName]) VALUES (N'1d59fd2e-823f-4ec6-914f-38f5598bd312', N'Admin')
INSERT [User].[Roles] ([RoleId], [RoleName]) VALUES (N'b6b70d66-361f-425f-bd69-3b07f12dbb44', N'CSD')
INSERT [User].[Roles] ([RoleId], [RoleName]) VALUES (N'693539e3-f66e-49b7-ae75-403bb1802655', N'IT')
INSERT [User].[Roles] ([RoleId], [RoleName]) VALUES (N'9a04dcab-4cd6-4522-beb1-e723309bafe8', N'Teller')
SET IDENTITY_INSERT [User].[UserRole] ON 

INSERT [User].[UserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (1, N'909782ab-d09f-4c18-b228-802410fd5888', N'1d59fd2e-823f-4ec6-914f-38f5598bd312')
INSERT [User].[UserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (2, N'6fecd992-d977-431c-abfe-3d34bb64e8dc', N'4ce80ad1-8e0d-4216-a6db-2ca474886de6')
INSERT [User].[UserRole] ([UserRoleId], [UserId], [RoleId]) VALUES (3, N'6fecd992-d977-431c-abfe-3d34bb64e8dc', N'9a04dcab-4cd6-4522-beb1-e723309bafe8')
SET IDENTITY_INSERT [User].[UserRole] OFF
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_IsParent]  DEFAULT ((0)) FOR [IsParent]
GO
ALTER TABLE [User].[Credential] ADD  CONSTRAINT [DF_Credential_IsIntruder]  DEFAULT ((0)) FOR [IsIntruder]
GO
ALTER TABLE [User].[Credential] ADD  CONSTRAINT [DF_Credential_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [User].[Credential] ADD  CONSTRAINT [DF_Credential_HasTwoFactorEnabled]  DEFAULT ((0)) FOR [TwoFactorEnabled]
GO
ALTER TABLE [User].[PasswordPolicy] ADD  CONSTRAINT [DF_PasswordPolicy_IsPasswordExpired]  DEFAULT ((0)) FOR [IsPasswordExpired]
GO
ALTER TABLE [User].[Profile] ADD  CONSTRAINT [DF_Profile_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [User].[Profile] ADD  CONSTRAINT [DF_Profile_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [User].[Profile] ADD  CONSTRAINT [DF_Profile_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [User].[ResourcePoolRole] ADD  CONSTRAINT [DF_ResourceRole_CanView]  DEFAULT ((1)) FOR [CanView]
GO
ALTER TABLE [User].[ResourcePoolRole] ADD  CONSTRAINT [DF_ResourceRole_CanEdit]  DEFAULT ((1)) FOR [CanEdit]
GO
ALTER TABLE [User].[ResourcePoolRole] ADD  CONSTRAINT [DF_ResourceRole_CanDelete]  DEFAULT ((1)) FOR [CanDelete]
GO
ALTER TABLE [User].[ResourcePoolRole] ADD  CONSTRAINT [DF_ResourceRole_CanApprove]  DEFAULT ((0)) FOR [CanApprove]
GO
ALTER TABLE [User].[ResourcePoolRole] ADD  CONSTRAINT [DF_ResourceRole_CanPrint]  DEFAULT ((0)) FOR [CanPrint]
GO
USE [master]
GO
ALTER DATABASE [TestDB] SET  READ_WRITE 
GO
