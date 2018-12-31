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
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Menus,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Spin,
  TheKing;

type

  TKingButton = class;
  TMonthButton = class;
  TCalGlyph = ( ngEnabled, ndDisabled );
  TCalcBtn = ( nbPrevYear, nbPrevMonth, nbToday, nbNextMonth, nbNextYear );
  TMonthBtn = ( nbJan, nbFeb, nbMar, nbApr, nbMay, nbJun, nbJul, nbAug, nbSep,
    nbOct, nbNov, nbDec );
  TMonthBtnSet = set of TMonthBtn;
  TCalcBtnSet = set of TCalcBtn;
  eCalcClick = procedure(
    Sender : TObject;
    Button : TCalcBtn ) of Object;
  eMonthClick = procedure(
    Sender : TObject;
    Button : TMonthBtn ) of Object;

  { TKingLabel }
  TKingLabel = class( TLabel )
    private
      FAbout : String;
      FCalendarSource : TKingCalendar;
      FFormat : String;
    protected
      procedure SetSource( Value : TKingCalendar );
      procedure SetFormat( Value : String );
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure DateChange( Sender : TObject );
      procedure UpdateLabel;
    published
      property About : String
        read FAbout
        write FAbout;
      property CalendarSource : TKingCalendar
        read FCalendarSource
        write SetSource;
      property DateFormat : String
        read FFormat
        write SetFormat;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TKingBaseSpine }
  TKingBaseSpin = class( TSpinButton )
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

  { TMonthSpin }
  TMonthSpin = class( TKingBaseSpin { TSpinButton } )
    private
      FAbout : String;
      { FCalendarSource: TKingCalendar; }
      // hint    FOnUpClick: TNotifyEvent;
      // hint    FOnDownClick: TNotifyEvent;
    protected
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure nextMonth( Sender : TObject );
      procedure prevMonth( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      { property CalendarSource: TKingCalendar read FCalendarSource write FCalendarSource; }
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TYearSpin }
  TYearSpin = class( TKingBaseSpin { TSpinButton } )
    private
      FAbout : String;
      { FCalendarSource: TKingCalendar; }
      // hint    FOnUpClick: TNotifyEvent;
      // hint    FOnDownClick: TNotifyEvent;
      FMinYear : Integer;
      FMaxYear : Integer;
    protected
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure nextYear( Sender : TObject );
      procedure prevYear( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      property MinYear : Integer
        read FMinYear
        write FMinYear;
      property MaxYear : Integer
        read FMaxYear
        write FMaxYear;
      { property CalendarSource: TKingCalendar read FCalendarSource write FCalendarSource; }
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TDaySpin }
  TDaySpin = class( TKingBaseSpin { TSpinButton } )
    private
      FAbout : String;
      { FCalendarSource: TKingCalendar; }
      // hint    FOnUpClick: TNotifyEvent;
      // hint    FOnDownClick: TNotifyEvent;
    protected
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure nextDay( Sender : TObject );
      procedure prevDay( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      { property CalendarSource: TKingCalendar read FCalendarSource write FCalendarSource; }
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TKingBaseCombo }
  TKingBaseCombo = class( TCustomComboBox )
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

  { TMonthCombo }
  TMonthCombo = class( TKingBaseCombo { TCustomComboBox } )
    private
      FAbout : String;
      { FCalendarSource: TKingCalendar; }
    protected
      procedure SetSource( Value : TKingCalendar ); override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure ChangeTheMonth( Sender : TObject );
      procedure Hooked( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      { property CalendarSource: TKingCalendar read FCalendarSource write SetSource; }
      property Font;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TYearCombo }
  TYearCombo = class( TKingBaseCombo { TCustomComboBox } )
    private
      FAbout : String;
      { FCalendarSource: TKingCalendar; }
      FMinYear : Integer;
      FMaxYear : Integer;
    protected
      procedure SetSource( Value : TKingCalendar ); override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure ChangeTheYear( Sender : TObject );
      procedure Hooked( Sender : TObject );
    published
      property About : String
        read FAbout
        write FAbout;
      property MinYear : Integer
        read FMinYear
        write FMinYear;
      property MaxYear : Integer
        read FMaxYear
        write FMaxYear;
      { property CalendarSource: TKingCalendar read FCalendarSource write SetSource; }
      property Font;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TDayCombo }
  TDayCombo = class( TKingBaseCombo { TCustomComboBox } )
    private
      FAbout : String;
      { FCalendarSource: TKingCalendar; }
      FMinDay : Integer;
      FMaxDay : Integer;
    protected
      procedure SetSource( Value : TKingCalendar ); override;
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure Loaded; override;
      procedure ChangeTheDay( Sender : TObject );
      procedure TheDateChanged( Sender : TObject );
      property MinDay : Integer
        read FMinDay
        write FMinDay;
      property MaxDay : Integer
        read FMaxDay
        write FMaxDay;
    published
      property About : String
        read FAbout
        write FAbout;
      { property CalendarSource: TKingCalendar read FCalendarSource write SetSource; }
      property Font;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

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

  { TMonthBar }
  TMonthBar = class( TCustomPanel { TKingBasePanel } )
    private
      Buttons : array [ TMonthBtn ] of TMonthButton;
      FVisibleButtons : TMonthBtnSet;
      FCalendarSource : TKingCalendar;
      // hint    CurrentButton: TMonthBtn;
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

  { Future KingTool DLL Fucntions }
