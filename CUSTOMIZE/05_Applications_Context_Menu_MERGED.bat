@echo off

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>NUL 2>NUL || goto :NOADMIN

::**********************************
:: 01 NSudo Install and Context Menu
::**********************************
choice /C:YN /M "Do you want to install NSudo?"
if ERRORLEVEL 2 goto :NOTEPAD_PLUSPLUS
	setlocal
	echo Where do you want to install Nsudo?
	echo Enter the path here:
	set /p "NSudoFolder="
	set "RegKey=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
	pause
	cd /d "%~dp0"
	mkdir "%TEMP%\NSudoInstall" >NUL 2>&1
:: IMPORT
:: Check for 7z first (fastest)
	if exist "%ProgramFiles%\7-Zip\7z.exe" (
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -y -r -o"%TEMP%\NSudoInstall" >NUL & goto :INSTALL
	)
:: Check for WINRAR
	:WINRAR
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -ibck -o+ "%TEMP%\NSudoInstall" >NUL & goto :INSTALL
	)
:: Slowest option...
	:PS
	powershell -ExecutionPolicy Bypass -command "Expand-Archive -Path "05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip"  -DestinationPath "$env:TEMP\NSudoInstall" -Force" >NUL 2>&1
	:INSTALL
	robocopy "%TEMP%\NSudoInstall" "%NSudoFolder%" NSudo.exe >NUL 2>&1
	choice /C:YN /M "Do you want to install modified .json file?"
	if ERRORLEVEL 2 goto :TILE
	robocopy "%TEMP%\NSudoInstall" "%NSudoFolder%" NSudo.json >NUL 2>&1
	:TILE
	choice /C:YN /M "Do you want to add Start Menu Tile/icon as well?"
	if ERRORLEVEL 2 goto :STARTMENU
	robocopy "%TEMP%\NSudoInstall" "%NSudoFolder%" NSudo.visualelementsmanifest.xml >NUL 2>&1
	xcopy "%TEMP%\NSudoInstall\Images" "%NSudoFolder%\Images" /e /h /k /i /y >NUL 2>&1
	attrib +h "%NSudoFolder%\Images" >NUL 2>&1
	attrib +h "%NSudoFolder%\NSudo.visualelementsmanifest.xml" >NUL 2>&1
	:STARTMENU
	choice /C:YN /M "And Start Menu link?"
	if ERRORLEVEL 2 goto :CONTEXTMENU
	if exist "%programdata%\Microsoft\Windows\Start Menu\Programs\System\Nsudo.lnk" echo Skipped, link is already in Start Menu. & goto :CONTEXTMENU
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
	"%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\pathman.exe" /as "%NSudoFolder%"

