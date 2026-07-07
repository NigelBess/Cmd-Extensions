@echo off
setlocal enabledelayedexpansion

REM Check if a username was provided
if "%~1"=="" (
    echo Usage: gitas ^<username^>
    exit /b 1
)

set "user=%~1"

REM --- Look up a stored email for this username (per-user store) ---
set "store=%USERPROFILE%\.gitas_emails.txt"
set "email="
if exist "%store%" (
    for /f "usebackq tokens=1,* delims==" %%A in ("%store%") do (
        if /i "%%A"=="%user%" set "email=%%B"
    )
)

REM --- First-time setup: ask for the email and remember it ---
if "!email!"=="" (
    set /p "email=Enter email for %user%: "
    if "!email!"=="" (
        echo No email provided. Aborting.
        exit /b 1
    )
    echo %user%=!email!>>"%store%"
)

REM --- Read the current origin URL ---
set "url="
for /f "delims=" %%U in ('git remote get-url origin 2^>nul') do set "url=%%U"
if "!url!"=="" (
    echo Could not read origin remote URL.
    exit /b 1
)

REM --- Inject the username into the URL: https://user@host/path ---
REM Strip the protocol, then strip any existing user@ prefix
set "rest=!url:*//=!"
set "hostpath=!rest:*@=!"
set "newurl=https://%user%@!hostpath!"

REM --- Apply the changes ---
git remote set-url origin "!newurl!"
git config user.name "%user%"
git config user.email "!email!"

echo.
echo Remote and identity updated:
git remote -v
echo   user.name  = %user%
echo   user.email = !email!
