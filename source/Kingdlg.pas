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
  kingpop;

type

  TKingDateDialog = class( TCustomEdit )
    private
      FAbout : String;
      // hint    FCanvas: TCanvas;
      FButton : TSpeedButton;
      FPopup : TKingPopup;
      function GetMinHeight : Integer;
      procedure SetEditRect;
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
    protected
      procedure BtnClick( Sender : TObject ); virtual;
      procedure CreateParams( var Params : TCreateParams ); override;
      procedure CreateWnd; override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      property Button : TSpeedButton
        read FButton;
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

// uses
// winprocs;

{$R KDLG32.RES}

{ *************************************************************************** }
constructor TKingDateDialog.Create( AOwner : TComponent );
  VAR
    I : Integer;
  begin
    inherited Create( AOwner );
    FButton := TSpeedButton.Create( Self );

    FButton.Width := 21;
    FButton.Height := 17;
    FButton.Visible := True;
    FButton.Glyph.Handle := LoadBitmap( HInstance, 'BTN_CALENDAR' );
    FButton.NumGlyphs := 1;
    FButton.OnClick := BtnClick;
    FButton.Parent := Self;

    Text := '';

    Width := 113;
    ControlStyle := ControlStyle - [ csSetCaption ];

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingPopup
      then
      begin
        FPopup := TKingPopup( TForm( AOwner ).Components[ I ] );
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

{ *************************************************************************** }
procedure TKingDateDialog.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    { Params.Style := Params.Style and not WS_BORDER; }
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

{ *************************************************************************** }
procedure TKingDateDialog.CreateWnd;
  // hint var
  // hint  Loc: TRect;
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

{ *************************************************************************** }
procedure TKingDateDialog.BtnClick( Sender : TObject );
  begin

    if Assigned( FPopup )
    then
    begin

      if FPopup.execute
      then
        Text := DateToStr( FPopup.Popupdate );
    end;

  end;

end.
