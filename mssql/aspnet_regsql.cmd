aspnet_regsql -?

@REM ASPState
aspnet_regsql –S {hostname}\MSSQL2019 –ssadd –U sa –P {password}

@REM aspnetdb
aspnet_regsql –S {hostname}\MSSQL2019 -A all –U sa –P {password}