@echo off

:: Launch NSudo to modify Context Menu with Trusted Installer privileges.
%windir%\system32\whoami.exe /USER | find /i "S-1-5-18" 1>nul && (
goto :OK
) || (
goto START
)

:START
	cd /d "%~dp0"
:: Extract NSudo
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
		"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -y -r -o"%TEMP%\NSudo" >NUL 2>&1
		goto :NSudo
	)
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
		"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -ibck -o+ "%TEMP%\NSudo" >NUL 2>&1
		goto :NSudo
	)
	PowerShell -NoProfile -ExecutionPolicy Bypass "Expand-Archive -Path ".\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -DestinationPath "$env:TEMP\NSudo" -Force" >NUL 2>&1
	goto :NSudo

:NSudo
	"%TEMP%\Nsudo\NSudoC.exe" -U:T -P:E -Wait -UseCurrentConsole "%~dpnx0"& goto :Install_Required_Scripts_and_Tools >NUL 2>&1

:OK
call :Task_01
call :Task_Success
call :Task_02
call :Task_Success
call :Task_03
call :Task_Success
call :Task_04
call :Task_Success
call :Task_05
call :Task_Success
call :Task_06
call :Task_Success
call :Task_07
call :Task_Success
set "NirCmdFolder=C:\Program Files\System Tools\System Utilities\NirCmd"
call :Task_08
call :Task_Success
call :Task_09
call :Task_Success
call :Task_10
call :Task_Success
call :Task_11
call :Task_Success
echo:
call :Task_12
call :Task_Success
call :Task_13
call :Task_Success
call :Task_DB01
call :Task_Success
call :Task_DB02
call :Task_Success
call :Task_DB03
call :Task_Success
call :Task_DB04
call :Task_Success
call :Task_DB05
call :Task_Success
call :Task_DB06
call :Task_Success
call :Task_DB07
call :Task_Success
call :Task_DB08
call :Task_Success
exit /b

