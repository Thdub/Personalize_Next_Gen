# Personalize_Next_Gen
OS extensive personalization

Download: https://github.com/Thdub/Personalize_Next_Gen/releases

Infos: https://forums.mydigitallife.net/threads/custom-policies-set.78129/#post-1488737


---------------------------------------------------------------------------------------------------
# PERSONALIZE PROJECT NEXTGEN CONTENTS

---------------------------------------------------------------------------------------------------
# CUSTOMIZE ALL

---------------------------------------------------------------------------------------------------
01 DEBLOAT Context Menu

-01 Remove 'print' and 'printto' for common text-based files and internet shortcuts.
    Some of the registry keys have permissions locked by default, so you might need to add that file through NSudo for complete optimization, or run batch file.

-02 Remove 3D Edit from Context Menu.

-03 Remove 3D Print from Context Menu.

-04 Optimize/Debloat Context Menu. 
    Hide: Compatibility, Offline Files, Playto, Workfolder.
    Why "hide"? For convenience and safety reasons, registry values are not deleted, but renamed with a ? placed in front.
    Doing so it "hides" the context menu item instead of deleting it, allowing easier recovery if needed: 
    It's also simpler to search for ?{ in your favorite registry application, if you need to find those keys.
    
    -Compatibility: It will not hide or disable compatibility tab in properties, neither disable application compatibility assistant and/or engine (which I personally turned off via GPO).
    but wil just hide the "useless" context menu entry.
    -Offline Files: you don't need offline files if you don't use sync center.
    -PlayTo is deprecated.
    -Workfolder: Useless when you only have/use one computer (which isn't in a network/domain) and/or don't need to set workfolders.
   
---------------------------------------------------------------------------------------------------
# 02 CUSTOMIZE Context Menu

I added some screenshots in the folder to help you determine which settings you'd like to apply.
CF included Context Menus screenshots.

Run 'Install_Required_Scripts_and_Tools.exe' or 'Install_Required_Scripts_and_Tools.bat', if you want to install "Check for updates" script and icon, and ms-settings icons.
"Windows Update" script and icon will be extracted to "C:\Program Files\System Tools\Maintenance\Scripts"
ms-settings icons will be extracted to "C:\Program Files\System Tools\System Utilities\Icons"


-01 Add 'Pin To Start' or .exe, links and folders

-02 Add 'Open Command window here (Administrator)' and 'Open Powershell window here (Administrator)' to Extended Context Menu.
	Note: Needs NSudo.
	"Powershell" and "Runas" keys have permissions locked by default, so you might need to add some registry keys through NSudo, or run batch file.
	Single .reg will only install Context Menu
	Main Scripts* will install Context Menu, and NSudo to your chosen location.

-03 Add 'Hash' context menu to get files hash (SHA1,SHA256,SHA384,MACTripleDES,MD5,RIPEMD160 algorithms).

-04 Add 'Extract Contents' for .msi files : Useful to extract files from MSI installers.

-05 Scan with Windows Defender Context Menu for files, Directories and Drives (Windows Defender Command Line Utility)
	Note: Runs a scan with Windows Defender command line utility, without the need to launch Windows Defender program/UI
	Also useful for Windows Server that comes without Windows Defender shell extension (EPP Shell/{09A47860-11B0-4DA5-AFA5-26D86198A780} CLSID)

-06 Add 'Windows Defender exclusions': Add/remove Windows Defender exclusions directly from context menu
	Credits @BAU for commands and concept.

07 Directory Background: Restart Explorer

08 Directory Background: Enhanced ScreenSnip and Snipping Tools.

09 Open Disk Cleaner Recycle Bin Context Menu

10 Install CAB Update for .cab files: Useful to install .cab hotfixes

11 Send selection to New folder

12 Move_Selection to New folder

13 Permissions Context Menu:

DB01 - 	Desktop Background : Administrative and System Tools

DB02 -	Desktop Background : Appearance

DB03 -	Desktop Background : Control Panel cascading Context Menu with 'Control Panel' and 'Master Control Panel' subcommands
	
DB04 -	Desktop Background : Settings cascading Context Menu, containing all main ms-settings pages
	Note: Windows Security will open Windows Security UI directly, instead of the 'Security Settings' page (ms-settings:windowsdefender)
	Main scripts* will install custom icon for Windows Update

DB05 -  Desktop Background : System

DB06 - 	Desktop Background :WindowsDefender_Toggle
	Credits to @ for the idea.

DB07 - 	Desktop Background : WindowsFirewall_Toggle
	Note: Custom script will also work for people who use Windows Firewall Control with 'Secure Profile' enabled

DB08 -	Desktop Background : Windows Update
	Special script designed to use with Windows Firewall Control: 
	It will temporary bypass Windows Firewall Control Secure Profile and check for Windows Updates, and then re-activate Firewall Security Profile after update is/are installed.
	Notes: 
	-Needs NSudo to unlock registry keys.
	-Single .reg will only instal context menu. You need to install script manually from requiredscriptandtools.zip or run main scripts*
	Main Scripts* will install Context Menu, Script and NSudo to your chosen location as well as custom icon for Windows Update	
	-I also added transparent .png icons, together with CheckUpdates.visualelementsmanifest.xml, 
	-Files will be extracted to "C:\Program Files\System Tools\Maintenance\Scripts\CheckUpdatesWFC"
	
	More infos: https://forums.mydigitallife.net/threads/windows-firewall-configuration-truly-block-everything.64640/page-14#post-1484425

---------------------------------------------------------------------------------------------------
# 03 CUSTOMIZE Control Panel

-01 ADD 'Classic Personalization' to Control Panel

-02 ADD 'Windows Update' to Control Panel


---------------------------------------------------------------------------------------------------
# 04 CUSTOMIZE System/appeareance

-01 Explorer Personalization: Some personalizations found under HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced registry key.

-02 REMOVE '3D Objects'

-03 No 'People Contacts' pinned to taskbar (sets "CapacityOfPeopleBar" value to 0)

-04 REMOVE 'People' button from taskbar

-05 REMOVE external drives from Windows Navigation Pane

-06 Drive letter position (After/Default)
Note: This is default value. If you want 'Drive Letters' to appear before 'Drive Label', set dword value to 1 (dword:00000001)

-07 SHOW seconds on taskbar clock



---------------------------------------------------------------------------------------------------
# 05 Applications Context Menus

-01 NSudo context menu: NSudo context menu for .exe instead of all file when installing NSudo.exe using -install switch

-02 Notepad++ context menu: Notepad++ context menu personalized for files types it can open, instead of all files

-03 MBAM Flags: For people who use Malwarebytes Anti Malware
Note: Just cosmetic. Changes shell extension position so it will displays at bottom (flags=0), together with "Scan with Windows Defender" and "Windows Defender Exclusions" context menus

-04 ADD "Open with Photoshop" for images and image folders (Note: For Photoshop users)

-05 ADD "Open with VLC" for audio files and "Add to VLC media player playlist" for audio folders

-06 ADD "Open with Sound Forge Pro" for audio files and audio folders (Note: for Audio professionals)

-07 ADD "Open with iZotope RX" for audio files and audio folders (Note: for Audio professionals)


---------------------------------------------------------------------------------------------------
# 06 CUSTOMIZE WinX Menu

Simply run application .exe, or related .bat script.

-01 Customize WinX menu. Personalized menu with (Order from top to bottom):
 
   Group3:
   Programs and Features
   Power Options
   Event Viewer
   Registry Editor
   Performance Monitor
   Computer Management
   Disk Management
   Device Manager
   Task Manager
   Task Scheduler
   Services
   Network Connections
   Command Prompt (Admin)

   Group2:
   Control Panel
   Settings
   System
   Snipping Tool
   Calculator
   File Explorer
   Search
   Run
 
-02 Customize WinX menu (same layout), with Registry Workshop instead of Registry Editor
Note: This is my favorite registry editor for many reasons, the main ones being its history/undo and search/replace options.

-03 Replace File Explorer with File Explorer (Trusted Installer)
Note: It will extract 'RunExplorerShellAsTrustedInstaller.exe' to "C:\Program Files\System Tools\System Utilities\Custom Tools"
Based on my script that allows to launch an Explorer shell with Trusted Installer privileges
https://forums.mydigitallife.net/threads/run-explorer-as-ti.78329/

-04 Add 'Lock' to WinX menu (in Group 1, above 'Shut Down' options menu)
Note: Lock is available in Start Menu by clicking on your account icon, but not in WinX menu where in the same time you can have sleep, hibernate and sign-out under "shutdown" drop down menu...
Strange Microsoft design decisions...fixed now(somehow).


--------------------------------------------------------
"CUSTOMIZE WinX Menu" Notes:
Look at the provided screenshots to determine which setting to apply.

If you want to remove an entry from WinX menu, delete its shortcut from %LocalAppdata%\Microsoft\Windows\WinX

If you want to add custom links, you can't just copy shortcuts there, you'll need to add a validated hash to the shortcut before.
For that, use either hashlnk: https://github.com/riverar/hashlnk or WinX Menu Editor: https://winaero.com/comment.php?comment.news.30

hashlnk direct download link:
https://github.com/riverar/hashlnk/blob/master/bin/hashlnk_0.2.0.0.zip

WinX Menu Editor direct download link:
https://winaero.com/request.php?21
--------------------------------------------------------


--------------------------------------------------------------------------------------------------
# 07 Install Additional Scripts and Tools

Simply run "Install_Additional_Scripts_and_Tools.exe or "Install_Additional_Scripts_and_Tools.bat to install additional scripts and tools.
I also added a few (free) utilities that I use often.

1) - Custom Tools:

