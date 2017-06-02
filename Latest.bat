@ECHO off
TITLE Downloading Latest Build of WizBot...
::Setting convenient to read variables which don't delete the windows temp folder
SET "root=%~dp0"
CD /D "%root%"
SET "rootdir=%cd%"
SET "build5=%root%WizBotInstall_Temp\WizBot\src\WizBot\"
SET "installtemp=%root%WizBotInstall_Temp\"
::Deleting traces of last setup for the sake of clean folders, if by some miracle it still exists
IF EXIST "%installtemp%" ( RMDIR "%installtemp%" /S /Q >nul 2>&1)
echo.
timeout /t 5
::Checks that both git and dotnet are installed
dotnet --version >nul 2>&1 || GOTO :dotnet
git --version >nul 2>&1 || GOTO :git
::Creates the install directory to work in and get the current directory because spaces ruins everything otherwise
:start
MKDIR "%root%WizBotInstall_Temp"
CD /D "%installtemp%"
::Downloads the latest version of WizBot
ECHO Downloading WizBot...
ECHO.
git clone -b 1.4 --recursive --depth 1 --progress https://github.com/Wizkiller96/WizBot.git >nul
IF %ERRORLEVEL% EQU 128 (GOTO :giterror)
TITLE Installing WizBot, please wait...
ECHO.
ECHO Installing WizBot...
ECHO.
ECHO This will take a while...
ECHO.
CD /D "%build5%"
dotnet restore
dotnet build --configuration Release
ECHO.
ECHO.
ECHO WizBot installation completed successfully...
::Attempts to backup old files if they currently exist in the same folder as the batch file
IF EXIST "%root%WizBot\" (GOTO :backupinstall) ELSE (GOTO :freshinstall)
:freshinstall
	::Moves the WizBot folder to keep things tidy
	ECHO.
	ECHO Moving files, Please wait...
	ROBOCOPY "%root%WizBotInstall_Temp" "%rootdir%" /E /MOVE >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:backupinstall
	TITLE Backing up old files...
	ECHO.
	ECHO Moving and Backing up old files...
	::Recursively copies all files and folders from WizBot to WizBot_Old
	ROBOCOPY "%root%WizBot" "%root%WizBot_Old" /MIR >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO Old files backed up to WizBot_Old...
	::Copies the credentials and database from the backed up data to the new folder
	COPY "%root%WizBot_Old\src\WizBot\credentials.json" "%installtemp%WizBot\src\WizBot\credentials.json" >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO credentials.json copied...
	ROBOCOPY "%root%WizBot_Old\src\WizBot\bin" "%installtemp%WizBot\src\WizBot\bin" /E >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO bin folder copied...
	RD /S /Q "%root%WizBot_Old\src\WizBot\data\musicdata"
	ECHO.
	ECHO music cache cleared...
	ROBOCOPY "%root%WizBot_Old\src\WizBot\data" "%installtemp%WizBot\src\WizBot\data" /E >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	ECHO.
	ECHO Old data folder copied...
	::Moves the setup WizBot folder
	RMDIR "%root%WizBot\" /S /Q >nul 2>&1
	ROBOCOPY "%root%WizBotInstall_Temp" "%rootdir%" /E /MOVE >nul 2>&1
	IF %ERRORLEVEL% GEQ 8 (GOTO :copyerror)
	IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:dotnet
	::Terminates the batch script if it can't run dotnet --version
	TITLE Error!
	ECHO dotnet not found, make sure it's been installed as per the guides instructions!
	ECHO Press any key to exit.
	PAUSE >nul 2>&1
	CD /D "%root%"
	GOTO :EOF
:git
	::Terminates the batch script if it can't run git --version
	TITLE Error!
	ECHO git not found, make sure it's been installed as per the guides instructions!
	ECHO Press any key to exit.
	PAUSE >nul 2>&1
	CD /D "%root%"
	GOTO :EOF
:giterror
	ECHO.
	ECHO Git clone failed, trying again
	RMDIR "%installtemp%" /S /Q >nul 2>&1
	GOTO :start
:copyerror
	::If at any point a copy error is encountered 
	TITLE Error!
	ECHO.
	ECHO An error in copying data has been encountered, returning an exit code of %ERRORLEVEL%
	ECHO.
	ECHO Make sure to close any files, such as `WizBot.db` before continuing or try running the installer as an Administrator, if it does not help, try installing the bot again in a new folder.
	PAUSE >nul 2>&1
	CD /D "%root%"
	GOTO :EOF
:64BIT
ECHO.
ECHO Your System Architecture is 64bit...
GOTO end
:32BIT
ECHO.
ECHO Your System Architecture is 32bit...
timeout /t 5
ECHO.
ECHO Getting 32bit libsodium.dll and opus.dll...
IF EXIST "%root%WizBot\src\WizBot\_libs\32\libsodium.dll" (GOTO copysodium) ELSE (GOTO downloadsodium)
:copysodium
del "%root%WizBot\src\WizBot\libsodium.dll"
copy "%root%WizBot\src\WizBot\_libs\32\libsodium.dll" "%root%WizBot\src\WizBot\libsodium.dll"
ECHO libsodium.dll copied.
ECHO.
timeout /t 5
IF EXIST "%root%WizBot\src\WizBot\_libs\32\opus.dll" (GOTO copyopus) ELSE (GOTO downloadopus)
:downloadsodium
SET "FILENAME=%~dp0\WizBot\src\WizBot\libsodium.dll"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/src/WizBot/_libs/32/libsodium.dll -OutFile '%FILENAME%'"
ECHO libsodium.dll downloaded.
ECHO.
timeout /t 5
IF EXIST "%root%WizBot\src\WizBot\_libs\32\opus.dll" (GOTO copyopus) ELSE (GOTO downloadopus)
:copyopus
del "%root%WizBot\src\WizBot\opus.dll"
copy "%root%WizBot\src\WizBot\_libs\32\opus.dll" "%root%WizBot\src\WizBot\opus.dll"
ECHO opus.dll copied.
GOTO end
:downloadopus
SET "FILENAME=%~dp0\WizBot\src\WizBot\opus.dll"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBot/raw/dev/src/WizBot/_libs/32/opus.dll -OutFile '%FILENAME%'"
ECHO opus.dll downloaded.
GOTO end
:end
	::Normal execution of end of script
	TITLE WizBot Installation complete!
	CD /D "%root%"
	RMDIR /S /Q "%installtemp%" >nul 2>&1
	ECHO.
	ECHO Installation complete!
	ECHO.
	timeout /t 5
	del Latest.bat