:Task_01
echo [97m*******************************************************************
echo 01 ADD PinToStartScreen for .exe, links and folders in Context Menu
echo *******************************************************************
	reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f >NUL 2>&1
	reg delete "HKCR\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f >NUL 2>&1
	reg delete "HKCR\lnkfile\shellex\ContextMenuHandlers\PintoStartScreen" /f >NUL 2>&1
		reg add "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /ve /t REG_SZ /d "{470C0EBD-5D73-4d58-9CED-E91E22E23282}" /f >NUL 2>&1
		reg add "HKCR\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /ve /t REG_SZ /d "{470C0EBD-5D73-4d58-9CED-E91E22E23282}" /f >NUL 2>&1
		reg add "HKCR\lnkfile\shellex\ContextMenuHandlers\PintoStartScreen" /ve /t REG_SZ /d "{470C0EBD-5D73-4d58-9CED-E91E22E23282}" /f >NUL 2>&1
goto :eof

:Task_02
echo *******************************************************************************************************************
echo 02 ADD "Open Command window here (Administrator)" and "Open Powershell window here (Administrator)" to Context Menu
echo *******************************************************************************************************************
	echo Remove keys
		reg delete "HKCR\Directory\background\shell\cmd" /f >NUL 2>&1
		reg delete "HKCR\Directory\background\shell\Powershell" /f >NUL 2>&1
		reg delete "HKCR\Directory\background\shell\runas" /f >NUL 2>&1
		reg delete "HKCR\Directory\shell\cmd" /f >NUL 2>&1
		reg delete "HKCR\Directory\shell\Powershell" /f >NUL 2>&1
		reg delete "HKCR\Directory\shell\runas" /f >NUL 2>&1
		reg delete "HKCR\Drive\shell\cmd" /f >NUL 2>&1
		reg delete "HKCR\Drive\shell\Powershell" /f >NUL 2>&1
		reg delete "HKCR\Drive\shell\runas" /f >NUL 2>&1
	echo Directory background shell
		reg add "HKCR\Directory\background\shell\cmd" /ve /t REG_SZ /d "Open Command window here (Administrator)" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\cmd" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\cmd" /v "Icon" /t REG_SZ /d "imageres.dll,-5323" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\cmd" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\cmd" /v "SeparatorBefore" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\cmd" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\cmd\command" /ve /t REG_SZ /d "powershell.exe -windowstyle hidden -Command \"Start-Process cmd.exe -ArgumentList 'cmd.exe /s /k pushd \"%%V\"' -Verb RunAs\"" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\Powershell" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\Powershell" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\Powershell" /v "HideBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\Powershell\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /v "Icon" /t REG_SZ /d "powershell.exe" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas" /v "MUIVerb" /t REG_SZ /d "Open Powershell window here (Administrator)" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\runas\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
	echo Directory shell
		reg add "HKCR\Directory\shell\cmd" /ve /t REG_SZ /d "Open Command window here (Administrator)" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\cmd" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\cmd" /v "Icon" /t REG_SZ /d "imageres.dll,-5323" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\cmd" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\cmd" /v "SeparatorBefore" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\cmd" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\cmd\command" /ve /t REG_SZ /d "powershell.exe -windowstyle hidden -Command \"Start-Process cmd.exe -ArgumentList 'cmd.exe /s /k pushd \"%%V\"' -Verb RunAs\"" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Powershell" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Powershell" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Powershell" /v "Icon" /t REG_SZ /d "powershell.exe" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Powershell" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Powershell" /v "ShowBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Powershell\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /v "Icon" /t REG_SZ /d "powershell.exe" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas" /v "MUIVerb" /t REG_SZ /d "Open Powershell window here (Administrator)" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\runas\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
	echo Drive shell
		reg add "HKCR\Drive\shell\cmd" /ve /t REG_SZ /d "Open Command window here (Administrator)" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\cmd" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\cmd" /v "Icon" /t REG_SZ /d "imageres.dll,-5323" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\cmd" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\cmd" /v "SeparatorBefore" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\cmd" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\cmd\command" /ve /t REG_SZ /d "powershell.exe -windowstyle hidden -Command \"Start-Process cmd.exe -ArgumentList 'cmd.exe /s /k pushd \"%%V\"' -Verb RunAs\"" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\Powershell" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\Powershell" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\Powershell" /v "Icon" /t REG_SZ /d "powershell.exe" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\Powershell" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\Powershell" /v "ShowBasedOnVelocityId" /t REG_DWORD /d "6527944" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\Powershell\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /ve /t REG_SZ /d "@shell32.dll,-8508" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /v "Extended" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /v "Icon" /t REG_SZ /d "powershell.exe" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas" /v "MUIVerb" /t REG_SZ /d "Open Powershell window here (Administrator)" /f >NUL 2>&1
		reg add "HKCR\Drive\shell\runas\command" /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'" /f >NUL 2>&1
goto :eof

:Task_03
echo ************************************
echo 03 ADD Get File Hash to Context Menu
echo ************************************
	reg delete "HKCR\*\shell\GetFileHash" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash" /v "MUIVerb" /t REG_SZ /d "Hash" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash" /v "SeparatorBefore" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\01SHA1" /v "MUIVerb" /t REG_SZ /d "SHA1" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\01SHA1\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm SHA1 | format-list" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\02SHA256" /v "MUIVerb" /t REG_SZ /d "SHA256" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\02SHA256\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm SHA256 | format-list" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\03SHA384" /v "MUIVerb" /t REG_SZ /d "SHA384" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\03SHA384\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm SHA384 | format-list" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\04SHA512" /v "MUIVerb" /t REG_SZ /d "SHA512" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\04SHA512\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm SHA512 | format-list" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\05MACTripleDES" /v "MUIVerb" /t REG_SZ /d "MACTripleDES" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\05MACTripleDES\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm MACTripleDES | format-list" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\06MD5" /v "MUIVerb" /t REG_SZ /d "MD5" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\06MD5\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm MD5 | format-list" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\07RIPEMD160" /v "MUIVerb" /t REG_SZ /d "RIPEMD160" /f >NUL 2>&1
		reg add "HKCR\*\shell\GetFileHash\shell\07RIPEMD160\Command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath '%%1' -algorithm RIPEMD160 | format-list" /f >NUL 2>&1
goto :eof

:Task_04
echo *******************************************************
echo 04 ADD "Extract Contents" for MSI files in Context Menu
echo *******************************************************
	reg delete "HKCR\Msi.Package\shell\Extract" /f >NUL 2>&1
		reg add "HKCR\Msi.Package\shell\Extract" /ve /t REG_SZ /d "Extract the contents" /f >NUL 2>&1
		reg add "HKCR\Msi.Package\shell\Extract" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Msi.Package\shell\Extract\command" /ve /t REG_SZ /d "msiexec.exe /a \"%%1\" /qb TARGETDIR=\"%%1 Contents\"" /f >NUL 2>&1
goto :eof

:Task_05
echo **********************************************************************************
echo 05 Scan with Windows Defender Context Menu (Windows Defender Command Line Utility)
echo **********************************************************************************
	reg delete "HKCR\*\shell\01_WinDefenderScan" /f >NUL 2>&1
	reg delete "HKCR\AllFilesystemObjects\shell\01_WinDefenderScan" /f >NUL 2>&1
	reg delete "HKCR\Directory\shell\01_WinDefenderScan" /f >NUL 2>&1
	reg delete "HKCR\Drive\shell\01_WinDefenderScan" /f >NUL 2>&1
	reg delete "HKCR\Folder\shell\01_WinDefenderScan" /f >NUL 2>&1
	echo * shell
		reg add "HKCR\*\shell\01_WinDefenderScan" /v "Icon" /t REG_SZ /d "%ProgramFiles%\Windows Defender\EppManifest.dll" /f >NUL 2>&1
		reg add "HKCR\*\shell\01_WinDefenderScan" /v "MUIVerb" /t REG_SZ /d "Scan with Windows Defender" /f >NUL 2>&1
		reg add "HKCR\*\shell\01_WinDefenderScan" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\*\shell\01_WinDefenderScan\Command" /ve /t REG_SZ /d "cmd.exe /s /c \"\"C:\Program Files\Windows Defender\MpCmdRun.exe\" -scan -scantype 3 -SignatureUpdate -file \"%%1 \"\" & pause" /f >NUL 2>&1
	echo Directory shell
		reg add "HKCR\Directory\shell\01_WinDefenderScan" /v "Icon" /t REG_SZ /d "%ProgramFiles%\Windows Defender\EppManifest.dll" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\01_WinDefenderScan" /v "MUIVerb" /t REG_SZ /d "Scan with Windows Defender" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\01_WinDefenderScan" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\01_WinDefenderScan\Command" /ve /t REG_SZ /d "cmd.exe /s /c \"\"C:\Program Files\Windows Defender\MpCmdRun.exe\" -scan -scantype 3 -SignatureUpdate -file \"%%1 \"\" & pause" /f >NUL 2>&1
goto :eof

:Task_06
echo *******************************************
echo 06 Windows Defender Exclusions Context Menu
echo *******************************************
	reg delete "HKCR\*\shell\02_WinDefenderExclusions" /f >NUL 2>&1
	reg delete "HKCR\AllFilesystemObjects\shell\02_WinDefenderExclusions" /f >NUL 2>&1
	reg delete "HKCR\Directory\shell\02_WinDefenderExclusions" /f >NUL 2>&1
	reg delete "HKCR\Drive\shell\02_WinDefenderExclusions" /f >NUL 2>&1
	reg delete "HKCR\Folder\shell\02_WinDefenderExclusions" /f >NUL 2>&1
	echo * shell
		reg add "HKCR\*\shell\02_WinDefenderExclusions" /v "MUIVerb" /t REG_SZ /d "Windows Defender Exclusions" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,7" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\" OR System.ItemPathDisplay:=\"C:\Users\" OR System.ItemPathDisplay:=\"%USERPROFILE%\" OR System.ItemPathDisplay:=\"C:\ProgramData\" OR System.ItemPathDisplay:=\"C:\Program Files\" OR System.ItemPathDisplay:=\"C:\Program Files (x86)\" OR System.ItemPathDisplay:=\"C:\Windows\" OR System.ItemPathDisplay:=\"C:\Windows\System32\")" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\01_Add" /v "MUIVerb" /t REG_SZ /d "Add exclusion" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\01_Add" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,7" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\01_Add" /v "CommandFlags" /t REG_DWORD /d "16" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\01_Add\command" /ve /t REG_SZ /d "powershell -c \"mode 30,3;echo '';echo ' Add Defender Exclusion...'; Start-Process powershell -ArgumentList '-c \\\"Add-MpPreference -ExclusionPath ''%%1''\\\"' -verb RunAs -window Hidden\"" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\02_Remove" /v "MUIVerb" /t REG_SZ /d "Remove exclusion" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\02_Remove" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,4" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\02_Remove" /v "CommandFlags" /t REG_DWORD /d "48" /f >NUL 2>&1
		reg add "HKCR\*\shell\02_WinDefenderExclusions\shell\02_Remove\command" /ve /t REG_SZ /d "powershell -c \"mode 30,3;echo '';echo ' Rem Defender Exclusion...'; Start-Process powershell -ArgumentList '-c \\\"Remove-MpPreference -ExclusionPath ''%%1''\\\"' -verb RunAs -window Hidden\"" /f >NUL 2>&1
	echo Directory shell
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions" /v "MUIVerb" /t REG_SZ /d "Windows Defender Exclusions" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,7" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\" OR System.ItemPathDisplay:=\"C:\Users\" OR System.ItemPathDisplay:=\"%USERPROFILE%\" OR System.ItemPathDisplay:=\"C:\ProgramData\" OR System.ItemPathDisplay:=\"C:\Program Files\" OR System.ItemPathDisplay:=\"C:\Program Files (x86)\" OR System.ItemPathDisplay:=\"C:\Windows\" OR System.ItemPathDisplay:=\"C:\Windows\System32\")" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\01_Add" /v "MUIVerb" /t REG_SZ /d "Add exclusion" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\01_Add" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,7" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\01_Add" /v "CommandFlags" /t REG_DWORD /d "16" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\01_Add\command" /ve /t REG_SZ /d "powershell -c \"mode 30,3;echo '';echo ' Add Defender Exclusion...'; Start-Process powershell -ArgumentList '-c \\\"Add-MpPreference -ExclusionPath ''%%1''\\\"' -verb RunAs -window Hidden\"" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\02_Remove" /v "MUIVerb" /t REG_SZ /d "Remove exclusion" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\02_Remove" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,4" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\02_Remove" /v "CommandFlags" /t REG_DWORD /d "48" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\02_WinDefenderExclusions\shell\02_Remove\command" /ve /t REG_SZ /d "powershell -c \"mode 30,3;echo '';echo ' Rem Defender Exclusion...'; Start-Process powershell -ArgumentList '-c \\\"Remove-MpPreference -ExclusionPath ''%%1''\\\"' -verb RunAs -window Hidden\"" /f >NUL 2>&1
goto :eof

:Task_07
echo ***************************************
echo 07 ADD Restart Explorer to Context Menu
echo ***************************************
	reg delete "HKCR\Directory\background\shell\01_RestartExplorerNow" /f >NUL 2>&1
	reg delete "HKCR\Directory\background\shell\02_RestartExplorerOnDemand" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\01_RestartExplorerNow" /v "icon" /t REG_SZ /d "imageres.dll,84" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\01_RestartExplorerNow" /v "MUIVerb" /t REG_SZ /d "Restart Explorer Now" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\01_RestartExplorerNow" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\01_RestartExplorerNow" /v "SeparatorBefore" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\01_RestartExplorerNow\command" /ve /t REG_EXPAND_SZ /d "cmd.exe /c taskkill /f /im explorer.exe  & start explorer.exe" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\02_RestartExplorerOnDemand" /v "CommandFlags" /t REG_DWORD /d "32" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\02_RestartExplorerOnDemand" /v "icon" /t REG_SZ /d "imageres.dll,84" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\02_RestartExplorerOnDemand" /v "MUIVerb" /t REG_SZ /d "Restart Explorer On Demand" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\02_RestartExplorerOnDemand" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\02_RestartExplorerOnDemand" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\02_RestartExplorerOnDemand\command" /ve /t REG_EXPAND_SZ /d "cmd.exe /c @echo off & taskkill /f /im explorer.exe & echo: & echo Press any key to restart explorer.exe process...& pause >NUL && start explorer.exe && exit/b" /f >NUL 2>&1
goto :eof

:Task_08
echo **************************************************
echo 08 ADD SnippingTool and ScreenSnip to Context Menu
echo **************************************************
:Silent_Task_08
	reg delete "HKCR\Directory\background\shell\03_ScreenSnip_Enhanced" /f >NUL 2>&1
	reg delete "HKCR\Directory\background\shell\04_SnippingTools" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\03_ScreenSnip_Enhanced" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll,259" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\03_ScreenSnip_Enhanced" /v "MUIVerb" /t REG_SZ /d "ScreenSnip - Enhanced" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\03_ScreenSnip_Enhanced" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\03_ScreenSnip_Enhanced\command" /ve /t REG_SZ /d "\"%NirCmdFolder%\nircmd.exe\" exec hide \"C:\Program Files\System Tools\System Utilities\Scripts\ScreenSnip\ScreenSnipEnhanced.bat\"" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools" /v "Icon" /t REG_SZ /d "SnippingTool.exe" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools" /v "MUIVerb" /t REG_SZ /d "Snipping Tools" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\01_ScreenSnip_ActiveWindow" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll,259" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\01_ScreenSnip_ActiveWindow" /ve /t REG_SZ /d "ScreenSnip - Active Window (2 s delay)" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\01_ScreenSnip_ActiveWindow\command" /ve /t REG_SZ /d "\"%NirCmdFolder%\nircmd.exe\" exec hide \"C:\Program Files\System Tools\System Utilities\Scripts\ScreenSnip\ScreenSnipActiveWindow.bat\"" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\02_ScreenSnip_Fullscreen" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll,259" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\02_ScreenSnip_Fullscreen" /ve /t REG_SZ /d "ScreenSnip - Full Screen" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\02_ScreenSnip_Fullscreen\command" /ve /t REG_SZ /d "\"%NirCmdFolder%\nircmd.exe\" exec hide \"C:\Program Files\System Tools\System Utilities\Scripts\ScreenSnip\ScreenSnipFullScreen.bat\"" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\03_SnippingTool" /v "MUIVerb" /t REG_SZ /d "@SnippingTool.exe,-101" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\03_SnippingTool" /v "Icon" /t REG_SZ /d "SnippingTool.exe" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\03_SnippingTool" /v "CommandFlags" /t REG_DWORD /d "32" /f >NUL 2>&1
		reg add "HKCR\Directory\background\shell\04_SnippingTools\shell\03_SnippingTool\Command" /ve /t REG_SZ /d "SnippingTool.exe" /f >NUL 2>&1
goto :eof

:Task_09
echo ******************************************************
echo 09 ADD "Open Disk Cleaner" to RECYCLE BIN Context Menu
echo ******************************************************
	reg delete "HKCR\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\Open Disk Cleaner" /f >NUL 2>&1
			reg add "HKCR\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\Open Disk Cleaner" /v "Icon" /t REG_SZ /d "C:\Windows\System32\cleanmgr.exe,0" /f >NUL 2>&1
			reg add "HKCR\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\shell\Open Disk Cleaner\command" /ve /t REG_SZ /d "cleanmgr.exe" /f >NUL 2>&1
goto :eof

:Task_10
echo *****************************************************
echo 10 ADD Install CAB Update Context Menu for .cab files
echo *****************************************************
	reg delete "HKCR\CABFolder" /f >NUL 2>&1
	reg delete "HKCR\SystemFileAssociations\.cab" /f >NUL 2>&1
		reg add "HKCR\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "Install CAB Update" /f >NUL 2>&1
		reg add "HKCR\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\CABFolder\Shell\RunAs\Command" /ve /t REG_SZ /d "cmd /k dism /online /add-package /packagepath:\"%%1\"" /f >NUL 2>&1
		reg add "HKCR\SystemFileAssociations\.cab\Shell\RunAs" /ve /t REG_SZ /d "Install CAB Update" /f >NUL 2>&1
		reg add "HKCR\SystemFileAssociations\.cab\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\SystemFileAssociations\.cab\Shell\RunAs\Command" /ve /t REG_SZ /d "cmd /k dism /online /add-package /packagepath:\"%%1\"" /f >NUL 2>&1
goto :eof

:Task_11
echo ***************************************************************
echo 11 ADD Send To New Folder Capabilities to explorer Context Menu
echo ***************************************************************
<nul set /p dummyName=Creating shortcuts in Sendto folder (hybrid Powershell/WScript command execution is a bit slow)...
	PowerShell -NoProfile -ExecutionPolicy Bypass "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\SendTo\New folder (create new folder).lnk');$s.TargetPath='C:\Program Files\System Tools\System Utilities\Scripts\Sendto\SendtoNewFolder.bat';$s.WorkingDirectory='%AppData%\Microsoft\Windows\SendTo';$s.WindowStyle=7;$s.Description='Move selection to a new folder';$s.IconLocation='%SystemRoot%\System32\SHELL32.dll,4';$s.Save()" >NUL 2>&1
	PowerShell -NoProfile -ExecutionPolicy Bypass "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\SendTo\New folder (named as selection).lnk');$s.TargetPath='C:\Program Files\System Tools\System Utilities\Scripts\Sendto\SendtoFolderName.bat';$s.WorkingDirectory='%AppData%\Microsoft\Windows\SendTo';$s.WindowStyle=7;$s.Description='Move selection to a new folder, named as first item selected.';$s.IconLocation='%SystemRoot%\System32\SHELL32.dll,4';$s.Save()" >NUL 2>&1
	PowerShell -NoProfile -ExecutionPolicy Bypass "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\SendTo\New folder (type name).lnk');$s.TargetPath='C:\Program Files\System Tools\System Utilities\Scripts\Sendto\SendtoFolder.bat';$s.WorkingDirectory='%AppData%\Microsoft\Windows\SendTo';$s.Description='Prompt for a folder name and move selection to that folder';$s.IconLocation='%SystemRoot%\System32\SHELL32.dll,4';$s.Save()" >NUL 2>&1
	reg add "HKCR\CLSID\{7BA4C740-9E81-11CF-99D3-00AA004AE837}" /v "flags" /t REG_DWORD /d "2" /f >NUL 2>&1
goto :eof

:Task_12
echo *********************************************************************
echo 12 ADD Move to New Folder Button to Explorer Context Menu with script
echo *********************************************************************
:Silent_Task_12
:: Requires provided script and nircmd to hide window: since files are processed separately from "regular" context menu, it will open a cmd window for each selected file.
:: It is easy to hide them with NirCmd.exe (small) commandline tool.
	reg delete "HKCR\*\shell\03_MoveTo" /f >NUL 2>&1
		reg add "HKCR\*\shell\03_MoveTo" /ve /t REG_SZ /d "Move to new folder" /f >NUL 2>&1
		reg add "HKCR\*\shell\03_MoveTo" /v "Icon" /t REG_SZ /d "imageres.dll,176" /f >NUL 2>&1
		reg add "HKCR\*\shell\03_MoveTo" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\*\shell\03_MoveTo" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\" OR System.ItemPathDisplay:=\"C:\Users\" OR System.ItemPathDisplay:=\"%USERPROFILE%\" OR System.ItemPathDisplay:=\"C:\ProgramData\" OR System.ItemPathDisplay:=\"C:\Program Files\" OR System.ItemPathDisplay:=\"C:\Program Files (x86)\" OR System.ItemPathDisplay:=\"C:\Windows\" OR System.ItemPathDisplay:=\"C:\Windows\System32\")" /f >NUL 2>&1
		reg add "HKCR\*\shell\03_MoveTo\command" /ve /t REG_SZ /d "\"%NirCmdFolder%\nircmd.exe\" exec hide \"C:\Program Files\System Tools\System Utilities\Scripts\Sendto\MovetoNewFolder.bat\" \"%%V\"" /f >NUL 2>&1
goto :eof

:Task_13
echo ***************************************************************
echo 13 ADD Permissions Tools to Context Menu
echo ***************************************************************
	reg delete "HKCR\*\shell\Permissions" /f >NUL 2>&1
	reg delete "HKCR\Directory\shell\Permissions" /f >NUL 2>&1
		reg add "HKCR\*\shell\Permissions" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg add "HKCR\Directory\shell\Permissions" /v "SeparatorAfter" /t REG_DWORD /d "1" /f >NUL 2>&1
		reg import "%~dp0\02_Context_Menu_CUSTOMIZE\13_Permissions_Context_Menu.reg" >NUL 2>&1
goto :eof

::::::::::::::::::::
::DESKTOP BACKGROUND
::::::::::::::::::::
:Task_DB01
echo ***************************************************************************
echo DB01 ADD Administrative and System Tools to Desktop Background Context Menu
echo ***************************************************************************
	reg add "HKCR\DesktopBackground" /v "NoRecentDocs" /t REG_SZ /d "" /f >NUL 2>&1
	reg delete "HKCR\DesktopBackground\shell\Administrative and System Tools" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools" /v "Icon" /t REG_SZ /d "imageres.dll,-114" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools" /v "MUIVerb" /t REG_SZ /d "Administrative and System Tools" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Component Services" /v "Icon" /t REG_SZ /d "%%systemroot%%\system32\comres.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Component Services\Command" /ve /t REG_SZ /d "C:\Windows\system32\mmc.exe comexp.msc" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Computer Management" /v "Icon" /t REG_SZ /d "%%windir%%\system32\Mycomput.dll,2" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Computer Management\Command" /ve /t REG_SZ /d "C:\Windows\system32\mmc.exe compmgmt.msc /s" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Defragment and optimize your drives" /ve /t REG_SZ /d "Defragment and optimize your drives" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Defragment and optimize your drives" /v "icon" /t REG_SZ /d "%%windir%%\system32\dfrgui.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Defragment and optimize your drives\Command" /ve /t REG_SZ /d "C:\Windows\system32\dfrgui.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Device Manager" /ve /t REG_SZ /d "Device Manager" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Device Manager" /v "icon" /t REG_SZ /d "c:\windows\system32\devmgr.dll,-201" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Device Manager\Command" /ve /t REG_SZ /d "RunDll32.exe devmgr.dll DeviceManager_Execute" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Disk Cleanup" /v "icon" /t REG_SZ /d "%%windir%%\system32\cleanmgr.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Disk Cleanup\Command" /ve /t REG_SZ /d "cleanmgr.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Disk Management" /v "icon" /t REG_SZ /d "%%systemroot%%\system32\dmdskres.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Disk Management\Command" /ve /t REG_SZ /d "C:\Windows\SysWOW64\mmc.exe diskmgmt.msc" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Edit the system environment variables" /ve /t REG_SZ /d "Edit the system environment variables" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Edit the system environment variables" /v "icon" /t REG_SZ /d "SystemPropertiesAdvanced.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Edit the system environment variables\Command" /ve /t REG_SZ /d "SystemPropertiesAdvanced.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Event Viewer" /ve /t REG_SZ /d "Event Viewer" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Event Viewer" /v "icon" /t REG_SZ /d "%%windir%%\system32\miguiresource.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Event Viewer\Command" /ve /t REG_SZ /d "C:\Windows\system32\mmc.exe eventvwr.msc /s" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Local Group Policy" /ve /t REG_SZ /d "Local Group Policy" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Local Group Policy" /v "icon" /t REG_SZ /d "%%windir%%\system32\wsecedit.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Local Group Policy\Command" /ve /t REG_SZ /d "C:\Windows\SysWOW64\mmc.exe gpedit.msc" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Local Security Policy" /v "icon" /t REG_SZ /d "%%windir%%\system32\wsecedit.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Local Security Policy\Command" /ve /t REG_SZ /d "C:\Windows\system32\mmc.exe secpol.msc /s" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Network Connections" /ve /t REG_SZ /d "Network Connections" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Network Connections" /v "icon" /t REG_SZ /d "%%SystemRoot%%\system32\netshell.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Network Connections\Command" /ve /t REG_SZ /d "C:\Windows\explorer.exe shell:::{992CFFA0-F557-101A-88EC-00DD010CCC48}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Services" /ve /t REG_SZ /d "Services" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Services" /v "icon" /t REG_SZ /d "%%windir%%\system32\filemgmt.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Services\Command" /ve /t REG_SZ /d "C:\Windows\system32\mmc.exe services.msc" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\StartServerManagerWithServices" /ve /t REG_SZ /d "Server Manager" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\StartServerManagerWithServices" /v "icon" /t REG_SZ /d "%%SystemRoot%%\System32\ServerManager.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\StartServerManagerWithServices\Command" /ve /t REG_SZ /d "C:\Program Files\System Tools\System Utilities\Scripts\Program Launchers\StartServerManagerWithServices.bat" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Task Manager" /ve /t REG_SZ /d "Task Manager" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Task Manager" /v "icon" /t REG_SZ /d "%%windir%%\system32\Taskmgr.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Task Manager\Command" /ve /t REG_SZ /d "C:\Windows\system32\taskmgr.exe /7" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Task Scheduler" /ve /t REG_SZ /d "Task Scheduler" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Task Scheduler" /v "icon" /t REG_SZ /d "%%windir%%\system32\miguiresource.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Task Scheduler\Command" /ve /t REG_SZ /d "C:\Windows\system32\mmc.exe taskschd.msc /s" /f >NUL 2>&1
goto :eof

:Task_DB02
echo ***************************************************************
echo DB02 ADD Appearance Settings to Desktop Background Context Menu
echo ***************************************************************
	reg delete "HKCR\DesktopBackground\shell\Appearance" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance" /v "Icon" /t REG_SZ /d "themecpl.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance" /v "MUIVerb" /t REG_SZ /d "Appearance" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\01Display" /ve /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\display.dll,-4" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\01Display" /v "Icon" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\display.dll,-1" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\01Display" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\01Display" /v "SettingsUri" /t REG_SZ /d "ms-settings:display" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\01Display\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\02Personalize" /ve /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-10" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\02Personalize" /v "HideInSafeMode" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\02Personalize" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\themecpl.dll,-1" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\02Personalize" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\02Personalize" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-background" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\02Personalize\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\03DesktopBackground" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\03DesktopBackground" /v "MUIVerb" /t REG_SZ /d "Desktop Background" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\03DesktopBackground" /v "CommandFlags" /t REG_DWORD /d "32" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\03DesktopBackground\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageWallpaper" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\04Color" /v "Icon" /t REG_SZ /d "themecpl.dll" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\04Color" /v "MUIVerb" /t REG_SZ /d "Color" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\04Color\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageColorization" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\05Sounds" /v "Icon" /t REG_SZ /d "mmsys.cpl" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\05Sounds" /v "MUIVerb" /t REG_SZ /d "Sounds" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\05Sounds\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl ,2" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\06Screen Saver" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\06Screen Saver" /v "MUIVerb" /t REG_SZ /d "Screen Saver" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\06Screen Saver\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,screensaver,@screensaver" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\07DesktopIcons" /v "Icon" /t REG_SZ /d "desk.cpl" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\07DesktopIcons" /v "MUIVerb" /t REG_SZ /d "Change desktop icons" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\07DesktopIcons" /v "CommandFlags" /t REG_DWORD /d "32" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\07DesktopIcons\Command" /ve /t REG_SZ /d "rundll32 shell32.dll,Control_RunDLL desk.cpl,,0" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\08Cursors" /v "Icon" /t REG_SZ /d "main.cpl" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\08Cursors" /v "MUIVerb" /t REG_SZ /d "Change mouse pointers" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Appearance\Shell\08Cursors\Command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f >NUL 2>&1
goto :eof

:Task_DB03
echo **********************************************************************************
echo DB03 ADD Control Panel and Master Control Panel to Desktop Background Context Menu
echo **********************************************************************************
	reg delete "HKCR\DesktopBackground\shell\ControlPanel" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-4161" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel" /v "Icon" /t REG_SZ /d "imageres.dll,-27" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\01_ControlPanel" /v "MUIVerb" /t REG_SZ /d "Control Panel" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\01_ControlPanel" /v "Icon" /t REG_SZ /d "imageres.dll,-27" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\01_ControlPanel\Command" /ve /t REG_SZ /d "explorer.exe shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\02_MasterControlPanel" /v "MUIVerb" /t REG_SZ /d "Master Control Panel" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\02_MasterControlPanel" /v "Icon" /t REG_SZ /d "imageres.dll,-27" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\02_MasterControlPanel" /v "CommandFlags" /t REG_DWORD /d "32" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\ControlPanel\shell\02_MasterControlPanel\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}" /f >NUL 2>&1
goto :eof

:Task_DB04
echo **************************************************************************
echo DB04 ADD Settings and ms-settings pages to Desktop Background Context Menu
echo **************************************************************************
	reg delete "HKCR\DesktopBackground\shell\Settings" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings" /v "MUIVerb" /t REG_SZ /d "Settings" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\01_Settings" /v "MUIVerb" /t REG_SZ /d "Settings" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\01_Settings" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\01_Settings" /v "SettingsURI" /t REG_SZ /d "ms-settings:" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\01_Settings\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\02_Accounts" /v "MUIVerb" /t REG_SZ /d "Accounts" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\02_Accounts" /v "SettingsURI" /t REG_SZ /d "ms-settings:yourinfo" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\02_Accounts" /v "CommandFlags" /t REG_DWORD /d "32" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\02_Accounts" /v "Icon" /t REG_SZ /d "imageres.dll,208" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\02_Accounts\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\03_Apps" /v "MUIVerb" /t REG_SZ /d "Apps" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\03_Apps" /v "SettingsURI" /t REG_SZ /d "ms-settings:appsfeatures" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\03_Apps" /v "Icon" /t REG_SZ /d "imageres.dll,111" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\03_Apps\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\04_Devices" /v "MUIVerb" /t REG_SZ /d "Devices" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\04_Devices" /v "SettingsURI" /t REG_SZ /d "ms-settings:bluetooth" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\04_Devices" /v "Icon" /t REG_SZ /d "imageres.dll,71" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\04_Devices\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\05_EaseOfAccess" /v "MUIVerb" /t REG_SZ /d "Ease of Access" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\05_EaseOfAccess" /v "SettingsURI" /t REG_SZ /d "ms-settings:easeofaccess-narrator" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\05_EaseOfAccess" /v "Icon" /t REG_SZ /d "imageres.dll,81" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\05_EaseOfAccess\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\06_Network" /v "MUIVerb" /t REG_SZ /d "Network && Internet" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\06_Network" /v "SettingsURI" /t REG_SZ /d "ms-settings:network" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\06_Network" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\networkexplorer.dll,2" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\06_Network\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\07_Personalization" /v "MUIVerb" /t REG_SZ /d "Personalization" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\07_Personalization" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\07_Personalization" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\themecpl.dll,-1" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\07_Personalization\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\08_Privacy" /v "MUIVerb" /t REG_SZ /d "Privacy" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\08_Privacy" /v "SettingsURI" /t REG_SZ /d "ms-settings:privacy" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\08_Privacy" /v "Icon" /t REG_SZ /d "imageres.dll,54" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\08_Privacy\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\09_Search" /v "MUIVerb" /t REG_SZ /d "Search" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\09_Search" /v "SettingsURI" /t REG_SZ /d "ms-settings:cortana" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\09_Search" /v "Icon" /t REG_SZ /d "imageres.dll,168" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\09_Search\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\10_TimeAndLanguage" /v "MUIVerb" /t REG_SZ /d "Time && language" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\10_TimeAndLanguage" /v "SettingsURI" /t REG_SZ /d "ms-settings:dateandtime" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\10_TimeAndLanguage" /v "Icon" /t REG_SZ /d "imageres.dll,138" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\10_TimeAndLanguage\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\11_WindowsSecurity" /v "MUIVerb" /t REG_SZ /d "Windows Security" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\11_WindowsSecurity" /v "Icon" /t REG_SZ /d "%%ProgramFiles%%\Windows Defender\EppManifest.dll,7" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\11_WindowsSecurity\Command" /ve /t REG_SZ /d "explorer.exe windowsdefender:" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate" /v "MUIVerb" /t REG_SZ /d "Update && security" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate" /v "Icon" /t REG_SZ /d "C:\Program Files\System Tools\Maintenance\Scripts\CheckUpdatesWFC\Images\UpdateAndSecurity.ico" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate" /v "SubCommands" /t REG_SZ /d "" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\01_WindowsUpdate" /v "MUIVerb" /t REG_SZ /d "Windows Update" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\01_WindowsUpdate" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\01_WindowsUpdate" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\01_WindowsUpdate\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\02_UpdateHistory" /v "MUIVerb" /t REG_SZ /d "Update history" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\02_UpdateHistory" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate-history" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\02_UpdateHistory" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\02_UpdateHistory\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\03_RestartOptions" /v "MUIVerb" /t REG_SZ /d "Restart options" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\03_RestartOptions" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate-restartoptions" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\03_RestartOptions" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\03_RestartOptions\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\04_AdvancedOptions" /v "MUIVerb" /t REG_SZ /d "Advanced options" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\04_AdvancedOptions" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate-options" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\04_AdvancedOptions" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\Settings\shell\12_WindowsUpdate\shell\04_AdvancedOptions\Command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\System" /v "Icon" /t REG_SZ /d "imageres.dll,143" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\System" /v "MUIVerb" /t REG_SZ /d "System" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\Shell\System" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
goto :eof

:Task_DB05
echo **************************************************
echo DB05 ADD System to Desktop Background Context Menu
echo **************************************************
	reg delete "HKCR\DesktopBackground\shell\System" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\System" /v "Icon" /t REG_SZ /d "imageres.dll,143" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\System" /v "MUIVerb" /t REG_SZ /d "System" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\System" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\System\Command" /ve /t REG_SZ /d "explorer.exe shell:::{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}" /f >NUL 2>&1
goto :eof

:Task_DB06
echo *********************************************************************
echo DB06 ADD Toggle Defender ON or Off to Desktop Background Context Menu
echo *********************************************************************
	reg delete "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /v "MUIVerb" /t REG_SZ /d "Toggle Windows Defender On or Off" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /v "Icon" /t REG_SZ /d "C:\Program Files\Windows Defender\EppManifest.dll,4" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle\Command" /ve /t REG_SZ /d "powershell -Window Hidden \"Start-Process powershell -ArgumentList '-c \\\"$preferences = Get-MpPreference\\\";\\\"Set-MpPreference -DisableRealtimeMonitoring (!$preferences.DisableRealtimeMonitoring)\\\"' -verb RunAs -Window Hidden\"" /f >NUL 2>&1
goto :eof

:Task_DB07
echo *********************************************************************
echo DB07 ADD Toggle Firewall ON or Off to Desktop Background Context Menu
echo *********************************************************************
	reg delete "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /v "Icon" /t REG_SZ /d "imageres.dll,1" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /v "MUIVerb" /t REG_SZ /d "Toggle Windows Firewall On or Off" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle\Command" /ve /t REG_SZ /d "C:\Program Files\System Tools\System Utilities\Scripts\ToggleFirewall.bat" /f >NUL 2>&1
goto :eof

:Task_DB08
echo **********************************************************
echo DB08 ADD Windows Update to Desktop Background Context Menu
echo **********************************************************
	reg delete "HKCR\DesktopBackground\shell\WindowsUpdate" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsUpdate" /v "MUIVerb" /t REG_SZ /d "Windows Update" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsUpdate" /v "Icon" /t REG_SZ /d "C:\Program Files\System Tools\Maintenance\Scripts\CheckUpdatesWFC\Images\WindowsUpdate.ico" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsUpdate" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
		reg add "HKCR\DesktopBackground\shell\WindowsUpdate\Command" /ve /t REG_SZ /d "C:\Program Files\System Tools\Maintenance\Scripts\CheckUpdatesWFC\CheckUpdates.bat" /f >NUL 2>&1
goto :eof

:Task_Success
echo Done.
echo:
goto :eof

::---------------------------------
:Install_Required_Scripts_and_Tools
::---------------------------------
	cd /d "%~dp0"
	mkdir "%TEMP%\CustomizeNextGen" >NUL 2>&1
	mkdir "%TEMP%\CustomizeNextGen\NSudo" >NUL 2>&1
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
		"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0\02_Context_Menu_CUSTOMIZE\Required_Scripts_and_Tools.zip" -y -r -o"%TEMP%\CustomizeNextGen" >NUL 2>&1
		"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -y -r -o"%TEMP%\CustomizeNextGen\NSudo" >NUL 2>&1
		goto :Install_Settings
	)
:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
		"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0\02_Context_Menu_CUSTOMIZE\Required_Scripts_and_Tools.zip" -ibck -o+ "%TEMP%\CustomizeNextGen" >NUL 2>&1
		"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -ibck -o+ "%TEMP%\CustomizeNextGen\NSudo" >NUL 2>&1
		goto :Install_Settings
	)
:PS
	PowerShell -NoProfile -ExecutionPolicy Bypass "Expand-Archive -Path ".\02_Context_Menu_CUSTOMIZE\Required_Scripts_and_Tools.zip"  -DestinationPath "$env:TEMP\CustomizeNextGen" -Force" >NUL 2>&1
	PowerShell -NoProfile -ExecutionPolicy Bypass "Expand-Archive -Path ".\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -DestinationPath "$env:TEMP\CustomizeNextGen\NSudo" -Force" >NUL 2>&1

:Install_Settings
setlocal
set "NSudoFolder=C:\Program Files\System Tools\System Utilities\Nsudo"
set "NirCmdFolder=C:\Program Files\System Tools\System Utilities\NirCmd"
set "SetACLFolder=C:\Program Files\System Tools\System Utilities\SetACL"
call :NSudoChoice
echo:
call :NirCmd_Choice
echo:
call :SetACL_Choice
echo:
call :Install_Confirmation
echo:
:: Relaunch task 8 in case NirCmd folder changed.
call :Silent_Task_08
:: Relaunch task 12 in case NirCmd folder changed.
call :Silent_Task_12
echo:
call :Start_Install
call :TILE
call :CONTEXTMENU
echo:
call :PATHMAN_TASK
goto :END

