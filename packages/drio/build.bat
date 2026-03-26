@echo off
setlocal
REM KingCalendar Build Script - Delphi 26.0

set BASEDIR=%~dp0
set OUTBASE=%BASEDIR%26.0

call rsvars.bat
if errorlevel 1 (
    echo ERROR: rsvars.bat failed.
    exit /b 1
)

REM === Clean target directories ===
echo Cleaning output directories...
if exist "%OUTBASE%\Win32\Release" rd /s /q "%OUTBASE%\Win32\Release"
mkdir "%OUTBASE%\Win32\Release"
if exist "%OUTBASE%\Win32\Debug" rd /s /q "%OUTBASE%\Win32\Debug"
mkdir "%OUTBASE%\Win32\Debug"
if exist "%OUTBASE%\Win64\Release" rd /s /q "%OUTBASE%\Win64\Release"
mkdir "%OUTBASE%\Win64\Release"
if exist "%OUTBASE%\Win64\Debug" rd /s /q "%OUTBASE%\Win64\Debug"
mkdir "%OUTBASE%\Win64\Debug"
echo Done.

set ERRORCOUNT=0

REM === KingCalendar260 ===
echo.
echo Compiling KingCalendar260 / Win32 / Release...
msbuild "KingCalendar260.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar260 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar260 / Win32 / Debug...
msbuild "KingCalendar260.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar260 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar260 / Win64 / Release...
msbuild "KingCalendar260.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar260 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar260 / Win64 / Debug...
msbuild "KingCalendar260.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar260 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === KingCalendarDB260 ===
echo.
echo Compiling KingCalendarDB260 / Win32 / Release...
msbuild "KingCalendarDB260.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB260 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB260 / Win32 / Debug...
msbuild "KingCalendarDB260.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB260 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB260 / Win64 / Release...
msbuild "KingCalendarDB260.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB260 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB260 / Win64 / Debug...
msbuild "KingCalendarDB260.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB260 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendar260 ===
echo.
echo Compiling dclKingCalendar260 / Win32 / Release...
msbuild "dclKingCalendar260.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar260 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar260 / Win32 / Debug...
msbuild "dclKingCalendar260.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar260 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar260 / Win64 / Release...
msbuild "dclKingCalendar260.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar260 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar260 / Win64 / Debug...
msbuild "dclKingCalendar260.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar260 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendarDB260 ===
echo.
echo Compiling dclKingCalendarDB260 / Win32 / Release...
msbuild "dclKingCalendarDB260.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB260 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB260 / Win32 / Debug...
msbuild "dclKingCalendarDB260.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB260 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB260 / Win64 / Release...
msbuild "dclKingCalendarDB260.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB260 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB260 / Win64 / Debug...
msbuild "dclKingCalendarDB260.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB260 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === Copy .RES and .DFM from source ===
echo.
echo Copying resource files...
set SRCDIR=%BASEDIR%..\..\source
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\Win32\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\Win32\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\Win32\Debug\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\Win32\Debug\" >nul 2>&1
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\Win64\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\Win64\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\Win64\Debug\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\Win64\Debug\" >nul 2>&1

echo.
if %ERRORCOUNT% EQU 0 (
    echo Build complete - all packages compiled successfully.
) else (
    echo Build complete with %ERRORCOUNT% error^(s^). Check output above.
)
echo.
endlocal
pause