:NOTEPAD_PLUSPLUS
choice /C:YN /M "Do you want to customize Notepad++ context menu?
if ERRORLEVEL 2 goto :03
	::************************************
	:: 02 Customize Notepad++ Context Menu
	::************************************
	:: Remove shell
	reg delete "HKCR\*\shellex\ContextMenuHandlers\ANotepad++64" /f >NUL 2>&1
	reg delete "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: Add New shell
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /ve /t REG_SZ /d "Notepad++64" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\InprocServer32" /ve /t REG_SZ /d "C:\Program Files\Notepad++\NppShell_06.dll" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\InprocServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\Settings" /v "Title" /t REG_SZ /d "Edit with Notepad++" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\Settings" /v "Path" /t REG_SZ /d "C:\Program Files\Notepad++\notepad++.exe" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\Settings" /v "Custom" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\Settings" /v "ShowIcon" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\Settings" /v "Dynamic" /t REG_DWORD /d "1" /f >NUL 2>&1
	reg add "HKCR\CLSID\{B298D29A-A6ED-11DE-BA8C-A68E55D89593}\Settings" /v "Maxtext" /t REG_DWORD /d "25" /f >NUL 2>&1
	:: Customize Classes
	reg add "HKCR\batfile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\cmdfile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\dllfile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\docxfile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\Microsoft.PowerShellData.1\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\Microsoft.PowerShellModule.1\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\Microsoft.PowerShellScript.1\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\inffile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\regfile\ShellEx\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\textfile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\txtfile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\VBSFile\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\VLC.m3u\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: SystemFileAssociations for plain text files
	reg add "HKCR\SystemFileAssociations\document\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\text\ShellEx\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: Additional File Associations
	:: ADML
	reg add "HKCR\SystemFileAssociations\.adml\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: ADMX
	reg add "HKCR\SystemFileAssociations\.admx\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: CFG
	reg add "HKCR\SystemFileAssociations\.cfg\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: CONFIG
	reg add "HKCR\SystemFileAssociations\.config\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: DAT
	reg add "HKCR\SystemFileAssociations\.dat\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: JSON
	reg add "HKCR\SystemFileAssociations\.json\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: M3U
	reg add "HKCR\SystemFileAssociations\.m3u\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: PAR
	reg add "HKCR\SystemFileAssociations\.par\shellex\ContextMenuHandlers\Notepad++64" /ve /t REG_SZ /d "{B298D29A-A6ED-11DE-BA8C-A68E55D89593}" /f >NUL 2>&1
	:: Additional 'Open with'
	reg add "HKCR\.adml" /ve /t REG_SZ /d "adml_auto_file" /f >NUL 2>&1
	reg add "HKCR\.admx" /ve /t REG_SZ /d "admx_auto_file" /f >NUL 2>&1
	reg add "HKCR\.cfg" /ve /t REG_SZ /d "cfg_auto_file" /f >NUL 2>&1
	reg add "HKCR\.config" /ve /t REG_SZ /d "config_auto_file" /f >NUL 2>&1
	reg add "HKCR\.dat" /ve /t REG_SZ /d "dat_auto_file" /f >NUL 2>&1
	reg add "HKCR\.json" /ve /t REG_SZ /d "json_auto_file" /f >NUL 2>&1
	reg add "HKCR\.par" /ve /t REG_SZ /d "par_auto_file" /f >NUL 2>&1
	reg add "HKCR\adml_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\admx_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\cfg_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\config_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\dat_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\json_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\par_auto_file\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\Notepad++\notepad++.exe\" \"%%1\"" /f >NUL 2>&1
	:: Shorten FriendlyAppName
	reg add "HKCR\Local Settings\Software\Microsoft\Windows\shell\MuiCache" /v "C:\Program Files\Notepad++\notepad++.exe.ApplicationCompany" /t REG_SZ /d "Don HO don.h@free.fr" /f >NUL 2>&1
	reg add "HKCR\Local Settings\Software\Microsoft\Windows\shell\MuiCache" /v "C:\Program Files\Notepad++\notepad++.exe.FriendlyAppName" /t REG_SZ /d "Notepad++" /f >NUL 2>&1

:03
choice /C:YN /M "Do you want to add MBAM Shell Extension flags (to display close to Win Defender in context menu)?"
if ERRORLEVEL 2 goto :04
::****************************************************************
:: 03 SET MalwareBytes Anti Malware Shell Extension flags (BOTTOM)
::****************************************************************
	reg add "HKCR\CLSID\{57CE581A-0CB6-4266-9CA0-19364C90A0B3}" /v "flags" /t REG_DWORD /d "0" /f >NUL 2>&1

:04
choice /C:YN /M "Do you want to add 'Open with Photoshop' for images and image folders?"
if ERRORLEVEL 2 goto :05
::**********************************************************
:: 04 ADD 'Open with Photoshop' for images and image folders
::**********************************************************
	::Images
	reg add "HKCR\SystemFileAssociations\image\shell\Open with Photoshop" /v "Icon" /t REG_SZ /d "\"C:\Program Files\Adobe\Adobe Photoshop CC 2018\Photoshop.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\image\shell\Open with Photoshop" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\image\shell\Open with Photoshop\command" /ve /t REG_SZ /d "\"C:\Program Files\Adobe\Adobe Photoshop CC 2018\Photoshop.exe\" \"%%1\"" /f >NUL 2>&1
	::Image folders
	reg add "HKCR\SystemFileAssociations\Directory.Image\shell\Open with Photoshop" /v "Icon" /t REG_SZ /d "\"C:\Program Files\Adobe\Adobe Photoshop CC 2018\Photoshop.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Image\shell\Open with Photoshop" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Image\shell\Open with Photoshop" /v "MUIVerb" /t REG_SZ /d "Open folder contents with Photoshop" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Image\shell\Open with Photoshop\command" /ve /t REG_SZ /d "\"C:\Program Files\Adobe\Adobe Photoshop CC 2018\Photoshop.exe\" \"%%1\"" /f >NUL 2>&1

