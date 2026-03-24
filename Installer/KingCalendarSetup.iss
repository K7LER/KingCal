; =============================================================================
; KingCalendar Setup Script
; Inno Setup 6.x required
;
; Supports Delphi 10.2 Tokyo through Delphi 13 Florence
; Platforms: Win32, Win64, Win64x, WinARM64EC
; =============================================================================

#define AppName    "KingCalendar"
#define AppVersion "2.1"
#define AppPublisher "AppVision"

[Setup]
AppId={{3F8A2D1B-7C45-4E9F-B6D2-1A5E8C934F70}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppCopyright=Copyright (C) 1995-2026 Mark Lussier and AppVision
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=KingCalendarSetup
Compression=lzma2/ultra
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayName={#AppName} {#AppVersion}
SetupLogging=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; --- Source files ---
Source: "..\source\*";        DestDir: "{app}\source";        Flags: ignoreversion recursesubdirs createallsubdirs
; --- Package projects (all Delphi versions) ---
Source: "..\packages\102\*";  DestDir: "{app}\packages\102";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\103\*";  DestDir: "{app}\packages\103";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\104\*";  DestDir: "{app}\packages\104";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\110\*";  DestDir: "{app}\packages\110";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\12\*";   DestDir: "{app}\packages\12";   Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\13\*";   DestDir: "{app}\packages\13";   Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled DCU libraries (Delphi 10.2 / BDS 19) ---
Source: "..\LIBD25x32\*";     DestDir: "{app}\LIBD25x32";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD25x64\*";     DestDir: "{app}\LIBD25x64";     Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled DCU libraries (Delphi 10.3 / BDS 20) ---
Source: "..\LIBD26x32\*";     DestDir: "{app}\LIBD26x32";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD26x64\*";     DestDir: "{app}\LIBD26x64";     Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled DCU libraries (Delphi 10.4 / BDS 21) ---
Source: "..\LIBD27x32\*";     DestDir: "{app}\LIBD27x32";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD27x64\*";     DestDir: "{app}\LIBD27x64";     Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled DCU libraries (Delphi 11 / BDS 22) ---
Source: "..\LIBD28x32\*";     DestDir: "{app}\LIBD28x32";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD28x64\*";     DestDir: "{app}\LIBD28x64";     Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled DCU libraries (Delphi 12 / BDS 23) ---
Source: "..\LIBD29x32\*";     DestDir: "{app}\LIBD29x32";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD29x64\*";     DestDir: "{app}\LIBD29x64";     Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled DCU libraries (Delphi 13 / BDS 24) ---
Source: "..\LIBD37x32\*";     DestDir: "{app}\LIBD37x32";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD37x64\*";     DestDir: "{app}\LIBD37x64";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\LIBD37x64x\*";    DestDir: "{app}\LIBD37x64x";    Flags: ignoreversion recursesubdirs createallsubdirs
; --- Documentation ---
Source: "..\Documentation\*"; DestDir: "{app}\Documentation"; Flags: ignoreversion recursesubdirs createallsubdirs
; --- Demos ---
Source: "..\Demos\*";         DestDir: "{app}\Demos";         Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\KingCalendar Documentation"; Filename: "{app}\Documentation\kingcal30.rtf"
Name: "{group}\Uninstall KingCalendar";      Filename: "{uninstallexe}"

[Code]

// =============================================================================
// Constants and types
// =============================================================================

const
  NUM_VERSIONS = 6;

  // Platform array indices
  PLT_WIN32     = 0;
  PLT_WIN64     = 1;
  PLT_WIN64X    = 2;
  PLT_ARM64EC   = 3;
  NUM_PLATFORMS = 4;

type
  TDelphiVersionInfo = record
    DisplayName : String;  // e.g. 'Delphi 13 Florence'
    BDSVer      : String;  // e.g. '24.0'
    PkgSuffix   : String;  // e.g. '370'
    PkgFolder   : String;  // e.g. '13'
    LibPrefix   : String;  // e.g. 'LIBD37'  (empty = no dedicated LIB folder for that platform)
    Has64x      : Boolean; // supports Win64x platform
    HasARM64EC  : Boolean; // supports WinARM64EC platform
    HasBin64IDE : Boolean; // whether to check for 64-bit IDE (D12+)
  end;

var
  // Custom wizard pages
  PageVersions    : TWizardPage;
  PagePlatforms   : TWizardPage;
  PageBuildConfig : TWizardPage;

  // UI controls
  VersionChecks  : TNewCheckListBox;
  PlatformChecks : TNewCheckListBox;
  BuildReleaseRB : TRadioButton;
  BuildDebugRB   : TRadioButton;

  // Detected Delphi state (indexed 0..NUM_VERSIONS-1)
  DelphiRoots      : array[0..NUM_VERSIONS-1] of String;
  DelphiInstalled  : array[0..NUM_VERSIONS-1] of Boolean;
  DelphiHasBin64   : array[0..NUM_VERSIONS-1] of Boolean;

  // Maps checkbox list index → version array index (populated during page build)
  CheckToVersion   : array[0..NUM_VERSIONS-1] of Integer;
  CheckCount       : Integer;


// =============================================================================
// Static version table
// =============================================================================

function GetVersionInfo(Idx: Integer): TDelphiVersionInfo;
begin
  case Idx of
    0: begin
         Result.DisplayName := 'Delphi 10.2 Tokyo';
         Result.BDSVer      := '19.0';
         Result.PkgSuffix   := '250';
         Result.PkgFolder   := '102';
         Result.LibPrefix   := 'LIBD25';
         Result.Has64x      := False;
         Result.HasARM64EC  := False;
         Result.HasBin64IDE := False;
       end;
    1: begin
         Result.DisplayName := 'Delphi 10.3 Rio';
         Result.BDSVer      := '20.0';
         Result.PkgSuffix   := '260';
         Result.PkgFolder   := '103';
         Result.LibPrefix   := 'LIBD26';
         Result.Has64x      := False;
         Result.HasARM64EC  := False;
         Result.HasBin64IDE := False;
       end;
    2: begin
         Result.DisplayName := 'Delphi 10.4 Sydney';
         Result.BDSVer      := '21.0';
         Result.PkgSuffix   := '270';
         Result.PkgFolder   := '104';
         Result.LibPrefix   := 'LIBD27';
         Result.Has64x      := False;
         Result.HasARM64EC  := False;
         Result.HasBin64IDE := False;
       end;
    3: begin
         Result.DisplayName := 'Delphi 11 Alexandria';
         Result.BDSVer      := '22.0';
         Result.PkgSuffix   := '280';
         Result.PkgFolder   := '110';
         Result.LibPrefix   := 'LIBD28';
         Result.Has64x      := False;
         Result.HasARM64EC  := False;
         Result.HasBin64IDE := False;
       end;
    4: begin
         Result.DisplayName := 'Delphi 12 Athens';
         Result.BDSVer      := '23.0';
         Result.PkgSuffix   := '290';
         Result.PkgFolder   := '12';
         Result.LibPrefix   := 'LIBD29';
         Result.Has64x      := False;
         Result.HasARM64EC  := False;
         Result.HasBin64IDE := True;
       end;
    5: begin
         Result.DisplayName := 'Delphi 13 Florence';
         Result.BDSVer      := '24.0';
         Result.PkgSuffix   := '370';
         Result.PkgFolder   := '13';
         Result.LibPrefix   := 'LIBD37';
         Result.Has64x      := True;
         Result.HasARM64EC  := True;
         Result.HasBin64IDE := True;
       end;
  end;
end;


// =============================================================================
// Delphi detection
// =============================================================================

procedure DetectDelphiInstalls;
var
  I       : Integer;
  Root    : String;
  RegBase : String;
  Info    : TDelphiVersionInfo;
begin
  for I := 0 to NUM_VERSIONS - 1 do
  begin
    Info    := GetVersionInfo(I);
    RegBase := 'Software\Embarcadero\BDS\' + Info.BDSVer;
    Root    := '';

    // Try HKCU first (per-user install), then HKLM (system-wide)
    if not RegQueryStringValue(HKCU, RegBase, 'RootDir', Root) then
      RegQueryStringValue(HKLM, RegBase, 'RootDir', Root);

    if (Root <> '') and DirExists(Root) then
    begin
      DelphiRoots[I]     := Root;
      DelphiInstalled[I] := True;
      // 64-bit IDE is only present from D12 onwards
      if Info.HasBin64IDE then
        DelphiHasBin64[I] := FileExists(Root + '\bin64\bds.exe')
      else
        DelphiHasBin64[I] := False;
    end
    else
    begin
      DelphiRoots[I]     := '';
      DelphiInstalled[I] := False;
      DelphiHasBin64[I]  := False;
    end;
  end;
end;


// Returns True if the given platform compiler is present for that BDS root.
function PlatformAvailable(const BDSRoot: String; PlatIdx: Integer;
                           const Info: TDelphiVersionInfo): Boolean;
begin
  Result := False;
  if BDSRoot = '' then Exit;
  case PlatIdx of
    PLT_WIN32   : Result := FileExists(BDSRoot + '\bin\dcc32.exe');
    PLT_WIN64   : Result := FileExists(BDSRoot + '\bin\dcc64.exe');
    PLT_WIN64X  : Result := Info.Has64x and
                            FileExists(BDSRoot + '\bin\dcc64.exe');
    PLT_ARM64EC : Result := Info.HasARM64EC and
                            FileExists(BDSRoot + '\bin\dcca64ec.exe');
  end;
end;


// =============================================================================
// Wizard page builders
// =============================================================================

procedure BuildVersionPage;
var
  I, J     : Integer;
  Info     : TDelphiVersionInfo;
  AnyFound : Boolean;
begin
  PageVersions := CreateCustomPage(
    wpSelectDir,
    'Select Delphi Versions',
    'Choose which Delphi installations to install KingCalendar into.' + #13#10 +
    'Only detected installations are listed.'
  );

  VersionChecks           := TNewCheckListBox.Create(PageVersions);
  VersionChecks.Parent    := PageVersions.Surface;
  VersionChecks.Left      := 0;
  VersionChecks.Top       := 0;
  VersionChecks.Width     := PageVersions.SurfaceWidth;
  VersionChecks.Height    := PageVersions.SurfaceHeight;

  AnyFound   := False;
  CheckCount := 0;

  for I := 0 to NUM_VERSIONS - 1 do
  begin
    if not DelphiInstalled[I] then Continue;
    Info := GetVersionInfo(I);
    J    := VersionChecks.Items.Count;

    VersionChecks.AddCheckBox(
      Info.DisplayName + '   [' + DelphiRoots[I] + ']',
      '', 0, True, True, False, True, nil
    );

    // Record which version index this checkbox corresponds to
    CheckToVersion[CheckCount] := I;
    Inc(CheckCount);

    // Annotate 64-bit IDE detection result in the label
    if DelphiHasBin64[I] then
    begin
      VersionChecks.Items[J] :=
        VersionChecks.Items[J] + '   (+64-bit IDE)';
    end;

    AnyFound := True;
  end;

  if not AnyFound then
    VersionChecks.AddCheckBox(
      '(No supported Delphi versions detected on this machine)',
      '', 0, False, False, False, True, nil
    );
end;


procedure BuildPlatformsPage;
begin
  PagePlatforms := CreateCustomPage(
    PageVersions.ID,
    'Select Target Platforms',
    'Choose which platforms to compile and register.' + #13#10 +
    'Only platforms available for the selected Delphi versions are enabled.'
  );

  PlatformChecks        := TNewCheckListBox.Create(PagePlatforms);
  PlatformChecks.Parent := PagePlatforms.Surface;
  PlatformChecks.Left   := 0;
  PlatformChecks.Top    := 0;
  PlatformChecks.Width  := PagePlatforms.SurfaceWidth;
  PlatformChecks.Height := PagePlatforms.SurfaceHeight;

  // Items are added in PLT_* constant order; enabled/checked state is
  // refreshed in ShouldSkipPage when the user moves to this page.
  PlatformChecks.AddCheckBox('Win32  (32-bit Windows)',         '', 0, True,  True,  False, True, nil);
  PlatformChecks.AddCheckBox('Win64  (64-bit Windows)',         '', 0, True,  True,  False, True, nil);
  PlatformChecks.AddCheckBox('Win64x (64-bit Modern / LLVM)',   '', 0, False, False, False, True, nil);
  PlatformChecks.AddCheckBox('WinARM64EC  (ARM64 EC)',          '', 0, False, False, False, True, nil);
end;


procedure BuildConfigPage;
var
  Lbl : TLabel;
begin
  PageBuildConfig := CreateCustomPage(
    PagePlatforms.ID,
    'Build Configuration',
    'Choose whether to compile Debug or Release packages.'
  );

  Lbl          := TLabel.Create(PageBuildConfig);
  Lbl.Parent   := PageBuildConfig.Surface;
  Lbl.Left     := 0;
  Lbl.Top      := 0;
  Lbl.Caption  := 'Select the build configuration:';
  Lbl.AutoSize := True;

  BuildReleaseRB         := TRadioButton.Create(PageBuildConfig);
  BuildReleaseRB.Parent  := PageBuildConfig.Surface;
  BuildReleaseRB.Left    := 0;
  BuildReleaseRB.Top     := 24;
  BuildReleaseRB.Width   := PageBuildConfig.SurfaceWidth;
  BuildReleaseRB.Caption := 'Release  (recommended — optimised, no debug info)';
  BuildReleaseRB.Checked := True;

  BuildDebugRB         := TRadioButton.Create(PageBuildConfig);
  BuildDebugRB.Parent  := PageBuildConfig.Surface;
  BuildDebugRB.Left    := 0;
  BuildDebugRB.Top     := 48;
  BuildDebugRB.Width   := PageBuildConfig.SurfaceWidth;
  BuildDebugRB.Caption := 'Debug  (includes debug symbols)';
end;


// =============================================================================
// Standard wizard callbacks
// =============================================================================

procedure InitializeWizard;
begin
  DetectDelphiInstalls;
  BuildVersionPage;
  BuildPlatformsPage;
  BuildConfigPage;
end;


function ShouldSkipPage(PageID: Integer): Boolean;
var
  I, VerIdx   : Integer;
  CanPlt      : array[0..NUM_PLATFORMS-1] of Boolean;
  AnyVer      : Boolean;
  AnyPlt      : Boolean;
  Info        : TDelphiVersionInfo;
begin
  Result := False;

  // --- Platform page: update enabled state based on selected versions ---
  if PageID = PagePlatforms.ID then
  begin
    AnyVer := False;
    for I := 0 to NUM_PLATFORMS - 1 do CanPlt[I] := False;

    for I := 0 to CheckCount - 1 do
    begin
      if not VersionChecks.Checked[I] then Continue;
      VerIdx := CheckToVersion[I];
      if not DelphiInstalled[VerIdx] then Continue;
      Info   := GetVersionInfo(VerIdx);
      AnyVer := True;
      if PlatformAvailable(DelphiRoots[VerIdx], PLT_WIN32,   Info) then CanPlt[PLT_WIN32]   := True;
      if PlatformAvailable(DelphiRoots[VerIdx], PLT_WIN64,   Info) then CanPlt[PLT_WIN64]   := True;
      if PlatformAvailable(DelphiRoots[VerIdx], PLT_WIN64X,  Info) then CanPlt[PLT_WIN64X]  := True;
      if PlatformAvailable(DelphiRoots[VerIdx], PLT_ARM64EC, Info) then CanPlt[PLT_ARM64EC] := True;
    end;

    for I := 0 to NUM_PLATFORMS - 1 do
    begin
      PlatformChecks.ItemEnabled[I] := CanPlt[I];
      PlatformChecks.Checked[I]     := CanPlt[I];
    end;

    // Skip the platform page if no version was selected
    if not AnyVer then Result := True;
  end;

  // --- Config page: skip if no platform selected ---
  if PageID = PageBuildConfig.ID then
  begin
    AnyPlt := False;
    for I := 0 to NUM_PLATFORMS - 1 do
      if PlatformChecks.Checked[I] then AnyPlt := True;
    if not AnyPlt then Result := True;
  end;
end;


function NextButtonClick(CurPageID: Integer): Boolean;
var
  I          : Integer;
  AnyChecked : Boolean;
begin
  Result := True;

  if CurPageID = PageVersions.ID then
  begin
    AnyChecked := False;
    for I := 0 to CheckCount - 1 do
      if VersionChecks.Checked[I] then AnyChecked := True;
    if not AnyChecked then
    begin
      MsgBox('Please select at least one Delphi version to continue.', mbError, MB_OK);
      Result := False;
    end;
  end;

  if CurPageID = PagePlatforms.ID then
  begin
    AnyChecked := False;
    for I := 0 to NUM_PLATFORMS - 1 do
      if PlatformChecks.Checked[I] then AnyChecked := True;
    if not AnyChecked then
    begin
      MsgBox('Please select at least one platform to continue.', mbError, MB_OK);
      Result := False;
    end;
  end;
end;


// =============================================================================
// Post-install helpers
// =============================================================================

// Append NewPath to a semicolon-separated registry string value (no duplicates).
procedure AppendRegPath(const SubKey, ValueName, NewPath: String);
var
  Existing, NewValue : String;
  Parts              : TStringList;
  I                  : Integer;
  Found              : Boolean;
begin
  Existing := '';
  RegQueryStringValue(HKCU, SubKey, ValueName, Existing);

  Parts := TStringList.Create;
  try
    Parts.Delimiter       := ';';
    Parts.StrictDelimiter := True;
    Parts.DelimitedText   := Existing;
    Found := False;
    for I := 0 to Parts.Count - 1 do
      if CompareText(Trim(Parts[I]), Trim(NewPath)) = 0 then Found := True;
    if not Found then
      Parts.Add(NewPath);
    // Rebuild semicolon string (suppress leading/trailing empty entries)
    NewValue := '';
    for I := 0 to Parts.Count - 1 do
    begin
      if Trim(Parts[I]) = '' then Continue;
      if NewValue <> '' then NewValue := NewValue + ';';
      NewValue := NewValue + Parts[I];
    end;
    RegWriteStringValue(HKCU, SubKey, ValueName, NewValue);
  finally
    Parts.Free;
  end;
end;


// Run a command via cmd.exe; returns MSBuild exit code (0 = success).
function RunBatch(const BatchFile: String): Integer;
var
  ExitCode : Integer;
begin
  if not Exec(ExpandConstant('{cmd}'), '/C "' + BatchFile + '"',
              '', SW_HIDE, ewWaitUntilTerminated, ExitCode) then
    ExitCode := -1;
  Result := ExitCode;
end;


// Write and execute a batch file that calls rsvars.bat then MSBuild.
// Compiles runtime package (all selected platforms) and design-time package (Win32 only).
// Returns True if the build completed without error.
function CompilePackages(const AppDir, BDSRoot, BDSVer,
                         PkgFolder, PkgSuffix, PlatformName,
                         Config: String): Boolean;
var
  RsVars     : String;
  BatchPath  : String;
  RuntimeDpr : String;
  DesignDpr  : String;
  Lines      : TStringList;
  ExitCode   : Integer;
begin
  Result    := False;
  RsVars := BDSRoot + '\bin\rsvars.bat';
  if not FileExists(RsVars) then
  begin
    Log('rsvars.bat not found for BDS ' + BDSVer + '; skipping compile.');
    Exit;
  end;

  RuntimeDpr := AppDir + '\packages\' + PkgFolder + '\KingCalendar'    + PkgSuffix + '.dproj';
  DesignDpr  := AppDir + '\packages\' + PkgFolder + '\dclKingCalendar' + PkgSuffix + '.dproj';

  if not FileExists(RuntimeDpr) then
  begin
    Log('Runtime dproj not found: ' + RuntimeDpr);
    Exit;
  end;

  BatchPath := ExpandConstant('{tmp}') + '\KCBuild_' + PkgSuffix + '_' + PlatformName + '.bat';
  Lines     := TStringList.Create;
  try
    Lines.Add('@echo off');
    Lines.Add('call "' + RsVars + '"');
    // Compile runtime package for the requested platform
    Lines.Add('msbuild "' + RuntimeDpr + '"' +
              ' /t:Build' +
              ' /p:Config=' + Config +
              ' /p:Platform=' + PlatformName +
              ' /nologo /v:minimal');
    // Compile design-time package only for Win32 (IDE is 32-bit for most versions)
    if (PlatformName = 'Win32') and FileExists(DesignDpr) then
      Lines.Add('msbuild "' + DesignDpr + '"' +
                ' /t:Build' +
                ' /p:Config=' + Config +
                ' /p:Platform=Win32' +
                ' /nologo /v:minimal');
    Lines.SaveToFile(BatchPath);
  finally
    Lines.Free;
  end;

  ExitCode := RunBatch(BatchPath);
  if ExitCode = 0 then
    Result := True
  else
    Log('Build warning: exit code ' + IntToStr(ExitCode) +
        ' compiling ' + PkgSuffix + '/' + PlatformName);
end;


// Register the design-time (dcl) BPL in the IDE's Known Packages registry key.
// The BPL is in packages/<folder>/Win32/<Config>/ (MSBuild DCC_ExeOutput).
procedure RegisterBPL(const AppDir, BDSVer, PkgFolder, PkgSuffix, Config: String);
var
  BplPath : String;
  RegKey  : String;
begin
  BplPath := AppDir + '\packages\' + PkgFolder +
             '\Win32\' + Config +
             '\dclKingCalendar' + PkgSuffix + '.bpl';

  if not FileExists(BplPath) then
  begin
    Log('Design-time BPL not found, skipping Known Packages: ' + BplPath);
    Exit;
  end;

  RegKey := 'Software\Embarcadero\BDS\' + BDSVer + '\Known Packages';
  RegWriteStringValue(HKCU, RegKey, BplPath, 'KingCalendar Components');
  Log('Registered BPL: ' + BplPath);
end;


// Add the pre-compiled DCU library folder and the source folder to the
// Delphi library and browsing paths for the given BDS version + platform.
procedure UpdatePaths(const AppDir, BDSVer, LibPrefix,
                      PlatformName, Config: String);
var
  LibDir    : String;
  SrcDir    : String;
  LibKey    : String;
  PltSuffix : String;
begin
  // Map platform name to the LIB folder name suffix
  if      PlatformName = 'Win32'      then PltSuffix := 'x32'
  else if PlatformName = 'Win64'      then PltSuffix := 'x64'
  else if PlatformName = 'Win64x'     then PltSuffix := 'x64x'
  else if PlatformName = 'WinARM64EC' then PltSuffix := ''    // no dedicated LIB folder
  else PltSuffix := '';

  SrcDir := AppDir + '\source';
  LibKey := 'Software\Embarcadero\BDS\' + BDSVer + '\Library\' + PlatformName;

  // Add source to browsing path for all platforms (source is platform-neutral)
  AppendRegPath(LibKey, 'Browsing Path', SrcDir);

  // Add DCU library path when a dedicated LIB folder exists
  if PltSuffix <> '' then
  begin
    LibDir := AppDir + '\' + LibPrefix + PltSuffix + '\' + Config;
    if DirExists(LibDir) then
      AppendRegPath(LibKey, 'Search Path', LibDir)
    else
    begin
      // LIB folder missing — fall back to MSBuild output folder inside packages
      // (MSBuild DCC_ExeOutput = .\$(Platform)\$(Config) relative to dproj)
      Log('LIB folder not found, paths not updated for ' + LibPrefix + PltSuffix);
    end;
  end
  else
  begin
    // ARM64EC: no dedicated LIB folder; point at the MSBuild output in packages/.
    // The caller knows the PkgFolder for this — handled via a separate overload note:
    // We just add the source to browsing; runtime BPL location is in packages/
    // which MSBuild puts on PATH via the Delphi BDS environment.
    Log('No dedicated LIB folder for ' + PlatformName + '; search path not updated.');
  end;
end;


// =============================================================================
// Main post-install driver
// =============================================================================

procedure CurStepChanged(CurStep: TSetupStep);
var
  I, J          : Integer;
  VerIdx        : Integer;
  Info          : TDelphiVersionInfo;
  AppDir        : String;
  Config        : String;
  PlatNames     : array[0..NUM_PLATFORMS-1] of String;
  DoPlat        : array[0..NUM_PLATFORMS-1] of Boolean;
  AnyCompileErr : Boolean;
begin
  if CurStep <> ssPostInstall then Exit;

  AppDir := ExpandConstant('{app}');
  Config := 'Release';
  if BuildDebugRB.Checked then Config := 'Debug';

  PlatNames[PLT_WIN32]   := 'Win32';
  PlatNames[PLT_WIN64]   := 'Win64';
  PlatNames[PLT_WIN64X]  := 'Win64x';
  PlatNames[PLT_ARM64EC] := 'WinARM64EC';

  for J := 0 to NUM_PLATFORMS - 1 do
    DoPlat[J] := PlatformChecks.Checked[J];

  AnyCompileErr := False;

  for I := 0 to CheckCount - 1 do
  begin
    if not VersionChecks.Checked[I] then Continue;
    VerIdx := CheckToVersion[I];
    if not DelphiInstalled[VerIdx] then Continue;
    Info := GetVersionInfo(VerIdx);

    // --- Compile packages for each selected platform ---
    for J := 0 to NUM_PLATFORMS - 1 do
    begin
      if not DoPlat[J] then Continue;
      if not PlatformAvailable(DelphiRoots[VerIdx], J, Info) then Continue;

      if not CompilePackages(
               AppDir,
               DelphiRoots[VerIdx],
               Info.BDSVer,
               Info.PkgFolder,
               Info.PkgSuffix,
               PlatNames[J],
               Config
             ) then
        AnyCompileErr := True;
    end;

    // --- Register design-time BPL (Win32 IDE, standard Known Packages) ---
    if DoPlat[PLT_WIN32] and
       PlatformAvailable(DelphiRoots[VerIdx], PLT_WIN32, Info) then
    begin
      RegisterBPL(AppDir, Info.BDSVer, Info.PkgFolder, Info.PkgSuffix, Config);
    end;

    // --- Update library and browsing paths ---
    for J := 0 to NUM_PLATFORMS - 1 do
    begin
      if not DoPlat[J] then Continue;
      if not PlatformAvailable(DelphiRoots[VerIdx], J, Info) then Continue;

      UpdatePaths(
        AppDir,
        Info.BDSVer,
        Info.LibPrefix,
        PlatNames[J],
        Config
      );
    end;
  end;

  // --- Final status message ---
  if AnyCompileErr then
    MsgBox(
      'KingCalendar was installed but one or more packages could not be compiled.' + #13#10 +
      'Check the setup log for details.' + #13#10 + #13#10 +
      'You can compile the packages manually from the Delphi IDE using the' + #13#10 +
      'group project in the packages\ folder.',
      mbInformation, MB_OK
    )
  else
    MsgBox(
      'KingCalendar has been installed successfully.' + #13#10 + #13#10 +
      'Restart the Delphi IDE to see the components on the palette.' + #13#10 + #13#10 +
      'NOTE: If you use the 64-bit IDE (Delphi 12+), you may need to' + #13#10 +
      'manually install the design-time package via Component > Install Packages.',
      mbInformation, MB_OK
    );
end;
