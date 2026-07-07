@echo off

REM Check if at least one argument is provided
if "%~1"=="" (
    echo Usage: openlog "dispensecommandId"
    exit /b 1
)

REM Use the provided argument as the dispensecommandId
set id=%1
set url=https://dashboard.fulfil.store/dispenses/%id%/details?facility=PLM
start "" "%url%"