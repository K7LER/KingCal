# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KingCalendar is a Delphi VCL component library providing calendar controls for Windows applications. It targets Delphi 10.2 through 13. The codebase is Object Pascal with no external dependencies beyond the standard Delphi VCL packages.

## Building

There is no CLI build system. Builds are done inside the Delphi IDE:

1. Open the group project for the target Delphi version, e.g. `packages/d13/D13All.groupproj`
2. Compile the runtime package first (e.g. `KingCalendar370.dpk`)
3. Compile the DB runtime package (e.g. `KingCalendarDB370.dpk`)
4. Compile the design-time package (e.g. `dclKingCalendar370.dpk`) → **Install** to register base components
5. Compile the DB design-time package (e.g. `dclKingCalendarDB370.dpk`) → **Install** to register DB components

Pre-compiled binaries live in `LIB<ver>x32/RELEASE` and `LIB<ver>x64/RELEASE` (e.g. `LIBD37x64`). To use them without recompiling, add the appropriate lib folder to the Delphi Library Path and add `source/` to the Browsing Path.

## Package Naming Convention

| Delphi Version | BDS Key | Package suffix | Folder | Platforms |
|---|---|---|---|---|
| 10.2 Tokyo | 25.0 | 250 | packages/dtokyo | Win32, Win64 |
| 10.3 Rio | 26.0 | 260 | packages/drio | Win32, Win64 |
| 10.4 Sydney | 27.0 | 270 | packages/dsydney | Win32, Win64 |
| 11 Alexandria | 28.0 | 280 | packages/d11 | Win32, Win64 |
| 12 Athens | 29.0 | 290 | packages/d12 | Win32, Win64, Win64x |
| 13 Florence | 37.0 | 370 | packages/d13 | Win32, Win64, Win64x |

Each version has four packages:
- **Runtime** (`KingCalendar<ver>.dpk`) — `{$RUNONLY}`, contains all base implementation units + LiveBindings registration
- **Runtime DB** (`KingCalendarDB<ver>.dpk`) — `{$RUNONLY}`, database-aware components (`DBKingSpin.pas`); requires `dbrtl`, `bindengine`, `bindcomp`
- **Design-time** (`dclKingCalendar<ver>.dpk`) — `{$DESIGNONLY}`, contains `Kcal32.pas` (base component registration)
- **Design-time DB** (`dclKingCalendarDB<ver>.dpk`) — `{$DESIGNONLY}`, contains `Kcal32DB.pas` (DB component registration)

## Architecture

### Core Component

**`source/Theking.pas`** — `TKingCalendar` inherits from `TCustomGrid`. This is the central class; it renders the month grid, handles day selection, blocked days, per-cell colors, and fires all calendar events. Every other unit is either a companion control or a support form.

### Companion Controls (split units)

Navigation and display controls that bind to a `TKingCalendar` instance. Originally in `KingTool.pas`, now split into focused units:
- `source/KingToolCtrl.pas` — `TKingLabel`, `TKingWeekLabel`, `TKingBaseSpin`, `TMonthSpin`, `TYearSpin`, `TDaySpin`, `TKingBaseCombo`, `TMonthCombo`, `TYearCombo`, `TDayCombo`
- `source/KingToolNav.pas` — `TKingNavigator` (prev/next month/year buttons), `TKingButton`
- `source/KingToolMonth.pas` — `TMonthBar` (month-selection buttons), `TMonthButton`
- `source/KingTool.pas` — utility functions only (`kcDateToStr`, `kcEaster`, `kcWorkDays`, etc.)

### Specialized Controls

- `source/Kingpop.pas` — `TKingPopup`: popup calendar (dropdown style)
- `source/Kingdlg.pas` — `TKingDateDialog`: standalone date-picker dialog
- `source/Kingspin.pas`, `Kingspnt.pas`, `Kingspn1.pas` — date/time spin-button editors (`TKingDateSpin`, `TKingTimeSpin`, `TKingMDYSpin`, `TKingHMSpin`)
- `source/KingBase.pas` — `TKingBaseDateEdit`: shared base class for all spin/dialog editors

### Database-Aware Controls

