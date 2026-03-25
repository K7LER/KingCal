{ *                                                                                * }
{ *  unit Kcal32DB                                                                * }
{ *  Design-time registration for database-aware KingCalendar components          * }
{ *  KingCalendar Components v3.0 for Delphi                                       * }
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

// LR20260325 - Separate design-time registration for DB-aware components

unit Kcal32DB;

interface

procedure Register;

implementation

uses
  System.Classes,
  DesignIntf,
  DesignEditors,
  DBKingSpin,
  KingCore;

type
  // LR20260325 - Reuse the same About property editor pattern as Kcal32.pas
  TDBKingAboutProperty = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TDBKingAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TDBKingAboutProperty.GetValue: string;
begin
  Result := 'v' + vcdVersion;
end;

procedure TDBKingAboutProperty.SetValue(const Value: string);
begin
  // Read-only; intentionally empty
end;

procedure Register;
begin
  // LR20260325 - Register database-aware components into KingCalendar palette
  RegisterComponents('KingCalendar', [
    TDBKingCalendar,
    TDBKingDateSpin,
    TDBKingTimeSpin,
    TDBKingMDYSpin,
    TDBKingHMSpin,
    TDBKingDateDialog
  ]);

  // About property editors
  RegisterPropertyEditor(TypeInfo(string), TDBKingCalendar, 'About', TDBKingAboutProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBKingDateSpin, 'About', TDBKingAboutProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBKingTimeSpin, 'About', TDBKingAboutProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBKingMDYSpin, 'About', TDBKingAboutProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBKingHMSpin, 'About', TDBKingAboutProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBKingDateDialog, 'About', TDBKingAboutProperty);
end;

end.
