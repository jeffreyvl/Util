Environment Variables

Locations:

user environment	hkcu\environmennet

system environment	"hklm\system\currentcontrolset\control\session manager\environment"

Set:

setx [var] [value]

/M	Specifies that the variable should be set in the system wide (HKEY_LOCAL_MACHINE)
    environment. The default is to set the variable under the HKEY_CURRENT_USER
    environment.

Query and Delete:

REG QUERY hkcu\environment

REG DELETE hkcu\environment /f /v [name]
