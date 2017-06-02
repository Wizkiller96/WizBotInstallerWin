@ECHO off
@TITLE WizBot


SET "root=%~dp0"
CD /D "%root%"

CLS
ECHO Welcome to WizBot Auto Restart and Update!
ECHO --------------------------------------------
ECHO 1.Auto Restart and Update with Dev Build (latest)
ECHO 2.Auto Restart and Update with Stable Build
ECHO 3.Run Auto Restart normally without Updating (will restart faster)
ECHO 4.To exit
ECHO.

CHOICE /C 1234 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 4 GOTO exit
IF ERRORLEVEL 3 GOTO autorun
IF ERRORLEVEL 2 GOTO stablear
IF ERRORLEVEL 1 GOTO latestar

:latestar
ECHO Auto Restart and Update with Dev Build (latest)
ECHO Bot will auto update on every restart!
CD /D "%~dp0WizBot\src\WizBot"
dotnet run --configuration Release
ECHO Updating...
SET "FILENAME=%~dp0\Latest.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/scripts/Latest.bat -OutFile '%FILENAME%'"
ECHO WizBot Dev Build (latest) downloaded.
SET "root=%~dp0"
CD /D "%root%"
CALL Latest.bat
GOTO latestar

:stablear
ECHO Auto Restart and Update with Stable Build
ECHO Bot will auto update on every restart!
CD /D "%~dp0WizBot\src\WizBot"
dotnet run --configuration Release
ECHO Updating...
SET "FILENAME=%~dp0\Stable.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/scripts/Stable.bat -OutFile '%FILENAME%'"
ECHO WizBot Stable build downloaded.
SET "root=%~dp0"
CD /D "%root%"
CALL Stable.bat
GOTO stablear

:autorun
ECHO Normal Auto Restart
ECHO Bot will not auto update on every restart!
timeout /t 3
CD /D "%~dp0WizBot\src\WizBot"
dotnet run --configuration Release
goto autorun

:Exit
SET "root=%~dp0"
CD /D "%root%"
del WizBotAutoRun.bat
CALL WizBotInstaller.bat