-Optimize SERVER Services.exe: Script utility to optimize Server services.
-Optimize LTSC Services.exe: Script utility to optimize LTSC services.

Both utilities are based on my script which launches Nsudo and allows to change protected registry keys and services. It required intensive services testing/debugging...
https://forums.mydigitallife.net/threads/solved-script-to-automate-services-default-state.78221/#post-1482368

These 2 utilities will be extracted to "C:\Program Files\System Tools\Maintenance\Services Optimization"


-RunExplorerShellAsTrustedInstaller.exe

Based on my script that allows to launch an Explorer shell with Trusted Installer privileges
https://forums.mydigitallife.net/threads/run-explorer-as-ti.78329/

I also added tranparent .png icons, together with RunExplorerShellAsTrustedInstaller.visualelementsmanifest.xml,
which add the ability to display a custom transparent tile on your start menu panel, as well as custom background colour for this tile.
You can edit the .xml file to change tile background color (only accept hex color value), or change text "color" displayed on big tile (only accept "dark" or "light" values).
You can also edit the picture or change with custom ones if you like.

To reset tile (to see the changes), enter this code in Powershell:
	(ls "$env:programdata\Microsoft\Windows\Start Menu\Programs\YOURLINKPATH\YOURLINKNAME.lnk").lastwritetime = get-date
