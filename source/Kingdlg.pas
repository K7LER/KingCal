{ *                                                                                * }
{ *  unit KingDlg                                                                  * }
{ *  TKingCalendar Date Dialog Component                                           * }
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

unit KingDlg;

interface

uses

  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  VCL.Samples.Spin,
  kingpop,
  // LR20260325 - Added for procedural icon drawing with theme support
  Vcl.Themes,
  // LR20260325 - Added KingBase for TKingBaseDateEdit base class
  KingBase;

type

  // LR20260325 - Custom button that draws a calendar icon procedurally for DPI/theme support
  TKingDlgButton = class( TSpeedButton )
  protected
    procedure Paint; override;
  end;

  // LR20260325 - Changed base class from TCustomEdit to TKingBaseDateEdit
  // TKingDateDialog = class( TCustomEdit )
  TKingDateDialog = class( TKingBaseDateEdit )
    private
      FAbout : String;
      // LR20260325 - FButton now inherited from TKingBaseDateEdit as TControl
      // FButton : TSpeedButton;
      FPopup : TKingPopup;
      // LR20260325 - GetMinHeight now inherited from TKingBaseDateEdit
      // function GetMinHeight : Integer;
      // LR20260325 - SetEditRect now inherited from TKingBaseDateEdit
      // procedure SetEditRect;
      // LR20260325 - WMSize now inherited from TKingBaseDateEdit
      // procedure WMSize( var Message : TWMSize ); message WM_SIZE;
    protected
      procedure BtnClick( Sender : TObject ); virtual;
      // LR20260325 - CreateParams now inherited from TKingBaseDateEdit
      // procedure CreateParams( var Params : TCreateParams ); override;
      // LR20260325 - CreateWnd now inherited from TKingBaseDateEdit
      // procedure CreateWnd; override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      // LR20260325 - FButton is now TControl in base; cast to TSpeedButton
      function GetSpeedButton : TSpeedButton;
      property Button : TSpeedButton
        read GetSpeedButton;
      procedure Loaded; override;
    published
      property About : String
        read FAbout
        write FAbout;
      property KingPopup : TKingPopup
        read FPopup
        write FPopup;
      property AutoSelect;
      property AutoSize;
      property BorderStyle;
      property Color;
      property Ctl3D;
      property Font;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property
        ReadOnly;
      property ShowHint;
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property DragCursor;
      property DragMode;
  end;

implementation

// LR20260325 - Bitmap resources no longer needed; glyphs drawn procedurally
// {$R KDLG32.RES}

{ *************************************************************************** }
// LR20260325 - Procedural calendar icon for DPI/theme compatibility
procedure TKingDlgButton.Paint;
var
  R: TRect;
  CX, CY, S, I, J: Integer;
  LStyleServices: TCustomStyleServices;
begin
  inherited Paint;
  LStyleServices := StyleServices;

  R := Bounds(0, 0, Width, Height);
  if FState = bsDown then
    OffsetRect(R, 1, 1);

  CX := (R.Left + R.Right) div 2;
  CY := (R.Top + R.Bottom) div 2;
  S := MulDiv(2, Screen.PixelsPerInch, 96);

  // Draw calendar outline
  if Enabled then
    Canvas.Pen.Color := LStyleServices.GetSystemColor(clBtnText)
  else
    Canvas.Pen.Color := LStyleServices.GetSystemColor(clGrayText);
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(CX - 3 * S, CY - 2 * S, CX + 3 * S, CY + 3 * S);

  // Draw header bar
  Canvas.Pen.Color := Canvas.Pen.Color;
  Canvas.MoveTo(CX - 3 * S, CY - S);
  Canvas.LineTo(CX + 3 * S, CY - S);

  // Draw grid dots
  Canvas.Brush.Color := Canvas.Pen.Color;
  Canvas.Brush.Style := bsSolid;
  for I := 0 to 2 do
    for J := 0 to 1 do
      Canvas.FillRect(Rect(
        CX - 2 * S + I * 2 * S,
        CY + J * S,
        CX - 2 * S + I * 2 * S + S,
        CY + J * S + S));
end;

// LR20260325 - Typed accessor for FButton (TControl in base)
function TKingDateDialog.GetSpeedButton : TSpeedButton;
  begin
    Result := TSpeedButton( FButton );
  end;

