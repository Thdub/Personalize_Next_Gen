@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

:: IMPORT
	cd /d "%~dp0"
	mkdir "%TEMP%\CustomizeNextGen" >NUL 2>&1
	mkdir "%TEMP%\CustomizeNextGen\NSudo" >NUL 2>&1
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0Additional_Scripts_and_Tools.zip" -y -r -o"%TEMP%\CustomizeNextGen" >NUL 2>&1
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0..\..\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -y -r -o"%TEMP%\CustomizeNextGen\NSudo" >NUL 2>&1
	goto :NSudo
	)
:: Check for WINRAR
	:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0Additional_Scripts_and_Tools.zip" -ibck -o+ "%TEMP%\CustomizeNextGen" >NUL 2>&1
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0..\..\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -ibck -o+ "%TEMP%\CustomizeNextGen\NSudo" >NUL 2>&1
	goto :NSudo
	)
:: LAST Option...
	:PS
	cd /d "%~dp0"
	powershell -ExecutionPolicy Bypass "Expand-Archive -Path "Additional_Scripts_and_Tools.zip"  -DestinationPath "$env:TEMP\CustomizeNextGen" -Force" >NUL 2>&1
	powershell -ExecutionPolicy Bypass "Expand-Archive -Path "..\..\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -DestinationPath "$env:TEMP\CustomizeNextGen\NSudo" -Force" >NUL 2>&1
:: INSTALL PROGRAMS
:NSudo
	choice /C:YN /M "Do you want to install NSudo?"
	if ERRORLEVEL 2 goto INSTALL_ALL
	setlocal
	echo Where do you want to install Nsudo?
	echo Enter the path here:
	set /p "NSudoFolder="
	pause
	set "NSudoInstall=NSudoIsInstalled"
	echo Copying Nsudo files
	robocopy "%TEMP%\CustomizeNextGen\NSudo" "%NSudoFolder%" *.* /S >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\System Utilities\Nsudo\Images" >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\System Utilities\Nsudo\NSudo.visualelementsmanifest.xml" >NUL 2>&1
	powershell -ExecutionPolicy Bypass -command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%programdata%\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk');$s.TargetPath='%NSudoFolder%\Nsudo.exe';$s.Save()"
	powershell -ExecutionPolicy Bypass -command "(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk").lastwritetime = get-date" >NUL 2>&1
	echo Setting NSudo Context Menu
:: ADD to .exe file shell
	reg add "HKCR\exefile\shell\NSudo" /v "SubCommands" /t REG_SZ /d "NSudo.RunAs.TrustedInstaller;NSudo.RunAs.TrustedInstaller.EnableAllPrivileges;NSudo.RunAs.System;NSudo.RunAs.System.EnableAllPrivileges;" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "MUIVerb" /t REG_SZ /d "NSudo" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "Icon" /t REG_SZ /d "\"%NSudoFolder%\NSudo.exe\"" /f >NUL 2>&1
	reg add "HKCR\exefile\shell\NSudo" /v "Position" /t REG_SZ /d "1" /f >NUL 2>&1
:: ADD CommandStore
	echo Setting NSudo CommandStore
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
	echo Adding Nsudo to Environment Variables Path
	"%TEMP%\CustomizeNextGen\pathman" /as "%NSudoFolder%"
:: All the rest
:INSTALL_ALL
	tasklist | find /i "7+ Taskbar Tweaker.exe" >NUL 2>&1
	if errorlevel 1 (
	goto STARTCOPY
	) else (
	taskkill /F /IM "7+ Taskbar Tweaker.exe" >NUL 2>&1
	)
:STARTCOPY
	echo:
	echo Copying additional files
	rmdir "%ProgramFiles%\System Tools\Maintenance\Microsoft" /s /q >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\System tools" "%ProgramFiles%\System Tools" *.*  /S >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\System Utilities\Custom Tools\Images" >NUL 2>&1
	attrib +h "%ProgramFiles%\System Tools\System Utilities\Custom Tools\RunExplorerShellAsTrustedInstaller.visualelementsmanifest.xml" >NUL 2>&1
	for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do ( 
	echo %%i | findstr /i /c:"Server 2019" >nul && robocopy "%TEMP%\CustomizeNextGen\SERVER\System Tools" "%ProgramFiles%\System Tools" *.*  /S >NUL 2>&1
	)
	for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do ( 
	echo %%i | findstr /i /c:"LTSC" >nul && robocopy "%TEMP%\CustomizeNextGen\LTSC\System Tools" "%ProgramFiles%\System Tools" *.*  /S >NUL 2>&1
	)
	echo Done.
	echo:
:: Creating Start Menu links
	choice /C:YN /M "Do you want to install Start Menu links (and custom tiles)?"
	if ERRORLEVEL 2 goto REGISTRY
	mkdir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Backup" >NUL 2>&1
	mkdir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Maintenance" >NUL 2>&1
	mkdir "%ProgramData%\Microsoft\Windows\Start Menu\Programs\System" >NUL 2>&1
	robocopy "%TEMP%\CustomizeNextGen\Start Menu" "%ProgramData%\Microsoft\Windows\Start Menu\Programs" *.lnk /S >NUL 2>&1
	powershell -ExecutionPolicy Bypass -command "(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\System\Explorer TI.lnk").lastwritetime = get-date" >NUL 2>&1
	if NSudoInstall == NSudoIsInstalled (
	powershell -ExecutionPolicy Bypass -command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%programdata%\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk');$s.TargetPath='%NSudoFolder%\Nsudo.exe';$s.Save()"
	powershell -ExecutionPolicy Bypass -command "(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk").lastwritetime = get-date" >NUL 2>&1
	)
