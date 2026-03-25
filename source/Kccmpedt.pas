{ *                                                                                * }
{ *  unit kccmpedt                                                                 * }
{ *  Visual Calendar Editor Module                                                 * }
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

unit kccmpedt;

interface

uses

  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  TheKing,
  CalEdit,
  Attach,
  // LR20260325 - Changed to split units
  // KingTool;
  KingToolCtrl,
  KingToolMonth,
  KingToolNav;

const
  VerbAttach = 'Attach to Calendar...';
  VerbVisual = 'Visual Calendar Editor';

procedure DoCalendarAttach( Container, Controller : TComponent );
procedure DoVisualEdit( Container, Controller : TComponent );

implementation

// uses
// ;

{ This function executes the Attachment Property Editor and then sets the
  CalendarSource depending on the selection in the property Editor. This
  function is called by the TKingAttachEditor's Edit method. If it placed in
  the registration unit on purpose and will =not= be linked into your app. }

{ *************************************************************************** }
procedure DoCalendarAttach( Container, Controller : TComponent );
  var
    FrmAttach : TFrmAttach;
  begin

    { Create the Attachment Editor Form }
    FrmAttach := TFrmAttach.Create( Application );

    { Of the components that interact with a TKingCalendar we have 4 base types
      and since they are all different we had to do the following. Ugly, but
      pretty much necessary }
    try

      { Assign the controlls owner to the property editor. We need to do this
        so we can get a list of controls from within the property editor }
      FrmAttach.Container := Container as TWinControl;

      { Show the property editor Modal }
      if FrmAttach.ShowModal = mrOk
      then
      begin

        { If the user chose Apply, or double clicked on a Calendar in the
          property editor, we need to set it now }
        if Controller is TKingLabel
        then
          TKingLabel( Controller ).CalendarSource := FrmAttach.Chosen;
        if Controller is TKingBaseCombo
        then
          TKingBaseCombo( Controller ).CalendarSource := FrmAttach.Chosen;
        if Controller is TKingBaseSpin
        then
          TKingBaseSpin( Controller ).CalendarSource := FrmAttach.Chosen;
        if Controller is TKingBasePanel
        then
          TKingBasePanel( Controller ).CalendarSource := FrmAttach.Chosen;
        if Controller is TMonthBar
        then
          TMonthBar( Controller ).CalendarSource := FrmAttach.Chosen;

      end;
    finally
      FrmAttach.Release;
    end;

  end;

