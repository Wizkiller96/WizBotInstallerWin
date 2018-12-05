@ECHO OFF
TITLE WizBot Installer!
SET "root=%~dp0"
CD /D "%root%"
goto check_Permissions
timeout /t 5
goto installer

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

:installer
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%WizBotCredentials.bat" del "%root%WizBotCredentials.bat"
IF EXIST "%root%WizBotAutoRun.bat" del "%root%WizBotAutoRun.bat"
IF EXIST "%root%WizBotRun.bat" del "%root%WizBotRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
SET "FILENAME=%root%windowsAIO.bat"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Wizkiller96/WizBotInstallerWin/1.9/windowsAIO.bat -OutFile '%FILENAME%'"
CALL windowsAIO.bat
IF EXIST "%root%windowsAIO.bat" del "%root%windowsAIO.bat"
IF EXIST "%root%WizBotCredentials.bat" del "%root%WizBotCredentials.bat"
IF EXIST "%root%WizBotAutoRun.bat" del "%root%WizBotAutoRun.bat"
IF EXIST "%root%WizBotRun.bat" del "%root%WizBotRun.bat"
IF EXIST "%root%Stable.bat" del "%root%Stable.bat"
IF EXIST "%root%Latest.bat" del "%root%Latest.bat"
pause


:exit
exit