If(db_id(N'ASPNetDb') IS NULL)

BEGIN

CREATE DATABASE ASPNetDb

END

RESTORE DATABASE ASPNetDb

FROM DISK = 'D:\SQL\BACKUP\ASPNetdb.bak'

WITH REPLACE,

move 'aspnetdb' to 'D:\SQL\2019\DATA\ASPNetDb.mdf',

move 'aspnetdb_log' to 'D:\SQL\2019\DATA\ASPNetdb_log.ldf'
GO