:05
choice /C:YN /M "Do you want to add 'Open with VLC' for audio files and 'Add to VLC media player playlist' for audio folders?"
if ERRORLEVEL 2 goto :06
::************************************************************************************************
:: 05 ADD 'Open with VLC' for audio files and 'Add to VLC media player playlist' for audio folders
::************************************************************************************************
	::Audio files
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with VLC" /ve /t REG_SZ /d "Open with VLC" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with VLC" /v "Icon" /t REG_SZ /d "\"C:\Program Files\VideoLAN\VLC\vlc.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with VLC" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with VLC\command" /ve /t REG_SZ /d "\"C:\Program Files\VideoLAN\VLC\vlc.exe\" --started-from-file \"%%1\"" /f >NUL 2>&1
	::Audio folders
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Add to VLC media player playlist" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Add to VLC media player playlist" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Add to VLC media player playlist\command" /ve /t REG_SZ /d "\"C:\Program Files\VideoLAN\VLC\vlc.exe\" --started-from-file --playlist-enqueue \"%%1\"" /f >NUL 2>&1

:06
choice /C:YN /M "Do you want to add 'Open with Sound Forge Pro' for audio files and audio folders?"
if ERRORLEVEL 2 goto :07
::*********************************************************************
:: 06 ADD 'Open with Sound Forge Pro' for audio files and audio folders
::*********************************************************************
	::Audio files
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with Sound Forge Pro" /ve /t REG_SZ /d "Open with Sound Forge Pro" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with Sound Forge Pro" /v "Icon" /t REG_SZ /d "\"C:\Program Files\Sound Forge\Sound Forge Pro 12.0\Forge120.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with Sound Forge Pro" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with Sound Forge Pro\command" /ve /t REG_SZ /d "\"C:\Program Files\Sound Forge\Sound Forge Pro 12.0\Forge120.exe\" \"%%1\"" /f >NUL 2>&1
	::Audio folders
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with Sound Forge Pro" /ve /t REG_SZ /d "Open with Sound Forge Pro" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with Sound Forge Pro" /v "Icon" /t REG_SZ /d "\"C:\Program Files\Sound Forge\Sound Forge Pro 12.0\Forge120.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with Sound Forge Pro" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with Sound Forge Pro\command" /ve /t REG_SZ /d "\"C:\Program Files\Sound Forge\Sound Forge Pro 12.0\Forge120.exe\" \"%%1\"" /f >NUL 2>&1

:07
choice /C:YN /M "Do you want to add 'Open with iZotope RX' for audio files and audio folders?"
if ERRORLEVEL 2 goto :08
::****************************************************************
:: 07 ADD 'Open with iZotope RX' for audio files and audio folders
::****************************************************************
	::Audio files
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with iZotope RX" /ve /t REG_SZ /d "Open with iZotope RX" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with iZotope RX" /v "Icon" /t REG_SZ /d "\"C:\Program Files (x86)\iZotope\RX 7 Audio Editor\win64\iZotope RX 7 Audio Editor.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with iZotope RX" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\audio\shell\Open with iZotope RX\command" /ve /t REG_SZ /d "\"C:\Program Files (x86)\iZotope\RX 7 Audio Editor\win64\iZotope RX 7 Audio Editor.exe\" \"%%1\"" /f >NUL 2>&1
	::Audio folders
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with iZotope RX" /ve /t REG_SZ /d "Open with iZotope RX" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with iZotope RX" /v "Icon" /t REG_SZ /d "\"C:\Program Files (x86)\iZotope\RX 7 Audio Editor\win64\iZotope RX 7 Audio Editor.exe\"" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with iZotope RX" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\SystemFileAssociations\Directory.Audio\shell\Open with iZotope RX\command" /ve /t REG_SZ /d "\"C:\Program Files (x86)\iZotope\RX 7 Audio Editor\win64\iZotope RX 7 Audio Editor.exe\" \"%%1\"" /f >NUL 2>&1

