; =============================================================================
; KingCalendar Setup Script
; Inno Setup 6.x required
;
; Supports Delphi 10.2 Tokyo through Delphi 13 Florence
; Platforms: Win32, Win64, Win64x, WinARM64EC
; =============================================================================

#define AppName    "KingCalendar"
#define AppVersion "2026.0324.0008"
#define AppPublisher "Lance Rasmussen"

[Setup]
AppId={{3F8A2D1B-7C45-4E9F-B6D2-1A5E8C934F70}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppCopyright=Copyright (C) 1995-2026 Lance Rasmussen, Mark Lussier and AppVision
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
AllowNoIcons=no
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
; --- Library support files — DCUs excluded (compiled from source post-install) ---
; --- Delphi 10.2 / BDS 19 ---
Source: "..\LIBD25x32\*";     DestDir: "{app}\LIBD25x32";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD25x64\*";     DestDir: "{app}\LIBD25x64";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
; --- Delphi 10.3 / BDS 20 ---
Source: "..\LIBD26x32\*";     DestDir: "{app}\LIBD26x32";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD26x64\*";     DestDir: "{app}\LIBD26x64";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
; --- Delphi 10.4 / BDS 21 ---
Source: "..\LIBD27x32\*";     DestDir: "{app}\LIBD27x32";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD27x64\*";     DestDir: "{app}\LIBD27x64";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
; --- Delphi 11 / BDS 22 ---
Source: "..\LIBD28x32\*";     DestDir: "{app}\LIBD28x32";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD28x64\*";     DestDir: "{app}\LIBD28x64";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
; --- Delphi 12 / BDS 23 ---
Source: "..\LIBD29x32\*";     DestDir: "{app}\LIBD29x32";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD29x64\*";     DestDir: "{app}\LIBD29x64";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
; --- Delphi 13 / BDS 24 ---
Source: "..\LIBD37x32\*";     DestDir: "{app}\LIBD37x32";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD37x64\*";     DestDir: "{app}\LIBD37x64";     Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
Source: "..\LIBD37x64x\*";    DestDir: "{app}\LIBD37x64x";    Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.dcu"
; --- Documentation ---
Source: "..\Documentation\*"; DestDir: "{app}\Documentation"; Flags: ignoreversion recursesubdirs createallsubdirs
; --- Demos ---
Source: "..\Demos\*";         DestDir: "{app}\Demos";         Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\KingCalendar Documentation"; \
  Filename: "{app}\Documentation\kingcal30.rtf"; \
  WorkingDir: "{app}\Documentation"; \
  Comment: "Open the KingCalendar component reference guide"
Name: "{group}\Uninstall KingCalendar"; \
  Filename: "{uninstallexe}"; \
  Comment: "Remove KingCalendar from this computer"

[Code]

// =============================================================================
// Windows API import
// Second parameter declared as LongInt so we can pass 0 (NULL) to match any
// window title when only the class name matters.
// =============================================================================

function FindWindowW(lpClassName: String; lpWindowName: LongInt): THandle;
  external 'FindWindowW@user32.dll stdcall';


// Returns True if any instance of the Delphi IDE is currently running.
// The IDE main window always registers the class name 'TAppBuilder'.
function IsBDSRunning: Boolean;
begin
  Result := FindWindowW('TAppBuilder', 0) <> 0;
end;


// Called once before the wizard is shown.
// Loops until the user closes the IDE or cancels the installation.
function InitializeSetup: Boolean;
begin
  Result := True;
  while IsBDSRunning do
  begin
    if MsgBox(
         'The Delphi IDE (BDS.EXE) is currently running.' + #13#10 + #13#10 +
         'Please save your work and close the Delphi IDE before continuing,' + #13#10 +
         'then click Retry.  Click Cancel to abort the installation.',
         mbError, MB_RETRYCANCEL
       ) = IDCANCEL then
    begin
      Result := False;
      Exit;
    end;
  end;
end;


// =============================================================================
// Constants and types
// =============================================================================

const
  MAX_VERSIONS  = 16; // maximum number of detectable BDS installations

  // Platform array indices
  PLT_WIN32     = 0;
  PLT_WIN64     = 1;
  PLT_WIN64X    = 2;
  PLT_ARM64EC   = 3;
  NUM_PLATFORMS = 4;

type
  // One detected Delphi installation (populated dynamically at runtime)
  TDetectedDelphi = record
    BDSVer      : String;  // registry subkey, e.g. '24.0'
    BDSRoot     : String;  // IDE root directory
    DisplayName : String;  // e.g. 'Delphi 13 Florence'
    PkgSuffix   : String;  // e.g. '370'
    PkgFolder   : String;  // e.g. '13'
    LibPrefix   : String;  // e.g. 'LIBD37'
    HasBin64    : Boolean; // bin64\bds.exe present (64-bit IDE)
    Has64x      : Boolean; // Win64x platform available
    HasARM64EC  : Boolean; // WinARM64EC platform available
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

  // All detected Delphi installs (populated in DetectDelphiInstalls)
  Versions     : array[0..MAX_VERSIONS-1] of TDetectedDelphi;
  VersionCount : Integer;

  // Maps checkbox list index → Versions[] index
  CheckToVersion : array[0..MAX_VERSIONS-1] of Integer;
  CheckCount     : Integer;


// =============================================================================
// Compiler-version → package info lookup
// Detection reads dcc32.exe file version; major version identifies the release.
// =============================================================================

// Returns False if this compiler major version is not supported by this installer.
function GetPkgInfoByCompilerMajor(CompMajor: Cardinal;
  var PkgSuffix, PkgFolder, LibPrefix, DisplayName: String): Boolean;
begin
  Result := True;
  case CompMajor of
    25: begin PkgSuffix := '250'; PkgFolder := '102'; LibPrefix := 'LIBD25'; DisplayName := 'Delphi 10.2 Tokyo';     end;
    26: begin PkgSuffix := '260'; PkgFolder := '103'; LibPrefix := 'LIBD26'; DisplayName := 'Delphi 10.3 Rio';       end;
    27: begin PkgSuffix := '270'; PkgFolder := '104'; LibPrefix := 'LIBD27'; DisplayName := 'Delphi 10.4 Sydney';    end;
    28: begin PkgSuffix := '280'; PkgFolder := '110'; LibPrefix := 'LIBD28'; DisplayName := 'Delphi 11 Alexandria';  end;
    29: begin PkgSuffix := '290'; PkgFolder := '12';  LibPrefix := 'LIBD29'; DisplayName := 'Delphi 12 Athens';      end;
    37: begin PkgSuffix := '370'; PkgFolder := '13';  LibPrefix := 'LIBD37'; DisplayName := 'Delphi 13 Florence';    end;
  else
    Result := False; // Unknown / unsupported compiler version
  end;
end;


// =============================================================================
// Delphi detection — scans all BDS registry subkeys dynamically
// =============================================================================

procedure DetectDelphiInstalls;
var
  BDSKey    : String;
  SubKeys   : TArrayOfString;
  I         : Integer;
  BDSVer    : String;
  BDSRoot   : String;
  Dcc32Path : String;
  VerMS, VerLS   : Cardinal;
  CompMajor      : Cardinal;
  PkgSuffix, PkgFolder, LibPrefix, DisplayName : String;
  Info      : TDetectedDelphi;
begin
  VersionCount := 0;
  BDSKey := 'Software\Embarcadero\BDS';

  // Enumerate all installed BDS versions; try HKCU then HKLM
  if not RegGetSubkeyNames(HKCU, BDSKey, SubKeys) then
    if not RegGetSubkeyNames(HKLM, BDSKey, SubKeys) then
      Exit;

  for I := 0 to GetArrayLength(SubKeys) - 1 do
  begin
    if VersionCount >= MAX_VERSIONS then Break;
    BDSVer  := SubKeys[I];
    BDSRoot := '';

    // Read RootDir from HKCU first, then HKLM
    if not RegQueryStringValue(HKCU, BDSKey + '\' + BDSVer, 'RootDir', BDSRoot) then
      RegQueryStringValue(HKLM, BDSKey + '\' + BDSVer, 'RootDir', BDSRoot);

    if (BDSRoot = '') or not DirExists(BDSRoot) then Continue;

    // Strip trailing backslash if present
    if Copy(BDSRoot, Length(BDSRoot), 1) = '\' then
      BDSRoot := Copy(BDSRoot, 1, Length(BDSRoot) - 1);

    // Confirm this is a Delphi install (not C++Builder-only etc.)
    Dcc32Path := BDSRoot + '\bin\dcc32.exe';
    if not FileExists(Dcc32Path) then Continue;

    // Read the compiler file version to identify which Delphi release this is
    if not GetVersionNumbers(Dcc32Path, VerMS, VerLS) then Continue;
    CompMajor := VerMS shr 16; // high word of MS = major version

    // Map compiler major version to our package set
    if not GetPkgInfoByCompilerMajor(CompMajor, PkgSuffix, PkgFolder, LibPrefix, DisplayName) then
    begin
      Log('Skipping BDS ' + BDSVer + ': dcc32 v' + IntToStr(CompMajor) + ' not supported.');
      Continue;
    end;

    // Detect available platforms via presence of BDS lib sub-directories
    Info.BDSVer      := BDSVer;
    Info.BDSRoot     := BDSRoot;
    Info.DisplayName := DisplayName;
    Info.PkgSuffix   := PkgSuffix;
    Info.PkgFolder   := PkgFolder;
    Info.LibPrefix   := LibPrefix;
    Info.HasBin64    := FileExists(BDSRoot + '\bin64\bds.exe');
    Info.Has64x      := DirExists(BDSRoot + '\lib\Win64x');
    Info.HasARM64EC  := DirExists(BDSRoot + '\lib\WinARM64EC');

    Versions[VersionCount] := Info;
    Inc(VersionCount);

    Log('Detected: ' + DisplayName + ' [BDS ' + BDSVer + '] at ' + BDSRoot);
  end;
end;


// Returns True if the given platform is available for this installation.
function PlatformAvailable(const BDSRoot: String; PlatIdx: Integer;
                           const Info: TDetectedDelphi): Boolean;
begin
  Result := False;
  if BDSRoot = '' then Exit;
  case PlatIdx of
    PLT_WIN32   : Result := FileExists(BDSRoot + '\bin\dcc32.exe');
    PLT_WIN64   : Result := FileExists(BDSRoot + '\bin\dcc64.exe');
    PLT_WIN64X  : Result := Info.Has64x;
    PLT_ARM64EC : Result := Info.HasARM64EC;
  end;
end;


// =============================================================================
// Wizard page builders
// =============================================================================

procedure BuildVersionPage;
var
  I         : Integer;
  AnyFound  : Boolean;
  ItemLabel : String;
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

  for I := 0 to VersionCount - 1 do
  begin
    ItemLabel := Versions[I].DisplayName + '   [' + Versions[I].BDSRoot + ']';
    if Versions[I].HasBin64 then ItemLabel := ItemLabel + '   (+64-bit IDE)';

    VersionChecks.AddCheckBox(ItemLabel, '', 0, True, True, False, True, nil);

    CheckToVersion[CheckCount] := I;
    Inc(CheckCount);
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
      AnyVer := True;
      if PlatformAvailable(Versions[VerIdx].BDSRoot, PLT_WIN32,   Versions[VerIdx]) then CanPlt[PLT_WIN32]   := True;
      if PlatformAvailable(Versions[VerIdx].BDSRoot, PLT_WIN64,   Versions[VerIdx]) then CanPlt[PLT_WIN64]   := True;
      if PlatformAvailable(Versions[VerIdx].BDSRoot, PLT_WIN64X,  Versions[VerIdx]) then CanPlt[PLT_WIN64X]  := True;
      if PlatformAvailable(Versions[VerIdx].BDSRoot, PLT_ARM64EC, Versions[VerIdx]) then CanPlt[PLT_ARM64EC] := True;
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
// Maps a platform name to its LIBD folder suffix (e.g. 'Win32' -> 'x32').
// Returns '' for platforms with no dedicated LIB folder (ARM64EC).
function GetPlatLibSuffix(const PlatformName: String): String;
begin
  if      PlatformName = 'Win32'      then Result := 'x32'
  else if PlatformName = 'Win64'      then Result := 'x64'
  else if PlatformName = 'Win64x'     then Result := 'x64x'
  else                                     Result := '';
end;


// Returns a quoted /p:DCC_DcuOutput=... argument safe for cmd.exe
function DcuArg(const Path: String): String;
begin
  Result := ' "/p:DCC_DcuOutput=' + Path + '"';
end;


// Compile runtime package for both Debug and Release.
// For Win32, also compiles the design-time (dcl) package for both configs.
// DCC_DcuOutput is overridden on the MSBuild command line so DCUs always land
// in the correct LIBD subfolder, regardless of what the dproj contains.
function CompilePackages(const AppDir, BDSRoot, BDSVer,
                         PkgFolder, PkgSuffix, PlatformName,
                         LibPrefix: String): Boolean;
var
  RsVars      : String;
  BatchPath   : String;
  RuntimeDpr  : String;
  DesignDpr   : String;
  Lines       : TStringList;
  ExitCode    : Integer;
  PlatSuffix  : String;
  DcuPathD    : String;
  DcuPathR    : String;
  Dcu32PathD  : String;
  Dcu32PathR  : String;

begin
  Result := False;
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

  // Compute DCU output paths for this platform
  PlatSuffix := GetPlatLibSuffix(PlatformName);
  if PlatSuffix <> '' then
  begin
    DcuPathD := AppDir + '\' + LibPrefix + PlatSuffix + '\Debug';
    DcuPathR := AppDir + '\' + LibPrefix + PlatSuffix + '\Release';
  end
  else
  begin
    // ARM64EC: no dedicated LIB folder — output within packages tree
    DcuPathD := AppDir + '\packages\' + PkgFolder + '\' + PlatformName + '\Debug';
    DcuPathR := AppDir + '\packages\' + PkgFolder + '\' + PlatformName + '\Release';
  end;

  // Win32 dcl DCU paths (always x32)
  Dcu32PathD := AppDir + '\' + LibPrefix + 'x32\Debug';
  Dcu32PathR := AppDir + '\' + LibPrefix + 'x32\Release';

  BatchPath := ExpandConstant('{tmp}') + '\KCBuild_' + PkgSuffix + '_' + PlatformName + '.bat';
  Lines     := TStringList.Create;
  try
    Lines.Add('@echo off');
    Lines.Add('call "' + RsVars + '"');
    Lines.Add('if errorlevel 1 exit /b %errorlevel%');

    // --- Runtime: Debug ---
    Lines.Add('msbuild "' + RuntimeDpr + '"' +
              ' /t:Build /p:Config=Debug /p:Platform=' + PlatformName +
              DcuArg(DcuPathD) +
              ' /nologo /v:minimal');

    // --- Runtime: Release ---
    Lines.Add('msbuild "' + RuntimeDpr + '"' +
              ' /t:Build /p:Config=Release /p:Platform=' + PlatformName +
              DcuArg(DcuPathR) +
              ' /nologo /v:minimal');

    // --- Design-time (Win32 only): Debug + Release ---
    if (PlatformName = 'Win32') and FileExists(DesignDpr) then
    begin
      Lines.Add('msbuild "' + DesignDpr + '"' +
                ' /t:Build /p:Config=Debug /p:Platform=Win32' +
                DcuArg(Dcu32PathD) +
                ' /nologo /v:minimal');
      Lines.Add('msbuild "' + DesignDpr + '"' +
                ' /t:Build /p:Config=Release /p:Platform=Win32' +
                DcuArg(Dcu32PathR) +
                ' /nologo /v:minimal');
    end;

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


// Copy compiled BPLs for the selected config to the BDS bin folders so the
// IDE can locate them as dependencies, then register the design-time BPL.
//
//   Win32 runtime BPL  → {BDSRoot}\bin\
//   Win32 dcl BPL      → {BDSRoot}\bin\   + Known Packages
//   Win64 runtime BPL  → {BDSRoot}\bin64\ (if 64-bit IDE present)
procedure CopyAndRegisterBPLs(const AppDir, BDSRoot, BDSVer,
                               PkgFolder, PkgSuffix, Config: String;
                               HasBin64: Boolean);
var
  PkgBase   : String;
  BinDir    : String;
  Bin64Dir  : String;
  RuntimeBpl: String;
  DclBpl    : String;
  RegKey    : String;
begin
  PkgBase  := AppDir + '\packages\' + PkgFolder;
  BinDir   := BDSRoot + '\bin\';
  Bin64Dir := BDSRoot + '\bin64\';

  // --- Win32 runtime BPL ---
  RuntimeBpl := PkgBase + '\Win32\' + Config + '\KingCalendar' + PkgSuffix + '.bpl';
  if FileExists(RuntimeBpl) then
    FileCopy(RuntimeBpl, BinDir + 'KingCalendar' + PkgSuffix + '.bpl', False)
  else
    Log('Win32 runtime BPL not found: ' + RuntimeBpl);

  // --- Win32 design-time BPL: copy to bin\ and register ---
  DclBpl := PkgBase + '\Win32\' + Config + '\dclKingCalendar' + PkgSuffix + '.bpl';
  if FileExists(DclBpl) then
  begin
    FileCopy(DclBpl, BinDir + 'dclKingCalendar' + PkgSuffix + '.bpl', False);
    RegKey := 'Software\Embarcadero\BDS\' + BDSVer + '\Known Packages';
    RegWriteStringValue(HKCU, RegKey,
      BinDir + 'dclKingCalendar' + PkgSuffix + '.bpl',
      'KingCalendar Components');
    Log('Registered BPL: ' + BinDir + 'dclKingCalendar' + PkgSuffix + '.bpl');
  end
  else
    Log('Win32 design-time BPL not found: ' + DclBpl);

  // --- Win64 runtime BPL (needed by the 64-bit IDE) ---
  if HasBin64 and DirExists(Bin64Dir) then
  begin
    RuntimeBpl := PkgBase + '\Win64\' + Config + '\KingCalendar' + PkgSuffix + '.bpl';
    if FileExists(RuntimeBpl) then
      FileCopy(RuntimeBpl, Bin64Dir + 'KingCalendar' + PkgSuffix + '.bpl', False)
    else
      Log('Win64 runtime BPL not found: ' + RuntimeBpl);
  end;
end;


// Add the compiled DCU folder (selected config only) and the source folder to
// the Delphi library and browsing paths for the given BDS version + platform.
procedure UpdatePaths(const AppDir, BDSVer, LibPrefix,
                      PlatformName, Config, PkgFolder: String);
var
  LibDir    : String;
  SrcDir    : String;
  LibKey    : String;
  PlatSuffix: String;
begin
  PlatSuffix := GetPlatLibSuffix(PlatformName);
  SrcDir     := AppDir + '\source';
  LibKey     := 'Software\Embarcadero\BDS\' + BDSVer + '\Library\' + PlatformName;

  // Source browsing path is platform-neutral
  AppendRegPath(LibKey, 'Browsing Path', SrcDir);

  if PlatSuffix <> '' then
  begin
    LibDir := AppDir + '\' + LibPrefix + PlatSuffix + '\' + Config;
    if DirExists(LibDir) then
      AppendRegPath(LibKey, 'Search Path', LibDir)
    else
      Log('LIB folder not found after compile, path not updated: ' + LibDir);
  end
  else
  begin
    // ARM64EC — use the MSBuild output folder inside packages as the search path
    LibDir := AppDir + '\packages\' + PkgFolder + '\' + PlatformName + '\' + Config;
    if DirExists(LibDir) then
      AppendRegPath(LibKey, 'Search Path', LibDir)
    else
      Log('ARM64EC output folder not found: ' + LibDir);
  end;
end;


// =============================================================================
// Main post-install driver
// =============================================================================

procedure CurStepChanged(CurStep: TSetupStep);
var
  I, J          : Integer;
  VerIdx        : Integer;
  AppDir        : String;
  Config        : String;
  PlatNames     : array[0..NUM_PLATFORMS-1] of String;
  DoPlat        : array[0..NUM_PLATFORMS-1] of Boolean;
  AnyCompileErr : Boolean;
begin
  // Guard: re-check at the start of actual file installation in case the IDE
  // was launched after the wizard was already open.
  if CurStep = ssInstall then
  begin
    while IsBDSRunning do
    begin
      if MsgBox(
           'The Delphi IDE (BDS.EXE) was opened after setup started.' + #13#10 + #13#10 +
           'Please close the Delphi IDE, then click Retry to continue installation.',
           mbError, MB_RETRYCANCEL
         ) = IDCANCEL then
        Abort;
    end;
  end;

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

    // --- Compile both Debug + Release for each selected platform ---
    for J := 0 to NUM_PLATFORMS - 1 do
    begin
      if not DoPlat[J] then Continue;
      if not PlatformAvailable(Versions[VerIdx].BDSRoot, J, Versions[VerIdx]) then Continue;

      if not CompilePackages(
               AppDir,
               Versions[VerIdx].BDSRoot,
               Versions[VerIdx].BDSVer,
               Versions[VerIdx].PkgFolder,
               Versions[VerIdx].PkgSuffix,
               PlatNames[J],
               Versions[VerIdx].LibPrefix
             ) then
        AnyCompileErr := True;
    end;

    // --- Copy BPLs to BDS bin and register design-time package ---
    // Runs once per version (not per platform); uses the user-selected config.
    if DoPlat[PLT_WIN32] and
       PlatformAvailable(Versions[VerIdx].BDSRoot, PLT_WIN32, Versions[VerIdx]) then
      CopyAndRegisterBPLs(
        AppDir,
        Versions[VerIdx].BDSRoot,
        Versions[VerIdx].BDSVer,
        Versions[VerIdx].PkgFolder,
        Versions[VerIdx].PkgSuffix,
        Config,
        Versions[VerIdx].HasBin64
      );

    // --- Add selected-config DCU folder and source to library paths ---
    for J := 0 to NUM_PLATFORMS - 1 do
    begin
      if not DoPlat[J] then Continue;
      if not PlatformAvailable(Versions[VerIdx].BDSRoot, J, Versions[VerIdx]) then Continue;

      UpdatePaths(
        AppDir,
        Versions[VerIdx].BDSVer,
        Versions[VerIdx].LibPrefix,
        PlatNames[J],
        Config,
        Versions[VerIdx].PkgFolder
      );
    end;
  end;

  // --- Final status message ---
  if AnyCompileErr then
    MsgBox(
      'KingCalendar was installed but one or more packages could not be compiled.' + #13#10 +
      'Check the setup log for details.' + #13#10 + #13#10 +
      'You can compile the packages manually from the Delphi IDE by opening' + #13#10 +
      'the group project in the packages\ subfolder.',
      mbInformation, MB_OK
    )
  else
    MsgBox(
      'KingCalendar has been installed successfully.' + #13#10 + #13#10 +
      'Restart the Delphi IDE to see the components on the palette.',
      mbInformation, MB_OK
    );
end;


// =============================================================================
// Uninstall cleanup — remove compiled artifacts left by the post-install build
// =============================================================================

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  AppDir   : String;
  ExitCode : Integer;
begin
  if CurUninstallStep <> usPostUninstall then Exit;

  AppDir := ExpandConstant('{app}');

  // Delete all *.dcu files recursively (compiled units)
  Exec(ExpandConstant('{cmd}'),
       '/C del /s /f /q "' + AppDir + '\*.dcu"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // Delete all *.o files recursively (linker object files, e.g. dpk.o)
  Exec(ExpandConstant('{cmd}'),
       '/C del /s /f /q "' + AppDir + '\*.o"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // Delete all *.bpl files from the packages output subfolders
  Exec(ExpandConstant('{cmd}'),
       '/C del /s /f /q "' + AppDir + '\packages\*.bpl"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // Delete all *.dcp files (Delphi compiled package descriptors)
  Exec(ExpandConstant('{cmd}'),
       '/C del /s /f /q "' + AppDir + '\*.dcp"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // Remove empty platform/config output directories left inside packages\
  Exec(ExpandConstant('{cmd}'),
       '/C for /d /r "' + AppDir + '\packages" %D in' +
       ' (Debug Release Win32 Win64 Win64x WinARM64EC) do' +
       ' if exist "%D" rmdir /s /q "%D"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);
end;
