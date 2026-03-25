# KingCalendar for Delphi — Wiki

KingCalendar is an open-source VCL calendar component library for Delphi 10.2 through 13. It provides a full month-grid calendar control, popup and dialog date pickers, database binding, navigation companions, and inline date/time spin editors — all as native Delphi components that install directly into the IDE palette.

> **Quick install:** download [KingCalendarSetup.exe](https://github.com/K7LER/KingCal/raw/master/Installer/KingCalendarSetup.exe) — it detects your Delphi versions, compiles the packages, and registers the components automatically.

---

## Table of Contents

1. [Installation](#installation)
   - [Windows Installer (Recommended)](#windows-installer-recommended)
   - [Manual / Git Clone](#manual--git-clone)
2. [Delphi Version Support](#delphi-version-support)
3. [Component Overview](#component-overview)
4. [TKingCalendar](#tkingcalendar)
   - [Properties](#tkingcalendar-properties)
   - [Events](#tkingcalendar-events)
   - [Methods](#tkingcalendar-methods)
   - [Color Sets](#color-sets)
   - [Blocked and Flagged Days](#blocked-and-flagged-days)
   - [Color Bars](#color-bars)
5. [Companion Controls](#companion-controls)
   - [TKingLabel](#tkinglabel)
   - [TKingWeekLabel](#tkingweeklabel)
   - [TMonthSpin / TYearSpin / TDaySpin](#tmonthspin--tyearspin--tdayspin)
   - [TMonthCombo / TYearCombo / TDayCombo](#tmonthcombo--tyearcombo--tdaycombo)
   - [TKingNavigator](#tkingnavigator)
   - [TMonthBar](#tmonthbar)
6. [Popup and Dialog Controls](#popup-and-dialog-controls)
   - [TKingPopup](#tkingpopup)
   - [TKingDateDialog](#tkingdatedialog)
7. [Spin Editors](#spin-editors)
   - [TKingDateSpin](#tkingdatespin)
   - [TKingTimeSpin](#tkingtimespin)
   - [TKingHMSpin](#tkinghmsspin)
   - [TKingMDYSpin](#tkingmdyspin)
8. [Database-Aware Components](#database-aware-components)
   - [TDBKingCalendar](#tdbkingcalendar)
   - [TDBKingDateSpin](#tdbkingdatespin)
   - [TDBKingTimeSpin](#tdbkingtimespin)
   - [TDBKingMDYSpin](#tdbkingmdyspin)
   - [TDBKingHMSpin](#tdbkingmhspin)
   - [TDBKingDateDialog](#tdbkingdatedialog)
9. [LiveBindings Support](#livebindings-support)
10. [Demo Projects](#demo-projects)
11. [Building from Source](#building-from-source)
12. [Version History](#version-history)
13. [License and Credits](#license-and-credits)

---

## Installation

### Windows Installer (Recommended)

The installer auto-detects every Delphi version on your machine, compiles the correct packages for each one, and writes the registry entries needed to make the components appear in the IDE palette.

1. Close the Delphi IDE.
2. Download and run **[KingCalendarSetup.exe](https://github.com/K7LER/KingCal/raw/master/Installer/KingCalendarSetup.exe)**.
3. Follow the wizard.
4. Open Delphi — the KingCalendar components will be on the palette.

An `installation.log` is written to the install folder. Check it if components do not appear.

### Manual / Git Clone

Use this method if you want the full source and prefer to manage builds yourself.

```
git clone https://github.com/K7LER/KingCal.git
```

Then for each Delphi version:

1. **Tools → Options → Delphi Options → Library**
2. Add `LIBD<ver>x64\RELEASE` (and `LIBD<ver>x32\RELEASE` for 32-bit targets) to the **Library Path**.
3. Add `source\` to the **Browsing Path**.
4. Click **OK**.
5. Open the group project for your version (e.g. `packages\13\D13All.groupproj`).
6. Compile the runtime package (`KingCalendar<ver>.dpk`) first.
7. Compile the design-time package (`dclKingCalendar<ver>.dpk`).
8. Right-click the design-time package → **Install**.

---

## Delphi Version Support

The installer reads the `BDS.EXE` file version (build number, third component) to identify the exact Delphi sub-version. Platform availability is gated by version thresholds, then confirmed by checking the IDE's `lib\` directories.

| Delphi Release | BDS Key | Package Suffix | Win32 | Win64 | Win64 Modern | WinARM64EC |
|---|---|---|:---:|:---:|:---:|:---:|
| Delphi 13.1 Florence | 37.0 | `370` | ✓ | ✓ | ✓ | ✓ |
| Delphi 13.0 Florence | 37.0 | `370` | ✓ | ✓ | ✓ | — |
| Delphi 12.3 Athens | 29.0 | `290` | ✓ | ✓ | ✓ | — |
| Delphi 12.2.1 Athens | 29.0 | `290` | ✓ | ✓ | ✓ | — |
| Delphi 12.2 Athens | 29.0 | `290` | ✓ | ✓ | ✓ | — |
| Delphi 12.1 Athens | 29.0 | `290` | ✓ | ✓ | ✓ | — |
| Delphi 12.0 Athens | 29.0 | `290` | ✓ | ✓ | — | — |
| Delphi 11.2 Alexandria | 28.0 | `280` | ✓ | ✓ | — | — |
| Delphi 11.1 Alexandria | 28.0 | `280` | ✓ | ✓ | — | — |
| Delphi 11.0 Alexandria | 28.0 | `280` | ✓ | ✓ | — | — |
| Delphi 10.4.2 Sydney | 27.0 | `270` | — | ✓ | — | — |
| Delphi 10.4.1 Sydney | 27.0 | `270` | — | ✓ | — | — |
| Delphi 10.4.0 Sydney | 27.0 | `270` | — | ✓ | — | — |
| Delphi 10.3 Rio | 26.0 | `260` | — | ✓ | — | — |
| Delphi 10.2 Tokyo | 25.0 | `250` | — | ✓ | — | — |

**Platform thresholds:**
- **Win64 Modern (Win64x)** — Delphi 12.1+ (`BDS.EXE` build ≥ 51961) or any Delphi 13.x
- **WinARM64EC** — Delphi 13.1+ (`BDS.EXE` build ≥ 59082)

Pre-compiled DCU files for each version and platform live in `LIBD<prefix>x<plat>\RELEASE` (e.g. `LIBD37x64\RELEASE`). Add the matching folder to the Delphi Library Path when installing manually.

---

## Component Overview

| Component | Unit | Description |
|---|---|---|
| `TKingCalendar` | `Theking` | Core month-grid calendar |
| `TKingLabel` | `KingTool` | Label that displays the selected date |
| `TKingWeekLabel` | `KingTool` | Label that displays the week number |
| `TMonthSpin` | `KingTool` | Spin buttons for month navigation |
| `TYearSpin` | `KingTool` | Spin buttons for year navigation |
| `TDaySpin` | `KingTool` | Spin buttons for day navigation |
| `TMonthCombo` | `KingTool` | Combo box listing months |
| `TYearCombo` | `KingTool` | Combo box listing years |
| `TDayCombo` | `KingTool` | Combo box listing days |
| `TKingNavigator` | `KingTool` | Panel with prev/next month & year buttons |
| `TMonthBar` | `KingTool` | Row of 12 month-selection buttons |
| `TKingPopup` | `Kingpop` | Non-visual popup calendar |
| `TKingDateDialog` | `Kingdlg` | Edit control with calendar popup button |
| `TDBKingCalendar` | `DBKingCal` | Database-aware calendar grid bound to a date field |
| `TDBKingDateSpin` | `DBKingSpin` | Database-aware date spin editor |
| `TDBKingTimeSpin` | `DBKingSpin` | Database-aware time spin editor |
| `TDBKingMDYSpin` | `DBKingSpin` | Database-aware month/day/year spin editor |
| `TDBKingHMSpin` | `DBKingSpin` | Database-aware hour/minute/second spin editor |
| `TDBKingDateDialog` | `DBKingDlg` | Database-aware date dialog with popup |
| `TKingDateSpin` | `Kingspin` | Inline date spin editor |
| `TKingTimeSpin` | `Kingspin` | Inline time spin editor |
| `TKingHMSpin` | `Kingspnt` | Hour/minute/second field-by-field spin editor |
| `TKingMDYSpin` | `Kingspn1` | Month/day/year field-by-field spin editor |

All companion controls have a `CalendarSource` property that links them to a `TKingCalendar` instance. When the calendar date changes, every linked control updates automatically.

---

## TKingCalendar

`TKingCalendar` (`source/Theking.pas`) inherits from `TCustomGrid` and is the central component. Drop it on a form and it renders a full month view.

### TKingCalendar Properties

#### Date

| Property | Type | Default | Description |
|---|---|---|---|
| `Day` | `Integer` | today | Selected day (1–31) |
| `Month` | `Integer` | today | Selected month (1–12) |
| `Year` | `Integer` | today | Selected year |
| `CalendarDate` | `TDateTime` | today | Get/set date as `TDateTime` |
| `StartingDay` | `TDaysInWeek` | Sunday | First day of the week |

#### Appearance

| Property | Type | Default | Description |
|---|---|---|---|
| `ShowGridLines` | `Boolean` | `True` | Draw cell grid lines |
| `IsActive` | `Boolean` | `True` | Highlight the selected day cell |
| `TitleColor` | `TColor` | `clBtnShadow` | Header row background |
| `CellColor` | `TColor` | `clBtnFace` | Cell background |
| `GridLineColor` | `TColor` | `clBtnShadow` | Grid line color |
| `Highlight` | `TColor` | `clHighlight` | Selected cell background |
| `HighlightText` | `TColor` | `clHighlightText` | Selected cell text color |
| `TodayColor` | `TColor` | `clWindowText` | Color used to mark today |
| `TitleFont` | `TFont` | — | Font for the header row |
| `TextFont` | `TFont` | — | Font for cell annotation text |
| `DowNames` | `TStrings` | — | Day-of-week name overrides |
| `StyleName` | `String` | `''` | VCL Style override; blank = active app style |
| `TextPlacement` | `TKingText` | `ktCenter` | Cell text alignment |
| `ColorOrder` | `TColorarchy` | `kcaSetColor` | Color precedence when multiple rules apply |

#### Blocked Days

| Property | Type | Default | Description |
|---|---|---|---|
| `BlockWeekends` | `Boolean` | `False` | Automatically block Saturday and Sunday |
| `BlockedBkGnd` | `TColor` | `clBtnFace` | Background color for blocked days |
| `BlockedFrGnd` | `TColor` | `clGrayText` | Text color for blocked days |

#### Cell Text / Annotations

| Property | Type | Default | Description |
|---|---|---|---|
| `TextInCell` | `Boolean` | `False` | Show annotation text inside day cells |
| `ColorCellText` | `Boolean` | `False` | Apply per-day color to text only |
| `ColorCellDay` | `Boolean` | `True` | Apply per-day color to whole cell |
| `CellText[Row, Col]` | `String` | — | Get/set text in a specific grid cell |

#### Color Bars

| Property | Type | Default | Description |
|---|---|---|---|
| `ShowColorBars` | `Boolean` | `False` | Enable color bar overlay display |

#### Color Sets

| Property | Type | Description |
|---|---|---|
| `ColorSets` | `TKingColoring` | Nine named color sets (`ColorSet1`–`ColorSet9`) |

#### Misc

| Property | Type | Default | Description |
|---|---|---|---|
| `SuspendUpdate` | `Boolean` | `False` | Suspend repaints during batch changes |
| `HeaderUseFixed` | `Boolean` | `True` | Use a fixed row for the day-name header |

---

### TKingCalendar Events

| Event | Signature | Fires when |
|---|---|---|
| `OnClick` | `TNotifyEvent` | User clicks a day cell |
| `OnDblClick` | `TNotifyEvent` | User double-clicks a day cell |
| `OnChange` | `TNotifyEvent` | Any date property changes |
| `OnDayChange` | `eDayChange` | `Day` property changes |
| `OnMonthChange` | `eMonthChange` | `Month` property changes |
| `OnYearChange` | `eYearChange` | `Year` property changes |
| `OnDateChange` | `eDateChange` | Full date (day, month, or year) changes |
| `OnDayFlag` | `TNotifyEvent` | A flagged day is rendered |
| `OnDroppedCell` | `eDroppedDay` | A drag-and-drop operation drops on a cell |

---

### TKingCalendar Methods

#### Navigation

```pascal
procedure NextMonth;   // Advance to next month
procedure PrevMonth;   // Go to previous month
procedure NextYear;    // Advance to next year
procedure PrevYear;    // Go to previous year
procedure NextDay;     // Advance one day
procedure PrevDay;     // Go back one day
procedure Today;       // Jump to today's date
```

#### Annotations

```pascal
// Set a flag and optional text for a day (1–31)
procedure SetDateFlag(nDay, Flag: Integer; Text: string);

// Set annotation text for a day without changing its flag
procedure SetDateText(nDay: Integer; Text: string);

// Clear all annotations for a day
procedure ClearDay(nDay: Integer);

// Clear all annotations for the current month
procedure ClearAllDays;

// Bulk-set all flags for the month
procedure SetMonthFlags(Value: TKingFlags);

// Read back the flag for a day
function GetDateFlag(Value: Integer): Integer;

// Read back all flags for the month
function GetMonthFlags: TKingFlags;
```

#### Color Range

```pascal
// Apply background/foreground colors to a range of days
procedure ColorDateRange(nStart, nEnd: Integer; nBack, nFore: TColor);

// Remove per-day coloring
procedure ClearDateRange(nBack, nFore: TColor);

// Fill all cells with a single background or foreground color
procedure FillBackground(Value: TColor);
procedure FillForeground(Value: TColor);
```

#### Color Bars

```pascal
procedure SetColorBars(Value: Boolean);      // Enable/disable bars
procedure ClearColorBars;                    // Remove all bars
procedure AddColorBar(nDay: Integer; nColor: TColor);
procedure MakeBarFromRange(nStart, nEnd: Integer; nColor: TColor);
```

#### Drag and Drop

```pascal
// Call this in your OnDragDrop handler to commit the drop
procedure AcceptDropped(X, Y, Value: Integer; Text: string);
```

#### Utilities

```pascal
function DaysThisMonth: Integer;
function DaysInMonth(nMonth, nYear: Integer): Integer;
procedure UpdateCalendar;   // Force a full repaint
```

---

### Color Sets

`TKingCalendar` ships with nine named color sets accessible via the `ColorSets` property (`TKingColoring`). In the Object Inspector, expand `ColorSets` to see `ColorSet1` through `ColorSet9`. Each set defines colors for normal days, weekends, the header, the selected day, and today.

Assign a color set at runtime:

```pascal
KingCalendar1.ColorSets.ColorSet1.BkGnd := clNavy;
KingCalendar1.ColorSets.ColorSet1.FrGnd := clWhite;
KingCalendar1.UpdateCalendar;
```

The `ColorOrder` property (`TColorarchy`) controls precedence when a day matches multiple coloring rules (e.g., a flagged day that is also a weekend).

---

### Blocked and Flagged Days

**Blocking weekends** is a single property toggle:

```pascal
KingCalendar1.BlockWeekends := True;
```

**Blocking or flagging individual days** uses `SetDateFlag`. The `Flag` parameter is an integer that your application defines. `Flag = 0` means no flag (normal day); any non-zero value marks the day.

```pascal
// Block days 24 and 25
KingCalendar1.SetDateFlag(24, 1, 'Blocked');
KingCalendar1.SetDateFlag(25, 1, 'Blocked');
```

The `OnDayFlag` event fires once per flagged day as the calendar renders each row. Use it to apply custom colors or text per day:

```pascal
procedure TForm1.KingCalendar1DayFlag(Sender: TObject);
begin
  if KingCalendar1.GetDateFlag(KingCalendar1.Day) = 1 then
  begin
    KingCalendar1.BlockedBkGnd := clRed;
    KingCalendar1.BlockedFrGnd := clWhite;
  end;
end;
```

---

### Color Bars

Color bars are narrow horizontal stripes drawn inside day cells, useful for showing multiple overlapping events.

```pascal
KingCalendar1.ShowColorBars := True;
KingCalendar1.AddColorBar(15, clBlue);   // Blue bar on the 15th
KingCalendar1.AddColorBar(15, clGreen);  // Second bar on the same day
KingCalendar1.MakeBarFromRange(10, 20, clRed);  // Red bar across days 10–20
```

---

## Companion Controls

All companion controls share a `CalendarSource: TKingCalendar` property. Assign it to a `TKingCalendar` on the same form and the control will stay in sync automatically.

### TKingLabel

Displays the currently selected date as formatted text.

| Property | Type | Description |
|---|---|---|
| `CalendarSource` | `TKingCalendar` | Calendar to track |
| `DateFormat` | `String` | Format string passed to `FormatDateTime` |
| `IncludeWeekNum` | `Boolean` | Append the ISO week number to the label |

```pascal
KingLabel1.CalendarSource := KingCalendar1;
KingLabel1.DateFormat := 'dddd, mmmm d, yyyy';
```

### TKingWeekLabel

Displays the ISO week number of the selected date.

| Property | Type | Description |
|---|---|---|
| `CalendarSource` | `TKingCalendar` | Calendar to track |
| `IncludeCaption` | `Boolean` | Prepend "Week " to the number |
| `OnChange` | `TNotifyEvent` | Fires when the week number changes |

### TMonthSpin / TYearSpin / TDaySpin

Spin-button pairs for navigating month, year, or day. Drop one near the calendar, assign `CalendarSource`, and clicking the up/down arrows advances or retreats the appropriate value.

`TYearSpin` has additional `MinYear` and `MaxYear` properties to constrain the range.

### TMonthCombo / TYearCombo / TDayCombo

Drop-down combo boxes populated with month names, a range of years, or the days valid for the current month. All three automatically repopulate when the linked calendar changes.

`TYearCombo` exposes `MinYear` and `MaxYear`.
`TDayCombo` exposes `MinDay` and `MaxDay`.

### TKingNavigator

A panel containing up to five buttons: **Previous Year**, **Previous Month**, **Today**, **Next Month**, **Next Year**.

| Property | Type | Default | Description |
|---|---|---|---|
| `CalendarSource` | `TKingCalendar` | — | Calendar to drive |
| `VisibleButtons` | `TCalcBtnSet` | all | Which buttons to show |
| `Highlight` | `TColor` | — | Button highlight color |
| `TodayText` | `String` | — | Label for the Today button |
| `CaptionInToday` | `Boolean` | `False` | Show caption inside Today button |
| `OnClick` | `eCalcClick` | — | Fires with the button index clicked |

```pascal
KingNavigator1.CalendarSource := KingCalendar1;
KingNavigator1.VisibleButtons := [nbPrevMonth, nbNextMonth];
```

### TMonthBar

A row of 12 buttons, one per month. Clicking a button sets the calendar to that month.

| Property | Type | Description |
|---|---|---|
| `CalendarSource` | `TKingCalendar` | Calendar to drive |
| `VisibleButtons` | `TMonthBtnSet` | Which month buttons to show |
| `Highlight` | `TColor` | Button highlight color |

---

## Popup and Dialog Controls

### TKingPopup

A non-visual component that shows a floating calendar popup. Use it as the backing for custom date-entry controls or invoke it programmatically.

```pascal
KingPopup1.AlignSource := Edit1;   // popup appears below Edit1
if KingPopup1.Execute then
  Edit1.Text := DateToStr(KingPopup1.PopupDate);
```

| Property / Method | Type | Description |
|---|---|---|
| `AlignSource` | `TWinControl` | Control to position the popup beneath |
| `PopupDate` | `TDateTime` | Selected date after `Execute` returns `True` |
| `Execute` | `Boolean` | Show the popup; returns `True` if user picked a date |
| `ShowHint` | `Boolean` | Show button hints inside the popup |

### TKingDateDialog

A `TCustomEdit` descendant with a built-in calendar button. The user can type a date or click the button to pick from a popup.

```pascal
KingDateDialog1.KingPopup := KingPopup1;
ShowMessage(KingDateDialog1.Text);   // formatted date string
```

| Property | Type | Description |
|---|---|---|
| `KingPopup` | `TKingPopup` | Popup component to use |
| `Button` | `TSpeedButton` | Internal calendar button (for layout) |

> **Note:** The legacy `TDBKingDlg` (BDE-based) has been moved to `source/legacy/`. For database-aware controls, use the new DB components described in [Database-Aware Components](#database-aware-components) below.

---

## Spin Editors

All spin editors share a similar interface: a `Value: TDateTime` property, an `Increment` property, and `IncrementBy` / `DecrementBy` methods.

### TKingDateSpin

Edits a date by incrementing/decrementing the whole date value.

| Property | Type | Default | Description |
|---|---|---|---|
| `DateFormat` | `String` | — | Display format (`FormatDateTime` mask) |
| `StartDate` | `String` | — | Initial date string |
| `Increment` | `Integer` | 1 | Days to advance/retreat per click |
| `Value` | `TDateTime` | — | Current date |

```pascal
KingDateSpin1.DateFormat  := 'mm/dd/yyyy';
KingDateSpin1.StartDate   := '01/01/2026';
KingDateSpin1.Increment   := 7;   // jump by weeks
```

### TKingTimeSpin

Edits a time value in AM/PM format, incrementing by whole minutes.

| Property | Type | Default | Description |
|---|---|---|---|
| `TimeFormat` | `String` | `'hh:mm AMPM'` | Display format |
| `StartTime` | `String` | `'06:00 AM'` | Initial time string |
| `Increment` | `Integer` | 1 | Minutes per click |
| `Value` | `TDateTime` | — | Current time |

### TKingHMSpin

Like `TKingTimeSpin` but supports field-by-field editing (hours, minutes, seconds). Use Left/Right arrow keys to move between fields; Up/Down to change the focused field.

| Property | Type | Default | Description |
|---|---|---|---|
| `TimeFormat` | `String` | `'hh:mm AMPM'` | Display format |
| `StartTime` | `String` | `'06:00 AM'` | Initial time |
| `Increment` | `Integer` | 1 | Increment per click for focused field |
| `Value` | `TDateTime` | — | Current time |
| `Selected` | `Boolean` | — | Whether a field currently has focus |

### TKingMDYSpin

Field-by-field date editing (month / day / year). Use Left/Right arrow keys to move between fields; Up/Down to change the focused field. Month and day boundaries are handled automatically (e.g. advancing month past December wraps to January).

| Property | Type | Default | Description |
|---|---|---|---|
| `DateFormat` | `String` | — | Display format |
| `StartDate` | `String` | — | Initial date |
| `Increment` | `Integer` | 1 | Increment per click for focused field |
| `Value` | `TDateTime` | — | Current date |
| `SelValue` | `Word` | — | Numeric value of the currently selected field |
| `Selected` | `Boolean` | — | Whether a field is selected |

---

## Database-Aware Components

All database-aware components use `TFieldDataLink` to bind to a `TDataSource` and `TDataField`. They require no BDE dependency and work with any dataset (FireDAC, ClientDataSet, third-party ORMs, etc.).

> **Package note:** The DB components live in a separate package (`KingCalendarDB<ver>.dpk`). Install both `dclKingCalendar` and `dclKingCalendarDB` to use them in the IDE.

### Common Properties

Every DB component exposes these properties:

| Property | Type | Description |
|---|---|---|
| `DataSource` | `TDataSource` | The data source to bind to |
| `DataField` | `String` | The field name within the dataset |
| `ReadOnly` | `Boolean` | When `True`, the control displays the field value but does not post edits |
| `Field` | `TField` | Direct reference to the bound field (read-only) |

### Usage Example

```pascal
// Drop TDataSource, TClientDataSet, and TDBKingDateSpin on a form
DataSource1.DataSet := ClientDataSet1;
DBKingDateSpin1.DataSource := DataSource1;
DBKingDateSpin1.DataField := 'BirthDate';
// The spin editor now displays and edits the BirthDate field
```

### TDBKingCalendar

A database-aware version of `TKingCalendar`. The calendar grid automatically navigates to the date stored in the bound field. When the user clicks a day, the field value is updated and posted to the dataset.

All standard `TKingCalendar` features (color sets, blocked days, flagged days, color bars, annotations) remain available.

### TDBKingDateSpin

A database-aware version of `TKingDateSpin`. Displays and edits a date field using spin buttons to increment/decrement the date value. Supports the same `DateFormat` and `Increment` properties as `TKingDateSpin`.

### TDBKingTimeSpin

A database-aware version of `TKingTimeSpin`. Displays and edits a time field using spin buttons. Supports the same `TimeFormat` and `Increment` properties as `TKingTimeSpin`.

### TDBKingMDYSpin

A database-aware version of `TKingMDYSpin`. Provides field-by-field editing (month / day / year) of a date field. Arrow keys move between fields; Up/Down changes the focused field.

### TDBKingHMSpin

A database-aware version of `TKingHMSpin`. Provides field-by-field editing (hours / minutes / seconds) of a time field. Arrow keys move between fields; Up/Down changes the focused field.

### TDBKingDateDialog

A database-aware version of `TKingDateDialog`. Shows an edit control with a popup calendar button, bound to a date field. When the user picks a date from the popup or types one in, the field value is posted to the dataset.

---

## LiveBindings Support

All date/time controls support Delphi's LiveBindings framework, allowing you to bind control properties to data sources visually in the LiveBindings Designer.

### Bindable Properties

| Component | Bindable Property | Type | Description |
|---|---|---|---|
| `TKingCalendar` | `CalendarDate` | `TDateTime` | The selected calendar date |
| `TKingDateSpin` | `Value` | `TDateTime` | The current date value |
| `TKingTimeSpin` | `Value` | `TDateTime` | The current time value |
| `TKingMDYSpin` | `Value` | `TDateTime` | The current date value |
| `TKingHMSpin` | `Value` | `TDateTime` | The current time value |
| `TKingDateDialog` | `Text` | `String` | The formatted date string |

### How to Use

1. Drop a `TBindSourceDB` (or `TBindSourceAdapter`) and a KingCalendar control on your form.
2. Open **View → LiveBindings Designer**.
3. Drag a connection from the data source field to the bindable property on the KingCalendar control (e.g., drag a `TDateTime` field to `TKingDateSpin.Value`).
4. The control will now read from and write to the data source automatically.

> **No additional packages needed.** LiveBindings registration is included in the main runtime package (`KingCalendar<ver>.dpk`).

---

## Demo Projects

Five demo projects are included for Delphi 10.2, 10.3, 10.4, and 13. Open the group project for your version from the `Demos\` folder.

| Demo | Project file | What it shows |
|---|---|---|
| **Main Demo** | `Kingcal.dpr` | Full `TKingCalendar` feature tour — color sets, blocked days, events, annotations |
| **Drag & Drop** | `Dragdrop.dpr` | Dragging selected dates between two calendars |
| **Navigation** | `Navexmpl.dpr` | Wiring `TKingNavigator`, spin, and combo controls to a calendar |
| **Date Picker** | `Pickdate.dpr` | `TKingPopup` and `TKingDateDialog` in a form |
| **Start Day** | `Startday.dpr` | Switching the first day of the week at runtime |

Demo source EXEs are not pre-compiled; compile the demos yourself after installing the components.

---

## Building from Source

### Prerequisites

- Delphi 10.2 or later (one or more versions)
- MSBuild (included with Delphi)

### Package structure

| Package | Type | Purpose |
|---|---|---|
| `KingCalendar<ver>.dpk` | `{$RUNONLY}` | Runtime — base components + LiveBindings registration |
| `KingCalendarDB<ver>.dpk` | `{$RUNONLY}` | Runtime — database-aware components |
| `dclKingCalendar<ver>.dpk` | `{$DESIGNONLY}` | Design-time — base component registration |
| `dclKingCalendarDB<ver>.dpk` | `{$DESIGNONLY}` | Design-time — DB component registration |

### Build order

1. Open the group project for your target version, e.g. `packages/13/D13All.groupproj`.
2. Compile the **base runtime** package (`KingCalendar<ver>.dpk`) first.
3. Compile the **DB runtime** package (`KingCalendarDB<ver>.dpk`).
4. Compile the **base design-time** package (`dclKingCalendar<ver>.dpk`).
5. Compile the **DB design-time** package (`dclKingCalendarDB<ver>.dpk`).
6. Right-click each design-time package → **Install**.

### Library path conventions

Pre-compiled outputs go to `LIBD<prefix>x<plat>\<Config>`:

| Folder example | Contents |
|---|---|
| `LIBD37x64\RELEASE` | Delphi 13, Win64, release DCUs |
| `LIBD37x32\DEBUG` | Delphi 13, Win32, debug DCUs |
| `LIBD29x64\RELEASE` | Delphi 12, Win64, release DCUs |

---

## Version History

| Version | Date | Notes |
|---|---|---|
| 2026.0325.1613 | 2026-03-25 | Fixed IDE crash on close (AV in UnhookEvent during destruction); replaced bitmap glyph resources with procedural drawing (DPI/theme aware via Canvas.Polygon + StyleServices); removed runtime dependency on KCAL32.RES and KDLG32.RES; regenerated palette icons (Kcal32.dcr, Kcal32DB.dcr) for all 24 components; version numbering revision now uses HHMM 24-hour format |
| 2026.0325.0010 | 2026-03-25 | Database-aware components (TDBKingCalendar, TDBKingDateSpin, TDBKingTimeSpin, TDBKingMDYSpin, TDBKingHMSpin, TDBKingDateDialog) using TFieldDataLink; LiveBindings support for all date/time controls; 4-package layout (base + DB, runtime + design-time); legacy TDBKingDlg moved to source/legacy/ |
| 26.1.1 | 2026-01-01 | Added support for Delphi 13; Windows installer |
| 2.1.1 | 2023-12-12 | Added support for Delphi 12 |
| 2.0.9 | 2022-12-01 | Added support for Delphi 11 |
| 2.0.8 | 2018-12-31 | VCL Styles navigator repaint fix; default font → Segoe UI; `TKingWeekLabel` added; DateUtils cleanup |
| 2.0.6 | 2018-12-30 | International locale date format support; demo range-check fixes |
| 2.0.2 | 2018-12-29 | Added support for Delphi 10.3 Rio |
| 2.0.1 | 2018-06-30 | Converted DFMs from binary to text format |
| 2.0.0 | 2018-06-28 | Initial open-source release on GitHub |

---

## License and Credits

KingCalendar is released under the **MIT License**. See [LICENSE](https://github.com/K7LER/KingCal/blob/master/LICENSE) for the full text.

**Original component:** Mark Lussier and AppVision © 1995–2000
**Current maintainer:** Lance Rasmussen — [lancerasmussen@gmail.com](mailto:lancerasmussen@gmail.com)

In June 2018, Mark Lussier gave Lance Rasmussen permission to open-source KingCalendar and publish it on GitHub.

Issues and pull requests welcome: [https://github.com/K7LER/KingCal/issues](https://github.com/K7LER/KingCal/issues)
