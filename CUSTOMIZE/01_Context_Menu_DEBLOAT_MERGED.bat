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
	"%ProgramFiles%\7-Zip\7z.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -y -r -o"%TEMP%\NSudo" >NUL 2>&1
	goto :NSudo
	)
	if exist "%programFiles%\WinRAR\WinRAR.exe" (
	"%programFiles%\WinRAR\WinRAR.exe" x "%~dp0\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -ibck -o+ "%TEMP%\NSudo" >NUL 2>&1
	goto :NSudo
	)
	powershell -ExecutionPolicy Bypass "Expand-Archive -Path ".\05_Applications_Context_Menu\01_NSudo_Installer\NSudoFolder.zip" -DestinationPath "$env:TEMP\NSudo" -Force" >NUL 2>&1

:NSudo
	"%TEMP%\Nsudo\NSudoC.exe" -U:T -P:E -Wait -UseCurrentConsole "%~dpnx0"& exit /b >NUL 2>&1

:OK
echo **********************
echo RESTORE DEFAULT VALUES
echo **********************
reg add "HKCR\Applications\photoviewer.dll\shell\print" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f >NUL 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f >NUL 2>&1
reg add "HKCR\batfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\NOTEPAD.EXE /p %%1" /f >NUL 2>&1
reg add "HKCR\cmdfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\NOTEPAD.EXE /p %%1" /f >NUL 2>&1
reg add "HKCR\contact_wab_auto_file\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows Mail\wab.exe\" /Print \"%%1\"" /f >NUL 2>&1
reg add "HKCR\docxfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\docxfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\emffile\shell\print\command" /f >NUL 2>&1
reg add "HKCR\emffile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\FaxCover.Document\shell\print\command" /ve /t REG_SZ /d "C:\Windows\System32\fxscover.exe /P \"%%1\"" /f >NUL 2>&1
reg add "HKCR\fonfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\fontview.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\giffile\shell\printto" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\giffile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\rundll32.exe\" \"%%SystemRoot%%\System32\shimgvw.dll\",ImageView_PrintTo /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\group_wab_auto_file\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows Mail\wab.exe\" /Print \"%%1\"" /f >NUL 2>&1
reg add "HKCR\htmlfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\rundll32.exe\" \"%%systemroot%%\system32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\htmlfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\rundll32.exe\" \"%%systemroot%%\system32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.HTM\shell\print\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.HTM\shell\printto\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.SVG\shell\print\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.SVG\shell\printto\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.URL\shell\print\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.URL\shell\printto\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.XHT\shell\print\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintXHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\IE.AssocFile.XHT\shell\printto\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintXHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\inffile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE /p %%1" /f >NUL 2>&1
reg add "HKCR\inifile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE /p %%1" /f >NUL 2>&1
reg add "HKCR\InternetShortcut\shell\print\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\InternetShortcut\shell\printto\command" /ve /t REG_SZ /d "\"C:\Windows\System32\rundll32.exe\" \"C:\Windows\System32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\jpegfile\shell\printto" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\jpegfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\rundll32.exe\" \"%%SystemRoot%%\System32\shimgvw.dll\",ImageView_PrintTo /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\JSEFile\shell\Print\Command" /ve /t REG_SZ /d "C:\Windows\System32\Notepad.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\JSFile\shell\Print\Command" /ve /t REG_SZ /d "C:\Windows\System32\Notepad.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\odtfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\odtfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\opensearchresult\shell\print\command" /ve /t REG_EXPAND_SZ /d "rundll32.exe %%windir%%\system32\mshtml.dll,PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\otffile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\fontview.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\Paint.Picture\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\PBrush\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\PBrush\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\pfmfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\fontview.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\pjpegfile\shell\printto" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\pjpegfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\rundll32.exe\" \"%%SystemRoot%%\System32\shimgvw.dll\",ImageView_PrintTo /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\pngfile\shell\printto" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\pngfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\rundll32.exe\" \"%%SystemRoot%%\System32\shimgvw.dll\",ImageView_PrintTo /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\regfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\notepad.exe /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\rlefile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\rlefile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\rtffile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\rtffile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\svgfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\rundll32.exe\" \"%%systemroot%%\system32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\svgfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\rundll32.exe\" \"%%systemroot%%\system32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\image\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\image\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f >NUL 2>&1
reg add "HKCR\textfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\textfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\TIFImage.Document\shell\printto" /v "NeverDefault" /t REG_SZ /d "" /f >NUL 2>&1
reg add "HKCR\TIFImage.Document\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\rundll32.exe\" \"%%SystemRoot%%\System32\shimgvw.dll\",ImageView_PrintTo /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\ttcfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\fontview.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\ttffile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\fontview.exe /p %%1" /f >NUL 2>&1
reg add "HKCR\txtfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE /p %%1" /f >NUL 2>&1
reg add "HKCR\txtfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\notepad.exe /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\VBEFile\shell\Print\Command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\Notepad.exe\" /p %%1" /f >NUL 2>&1
reg add "HKCR\VBSFile\shell\Print\Command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\Notepad.exe\" /p %%1" /f >NUL 2>&1
reg add "HKCR\wdpfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "rundll32.exe %%SystemRoot%%\system32\shimgvw.dll,ImageView_Fullscreen %%1" /f >NUL 2>&1
reg add "HKCR\wdpfile\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f >NUL 2>&1
reg add "HKCR\wdpfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "rundll32.exe %%SystemRoot%%\system32\shimgvw.dll,ImageView_PrintTo /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\wmffile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\wmffile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\mspaint.exe\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\Wordpad.Document.1\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /p \"%%1\"" /f >NUL 2>&1
reg add "HKCR\Wordpad.Document.1\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows NT\Accessories\WORDPAD.EXE\" /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\WSFFile\shell\Print\Command" /ve /t REG_EXPAND_SZ /d "\"%%SystemRoot%%\System32\Notepad.exe\" /p %%1" /f >NUL 2>&1
reg add "HKCR\xhtmlfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\rundll32.exe\" \"%%systemroot%%\system32\mshtml.dll\",PrintHTML \"%%1\"" /f >NUL 2>&1
reg add "HKCR\xhtmlfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "\"%%systemroot%%\system32\rundll32.exe\" \"%%systemroot%%\system32\mshtml.dll\",PrintHTML \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\zapfile\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE /p %%1" /f >NUL 2>&1
reg add "HKCR\zapfile\shell\printto\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\notepad.exe /pt \"%%1\" \"%%2\" \"%%3\" \"%%4\"" /f >NUL 2>&1
reg add "HKCR\.3mf\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.bmp\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.fbx\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.gif\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.glb\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.jfif\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.jpe\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.jpeg\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.jpg\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.obj\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.ply\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.png\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.stl\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.tif\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\.tiff\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3mf\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.bmp\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.fbx\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.gif\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.glb\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.jfif\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.jpe\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.jpeg\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.jpg\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.obj\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.ply\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.png\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.stl\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.tif\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.tiff\shell\3D Edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mspaint.exe \"%%1\" /ForceBootstrapPaint3D" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3ds\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3mf\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.dae\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.dxf\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.obj\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.ply\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.stl\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.wrl\shell\3D Print\Command" /v "DelegateExecute" /t REG_SZ /d "{1A68CF90-753A-4523-A4A4-40CAB4BC6EFF}" /f >NUL 2>&1
reg add "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "{3dad6c5d-2167-4cae-9914-f99e41c12cfa}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\CopyHookHandlers\Sharing" /ve /t REG_SZ /d "{40dd6e20-7c17-11ce-a804-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\Folder\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\Stack.Audio\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\Stack.Image\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\Stack.Video\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3g2\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3gp\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3gp2\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3gpp\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.aac\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.adt\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.adts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.dtcp-ip\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.flac\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.lpcm\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m2t\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m2ts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m4a\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m4v\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mk3d\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mka\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mkv\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mov\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mp4\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mp4v\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.ts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.tts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.wtv\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\audio\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\Directory.Audio\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\Directory.Image\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\Directory.Video\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\image\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\video\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\Offline Files" /ve /t REG_SZ /d "{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg add "HKCR\Folder\shellex\PropertySheetHandlers\Offline Files" /ve /t REG_SZ /d "{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\Open With EncryptionMenu" /ve /t REG_SZ /d "{A470F8CF-A1E8-4f65-8335-227475AA5C46}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EncryptionMenu" /ve /t REG_SZ /d "{A470F8CF-A1E8-4f65-8335-227475AA5C46}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /ve /t REG_SZ /d "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "{E61BF828-5E63-4287-BEF1-60B1A4FDE0E3}" /f >NUL 2>&1
reg add "HKCR\Directory\background\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "{E61BF828-5E63-4287-BEF1-60B1A4FDE0E3}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "{E61BF828-5E63-4287-BEF1-60B1A4FDE0E3}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Directory\background\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\PropertySheetHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\batfile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\cmdfile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\Msi.Package\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\MSILink\shellex\ContextMenuHandlers" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\?{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\?{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\?{D6791A63-E7E2-4fee-BF52-5DED8E86E9B8}" /f >NUL 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\?{fbeb8a05-beee-4442-804e-409d6c4515e9}" /f >NUL 2>&1
reg delete "HKCR\MSILink\shellex\ContextMenuHandlers\?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\{D6791A63-E7E2-4fee-BF52-5DED8E86E9B8}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\{fbeb8a05-beee-4442-804e-409d6c4515e9}" /f >NUL 2>&1
reg add "HKCR\MSILink\shellex\ContextMenuHandlers\{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
echo **********************************************************************************
echo 01 REMOVE "print" and "printto" for common text-based files and internet shortcuts
echo **********************************************************************************
reg delete "HKCR\Applications\photoviewer.dll\shell\print" /f >NUL 2>&1
reg delete "HKCR\batfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\cmdfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\contact_wab_auto_file\shell\print" /f >NUL 2>&1
reg delete "HKCR\docxfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\docxfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\emffile\shell\print" /f >NUL 2>&1
reg delete "HKCR\emffile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\FaxCover.Document\shell\print" /f >NUL 2>&1
reg delete "HKCR\fonfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\giffile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\group_wab_auto_file\shell\print" /f >NUL 2>&1
reg delete "HKCR\htmlfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\htmlfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.HTM\shell\print" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.HTM\shell\printto" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.SVG\shell\print" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.SVG\shell\printto" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.URL\shell\print" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.URL\shell\printto" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.XHT\shell\print" /f >NUL 2>&1
reg delete "HKCR\IE.AssocFile.XHT\shell\printto" /f >NUL 2>&1
reg delete "HKCR\inffile\shell\print" /f >NUL 2>&1
reg delete "HKCR\inifile\shell\print" /f >NUL 2>&1
reg delete "HKCR\InternetShortcut\shell\print" /f >NUL 2>&1
reg delete "HKCR\InternetShortcut\shell\printto" /f >NUL 2>&1
reg delete "HKCR\jpegfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\JSEFile\shell\Print" /f >NUL 2>&1
reg delete "HKCR\JSFile\shell\Print" /f >NUL 2>&1
reg delete "HKCR\odtfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\odtfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\opensearchresult\shell\print" /f >NUL 2>&1
reg delete "HKCR\otffile\shell\print" /f >NUL 2>&1
reg delete "HKCR\Paint.Picture\shell\printto" /f >NUL 2>&1
reg delete "HKCR\PBrush\shell\print" /f >NUL 2>&1
reg delete "HKCR\PBrush\shell\printto" /f >NUL 2>&1
reg delete "HKCR\pfmfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\pjpegfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\pngfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\regfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\rlefile\shell\print" /f >NUL 2>&1
reg delete "HKCR\rlefile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\rtffile\shell\print" /f >NUL 2>&1
reg delete "HKCR\rtffile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\svgfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\svgfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\image\shell\print" /f >NUL 2>&1
reg delete "HKCR\textfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\textfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\TIFImage.Document\shell\printto" /f >NUL 2>&1
reg delete "HKCR\ttcfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\ttffile\shell\print" /f >NUL 2>&1
reg delete "HKCR\txtfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\txtfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\VBEFile\shell\Print" /f >NUL 2>&1
reg delete "HKCR\VBSFile\shell\Print" /f >NUL 2>&1
reg delete "HKCR\wdpfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\wdpfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\wmffile\shell\print" /f >NUL 2>&1
reg delete "HKCR\wmffile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\Wordpad.Document.1\shell\print" /f >NUL 2>&1
reg delete "HKCR\Wordpad.Document.1\shell\printto" /f >NUL 2>&1
reg delete "HKCR\WSFFile\shell\Print" /f >NUL 2>&1
reg delete "HKCR\xhtmlfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\xhtmlfile\shell\printto" /f >NUL 2>&1
reg delete "HKCR\zapfile\shell\print" /f >NUL 2>&1
reg delete "HKCR\zapfile\shell\printto" /f >NUL 2>&1
echo ***********************************
echo 02 REMOVE 3D Edit from Context Menu
echo ***********************************
reg delete "HKCR\SystemFileAssociations\.3mf\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.bmp\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.fbx\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.gif\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.glb\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jfif\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpe\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpeg\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.obj\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.ply\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.stl\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tiff\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.3mf\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.bmp\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.fbx\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.gif\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.glb\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.jfif\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.jpe\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.jpeg\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.jpg\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.obj\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.ply\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.png\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.stl\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.tif\shell\3D Edit" /f >NUL 2>&1
reg delete "HKCR\.tiff\shell\3D Edit" /f >NUL 2>&1
echo ************************************
echo 03 REMOVE 3D Print from Context Menu
echo ************************************
reg delete "HKCR\SystemFileAssociations\.3ds\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.3mf\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.dae\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.dxf\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.obj\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.ply\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.stl\shell\3D Print" /f >NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.wrl\shell\3D Print" /f >NUL 2>&1
echo *****************************************************************
echo 04 HIDE Offline Files, Sharing, Workfolder, Playto, Compatibility
echo *****************************************************************
echo 04a Replace Default Values Data
reg add "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "?{3dad6c5d-2167-4cae-9914-f99e41c12cfa}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\CopyHookHandlers\Sharing" /ve /t REG_SZ /d "?{40dd6e20-7c17-11ce-a804-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "?{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "?{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\Folder\shellex\ContextMenuHandlers\Offline Files" /ve /t REG_SZ /d "?{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\Stack.Audio\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\Stack.Image\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\Stack.Video\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3g2\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3gp\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3gp2\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.3gpp\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.aac\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.adt\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.adts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.dtcp-ip\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.flac\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.lpcm\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m2t\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m2ts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m4a\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.m4v\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mk3d\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mka\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mkv\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mov\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mp4\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mp4v\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.mts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.ts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.tts\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\.wtv\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\audio\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\Directory.Audio\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\Directory.Image\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\Directory.Video\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\image\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\SystemFileAssociations\video\shellex\ContextMenuHandlers\PlayTo" /ve /t REG_SZ /d "?{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\Offline Files" /ve /t REG_SZ /d "?{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg add "HKCR\Folder\shellex\PropertySheetHandlers\Offline Files" /ve /t REG_SZ /d "?{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\Open With EncryptionMenu" /ve /t REG_SZ /d "?{A470F8CF-A1E8-4f65-8335-227475AA5C46}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\EncryptionMenu" /ve /t REG_SZ /d "?{A470F8CF-A1E8-4f65-8335-227475AA5C46}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /ve /t REG_SZ /d "?{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "?{E61BF828-5E63-4287-BEF1-60B1A4FDE0E3}" /f >NUL 2>&1
reg add "HKCR\Directory\background\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "?{E61BF828-5E63-4287-BEF1-60B1A4FDE0E3}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\WorkFolders" /ve /t REG_SZ /d "?{E61BF828-5E63-4287-BEF1-60B1A4FDE0E3}" /f >NUL 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Directory\background\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\PropertySheetHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /ve /t REG_SZ /d "?{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f >NUL 2>&1
reg add "HKCR\batfile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\cmdfile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\Msi.Package\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
reg add "HKCR\MSILink\shellex\ContextMenuHandlers" /ve /t REG_SZ /d "?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
echo 04b Rename keys
echo Remove shell
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{D6791A63-E7E2-4fee-BF52-5DED8E86E9B8}" /f >NUL 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{fbeb8a05-beee-4442-804e-409d6c4515e9}" /f >NUL 2>&1
reg delete "HKCR\MSILink\shellex\ContextMenuHandlers\{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1
echo Rename shell
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\?{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\?{7EFA68C6-086B-43e1-A2D2-55A113531240}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\?{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\?{D6791A63-E7E2-4fee-BF52-5DED8E86E9B8}" /f >NUL 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\?{fbeb8a05-beee-4442-804e-409d6c4515e9}" /f >NUL 2>&1
reg add "HKCR\MSILink\shellex\ContextMenuHandlers\?{1d27f844-3a1f-4410-85ac-14651078412d}" /f >NUL 2>&1

echo:
echo Done.
cd /d "%TEMP%" & rmdir /s /q "%TEMP%\Nsudo" >NUL 2>&1
if "%Install%" == "FULL" exit /b
timeout /t 3 /nobreak >NUL 2>&1
exit /b