{ *************************************************************************** }
procedure DoVisualEdit( Container, Controller : TComponent );
  var
    FrmCalEdit : TFrmCalEdit;
    // LR20260325 - Local variable replaces with statement
    LCal : TKingCalendar;
  begin

    { Create the Attachment Editor Form }
    FrmCalEdit := TFrmCalEdit.Create( Application );

    // LR20260325 - Removed with statement; use explicit LCal reference
    LCal := TKingCalendar( Controller );
    FrmCalEdit.KingCalendar2.BlockWeekends := LCal.BlockWeekends;
    FrmCalEdit.KingCalendar2.HeaderUseFixed := LCal.HeaderUseFixed;
    FrmCalEdit.KingCalendar2.ShowGridLines := LCal.ShowGridLines;
    FrmCalEdit.KingCalendar2.IsActive := LCal.IsActive;
    FrmCalEdit.KingCalendar2.StartingDay := LCal.StartingDay;
    FrmCalEdit.KingCalendar2.TextPlacement := LCal.TextPlacement;
    FrmCalEdit.KingCalendar2.DowNames := LCal.DowNames;

    FrmCalEdit.KingCalendar3.TitleFont := LCal.TitleFont;
    FrmCalEdit.KingCalendar3.TextFont := LCal.TextFont;
    FrmCalEdit.KingCalendar3.Font := LCal.Font;

    FrmCalEdit.KingCalendar1.BlockedBkgnd := LCal.BlockedBkgnd;
    FrmCalEdit.KingCalendar1.BlockedFrgnd := LCal.BlockedFrgnd;
    FrmCalEdit.KingCalendar1.CellColor := LCal.CellColor;
    FrmCalEdit.KingCalendar1.Highlight := LCal.Highlight;
    FrmCalEdit.KingCalendar1.HighlightText := LCal.HighlightText;
    FrmCalEdit.KingCalendar1.GridLineColor := LCal.GridLineColor;
    FrmCalEdit.KingCalendar1.TitleColor := LCal.TitleColor;
    FrmCalEdit.KingCalendar1.TitleFont := LCal.TitleFont;
    FrmCalEdit.KingCalendar1.TodayColor := LCal.TodayColor;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet1 := LCal.ColorSets.ColorSet1;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet2 := LCal.ColorSets.ColorSet2;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet3 := LCal.ColorSets.ColorSet3;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet4 := LCal.ColorSets.ColorSet4;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet5 := LCal.ColorSets.ColorSet5;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet6 := LCal.ColorSets.ColorSet6;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet7 := LCal.ColorSets.ColorSet7;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet8 := LCal.ColorSets.ColorSet8;
    FrmCalEdit.KingCalendar1.ColorSets.ColorSet9 := LCal.ColorSets.ColorSet9;

    try
      { Show the property editor Modal }
      if FrmCalEdit.ShowModal = mrOk
      then
      begin

        // LR20260325 - Removed with statement; use explicit LCal reference
        LCal.BlockedBkgnd := FrmCalEdit.KingCalendar1.BlockedBkgnd;
        LCal.BlockedFrgnd := FrmCalEdit.KingCalendar1.BlockedFrgnd;
        LCal.CellColor := FrmCalEdit.KingCalendar1.CellColor;
        LCal.Highlight := FrmCalEdit.KingCalendar1.Highlight;
        LCal.HighlightText := FrmCalEdit.KingCalendar1.HighlightText;
        LCal.GridLineColor := FrmCalEdit.KingCalendar1.GridLineColor;
        LCal.TitleColor := FrmCalEdit.KingCalendar1.TitleColor;
        LCal.TitleFont := FrmCalEdit.KingCalendar1.TitleFont;
        LCal.TodayColor := FrmCalEdit.KingCalendar1.TodayColor;
        LCal.ColorSets.ColorSet1 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet1;
        LCal.ColorSets.ColorSet2 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet2;
        LCal.ColorSets.ColorSet3 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet3;
        LCal.ColorSets.ColorSet4 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet4;
        LCal.ColorSets.ColorSet5 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet5;
        LCal.ColorSets.ColorSet6 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet6;
        LCal.ColorSets.ColorSet7 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet7;
        LCal.ColorSets.ColorSet8 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet8;
        LCal.ColorSets.ColorSet9 := FrmCalEdit.KingCalendar1.ColorSets.ColorSet9;

        LCal.BlockWeekends := FrmCalEdit.KingCalendar2.BlockWeekends;
        LCal.HeaderUseFixed := FrmCalEdit.KingCalendar2.HeaderUseFixed;
        LCal.ShowGridLines := FrmCalEdit.KingCalendar2.ShowGridLines;
        LCal.IsActive := FrmCalEdit.KingCalendar2.IsActive;
        LCal.StartingDay := FrmCalEdit.KingCalendar2.StartingDay;
        LCal.TextPlacement := FrmCalEdit.KingCalendar2.TextPlacement;
        LCal.DowNames := FrmCalEdit.KingCalendar2.DowNames;

        LCal.TitleFont := FrmCalEdit.KingCalendar3.TitleFont;
        LCal.TextFont := FrmCalEdit.KingCalendar3.TextFont;
        LCal.Font := FrmCalEdit.KingCalendar3.Font;

      end;
    finally
      FrmCalEdit.Release;
    end;

  end;

end.
