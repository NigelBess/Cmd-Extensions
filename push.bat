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

REM Get the current branch (git -C "%CD%" because the cmd AutoRun cds child shells elsewhere)
for /f "delims=" %%b in ('git -C "%CD%" rev-parse --abbrev-ref HEAD') do set current_branch=%%b

REM Determine the trunk branch from origin/HEAD (fall back to master/main check)
set trunk_branch=
for /f "tokens=* delims=" %%t in ('git -C "%CD%" symbolic-ref --short refs/remotes/origin/HEAD 2^>nul') do set trunk_branch=%%t
if defined trunk_branch set trunk_branch=%trunk_branch:origin/=%
if not defined trunk_branch (
    if "%current_branch%"=="master" set trunk_branch=master
    if "%current_branch%"=="main" set trunk_branch=main
)

REM Warn before pushing directly to the trunk
if /i not "%current_branch%"=="%trunk_branch%" goto :do_push
set /p confirm=Are you sure you want to push directly to %current_branch%? y/n:
if /i not "%confirm%"=="y" (
    echo Push cancelled.
    exit /b 1
)

:do_push
git add .
git commit -m "%commit_msg%" --no-verify
git push
