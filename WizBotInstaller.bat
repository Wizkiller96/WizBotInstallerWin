@ECHO OFF

SET root=%~dp0
CD /D %root%

CLS
ECHO 1.Run WizBot (normally)
ECHO 2.Run WizBot with Auto Restart (check "if" WizBot is working properly, before using this)
ECHO 3.Download Latest Build
ECHO 4.To exit
ECHO.

CHOICE /C 1234 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 4 GOTO exit
IF ERRORLEVEL 3 GOTO latest
IF ERRORLEVEL 2 GOTO autorestart
IF ERRORLEVEL 1 GOTO runnormal

:runnormal
ECHO Downloading WizBot Run, please wait...
SET "FILENAME=%~dp0\WizBotRunNormal.bat"
bitsadmin.exe /transfer "Downloading WizBot Run (normal)" /priority high https://github.com/Wizkiller96/WizBot/raw/dev/scripts/WizBotRun.bat "%FILENAME%"
ECHO.
ECHO Running WizBot Normally, "if" you are running this to check WizBot, use ".die" command on discord to stop WizBot.
timeout /t 10
CALL WizBotRunNormal.bat
GOTO End

:autorestart
ECHO Downloading WizBot Auto Run, please wait...
SET "FILENAME=%~dp0\WizBotAutoRun.bat"
bitsadmin.exe /transfer "Downloading WizBot Auto-Run" /priority high https://github.com/Wizkiller96/WizBot/raw/dev/scripts/WizBotAutoRun.bat "%FILENAME%"
ECHO.
ECHO Running WizBot with Auto Restart, you will have to close the session to stop the auto restart.
timeout /t 15
CALL WizBotAutoRun.bat
GOTO End

:latest
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
ECHO Downloading WizBot (Latest), please wait...
SET "FILENAME=%~dp0\Latest.bat"
bitsadmin.exe /transfer "Downloading WizBot (Latest)" /priority high https://github.com/Wizkiller96/WizBot/raw/dev/scripts/Latest.bat "%FILENAME%"
ECHO WizBot Dev Build (latest) downloaded.
timeout /t 5
CALL Latest.bat
GOTO End

:exit
exit

:End
pause
CALL WizBotInstaller.bat
