{ *                                                                                * }
{ *  unit KingToolNav                                                             * }
{ *  KingCalendar Navigator Panel                                                 * }
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

// LR20260325 - Extracted TKingBasePanel, TKingNavigator, TKingButton from KingTool.pas

unit KingToolNav;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Types,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.Themes,
  TheKing;

type

  TKingButton = class;
  TCalGlyph = ( ngEnabled, ndDisabled );
  TCalcBtn = ( nbPrevYear, nbPrevMonth, nbToday, nbNextMonth, nbNextYear );
  TCalcBtnSet = set of TCalcBtn;
  eCalcClick = procedure(
    Sender : TObject;
    Button : TCalcBtn ) of Object;

  { TKingBasePanel }
  TKingBasePanel = class( TCustomPanel )
    private
      FCalendarSource : TKingCalendar;
    protected
      procedure SetSource( Value : TKingCalendar ); virtual;
    public
    published
      property CalendarSource : TKingCalendar
        read FCalendarSource
        write SetSource;
  end;

  { TKingNavigator }
  TKingNavigator = class( TKingBasePanel )
    private
      FTodayStyle : Boolean;
      FTodayText : String;
      Buttons : array [ TCalcBtn ] of TKingButton;
      FVisibleButtons : TCalcBtnSet;
      { FCalendarSource: TKingCalendar; }
      // hint    CurrentButton: TCalcBtn;
      ButtonWidth : Integer;
      MinBtnSize : TPoint;
      FOnNavClick : eCalcClick;
      FocusedButton : TCalcBtn;
      FHighlight : TColor;
      FAbout : String;
      procedure InitButtons;
      procedure Click( Sender : TObject ); reintroduce; virtual; // Resolve hint
      procedure BtnMouseDown(
        Sender : TObject;
        Button : TMouseButton;
        Shift  : TShiftState;
        X, Y   : Integer );
      procedure SetVisible( Value : TCalcBtnSet );
      procedure AdjustSize(
        var W : Integer;
        var H : Integer ); reintroduce; virtual; // Resolve hint
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure WMSetfocus( var Message : TWMSetFocus ); message WM_SETFOCUS;
      procedure WMKillFocus( var Message : TWMKillFocus ); message WM_KILLFOCUS;
      procedure WMGetDlgCode( var Message : TWMGetDlgCode );
        message WM_GETDLGCODE;
      procedure SetHighlight( oColor : TColor );
    protected
      procedure SetSource( Value : TKingCalendar ); override;
      procedure Loaded; override;
      procedure KeyDown(
        var Key : Word;
        Shift   : TShiftState ); override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
      procedure SetTodayStyle( Value : Boolean );
      procedure SetTodayText( Value : String );
      // LR20260323 - Scale MinBtnSize pixel values for high DPI
      procedure ChangeScale( M, D : Integer ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure SetBounds( ALeft, ATop, AWidth, AHeight : Integer ); override;
      procedure BtnClick( Index : TCalcBtn );
      procedure TheDateChanged( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      { property CalendarSource: TKingCalendar read FCalendarSource write SetSource; }
      property VisibleButtons : TCalcBtnSet
        read FVisibleButtons
        write SetVisible
        default [ nbPrevYear, nbPrevMonth, nbToday, nbNextMonth, nbNextYear ];
      property Highlight : TColor
        read FHighlight
        write SetHighlight;
      property Align;
      property DragCursor;
      property DragMode;
      property ShowHint
        default True;
      property OnClick : eCalcClick
        read FOnNavClick
        write FOnNavClick;
      property TabOrder;
      property CaptionInToday : Boolean
        read FTodayStyle
        write SetTodayStyle
        default False;
      property TodayText : String
        read FTodayText
        write SetTodayText;
      property ParentShowHint;
      property Visible;
  end;

  { TKingButton }
  TKingButton = class( TSpeedButton )
    private
      FIndex : TCalcBtn;
    protected
      procedure Paint; override;
    public
      property
        Index : TCalcBtn
        read FIndex
        write FIndex;

    published
  end;

implementation

uses
  KingTool;

{$R KCAL32.RES}

const

  { * TKingNavigator Glpyh Suffix's in the KINGCAL.RES * }
  BtnResName : array [ TCalcBtn ] of PChar = ( 'PREVYEAR', 'PREVMONTH', 'TODAY',
    'NEXTMONTH', 'NEXTYEAR' );

  { * Hint's for the TKingNavigator * }
  BtnHintId : array [ TCalcBtn ] of PChar = ( 'Previous Year', 'Previous Month',
    'Return to Todays Date', 'Next Month', 'Next Year' );

{ ===========================================================================
  TKingBasePnel
  =========================================================================== }

{ *************************************************************************** }
procedure TKingBasePanel.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
  end;

{ ===========================================================================
  TKingNavigator
  =========================================================================== }
constructor TKingNavigator.Create( AOwner : TComponent );
  // LR20260325 - Removed I: Integer; no longer needed after scan loop removal
  // var
  //   I : Integer;
  begin
    inherited Create( AOwner );
    ControlStyle := ControlStyle - [ csAcceptsControls, csSetCaption ] +
      [ csFramed, csOpaque ];
    FVisibleButtons := [ nbPrevYear, nbPrevMonth, nbToday, nbNextMonth,
      nbNextYear ];
    FHighlight := clBlue;
    InitButtons;
    BevelOuter := bvNone;
    BevelInner := bvNone;

    { Set Dimensions to match default size of the TKingCalendar Component }
    Width := 317;
    Height := 21;
    ButtonWidth := 0;
    FocusedButton := nbNextMonth;

    { Enable Hints }
    ShowHint := True;

    FTodayStyle := False;
    FTodayText := 'Today';

    // LR20260325 - Use shared FindFirstKingCalendar utility
    // for I := 0 to AOwner.ComponentCount - 1 do
    // begin
    //   if AOwner.Components[ I ] is TKingCalendar
    //   then
    //   begin
    //     CalendarSource := TKingCalendar( AOwner.Components[ I ] );
    //     Break;
    //   end;
    // end;
    CalendarSource := FindFirstKingCalendar(AOwner);

  end;

{ *************************************************************************** }
procedure TKingNavigator.InitButtons;
  var
    I : TCalcBtn;
    Btn : TKingButton;
    X : Integer;
    ResName : array [ 0 .. 40 ] of Char;
  begin
    MinBtnSize := Point( 20, 18 );
    X := 0;
    for I := low( Buttons ) to high( Buttons ) do
    begin
      Btn := TKingButton.Create( Self );
      Btn.Index := I;
      Btn.Visible := I in FVisibleButtons;
      Btn.Enabled := True;
      Btn.SetBounds( X, 0, MinBtnSize.X, MinBtnSize.Y );

      { * In the following IF..ELSE block we get the Glyph's for 4 of the
        5 buttons. The 3rd buton, or nbToday, has a caption as opposed
        to a Glyph. This holds the CalendarSources focused date. The font
        is set to Times New Roman. If the focused date is FDate the display
        color is set to clBlue signifying Today. * }

      if ( I <> nbToday )
      then
      begin
        Btn.Glyph.Handle := LoadBitmap( HInstance, StrFmt( ResName, 'CNV_%s',
          [ BtnResName[ I ] ] ) );
        Btn.NumGlyphs := 2;
      end
      else
      begin
        Btn.Font.Name := 'Segoe UI'; { Captions Font }
        Btn.Font.Size := 9; { Set Caption to 9 Points }
        Btn.Font.Color := FHighlight; { Set initial color to clBlue }
        Btn.Caption := kcDateToStr( Date );
      end;
      Btn.OnClick := Click;
      Btn.OnMouseDown := BtnMouseDown;
      Btn.Hint := StrPas( BtnHintId[ I ] );
      Btn.Parent := Self;
      Buttons[ I ] := Btn;
      X := X + MinBtnSize.X;
    end;

  end;

{ *************************************************************************** }
procedure TKingNavigator.SetVisible( Value : TCalcBtnSet );
  var
    I : TCalcBtn;
    W, H : Integer;
  begin
    W := Width;
    H := Height;
    FVisibleButtons := Value;
    For I := low( Buttons ) to high( Buttons ) do
      Buttons[ I ].Visible := I in FVisibleButtons;
    AdjustSize( W, H );
    If ( W <> Width ) or ( H <> Height )
    then
      inherited SetBounds( Left, Top, W, H );
    self.invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.AdjustSize(
  var W : Integer;
  var H : Integer );
  var
    Count, MInW, X, Space, Temp, Remain : Integer;
    I : TCalcBtn;
    // hint	LastBtn: TCalcBtn;
  begin

    if ( csLoading in ComponentState )
    then
      exit;
    if Buttons[ nbPrevMonth ] = nil
    then
      exit;
    Count := 0;
    // hint		 LastBtn := high(buttons);

    for I := low( Buttons ) to high( Buttons ) do
    begin
      If Buttons[ I ].Visible
      then
      Begin
        Inc( Count );
        // hint			  LastBtn := I;
      end;
    end;

    if Count = 0
    then
      Inc( Count );
    MInW := Count * ( MinBtnSize.X - 1 ) + 1;

    if W < MInW
    then
      W := MInW;

    if H < MinBtnSize.Y
    then
      H := MinBtnSize.Y;

    ButtonWidth := ( ( W - 1 ) div Count ) + 1;
    Temp := Count * ( ButtonWidth - 1 ) + 1;

    IF Align = alNone
    then
      W := Temp;

    X := 0;
    Remain := W - Temp;
    Temp := Count div 2;
    for I := low( Buttons ) to high( Buttons ) do
    begin
      if Buttons[ I ].Visible
      then
      begin
        Space := 0;
        if Remain <> 0
        then
        begin
          Dec( Temp, Remain );
          if Temp <> 0
          then
          begin
            Inc( Temp, Count );
            Space := 1;
          end;
        end;
        Buttons[ I ].SetBounds( X, 0, ButtonWidth + Space, Height );
        Inc( X, ButtonWidth - 1 + Space );
        // hint	       LastBtn := I;
      end
      else
        Buttons[ I ].SetBounds( Width + 1, 0, ButtonWidth, Height );
    end;
    self.invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.SetBounds( ALeft, ATop, AWidth, AHeight : Integer );
  var
    W, H : Integer;
  begin
    W := AWidth;
    H := AHeight;
    AdjustSize( W, H );
    inherited SetBounds( ALeft, ATop, W, H );
    self.invalidate;
  end;

{ *************************************************************************** }
// LR20260323 - Scale MinBtnSize pixel values for high DPI
procedure TKingNavigator.ChangeScale( M, D : Integer );
  begin
    inherited ChangeScale( M, D );
    MinBtnSize.X := MulDiv( MinBtnSize.X, M, D );
    MinBtnSize.Y := MulDiv( MinBtnSize.Y, M, D );
  end;

{ *************************************************************************** }
procedure TKingNavigator.WMSize( var Message : TWMSize );
  var
    W, H : Integer;
  begin
    inherited;
    W := Width;
    H := Height;
    AdjustSize( W, H );
    IF ( W <> Width ) or ( H <> Height )
    then
      inherited SetBounds( Left, Top, W, H );
    Message.Result := 0;
  end;

{ *************************************************************************** }
procedure TKingNavigator.Click( Sender : TObject );
  begin
    BtnClick( TKingButton( Sender ).Index );
    self.Invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.BtnMouseDown(
  Sender : TObject;
  Button : TMouseButton;
  Shift  : TShiftState;
  X, Y   : Integer );
  var
    OldFocus : TCalcBtn;
    // LR20260325 - Changed from TForm to TCustomForm to avoid unsafe cast
    // Form : TForm;
    Form : TCustomForm;
  begin
    OldFocus := FocusedButton;
    FocusedButton := TKingButton( Sender ).Index;
    If TabStop and ( GetFocus <> Handle ) and CanFocus
    then
    begin
      SetFocus;
      If ( GetFocus <> Handle )
      then
        exit;
    end
    else if TabStop and ( GetFocus = Handle ) and ( OldFocus <> FocusedButton )
    then
    begin
      Buttons[ OldFocus ].invalidate;
      Buttons[ FocusedButton ].invalidate;
    end
    else if not TabStop
    then
    begin
      Form := GetParentForm( Self );
      if ( Form <> nil )
      then
        Form.Perform( CM_CANCELMODE, 0, 0 );
    end;

    self.Invalidate;


  end;

{ *************************************************************************** }
procedure TKingNavigator.WMSetfocus( var Message : TWMSetFocus );
  begin
    Buttons[ FocusedButton ].invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.WMKillFocus( var Message : TWMKillFocus );
  begin
    Buttons[ FocusedButton ].invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.KeyDown(
  var Key : Word;
  Shift   : TShiftState );
  var
    NewFocus, OldFocus : TCalcBtn;
  begin
    OldFocus := FocusedButton;
    case Key of
      VK_RIGHT :
        begin
          NewFocus := FocusedButton;
          repeat
            if NewFocus < high( Buttons )
            then
              NewFocus := succ( NewFocus );
          until ( NewFocus = High( Buttons ) ) or
            ( Buttons[ NewFocus ].Visible );
          if NewFocus <> FocusedButton
          then
          begin
            FocusedButton := NewFocus;
            Buttons[ OldFocus ].invalidate;
            Buttons[ FocusedButton ].invalidate;
          end;
        end;
      VK_LEFT :
        begin
          NewFocus := FocusedButton;
          repeat
            if NewFocus > low( Buttons )
            then
              NewFocus := Pred( NewFocus );
          until ( NewFocus = Low( Buttons ) ) or
            ( Buttons[ NewFocus ].Visible );
          if NewFocus <> FocusedButton
          then
          begin
            FocusedButton := NewFocus;
            Buttons[ OldFocus ].invalidate;
            Buttons[ FocusedButton ].invalidate;
          end;
        end;

      VK_SPACE :
        begin
          if Buttons[ FocusedButton ].Enabled
          then
            Buttons[ FocusedButton ].Click;
        end;
    end;

    self.Invalidate;

  end;

{ *************************************************************************** }
procedure TKingNavigator.WMGetDlgCode( var Message : TWMGetDlgCode );
  begin
    Message.Result := DLGC_WANTARROWS;
  end;

{ *************************************************************************** }
procedure TKingNavigator.Loaded;
  var
    W, H : Integer;
  begin
    inherited Loaded;
    W := Width;
    H := Height;
    AdjustSize( W, H );
    IF ( W <> Width ) or ( H <> Height )
    then
      inherited SetBounds( Left, Top, W, H );

    if ( FCalendarSource <> nil )
    then
      CalendarSource.HookEvent := TheDateChanged;

  end;

{ *************************************************************************** }
procedure TKingNavigator.BtnClick( Index : TCalcBtn );
var
  I : TCalcBtn;
  begin
    if ( CalendarSource <> nil )
    then
    begin
      // LR20260325 - Removed with statement; use explicit CalendarSource reference
      case Index of
        nbPrevMonth :
          CalendarSource.prevMonth;
        nbPrevYear :
          CalendarSource.prevYear;
        nbNextYear :
          CalendarSource.nextYear;
        nbNextMonth :
          CalendarSource.nextMonth;
        nbToday :
          CalendarSource.Today;
      end;
    end;
    for I := Low(Buttons) to High(Buttons) do begin
      Buttons[I].Invalidate;
      // LR20260325 - Removed Application.ProcessMessages; unnecessary in invalidation loop
      // application.ProcessMessages;
    end;
    if not ( csDesigning in ComponentState ) and Assigned( FOnNavClick )
    then
      FOnNavClick( Self, Index );
  end;

{ *************************************************************************** }
procedure TKingNavigator.TheDateChanged;
  var
    cDate, cToday : String;
    dDate : TDateTime;
  begin

    cToday := kcDateToStr( Now );
    dDate := EncodeDate( CalendarSource.Year, CalendarSource.Month,
      CalendarSource.Day );
    cDate := kcDateToStr( dDate );

    if ( cDate <> cToday ) then
      SetTodayText(cDate)
    else
      SetTodayText(cToday);

    if ( cDate <> cToday )
    then
    begin
      if FTodayStyle
      then
        Buttons[ nbToday ].Caption := FTodayText
      else
        Buttons[ nbToday ].Caption := cDate;

      Buttons[ nbToday ].Font.Color := clWindowText;
    end
    else
    begin
      if FTodayStyle
      then
        Buttons[ nbToday ].Caption := FTodayText
      else
        Buttons[ nbToday ].Caption := cDate;

      Buttons[ nbToday ].Font.Color := Highlight;
    end;
    Buttons[ nbToday ].Invalidate;
    self.Invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.SetHighlight( oColor : TColor );
var
  I: TCalcbtn;
  begin
    FHighlight := oColor;
    Buttons[ nbToday ].Font.Color := FHighlight;

    for I := Low(Buttons) to High(Buttons) do begin
      Buttons[I].Invalidate;
      // LR20260325 - Removed Application.ProcessMessages; unnecessary in invalidation loop
      // application.ProcessMessages;
    end;
  end;

{ *************************************************************************** }
procedure TKingNavigator.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
    self.invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
    begin
      // LR20260325 - Unhook before nilling to prevent dangling pointer
      FCalendarSource.UnhookEvent( TheDateChanged );
      FCalendarSource := nil;
    end;

  end;

{ *************************************************************************** }
procedure TKingNavigator.SetTodayText( Value : String );
  begin
    FTodayText := Value;

    if FTodayStyle
    then
      Buttons[ nbToday ].Caption := Value;

    self.invalidate;
  end;

{ *************************************************************************** }
procedure TKingNavigator.SetTodayStyle( Value : Boolean );
  begin
    FTodayStyle := Value;

    if FTodayStyle
    then
      Buttons[ nbToday ].Caption := FTodayText
    else
      Buttons[ nbToday ].Caption := kcDateToStr( Now );

    self.invalidate;
  end;

{ ===========================================================================
  TKingButton
  =========================================================================== }
procedure TKingButton.Paint;
  var
    R      : TRect;
    Margin : Integer;
  begin
    if ThemeControl(self) then
      PerformEraseBackground(Self, Canvas.Handle);

    Inherited Paint;

//      if ShowFocus and Focused and FShowFocusRect then
//  begin
//    Canvas.Brush.Color := Self.Color;
//    R := Rect( FButtonWidth + 1, 2, Width - FButtonWidth -1, Height - 2 );
//    Canvas.DrawFocusRect( R );
//  end;

    if ( GetFocus = Parent.Handle ) and
      ( FIndex = TKingNavigator( Parent ).FocusedButton )
    then
    begin
      Canvas.Brush.Color := Self.Color;
      R := Bounds( 0, 0, Width, Height );
      // LR20260323 - Scale focus rect inset for high DPI
      // InflateRect( R, - 3, - 3 );
      Margin := MulDiv( 3, Screen.PixelsPerInch, 96 );
      InflateRect( R, -Margin, -Margin );
      IF FState = bsDown
      then
        OffsetRect( R, 1, 1 );
      DrawFocusRect( Canvas.Handle, R );
    end;
  end;

end.
