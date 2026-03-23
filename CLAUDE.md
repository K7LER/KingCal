# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KingCalendar is a Delphi VCL component library providing calendar controls for Windows applications. It targets Delphi 10.2 through 13. The codebase is Object Pascal with no external dependencies beyond the standard Delphi VCL packages.

## Building

There is no CLI build system. Builds are done inside the Delphi IDE:

1. Open the group project for the target Delphi version, e.g. `packages/13/D13All.groupproj`
2. Compile the runtime package first (e.g. `KingCalendar370.dpk`)
3. Compile the design-time package (e.g. `dclKingCalendar370.dpk`)
4. Right-click the design-time package → **Install** to register components in the IDE

Pre-compiled binaries live in `LIB<ver>x32/RELEASE` and `LIB<ver>x64/RELEASE` (e.g. `LIBD37x64`). To use them without recompiling, add the appropriate lib folder to the Delphi Library Path and add `source/` to the Browsing Path.

## Package Naming Convention

| Delphi Version | Package suffix | Folders |
|---|---|---|
| 10.2 | 260 | packages/102, LIBD26x64 |
| 10.3 | 270 | packages/103, LIBD27x64 |
| 10.4 | 280 | packages/104, LIBD28x64 |
| 11 | 290 | packages/110, LIBD29x32, LIBD29x64 |
| 12 | 360 | packages/12, LIBD36x32, LIBD36x64 |
| 13 | 370 | packages/13, LIBD37x32, LIBD37x64 |

Each version has two packages:
- **Runtime** (`KingCalendar<ver>.dpk`) — `{$RUNONLY}`, contains all implementation units
- **Design-time** (`dclKingCalendar<ver>.dpk`) — `{$DESIGNONLY}`, contains only `Kcal32.pas`

## Architecture

### Core Component

**`source/Theking.pas`** — `TKingCalendar` inherits from `TCustomGrid`. This is the central class; it renders the month grid, handles day selection, blocked days, per-cell colors, and fires all calendar events. Every other unit is either a companion control or a support form.

### Companion Controls (`source/KingTool.pas`)

Navigation and display controls that bind to a `TKingCalendar` instance:
- `TKingLabel`, `TKingWeekLabel` — bound labels showing date/week info
- `TMonthSpin`, `TYearSpin`, `TDaySpin` / `TMonthCombo`, `TYearCombo`, `TDayCombo` — spin and combo controls
- `TKingNavigator` — panel with prev/next month/year buttons
- `TMonthBar` — row of month-selection buttons

### Specialized Controls

- `source/Kingpop.pas` — `TKingPopup`: popup calendar (dropdown style)
- `source/Kingdlg.pas` — `TKingDateDialog`: standalone date-picker dialog
- `source/DBKing.pas` — `TDBKingDlg`: database-bound date picker (links to a `TField`)
- `source/Kingspin.pas`, `Kingspnt.pas`, `Kingspn1.pas` — date/time spin-button editors (`TKingDateSpin`, `TKingTimeSpin`, `TKingMDYSpin`)

### Design-Time Layer

- `source/Kcal32.pas` — `Register` procedure; registers every component into the IDE palette and installs property/component editors
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