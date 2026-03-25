{ *                                                                                * }
{ *  unit KingToolMonth                                                            * }
{ *  KingCalendar Month Bar Panel                                                  * }
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

// LR20260325 - Extracted TMonthBar and TMonthButton from KingTool.pas

unit KingToolMonth;

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

  TMonthButton = class;
  TMonthBtn = ( nbJan, nbFeb, nbMar, nbApr, nbMay, nbJun, nbJul, nbAug, nbSep,
    nbOct, nbNov, nbDec );
  TMonthBtnSet = set of TMonthBtn;
  eMonthClick = procedure(
    Sender : TObject;
    Button : TMonthBtn ) of Object;

  { TMonthBar }
  TMonthBar = class( TCustomPanel { TKingBasePanel } )
    private
      Buttons : array [ TMonthBtn ] of TMonthButton;
      FVisibleButtons : TMonthBtnSet;
      FCalendarSource : TKingCalendar;
      ButtonWidth : Integer;
      MinBtnSize : TPoint;
      FOnNavClick : eMonthClick;
      FocusedButton : TMonthBtn;
      FHighlight : TColor;
      FAbout : String;
      procedure InitButtons;
      procedure Click( Sender : TObject ); reintroduce; virtual; // Resolve hint
      procedure BtnMouseDown(
        Sender : TObject;
        Button : TMouseButton;
        Shift  : TShiftState;
        X, Y   : Integer );
      procedure SetVisible( Value : TMonthBtnSet );
      procedure AdjustSize(
        var W : Integer;
        var H : Integer ); reintroduce; virtual; // Resolve hint
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure WMSetfocus( var Message : TWMSetFocus ); message WM_SETFOCUS;
      procedure WMKillFocus( var Message : TWMKillFocus ); message WM_KILLFOCUS;
      procedure WMGetDlgCode( var Message : TWMGetDlgCode );
        message WM_GETDLGCODE;
      procedure SetHighlight( oColor : TColor );
      procedure SetFocusedButton( nMonth : Integer );
    protected
      procedure SetSource( Value : TKingCalendar ); { override; }
      procedure Loaded; override;
      procedure KeyDown(
        var Key : Word;
        Shift   : TShiftState ); override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
      // LR20260323 - Scale MinBtnSize pixel values for high DPI
      procedure ChangeScale( M, D : Integer ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure SetBounds( ALeft, ATop, AWidth, AHeight : Integer ); override;
      procedure BtnClick( Index : TMonthBtn );
      procedure TheDateChanged( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      property CalendarSource : TKingCalendar
        read FCalendarSource
        write SetSource;
      property VisibleButtons : TMonthBtnSet
        read FVisibleButtons
        write SetVisible
        default [ nbJan, nbFeb, nbMar, nbApr, nbMay, nbJun, nbJul, nbAug, nbSep,
        nbOct, nbNov, nbDec ];
      property Align;
      property Highlight : TColor
        read FHighlight
        write SetHighlight;
      property DragCursor;
      property DragMode;
      property ShowHint
        default True;
      property ParentShowHint;
      property Visible;
  end;

  { TMonthButton }
  TMonthButton = class( TSpeedButton )
    private
      FIndex : TMonthBtn;
    protected
      procedure Paint; override;
    public
      property
        Index : TMonthBtn
        read FIndex
        write FIndex;

    published
  end;

implementation

uses
  KingTool;

const

  { * Captions for the TMonthBar * }
  MthCaption : array [ TMonthBtn ] of PChar = ( 'Jan', 'Feb', 'Mar', 'Apr',
    'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' );

  { * Hints for the TMonthBar * }
  MthHintId : array [ TMonthBtn ] of PChar = ( 'January', 'February', 'March',
    'April', 'May', 'June', 'July', 'August', 'September', 'October',
    'November', 'December' );

{ ===========================================================================
  TMonthBar
  =========================================================================== }
constructor TMonthBar.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    ControlStyle := ControlStyle - [ csAcceptsControls, csSetCaption ] +
      [ csFramed, csOpaque ];
    FVisibleButtons := [ nbJan, nbFeb, nbMar, nbApr, nbMay, nbJun, nbJul, nbAug,
      nbSep, nbOct, nbNov, nbDec ];
    FHighlight := clBlue;
    InitButtons;
    BevelOuter := bvNone;
    BevelInner := bvNone;

    { Set Dimensions to match default size of the TKingCalendar Component }
    Width := 321;
    Height := 18;
    ButtonWidth := 0;

    { Enable Hints }
    ShowHint := True;

    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( AOwner.Components[ I ] );
        Break;
      end;
    end;

  end;

{ *************************************************************************** }
procedure TMonthBar.InitButtons;
  var
    I : TMonthBtn;
    Btn : TMonthButton;
    X, Y, nMonth : Integer;
    // hint  ResName: array[0..40] of Char;
  begin
    MinBtnSize := Point( 20, 18 );
    nMonth := kcMonth( Date );
    SetFocusedButton( nMonth );
    X := 0;
    Y := 0;
    for I := low( Buttons ) to high( Buttons ) do
    begin
      Y := Y + 1;
      Btn := TMonthButton.Create( Self );
      Btn.Index := I;
      Btn.Visible := I in FVisibleButtons;
      Btn.Enabled := True;
      Btn.SetBounds( X, 0, MinBtnSize.X, MinBtnSize.Y );

      // LR20260323 - Fixed typo: was 'Segue UI'
      // Btn.Font.Name := 'Segue UI';
      Btn.Font.Name := 'Segoe UI';
      //      Btn.Font.Name := 'Small Fonts';
      Btn.Font.Size := 7;
      Btn.Caption := StrPas( MthCaption[ I ] );

      if ( Y = nMonth )
      then
        Btn.Font.Color := FHighlight;

      Btn.OnClick := Click;
      Btn.OnMouseDown := BtnMouseDown;
      Btn.Hint := StrPas( MthHintId[ I ] );
      Btn.Parent := Self;
      Buttons[ I ] := Btn;
      X := X + MinBtnSize.X;
    end;

  end;

{ *************************************************************************** }
procedure TMonthBar.SetVisible( Value : TMonthBtnSet );
  var
    I : TMonthBtn;
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
    invalidate;
  end;

{ *************************************************************************** }
procedure TMonthBar.AdjustSize(
  var W : Integer;
  var H : Integer );
  var
    Count, MInW, X, Space, Temp, Remain : Integer;
    I : TMonthBtn;
    // hint	LastBtn: TMonthBtn;
  begin

    if ( csLoading in ComponentState )
    then
      exit;
    if Buttons[ nbJan ] = nil
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
        // hint	  LastBtn := I;
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

    invalidate;
  end;

{ *************************************************************************** }
procedure TMonthBar.SetBounds( ALeft, ATop, AWidth, AHeight : Integer );
  var
    W, H : Integer;
  begin
    W := AWidth;
    H := AHeight;
    AdjustSize( W, H );
    inherited SetBounds( ALeft, ATop, W, H );
  end;

{ *************************************************************************** }
// LR20260323 - Scale MinBtnSize pixel values for high DPI
procedure TMonthBar.ChangeScale( M, D : Integer );
  begin
    inherited ChangeScale( M, D );
    MinBtnSize.X := MulDiv( MinBtnSize.X, M, D );
    MinBtnSize.Y := MulDiv( MinBtnSize.Y, M, D );
  end;

{ *************************************************************************** }
procedure TMonthBar.WMSize( var Message : TWMSize );
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

    invalidate;
  end;

{ *************************************************************************** }
procedure TMonthBar.Click( Sender : TObject );
  begin
    BtnClick( TMonthButton( Sender ).Index );
  end;

{ *************************************************************************** }
procedure TMonthBar.BtnMouseDown(
  Sender : TObject;
  Button : TMouseButton;
  Shift  : TShiftState;
  X, Y   : Integer );
  var
    OldFocus : TMonthBtn;
    // LR20260325 - Changed from TForm to TCustomForm to avoid unsafe cast
    // Form : TForm;
    Form : TCustomForm;
  begin
    OldFocus := FocusedButton;
    FocusedButton := TMonthButton( Sender ).Index;
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
  end;

{ *************************************************************************** }
procedure TMonthBar.WMSetfocus( var Message : TWMSetFocus );
  begin
    Buttons[ FocusedButton ].invalidate;
  end;

{ *************************************************************************** }
procedure TMonthBar.WMKillFocus( var Message : TWMKillFocus );
  begin
    Buttons[ FocusedButton ].invalidate;
  end;

{ *************************************************************************** }
procedure TMonthBar.KeyDown(
  var Key : Word;
  Shift   : TShiftState );
  var
    NewFocus, OldFocus : TMonthBtn;
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
  end;

{ *************************************************************************** }
procedure TMonthBar.WMGetDlgCode( var Message : TWMGetDlgCode );
  begin
    Message.Result := DLGC_WANTARROWS;
  end;

{ *************************************************************************** }
procedure TMonthBar.Loaded;
  var
    W, H : Integer;
    // hint  State: TComponentState;
  begin
    inherited Loaded;
    W := Width;
    H := Height;
    AdjustSize( W, H );
    IF ( W <> Width ) or ( H <> Height )
    then
      inherited SetBounds( Left, Top, W, H );

    if ( CalendarSource <> nil )
    then
    begin
      SetFocusedButton( CalendarSource.Month );
      CalendarSource.HookEvent := TheDateChanged;
    end;

  end;

{ *************************************************************************** }
procedure TMonthBar.SetFocusedButton( nMonth : Integer );
  begin
    case nMonth of
      1 :
        FocusedButton := nbJan;
      2 :
        FocusedButton := nbFeb;
      3 :
        FocusedButton := nbMar;
      4 :
        FocusedButton := nbApr;
      5 :
        FocusedButton := nbMay;
      6 :
        FocusedButton := nbJun;
      7 :
        FocusedButton := nbJul;
      8 :
        FocusedButton := nbAug;
      9 :
        FocusedButton := nbSep;
      10 :
        FocusedButton := nbOct;
      11 :
        FocusedButton := nbNov;
      12 :
        FocusedButton := nbDec;
    end;

  end;

{ *************************************************************************** }
procedure TMonthBar.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
    SetFocusedButton( Value.Month );
  end;

{ *************************************************************************** }
procedure TMonthBar.BtnClick( Index : TMonthBtn );
  var
    X : TMonthBtn;
  begin
    if ( CalendarSource <> nil )
    then
    begin
      // LR20260325 - Removed with statement
      // with CalendarSource do
      case Index of
        nbJan :
          CalendarSource.Month := 1;
        nbFeb :
          CalendarSource.Month := 2;
        nbMar :
          CalendarSource.Month := 3;
        nbApr :
          CalendarSource.Month := 4;
        nbMay :
          CalendarSource.Month := 5;
        nbJun :
          CalendarSource.Month := 6;
        nbJul :
          CalendarSource.Month := 7;
        nbAug :
          CalendarSource.Month := 8;
        nbSep :
          CalendarSource.Month := 9;
        nbOct :
          CalendarSource.Month := 10;
        nbNov :
          CalendarSource.Month := 11;
        nbDec :
          CalendarSource.Month := 12;
      end;
      for X := low( Buttons ) to high( Buttons ) do
      begin
        if ( X <> Index )
        then
          Buttons[ X ].Font.Color := clWindowText
        else
          Buttons[ X ].Font.Color := Highlight;
      end;

    end;
    if not ( csDesigning in ComponentState ) and Assigned( FOnNavClick )
    then
      FOnNavClick( Self, Index );
  end;

{ *************************************************************************** }
procedure TMonthBar.SetHighlight( oColor : TColor );
  begin
    FHighlight := oColor;
    Buttons[ FocusedButton ].Font.Color := FHighlight;
  end;

{ *************************************************************************** }
procedure TMonthBar.Notification(
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
procedure TMonthBar.TheDateChanged( Sender : TObject );
  var
    X : TMonthBtn;
  begin

    SetFocusedButton( CalendarSource.Month );

    for X := low( Buttons ) to high( Buttons ) do
    begin
      if ( X <> FocusedButton )
      then
        Buttons[ X ].Font.Color := clWindowText
      else
        Buttons[ X ].Font.Color := Highlight;
    end;
    invalidate;
  end;

{ ===========================================================================
  TMonthButton
  =========================================================================== }
procedure TMonthButton.Paint;
  var
    R      : TRect;
    Margin : Integer;
  begin
    if ThemeControl(self) then
      PerformEraseBackground(Self, Canvas.Handle);

    Inherited Paint;
    if ( GetFocus = Parent.Handle ) and
      ( FIndex = TMonthBar( Parent ).FocusedButton )
    then
    begin
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
