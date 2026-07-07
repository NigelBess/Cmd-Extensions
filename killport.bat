@echo off
if "%~1"=="" (
    echo Usage: killport [port]
    exit /b 1
)
setlocal EnableDelayedExpansion
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%1 " ') do (
    if not "%%a"=="0" (
        call :KillPID %%a %1
    )
)
endlocal
exit /b

:KillPID
set "pid=%1"
set "port=%2"
if defined killed_%pid% goto :EOF
echo Killing process on port %port% (PID: %pid%)
taskkill /F /PID %pid%
set "killed_%pid%=1"
exit /b
