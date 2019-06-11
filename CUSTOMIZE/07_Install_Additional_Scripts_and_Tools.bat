@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN
"%~dp0\07_Install_Additional_Scripts_and_Tools\Install_Additional_Scripts_and_Tools.bat"& exit /b
:NOADMIN
echo You must have administrator rights to run this script.
<nul set /p dummyName=Press any key to exit...
pause >nul
goto :eof
