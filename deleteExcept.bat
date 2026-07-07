@echo OFF
if "%~1"=="" exit /b 1
echo Deleting all except %1
git checkout %1 || exit /b 1
for /f "tokens=*" %%i in ('git branch') do @if not "%%i"=="* %1" if not "%%i"=="  %1" git branch -D %%i
@echo ON
