@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

:: Check Directories
	if not exist "%LocalAppdata%\Microsoft\Windows\WinX\" mkdir "%LocalAppdata%\Microsoft\Windows\WinX" >NUL 2>&1
	cd /d "%LocalAppdata%\Microsoft\Windows\WinX"
	set "SearchExplorerString=explorer"
	for /r %%a in (*) do for /f "delims=" %%i in ('echo("%%~na\Group2" ^| findstr /i "%SearchExplorerString%"') do del "%%~fa" /s/q >NUL 2>&1
:: Import
	cd /d "%~dp0"
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0Explorer_TI.zip" -y -r -o"%ProgramFiles%\System Tools\System Utilities\Custom Tools" >NUL 2>&1
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0CustomWinX_TI.zip" -y -r -o"%LocalAppdata%\Microsoft\Windows\WinX" >NUL & goto :Restart_Explorer
	) || (
	goto WINRAR
	)
:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0Explorer_TI.zip" -ibck -o+ "%ProgramFiles%\System Tools\System Utilities\Custom Tools" >NUL 2>&1
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0CustomWinX_TI.zip" -ibck -o+ "%LocalAppdata%\Microsoft\Windows\WinX" >NUL & goto :Restart_Explorer
	) || (
	goto PS
	)
:PS
	PowerShell -NoProfile -ExecutionPolicy Bypass "Expand-Archive -Path "Explorer_TI.zip" -DestinationPath "$env:ProgramFiles\'System Tools\System Utilities\Custom Tools'" -Force" >NUL 2>&1
	PowerShell -NoProfile -ExecutionPolicy Bypass "Expand-Archive -Path "CustomWinX_TI.zip" -DestinationPath "$env:LocalAppdata\Microsoft\Windows\WinX" -Force" >NUL 2>&1
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