:NSudoChoice
	echo Where do you want to install Nsudo?
	echo Press 0 to copy NSudo to default location (Program Files\System Tools\System Utilities\Nsudo),
	<nul set /p dummyName=or 1 to choose custom location [0/1]
	choice /C:01 /M "" >NUL 2>&1
	if errorlevel 2 (
		echo 1& echo Enter NSudo path here:
		set /p "NSudoFolder="
		goto :eof
	)
	echo 0& goto :eof

:NirCmd_Choice
	echo Where do you want to install NirCmd?
	echo Press 0 to copy NirCmd to default location (Program Files\System Tools\System Utilities\NirCmd),
	<nul set /p dummyName=or 1 to choose custom location [0/1]
	choice /C:01 /M "" >NUL 2>&1
	if errorlevel 2 (
		echo 1& echo Enter NirCmd path here:
		set /p "NirCmdFolder="
		goto :eof
	)
	echo 0& goto :eof

:SetACL_Choice
	echo Where do you want to install SetACL?
	echo Press 0 to copy SetACL to default location (Program Files\System Tools\System Utilities\SetACL),
	<nul set /p dummyName=or 1 to choose custom location [0/1]
	choice /C:01 /M "" >NUL 2>&1
	if errorlevel 2 (
		echo 1& echo Enter SetACL path here:
		set /p "SetACLFolder="
		goto :eof
	)
	echo 0& goto :eof

