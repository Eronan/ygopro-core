@ECHO OFF
SETLOCAL

SET PREMAKE_VERSION=5.0.0-beta2
SET PREMAKE_EXTRACT_DIR="tmp\premake"
SET PREMAKE_ZIP="tmp\premake-%PREMAKE_VERSION%-windows.zip"

REM ensure the script is always running inside the core's root directory
CD %~dp0..

MKDIR tmp

IF EXIST %PREMAKE_EXTRACT_DIR% RMDIR /s /q %PREMAKE_EXTRACT_DIR%
IF EXIST %PREMAKE_EXTRACT_DIR% EXIT /B 1

CALL "%~DP0cmd\download.bat" ^
	https://github.com/premake/premake-core/releases/download/v%PREMAKE_VERSION%/premake-%PREMAKE_VERSION%-windows.zip %PREMAKE_ZIP%
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

CALL "%~DP0cmd\unzip.bat" %PREMAKE_ZIP% %PREMAKE_EXTRACT_DIR%
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

COPY /V /Y %PREMAKE_EXTRACT_DIR%\premake5.exe .
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

EXIT /B