; =============================================================================
; KingCalendar Setup Script
; Inno Setup 6.x required
;
; Supports Delphi 10.2 Tokyo through Delphi 13 Florence
; Platforms: Win32, Win64, Win64x, WinARM64EC
; =============================================================================

#define AppName    "KingCalendar"
#define AppVersion "2026.0325.2003"
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
; LR20260325 - Updated folder names to match renamed package directories
Source: "..\packages\dtokyo\*";  DestDir: "{app}\packages\dtokyo";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\drio\*";    DestDir: "{app}\packages\drio";    Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\dsydney\*"; DestDir: "{app}\packages\dsydney"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\d11\*";     DestDir: "{app}\packages\d11";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\d12\*";     DestDir: "{app}\packages\d12";     Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\packages\d13\*";     DestDir: "{app}\packages\d13";     Flags: ignoreversion recursesubdirs createallsubdirs
; --- Pre-compiled binaries (BinPackages) ---
; LR20260325 - Replaced LIBD* folders with BinPackages directory structure
Source: "..\BinPackages\*";   DestDir: "{app}\BinPackages";   Flags: ignoreversion recursesubdirs createallsubdirs
; --- Documentation ---
Source: "..\Documentation\*"; DestDir: "{app}\Documentation"; Flags: ignoreversion recursesubdirs createallsubdirs
; --- Demos ---
Source: "..\Demos\*";         DestDir: "{app}\Demos";         Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.exe"

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

  // Installation log — written to {app}\installation.log after ssPostInstall
  InstallLog : TStringList;


// =============================================================================
// Compiler-version → package info lookup
// Detection reads dcc32.exe file version; major version identifies the release.
// BDS.EXE build number refines the display name and gates platform availability.
//
// Platform availability thresholds (BDS.EXE build, 3rd version component):
//   Win64x    — Delphi 12.1+ (CompMajor=29, build >= 51961)
//                Delphi 13.x  (CompMajor=37, all builds)
//   WinARM64EC — Delphi 13.1+ (CompMajor=37, build >= 59082)
// =============================================================================

// Returns False if this compiler major version is not supported by this installer.
// DisplayName is set to a generic string; call GetDelphiSubInfo to refine it.
function GetPkgInfoByCompilerMajor(CompMajor: Cardinal;
  var PkgSuffix, PkgFolder, LibPrefix, DisplayName: String): Boolean;
begin
  Result := True;
  case CompMajor of
    // LR20260325 - Updated PkgFolder to match renamed package directories
    25: begin PkgSuffix := '250'; PkgFolder := 'dtokyo';  LibPrefix := 'LIBD25'; DisplayName := 'Delphi 10.2 Tokyo';    end;
    26: begin PkgSuffix := '260'; PkgFolder := 'drio';    LibPrefix := 'LIBD26'; DisplayName := 'Delphi 10.3 Rio';      end;
    27: begin PkgSuffix := '270'; PkgFolder := 'dsydney'; LibPrefix := 'LIBD27'; DisplayName := 'Delphi 10.4 Sydney';   end;
    28: begin PkgSuffix := '280'; PkgFolder := 'd11';     LibPrefix := 'LIBD28'; DisplayName := 'Delphi 11 Alexandria'; end;
    29: begin PkgSuffix := '290'; PkgFolder := 'd12';     LibPrefix := 'LIBD29'; DisplayName := 'Delphi 12 Athens';     end;
    37: begin PkgSuffix := '370'; PkgFolder := 'd13';     LibPrefix := 'LIBD37'; DisplayName := 'Delphi 13 Florence';   end;
  else
    Result := False; // Unknown / unsupported compiler version
  end;
end;

// Refines DisplayName to the exact Delphi sub-version (e.g. 'Delphi 12.3 Athens')
// using the BDS.EXE build number (third component of the four-part file version).
// LR20260324 - Added sub-version name mapping from BDS.EXE build number
procedure GetDelphiSubInfo(CompMajor, BdsBuild: Cardinal;
                           var DisplayName: String);
