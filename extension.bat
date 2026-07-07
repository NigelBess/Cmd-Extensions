@echo off
setlocal

if "%~1"=="" (
  echo Usage: %~n0 MyExtension
  exit /b 1
)

set "name=%~1"
mkdir "%name%" 2>nul || (
  echo Failed to create folder "%name%".
  exit /b 1
)

type nul > "%name%\manifest.json"
type nul > "%name%\content.js"

start "" explorer "%cd%\%name%"
