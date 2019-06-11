@echo off

%windir%\system32\whoami.exe /USER | find /i "S-1-5-18" 1>nul && (
goto :OK
) || (
goto START
)
:START
cd /d "%~dp0"
:: IMPORT for NSudo
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0..\CUSTOMIZE\02_Context_Menu_CUSTOMIZE\Required_Scripts_and_Tools.zip" -y -r -o"%TEMP%\ContextMenuCustomize" >NUL & goto NSudo
	)
	:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0..\CUSTOMIZE\02_Context_Menu_CUSTOMIZE\Required_Scripts_and_Tools.zip" -ibck -o+ "%TEMP%\ContextMenuCustomize" >NUL & goto NSudo
	)
	:PS
	powershell -ExecutionPolicy Bypass -command "Expand-Archive -Path "..\CUSTOMIZE\02_Context_Menu_CUSTOMIZE\Required_Scripts_and_Tools.zip"  -DestinationPath "$env:TEMP\ContextMenuCustomize" -Force" >NUL 2>&1
:NSudo
"%TEMP%\ContextMenuCustomize\Nsudo\NSudoG.exe" -U:T -P:E "%~dpnx0"&exit /b >NUL 2>&1
:OK
<nul set /p dummyName=Restoring Default Values...
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f >NUL 2>&1
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f >NUL 2>&1
reg delete "HKCR\lnkfile\shellex\ContextMenuHandlers\PintoStartScreen" /f >NUL 2>&1
reg delete "HKCR\Directory\background\shell\cmd" /f >NUL 2>&1
reg delete "HKCR\Directory\background\shell\Powershell" /f >NUL 2>&1
reg delete "HKCR\Directory\background\shell\runas" /f >NUL 2>&1
reg delete "HKCR\Directory\shell\cmd" /f >NUL 2>&1
reg delete "HKCR\Directory\shell\Powershell" /f >NUL 2>&1
reg delete "HKCR\Directory\shell\runas" /f >NUL 2>&1
reg delete "HKCR\Drive\shell\cmd" /f >NUL 2>&1
reg delete "HKCR\Drive\shell\Powershell" /f >NUL 2>&1
reg delete "HKCR\Drive\shell\runas" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\cmd" /ve /t REG_SZ /d "@shell32.dll,-8506" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\cmd" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\cmd" /v "HideBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\cmd" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\cmd\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\Powershell" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\Powershell" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\Powershell" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\Powershell" /v "ShowBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
reg add "HKCR\Directory\background\shell\Powershell\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
reg add "HKCR\Directory\shell\cmd" /ve /t REG_SZ /d "@shell32.dll,-8506" /f >NUL 2>&1
reg add "HKCR\Directory\shell\cmd" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\shell\cmd" /v "HideBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
reg add "HKCR\Directory\shell\cmd" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\shell\cmd\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f >NUL 2>&1
reg add "HKCR\Directory\shell\Powershell" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
reg add "HKCR\Directory\shell\Powershell" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\shell\Powershell" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Directory\shell\Powershell" /v "ShowBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
reg add "HKCR\Directory\shell\Powershell\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
reg add "HKCR\Drive\shell\cmd" /ve /t REG_SZ /d "@shell32.dll,-8506" /f >NUL 2>&1
reg add "HKCR\Drive\shell\cmd" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Drive\shell\cmd" /v "HideBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
reg add "HKCR\Drive\shell\cmd" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Drive\shell\cmd\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f >NUL 2>&1
reg add "HKCR\Drive\shell\Powershell" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
reg add "HKCR\Drive\shell\Powershell" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Drive\shell\Powershell" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Drive\shell\Powershell" /v "ShowBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
reg add "HKCR\Drive\shell\Powershell\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
reg delete "HKCR\*\shell\GetFileHash" /f >NUL 2>&1
reg delete "HKCR\Msi.Package\shell\Extract" /f >NUL 2>&1
reg delete "HKCR\*\shell\01_WinDefenderScan" /f >NUL 2>&1
reg delete "HKCR\Directory\shell\01_WinDefenderScan" /f >NUL 2>&1
reg delete "HKCR\Drive\shell\01_WinDefenderScan" /f >NUL 2>&1
reg delete "HKCR\*\shell\02_WinDefenderExclusions" /f >NUL 2>&1
reg delete "HKCR\Directory\shell\02_WinDefenderExclusions" /f >NUL 2>&1
reg delete "HKCR\Drive\shell\02_WinDefenderExclusions" /f >NUL 2>&1
reg delete "HKCR\DesktopBackground\shell\CheckForUpdates" /f >NUL 2>&1
reg delete "HKCR\DesktopBackground\shell\ControlPanel" /f >NUL 2>&1
reg delete "HKCR\DesktopBackground\shell\Settings" /f >NUL 2>&1
reg delete "HKCR\DesktopBackground\shell\System" /f >NUL 2>&1
reg delete "HKCR\DesktopBackground\shell\ToggleFirewall" /f >NUL 2>&1
reg delete "HKCR\Directory\background\shell\01_RestartExplorer" /f >NUL 2>&1
reg delete "HKCR\Directory\background\shell\02_SnippingTool" /f >NUL 2>&1
reg delete "HKCR\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\Open Disk Cleaner" /f >NUL 2>&1
echo Done.
cd /d "%TEMP%"
rmdir /s /q "%TEMP%\ContextMenuCustomize" >NUL 2>&1
timeout /t 3 /nobreak >NUL 2>&1
exit /b