function kcDateToStr( dDate : TDateTime ) : String;
function kcMonth( dDate : TDateTime ) : Word;
function kcIsLeapYear( nYear : Integer ) : Boolean;
function kcDate2Week( dDate : TDateTime ) : Integer;
function kcWeekOfYear( dDate : TDateTime ) : Integer;
function kcDayOfYear( dDate : TDateTime ) : Integer;
function kcMonthDays( nMonth, nYear : Integer ) : Integer;
function kcEaster( nYear : Integer ) : TDateTime;
function kcDayOfWeek( dDate : TDateTime ) : Integer;
function kcIncDate( dDate : TDateTime ) : TDateTime;
function kcIncDateBy(
  dDate  : TDateTime;
  nValue : Integer ) : TDateTime;
function kcDecdate( dDate : TDateTime ) : TDateTime;
function kcDecDateBy(
  dDate  : TDateTime;
  nValue : Integer ) : TDateTime;
function kcWorkDays( dStart, dEnd : TDateTime ) : Integer;
function kcSubDates( dMax, dMin : TDateTime ) : Integer;
function kcAddDates( dMin, dMax : TDateTime ) : Integer;

implementation

{$R KCAL32.RES}

uses
  System.DateUtils;

const

  { * TKingNavigator Glpyh Suffix's in the KINGCAL.RES * }
  BtnResName : array [ TCalcBtn ] of PChar = ( 'PREVYEAR', 'PREVMONTH', 'TODAY',
    'NEXTMONTH', 'NEXTYEAR' );

  { * Hint's for the TKingNavigator * }
  BtnHintId : array [ TCalcBtn ] of PChar = ( 'Previous Year', 'Previous Month',
    'Return to Todays Date', 'Next Month', 'Next Year' );

  { * Captions for the TMonthBar * }
  MthCaption : array [ TMonthBtn ] of PChar = ( 'Jan', 'Feb', 'Mar', 'Apr',
    'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' );

  { * Hints for the TMonthBar * }
  MthHintId : array [ TMonthBtn ] of PChar = ( 'January', 'February', 'March',
    'April', 'May', 'June', 'July', 'August', 'September', 'October',
    'November', 'December' );

  { * Strings to loadup the TMonthCombo with * }
  MnthNameList : array [ 1 .. 12 ] of PChar = ( 'January', 'February', 'March',
    'April', 'May', 'June', 'July', 'August', 'September', 'October',
    'November', 'December' );

  { ===========================================================================
    TMonthSpin
    =========================================================================== }
constructor TMonthSpin.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;

  end;

procedure TMonthSpin.Loaded;
  begin
    inherited Loaded;

    { Assign NextMonth method to the the OnUpClick Event }
    OnUpClick := nextMonth;

    { Assign PrevMonth method to the the OnDownClick Event }
    OnDownClick := prevMonth;

  end;

{ *************************************************************************** }
procedure TMonthSpin.nextMonth( Sender : TObject );
  begin

    { If the control is wired to a TKingCalendar, fire off the method }
    if CalendarSource <> nil
    then
      CalendarSource.nextMonth;
  end;

{ *************************************************************************** }
procedure TMonthSpin.prevMonth( Sender : TObject );
  begin
    { If the control is wired to a TKingCalendar, fire off the method }
    if CalendarSource <> nil
    then
      CalendarSource.prevMonth;
  end;

{ *************************************************************************** }
procedure TMonthSpin.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );
    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;
  end;

{ ===========================================================================
  TYearSpin
  =========================================================================== }
constructor TYearSpin.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    { Set the Base Ranges of selectable years }
    FMinYear := 1980;
    FMaxYear := 2040;
//    FMaxYear := 2020;

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;

  end;

{ *************************************************************************** }
procedure TYearSpin.Loaded;
  begin
    inherited Loaded;
    { Assign NextYear method to the the OnUpClick Event }
    OnUpClick := nextYear;
    { Assign PrevYear method to the the OnUpClick Event }
    OnDownClick := prevYear;
  end;

{ *************************************************************************** }
procedure TYearSpin.nextYear( Sender : TObject );
  begin
    { If the control is wired to a TKingCalendar, fire off the method }
    if ( CalendarSource <> nil ) and ( CalendarSource.Year < FMaxYear )
    then
      CalendarSource.nextYear;
  end;

{ *************************************************************************** }
procedure TYearSpin.prevYear( Sender : TObject );
  begin
    { If the control is wired to a TKingCalendar, fire off the method }
    if ( CalendarSource <> nil ) and ( CalendarSource.Year > FMinYear )
    then
      CalendarSource.prevYear;
  end;

{ *************************************************************************** }
procedure TYearSpin.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );
    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;
  end;

