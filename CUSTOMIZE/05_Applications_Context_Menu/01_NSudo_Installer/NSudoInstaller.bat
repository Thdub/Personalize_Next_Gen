@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

echo Where do you want to install Nsudo?
echo Enter the path here:
setlocal
set /p "NSudoFolder="
pause
cd /d "%~dp0"
mkdir "%TEMP%\NSudoInstall" >NUL 2>&1
:: IMPORT
:: Check for 7z first (fastest)
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0NSudoFolder.zip" -y -r -o"%TEMP%\NSudoInstall" >NUL & goto INSTALL
	)
:: Check for WINRAR
	:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0NSudoFolder.zip" -ibck -o+ "%TEMP%\NSudoInstall" >NUL & goto INSTALL
	)
:: Slowest option...
	:PS
	powershell -ExecutionPolicy Bypass -command "Expand-Archive -Path "NSudoFolder.zip"  -DestinationPath "$env:TEMP\NSudoInstall" -Force" >NUL 2>&1
	:INSTALL
	robocopy "%TEMP%\NSudoInstall" "%NSudoFolder%" NSudo.exe >NUL 2>&1
	choice /C:YN /M "Do you want to install modified .json file?"
	if ERRORLEVEL 2 goto TILE
	robocopy "%TEMP%\NSudoInstall" "%NSudoFolder%" NSudo.json >NUL 2>&1
	:TILE
	choice /C:YN /M "Do you want to add Start Menu Tile/icon as well?"
	if ERRORLEVEL 2 goto STARTMENU
	robocopy "%TEMP%\NSudoInstall" "%NSudoFolder%" NSudo.visualelementsmanifest.xml >NUL 2>&1
	xcopy "%TEMP%\NSudoInstall\Images" "%NSudoFolder%\Images" /e /h /k /i /y >NUL 2>&1
	attrib +h "%NSudoFolder%\Images" >NUL 2>&1
	attrib +h "%NSudoFolder%\NSudo.visualelementsmanifest.xml" >NUL 2>&1
	:STARTMENU
	choice /C:YN /M "And Start Menu link?"
	if ERRORLEVEL 2 goto CONTEXTMENU
	powershell -ExecutionPolicy Bypass -command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%programdata%\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk');$s.TargetPath='%NSudoFolder%\Nsudo.exe';$s.Save()" >NUL 2>&1
	powershell -ExecutionPolicy Bypass -command "(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk").lastwritetime = get-date" >NUL 2>&1
	:CONTEXTMENU
:: ADD to .exe file shell
	echo Setting Context Menu and CommandStore
	reg add "HKCR\exefile\shell\NSudo" /v "SubCommands" /t REG_SZ /d "NSudo.RunAs.TrustedInstaller;NSudo.RunAs.TrustedInstaller.EnableAllPrivileges;NSudo.RunAs.System;NSudo.RunAs.System.EnableAllPrivileges;" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "MUIVerb" /t REG_SZ /d "NSudo" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "Icon" /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\"" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "Position" /t REG_SZ /d "1" /f >NUL 2>&1
:: ADD CommandStore
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
:: ADD Nsudo to Environment Variables PATH
echo Setting Nsudo Environment Variable Path
	%~dp0pathman /as "%NSudoFolder%"
:END
echo Done.
cd /d "%TEMP%"
rmdir "NSudoInstall" /s /q >NUL 2>&1
timeout /t 3 /nobreak >NUL 2>&1
exit /b

:NOADMIN
Cls & echo You must have administrator rights to run this script.
      echo Press any key to exit...
pause >NUL
Cls
goto:eof