begin
  case CompMajor of
    25: DisplayName := 'Delphi 10.2 Tokyo';
    26: DisplayName := 'Delphi 10.3 Rio';
    27: begin
          if    BdsBuild < 38860 then DisplayName := 'Delphi 10.4.0 Sydney'
          else if BdsBuild < 40680 then DisplayName := 'Delphi 10.4.1 Sydney'
          else                          DisplayName := 'Delphi 10.4.2 Sydney';
        end;
    28: begin
          if    BdsBuild < 44500 then DisplayName := 'Delphi 11.0 Alexandria'
          else if BdsBuild < 46141 then DisplayName := 'Delphi 11.1 Alexandria'
          else                          DisplayName := 'Delphi 11.2 Alexandria';
        end;
    29: begin
          if    BdsBuild < 50492 then DisplayName := 'Delphi 12.0 Athens (RTM)'
          else if BdsBuild < 51961 then DisplayName := 'Delphi 12.0 Athens'
          else if BdsBuild < 53571 then DisplayName := 'Delphi 12.1 Athens'
          else if BdsBuild < 53982 then DisplayName := 'Delphi 12.2 Athens'
          else if BdsBuild < 55362 then DisplayName := 'Delphi 12.2.1 Athens'
          else                          DisplayName := 'Delphi 12.3 Athens';
        end;
    37: begin
          if BdsBuild < 59082 then DisplayName := 'Delphi 13.0 Florence'
          else                     DisplayName := 'Delphi 13.1 Florence';
        end;
  end;
end;

// Sets platform availability flags based on BDS.EXE version thresholds.
// A version gate is applied first; the lib directory is then checked to confirm
// the platform is actually present in this installation.
// LR20260324 - Added version-gated platform detection using BDS.EXE build number
procedure SetPlatformFlags(CompMajor, BdsBuild: Cardinal;
                           const BDSRoot: String;
                           var Has64x, HasARM64EC: Boolean);
begin
  Has64x     := False;
  HasARM64EC := False;
  case CompMajor of
    29: begin
          // Win64x (WIN64 Modern) requires Delphi 12.1+ (build >= 51961)
          if BdsBuild >= 51961 then
            Has64x := DirExists(BDSRoot + '\lib\Win64x');
        end;
    37: begin
          // Win64x available for all Delphi 13.x
          Has64x := DirExists(BDSRoot + '\lib\Win64x');
          // WinARM64EC requires Delphi 13.1+ (build >= 59082)
          if BdsBuild >= 59082 then
            HasARM64EC := DirExists(BDSRoot + '\lib\WinARM64EC');
        end;
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
  BdsPath   : String;
  VerMS, VerLS       : Cardinal;
  BdsVerMS, BdsVerLS : Cardinal;
  CompMajor : Cardinal;
  BdsBuild  : Cardinal;  // 3rd component of BDS.EXE file version
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

    // Read BDS.EXE version to obtain the exact build number (3rd component).
    // This is used to refine the display name and gate platform availability.
    // LR20260324 - Added BDS.EXE version read for sub-version and platform detection
    BdsBuild := 0;
    BdsPath  := BDSRoot + '\bin\bds.exe';
    if FileExists(BdsPath) and GetVersionNumbers(BdsPath, BdsVerMS, BdsVerLS) then
      BdsBuild := BdsVerLS shr 16;  // high word of LS = build (3rd component)

    // Refine display name to exact sub-version (e.g. 'Delphi 12.3 Athens')
    GetDelphiSubInfo(CompMajor, BdsBuild, DisplayName);

    // Set platform availability flags using version thresholds + directory checks
    Info.BDSVer      := BDSVer;
    Info.BDSRoot     := BDSRoot;
    Info.DisplayName := DisplayName;
    Info.PkgSuffix   := PkgSuffix;
    Info.PkgFolder   := PkgFolder;
    Info.LibPrefix   := LibPrefix;
    Info.HasBin64    := FileExists(BDSRoot + '\bin64\bds.exe');
    SetPlatformFlags(CompMajor, BdsBuild, BDSRoot, Info.Has64x, Info.HasARM64EC);

    Versions[VersionCount] := Info;
    Inc(VersionCount);

    Log('Detected: ' + DisplayName + ' [BDS ' + BDSVer + '] build=' +
        IntToStr(BdsBuild) + ' at ' + BDSRoot);
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
// Logging and progress helpers
// =============================================================================