{ ===========================================================================
  TDaySpin
  =========================================================================== }
constructor TDaySpin.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;

  end;

{ *************************************************************************** }
procedure TDaySpin.Loaded;
  begin
    inherited Loaded;
    { Assign NextDay method to the the OnUpClick Event }
    OnUpClick := nextDay;
    { Assign PrevDay method to the the OnUpClick Event }
    OnDownClick := prevDay;
  end;

{ *************************************************************************** }
procedure TDaySpin.nextDay( Sender : TObject );
  begin
    if CalendarSource <> nil
    then
      CalendarSource.nextDay;
  end;

{ *************************************************************************** }
procedure TDaySpin.prevDay( Sender : TObject );
  begin
    if CalendarSource <> nil
    then
      CalendarSource.prevDay;
  end;

{ *************************************************************************** }
procedure TDaySpin.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;

  end;
{ ===========================================================================
  TKingBaseSpin
  =========================================================================== }

{ *************************************************************************** }
procedure TKingBaseSpin.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
  end;

{ ===========================================================================
  TKingBasePnel
  =========================================================================== }

{ *************************************************************************** }
procedure TKingBasePanel.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
  end;

{ ===========================================================================
  TKingBaseCombo
  =========================================================================== }

{ *************************************************************************** }
procedure TKingBaseCombo.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
  end;

{ ===========================================================================
  TMonthCombo
  =========================================================================== }
constructor TMonthCombo.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    Width := 124;
    Style := csDropDownList;

    for I := 0 to TForm( Owner ).ComponentCount - 1 do
    begin
      if TForm( Owner ).Components[ I ] is TKingCalendar
      then
      begin
        FCalendarSource := TKingCalendar( TForm( Owner ).Components[ I ] );
        Break;
      end;
    end;

  end;

{ *************************************************************************** }
procedure TMonthCombo.ChangeTheMonth( Sender : TObject );
  begin
    if FCalendarSource <> nil
    then
      CalendarSource.Month := ItemIndex + 1;
  end;

