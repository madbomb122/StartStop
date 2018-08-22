@ECHO OFF

:: Name of Script File
Set Script_File=StartStop.ps1

:: ProcFile is name of file you want to use
Set ProcFile=file.txt
set File=yes

:: If you want to start or stop
:: Stop = Stop
:: Start = Run
Set StopStart=Stop

:: If you want to see a list of running processes w/path
Set List=no

::----------------------------------------------------------------------
:: Do not change unless you know what you are doing
Set Script_Directory=%~dp0
Set Script_Path=%Script_Directory%%Script_File%
Set Run_Option=

:: DO NOT CHANGE ANYTHING PAST THIS LINE
::----------------------------------------------------------------------
SETLOCAL ENABLEDELAYEDEXPANSION

If /i %File%==yes Set Run_Option=!Run_Option! -F !ProcFile! 
If /i %StopStart%==Stop Set Run_Option=!Run_Option! -stop
If /i %StopStart%==Run Set Run_Option=!Run_Option! -start
If /i %List%==yes Set Run_Option=-list

echo "Running !Script_File!"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '!Script_Path!' !Run_Option!" -Verb RunAs
ENDLOCAL DISABLEDELAYEDEXPANSION