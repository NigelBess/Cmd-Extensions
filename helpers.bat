@echo off
for %%G in ("%PATH:;=" "%") do (
    for %%f in (%%G\*.bat) do (
        echo %%~nf
    )
)