{ *************************************************************************** }
procedure TMonthCombo.Loaded;
  var
    X : Integer;
  begin
    inherited Loaded;

    Clear;
    for X := 1 to 12 do
      items.Add( StrPas( MnthNameList[ X ] ) );

    OnChange := ChangeTheMonth;

    if ( CalendarSource <> nil )
    then
    begin
      CalendarSource.HookEvent := Hooked;
      ItemIndex := ( CalendarSource.Month - 1 );
    end;
  end;

{ *************************************************************************** }
procedure TMonthCombo.Hooked( Sender : TObject );
  begin
    ItemIndex := ( CalendarSource.Month - 1 );
  end;

{ *************************************************************************** }
procedure TMonthCombo.SetSource( Value : TKingCalendar );
  var
    X : Integer;
  begin
    Clear;

    for X := 1 to 12 do
      items.Add( StrPas( MnthNameList[ X ] ) );

    FCalendarSource := Value;
    ItemIndex := ( CalendarSource.Month - 1 );

  end;

{ *************************************************************************** }
procedure TMonthCombo.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;

  end;

{ ===========================================================================
  TYearCombo
  =========================================================================== }
constructor TYearCombo.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    FMinYear := 1980;
    FMaxYear := 2020;
    Width := 75;
    Style := csDropDownList;

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        FCalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;

  end;

{ *************************************************************************** }
procedure TYearCombo.ChangeTheYear( Sender : TObject );
  begin
    if CalendarSource <> nil
    then
      CalendarSource.Year := ( ItemIndex + FMinYear );
  end;

{ *************************************************************************** }
procedure TYearCombo.Loaded;
  var
    X : Integer;
  begin
    inherited Loaded;
    Clear;

    for X := MinYear to MaxYear do
      items.Add( IntToStr( X ) );

    SelText := IntToStr( FMinYear );

    OnChange := ChangeTheYear;

    if ( CalendarSource <> nil )
    then
    begin
      CalendarSource.HookEvent := Hooked;
      ItemIndex := ( CalendarSource.Year - FMinYear );
    end;

  end;

{ *************************************************************************** }
procedure TYearCombo.SetSource( Value : TKingCalendar );
  var
    X : Integer;
  begin
    FCalendarSource := Value;
    Clear;
    for X := MinYear to MaxYear do
      items.Add( IntToStr( X ) );
    SelText := IntToStr( CalendarSource.Year );
  end;

{ *************************************************************************** }
procedure TYearCombo.Hooked( Sender : TObject );
  begin
    ItemIndex := ( CalendarSource.Year - FMinYear );
  end;

{ *************************************************************************** }
procedure TYearCombo.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;

  end;

{ ===========================================================================
  TDayCombo
  =========================================================================== }
constructor TDayCombo.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    FMinDay := 1;
    FMaxDay := 31;
    Width := 75;
    Style := csDropDownList;
    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        FCalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;

  end;

{ *************************************************************************** }
procedure TDayCombo.ChangeTheDay( Sender : TObject );
  begin
    if CalendarSource <> nil
    then
    begin
      CalendarSource.Day := ( ItemIndex + 1 );
      CalendarSource.UpdateCalendar;
    end;
  end;

{ *************************************************************************** }
procedure TDayCombo.Loaded;
  var
    X : Integer;
  begin
    inherited Loaded;

    for X := FMinDay to FMaxDay do
      items.Add( IntToStr( X ) );

    OnChange := ChangeTheDay;

    if ( FCalendarSource <> nil )
    then
      CalendarSource.HookEvent := TheDateChanged;

  end;

{ *************************************************************************** }
procedure TDayCombo.SetSource( Value : TKingCalendar );
  var
    X : Integer;
  begin
    FCalendarSource := Value;
    MaxDay := Value.DaysThisMonth;
    Clear;
    for X := FMinDay to FMaxDay do
      items.Add( IntToStr( X ) );

    ItemIndex := ( CalendarSource.Day - 1 );

  end;

{ *************************************************************************** }
procedure TDayCombo.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;

  end;

