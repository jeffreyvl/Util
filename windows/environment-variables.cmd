@REM Environment Variables

@REM user environment	
@REM hkcu\environmennet

@REM system environment	
@REM "hklm\system\currentcontrolset\control\session manager\environment"

@REM Set environment variables

setx [var] [value]

@REM /M	Specifies that the variable should be set in the system wide (HKEY_LOCAL_MACHINE)
@REM     environment. The default is to set the variable under the HKEY_CURRENT_USER
@REM     environment.

@REM Query and Delete:

REG QUERY hkcu\environment

REG DELETE hkcu\environment /f /v [name]
