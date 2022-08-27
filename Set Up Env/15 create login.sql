USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [usrdemo]    Script Date: 11.08.2022 16:59:39 ******/
CREATE LOGIN [usrdemo] WITH PASSWORD=N'usrdemo', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

CREATE USER [usrdemo] FOR LOGIN [usrdemo] WITH DEFAULT_SCHEMA=[dbo]
GO



