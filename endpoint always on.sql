SELECT * FROM sys.database_mirroring_endpoints  
go
DROP ENDPOINT [Hadr_endpoint]
go
CREATE ENDPOINT [Hadr_endpoint]
    STATE=STARTED
    AS TCP (LISTENER_PORT = 5022, LISTENER_IP = ALL)
    FOR DATA_MIRRORING (ROLE = ALL
, AUTHENTICATION = WINDOWS NEGOTIATE
, ENCRYPTION = REQUIRED ALGORITHM AES)
go
CREATE LOGIN [ru1000\o-b2b-sqleng-svc-1] FROM WINDOWS;  
GO  
GRANT CONNECT ON endpoint::hadr_endpoint TO [ru1000\o-b2b-sqleng-svc-1]
go

