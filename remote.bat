@echo off

REM Check if at least one argument is provided
if "%~1"=="" (
    echo Usage: remote "name of branch you want"
    exit /b 1
)

REM Use the provided argument as the commit message
set branch=%*

git fetch origin %branch%
git checkout %branch%
git pull