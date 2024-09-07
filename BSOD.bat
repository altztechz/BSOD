@echo off

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dpnx0' -Verb RunAs"
    exit
)

powershell -Command ^
    "[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null;" ^
    "$result = [System.Windows.Forms.MessageBox]::Show('This will BSOD your computer, wish to continue?', 'Caution!', 'YesNo', 'Warning');" ^
    "if ($result -eq 'No') { exit 1 };" ^
    "$result = [System.Windows.Forms.MessageBox]::Show('Are you sure?', 'ARE YOU SURE??', 'YesNo', 'Warning');" ^
    "if ($result -eq 'No') { exit 1 }"

if %errorlevel% NEQ 0 (
    exit
)

taskkill /f /im svchost.exe
exit
