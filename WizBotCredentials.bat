@echo off

SET root=%~dp0
CD /D %root%

IF EXIST "%root%WizBot\src\WizBot" (GOTO installed) ELSE (GOTO notinstalled)

:notinstalled
title Failed Creating WizBot credentials.json
echo You don't have WizBot installed. Please Install WizBot (latest or stable) build before trying again!
pause
del WizBotCredentials.bat

:installed
title Creating WizBot credentials.json
echo Please make sure you have all the required informations to setup the credentials.json before continuing...
echo Refer to the hosting documents for more info...
echo.
pause
IF EXIST "%root%WizBot\src\WizBot\credentials.json" (GOTO backup) ELSE (GOTO create)

:backup
echo.
echo Backing up existing credentials.json...
IF EXIST "%root%WizBot\src\WizBot\credentials.json.backup3" del "%root%WizBot\src\WizBot\credentials.json.backup3"
IF EXIST "%root%WizBot\src\WizBot\credentials.json.backup2" rename "%root%WizBot\src\WizBot\credentials.json.backup2" "credentials.json.backup3"
IF EXIST "%root%WizBot\src\WizBot\credentials.json.backup" rename "%root%WizBot\src\WizBot\credentials.json.backup" "credentials.json.backup2"
rename "%root%WizBot\src\WizBot\credentials.json" "credentials.json.backup"
echo.
echo Back up complete...
echo.
pause
GOTO create

:create
cls
set /p client=Please enter your Client ID:
cls
set /p botid=Please enter your Bot ID (it is same as the client ID for new users):
cls
set /p token=Please enter your Bot Token ~59 characters long(it is not the Client Secret, Please make sure you enter the Token and not Client Secret):
cls
set /p owner=Please enter your Owner ID:
cls
set /p googleapi=Please enter your Google API key (Optional!! You can skip this step pressing Enter key): 
cls
set /p lolapi=Please enter your LoLApiKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p mashape=Please enter your MashapeKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p osu=Please enter your OsuApiKey (Optional!! You can skip this step pressing Enter key): 
cls
set /p scid=Please enter your SoundCloudClientId (Optional!! You can skip this step pressing Enter key):
cls
(
echo {
echo   "ClientId": %client%,
echo   "BotId": %botid%,
echo   "Token": "%token%",
echo   "OwnerIds": [
echo     %owner%,
echo   ],
echo   "LoLApiKey": "%lolapi%",
echo   "GoogleApiKey": "%googleapi%",
echo   "MashapeKey": "%mashape%",
echo   "OsuApiKey": "%osu%",
echo   "SoundCloudClientId": "%scid%",
echo   "CarbonKey": "",
echo   "Db": null,
echo   "TotalShards": 1
echo }
) > "%root%WizBot\src\WizBot\credentials.json"
echo.
echo Saved!
echo credentials.json setup is now complete!
echo.
CD /D "%root%"
pause
del WizBotCredentials.bat