// Append a timestamped entry to the installation log and to the Inno Setup log.
procedure LogLine(const Msg: String);
begin
  if Assigned(InstallLog) then
    InstallLog.Add('[' + GetDateTimeString('yyyy/mm/dd hh:nn:ss', '/', ':') + '] ' + Msg);
  Log(Msg);
end;


// Update the wizard status label so the user can see what is happening.
// Must call Application.ProcessMessages after to repaint the window.
procedure SetStatus(const Msg: String);
begin
  WizardForm.StatusLabel.Caption := Msg;
  WizardForm.Update;
end;


// Inno Setup Pascal has no BoolToStr; use this wrapper instead.
function BoolStr(B: Boolean): String;
begin
  if B then Result := 'True' else Result := 'False';
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


// Read the BDSCOMMONDIR value from a rsvars.bat or rsvars64.bat file.
// The relevant line looks like:  @SET BDSCOMMONDIR=C:\Users\Public\...
// Returns the path with any trailing backslash stripped, or '' if not found.
function ReadBDSCommonDir(const RsVarsPath: String): String;
var
  Lines  : TStringList;
  I      : Integer;
  Line   : String;
  Marker : String;
begin
  Result := '';
  if not FileExists(RsVarsPath) then Exit;

  Marker := '@SET BDSCOMMONDIR=';
  Lines  := TStringList.Create;
  try
    Lines.LoadFromFile(RsVarsPath);
    for I := 0 to Lines.Count - 1 do
    begin
      Line := Trim(Lines[I]);
      if CompareText(Copy(Line, 1, Length(Marker)), Marker) = 0 then
      begin
        Result := Trim(Copy(Line, Length(Marker) + 1, MaxInt));
        // Strip any trailing backslash
        while (Length(Result) > 0) and (Result[Length(Result)] = '\') do
          Result := Copy(Result, 1, Length(Result) - 1);
        Break;
      end;
    end;
  finally
    Lines.Free;
  end;
end;


// Write and execute a batch file that calls rsvars.bat then MSBuild.
// Compiles runtime package (all selected platforms) and design-time package (Win32 only).
// Returns True if the build completed without error.
// Maps a platform name to its LIBD folder suffix (e.g. 'Win32' -> 'x32').
// LR20260325 - Returns MSBuild /p: arguments to override all output paths
function OutputArgs(const OutDir: String): String;
begin
  Result := ' "/p:DCC_DcuOutput=' + OutDir + '"' +
            ' "/p:DCC_DcpOutput=' + OutDir + '"' +
            ' "/p:DCC_BplOutput=' + OutDir + '"';
end;


// LR20260325 - Rewritten to output all compiled files to BinPackages directory.
// All 4 packages are compiled for the given platform in both Debug and Release.
// Output: {app}\BinPackages\{PkgFolder}\{Platform}\{Config}\
// Design-time packages are compiled during the Win32 pass (and Win64 when HasBin64).
function CompilePackages(const AppDir, BDSRoot, BDSVer,
                         PkgFolder, PkgSuffix, PlatformName,
                         LibPrefix: String; HasBin64: Boolean): Boolean;
var
  RsVars      : String;
  BatchPath   : String;
  MsbuildLog  : String;
  RuntimeDpr  : String;
  DBRuntimeDpr: String;
  DesignDpr   : String;
  DBDesignDpr : String;
  Lines       : TStringList;
  LogLines    : TStringList;
  ExitCode    : Integer;
  OutPathD    : String;
  OutPathR    : String;
  Out64PathD  : String;
  Out64PathR  : String;
  BinBase     : String;
  I           : Integer;

begin
  Result := False;
  RsVars := BDSRoot + '\bin\rsvars.bat';
  if not FileExists(RsVars) then
  begin
    LogLine('rsvars.bat not found for BDS ' + BDSVer + '; skipping compile.');
    Exit;
  end;

  RuntimeDpr   := AppDir + '\packages\' + PkgFolder + '\KingCalendar'      + PkgSuffix + '.dproj';
  DBRuntimeDpr := AppDir + '\packages\' + PkgFolder + '\KingCalendarDB'    + PkgSuffix + '.dproj';
  DesignDpr    := AppDir + '\packages\' + PkgFolder + '\dclKingCalendar'   + PkgSuffix + '.dproj';
  DBDesignDpr  := AppDir + '\packages\' + PkgFolder + '\dclKingCalendarDB' + PkgSuffix + '.dproj';

  if not FileExists(RuntimeDpr) then
  begin
    LogLine('Runtime dproj not found: ' + RuntimeDpr);
    Exit;
  end;

  // Output paths: BinPackages\<PkgFolder>\<Platform>\<Config>
  BinBase    := AppDir + '\BinPackages\' + PkgFolder;
  OutPathD   := BinBase + '\' + PlatformName + '\Debug';
  OutPathR   := BinBase + '\' + PlatformName + '\Release';
  Out64PathD := BinBase + '\Win64\Debug';
  Out64PathR := BinBase + '\Win64\Release';

  BatchPath  := ExpandConstant('{tmp}') + '\KCBuild_' + PkgSuffix + '_' + PlatformName + '.bat';
  MsbuildLog := ExpandConstant('{tmp}') + '\KCBuild_' + PkgSuffix + '_' + PlatformName + '.log';

  Lines := TStringList.Create;
  try
    Lines.Add('@echo off');
    Lines.Add('call "' + RsVars + '"');
    Lines.Add('if errorlevel 1 exit /b %errorlevel%');

    // Create output directories
    Lines.Add('if not exist "' + OutPathD + '" mkdir "' + OutPathD + '"');
    Lines.Add('if not exist "' + OutPathR + '" mkdir "' + OutPathR + '"');

    // --- Runtime: Debug + Release ---
    Lines.Add('msbuild "' + RuntimeDpr + '"' +
              ' /t:Build /p:Config=Debug /p:Platform=' + PlatformName +
              OutputArgs(OutPathD) +
              ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
    Lines.Add('msbuild "' + RuntimeDpr + '"' +
              ' /t:Build /p:Config=Release /p:Platform=' + PlatformName +
              OutputArgs(OutPathR) +
              ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');

    // --- DB Runtime: Debug + Release ---
    if FileExists(DBRuntimeDpr) then
    begin
      Lines.Add('msbuild "' + DBRuntimeDpr + '"' +
                ' /t:Build /p:Config=Debug /p:Platform=' + PlatformName +
                OutputArgs(OutPathD) +
                ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
      Lines.Add('msbuild "' + DBRuntimeDpr + '"' +
                ' /t:Build /p:Config=Release /p:Platform=' + PlatformName +
                OutputArgs(OutPathR) +
                ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
    end;

    // --- Design-time packages (Win32 pass only) ---
    if (PlatformName = 'Win32') and FileExists(DesignDpr) then
    begin
      // Win32 dcl
      Lines.Add('msbuild "' + DesignDpr + '"' +
                ' /t:Build /p:Config=Debug /p:Platform=Win32' +
                OutputArgs(OutPathD) +
                ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
      Lines.Add('msbuild "' + DesignDpr + '"' +
                ' /t:Build /p:Config=Release /p:Platform=Win32' +
                OutputArgs(OutPathR) +
                ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');

      // Win64 dcl for 64-bit IDE
      if HasBin64 then
      begin
        Lines.Add('if not exist "' + Out64PathD + '" mkdir "' + Out64PathD + '"');
        Lines.Add('if not exist "' + Out64PathR + '" mkdir "' + Out64PathR + '"');
        Lines.Add('msbuild "' + DesignDpr + '"' +
                  ' /t:Build /p:Config=Debug /p:Platform=Win64' +
                  OutputArgs(Out64PathD) +
                  ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
        Lines.Add('msbuild "' + DesignDpr + '"' +
                  ' /t:Build /p:Config=Release /p:Platform=Win64' +
                  OutputArgs(Out64PathR) +
                  ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
      end;

      // DB design-time
      if FileExists(DBDesignDpr) then
      begin
        Lines.Add('msbuild "' + DBDesignDpr + '"' +
                  ' /t:Build /p:Config=Debug /p:Platform=Win32' +
                  OutputArgs(OutPathD) +
                  ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
        Lines.Add('msbuild "' + DBDesignDpr + '"' +
                  ' /t:Build /p:Config=Release /p:Platform=Win32' +
                  OutputArgs(OutPathR) +
                  ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
        if HasBin64 then
        begin
          Lines.Add('msbuild "' + DBDesignDpr + '"' +
                    ' /t:Build /p:Config=Debug /p:Platform=Win64' +
                    OutputArgs(Out64PathD) +
                    ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
          Lines.Add('msbuild "' + DBDesignDpr + '"' +
                    ' /t:Build /p:Config=Release /p:Platform=Win64' +
                    OutputArgs(Out64PathR) +
                    ' /nologo /v:minimal >> "' + MsbuildLog + '" 2>&1');
        end;
      end;
    end;

    // Copy .RES and .DFM from source to output directories
    Lines.Add('copy /Y "' + AppDir + '\source\*.res" "' + OutPathD + '\" >nul 2>&1');
    Lines.Add('copy /Y "' + AppDir + '\source\*.dfm" "' + OutPathD + '\" >nul 2>&1');
    Lines.Add('copy /Y "' + AppDir + '\source\*.res" "' + OutPathR + '\" >nul 2>&1');
    Lines.Add('copy /Y "' + AppDir + '\source\*.dfm" "' + OutPathR + '\" >nul 2>&1');

    Lines.SaveToFile(BatchPath);
  finally
    Lines.Free;
  end;

  LogLine('Compiling ' + PkgSuffix + '/' + PlatformName + ' ...');
  ExitCode := RunBatch(BatchPath);

  // Append MSBuild output to the installation log for debugging
  if FileExists(MsbuildLog) then
  begin
    LogLines := TStringList.Create;
    try
      LogLines.LoadFromFile(MsbuildLog);
      for I := 0 to LogLines.Count - 1 do
        LogLine('  [msbuild] ' + LogLines[I]);
    finally
      LogLines.Free;
    end;
  end;

  if ExitCode = 0 then
  begin
    Result := True;
    LogLine('Compile OK: ' + PkgSuffix + '/' + PlatformName);
  end
  else
    LogLine('Compile FAILED (exit ' + IntToStr(ExitCode) + '): ' +
            PkgSuffix + '/' + PlatformName);
end;


// LR20260325 - Rewritten: BPLs are now in BinPackages, registered directly from there.
// No copying to BDSCOMMONDIR — the IDE loads BPLs from the registered path.
procedure CopyAndRegisterBPLs(const AppDir, BDSRoot, BDSVer,
                               PkgFolder, PkgSuffix, Config: String;
                               HasBin64: Boolean);
var
  BinBase     : String;
  BplPath     : String;
  Bpl64Path   : String;
  RegKey32    : String;
  RegKey64    : String;
  CommonDir32 : String;
  CommonDir64 : String;
  BplDir      : String;
  Bpl64Dir    : String;
begin
  BinBase  := AppDir + '\BinPackages\' + PkgFolder;
  RegKey32 := 'Software\Embarcadero\BDS\' + BDSVer + '\Known Packages';
  RegKey64 := 'Software\Embarcadero\BDS\' + BDSVer + '\Known Packages x64';

  LogLine('Registering BPLs for BDS ' + BDSVer + '  Config=' + Config +
          '  HasBin64=' + BoolStr(HasBin64));

  // --- Copy runtime BPLs to BDSCOMMONDIR so the IDE can find them ---
  // LR20260325 - Runtime BPLs ({$RUNONLY}) can't go in Known Packages.
  // They must be in a directory the IDE searches for DLL dependencies.
  // BDSCOMMONDIR\Bpl (Win32) and BDSCOMMONDIR\Bpl\Win64 (64-bit IDE)
  // are the standard locations Delphi uses.
  CommonDir32 := ReadBDSCommonDir(BDSRoot + '\bin\rsvars.bat');
  if CommonDir32 = '' then
    CommonDir32 := ExpandConstant('{%PUBLIC}\Documents') +
                   '\Embarcadero\Studio\' + BDSVer;

  BplDir := CommonDir32 + '\Bpl';
  ForceDirectories(BplDir);

  // Copy all Win32 BPLs (runtime + design-time) to BDSCOMMONDIR\Bpl
  BplPath := BinBase + '\Win32\' + Config;
  if DirExists(BplPath) then
  begin
    CopyFile(BplPath + '\KingCalendar'      + PkgSuffix + '.bpl', BplDir + '\KingCalendar'      + PkgSuffix + '.bpl', False);
    CopyFile(BplPath + '\KingCalendarDB'    + PkgSuffix + '.bpl', BplDir + '\KingCalendarDB'    + PkgSuffix + '.bpl', False);
    CopyFile(BplPath + '\dclKingCalendar'   + PkgSuffix + '.bpl', BplDir + '\dclKingCalendar'   + PkgSuffix + '.bpl', False);
    CopyFile(BplPath + '\dclKingCalendarDB' + PkgSuffix + '.bpl', BplDir + '\dclKingCalendarDB' + PkgSuffix + '.bpl', False);
    LogLine('Copied Win32 BPLs to: ' + BplDir);
  end;

  // Register Win32 design-time BPLs from BDSCOMMONDIR\Bpl
  BplPath := BplDir + '\dclKingCalendar' + PkgSuffix + '.bpl';
  if FileExists(BplPath) then
  begin
    RegWriteStringValue(HKCU, RegKey32, BplPath, 'KingCalendar');
    LogLine('Registered Win32 dcl: ' + BplPath);
  end;
  BplPath := BplDir + '\dclKingCalendarDB' + PkgSuffix + '.bpl';
  if FileExists(BplPath) then
  begin
    RegWriteStringValue(HKCU, RegKey32, BplPath, 'KingCalendar DB');
    LogLine('Registered Win32 DB dcl: ' + BplPath);
  end;

  // Copy all Win64 BPLs and register design-time for 64-bit IDE
  if HasBin64 then
  begin
    CommonDir64 := ReadBDSCommonDir(BDSRoot + '\bin64\rsvars64.bat');
    if CommonDir64 = '' then CommonDir64 := CommonDir32;
    Bpl64Dir := CommonDir64 + '\Bpl\Win64';
    ForceDirectories(Bpl64Dir);

    Bpl64Path := BinBase + '\Win64\' + Config;
    if DirExists(Bpl64Path) then
    begin
      CopyFile(Bpl64Path + '\KingCalendar'      + PkgSuffix + '.bpl', Bpl64Dir + '\KingCalendar'      + PkgSuffix + '.bpl', False);
      CopyFile(Bpl64Path + '\KingCalendarDB'    + PkgSuffix + '.bpl', Bpl64Dir + '\KingCalendarDB'    + PkgSuffix + '.bpl', False);
      CopyFile(Bpl64Path + '\dclKingCalendar'   + PkgSuffix + '.bpl', Bpl64Dir + '\dclKingCalendar'   + PkgSuffix + '.bpl', False);
      CopyFile(Bpl64Path + '\dclKingCalendarDB' + PkgSuffix + '.bpl', Bpl64Dir + '\dclKingCalendarDB' + PkgSuffix + '.bpl', False);
      LogLine('Copied Win64 BPLs to: ' + Bpl64Dir);
    end;

    Bpl64Path := Bpl64Dir + '\dclKingCalendar' + PkgSuffix + '.bpl';
    if FileExists(Bpl64Path) then
    begin
      RegWriteStringValue(HKCU, RegKey64, Bpl64Path, 'KingCalendar');
      LogLine('Registered Win64 dcl: ' + Bpl64Path);
    end;
    Bpl64Path := Bpl64Dir + '\dclKingCalendarDB' + PkgSuffix + '.bpl';
    if FileExists(Bpl64Path) then
    begin
      RegWriteStringValue(HKCU, RegKey64, Bpl64Path, 'KingCalendar DB');
      LogLine('Registered Win64 DB dcl: ' + Bpl64Path);
    end;
  end;
end;


// LR20260325 - Rewritten: library paths now point to BinPackages.
procedure UpdatePaths(const AppDir, BDSVer, LibPrefix,
                      PlatformName, Config, PkgFolder: String);
var
  LibDir : String;
  SrcDir : String;
  LibKey : String;
begin
  SrcDir := AppDir + '\source';
  LibKey := 'Software\Embarcadero\BDS\' + BDSVer + '\Library\' + PlatformName;

  // Source browsing path
  AppendRegPath(LibKey, 'Browsing Path', SrcDir);

  // Compiled output path: BinPackages\<PkgFolder>\<Platform>\<Config>
  LibDir := AppDir + '\BinPackages\' + PkgFolder + '\' + PlatformName + '\' + Config;
  if DirExists(LibDir) then
    AppendRegPath(LibKey, 'Search Path', LibDir)
  else
    Log('BinPackages folder not found: ' + LibDir);
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

  // Initialise the installation log; will be saved to {app}\installation.log
  InstallLog := TStringList.Create;
  LogLine('KingCalendar post-install started');
  LogLine('AppDir=' + AppDir + '  Config=' + Config);

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

    LogLine('Processing: ' + Versions[VerIdx].DisplayName +
            '  BDSVer=' + Versions[VerIdx].BDSVer +
            '  HasBin64=' + BoolStr(Versions[VerIdx].HasBin64));

    // --- Compile both Debug + Release for each selected platform ---
    for J := 0 to NUM_PLATFORMS - 1 do
    begin
      if not DoPlat[J] then Continue;
      if not PlatformAvailable(Versions[VerIdx].BDSRoot, J, Versions[VerIdx]) then Continue;

      SetStatus('Compiling ' + Versions[VerIdx].DisplayName +
                ' / ' + PlatNames[J] + ' ...');

      if not CompilePackages(
               AppDir,
               Versions[VerIdx].BDSRoot,
               Versions[VerIdx].BDSVer,
               Versions[VerIdx].PkgFolder,
               Versions[VerIdx].PkgSuffix,
               PlatNames[J],
               Versions[VerIdx].LibPrefix,
               Versions[VerIdx].HasBin64
             ) then
        AnyCompileErr := True;
    end;

    // --- Copy BPLs to BDS bin and register design-time package ---
    // Runs once per version (not per platform); uses the user-selected config.
    if DoPlat[PLT_WIN32] and
       PlatformAvailable(Versions[VerIdx].BDSRoot, PLT_WIN32, Versions[VerIdx]) then
    begin
      SetStatus('Registering ' + Versions[VerIdx].DisplayName + ' design-time package ...');
      CopyAndRegisterBPLs(
        AppDir,
        Versions[VerIdx].BDSRoot,
        Versions[VerIdx].BDSVer,
        Versions[VerIdx].PkgFolder,
        Versions[VerIdx].PkgSuffix,
        Config,
        Versions[VerIdx].HasBin64
      );
    end;

    // --- Add selected-config DCU folder and source to library paths ---
    SetStatus('Updating library paths for ' + Versions[VerIdx].DisplayName + ' ...');
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

  // --- Save installation log to {app}\installation.log ---
  SetStatus('Saving installation log ...');
  LogLine('Post-install complete.  AnyCompileErr=' + BoolStr(AnyCompileErr));
  try
    InstallLog.SaveToFile(AppDir + '\installation.log');
  except
    Log('Warning: could not save installation.log');
  end;
  InstallLog.Free;
  InstallLog := nil;

  // --- Final status message ---
  if AnyCompileErr then
    MsgBox(
      'KingCalendar was installed but one or more packages could not be compiled.' + #13#10 +
      'Check installation.log in the installation folder for details.' + #13#10 + #13#10 +
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
// LR20260325 - Uninstall helpers — BPLs are in BinPackages, not BDSCOMMONDIR
// =============================================================================


// Remove every Known Packages registry value whose name contains 'KingCalendar'.
// KeySuffix is '' for 32-bit IDE or ' x64' for 64-bit IDE.
procedure CleanKnownPackages(const BDSVer, KeySuffix: String);
var
  RegKey : String;
  Names  : TArrayOfString;
  I      : Integer;
begin
  RegKey := 'Software\Embarcadero\BDS\' + BDSVer + '\Known Packages' + KeySuffix;
  if RegGetValueNames(HKCU, RegKey, Names) then
    for I := 0 to GetArrayLength(Names) - 1 do
      if Pos('KingCalendar', Names[I]) > 0 then
        RegDeleteValue(HKCU, RegKey, Names[I]);
end;


// =============================================================================
// Uninstall cleanup — remove compiled artifacts left by the post-install build
// =============================================================================

// LR20260325 - Rewritten: BPLs are in BinPackages, not BDSCOMMONDIR.
// Only need to remove registry entries and delete BinPackages + packages build output.
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  AppDir      : String;
  BatchPath   : String;
  Lines       : TStringList;
  ExitCode    : Integer;
  I           : Integer;
  CommonDir32 : String;
  CommonDir64 : String;
begin
  if CurUninstallStep <> usPostUninstall then Exit;

  AppDir := ExpandConstant('{app}');

  // Remove the installation log
  DeleteFile(AppDir + '\installation.log');

  // --- Remove registry entries and copied runtime BPLs for every detected Delphi ---
  DetectDelphiInstalls;
  for I := 0 to VersionCount - 1 do
  begin
    CleanKnownPackages(Versions[I].BDSVer, '');      // 32-bit IDE
    CleanKnownPackages(Versions[I].BDSVer, ' x64');  // 64-bit IDE

    // Remove runtime BPLs copied to BDSCOMMONDIR during install
    CommonDir32 := ReadBDSCommonDir(Versions[I].BDSRoot + '\bin\rsvars.bat');
    if CommonDir32 = '' then
      CommonDir32 := ExpandConstant('{%PUBLIC}\Documents') +
                     '\Embarcadero\Studio\' + Versions[I].BDSVer;
    // Remove all KingCalendar BPLs from BDSCOMMONDIR\Bpl
    DeleteFile(CommonDir32 + '\Bpl\KingCalendar'      + Versions[I].PkgSuffix + '.bpl');
    DeleteFile(CommonDir32 + '\Bpl\KingCalendarDB'    + Versions[I].PkgSuffix + '.bpl');
    DeleteFile(CommonDir32 + '\Bpl\dclKingCalendar'   + Versions[I].PkgSuffix + '.bpl');
    DeleteFile(CommonDir32 + '\Bpl\dclKingCalendarDB' + Versions[I].PkgSuffix + '.bpl');

    if Versions[I].HasBin64 then
    begin
      CommonDir64 := ReadBDSCommonDir(Versions[I].BDSRoot + '\bin64\rsvars64.bat');
      if CommonDir64 = '' then CommonDir64 := CommonDir32;
      DeleteFile(CommonDir64 + '\Bpl\Win64\KingCalendar'      + Versions[I].PkgSuffix + '.bpl');
      DeleteFile(CommonDir64 + '\Bpl\Win64\KingCalendarDB'    + Versions[I].PkgSuffix + '.bpl');
      DeleteFile(CommonDir64 + '\Bpl\Win64\dclKingCalendar'   + Versions[I].PkgSuffix + '.bpl');
      DeleteFile(CommonDir64 + '\Bpl\Win64\dclKingCalendarDB' + Versions[I].PkgSuffix + '.bpl');
    end;
  end;

  // --- Remove BinPackages directory (all compiled output) ---
  Exec(ExpandConstant('{cmd}'),
       '/C rd /s /q "' + AppDir + '\BinPackages"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // --- Remove compiled artifacts from packages build output ---
  Exec(ExpandConstant('{cmd}'),
       '/C del /s /f /q "' + AppDir + '\packages\*.dcu" "' + AppDir + '\packages\*.bpl" "' + AppDir + '\packages\*.dcp" "' + AppDir + '\packages\*.o"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // --- Remove all empty directories recursively ---
  BatchPath := ExpandConstant('{tmp}') + '\KCRmDirs.bat';
  Lines := TStringList.Create;
  try
    Lines.Add('@echo off');
    Lines.Add(':loop');
    Lines.Add('set found=0');
    Lines.Add('for /f "delims=" %%D in (''dir /ad /b /s "' + AppDir + '" 2^>nul'') do (');
    Lines.Add('  rd "%%D" 2>nul');
    Lines.Add('  if not errorlevel 1 set found=1');
    Lines.Add(')');
    Lines.Add('if "%found%"=="1" goto loop');
    Lines.SaveToFile(BatchPath);
  finally
    Lines.Free;
  end;

  Exec(ExpandConstant('{cmd}'), '/C "' + BatchPath + '"',
       '', SW_HIDE, ewWaitUntilTerminated, ExitCode);

  // Delete the installation folder itself if it is now empty
  RemoveDir(AppDir);
end;
