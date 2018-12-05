@ECHO OFF
TITLE WizBot CLI for v1.9+!
SET "root=%~dp0"
CD /D "%root%"

:MENU
CLS
ECHO.
ECHO 1.Download Latest Build
ECHO 2.Run WizBot (normally)
ECHO 3.Run WizBot with Auto Restart (check "if" WizBot is working properly, before using this)
ECHO 4.Setup credentials.json
ECHO 5.Install ffmpeg (for music)
ECHO 6.Redis Installation (Opens Website) (64bit)
ECHO 7.Run Redis (if its not running) (64bit)
ECHO 8.Install Youtube-dl. (Opens Website)
ECHO 9.Add Youtube-dl to PATH.
ECHO 10.Add Redis to PATH. (Advanced Users Only) ("Run Redis" is enough for Normal Users.) (64bit)
ECHO 11.Install .NET Core SDK (Opens Website)
ECHO 12.Install Git. (Opens Website)
ECHO 13.Copy libsodium and opus dll files for 32bit users. (Required for 32bit, Music)
ECHO 14.Download and run redis-server for 32bit users. (32bit)
ECHO 15.To exit

ECHO.
ECHO Make sure you are running WizBotInstaller.bat as Administrator!
ECHO.
SET /P "M=Input>"

IF "%M%"=="1" GOTO latest
IF "%M%"=="2" GOTO runnormal
IF "%M%"=="3" GOTO autorestart
IF "%M%"=="4" GOTO credentials
IF "%M%"=="5" GOTO ffmpeg
IF "%M%"=="6" GOTO redisinstall
IF "%M%"=="7" GOTO runredis
IF "%M%"=="8" GOTO ytdl
IF "%M%"=="9" GOTO ytdlpath
IF "%M%"=="10" GOTO redispath
IF "%M%"=="11" GOTO dnetinstl
IF "%M%"=="12" GOTO installgit
IF "%M%"=="13" GOTO libs
IF "%M%"=="14" GOTO 32bitredis
IF "%M%"=="15" GOTO exit
ECHO Invalid selection ("%M%")
GOTO :MENU

:latest
ECHO Make sure you are running it on Windows 8 or later.
timeout /t 10
TITLE Downloading WizBot (Latest), please wait...
SET "FILENAME=%~dp0\Latest.bat"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Wizkiller96/WizBotInstallerWin/1.9/Latest.bat -OutFile '%FILENAME%'"
ECHO WizBot Latest build script downloaded.
timeout /t 5
CALL Latest.bat
GOTO End

:runnormal
TITLE Downloading WizBot Run, please wait...
SET "FILENAME=%~dp0\WizBotRun.bat"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Wizkiller96/WizBotInstallerWin/1.9/WizBotRun.bat -OutFile '%FILENAME%'"
ECHO.
ECHO Running WizBot Normally, "if" you are running this to check WizBot, use ".die" command on discord to stop WizBot.
timeout /t 10
CALL WizBotRun.bat
GOTO End

:autorestart
TITLE Downloading WizBot Auto Run, please wait...
SET "FILENAME=%~dp0\WizBotAutoRun.bat"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Wizkiller96/WizBotInstallerWin/1.9/WizBotAutoRun.bat -OutFile '%FILENAME%'"
ECHO.
ECHO Running WizBot with Auto Restart, you will have to close the session to stop the auto restart.
timeout /t 15
CALL WizBotAutoRun.bat
GOTO End

:ffmpeg
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
TITLE WizBot FFMPEG Installer for 64bit OS!
CLS
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
mkdir "%SystemDrive%\ffmpeg\"
SET "FILENAME=%SystemDrive%\ffmpeg\ffmpeg.zip"
ECHO.
ECHO Downloading ffmpeg, please wait...
powershell -Command "Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20180806-076b196-win64-static.zip -OutFile '%FILENAME%'"
ECHO.
ECHO ffmpeg zip downloaded: %FILENAME%...
ECHO.
ECHO Press any key to continue extraction...
pause >nul 2>&1
ECHO.
ECHO Extracting files...
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170601-bd1179e-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170601-bd1179e-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170111-e71b811-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170111-e71b811-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20171014-0655810-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20171014-0655810-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20180224-28924f4-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20180224-28924f4-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20180806-076b196-win64-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20180806-076b196-win64-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg.zip" powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%SystemDrive%\ffmpeg\ffmpeg.zip"', '%SystemDrive%\ffmpeg\'); }"
ECHO.
ECHO ffmpeg extracted to %SystemDrive%\ffmpeg\
ECHO.
pause
ECHO.
mkdir "%SystemDrive%\wizbot_path_registry"
ECHO Backing up System PATH registry to "%SystemDrive%\wizbot_path_registry"
ECHO IMPORTANT!! READ BELOW.
ECHO NOTE: If you get a prompt to replace the registry file "path_registry_backup.reg"
ECHO Choose "No"!
ECHO.
pause
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\wizbot_path_registry\path_registry_backup_%date:/=-%_%time::=-%.reg"
ECHO Registry file backup complete!
@echo on
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\ffmpeg\ffmpeg-20180806-076b196-win64-static\bin"
@echo off
ECHO ffmpeg path has been set!
ECHO.
ECHO ffmpeg Installation complete! (Restarting WizBotInstaller.bat is required)
ECHO Press any key to exit...
pause >nul 2>&1
GOTO exit

