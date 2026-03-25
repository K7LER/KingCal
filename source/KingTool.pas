{ *                                                                                * }
{ *  unit KingTool                                                                 * }
{ *  KingCalendar Navigational Tools                                               * }
{ *  KingCalendar Components v2.0 for Delphi                                       * }
{ *                                                                                * }
{ * ***** BEGIN LICENSE BLOCK *****                                                * }
{ * MIT License                                                                    * }
{ *                                                                                * }
{ * Permission is hereby granted, free of charge, to any person obtaining a copy   * }
{ * of this software and associated documentation files (the "Software"), to deal  * }
{ * in the Software without restriction, including without limitation the rights   * }
{ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      * }
{ * copies of the Software, and to permit persons to whom the Software is          * }
{ * furnished to do so, subject to the following conditions:                       * }
{ *                                                                                * }
{ * The above copyright notice and this permission notice shall be included in all * }
{ * copies or substantial portions of the Software.                                * }
{ *                                                                                * }
{ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     * }
{ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       * }
{ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    * }
{ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         * }
{ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  * }
{ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  * }
{ * SOFTWARE.                                                                      * }
{ *                                                                                * }
{ * The Original Code is KingCalendar                                              * }
{ *                                                                                * }
{ * The Initial Developer of the Original Code is Mark Lussier and AppVision       * }
{ *                                                                                * }
{ * Portions created by Mark Lussier and AppVision are Copyright (c) 1995-2000     * }
{ * Mark Lussier and AppVision. All Rights Reserved.                               * }
{ *                                                                                * }
{ * Contributor(s):                                                                * }
{ * Lance Rasmussen - lanceRasmussen@gmail.com - Github                            * }
{ *                                                                                * }
{ * ***** END LICENSE BLOCK *****                                                  * }

unit KingTool;

interface

uses

  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  VCL.Samples.Spin,
  System.Types,
  Vcl.Themes,
  TheKing,
  // LR20260325 - Classes moved to split units; KingTool retains utility functions only
  KingToolNav,
  KingToolMonth,
  KingToolCtrl;

function kcDateToStr(dDate: TDateTime): string;
function kcMonth(dDate: TDateTime): Word;
function kcIsLeapYear(nYear: Integer): Boolean;
function kcDate2Week(dDate: TDateTime): Integer;
function kcWeekOfYear(dDate: TDateTime): Integer;
function kcDayOfYear(dDate: TDateTime): Integer;
function kcMonthDays(nMonth, nYear: Integer): Integer;
function kcEaster(nYear: Integer): TDateTime;
function kcDayOfWeek(dDate: TDateTime): Integer;
function kcIncDate(dDate: TDateTime): TDateTime;
function kcIncDateBy(
  dDate: TDateTime;
  nValue: Integer): TDateTime;
function kcDecdate(dDate: TDateTime): TDateTime;
function kcDecDateBy(
  dDate: TDateTime;
  nValue: Integer): TDateTime;
function kcWorkDays(dStart, dEnd: TDateTime): Integer;
function kcSubDates(dMax, dMin: TDateTime): Integer;
function kcAddDates(dMin, dMax: TDateTime): Integer;

implementation

{ ===========================================================================
  KingCalendar Components for Delphi Support Functions
  =========================================================================== }
function kcDateToStr(dDate: TDateTime): string;
var
  sdf: string;
  LFormatSettings: TFormatSettings;
begin
  // LR20260325 - Use local format settings to avoid mutating global
  // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
  LFormatSettings := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
{$WARN SYMBOL_PLATFORM ON}
  sdf := LFormatSettings.ShortDateFormat;
  DateTimeToString(Result, sdf, dDate, LFormatSettings);
end;

{ *************************************************************************** }
function kcIsLeapYear(nYear: Integer): Boolean;
var
  dt: TDateTime;
begin
  dt := encodedatetime(nYear, 1, 1, 0, 0, 0, 0);
  Result := IsInLeapYear(dt);
end;

{ *************************************************************************** }
function kcMonth(dDate: TDateTime): Word;
begin
  Result := MonthOf(dDate);
end;

{ *************************************************************************** }
function kcMonthDays(nMonth, nYear: Integer): Integer;
begin
  Result := DaysInAMonth(nYear, nMonth);
end;

{ *************************************************************************** }
function kcDate2Week(dDate: TDateTime): Integer;
begin
  Result := kcWeekOfYear(dDate);
end;

{ *************************************************************************** }
function kcWeekOfYear(dDate: TDateTime): Integer;
begin
  Result := WeekOfTheYear(dDate);
