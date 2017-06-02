@ECHO OFF
TITLE WizBot Installer!
SET "root=%~dp0"
CD /D "%root%"
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%WizBotCredentials.bat" del "%root%WizBotCredentials.bat"
IF EXIST "%root%WizBotAutoRun.bat" del "%root%WizBotAutoRun.bat"
IF EXIST "%root%WizBotRun.bat" del "%root%WizBotRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
SET "FILENAME=%root%windowsAIO.bat"
powershell -Command "Invoke-WebRequest https://github.com/Wizkiller96/WizBotInstallerWin/raw/master/windowsAIO.bat -OutFile '%FILENAME%'"
CALL windowsAIO.bat
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%WizBotCredentials.bat" del "%root%WizBotCredentials.bat"
IF EXIST "%root%WizBotAutoRun.bat" del "%root%WizBotAutoRun.bat"
IF EXIST "%root%WizBotRun.bat" del "%root%WizBotRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"