:32BIT
TITLE WizBotBot FFMPEG Installer for 32bit OS!
CLS
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
mkdir "%SystemDrive%\ffmpeg\"
SET "FILENAME=%SystemDrive%\ffmpeg\ffmpeg.zip"
ECHO.
ECHO Downloading ffmpeg, please wait...
powershell -Command "Invoke-WebRequest https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-20180806-076b196-win32-static.zip -OutFile '%FILENAME%'"
ECHO.
ECHO ffmpeg zip downloaded: '%FILENAME%'...
ECHO.
ECHO Press any key to continue extraction...
pause >nul 2>&1
ECHO.
ECHO Extracting files...
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170601-bd1179e-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170601-bd1179e-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170225-7e4f32f-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20170125-2080bc3-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20170125-2080bc3-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20171014-0655810-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20171014-0655810-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20180224-28924f4-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20180224-28924f4-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg-20180806-076b196-win32-static" RD /S /Q "%SystemDrive%\ffmpeg\ffmpeg-20180806-076b196-win32-static"
IF EXIST "%SystemDrive%\ffmpeg\ffmpeg.zip" powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%SystemDrive%\ffmpeg\ffmpeg.zip"', '%SystemDrive%\ffmpeg\'); }"
ECHO.
ECHO ffmpeg extracted to %SystemDrive%\ffmpeg\
ECHO.
pause
ECHO.
mkdir "%SystemDrive%\wizbot_path_registry"
ECHO Backing up System PATH registry to "%SystemDrive%\wizbot_path_registry"
ECHO IMPORTANT!! READ BELOW.
ECHO NOTE: If you get a prompt to replace the registry file "path_registry_backup.reg"
ECHO Choose "No"!
ECHO.
pause
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\wizbot_path_registry\path_registry_backup_%date:/=-%_%time::=-%.reg"
ECHO Registry file backup complete!
@echo on
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\ffmpeg\ffmpeg-20180806-076b196-win32-static\bin"
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
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Wizkiller96/WizBotInstallerWin/1.9/WizBotCredentials.bat -OutFile '%FILENAME%'"
ECHO WizBot credentials.json setup files downloaded.
timeout /t 5
CALL WizBotCredentials.bat
GOTO End

:redisinstall
CLS
ECHO.
ECHO Check your Browser and download and install the latest/stable version of redis.
ECHO.
start https://github.com/MicrosoftArchive/redis/releases
start https://github.com/MicrosoftArchive/redis/releases/download/win-3.0.504/Redis-x64-3.0.504.msi
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:runredis
CLS
ECHO.
ECHO Only works if the Redis is installed at its default location. e.g. "%SystemDrive%\Program Files\Redis"
ECHO.
IF EXIST "%SystemDrive%\Program Files\Redis" powershell Start-Process '%SystemDrive%\Program Files\Redis\redis-server.exe' -WindowStyle Hidden
ECHO.
ECHO Redis-server is now started, if you see the redis connection error while running the bot.
ECHO It could mean you don't have the redis installed to its default directory.
ECHO If so, just find the directory and run "redis-server.exe" file. 
ECHO.
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:ytdl
CLS
ECHO.
ECHO Install Youtube-dl from its official website, check your browser.
ECHO and download the "Windows exe".
start https://rg3.github.io/youtube-dl/download.html
IF EXIST "%SystemDrive%\youtube-dl" (GOTO ytdlexist) ELSE (GOTO ytdlmake)

:ytdlmake
ECHO.
mkdir "%SystemDrive%\youtube-dl"
ECHO Created "%SystemDrive%\youtube-dl" folder.
ECHO.