{ *************************************************************************** }
constructor TKingDateDialog.Create( AOwner : TComponent );
  VAR
    I : Integer;
    // LR20260325 - Local typed variable for TSpeedButton-specific setup
    LBtn : TSpeedButton;
  begin
    inherited Create( AOwner );
    // LR20260325 - Use TKingDlgButton for procedural calendar icon (DPI/theme aware)
    // LBtn := TSpeedButton.Create( Self );
    LBtn := TKingDlgButton.Create( Self );
    FButton := LBtn;

    LBtn.Width := 21;
    LBtn.Height := 17;
    LBtn.Visible := True;
    // LR20260325 - Bitmap glyph replaced with procedural drawing in TKingDlgButton.Paint
    // LBtn.Glyph.Handle := LoadBitmap( HInstance, 'BTN_CALENDAR' );
    // LBtn.NumGlyphs := 1;
    LBtn.OnClick := BtnClick;
    LBtn.Parent := Self;

    Text := '';

    Width := 113;
    ControlStyle := ControlStyle - [ csSetCaption ];

    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[ I ] is TKingPopup
      then
      begin
        FPopup := TKingPopup( AOwner.Components[ I ] );
        Break;
      end;
    end;

    if Assigned( FPopup ) and ( TKingPopup( FPopup ).AlignSource = nil )
    then
      TKingPopup( FPopup ).AlignSource := Self;

  end;

{ *************************************************************************** }
destructor TKingDateDialog.Destroy;
  begin
    FButton := nil;
    inherited Destroy;
  end;

{ *************************************************************************** }
procedure TKingDateDialog.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );
    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FPopup )
    then
      FPopup := nil;
  end;

{ *************************************************************************** }
procedure TKingDateDialog.Loaded;
  begin
    inherited Loaded;
  end;

// LR20260325 - CreateParams, CreateWnd, SetEditRect, WMSize, GetMinHeight
// now inherited from TKingBaseDateEdit
{$IFDEF KINGBASE_LEGACY}
procedure TKingDateDialog.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

{ *************************************************************************** }
procedure TKingDateDialog.CreateWnd;
  begin
    inherited CreateWnd;
    SetEditRect;
  end;

{ *************************************************************************** }
procedure TKingDateDialog.SetEditRect;
  var
    Loc : TRect;
  begin
    SendMessage( Handle, EM_GETRECT, 0, LongInt( @Loc ) );
    Loc.Bottom := ClientHeight;
    Loc.Right := ClientWidth - FButton.Width - 2;
    Loc.Top := 0;
    Loc.Left := 0;
    SendMessage( Handle, EM_SETRECTNP, 0, LongInt( @Loc ) );
    SendMessage( Handle, EM_GETRECT, 0, LongInt( @Loc ) ); { debug }
  end;

{ *************************************************************************** }
procedure TKingDateDialog.WMSize( var Message : TWMSize );
  var
    // Loc: TRect;
    MinHeight : Integer;
  begin
    inherited;
    MinHeight := GetMinHeight;
    if Height < MinHeight
    then
      Height := MinHeight
    else if FButton <> nil
    then
    begin
      FButton.SetBounds( Width - FButton.Width, 0, FButton.Width, Height );
      SetEditRect;
    end;
  end;

{ *************************************************************************** }
function TKingDateDialog.GetMinHeight : Integer;
  var
    DC : HDC;
    SaveFont : HFont;
    I : Integer;
    SysMetrics, Metrics : TTextMetric;
  begin
    DC := GetDC( 0 );
    GetTextMetrics( DC, SysMetrics );
    SaveFont := SelectObject( DC, Font.Handle );
    GetTextMetrics( DC, Metrics );
    SelectObject( DC, SaveFont );
    ReleaseDC( 0, DC );
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight
    then
      I := Metrics.tmHeight;
    Result := Metrics.tmHeight + I div 4 + GetSystemMetrics
      ( SM_CYBORDER ) * 4 + 2;
  end;
{$ENDIF KINGBASE_LEGACY}

{ *************************************************************************** }
procedure TKingDateDialog.BtnClick( Sender : TObject );
  begin

    if Assigned( FPopup )
    then
    begin

      if FPopup.execute
      then
      begin
        Text := DateToStr( FPopup.Popupdate );
        // LR20260325 - Notify LiveBindings observers of value change
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
          TLinkObservers.ControlChanged(Self);
      end;
    end;

  end;

end.
