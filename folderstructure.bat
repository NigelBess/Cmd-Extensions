@echo off
setlocal EnableDelayedExpansion

set "MAXDEPTH=%~1"
if not defined MAXDEPTH set "MAXDEPTH=4"

set "root=%CD%"
for %%A in ("%root%") do set "root=%%~nxA"
echo %root%

call :Walk "%CD%" 1 ""
goto :eof

:Walk
set "dir=%~1"
set "depth=%2"
set "prefix=%~3"

if %depth% GEQ %MAXDEPTH% (
    call :Summarize "%dir%" "%prefix%"
    goto :eof
)

set /a nDirs=0, nFiles=0
for /f "delims=" %%D in ('dir /b /ad "%dir%"') do set /a nDirs+=1
for /f "delims=" %%F in ('dir /b /a-d "%dir%"') do set /a nFiles+=1
set /a total=nDirs+nFiles, i=0

for /f "delims=" %%D in ('dir /b /ad "%dir%"') do (
    set /a i+=1
    call :Entry "d" "%dir%\%%D" "%%D" %depth% !total! !i! "%prefix%"
)
for /f "delims=" %%F in ('dir /b /a-d "%dir%"') do (
    set /a i+=1
    call :Entry "f" "%dir%\%%F" "%%F" %depth% !total! !i! "%prefix%"
)
goto :eof

:Entry
set "kind=%~1"
set "path=%~2"
set "name=%~3"
set "depth=%4"
set "total=%5"
set "index=%6"
set "prefix=%~7"

if %index% LSS %total% (
    set "branch=├── "
    set "childprefix=%prefix%│   "
) else (
    set "branch=└── "
    set "childprefix=%prefix%    "
)

echo %prefix%%branch%%name%

if /i "%kind%"=="d" (
    set /a nextDepth=%depth%+1
    call :Walk "%path%" %nextDepth% "%childprefix%"
)
goto :eof

:Summarize
set "dir=%~1"
set "prefix=%~2"
set /a cFiles=0, cDirs=0
for /d /r "%dir%" %%D in (*) do set /a cDirs+=1
for /r "%dir%" %%F in (*) do set /a cFiles+=1
echo %prefix%└---!cFiles! files, !cDirs! subfolders
goto :eof
