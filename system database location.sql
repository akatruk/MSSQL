print @@version
print @@servername

USE master;
SELECT 
  name 'Logical Name', 
  physical_name 'File Location'
FROM sys.master_files
where 
name like ('master%') or 
name like ('%model%') or 
name like ('%msdb%') or 
name like ('%tempdb%') 