{ *************************************************************************** }
procedure TDayCombo.TheDateChanged;
  var
    X : Integer;
  begin

    if Assigned( FCalendarSource )
    then
    begin
      Clear;
      FMaxDay := CalendarSource.DaysThisMonth;
      for X := FMinDay to FMaxDay do
        items.Add( IntToStr( X ) );

      ItemIndex := ( CalendarSource.Day - 1 );
    end;

  end;

{ ===========================================================================
  TKingNavigator
  =========================================================================== }
constructor TKingNavigator.Create( AOwner : TComponent );
  var
    I : Integer;
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

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;

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
        Btn.Font.Name := 'Times New Roman'; { Captions Font }
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
    invalidate;
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
  end;

{ *************************************************************************** }
procedure TKingNavigator.BtnMouseDown(
  Sender : TObject;
  Button : TMouseButton;
  Shift  : TShiftState;
  X, Y   : Integer );
  var
    OldFocus : TCalcBtn;
    Form : TForm;
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
      Form := TForm( GetParentForm( Self ) );
      if ( Form <> nil )
      then
        Form.Perform( CM_CANCELMODE, 0, 0 );
    end;
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
    // hint  State: TComponentState;
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
  begin
    if ( CalendarSource <> nil )
    then
    begin
      with CalendarSource do
      begin
        case Index of
          nbPrevMonth :
            prevMonth;
          nbPrevYear :
            prevYear;
          nbNextYear :
            nextYear;
          nbNextMonth :
            nextMonth;
          nbToday :
            Today;
        end;
      end;
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

    cToday := kcDateToStr( Date );
    dDate := EncodeDate( CalendarSource.Year, CalendarSource.Month,
      CalendarSource.Day );
    cDate := kcDateToStr( dDate );

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
  end;

{ *************************************************************************** }
procedure TKingNavigator.SetHighlight( oColor : TColor );
  begin
    FHighlight := oColor;
    Buttons[ nbToday ].Font.Color := FHighlight;

  end;

{ *************************************************************************** }
procedure TKingNavigator.SetSource( Value : TKingCalendar );
  begin
    FCalendarSource := Value;
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
      FCalendarSource := nil;

  end;

{ *************************************************************************** }
procedure TKingNavigator.SetTodayText( Value : String );
  begin
    FTodayText := Value;

    if FTodayStyle
    then
      Buttons[ nbToday ].Caption := Value;

  end;

{ *************************************************************************** }
procedure TKingNavigator.SetTodayStyle( Value : Boolean );
  begin
    FTodayStyle := Value;

    if FTodayStyle
    then
      Buttons[ nbToday ].Caption := FTodayText
    else
      Buttons[ nbToday ].Caption := kcDateToStr( Date );

  end;

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

    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
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

      Btn.Font.Name := 'Small Fonts';
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
    Form : TForm;
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
      Form := TForm( GetParentForm( Self ) );
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
      with CalendarSource do
      begin
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
      FCalendarSource := nil;

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
  end;

{ ===========================================================================
  TKingButton
  =========================================================================== }
procedure TKingButton.Paint;
  var
    R : TRect;
  begin
    Inherited Paint;
    if ( GetFocus = Parent.Handle ) and
      ( FIndex = TKingNavigator( Parent ).FocusedButton )
    then
    begin
      R := Bounds( 0, 0, Width, Height );
      InflateRect( R, - 3, - 3 );
      IF FState = bsDown
      then
        OffsetRect( R, 1, 1 );
      DrawFocusRect( Canvas.Handle, R );
    end;
  end;

{ ===========================================================================
  TMonthButton
  =========================================================================== }
procedure TMonthButton.Paint;
  var
    R : TRect;
  begin
    Inherited Paint;
    if ( GetFocus = Parent.Handle ) and
      ( FIndex = TMonthBar( Parent ).FocusedButton )
    then
    begin
      R := Bounds( 0, 0, Width, Height );
      InflateRect( R, - 3, - 3 );
      IF FState = bsDown
      then
        OffsetRect( R, 1, 1 );
      DrawFocusRect( Canvas.Handle, R );
    end;
  end;

