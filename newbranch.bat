@echo off

REM Check if at least one argument is provided
if "%~1"=="" (
    echo Usage: newbranch "name of branch you want to create"
    exit /b 1
)

REM Use the provided argument as the commit message
set branch=%*

git checkout master
call hardReset.bat
git pull
git checkout -b %branch%
