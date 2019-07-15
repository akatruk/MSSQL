SELECT DATEADD(ms,-sample_ms,GETDATE() )AS StartTime
FROM sys.dm_io_virtual_file_stats(1,1);
SELECT create_date  AS StartTime
FROM sys.databases
WHERE name = 'tempdb';
SELECT login_time AS StartTime
FROM sys.dm_exec_sessions
WHERE session_id =1;
EXEC xp_readerrorlog;