{ *                                                                                * }
{ *  unit KingBindEditors                                                         * }
{ *  LiveBindings Registration for KingCalendar Components                        * }
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

// LR20260325 - LiveBindings observable member registration for KingCalendar components

unit KingBindEditors;

interface

implementation

uses
  System.Classes,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  TheKing,
  KingSpin,
  KingSpn1,
  KingSpnt,
  KingDlg;

procedure RegisterKingBindEditors;
begin
  // LR20260325 - Register CalendarDate as observable for TKingCalendar
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(TKingCalendar), 'CalendarDate', 'KingCalendar');

  // LR20260325 - Register Value as observable for all spin editors
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(TKingDateSpin), 'Value', 'KingCalendar');
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(TKingTimeSpin), 'Value', 'KingCalendar');
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(TKingMDYSpin), 'Value', 'KingCalendar');
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(TKingHMSpin), 'Value', 'KingCalendar');

  // LR20260325 - Register Text as observable for TKingDateDialog
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(TKingDateDialog), 'Text', 'KingCalendar');
end;

initialization
  RegisterKingBindEditors;

end.
