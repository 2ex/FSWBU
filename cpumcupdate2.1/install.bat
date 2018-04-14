@echo off
set WHOAMI_EXE=%windir%\system32\whoami.exe

if NOT exist "%WHOAMI_EXE%" (
   echo WARNING: could not verify that the user has Administrative privileges.
   echo Windows Server 2003 or later is required.  Windows XP x64 is also acceptable.
   pause
   exit /B 1
)

call :checkIfAdmin
if ERRORLEVEL 1 (
   echo The current account does not appear to be a member of the Administrators group.
   echo Administrative privileges are required to execute the tool.
   pause
   exit /B 1
)

for %%i IN (cpumcupdate.inf cpumcupdate32.sys cpumcupdate64.sys) DO (
   if NOT exist "%~dp0%%i" (
      echo File %%i was not found.  It needs to be extracted from the zip file.
      pause
      exit /B 1
   )
)

for %%i IN (microcode.dat microcode_amd.bin microcode_amd_fam15h.bin) DO (
   if NOT exist "%~dp0%%i" (
      echo File %%i was not found.  It needs to be downloaded separately from this tool.
      pause
      exit /B 1
   )
)

pushd %~dp0
rundll32 setupapi.dll,InstallHinfSection DefaultInstall 128 .\cpumcupdate.inf
set resultCode=%ERRORLEVEL%
net start cpumcupdate > nul: 2> nul:
popd
echo Install completed with code %resultCode%.  If no error was displayed then the install was successful.
pause
exit /B 0

:checkIfAdmin

set SAW_ADMIN_GROUP=0
for /F "tokens=3,* delims=," %%i in ('"%WHOAMI_EXE%" /groups /fo csv') DO (
   if "%%i"==""S-1-5-32-544"" (
      set SAW_ADMIN_GROUP=1
   )
)
if "%SAW_ADMIN_GROUP%"=="0" (
   echo ERROR: The current account does not appear to be a member of the Administrators group.
   exit /B 1
)

rem Test for a few example privileges that most admins have
set privCount=0
for /F "tokens=1,*" %%i in ('"%WHOAMI_EXE%" /priv /fo table') DO (
   if "%%i"=="SeTakeOwnershipPrivilege"      set /a privCount=privCount+1
   if "%%i"=="SeLoadDriverPrivilege"         set /a privCount=privCount+1
   if "%%i"=="SeBackupPrivilege"             set /a privCount=privCount+1
   if "%%i"=="SeRestorePrivilege"            set /a privCount=privCount+1
   if "%%i"=="SeImpersonatePrivilege"        set /a privCount=privCount+1
   if "%%i"=="SeCreateGlobalPrivilege"       set /a privCount=privCount+1
)

if %privCount% LSS 6 (
   echo ERROR: An administrator account is required to perform this task. Only %privCount% of 6 privileges needed were detected.
   exit /B 1
)

exit /B 0