:StartMenuEnd
	for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do ( 
	echo %%i | findstr /i /c:"Server 2019" >nul && robocopy "%TEMP%\CustomizeNextGen\SERVER\Start Menu" "%ProgramData%\Microsoft\Windows\Start Menu\Programs" *.lnk /S >NUL 2>&1
	)
	for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do ( 
	echo %%i | findstr /i /c:"LTSC" >nul && robocopy "%TEMP%\CustomizeNextGen\LTSC\Start Menu" "%ProgramData%\Microsoft\Windows\Start Menu\Programs" *.lnk /S >NUL 2>&1
	)
	echo Done.
:REGISTRY
	echo:
	echo Setting "Run as Admin" flags
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\System Tools\Maintenance\DeviceCleanup\DeviceCleanup.exe" /t REG_SZ /d "~ RUNASADMIN" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\System Tools\Maintenance\Driver Store Explorer\Rapr.exe" /t REG_SZ /d "~ RUNASADMIN" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\System Tools\Maintenance\Microsoft\Windows Installer Clean Up\msicuu.exe" /t REG_SZ /d "~ RUNASADMIN" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\System Tools\Maintenance\Service Installation Wizard\Srvinstw.exe" /t REG_SZ /d "~ RUNASADMIN" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\System Tools\Maintenance\ShortcutsSearchAndReplace\ShortcutsSearchAndReplace64.exe" /t REG_SZ /d "~ RUNASADMIN" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files\System Tools\Privacy\WPD\WPD.exe" /t REG_SZ /d "~ RUNASADMIN" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Shared Tools\Msinfo\Tools\MsiCU" /ve /t REG_SZ /d "Windows Installer Clean Up" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Shared Tools\Msinfo\Tools\MsiCU" /v "command" /t REG_SZ /d "C:\Program Files\System Tools\Maintenance\Microsoft\Windows Installer Clean Up\msicuu.exe" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Shared Tools\Msinfo\Tools\MsiCU" /v "description" /t REG_SZ /d "Runs Windows Installer Clean Up utility" /f >NUL 2>&1
	echo Setting 7+Taskbar Tweaker
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "hidetray" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "inspector_w" /t REG_DWORD /d "997" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "inspector_h" /t REG_DWORD /d "349" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "install_dir" /t REG_SZ /d "C:\Program Files\System Tools\System Utilities\7+ Taskbar Tweaker" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "language" /t REG_DWORD /d "1033" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "lefttrayfunc" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "MementoSectionUsed" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "MementoSection_StartMenuLnk" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "MementoSection_DesktopLnk" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "updcheck" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "updcheckauto" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker" /v "updchecktime" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Combining" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Grouping" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Keyboard Shortcuts" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Labeling" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Mouse Button Control" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069356" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069373" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069660" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069999" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1329809759" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1326387462" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318070012" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318070048" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069425" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1322745792" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069475" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069940" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1321127752" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1319067226" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069546" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069553" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069604" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069808" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069834" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069878" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069924" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1322639717" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1322639729" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069751" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1318069695" /t REG_DWORD /d "5" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1383174804" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1321056220" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1365090333" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Options" /v "1321056197" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "drag_towards_desktop" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "nocheck_minimize" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "nocheck_maximize" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "nocheck_close" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "pinned_ungrouped_animate_launch" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "sndvol_tooltip" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "tray_clock_fix_width" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "fix_hang_reposition" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "w7_tasklist_htclient" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "always_show_thumb_labels" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "scroll_reverse_cycle" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "scroll_reverse_minimize" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "multipage_wheel_scroll" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "show_desktop_button_size" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "tray_icons_padding" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "no_width_limit" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "w7_show_desktop_classic_corner" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "list_reverse_order" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "disable_topmost" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "multirow_equal_width" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "scroll_maximize_restore" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "always_show_tooltip" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "disable_taskbar_transparency" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "no_start_btn_spacing" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "right_drag_toggle_labels" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "show_desktop_on_hover" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "disable_items_drag" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "disable_tray_icons_drag" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "w10_large_icons" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "cycle_same_virtual_desktop" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "virtual_desktop_order_fix" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "scroll_no_wrap" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\OptionsEx" /v "show_labels" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKCU\Software\7 Taskbar Tweaker\Pinned grouping" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "7 Taskbar Tweaker" /t REG_SZ /d "\"C:\Program Files\System Tools\System Utilities\7+ Taskbar Tweaker\7+ Taskbar Tweaker.exe\" -hidewnd" /f >NUL 2>&1
	echo Adding "Open Hardware Monitor" to Administrative Tools Context Menu
	reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Open Hardware Monitor" /ve /t REG_SZ /d "Open Hardware Monitor" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Open Hardware Monitor" /v "icon" /t REG_SZ /d "C:\Program Files\System Tools\System Utilities\OpenHardwareMonitor\OpenHardwareMonitor.exe" /f >NUL 2>&1
	reg add "HKCR\DesktopBackground\Shell\Administrative and System Tools\shell\Open Hardware Monitor\Command" /ve /t REG_SZ /d "C:\Program Files\System Tools\System Utilities\OpenHardwareMonitor\OpenHardwareMonitor.exe" /f >NUL 2>&1

:END
	echo Done.
	cd /d "%TEMP%" & rmdir "CustomizeNextGen" /s /q >NUL 2>&1
	if "%Install%" == "FULL" exit /b
	timeout /t 3 /nobreak >NUL 2>&1
	exit /b

:NOADMIN
	echo You must have administrator rights to run this script.
	<nul set /p dummyName=Press any key to exit...
	pause >nul
	goto :eof