:08
choice /C:YN /M "Do you want to customize 7-zip and WinRAR context menu appearance (display them together, with 7-zip first)?"
if ERRORLEVEL 2 goto :END
:: *********************************
:: 08 WinRAR and 7-zip Context Menus
:: *********************************
	:: 7-zip flags value
	reg add "HKCR\CLSID\{23170F69-40C1-278A-1000-000100020000}" /v "flags" /t REG_DWORD /d "1" /f >NUL 2>&1
	:: WinRAR flags value
	reg add "HKCR\CLSID\{B41DB860-64E4-11D2-9906-E49FADC173CA}" /v "flags" /t REG_DWORD /d "1" /f >NUL 2>&1
	:: Classes
	reg add "HKCR\.7z" /ve /t REG_SZ /d "7-Zip.7z" /f >NUL 2>&1
	reg add "HKCR\.zip" /ve /t REG_SZ /d "7-Zip.zip" /f >NUL 2>&1
	reg add "HKCR\7-Zip.7z" /ve /t REG_SZ /d "7z Archive" /f >NUL 2>&1
	reg add "HKCR\7-Zip.7z\DefaultIcon" /ve /t REG_SZ /d "C:\Program Files\7-Zip\7z.dll,0" /f >NUL 2>&1
	reg add "HKCR\7-Zip.7z\shell" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\7-Zip.7z\shell\open" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\7-Zip.7z\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\7-Zip\7zFM.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\7-Zip.zip" /ve /t REG_SZ /d "zip Archive" /f >NUL 2>&1
	reg add "HKCR\7-Zip.zip\DefaultIcon" /ve /t REG_SZ /d "C:\Program Files\7-Zip\7z.dll,1" /f >NUL 2>&1
	reg add "HKCR\7-Zip.zip\shell" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\7-Zip.zip\shell\open" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\7-Zip.zip\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\7-Zip\7zFM.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\.rar" /ve /t REG_SZ /d "WinRAR" /f >NUL 2>&1
	reg add "HKCR\.rar\ShellNew" /v "FileName" /t REG_SZ /d "C:\Program Files\WinRAR\rarnew.dat" /f >NUL 2>&1
	:: ContextMenuHandlers
	reg delete "HKCR\*\shellex\ContextMenuHandlers\WinRAR32" /f >NUL 2>&1
	reg delete "HKCR\Folder\shellex\ContextMenuHandlers\WinRAR32" /f >NUL 2>&1
	reg delete "HKCR\Drive\shellex\DragDropHandlers\WinRAR32" /f >NUL 2>&1
	reg delete "HKCR\Folder\shellex\DragDropHandlers\WinRAR32" /f >NUL 2>&1
	reg delete "HKCR\WinRAR\shellex\ContextMenuHandlers" /f >NUL 2>&1
	reg delete "HKCR\WinRAR.ZIP\shellex\ContextMenuHandlers" /f >NUL 2>&1
	reg add "HKCR\WinRAR" /ve /t REG_SZ /d "WinRAR archive" /f >NUL 2>&1
	reg add "HKCR\WinRAR\DefaultIcon" /ve /t REG_SZ /d "C:\Program Files\WinRAR\WinRAR.exe,0" /f >NUL 2>&1
	reg add "HKCR\WinRAR\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\WinRAR\WinRAR.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\WinRAR\shellex\ContextMenuHandlers\{23170F69-40C1-278A-1000-000100020000}" /f >NUL 2>&1
	reg add "HKCR\WinRAR\shellex\ContextMenuHandlers\{B41DB860-64E4-11D2-9906-E49FADC173CA}" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\WinRAR\shellex\DropHandler" /ve /t REG_SZ /d "{B41DB860-64E4-11D2-9906-E49FADC173CA}" /f >NUL 2>&1
	reg add "HKCR\WinRAR\shellex\PropertySheetHandlers\{B41DB860-64E4-11D2-9906-E49FADC173CA}" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP" /ve /t REG_SZ /d "WinRAR ZIP archive" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP\DefaultIcon" /ve /t REG_SZ /d "C:\Program Files\WinRAR\WinRAR.exe,0" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP\shell\open\command" /ve /t REG_SZ /d "\"C:\Program Files\WinRAR\WinRAR.exe\" \"%%1\"" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP\shellex\ContextMenuHandlers\{23170F69-40C1-278A-1000-000100020000}" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP\shellex\ContextMenuHandlers\{B41DB860-64E4-11D2-9906-E49FADC173CA}" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP\shellex\DropHandler" /ve /t REG_SZ /d "{B41DB860-64E4-11D2-9906-E49FADC173CA}" /f >NUL 2>&1
	reg add "HKCR\WinRAR.ZIP\shellex\PropertySheetHandlers\{B41DB860-64E4-11D2-9906-E49FADC173CA}" /ve /t REG_SZ /d "" /f >NUL 2>&1
	reg add "HKCU\Software\7-Zip\Options" /v "ContextMenu" /t REG_DWORD /d "4919" /f >NUL 2>&1
	reg add "HKCU\Software\7-Zip\Options" /v "MenuIcons" /t REG_DWORD /d "1" /f >NUL 2>&1

:END
	echo Done.
	cd /d "%TEMP%" & rmdir "NSudoInstall" /s /q >NUL 2>&1
	if "%Install%" == "FULL" exit /b
	timeout /t 3 /nobreak >NUL 2>&1
	exit /b

:NOADMIN
	echo You must have administrator rights to run this script.
	<nul set /p dummyName=Press any key to exit...
	pause >nul
	goto :eof
