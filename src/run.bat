:: ============================================================================
:: Windows execution script
:: Notes:
::   To disable the pause-on-error behavior, run as one of the following:
::       build.bat -p
::       build.bat --no-pause
:: ============================================================================
@echo off
cls



:: ============================================================================
:: Editable settings
:: ============================================================================

:: Path to the node.exe used for execution
set NODE=node.exe

:: The port the server should run on
set PORT=80

:: The path to the directory which contains files which should be shared
set SHARE_PATH=files



:: ============================================================================
:: Setup
:: ============================================================================

set NO_PAUSE=0
if "%1%"=="-p" set NO_PAUSE=1
if "%1%"=="--no-pause" set NO_PAUSE=1

set BATCH_FULL_FILENAME=%0
for %%A in ("%BATCH_FULL_FILENAME%") do (
    set BATCH_PATH=%%~dpA
    set BATCH_FILENAME=%%~nxA
)

:: ============================================================================
:: Check for python
:: ============================================================================

"%NODE%" --version > NUL 2> NUL || goto :error_no_node

:: ============================================================================
:: Build execution
:: ============================================================================

"%NODE%" lan.js ^
	--directory "%SHARE_PATH%" ^
	--port "%PORT%" ^
	--pretty-print ^
	|| goto :error

:: ============================================================================
:: Success
:: ============================================================================


goto :eof

:: ============================================================================
:: Build error
:: ============================================================================
:error
if %NO_PAUSE%==0 (
	color 0c
	pause > NUL 2> NUL
	color
)
goto :eof

:: ============================================================================
:: No python error
:: ============================================================================
:error_no_node
if %NO_PAUSE%==0 color 0c
echo The node.exe version check failed.
echo.
echo.
echo The most likely problem is that you do not have node.exe installed.
echo.
echo.
echo Download a "Windows Binary" from the following link:
echo   http://nodejs.org/download/
echo.
echo.
echo And copy the node.exe it into this folder.
if %NO_PAUSE%==0 (
	pause > NUL 2> NUL
	color
)
goto :eof


