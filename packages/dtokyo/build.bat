@echo off
setlocal
REM KingCalendar Build Script - Delphi 25.0

set BASEDIR=%~dp0
set OUTBASE=%BASEDIR%25.0

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

REM === KingCalendar250 ===
echo.
echo Compiling KingCalendar250 / Win32 / Release...
msbuild "KingCalendar250.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar250 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar250 / Win32 / Debug...
msbuild "KingCalendar250.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar250 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar250 / Win64 / Release...
msbuild "KingCalendar250.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar250 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar250 / Win64 / Debug...
msbuild "KingCalendar250.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar250 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === KingCalendarDB250 ===
echo.
echo Compiling KingCalendarDB250 / Win32 / Release...
msbuild "KingCalendarDB250.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB250 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB250 / Win32 / Debug...
msbuild "KingCalendarDB250.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB250 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB250 / Win64 / Release...
msbuild "KingCalendarDB250.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB250 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB250 / Win64 / Debug...
msbuild "KingCalendarDB250.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB250 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendar250 ===
echo.
echo Compiling dclKingCalendar250 / Win32 / Release...
msbuild "dclKingCalendar250.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar250 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar250 / Win32 / Debug...
msbuild "dclKingCalendar250.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar250 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar250 / Win64 / Release...
msbuild "dclKingCalendar250.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar250 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar250 / Win64 / Debug...
msbuild "dclKingCalendar250.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar250 / Win64 / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendarDB250 ===
echo.
echo Compiling dclKingCalendarDB250 / Win32 / Release...
msbuild "dclKingCalendarDB250.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB250 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB250 / Win32 / Debug...
msbuild "dclKingCalendarDB250.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB250 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB250 / Win64 / Release...
msbuild "dclKingCalendarDB250.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB250 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB250 / Win64 / Debug...
msbuild "dclKingCalendarDB250.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB250 / Win64 / Debug
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
