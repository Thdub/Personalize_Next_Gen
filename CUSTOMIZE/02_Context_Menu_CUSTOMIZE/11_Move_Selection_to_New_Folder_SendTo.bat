@echo off

echo ***************************************************************************************
echo 11 ADD "Move to New Folder" Capabilities to explorer Context Menu with Sendto shortcuts
echo ***************************************************************************************
:: Requires provided script. If you want to hide cmd window totally, use nircmd or Nsudo.
	powershell -ExecutionPolicy Bypass -command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\SendTo\New folder.lnk');$s.TargetPath='C:\Program Files\System Tools\System Utilities\Scripts\Sendto\SendtoNewFolder.bat';$s.WorkingDirectory='%AppData%\Microsoft\Windows\SendTo';$s.WindowStyle=7;$s.Description='Move selection to a new folder';$s.IconLocation='%SystemRoot%\System32\SHELL32.dll,4';$s.Save()" >NUL 2>&1
	powershell -ExecutionPolicy Bypass -command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\SendTo\Folder (named as file).lnk');$s.TargetPath='C:\Program Files\System Tools\System Utilities\Scripts\Sendto\SendtoFolderName.bat';$s.WorkingDirectory='%AppData%\Microsoft\Windows\SendTo';$s.WindowStyle=7;$s.Description='Move selection to a new folder, named as first item selected.';$s.IconLocation='%SystemRoot%\System32\SHELL32.dll,4';$s.Save()" >NUL 2>&1
	powershell -ExecutionPolicy Bypass -command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\Microsoft\Windows\SendTo\Folder... (choose name).lnk');$s.TargetPath='C:\Program Files\System Tools\System Utilities\Scripts\Sendto\SendtoFolder.bat';$s.WorkingDirectory='%AppData%\Microsoft\Windows\SendTo';$s.Description='Prompt for a folder name and move selection to that folder';$s.IconLocation='%SystemRoot%\System32\SHELL32.dll,4';$s.Save()" >NUL 2>&1
exit /b
