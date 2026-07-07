@echo off
for /f "tokens=*" %%i in ('git rev-parse --abbrev-ref HEAD') do set branchName=%%i
@echo on
git fetch origin %1%
git merge origin/%1% -s recursive -X theirs --no-edit