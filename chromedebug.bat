@echo off
start "" chrome.exe --remote-debugging-port=9222 http://localhost:4200
@echo on
@echo Opened Chrome at port 9222