or if your link is in the "other" start menu :
	(ls "$env:appdata\Microsoft\Windows\Start Menu\Programs\YOURLINKPATH\YOURLINKNAME.lnk").lastwritetime = get-date
* Replace 'YOURLINKPATH' and 'YOURLINKNAME' with your own, of course...

Note: 'RunExplorerShellAsTrustedInstaller' application and files will be extracted to "C:\Program Files\System Tools\System Utilities\Custom Tools"



2) - Maintenance Scripts (custom):

-CleanRevoUninstallerFolders.bat : Clear Revo Uninstaller leftovers from uninstalled applications (found in %USERPROFILE%\AppData\Local\VS Revo Group\Revo Uninstaller Pro), moving them to Recycle Bin.

-CleanTempFolder_Move_to_Recycle_Bin.ps1 : Move your TEMP folder contents to Recycle Bin. Much safer...
Long time since I wanted to make that script to move TEMP contents to Recycle Bin, instead of deleting and sending files into space...

-ClearEventViewerLogs.bat : Simply clear Event Viewer logs...

-Make Start Menu Links as Admin.ps1 : script to make some start menu links as admin, like powershell, cmd, and maintenance batch scripts.
Function cmdlet created by http://rudolfvesely.com (and customized by myself). You can fully customize this script editing last lines, for example:
	Get-ChildItem -Path "$env:programdata\Microsoft\Windows\Start Menu\Programs\Musique\"  -recurse | Where-Object {$_.Name -like "*lnk*" -and $_.Name -like "*Uninstall*"} | Set-RvShortcutToRunAsAdministrator -Verbose
You see it is not limited to start menu, you could make any link from a choosen folder as admin in fact.

-ResetNotificationAreaIconsCache.bat : Resets Notification Area icons cache.


Note: Maintenance scripts will be extracted to "C:\Program Files\System Tools\System Utilities\Maintenance\Scripts"



3) - Custom Scripts :

-DriversBackup_Desktop.ps1 : It will export all your 3rd party drivers, change drivers name to a more "human readable" mode, and sort them in folder by classname (graphic/Network/etc.)
Note: Folder is extracted in 'TEMP' folder and then compressed as DriversBackup.zip on your Desktop. 

Going further: If you want to keep the whole folder (and not a .zip), and change the path, replace last 2 lines with something like:
	Move-Item "$DestinationPath" -Destination "C:\YOUR_OWN_BACKUP_PATH" -Force
(-Force will "force replace" if folder already exist at YourDestination)
or simply delete last 2 lines and replace $DestinationPath defined variable at line 9.

-Export_StartMenuLayout_and_make_Default.ps1 : Simple script to backup your start menu layout, and copy as Layoutmodifications.xml in Default profile, so it is loaded when you install/reinstall.
It can be also useful when you are fighting with your start menu tiles (tiles resetting)