:Install_Confirmation
	echo NSudo will be installed in %NSudoFolder%
	echo NirCmd will be installed in %NirCmdFolder%
	echo SetACL will be installed in %SetACLFolder%
	<nul set /p dummyName=Press any key to confirm and start installation...
	pause >NUL 2>&1
	goto :eof

:Start_Install
	robocopy "%TEMP%\CustomizeNextGen\NSudo" "%NSudoFolder%" NSudo.exe >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\System Tools\System Utilities\NirCmd" "%NirCmdFolder%" *.exe >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\System Tools\System Utilities\SetACL" "%SetACLFolder%" SetACL.exe /S >NUL 2>&1
	cd /d "%TEMP%\CustomizeNextGen\System Tools\System Utilities" & rmdir "NirCmd" "SetACL" /s /q >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\System Tools" "%ProgramFiles%\System Tools" *.* /S >NUL 2>&1
	choice /C:YN /M "Do you want to install modified NSudo.json file?"
	if ERRORLEVEL 2 goto :eof
	robocopy "%TEMP%\CustomizeNextGen\NSudo" "%NSudoFolder%" NSudo.json >NUL 2>&1
	call :Task_Success
	goto :eof

:TILE
	choice /C:YN /M "Do you want to add Start Menu Tiles/icons and Start Menu links?"
	if ERRORLEVEL 2 echo: & goto :eof
	robocopy "%TEMP%\CustomizeNextGen\NSudo" "%NSudoFolder%" NSudo.visualelementsmanifest.xml >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\NSudo\images" "%NSudoFolder%\images" *.png /S >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\Tiles\System Tools" "%ProgramFiles%\System Tools" *.* /S >NUL 2>&1
	attrib +h "%NSudoFolder%\Images" >NUL 2>&1
	attrib +h "%NSudoFolder%\NSudo.visualelementsmanifest.xml" >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\Maintenance\Scripts\CheckUpdatesWFC\Images" >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\Maintenance\Scripts\CheckUpdatesWFC\CheckUpdates.visualelementsmanifest.xml" >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\Maintenance\Scripts\CheckUpdatesWFC\WindowsUpdateLauncher.visualelementsmanifest.xml" >NUL 2>&1
	echo Setting Start Menu tiles and shortcuts
	mklink "%ProgramFiles%\System Tools\Maintenance\Scripts\CheckUpdatesWFC\WindowsUpdateLauncher.exe" "%NSudoFolder%\Nsudo.exe" >NUL 2>&1
	mkdir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Maintenance" >NUL 2>&1
	mkdir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\System" >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\Start Menu" "%ProgramData%\Microsoft\Windows\Start Menu\Programs" *.lnk /S >NUL 2>&1
	PowerShell -NoProfile -ExecutionPolicy Bypass "$s=(New-Object -COM WScript.Shell).CreateShortcut('%programdata%\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk');$s.TargetPath='%NSudoFolder%\Nsudo.exe';$s.Save()"
	PowerShell -NoProfile -ExecutionPolicy Bypass "(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk").lastwritetime = get-date" >NUL 2>&1
	PowerShell -NoProfile -ExecutionPolicy Bypass "(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\Maintenance\Windows Update.lnk").lastwritetime = get-date" >NUL 2>&1
	call :Task_Success
	goto :eof

