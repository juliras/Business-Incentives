USE [master]
GO

-- ****************************
-- Create BusinessIncentives DB 
-- ****************************
CREATE DATABASE [BusinessIncentives]
 CONTAINMENT = NONE
GO

/****************************/
/*     CREATE USER          */
/****************************/
USE [BusinessIncentives]
GO
CREATE USER [NT AUTHORITY\LOCAL SERVICE] FOR LOGIN [NT AUTHORITY\LOCAL SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_owner] TO [NT AUTHORITY\LOCAL SERVICE]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\LOCAL SERVICE]
GO
