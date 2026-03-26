@echo off
setlocal
REM KingCalendar Build Script - Delphi 37.0

set BASEDIR=%~dp0
set OUTBASE=%BASEDIR%37.0
set BINBASE=%BASEDIR%..\..\BinPackages\d13

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
if exist "%OUTBASE%\WinARM64EC\Release" rd /s /q "%OUTBASE%\WinARM64EC\Release"
mkdir "%OUTBASE%\WinARM64EC\Release"
if exist "%OUTBASE%\WinARM64EC\Debug" rd /s /q "%OUTBASE%\WinARM64EC\Debug"
mkdir "%OUTBASE%\WinARM64EC\Debug"
echo Done.

set ERRORCOUNT=0

REM === KingCalendar370 ===
echo.
echo Compiling KingCalendar370 / Win32 / Release...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / Win32 / Debug...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / Win64 / Release...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / Win64 / Debug...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / Win64x / Release...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / Win64x / Debug...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / Win64x / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / WinARM64EC / Release...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / WinARM64EC / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendar370 / WinARM64EC / Debug...
msbuild "KingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendar370 / WinARM64EC / Debug
    set /a ERRORCOUNT+=1
)

REM === KingCalendarDB370 ===
echo.
echo Compiling KingCalendarDB370 / Win32 / Release...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / Win32 / Debug...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / Win64 / Release...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / Win64 / Debug...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / Win64x / Release...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / Win64x / Debug...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / Win64x / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / WinARM64EC / Release...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / WinARM64EC / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling KingCalendarDB370 / WinARM64EC / Debug...
msbuild "KingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: KingCalendarDB370 / WinARM64EC / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendar370 ===
echo.
echo Compiling dclKingCalendar370 / Win32 / Release...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / Win32 / Debug...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / Win64 / Release...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / Win64 / Debug...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / Win64x / Release...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / Win64x / Debug...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / Win64x / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / WinARM64EC / Release...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Release /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / WinARM64EC / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendar370 / WinARM64EC / Debug...
msbuild "dclKingCalendar370.dproj" /t:Build /p:Config=Debug /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendar370 / WinARM64EC / Debug
    set /a ERRORCOUNT+=1
)

REM === dclKingCalendarDB370 ===
echo.
echo Compiling dclKingCalendarDB370 / Win32 / Release...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / Win32 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / Win32 / Debug...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=Win32 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win32\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win32\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / Win32 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / Win64 / Release...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / Win64 / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / Win64 / Debug...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64 ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / Win64 / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / Win64x / Release...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / Win64x / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / Win64x / Debug...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=Win64x ^
    /p:DCC_DcuOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\Win64x\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\Win64x\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / Win64x / Debug
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / WinARM64EC / Release...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Release /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Release" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Release" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / WinARM64EC / Release
    set /a ERRORCOUNT+=1
)
echo.
echo Compiling dclKingCalendarDB370 / WinARM64EC / Debug...
msbuild "dclKingCalendarDB370.dproj" /t:Build /p:Config=Debug /p:Platform=WinARM64EC ^
    /p:DCC_DcuOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_DcpOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /p:DCC_BplOutput="%OUTBASE%\WinARM64EC\Debug" ^
    /nologo /v:minimal
if errorlevel 1 (
    echo FAILED: dclKingCalendarDB370 / WinARM64EC / Debug
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
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\WinARM64EC\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\WinARM64EC\Release\" >nul 2>&1
copy /Y "%SRCDIR%\*.res" "%OUTBASE%\WinARM64EC\Debug\" >nul 2>&1
copy /Y "%SRCDIR%\*.dfm" "%OUTBASE%\WinARM64EC\Debug\" >nul 2>&1

REM === Copy output to BinPackages ===
echo.
echo Copying to BinPackages...
if exist "%BINBASE%\Win32\Release" rd /s /q "%BINBASE%\Win32\Release"
mkdir "%BINBASE%\Win32\Release"
xcopy /Y /Q "%OUTBASE%\Win32\Release\*.*" "%BINBASE%\Win32\Release\" >nul 2>&1
if exist "%BINBASE%\Win32\Debug" rd /s /q "%BINBASE%\Win32\Debug"
mkdir "%BINBASE%\Win32\Debug"
xcopy /Y /Q "%OUTBASE%\Win32\Debug\*.*" "%BINBASE%\Win32\Debug\" >nul 2>&1
if exist "%BINBASE%\Win64\Release" rd /s /q "%BINBASE%\Win64\Release"
mkdir "%BINBASE%\Win64\Release"
xcopy /Y /Q "%OUTBASE%\Win64\Release\*.*" "%BINBASE%\Win64\Release\" >nul 2>&1
if exist "%BINBASE%\Win64\Debug" rd /s /q "%BINBASE%\Win64\Debug"
mkdir "%BINBASE%\Win64\Debug"
xcopy /Y /Q "%OUTBASE%\Win64\Debug\*.*" "%BINBASE%\Win64\Debug\" >nul 2>&1
if exist "%BINBASE%\Win64x\Release" rd /s /q "%BINBASE%\Win64x\Release"
mkdir "%BINBASE%\Win64x\Release"
xcopy /Y /Q "%OUTBASE%\Win64x\Release\*.*" "%BINBASE%\Win64x\Release\" >nul 2>&1
if exist "%BINBASE%\Win64x\Debug" rd /s /q "%BINBASE%\Win64x\Debug"
mkdir "%BINBASE%\Win64x\Debug"
xcopy /Y /Q "%OUTBASE%\Win64x\Debug\*.*" "%BINBASE%\Win64x\Debug\" >nul 2>&1
if exist "%BINBASE%\WinARM64EC\Release" rd /s /q "%BINBASE%\WinARM64EC\Release"
mkdir "%BINBASE%\WinARM64EC\Release"
xcopy /Y /Q "%OUTBASE%\WinARM64EC\Release\*.*" "%BINBASE%\WinARM64EC\Release\" >nul 2>&1
if exist "%BINBASE%\WinARM64EC\Debug" rd /s /q "%BINBASE%\WinARM64EC\Debug"
mkdir "%BINBASE%\WinARM64EC\Debug"
xcopy /Y /Q "%OUTBASE%\WinARM64EC\Debug\*.*" "%BINBASE%\WinARM64EC\Debug\" >nul 2>&1
echo Done.

echo.
if %ERRORCOUNT% EQU 0 (
    echo Build complete - all packages compiled successfully.
) else (
    echo Build complete with %ERRORCOUNT% error^(s^). Check output above.
)
echo.
endlocal
pause
