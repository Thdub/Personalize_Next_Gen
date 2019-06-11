@echo off
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

	cd /d "%LocalAppdata%\Microsoft\Windows\WinX\Group1" >NUL 2>&1
	del "2 - Lock.lnk" /s /q >NUL 2>&1
:Restart_Explorer
	taskkill /IM explorer.exe /f >NUL 2>&1
	runas /trustlevel:0x20000 "explorer.exe"
	timeout /t 3 /nobreak >NUL 2>&1
	schTasks /query /TN "CreateExplorerShellUnelevatedTask" >NUL 2>&1 && schTasks /Delete /TN "CreateExplorerShellUnelevatedTask" /f >NUL 2>&1
	exit /b

:NOADMIN
	echo You must have administrator rights to run this script.
	<nul set /p dummyName=Press any key to exit...
	pause >nul
	goto :eof