Going further: if you want to keep old saved one, for example, replace code with:
	Export-StartLayout -Path "$env:UserProfile\Desktop\LayoutModification.xml" -verbose
	Copy-Item "$env:UserProfile\Desktop\LayoutModification.xml" -Destination "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml" -Force
	Copy-Item "$env:UserProfile\Desktop\LayoutModification.xml" -Destination "$env:LocalAppData\Microsoft\Windows\Shell\LayoutModification.xml" -Force
	Move-Item "C:\YOUR_OWN_BACKUP_PATH\LayoutModification.xml" -Destination "C:\YOUR_OWN_BACKUP_PATH\LayoutModification_old.xml" -Force
	Move-Item "$env:UserProfile\Desktop\LayoutModification.xml" -Destination "C:\YOUR_OWN_BACKUP_PATH\LayoutModification.xml" -Force
* Replace 'YOUR_OWN_BACKUP_PATH' with your own, of course...

-RegWorkshopX64_TI.bat : Launches Registry Workshop with Trusted Installer privileges (NSudo and Registry workshop required).
I just love Registry workshop (it's not free, though), Registry Editor at its best.

-StartAcronisTrueImageWithServices.bat : Start Acronis True Image with its required services, and set them back to "Disabled" (for next reboot).
Note: Those services are disabled by "Optimize Services Tool", and only needed for Acronis True Image. "Disabled" state (also set when you run 'Optimize Services' tool) will be back at startup.

-StartServerManagerWithServices.bat : For Windows Server 2019, starts Server Manager with required services, and set them back to "Disabled" (for next reboot).
Note: Those services are disabled by "Optimize Services Tool", and only needed for Server Manager. "Disabled" state (also set when you run 'Optimize Services' tool) will be back at startup.


Note: All these scripts will be extracted to "C:\Program Files\System Tools\System Utilities\Scripts"



4) - Telemetry:

-Telemetry script for both Windows and Office: It's a mixup between abbodi1406 telemetry script and OfficeRtool telemetry script from ratzlefatz, with few more entries.

-WPD : https://wpd.app/ is good.


5) - Maintenance Applications:

-DeviceCleanup : Clean hidden "leftovers" in device manager after you uninstalled a device.
https://www.uwe-sieber.de/misc_tools_e.html

-Driver Store Explorer : list your 3rd party drivers, uninstall old/obsolete drivers, install drivers.
https://github.com/lostindark/DriverStoreExplorer

-Microsoft Windows 'Installer Clean Up' and 'Program Install and Uninstall Troubleshooter' : Solve installer problems with missing files and/or registry entries.

-Service Installation Wizard (Srvinstw.exe) : GUI utility to install or delete any service. I advice not to do this, but you can use in conjunction with NSudo to delete "protected services".

-ShortcutsSearchAndReplace : Find dead links and replace them in a batch.
http://jacquelin.potier.free.fr/ShortcutsSearchAndReplace/



6) - System Utilities:

- 7+ Taskbar Tweaker : Very handy taskbar utility, set with the ability to move your pinned taskbar items INDEPENDENTLY!
You can customize many taskbar settings...
Note: Runs at startup. 
https://rammichael.com/7-taskbar-tweaker

-NTFSlinksview : View NTFS symbolic links and junction points
https://www.nirsoft.net/utils/ntfs_links_view.html

I advice you to check also (VERY USEFUL) Linkshellextension : http://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html
With this context menu shell extension, you can create all sort of links (junctions,hardlinks,symlink) in just 2 clicks. Check it out!

-Nsudo : Also required for custom DesktopBackground context menu. 
https://github.com/M2Team/NSudo

-OpenHardwareMonitor: Monitor your fans/cpu/graphic card temp and speeds.
https://openhardwaremonitor.org/

-UsbTreeView : See "which device is plugged in which usb port" : Informations from the Windows Device Management are collected and matched with the found USB devices, therefore UsbTreeView can show the child devices, including drive letters and COM-ports 
https://www.uwe-sieber.de/usbtreeview_e.html

-NirCmd : Usefull to hide windows and customize context menu


---------------------------------------------------------------------------------------------------
# RESTORE DEFAULT

'RESTORE DEFAULT' folder is an EXACT "mirror reflection" of the 'CUSTOMIZE' folder with all the "inverted" registry tweaks, which allows to REVERSE EVERY SINGLE TWEAK you could have made.

-01 Context Menu DEBLOAT_RESTORE (Registry settings)
-02 Context Menu CUSTOMIZE_REMOVE (Registry settings)
-03 Control Panel_RESTORE (Registry settings)
-04 System_RESTORE (Registry settings)
-05 Applications_REMOVE (Registry settings)

-06 WinX_RESTORE (Application or Script): Just run the applications (or related scripts). It will restore Windows 10 Default WinX menu (v.1703 to 1809)
	- DefaultWinX : Restore Default WinX Menu
	- DefaultWinX_Group2 : Restore Default WinX Menu Group2 only
	- DefaultWinX_Group3 : Restore Default WinX Menu Group3 only
	- DefaultWinX_Remove_Lock : Remove Lock option from WinX Menu Group 1