:ytdlexist
ECHO.
ECHO Place the downloaded "youtube-dl.exe" in "%SystemDrive%\youtube-dl"
ECHO.
ECHO Once Done, add the youtube-dl to PATH, check environment variables or just use the WizBot CLI Option "Add Youtube-dl to PATH." to do it automatically.
ECHO.
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:ytdlpath
CLS
ECHO.
mkdir "%SystemDrive%\wizbot_path_registry"
ECHO Backing up System PATH registry to "%SystemDrive%\wizbot_path_registry"
ECHO IMPORTANT!! READ BELOW.
ECHO NOTE: If you get a prompt to replace the registry file "path_registry_backup.reg"
ECHO Choose "No"!
ECHO.
pause
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\wizbot_path_registry\path_registry_backup_%date:/=-%_%time::=-%.reg"
ECHO Registry file backup complete!
@echo on
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\youtube-dl"
@echo off
ECHO youtube-dl PATH has been set!
ECHO.
ECHO Restarting WizBotInstaller.bat is required.
ECHO Press any key to exit...
pause >nul 2>&1
GOTO exit

:redispath
CLS
ECHO.
ECHO Only works if the Redis is installed at its default location. e.g. "%SystemDrive%\Program Files\Redis"
ECHO.
mkdir "%SystemDrive%\wizbot_path_registry"
ECHO Backing up System PATH registry to "%SystemDrive%\wizbot_path_registry"
ECHO IMPORTANT!! READ BELOW.
ECHO NOTE: If you get a prompt to replace the registry file "path_registry_backup.reg"
ECHO Choose "No"!
ECHO.
pause
reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "%SystemDrive%\wizbot_path_registry\path_registry_backup_%date:/=-%_%time::=-%.reg"
ECHO Registry file backup complete!
@echo on
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v "path" /t REG_SZ /d "%path%;%SystemDrive%\Program Files\Redis"
@echo off
ECHO Redis PATH has been set!
ECHO.
ECHO Restarting WizBotInstaller.bat is required.
ECHO Press any key to exit...
pause >nul 2>&1
GOTO exit

:dnetinstl
CLS
ECHO.
ECHO Check your Browser and download and install ".NET Core SDK"
ECHO.
ECHO (NOTE: You do not need to Install the "SDK Installer" of .NET Core 1.0.4 from GitHub, unless you have "bot playing with no sound" issue.)
ECHO.
ECHO Press any key to continue...
pause >nul 2>&1

start https://www.microsoft.com/net/download

ECHO.

start https://github.com/dotnet/core/blob/master/release-notes/download-archives/1.0.4-download.md

ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:installgit
CLS
ECHO.
ECHO Check your Browser and download and install git from the website.
ECHO.
ECHO IMPORTANT: Make sure you select "Use Git from the Windows Command Prompt" when you see the option while installing it.
ECHO.
start https://gitforwindows.org
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:libs
CLS
ECHO.

IF EXIST "%root%\WizBot\src\WizBot" (GOTO installedwizbot) ELSE (GOTO notinstalledwizbot)

:notinstalledwizbot
ECHO.
ECHO You don't have WizBot installed. Please Install WizBot build before trying again!
ECHO.
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:installedwizbot
ECHO Copying 32bit libs...
ECHO.
IF EXIST "%root%\WizBot\src\WizBot\opus.dll" ren "%root%WizBot\src\WizBot\opus.dll" "opus_%date:/=-%_%time::=-%.dll_backup"
COPY "%root%\WizBot\WizBot.Core\_libs\32\opus.dll" "%root%\WizBot\src\WizBot\opus.dll"
ECHO opus.dll file copied.
ECHO.
IF EXIST "%root%\WizBot\src\WizBot\libsodium.dll" ren "%root%WizBot\src\WizBot\libsodium.dll" "libsodium_%date:/=-%_%time::=-%.dll_backup"
COPY "%root%\WizBot\WizBot.Core\_libs\32\libsodium.dll" "%root%\WizBot\src\WizBot\libsodium.dll"
ECHO libsodium.dll file copied.
ECHO.
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:32bitredis
CLS
ECHO.
ECHO Downloading 32bit redis-server...
ECHO Provided by github.com/Wizkiller96/WizBotFiles
ECHO.
SET "FILENAME=%~dp0\redis-server.exe"
powershell -NoProfile -ExecutionPolicy unrestricted  -Command "Invoke-WebRequest "https://raw.githubusercontent.com/Wizkiller96/WizBotFiles/master/x86_Prereqs/redis-server.exe" -OutFile '%FILENAME%'"

ECHO redis-server.exe file downloaded.
ECHO.
ECHO Starting redis-server now...
ECHO.
ECHO Works if the redis-server.exe is present at the location: "%root%"
ECHO.
IF EXIST "%root%\redis-server.exe" powershell Start-Process '%root%\redis-server.exe' -WindowStyle Hidden
ECHO.
ECHO Redis-server is now started, if you see the redis connection error while running the bot.
ECHO It could mean you don't have the redis installed to its default directory.
ECHO If so, just find the directory and run the 32bit "redis-server.exe" file. 
ECHO.
ECHO Press any key to go back to menu...
pause >nul 2>&1
GOTO MENU

:exit
exit