end;

{ *************************************************************************** }
function kcDayOfYear(dDate: TDateTime): Integer;
begin
  Result := DayOfTheYear(dDate);
end;

{ *************************************************************************** }
function kcEaster(nYear: Integer): TDateTime;
var
  nMonth, nDay, nMoon, nEpact, nSunday, nGold, nCent, nCorx, nCorz: Integer;
begin

  { The Golden Number of the year in the 19 year Metonic Cycle }
  nGold := ((nYear mod 19) + 1);

  { Calculate the Century }
  nCent := ((nYear div 100) + 1);

  { No. of Years in which leap year was dropped in order to keep in step
    with the sun }
  nCorx := ((3 * nCent) div 4 - 12);

  { Special Correction to Syncronize Easter with the moon's orbit }
  nCorz := ((8 * nCent + 5) div 25 - 5);

  { Find Sunday }
  nSunday := ((5 * nYear) div 4 - nCorx - 10);

  { Set Epact (specifies occurance of full moon }
  nEpact := ((11 * nGold + 20 + nCorz - nCorx) mod 30);

  if (nEpact < 0) then
    nEpact := nEpact + 30;

  if ((nEpact = 25) and (nGold > 11)) or (nEpact = 24) then
    nEpact := nEpact + 1;

  { Find Full Moon }
  nMoon := 44 - nEpact;

  if (nMoon < 21) then
    nMoon := nMoon + 30;

  { Advance to Sunday }
  nMoon := (nMoon + 7 - ((nSunday + nMoon) mod 7));

  if (nMoon > 31) then
  begin
    nMonth := 4;
    nDay := (nMoon - 31);
  end
  else
  begin
    nMonth := 3;
    nDay := nMoon;
  end;

  Result := EncodeDate(nYear, nMonth, nDay);

end;

{ *************************************************************************** }
function kcDayOfWeek(dDate: TDateTime): Integer;
begin
  Result := DayOfTheWeek(dDate);
end;

{ *************************************************************************** }
function kcIncDate(dDate: TDateTime): TDateTime;
begin
  Result := IncDay(dDate, 1);

end;

{ *************************************************************************** }
function kcDecdate(dDate: TDateTime): TDateTime;
begin
  Result := IncDay(dDate, -1);
end;

{ *************************************************************************** }
function kcWorkDays(dStart, dEnd: TDateTime): Integer;
var
  nWorkDays, nDays, nAdjust: Integer;
  nStartDow, nEndDow: Integer;
begin

  // LR20260325 - Removed unnecessary initialization (nDays is assigned at line 250)
  // nDays := 0;

  nStartDow := kcDayOfWeek(dStart);

  if (nStartDow = 1) then
    dStart := kcIncDate(dStart)
  // LR20260325 - Bug fix: was comparing nDays (always 0 here) instead of nStartDow
  // else if (nDays = 7) then
  else if (nStartDow = 7) then
  begin
    dStart := kcIncDate(dStart);
    dStart := kcIncDate(dStart);
  end;

  nEndDow := kcDayOfWeek(dEnd);

  if (nEndDow = 1) then
  begin
    dEnd := kcDecdate(dEnd);
    dEnd := kcDecdate(dEnd);
  end
  else if (nEndDow = 7) then
    dEnd := kcDecdate(dEnd);

  nDays := (kcSubDates(dEnd, dStart) + 1);
  nAdjust := (nDays mod 7);

  if ((nEndDow + 1) < nStartDow) then
    nAdjust := nAdjust - 2;

  nWorkDays := ((nDays div 7) * 5 + nAdjust);
  Result := nWorkDays;

end;

{ *************************************************************************** }
function kcSubDates(dMax, dMin: TDateTime): Integer;
begin

  Result := Trunc((dMax - dMin));

end;

{ *************************************************************************** }
function kcAddDates(dMin, dMax: TDateTime): Integer;
begin

  Result := Trunc((dMax + dMin));

end;

{ *************************************************************************** }
function kcIncDateBy(
  dDate: TDateTime;
  nValue: Integer): TDateTime;
begin
  Result := IncDay(dDate, nValue);
end;

{ *************************************************************************** }
function kcDecDateBy(
  dDate: TDateTime;
  nValue: Integer): TDateTime;
begin
  // LR20260325 - Bug fix: was incrementing instead of decrementing (missing negation)
  // Result := IncDay(dDate, nValue);
  Result := IncDay(dDate, -nValue);

end;

end.