:CONTEXTMENU
	<nul set /p dummyName=Setting Context Menu and CommandStore...
:: Better command for "Open Commmand window here (administrator)" (with NSudoG)
	set "target=%NSudoFolder%"
	set "target=%target:\=\\%\\NSudoG.exe"
	set "FILENAME=%TEMP%\CustomizeNextGen\temp.reg"
	@echo Windows Registry Editor Version 5.00>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Directory\background\shell\cmd]>>"%FILENAME%"
	@echo @="Open Command window here (Administrator)">>"%FILENAME%"
	@echo "Extended"="">>"%FILENAME%"
	@echo "Icon"="imageres.dll,-5323">>"%FILENAME%"
	@echo "Position"="Bottom">>"%FILENAME%"
	@echo "SeparatorBefore"=dword:00000001>>"%FILENAME%"
	@echo "HasLUAShield"="">>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Directory\background\shell\cmd\command]>>"%FILENAME%"
	@echo @="\"%target%\" -U:P -P:E -ShowWindowMode=Hide cmd /c start \"Command Prompt\" cmd /s /k \"@echo off ^& for /f \"delims=\" %%%%i in ('ver') do echo %%%%i ^& echo (c) 2018 Microsoft Corporation. All rights reserved.^& @echo on^& pushd \"%%V\"\"">>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Directory\shell\cmd]>>"%FILENAME%"
	@echo @="Open Command window here (Administrator)">>"%FILENAME%"
	@echo "Extended"="">>"%FILENAME%"
	@echo "Icon"="imageres.dll,-5323">>"%FILENAME%"
	@echo "Position"="Bottom">>"%FILENAME%"
	@echo "SeparatorBefore"=dword:00000001>>"%FILENAME%"
	@echo "HasLUAShield"="">>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Directory\shell\cmd\command]>>"%FILENAME%"
	@echo @="\"%target%\" -U:P -P:E -ShowWindowMode=Hide cmd /c start \"Command Prompt\" cmd /s /k \"@echo off ^& for /f \"delims=\" %%%%i in ('ver') do echo %%%%i ^& echo (c) 2018 Microsoft Corporation. All rights reserved.^& @echo on^& pushd \"%%V\"\"">>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Drive\shell\cmd]>>"%FILENAME%"
	@echo @="Open Command window here (Administrator)">>"%FILENAME%"
	@echo "Extended"="">>"%FILENAME%"
	@echo "Icon"="imageres.dll,-5323">>"%FILENAME%"
	@echo "Position"="Bottom">>"%FILENAME%"
	@echo "SeparatorBefore"=dword:00000001>>"%FILENAME%"
	@echo "HasLUAShield"="">>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Drive\shell\cmd\command]>>"%FILENAME%"
	@echo @="\"%target%\" -U:P -P:E -ShowWindowMode=Hide cmd /c start \"Command Prompt\" cmd /s /k \"@echo off ^& for /f \"delims=\" %%%%i in ('ver') do echo %%%%i ^& echo (c) 2018 Microsoft Corporation. All rights reserved.^& @echo on^& pushd \"%%V\"\"">>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Directory\background\shell\Powershell]>>"%FILENAME%"
	@echo @="@shell32.dll,-8508">>"%FILENAME%"
	@echo "Extended"="">>"%FILENAME%"
	@echo "HideBasedBasedOnVelocityId"=dword:00639bc8>>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Directory\shell\Powershell]>>"%FILENAME%"
	@echo @="@shell32.dll,-8508">>"%FILENAME%"
	@echo "Extended"="">>"%FILENAME%"
	@echo "ShowBasedOnVelocityId"=dword:00639bc8>>"%FILENAME%"
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\Drive\shell\Powershell]>>"%FILENAME%"
	@echo @="@shell32.dll,-8508">>"%FILENAME%"
	@echo "Extended"="">>"%FILENAME%"
	@echo "ShowBasedOnVelocityId"=dword:00639bc8>>"%FILENAME%"
	@echo(>>"%FILENAME%"
:: DesktopBackground context menu: Better command for Toggle Defender (with NSudoG)
	reg delete "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /v "Icon" /t REG_SZ /d "%%ProgramFiles%%\Windows Defender\EppManifest.dll,4" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /v "MUIVerb" /t REG_SZ /d "Toggle Windows Defender On or Off" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsDefenderToggle" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
	@echo(>>"%FILENAME%"
	@echo [HKEY_CLASSES_ROOT\DesktopBackground\Shell\WindowsDefenderToggle\Command]>>"%FILENAME%"
	@echo @="\"%target%\" -U:P -ShowWindowMode:Hide cmd /c  \"sc query WinDefend ^| find \"STATE\" ^| find \"STOPPED\" ^&^& (\"%target%\" -U:T -ShowWindowMode:Hide sc start WinDefend ^& exit/b) ^|^| (\"%target%\" -U:T -ShowWindowMode:Hide sc stop WinDefend)\"">>"%FILENAME%"
	reg import "%FILENAME%" >NUL 2>&1
:: DesktopBackground context menu: Better command for Toggle Firewall (with NSudoG)
	reg delete "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /v "Icon" /t REG_SZ /d "imageres.dll,1" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /v "MUIVerb" /t REG_SZ /d "Toggle Windows Firewall On or Off" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle" /v "Position" /t REG_SZ /d "Bottom" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\shell\WindowsFirewallToggle\Command" /ve /t REG_SZ /d "\"%NSudoFolder%\NSudoG.exe\" -U:T -P:E -ShowWindowMode:Hide \"C:\Program Files\System Tools\System Utilities\Scripts\ToggleFirewall.bat\"" /f >NUL 2>&1
:: DesktopBackground context menu: Better command for Windows Update (with NSudoG)
	reg add  "HKCR\DesktopBackground\shell\WindowsUpdate\Command" /ve /t REG_SZ /d "\"%NSudoFolder%\NSudoG.exe\" -U:T -P:E \"C:\Program Files\System Tools\Maintenance\Scripts\CheckUpdatesWFC\CheckUpdates.bat\"" /f >NUL 2>&1
:: ADD NSudo to .exe file shell
	reg add "HKCR\exefile\shell\NSudo" /v "SubCommands" /t REG_SZ /d "NSudo.RunAs.TrustedInstaller;NSudo.RunAs.TrustedInstaller.EnableAllPrivileges;NSudo.RunAs.System;NSudo.RunAs.System.EnableAllPrivileges;" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "MUIVerb" /t REG_SZ /d "NSudo" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "Icon" /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\"" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "Position" /t REG_SZ /d "1" /f >NUL 2>&1
:: CommandStore
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System" /ve /t REG_SZ /d "Run As System" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System" /ve /t REG_SZ /d "Run As System" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System\command" /ve /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\" -U:S -ShowWindowMode=Hide cmd /c start \"NSudo.ContextMenu.Launcher\" \"%%1\"" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System.EnableAllPrivileges" /ve /t REG_SZ /d "Run As System (Enable All Privileges)" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System.EnableAllPrivileges" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.System.EnableAllPrivileges\command" /ve /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\" -U:S -P:E -ShowWindowMode=Hide cmd /c start \"NSudo.ContextMenu.Launcher\" \"%%1\"" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.TrustedInstaller" /ve /t REG_SZ /d "Run As TrustedInstaller" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.TrustedInstaller" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.TrustedInstaller\command" /ve /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\" -U:T -ShowWindowMode=Hide cmd /c start \"NSudo.ContextMenu.Launcher\" \"%%1\"" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.TrustedInstaller.EnableAllPrivileges" /ve /t REG_SZ /d "Run As TrustedInstaller (Enable All Privileges)" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.TrustedInstaller.EnableAllPrivileges" /v "HasLUAShield" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\NSudo.RunAs.TrustedInstaller.EnableAllPrivileges\command" /ve /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\" -U:T -P:E -ShowWindowMode=Hide cmd /c start \"NSudo.ContextMenu.Launcher\" \"%%1\"" /f >NUL 2>&1
	echo Done.
	goto :eof

:PATHMAN_TASK
:: Finally, add Nsudo SetACL and NirCmd to Environment Variables PATH
	<nul set /p dummyName=Adding Nsudo SetACL and NirCmd to Environment Variables Path...
	"%TEMP%\CustomizeNextGen\pathman" /as "%NSudoFolder%"
	"%TEMP%\CustomizeNextGen\pathman" /as "%NirCmdFolder%
	"%TEMP%\CustomizeNextGen\pathman" /as "%SetACLFolder%"
	echo Done.
	goto :eof

:END
	cd /d "%TEMP%" & rmdir "CustomizeNextGen" "Nsudo" /s /q >NUL 2>&1
	if "%Install%" == "FULL" exit /b
	echo: [?25l
	setlocal EnableDelayedExpansion
	for /f %%a in ('copy /Z "%~f0" nul') do set "CR=%%a"
	for /L %%n in (10 -1 1) do (
		<nul set /p "=Context Menu task has completed, closing script in %%n seconds...!CR!"
		ping -n 2 localhost > nul
	)
	exit /b

:NOADMIN
	echo You must have administrator rights to run this script.
	<nul set /p dummyName=Press any key to exit...
	pause >nul
	goto :eof
