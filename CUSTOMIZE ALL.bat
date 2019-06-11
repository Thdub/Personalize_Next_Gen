@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

set "Install=FULL"
<nul set /p dummyName=Debloating Context Menu...
echo:
call "%~dp0\CUSTOMIZE\01_Context_Menu_DEBLOAT_MERGED.bat"
echo:
<nul set /p dummyName=Customizing Context Menu...
echo:
call "%~dp0\CUSTOMIZE\02_Context_Menu_CUSTOMIZE_MERGED.bat"
reg import "%~dp0\CUSTOMIZE\Display.reg" >NUL 2>&1
echo Done.
<nul set /p dummyName=Customizing Control Panel...
reg import "%~dp0\CUSTOMIZE\03_Control_Panel_MERGED.reg" >NUL 2>&1
echo Done.
<nul set /p dummyName=Applying Various System Tweaks...
reg import "%~dp0\CUSTOMIZE\04_System_MERGED.reg" >NUL 2>&1
echo Done.
<nul set /p dummyName=Customizing Applications Context Menu...
call "%~dp0\CUSTOMIZE\05_Applications_Context_Menu_MERGED.bat"
echo:
<nul set /p dummyName=Customizing WinX Menu...
call "%~dp0\CUSTOMIZE\06_WinX_Menu_CUSTOMIZE\CustomWinX_ALL\CustomWinX_ALL.bat"
echo Done.
<nul set /p dummyName=Installing Additional Tools...
call "%~dp0\CUSTOMIZE\07_Install_Additional_Scripts_and_Tools\Install_Additional_Scripts_and_Tools.bat"
taskkill /IM explorer.exe /f >NUL 2>&1
runas /trustlevel:0x20000 "explorer.exe"
echo: [?25l
setlocal EnableDelayedExpansion
for /f %%a in ('copy /Z "%~f0" nul') do set "CR=%%a"
for /L %%n in (30 -1 1) do (
	<nul set /p "=Full personalization task has completed, closing script in %%n seconds...!CR!"
	ping -n 2 localhost > nul
)
schTasks /query /TN "CreateExplorerShellUnelevatedTask" >NUL 2>&1 && schTasks /Delete /TN "CreateExplorerShellUnelevatedTask" /f >NUL 2>&1
exit /b

:NOADMIN
echo You must have administrator rights to run this script.
<nul set /p dummyName=Press any key to exit...
pause >nul
goto :eof