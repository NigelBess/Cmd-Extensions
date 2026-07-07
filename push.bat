@echo off

REM Check if at least one argument is provided
if "%~1"=="" (
    echo Usage: push "commit message"
    exit /b 1
)

REM Use the provided argument as the commit message
set commit_msg=%*

REM Remove the surrounding quotes from the commit message
set commit_msg=%commit_msg:~1,-1%

git add .
git commit -m "%commit_msg%" --no-verify
git push