- `source/DBKingSpin.pas` — `TDBKingCalendar`, `TDBKingDateSpin`, `TDBKingTimeSpin`, `TDBKingMDYSpin`, `TDBKingHMSpin`, `TDBKingDateDialog` — all use `TFieldDataLink` to bind to `TDataSource`/`TDataField`

### LiveBindings Support

- `source/KingBindEditors.pas` — registers observable members (`CalendarDate`, `Value`, `Text`) for Delphi's LiveBindings framework; included in the main runtime package

### Design-Time Layer

- `source/Kcal32.pas` — `Register` procedure; registers base components into the IDE palette and installs property/component editors
- `source/Kcal32DB.pas` — `Register` procedure for DB-aware components (separate design-time package)
- `source/Kccmpedt.pas` — component editor
- `source/Caledit.pas`, `Caledit2.pas` — editor forms invoked from the component editor
- `source/Kingprop.pas` — About box form
- `source/Attach.pas` — Attachment helper form

### Version Info

`source/Kingcore.pas` holds `KC_VERSION` and `KC_BUILD` constants. Update this when bumping the library version.

## Key Conventions

- All units use fully-qualified Delphi unit references (`Winapi.*`, `System.*`, `Vcl.*`).
- Every source file starts with the MIT license header block.
- Color customization is via `TKingColoring` (9 named color sets, `ColorSet1`–`ColorSet9` properties on `TKingCalendar`).
- Blocked days and flagged days are set via array properties on `TKingCalendar`; day-level annotations fire `OnFlaggedDay`.
- The library targets Win32 and Win64; Delphi 10.x packages build 64-bit only, Delphi 11+ packages build both architectures.


## Comment Style Rules

All code comments must follow this format:
```
// LRYYYYMMDD - Comment text
```

- `LR` = your initials
- `YYYYMMDD` = date of the change (always full 8-digit date)
- Add a space before and after the dash
- Keep comments short and clear

**Examples:**
```pascal
// LR20260317 - Initial implementation
// LR20260317 - Refactored loop for clarity
// LR20260318 - Fixed crash when list is empty
```

**Additional guidelines:**
- Do not stack multiple dates on one line
- Add a new comment line for each change
- Do not remove older comments unless the code itself is deleted
- Place the comment above the line of code when possible

## Code Modification Rules

- **Never delete existing code.** When replacing logic, always comment out the old code first, then add the new code below it.
- **Always comment out old code before replacing it.** Use `//` to comment out each line of the replaced block. This preserves history inline and makes it easy to revert.

## Resource Management (try/finally) Rules

- **Never free multiple objects in a single `finally` block when they were created separately.** Each object must have its own `try/finally` pair so that if one creation fails, only the objects that were successfully created are freed.
- **Always nest `try/finally` blocks** — one per object — so cleanup is guaranteed regardless of which allocation fails.

**Wrong — multiple frees in one finally:**
```pascal
X := TStringList.Create;
try
  Y := TStringList.Create;   // if this raises, Y is uninitialized; Y.Free below is unsafe
  // ... use X and Y ...
finally
  Y.Free;   // BAD: Y may never have been assigned
  X.Free;   // BAD: both frees in the same finally
end;
```

**Correct — nested try/finally, one free each:**
```pascal
X := TStringList.Create;
try
  Y := TStringList.Create;
  try
    // ... use X and Y ...
  finally
    Y.Free;   // inner finally: frees Y
  end;
finally
  X.Free;     // outer finally: frees X
end;
```

**Example — replacing a line:**
```pascal
// LR20260318 - Replaced linear scan with binary search for performance
// for I := 0 to lstIDnumbers.Count-1 do begin
//   if str2int(lstIDnumbers.Items[I])=ProgID then begin Result := false; break; end;
// end;
Lo := 0;
Hi := High(ImportID_Sorted);
while Lo <= Hi do begin
  ...
end;
```

**Example — replacing a function body:**
```pascal
// LR20260318 - Rewrote to use WinINet; removed OverbyteIcsWSocket dependency
// Old implementation used async ICS socket with busy-wait loop.
// hWSocket := TWSocket.Create(nil);
// hWSocket.Connect('google.com', 80);
// while not InternetAvail do Application.ProcessMessages;
hInet := InternetOpen('CDE/2.0', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
...
```