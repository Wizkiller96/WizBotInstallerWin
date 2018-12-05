@ECHO off
@TITLE WizBot
CD /D "%~dp0WizBot"
dotnet restore
dotnet build --configuration Release
CD /D "%~dp0WizBot\src\WizBot"
dotnet run -c Release --no-build -- {0} {1}
ECHO WizBot has been succesfully stopped, press any key to close this window.
TITLE WizBot - Stopped
CD /D "%~dp0"
PAUSE >nul 2>&1
del WizBotRun.bat
