@echo off
setlocal
REM KingCalendar Build Script - Delphi 29.0

set BASEDIR=%~dp0
set OUTBASE=%BASEDIR%29.0

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
if exist "%OUTBASE%\Win64x\Release" rd /s /q "%OUTBASE%\Win64x\Release"
mkdir "%OUTBASE%\Win64x\Release"
if exist "%OUTBASE%\Win64x\Debug" rd /s /q "%OUTBASE%\Win64x\Debug"
mkdir "%OUTBASE%\Win64x\Debug"
echo Done.

set ERRORCOUNT=0

REM === KingCalendar290 ===
echo.
echo Compiling KingCalendar290 / Win32 / Release...
msbuild "KingCalendar290.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar290 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar290 / Win32 / Debug...
msbuild "KingCalendar290.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar290 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar290 / Win64 / Release...
msbuild "KingCalendar290.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar290 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar290 / Win64 / Debug...
msbuild "KingCalendar290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar290 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar290 / Win64x / Release...
msbuild "KingCalendar290.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar290 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar290 / Win64x / Debug...
msbuild "KingCalendar290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar290 / Win64x / Debug
    set /a ERRORCOUNT+=1
)

REM === KingCalendarDB290 ===
echo.
echo Compiling KingCalendarDB290 / Win32 / Release...
msbuild "KingCalendarDB290.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB290 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB290 / Win32 / Debug...
msbuild "KingCalendarDB290.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB290 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB290 / Win64 / Release...
msbuild "KingCalendarDB290.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB290 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB290 / Win64 / Debug...
msbuild "KingCalendarDB290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB290 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB290 / Win64x / Release...
msbuild "KingCalendarDB290.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB290 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB290 / Win64x / Debug...
msbuild "KingCalendarDB290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB290 / Win64x / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendar290 ===
echo.
echo Compiling dclKingCalendar290 / Win32 / Release...
msbuild "dclKingCalendar290.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar290 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar290 / Win32 / Debug...
msbuild "dclKingCalendar290.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar290 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar290 / Win64 / Release...
msbuild "dclKingCalendar290.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar290 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar290 / Win64 / Debug...
msbuild "dclKingCalendar290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar290 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar290 / Win64x / Release...
msbuild "dclKingCalendar290.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar290 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar290 / Win64x / Debug...
msbuild "dclKingCalendar290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar290 / Win64x / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendarDB290 ===
echo.
echo Compiling dclKingCalendarDB290 / Win32 / Release...
msbuild "dclKingCalendarDB290.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB290 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB290 / Win32 / Debug...
msbuild "dclKingCalendarDB290.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB290 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB290 / Win64 / Release...
msbuild "dclKingCalendarDB290.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB290 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB290 / Win64 / Debug...
msbuild "dclKingCalendarDB290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB290 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB290 / Win64x / Release...
msbuild "dclKingCalendarDB290.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB290 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB290 / Win64x / Debug...
msbuild "dclKingCalendarDB290.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB290 / Win64x / Debug
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
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\Win64x\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\Win64x\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\Win64x\Debug\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\Win64x\Debug\" >nul 2>&1

echo.
if %ERRORCOUNT% EQU 0 (
    echo Build complete - all packages compiled successfully.
) else (
    echo Build complete with %ERRORCOUNT% error^(s^). Check output above.
)
echo.
endlocal
pause
