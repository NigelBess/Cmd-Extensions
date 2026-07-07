@echo off
setlocal EnableDelayedExpansion

REM Get the current branch name
for /f "delims=" %%i in ('git rev-parse --abbrev-ref HEAD') do set "branchName=%%i"

REM Echo the message
echo Deleting all branches except %branchName% and master

REM Get all local branches
for /f "delims=" %%i in ('git branch --format="%%(refname:short)"') do (
    set "branch=%%i"

    REM Check if branch is not master and not the current branch
    if not "!branch!"=="master" if not "!branch!"=="%branchName%" (
        echo Deleting !branch!
        git branch -D !branch!
    )
)

endlocal
@echo on