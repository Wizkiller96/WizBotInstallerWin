@ECHO OFF
TITLE WizBot Client!
SET root=%~dp0
CD /D %root%

CLS
ECHO 1.Download Latest Build
ECHO 2.Download Stable Build
ECHO 3.Run WizBot (normally)
ECHO 4.Run WizBot with Auto Restart (check "if" WizBot is working properly, before using this)
ECHO 5.Setup credentials.json
ECHO 6.Install ffmpeg (for music)
ECHO 7.To exit

ECHO.
ECHO Make sure you are running WizBotInstaller.bat as Administrator!
ECHO.
CHOICE /C 1234567 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 7 GOTO exit
IF ERRORLEVEL 6 GOTO ffmpeg
IF ERRORLEVEL 5 GOTO credentials
IF ERRORLEVEL 4 GOTO autorestart
IF ERRORLEVEL 3 GOTO runnormal
IF ERRORLEVEL 2 GOTO stable
IF ERRORLEVEL 1 GOTO latest

:latest
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
TITLE Downloading WizBot (Latest), please wait...
SET "FILENAME=%~dp0\Latest.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/scripts/Latest.bat -OutFile '%FILENAME%'"
ECHO WizBot Dev Build (latest) downloaded.
timeout /t 5
CALL Latest.bat
GOTO End

:stable
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
TITLE Downloading WizBot (Stable), please wait...
SET "FILENAME=%~dp0\Stable.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/scripts/Stable.bat -OutFile '%FILENAME%'"
ECHO WizBot Stable build downloaded.
timeout /t 5
CALL Stable.bat
GOTO End

:runnormal
TITLE Downloading WizBot Run, please wait...
SET "FILENAME=%~dp0\WizBotRunNormal.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/scripts/WizBotRun.bat -OutFile '%FILENAME%'"
ECHO.
ECHO Running WizBot Normally, "if" you are running this to check WizBot, use ".die" command on discord to stop WizBot.
timeout /t 10
CALL WizBotRunNormal.bat
GOTO End

:autorestart
TITLE Downloading WizBot Auto Run, please wait...
SET "FILENAME=%~dp0\WizBotAutoRun.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/scripts/WizBotAutoRun.bat -OutFile '%FILENAME%'"
ECHO.
ECHO Running WizBot with Auto Restart, you will have to close the session to stop the auto restart.
timeout /t 15
CALL WizBotAutoRun.bat
GOTO End

:ffmpeg
goto check_Permissions
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
	    echo.

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		        echo.
		        pause
    ) else (
        echo Failure: Current permissions inadequate.
		          echo.
		          echo Run again as Administrator.
		          echo.
		          pause >nul
		          goto exit
    )

:64BIT
TITLE WizBot FFMPEG Installer for 64bit OS!
ECHO. 
ECHO Welcome to WizBot FFMPEG Installer! 
ECHO.
ECHO Installing ffmpeg in "%SystemDrive%\ffmpeg\"...
ECHO.
ECHO Make sure you are running this as Administrator! 
ECHO If not, then please restart "WizBotInstaller.bat" as Administrator.
ECHO.
ECHO DO NOT USE "Windows PowerShell" for ffmpeg Installation!
ECHO.
pause
mkdir %SystemDrive%\ffmpeg\
SET "FILENAME=%SystemDrive%\ffmpeg\ffmpeg.zip"
ECHO.
ECHO Downloading ffmpeg, please wait...
powershell -Command "Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20170225-7e4f32f-win64-static.zip -OutFile '%FILENAME%'"
ECHO.
ECHO ffmpeg zip downloaded: %FILENAME%...
ECHO.
ECHO Press any key to continue extraction...
pause >nul 2>&1
ECHO.
ECHO Extracting files...
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170111-e71b811-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170111-e71b811-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg.zip" powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%SystemDrive%\ffmpeg\ffmpeg.zip"', '%SystemDrive%\ffmpeg\'); }"
ECHO.
ECHO ffmpeg extracted to %SystemDrive%\ffmpeg\
ECHO.
pause
ECHO.
ECHO Backing up System PATH registry to "%SystemDrive%\ffmpeg\path_registry_backup.reg"
ECHO NOTE: If you get a prompt to replace the registry file "path_registry_backup.reg"
ECHO Choose "No"!
ECHO.
pause
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\ffmpeg\path_registry_backup.reg"
ECHO Registry file backup complete!
@echo on
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win64-static\bin"
@echo off
ECHO ffmpeg path has been set!
ECHO.
ECHO ffmpeg Installation complete! (Restarting WizBotInstaller.bat is required)
ECHO Press any key to exit...
pause >nul 2>&1
GOTO exit

:32BIT
TITLE WizBot FFMPEG Installer for 32bit OS!
ECHO. 
ECHO Welcome to WizBot FFMPEG Installer! 
ECHO.
ECHO Installing ffmpeg in "%SystemDrive%\ffmpeg\"...
ECHO.
ECHO Make sure you are running this as Administrator! 
ECHO If not, then please restart "WizBotInstaller.bat" as Administrator.
ECHO.
ECHO DO NOT USE "Windows PowerShell" for ffmpeg Installation!
ECHO.
pause
mkdir %SystemDrive%\ffmpeg\
SET "FILENAME=%SystemDrive%\ffmpeg\ffmpeg.zip"
ECHO.
ECHO Downloading ffmpeg, please wait...
powershell -Command "Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20170225-7e4f32f-win32-static.zip -OutFile '%FILENAME%'"
ECHO.
ECHO ffmpeg zip downloaded: '%FILENAME%'...
ECHO.
ECHO Press any key to continue extraction...
pause >nul 2>&1
ECHO.
ECHO Extracting files...
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170125-2080bc3-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170125-2080bc3-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg.zip" powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%SystemDrive%\ffmpeg\ffmpeg.zip"', '%SystemDrive%\ffmpeg\'); }"
ECHO.
ECHO ffmpeg extracted to %SystemDrive%\ffmpeg\
ECHO.
pause
ECHO.
ECHO Backing up System PATH registry to "%SystemDrive%\ffmpeg\path_registry_backup.reg"
ECHO NOTE: If you get a prompt to replace the registry file "path_registry_backup.reg"
ECHO Choose "No"!
ECHO.
pause
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\ffmpeg\path_registry_backup.reg"
ECHO Registry file backup complete!
@echo on
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win32-static\bin"
@echo off
ECHO ffmpeg path has been set!
ECHO.
ECHO ffmpeg Installation complete! (Restarting WizBotInstaller.bat is required)
ECHO Press any key to exit...
pause >nul 2>&1
GOTO exit

:End
cls
CALL WizBotInstaller.bat

:credentials
TITLE Downloading WizBot credentials.json setup files, please wait...
SET "FILENAME=%~dp0\WizBotCredentials.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBotInstallerWin/raw/master/WizBotCredentials.bat -OutFile '%FILENAME%'"
ECHO WizBot credentials.json setup files downloaded.
timeout /t 5
CALL WizBotCredentials.bat
GOTO End

:exit
exit
