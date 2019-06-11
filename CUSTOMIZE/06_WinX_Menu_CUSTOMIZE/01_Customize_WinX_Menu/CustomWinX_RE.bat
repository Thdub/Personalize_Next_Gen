@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

:: Check Directories
	if not exist "%LocalAppdata%\Microsoft\Windows\WinX\" mkdir "%LocalAppdata%\Microsoft\Windows\WinX" >NUL 2>&1
	cd /d "%LocalAppdata%\Microsoft\Windows\WinX"
	if exist "%LocalAppdata%\Microsoft\Windows\WinX\Group2\" rmdir "%LocalAppdata%\Microsoft\Windows\WinX\Group2" /s /q >NUL 2>&1
	if exist "%LocalAppdata%\Microsoft\Windows\WinX\Group3\" rmdir "%LocalAppdata%\Microsoft\Windows\WinX\Group3" /s /q >NUL 2>&1
:: Import
	cd /d "%~dp0"
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0CustomWinX_RE.zip" -y -r -o"%LocalAppdata%\Microsoft\Windows\WinX" >NUL & goto :RestoreAttrib
	) || (
	goto WINRAR
	)
:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0CustomWinX_RE.zip" -ibck -o+ "%LocalAppdata%\Microsoft\Windows\WinX" >NUL & goto :RestoreAttrib
	) || (
	goto PS
	)
:PS
	PowerShell -NoProfile -ExecutionPolicy Bypass "Expand-Archive -Path "CustomWinX_RE.zip" -DestinationPath "$env:LocalAppdata\Microsoft\Windows\WinX" -Force" >NUL 2>&1
:RestoreAttrib
	if exist "%LocalAppdata%\Microsoft\Windows\WinX\Group1\" attrib +h +s "%LocalAppdata%\Microsoft\Windows\WinX\Group1\desktop.ini" & attrib +r +s "%LocalAppdata%\Microsoft\Windows\WinX\Group1" >NUL 2>&1
	attrib +h +s "%LocalAppdata%\Microsoft\Windows\WinX\Group3\desktop.ini" & attrib +r +s "%LocalAppdata%\Microsoft\Windows\WinX\Group3" >NUL 2>&1
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