{ ===========================================================================
  TKingLabel
  =========================================================================== }
constructor TKingLabel.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    FFormat := 'MMMM DD, YYYY';
    for I := 0 to TForm( AOwner ).ComponentCount - 1 do
    begin
      if TForm( AOwner ).Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( TForm( AOwner ).Components[ I ] );
        Break;
      end;
    end;
  end;

{ *************************************************************************** }
procedure TKingLabel.Loaded;
  // hint var
  // hint  cDate: String;
  begin
    inherited Loaded;

    UpdateLabel;

    if ( FCalendarSource <> nil )
    then
      CalendarSource.HookEvent := DateChange;
  end;

{ *************************************************************************** }
procedure TKingLabel.DateChange( Sender : TObject );
  begin

    UpdateLabel;

  end;

{ *************************************************************************** }
procedure TKingLabel.SetFormat( Value : String );
  begin

    FFormat := Value;

    if ( FCalendarSource <> nil )
    then
      UpdateLabel;

  end;

{ *************************************************************************** }
procedure TKingLabel.SetSource( Value : TKingCalendar );
  begin

    FCalendarSource := Value;
    UpdateLabel;

  end;

{ *************************************************************************** }
procedure TKingLabel.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
      FCalendarSource := nil;

  end;

{ *************************************************************************** }
procedure TKingLabel.UpdateLabel;
  var
    cDate : String;
    ldf: string;
  begin

    if ( FCalendarSource <> nil )
    then
    begin
      // Furnish the locale format settings record
      {$WARN SYMBOL_PLATFORM OFF}
      formatSettings := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
      {$WARN SYMBOL_PLATFORM ON}

      ldf := formatSettings.LongDateFormat;

      DateTimeToString( cDate, ldf, CalendarSource.CalendarDate, formatSettings );
//      DateTimeToString( cDate, FFormat, CalendarSource.CalendarDate );
      Caption := cDate;
    end;

  end;

{ ===========================================================================
  KingCalendar Components for Delphi Support Functions
  =========================================================================== }
