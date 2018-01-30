@echo off
REM *****************************************************
REM *
REM *
REM *	Simple batch file to update firmware on Alternatro Regualtors
REM *
REM *	asdf: Put in URLs, for the reg and the github for this util
REM *
REM *	asdf:  Pur in how to use
REM *
REM *
REM *	Optional Parms
REM *	  %1 = COM port to use, enter as COM26, COM47, etc.
REM *
REM *
REM *
REM *
REM *
REM *
REM *****************************************************

SETLOCAL ENABLEDELAYEDEXPANSION

SET firmware=SmartRegulatorv1.2.0.ino.hex
SET comPort=COM1


if ["%~1"]==[""] (
    ECHO.
    ECHO.
    ECHO Automatic Port Scan
    ECHO.


	REM **********************************************************
	REM *
	REM *	Scan the COM ports, looking for a list of active ports.
	REM *	When one is found just try calling avrdude and see if
	REM *	it works.
	REM *
	REM **********************************************************
	for /f "tokens=4" %%A in ('mode^|findstr "COM[0-9]*:"') do (

        :: Looks like we may have found one.
        ECHO.
        ECHO.
        ECHO.
        ECHO.
        ECHO.
        ECHO Going to try uploading to port %%A
        ECHO.
        SET comPort=%%A

        :: Does string have a trailing `:` char? If so remove it 
        IF !comPort:~-1!==: SET comPort=!comPort:~0,-1!

        avrdude -Cavrdude.conf -patmega64m1 -carduino -P!comPort! -b57600 -D -Uflash:w:!firmware!:i 

 	)


) else (
    ECHO.
    ECHO.
    ECHO Com port %1 specified, will upload to that port
    ECHO.
    
    SET comPort=%1
    
    :: Does string have a trailing `:` char? If so remove it 
    IF !comPort:~-1!==: SET comPort=!comPort:~0,-1!
    
    avrdude -Cavrdude.conf -patmega64m1 -carduino -P!comPort! -b57600 -D -Uflash:w:!firmware!:i 
)


PAUSE


