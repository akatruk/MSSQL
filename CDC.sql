SET UNSI ON

-- Using CDC
use [DB_name]
go

-- Owner of database must be 'sa'
-- Change dbowner
exec sp_changedbowner 'sa'
go

-- Enable CDC on database
use [DB_name]
go
exec sys.sp_cdc_enable_db
go

-- Enable CDC on specific table [dbo].[test]
exec sys.sp_cdc_enable_table @source_schema = N'dbo', @source_name = N'test', @role_name=null, @capture_instance=null

----------
-- Enable all tables by CDC CURSOR
USE test
go
exec sp_changedbowner 'sa'
go
exec sys.sp_cdc_enable_db
go
DECLARE @Schema AS VARCHAR(300)

DECLARE @Table AS VARCHAR(300) 
DECLARE @cdc_Role AS VARCHAR(300) 
SET @cdc_Role = 'NULL'
DECLARE cdc_cursor CURSOR FOR  
SELECT TABLE_SCHEMA, TABLE_NAME  FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE';
OPEN cdc_cursor   
FETCH NEXT FROM cdc_cursor INTO @Schema ,    @Table
WHILE @@FETCH_STATUS = 0   
BEGIN   
 EXECUTE sys.sp_cdc_enable_table
									 @source_schema = @Schema
								   , @source_name = @Table
								   , @role_name = @cdc_Role;
								   
PRINT  'cdc Enable done for ' + @Schema + '.'+@Table ;
FETCH NEXT FROM cdc_cursor INTO @Schema ,    @Table
END   
CLOSE cdc_cursor   
DEALLOCATE cdc_cursor 