function kcDateToStr( dDate : TDateTime ) : String;
  var
    sdf: string;
  begin
    // Furnish the locale format settings record
    {$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
    {$WARN SYMBOL_PLATFORM ON}

    sdf := formatSettings.ShortDateFormat;
    DateTimeToString( Result, sdf, dDate, formatSettings );
//    DateTimeToString( Result, 'mm/dd/yy', dDate );

  end;

{ *************************************************************************** }
function kcIsLeapYear( nYear : Integer ) : Boolean;
  var
    dt: TDateTime;
  begin
    dt := encodedatetime(nyear,1,1,0,0,0,0);
    result := System.DateUtils.IsInLeapYear(dt);
//    Result := ( nYear mod 4 = 0 ) and
//      ( ( nYear mod 100 <> 0 ) or ( nYear mod 400 = 0 ) );
  end;

{ *************************************************************************** }
function kcMonth( dDate : TDateTime ) : Word;
//  var
//    AYear, AMonth, ADay : Word;
  begin
    result := System.DateUtils.MonthOf(dDate);
//
//    DecodeDate( dDate, AYear, AMonth, ADay );
//    Result := AMonth;
  end;

{ *************************************************************************** }
function kcMonthDays( nMonth, nYear : Integer ) : Integer;
//  const
//    DaysPerMonth : array [ 1 .. 12 ] of Integer = ( 31, 28, 31, 30, 31, 30, 31,
//      31, 30, 31, 30, 31 );
  begin
    result := System.DateUtils.DaysInAMonth(nYear,nMonth);
//
//
//    Result := DaysPerMonth[ nMonth ];
//    if ( nMonth = 2 ) and kcIsLeapYear( nYear )
//    then
//      Inc( Result );
  end;

{ *************************************************************************** }
function kcDate2Week( dDate : TDateTime ) : Integer;
  begin
    Result := kcWeekOfYear( dDate );
  end;

{ *************************************************************************** }
function kcWeekOfYear( dDate : TDateTime ) : Integer;
//  var
//    X, nDayCount : Integer;
//    nMonth, nDay, nYear : Word;
  begin
    result := System.DateUtils.WeekOfTheYear(dDate);
//
//    nDayCount := 0;
//
//    DecodeDate( dDate, nYear, nMonth, nDay );
//
//    For X := 1 to ( nMonth - 1 ) do
//      nDayCount := nDayCount + kcMonthDays( X, nYear );
//
//    nDayCount := nDayCount + nDay;
//
//    Result := ( ( nDayCount div 7 ) + 1 );

  end;

{ *************************************************************************** }
function kcDayOfYear( dDate : TDateTime ) : Integer;
//  var
//    X, nDayCount : Integer;
//    nMonth, nDay, nYear : Word;
  begin
    result := System.DateUtils.DayOfTheYear(dDate);
//
//
//    nDayCount := 0;
//
//    DecodeDate( dDate, nYear, nMonth, nDay );
//
//    For X := 1 to ( nMonth - 1 ) do
//      nDayCount := nDayCount + kcMonthDays( X, nYear );
//
//    Result := nDayCount + nDay;

  end;

{ *************************************************************************** }
function kcEaster( nYear : Integer ) : TDateTime;
  var
    nMonth, nDay, nMoon, nEpact, nSunday, nGold, nCent, nCorx, nCorz : Integer;
  begin

    { The Golden Number of the year in the 19 year Metonic Cycle }
    nGold := ( ( nYear mod 19 ) + 1 );

    { Calculate the Century }
    nCent := ( ( nYear div 100 ) + 1 );

    { No. of Years in which leap year was dropped in order to keep in step
      with the sun }
    nCorx := ( ( 3 * nCent ) div 4 - 12 );

    { Special Correction to Syncronize Easter with the moon's orbit }
    nCorz := ( ( 8 * nCent + 5 ) div 25 - 5 );

    { Find Sunday }
    nSunday := ( ( 5 * nYear ) div 4 - nCorx - 10 );

    { Set Epact (specifies occurance of full moon }
    nEpact := ( ( 11 * nGold + 20 + nCorz - nCorx ) mod 30 );

    if ( nEpact < 0 )
    then
      nEpact := nEpact + 30;

    if ( ( nEpact = 25 ) and ( nGold > 11 ) ) or ( nEpact = 24 )
    then
      nEpact := nEpact + 1;

    { Find Full Moon }
    nMoon := 44 - nEpact;

    if ( nMoon < 21 )
    then
      nMoon := nMoon + 30;

    { Advance to Sunday }
    nMoon := ( nMoon + 7 - ( ( nSunday + nMoon ) mod 7 ) );

    if ( nMoon > 31 )
    then
    begin
      nMonth := 4;
      nDay := ( nMoon - 31 );
    end
    else
    begin
      nMonth := 3;
      nDay := nMoon;
    end;

    Result := EncodeDate( nYear, nMonth, nDay );

  end;

{ *************************************************************************** }
function kcDayOfWeek( dDate : TDateTime ) : Integer;
  begin
    result := System.DateUtils.DayOfTheWeek(dDate);
//    MonthOf(dDate);
//    Result := Trunc( dDate ) mod 7 + 1;
  end;

{ *************************************************************************** }
function kcIncDate( dDate : TDateTime ) : TDateTime;
//  var
//    AYear, AMonth, ADay : Word;
  begin
    result := System.DateUtils.IncDay(dDate,1);

//    DecodeDate( dDate, AYear, AMonth, ADay );
//
//    if ( ( ADay + 1 ) > kcMonthDays( AMonth, AYear ) )
//    then
//    begin
//      if ( AMonth + 1 ) > 12
//      then
//      begin
//        AMonth := 1;
//        AYear := AYear + 1;
//      end
//      else
//        AMonth := AMonth + 1;
//
//      ADay := 1;
//    end
//    else
//      ADay := ADay + 1;
//
//    Result := EncodeDate( AYear, AMonth, ADay );
//
  end;

{ *************************************************************************** }
function kcDecdate( dDate : TDateTime ) : TDateTime;
//  var
//    AYear, AMonth, ADay : Word;
  begin
    result := System.DateUtils.IncDay(dDate,-1);
//
//    DecodeDate( dDate, AYear, AMonth, ADay );
//
//    if ( ADay = 1 )
//    then
//    begin
//      if ( AMonth - 1 ) < 1
//      then
//      begin
//        AMonth := 12;
//        AYear := AYear - 1;
//      end
//      else
//        AMonth := AMonth - 1;
//
//      ADay := kcMonthDays( AMonth, AYear );
//    end
//    else
//      ADay := ADay - 1;
//
//    Result := EncodeDate( AYear, AMonth, ADay );
//
  end;

{ *************************************************************************** }
function kcWorkDays( dStart, dEnd : TDateTime ) : Integer;
  var
    nWorkDays, nDays, nAdjust : Integer;
    nStartDow, nEndDow : Integer;
  begin

    nDays := 0;

    nStartDow := kcDayOfWeek( dStart );

    If ( nStartDow = 1 )
    then
      dStart := kcIncDate( dStart )
    else if ( nDays = 7 )
    then
    begin
      dStart := kcIncDate( dStart );
      dStart := kcIncDate( dStart );
    end;

    nEndDow := kcDayOfWeek( dEnd );

    If ( nEndDow = 1 )
    then
    begin
      dEnd := kcDecdate( dEnd );
      dEnd := kcDecdate( dEnd );
    end
    else if ( nEndDow = 7 )
    then
      dEnd := kcDecdate( dEnd );

    nDays := ( kcSubDates( dEnd, dStart ) + 1 );
    nAdjust := ( nDays mod 7 );

    if ( ( nEndDow + 1 ) < nStartDow )
    then
      nAdjust := nAdjust - 2;

    nWorkDays := ( ( nDays div 7 ) * 5 + nAdjust );
    Result := nWorkDays;

  end;

{ *************************************************************************** }
function kcSubDates( dMax, dMin : TDateTime ) : Integer;
  begin

    Result := Trunc( ( dMax - dMin ) );

  end;

{ *************************************************************************** }
function kcAddDates( dMin, dMax : TDateTime ) : Integer;
  begin

    Result := Trunc( ( dMax + dMin ) );

  end;

{ *************************************************************************** }
function kcIncDateBy(
  dDate  : TDateTime;
  nValue : Integer ) : TDateTime;
//  var
//    AYear, AMonth, ADay : Word;
//    APreMonth, APreYear : Word;
  begin
    result := System.DateUtils.IncDay(dDate,nValue);

//    DecodeDate( dDate, AYear, AMonth, ADay );
//    APreMonth := AMonth;
//    APreYear := AYear;
//
//    if ( ( ADay + nValue ) > kcMonthDays( AMonth, AYear ) )
//    then
//    begin
//      if ( AMonth + 1 ) > 12
//      then
//      begin
//        AMonth := 1;
//        AYear := AYear + 1;
//      end
//      else
//        AMonth := AMonth + 1;
//
//      ADay := ( 0 - ( kcMonthDays( APreMonth, APreYear ) - ADay ) );
//    end;
//
//    ADay := ADay + nValue;
//
//    Result := EncodeDate( AYear, AMonth, ADay );

  end;

{ *************************************************************************** }
function kcDecDateBy(
  dDate  : TDateTime;
  nValue : Integer ) : TDateTime;
//  var
//    AYear, AMonth, ADay : Word;
    // hint  APreMonth, APreYear: Word;
  begin
    result := System.DateUtils.IncDay(dDate,nValue);

//    DecodeDate( dDate, AYear, AMonth, ADay );
//
//    If ( ADay <= nValue )
//    then
//    begin
//      if AMonth = 1
//      then
//      begin
//        AMonth := 12;
//        AYear := AYear - 1;
//      end
//      else
//        AMonth := AMonth - 1;
//
//      ADay := ( kcMonthDays( AMonth, AYear ) + ADay );
//
//    end;
//
//    ADay := ADay - nValue;
//
//    Result := EncodeDate( AYear, AMonth, ADay );
//
  end;

end.
