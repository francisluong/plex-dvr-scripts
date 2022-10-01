REM This file converts Plex recorded video

SETLOCAL

set LOGFILE=D:\temp\zlog\plex-process.log

SET FILENAME=%1
SET PRESET=%2

call :encode2mkv >> %LOGFILE%

exit /B

:encode2mkv

@ECHO off

@ECHO Starting Batch Run: %date% %time%

@ECHO .

@ECHO .

FOR /F "tokens=*" %%G IN ('DIR /B /S %FILENAME%') DO (

@ECHO Using HandBrakeCLI to Convert file "%%G"

dir "%%G"

@ECHO .

@ECHO ..

"C:\Program Files\Handbrake\HandBrakeCLI.exe" -v -i "%%G" -o "%%~dG%%~pG%%~nG.m4v" --preset %PRESET%
REM --preset="H.264 MKV 720p30"
REM --preset="Fast 720p30"
REM --preset="Fast 1080p30"
@ECHO .


REM ### Check if converted file exists ###

IF EXIST "%%~dG%%~pG%%~nG.m4v" (

@ECHO Convert Complete for "%%~dG%%~pG%%~nG.m4v"

) ELSE (

ECHO Converted file "%%~dG%%~pG%%~nG.m4v" not found

ECHO "!!! ERROR RAISED !!!"

exit 2

)


@ECHO Deleting old file "%%G"

del "%%G"

)

@ECHO Batch Run Complete: %date% %time%

@ECHO ##########################################