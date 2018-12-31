{ *                                                                                * }
{ *  unit TheKing                                                                  * }
{ *  TKingCalendar Component                                                       * }
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

unit TheKing;

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
  Vcl.StdCtrls,
  Vcl.Grids;

type

  TDay = 1 .. 31;
  TMonth = 1 .. 12;
  TYear = 1600 .. 2999;
  TKingFlags = array [ 1 .. 31 ] of byte;
  TKingColors = array [ 1 .. 9 ] of TColor;

  TCellTextSize = array [ 1 .. 10 ] of String[ 30 ];
  TCellTextType = array [ 1 .. 10 ] of byte;
  TBlockedDays = array [ 1 .. 31 ] of Boolean;
  TCellTextCount = array [ 1 .. 31 ] of Integer;
  TKingCellText = array [ 1 .. 31 ] of TCellTextSize;
  TKingCellType = array [ 1 .. 31 ] of TCellTextType;

  { //\\ For 1.2 Test Code }
  TKingCellForeground = array [ 1 .. 31 ] of TColor;
  TKingCellBackground = array [ 1 .. 31 ] of TColor;

  TKingInfoBar = class( TObject )
    Color : TColor;
  end;
  { //\\ }

  TDaysInWeek = 0 .. 6;

  TColorarchy = ( kcaSetColor, kcaTodayColor );
  TKingText = ( ktCenter, ktLowerLeft, ktTopLeft, ktTopRight, ktLowerRight );
  TKingHooks = array [ 1 .. 20 ] of TNotifyEvent;

  TKingToday = record
    Year, Month, Day : Word;
  end;

  eDayChange = procedure(
    Sender : TObject;
    Day    : Integer ) of Object;
  eMonthChange = procedure(
    Sender : TObject;
    Month  : Integer ) of Object;
  eYearChange = procedure(
    Sender : TObject;
    Year   : Integer ) of Object;
  eDateChange = procedure(
    Sender  : TObject;
    NewDate : TDateTime ) of Object;
  eDroppedDay = procedure(
    Sender     : TObject;
    DroppedDay : Integer ) of Object;

  TGridDrawInfo = record
    EffectiveHorzLineWidth, EffectiveVertLineWidth : Integer;
    FixedBoundaryX, FixedBoundaryY : Integer;
    GridBoundaryX, GridBoundaryY : Integer;
    GridHeight, GridWidth : Integer;
    LastFullVisibleCol, LastFullVisibleRow : Longint;
    FullVisBoundaryX, FullVisBoundaryY : Integer;
  end;

  TGridCoord = record
    X : Longint;
    Y : Longint;
  end;

  { TKingColoring }
  TKingColoring = class( TPersistent )
    private
      FColorSet1 : TColor;
      FColorSet2 : TColor;
      FColorSet3 : TColor;
      FColorSet4 : TColor;
      FColorSet5 : TColor;
      FColorSet6 : TColor;
      FColorSet7 : TColor;
      FColorSet8 : TColor;
      FColorSet9 : TColor;
    protected
    public
    published
      property ColorSet1 : TColor
        read FColorSet1
        write FColorSet1;
      property ColorSet2 : TColor
        read FColorSet2
        write FColorSet2;
      property ColorSet3 : TColor
        read FColorSet3
        write FColorSet3;
      property ColorSet4 : TColor
        read FColorSet4
        write FColorSet4;
      property ColorSet5 : TColor
        read FColorSet5
        write FColorSet5;
      property ColorSet6 : TColor
        read FColorSet6
        write FColorSet6;
      property ColorSet7 : TColor
        read FColorSet7
        write FColorSet7;
      property ColorSet8 : TColor
        read FColorSet8
        write FColorSet8;
      property ColorSet9 : TColor
        read FColorSet9
        write FColorSet9;
  end;

  { TKingCalendar }
  TKingCalendar = class( TCustomGrid { TKingCustomGrid } )
    private
      { //\\ 1.2 Code }
      FCellBackground : TKingCellBackground;
      FCellForeground : TKingCellForeground;
      FCalendarObjects : TStrings;
      FMaxBarSize : Integer;
      FMinBarSize : Integer;
      FShowBars : Boolean;
      { //\\ }
      FSuspendPaint : Boolean;
      FBlockWeekends : Boolean;
      FBlockedDays : TBlockedDays;
      FBlockedBkgnd : TColor;
      FBlockedFrgnd : TColor;
      FColorCellText : Boolean;
      FColorCellDay : Boolean;
      FFixedHeader : Boolean;
      FFixedSize : Integer;
      FKingTextCount : TCellTextCount;
      FKingText : TKingCellText;
      FKingTypes : TKingCellType;
      FShowText : Boolean;
      FStartofWeek : TDaysInWeek;
      FMonthOffset : Integer;
      FKingColors : TKingColoring;
      FTodayColor : TColor;
      FOnClick : TNotifyEvent;
      FHookEvent : TNotifyEvent;
      FHookCount : Integer;
      FHooks : TKingHooks;
      FMonthChange : eMonthChange;
      FYearChange : eYearChange;
      FDayChange : eDayChange;
      FDateChange : eDateChange;
      FFlaggedDay : TNotifyEvent;
      FAbout : String;
      FCellColor : TColor;
      FGridLineColor : TColor;
      FHotSpots : TKingFlags;
      FAnchor : TGridCoord;
      // hint    FTopLeft: TGridCoord;
      FActive : Boolean; { Draw the Highlighted Cell? }
      FDate : TDateTime;
      FCurrent : TGridCoord;
      FOnChange : TNotifyEvent;
      FHighlight : TColor; { Color for Highlighted Cell }
      FHighlightText : TColor; { Color for Highligted Cell Font }
      FEditorMode : Boolean;
      FGridLines : Boolean; { Draw Gridlines? }
      FTitleColor : TColor;
      FTextPlacement : TKingText;
      FColorarchy : TColorarchy;
      FDowNames : TStrings;
      FOnDroppedCell : eDroppedDay;
      FUpdating : Boolean;
      FTextFont : TFont;
      FTitleFont : TFont;
      procedure CalcDrawInfo( var DrawInfo : TGridDrawInfo );
      procedure CalcDrawInfoXY(
        var DrawInfo        : TGridDrawInfo;
        UseWidth, UseHeight : Integer );
      procedure CalcFixedInfo( var DrawInfo : TGridDrawInfo );
      procedure SetGridLines( Value : Boolean );
      procedure SetForeground( oColor : TColor );
      procedure SetBackground( oColor : TColor );
      procedure SetCalendarActive( Value : Boolean );
      procedure SetTodayColor( Value : TColor );
      function CalcCoordFromPoint(
        X, Y           : Integer;
        const DrawInfo : TGridDrawInfo ) : TGridCoord;
      procedure WMLButtonDown( var Message : TMessage ); message WM_LBUTTONDOWN;
      procedure WMEraseBkgnd( var Message : TMessage ); message WM_ERASEBKGND;
      procedure SetTitleColor( Value : TColor );
      procedure ClearBlockedDays;
      { //\\ 1.2 }
      procedure ClearColorBars;
      { //\\ }
      function GetSelection : TGridRect;
      procedure GridRectToScreenRect(
        GridRect       : TGridRect;
        var ScreenRect : TRect;
        IncludeLine    : Boolean );
    protected
      procedure Change;
      procedure Click; override;
      function IsLeapYear( nYear : Integer ) : Boolean;
      function LeapYear : Boolean;
      function GetDateElement( Index : Integer ) : Integer;
      procedure SetDateElement(
        Index : Integer;
        Value : Integer );
      function GetCellText( Row, Column : Integer ) : string;
      procedure DrawCell(
        ACol, ARow : Longint;
        ARect      : TRect;
        AState     : TGridDrawState ); override;
      procedure Paint; override;
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure Loaded; override;
      procedure NotifyLinks;
      procedure SetCellColor( Value : TColor );
      procedure SetGridLineColor( Value : TColor );
      procedure SetTextPlacement( Value : TKingText );
      procedure SetDowNames( Value : TStrings );
      procedure SetHookEvent( Value : TNotifyEvent );
      procedure KeyDown(
        var Key : Word;
        Shift   : TShiftState ); override;
      procedure SetStartOfWeek( nStart : TDaysInWeek );
      function SelectCell( ACol, ARow : Longint ) : Boolean; override;
      procedure SetCalDate( Value : TDateTime );
      procedure SetBlockBack( Value : TColor );
      procedure SetBlockFore( Value : TColor );
    public
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      property CellText[ Row, Column : Integer ] : string
        read GetCellText;
      property CalendarDate : TDateTime
        read FDate
        write SetCalDate;
      function DaysThisMonth : Integer;
      function DaysInMonth( nMonth, nYear : Integer ) : Integer;
      procedure NextMonth;
      procedure PrevMonth;
      procedure NextYear;
      procedure PrevYear;
      procedure NextDay;
      procedure PrevDay;
      procedure Today;
      procedure AcceptDropped(
        X, Y, Value : Integer;
        Text        : String );
      procedure SetDateFlag(
        nDay, Flag : Integer;
        Text       : String );
      procedure SetDateText(
        nDay : Integer;
        Text : String );
      procedure ClearDay( nDay : Integer );
      procedure SetMonthFlags( Value : TKingFlags );
      function GetDateFlag( Value : Integer ) : Integer;
      function GetMonthFlags : TKingFlags;
      procedure UpdateCalendar;
      procedure ClearAllDays;
      property HookEvent : TNotifyEvent
        write SetHookEvent;
      function GetApptLevel : Integer;
      function GetKingColor( Value : Integer ) : TColor;
      procedure SetShowText( Value : Boolean );
      procedure SetTextFont( Value : TFont );
      procedure SetTitleFont( Value : TFont );
      procedure SetFixedHeader( Value : Boolean );
      procedure SetFixedSize( Value : Integer );
      procedure SetUseCellColor( Value : Boolean );
      procedure SetUseDayColor( Value : Boolean );
      procedure SetBlockWeekend( Value : Boolean );
      procedure SetDateRangeBlock( nStart, nEnd : Integer );
      procedure SetDayBlock( nDay : Integer );
      function GetDayBlock( nDay : Integer ) : Boolean;
      procedure SetSuspendUpdate( Value : Boolean );
      { //\\ 1.2 Code }
      procedure ClearDateRange( nBack, nFore : TColor );
      procedure ColorDateRange(
        nStart, nEnd : Integer;
        nBack, nFore : TColor );
      procedure FillForeground( Value : TColor );
      procedure FillBackground( Value : TColor );
      procedure AddColorBar(
        nDay   : Integer;
        nColor : TColor );
      procedure MakeBarFromRange(
        nStart, nEnd : Integer;
        nColor       : TColor );
      procedure RePaint; reintroduce; virtual; // Resolve hint
      procedure SetColorBars( Value : Boolean );
      { //\\ }
    published
      property Align;
      property BorderStyle;
      property Ctl3D;
      property Day : Integer
        index 3
        read GetDateElement
        write SetDateElement;
      property Font;
      property Month : Integer
        index 2
        read GetDateElement
        write SetDateElement;
      property ParentColor;
      property ParentFont;
      property Year : Integer
        index 1
        read GetDateElement
        write SetDateElement;
      property OnClick : TNotifyEvent
        read FOnClick
        write FOnClick;
      property OnMonthChange : eMonthChange
        read FMonthChange
        write FMonthChange;
      property OnYearChange : eYearChange
        read FYearChange
        write FYearChange;
      property OnDayChange : eDayChange
        read FDayChange
        write FDayChange;
      property OnDateChange : eDateChange
        read FDateChange
        write FDateChange;
      property OnChange : TNotifyEvent
        read FOnChange
        write FOnChange;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property Highlight : TColor
        read FHighlight
        write SetBackground
        default clHighlight;
      property HighlightText : TColor
        read FHighlightText
        write SetForeground
        default clHighlightText;
      property ShowGridLines : Boolean
        read FGridLines
        write SetGridLines
        default True;
      property IsActive : Boolean
        read FActive
        write SetCalendarActive
        default True;
      property About : String
        read FAbout
        write FAbout;
      property TitleColor : TColor
        read FTitleColor
        write SetTitleColor
        default clSilver;
      property CellColor : TColor
        read FCellColor
        write SetCellColor
        default clWhite;
      property GridLineColor : TColor
        read FGridLineColor
        write SetGridLineColor
        default clGray;
      property TabOrder;
      property TabStop;
      property TextPlacement : TKingText
        read FTextPlacement
        write SetTextPlacement
        default ktCenter;
      property ColorOrder : TColorarchy
        read FColorarchy
        write FColorarchy
        default kcaSetColor;
      property DowNames : TStrings
        read FDowNames
        write SetDowNames;
      property OnDroppedCell : eDroppedDay
        read FOnDroppedCell
        write FOnDroppedCell;
      property OnDayFlag : TNotifyEvent
        read FFlaggedDay
        write FFlaggedDay;
      property TodayColor : TColor
        read FTodayColor
        write SetTodayColor
        default clBlack;
      property ColorSets : TKingColoring
        read FKingColors
        write FKingColors;
      property StartingDay : TDaysInWeek
        read FStartofWeek
        write SetStartOfWeek;
      property TextInCell : Boolean
        read FShowText
        write SetShowText
        default False;
      property TextFont : TFont
        read FTextFont
        write SetTextFont;
      property TitleFont : TFont
        read FTitleFont
        write SetTitleFont;
      property HeaderUseFixed : Boolean
        read FFixedHeader
        write SetFixedHeader
        default True;
      property ColorCellText : Boolean
        read FColorCellText
        write SetUseCellColor
        default False;
      property ColorCellDay : Boolean
        read FColorCellDay
        write SetUseDayColor
        default True;
      property BlockedBkGnd : TColor
        read FBlockedBkgnd
        write SetBlockBack
        default clSilver;
      property BlockedFrGnd : TColor
        read FBlockedFrgnd
        write SetBlockFore
        default clGray;
      property BlockWeekends : Boolean
        read FBlockWeekends
        write SetBlockWeekend
        default False;
      property SuspendUpdate : Boolean
        read FSuspendPaint
        write SetSuspendUpdate
        default False;
      property Visible;
      { //\\ 1.2 }
      {
        property MaxBarSize: Integer read FMaxBarSize write FMaxBarSize;
        property MinBarSize: Integer read FMinBarSize write FMinBarSize;
      }
      property ShowColorBars : Boolean
        read FShowBars
        write SetColorBars
        default False;
      { //\\ }
  end;

implementation


{ //\\ 1.2 }
{ **************************************************************************** }
function min( nOne, nTwo : Longint ) : Longint;
  begin
    if nOne < nTwo
    then
      Result := nOne
    else
      Result := nTwo;
  end;

{ **************************************************************************** }
function max( nOne, nTwo : Longint ) : Longint;
  begin
    if nOne > nTwo
    then
      Result := nOne
    else
      Result := nTwo;
  end;
{ //\\ }

{ **************************************************************************** }
function PointInGridRect(
  Col, Row   : Longint;
  const Rect : TGridRect ) : Boolean;
  begin
    Result := ( Col >= Rect.Left ) and ( Col <= Rect.Right ) and
      ( Row >= Rect.Top ) and ( Row <= Rect.Bottom );
  end;

{ **************************************************************************** }
constructor TKingCalendar.Create( AOwner : TComponent );
  var
    X, Y : Integer;
  begin
    inherited Create( AOwner );

    FKingColors := TKingColoring.Create;
    FKingColors.ColorSet1 := clPurple;
    FKingColors.ColorSet2 := clBlue;
    FKingColors.ColorSet3 := clAqua;
    FKingColors.ColorSet4 := clGreen;
    FKingColors.ColorSet5 := clLime;
    FKingColors.ColorSet6 := clOlive;
    FKingColors.ColorSet7 := clYellow;
    FKingColors.ColorSet8 := clMaroon;
    FKingColors.ColorSet9 := clRed;

    { defaults }
    FixedCols := 0;
    FixedRows := 1;
    ColCount := 7;
    RowCount := 7;
    ScrollBars := ssNone;
    FDate := Date;
    Options := Options - [ goRangeSelect ] + [ goDrawFocusSelected ];
    FHighlight := clHighlight;
    FHighlightText := clHighlightText;
    Width := 317;
    Height := 121;
    FGridLines := True;
    FActive := True;
    FTitleColor := clSilver;
    FCellColor := clWhite;
    FGridLineColor := clGray;
    FTextPlacement := ktTopLeft;
    FBlockedFrgnd := clGray;
    FBlockedBkgnd := clSilver;
    FBlockWeekends := False;
    ClearAllDays; { Empty the HotSpot Array to all Flags = 0 }

    FHookCount := 0;
    FTodayColor := clBlack;

    FDowNames := TStringList.Create;

    for X := 1 to 7 do
      FDowNames.Add( FormatSettings.ShortDayNames[ X ] );

    for X := 1 to 31 do
      for Y := 1 to 10 do
        FKingText[ X ][ Y ] := '';

    for X := 1 to 31 do
    begin
      FKingTextCount[ X ] := 0;
      FBlockedDays[ X ] := False;
    end;

    UpdateCalendar;

    FShowText := False;
    FTextFont := TFont.Create;
    FTitleFont := TFont.Create;
    FFixedHeader := True;
    FFixedSize := FTitleFont.Size + 4;
    FColorCellText := False;
    FColorCellDay := True;

    FSuspendPaint := False;

    { //\\ 1.2 Code }
    FillForeground( clBlack );
    FillBackground( FCellColor );
    FCalendarObjects := TStringList.Create;
    FMaxBarSize := 10;
    FMinBarSize := 1;
    FShowBars := False;
    { //\\ End 1.2 }

    self.Font.Name := 'Segoe UI';
    self.FTextFont.Name := 'Segoe UI';
    self.FTitleFont.Name := 'Segoe UI';


  end;

{ **************************************************************************** }
destructor TKingCalendar.Destroy;
  var
    X : Integer;
  begin
    FreeAndNil( FDowNames ); // .Free;
    FreeAndNil( FTextFont ); // .Free;
    FreeAndNil( FTitleFont ); // .Free;
    FreeAndNil( FKingColors );
    // .Free;  // Lance added 0714/2006.  Memory Leak report

    { //\\ 1.2 Code }
    for X := ( FCalendarObjects.Count - 1 ) downto 0 do
    begin
      TObject( FCalendarObjects.Objects[ X ] ).Free;
      FCalendarObjects.Delete( X );
    end;
    { //\\ }
    FreeAndNil( FCalendarObjects );
    inherited Destroy;
  end;

{ **************************************************************************** }
procedure TKingCalendar.Loaded;
  var
    AYear, AMonth, ADay : Word;
  begin
    inherited Loaded;

    DecodeDate( Date, AYear, AMonth, ADay );

    FDate := Date;

    SetDateElement( 5, 1 );
    { Invalidate; }

  end;

{ **************************************************************************** }
procedure TKingCalendar.Change;
  var
    X : Integer;
  begin
    if Assigned( FOnChange )
    then
      FOnChange( Self );

    if FHookCount > 0
    then
      for X := 1 to FHookCount do
      begin
        FHookEvent := FHooks[ X ];
        FHookEvent( Self );
      end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.Click;
  var
    TheCellText : string;
  begin

    inherited Click;

    TheCellText := CellText[ Row, Col ];

    if ( TheCellText <> '' ) and IsActive
    then
      Day := StrToInt( TheCellText );

    if not ( csLoading in ComponentState )
    then
    begin
      if Assigned( FFlaggedDay ) and ( FHotSpots[ Day ] > 0 )
      then
        FFlaggedDay( Self );
      if Assigned( FOnClick )
      then
        FOnClick( Self );
    end;

  end;

{ **************************************************************************** }
function TKingCalendar.DaysThisMonth : Integer;
  const
    DaysPerMonth : array [ TMonth ] of Integer = ( 31, 28, 31, 30, 31, 30, 31,
      31, 30, 31, 30, 31 );
  begin
    Result := DaysInMonth( Month, Year );
  end;

{ **************************************************************************** }
function TKingCalendar.DaysInMonth( nMonth, nYear : Integer ) : Integer;
  // const
  // DaysPerMonth : array [ TMonth ] of Integer = ( 31, 28, 31, 30, 31, 30, 31,
  // 31, 30, 31, 30, 31 );
  // Note - Use Delphi's built in routine

  begin
    // Result :=  DaysPerMonth[ nMonth ];
    Result := DaysinAMonth( nYear, nMonth );
    // if ( Month = 2 ) and IsLeapYear( nYear )
    // then
    // Inc( Result ); { leap-year Feb is special }
  end;

{ **************************************************************************** }
procedure TKingCalendar.DrawCell(
  ACol, ARow : Longint;
  ARect      : TRect;
  AState     : TGridDrawState );
  var
    TheText : string;
    nText, X : Integer;
    AYear, AMonth, ADay : Word;
    nLines, nHeight, nStart : Integer;
    OldFont : TFont;
    TempColor : TColor;
    { //\\ 1.2 }
    bRect : TRect;
    aBars : Array [ 1 .. 10 ] of TColor;
    nCounter, nBarSize, nBottom : Integer;
    { //\\ 1.2 }
  begin
    nText := 0;
    TempColor := Canvas.Brush.Color;

    TheText := CellText[ ARow, ACol ];
    DecodeDate( Date, AYear, AMonth, ADay );

    if ARow > 0
    then
      if not ( TheText = '' )
      then
        nText := StrToInt( TheText );

    { The following comment is for v1.1a only }
    { if not ( nText = Day ) then }
    if ( nText > 0 ) and ( nText <= 31 )
    then
      if FColorCellDay
      then
      begin
        if not ( gdFocused in AState )
        then
          Canvas.Font.Color := GetKingColor( FHotSpots[ nText ] );
        if ( nText = ADay ) and ( AMonth = Month ) and ( AYear = Year ) and
          not ( gdFocused in AState ) and not ( csDesigning in ComponentState )
        then
          if ( FColorarchy = kcaTodayColor )
          then
            Canvas.Font.Color := FTodayColor
          else
            Canvas.Font.Color := GetKingColor( FHotSpots[ nText ] );
      end;
    if ( ARow > 0 ) and not ( TheText = '' )
    then
    begin

      { //\\! 1.2 Code }
      if ( FCellForeground[ nText ] <> clBlack ) and not ( gdFocused in AState )
      then
        Canvas.Font.Color := FCellForeground[ nText ];
      { //\\ }

      if FBlockedDays[ nText ]
      then
        Canvas.Font.Color := FBlockedFrgnd;

    end;

    with ARect, Canvas do
    begin

      if ( FTextPlacement = ktCenter ) or ( ARow = 0 )
      then
        if ( ARow = 0 )
        then
          TextRect( ARect, Left + ( Right - Left - TextWidth( TheText ) ) div 2,
            Top + ( Bottom - Top - TextHeight( TheText ) ) div 2, TheText )
        else
          TextOut( Left + ( Right - Left - TextWidth( TheText ) ) div 2,
            Top + ( Bottom - Top - TextHeight( TheText ) ) div 2, TheText )
      else if ( FTextPlacement = ktTopLeft )
      then
        TextRect( ARect, ( Left + 1 ), ( Top + 1 ), TheText )
      else if ( FTextPlacement = ktTopRight )
      then
        TextRect( ARect, ( Right - TextWidth( TheText ) - 2 ),
          ( Top + 1 ), TheText )
      else if ( FTextPlacement = ktLowerLeft )
      then
        TextRect( ARect, ( Left + 1 ),
          ( Bottom - TextHeight( TheText ) - 1 ), TheText )
      else if ( FTextPlacement = ktLowerRight )
      then
        TextRect( ARect, ( Right - TextWidth( TheText ) - 2 ),
          ( Bottom - TextHeight( TheText ) - 1 ), TheText );

      // hint	  nWidth  := ( Left + ( TextWidth( TheText ) + 2 ) );

      nStart := TextHeight( TheText ) + 1;
      OldFont := TFont.Create;
      OldFont.Assign( Font );
      Font.Assign( FTextFont );
      nHeight := TextHeight( TheText );

      iF ( ARow > 0 ) and TextInCell and not ( TheText = '' )
      then
      begin
        nLines := ( ( Bottom - ( Top + nStart ) ) div nHeight );
        for X := 1 to nLines do
        begin
          if FColorCellText
          then
            Font.Color := GetKingColor( FKingTypes[ nText ][ X ] );

          TextOut( ( Left + 2 ), ( ( Top + nStart ) + ( X * nHeight ) -
            nHeight ), String( FKingText[ nText ][ X ] ) );
        end;
        Font.Assign( OldFont );
        FreeAndNil( OldFont ); // .Free;
      end;

      { //\\ 1.2 }
      { Colorbar Code }
      if FShowBars
      then
      begin
        nCounter := 0;

        { Walk through the Calendar Objects and find stuff for Today }
        if FCalendarObjects.Count >= 1
        then
        begin
          for X := 0 to ( FCalendarObjects.Count - 1 ) do
            if FCalendarObjects[ X ] = ( 'CB' + TheText )
            then
            begin
              if nCounter < 10
              then
              begin
                Inc( nCounter );
                aBars[ nCounter ] :=
                  TKingInfoBar( FCalendarObjects.Objects[ X ] ).Color;
              end;
            end;

          { Calc the Rect of the are we can draw bars in }
          bRect.Top := ARect.Top + TextHeight( TheText );
          bRect.Left := ARect.Left + 1;
          bRect.Right := ARect.Right - 1;
          bRect.Bottom := ARect.Bottom - 1;

          if nCounter > 0
          then
          begin
            { Calc the size of the bar based on # of bars and Height of Rect }
            nBarSize := trunc( ( bRect.Bottom - bRect.Top ) div nCounter );
            { Make sure we do not exceed the MaxBar size }
            nBarSize := min( nBarSize, FMaxBarSize );
            { Make sure the bar is not to small }
            if nBarSize < FMinBarSize
            then
              nBarSize := FMinBarSize;

            { Draw them darn bars }
            nBottom := bRect.Bottom;
            for X := 0 to ( nCounter - 1 ) do
            begin
              bRect.Bottom := nBottom - ( X * nBarSize ) - 1;
              bRect.Top := bRect.Bottom - nBarSize;
              Brush.Color := aBars[ ( X + 1 ) ];
              FillRect( bRect );
            end;

          end;
        end;
      end;
      { //\\ }

    end;

    if Assigned( OldFont )
    then
      FreeAndNil( OldFont ); // .Free;
    Canvas.Brush.Color := TempColor;

  end;

{ **************************************************************************** }
function TKingCalendar.LeapYear : Boolean;
  begin
    Result := IsLeapYear( Year );
  end;

{ **************************************************************************** }
function TKingCalendar.IsLeapYear( nYear : Integer ) : Boolean;
  begin
    Result := IsLeapYear( nYear );

    // Use Delphi's built in check

    // Result := ( nYear mod 4 = 0 ) and
    // ( ( nYear mod 100 <> 0 ) or ( nYear mod 400 = 0 ) );
  end;

{ **************************************************************************** }
function TKingCalendar.GetCellText( Row, Column : Integer ) : string;
  var
    DayNum : Integer;
  begin
    if Row = 0
    then
    begin
      Result := FDowNames.Strings[ ( StartingDay + Column ) mod 7 ];
    end
    else
    begin
      DayNum := FMonthOffset + Column + ( Row - 1 ) * 7;
      if ( DayNum < 1 ) or ( DayNum > DaysThisMonth )
      then
        Result := ''
      else
        Result := IntToStr( DayNum );
    end;
  end;

{ **************************************************************************** }
function TKingCalendar.GetDateElement( Index : Integer ) : Integer;
  var
    AYear, AMonth, ADay : Word;
  begin
    DecodeDate( FDate, AYear, AMonth, ADay );
    case Index of
      1 :
        Result := AYear;
      2 :
        Result := AMonth;
      3 :
        Result := ADay;
      else
        Result := - 1;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetDateElement(
  Index : Integer;
  Value : Integer );
  var
    AYear, AMonth, ADay : Word;
    nFire : Integer;
    // hint	nRow, nCol: Integer;

  begin
    nFire := 0;

    if Value > 0
    then
    begin
      DecodeDate( FDate, AYear, AMonth, ADay );

      case Index of
        1 :
          begin

            If not ( AYear = Value )
            then
              ClearBlockedDays;

            AYear := Value;
            nFire := 1;
          end;
        2 :
          if AMonth <= 12
          then
          begin

            If not ( AMonth = Value )
            then
            begin
              ClearBlockedDays;
              { //\\ 1.2 Code }
              ClearDateRange( FCellColor, clBlack );
              ClearColorBars;
              { //\\ }
            end;

            AMonth := Value;
            nFire := 2;
          end
          else
            Exit;
        3 :
          if ADay <= DaysThisMonth
          then
          begin
            ADay := Value;
            nFire := 3;
          end
          else
            Exit;
        4 :
          nFire := 4;
        5 :
        else
          Exit;
      end;

      if DaysInMonth( AMonth, AYear ) < ADay
      then
        ADay := DaysInMonth( AMonth, AYear );

      FDate := EncodeDate( AYear, AMonth, ADay );

      if not ( nFire = 3 )
      then
      begin
        SetBlockWeekend( FBlockWeekends );
        UpdateCalendar;
      end;

      if not ( csLoading in ComponentState )
      then
        case nFire of
          1 :
            begin
              if Assigned( FYearChange )
              then
                FYearChange( Self, AYear );
              if Assigned( FDateChange )
              then
                FDateChange( Self, FDate );
            end;
          2 :
            begin
              if Assigned( FMonthChange )
              then
              begin
                if AMonth > 12
                then
                begin
                  AMonth := AMonth mod 12;
                end;
                FMonthChange( Self, AMonth );
              end;
              if Assigned( FDateChange )
              then
                FDateChange( Self, FDate );
            end;
          3 :
            begin
              if Assigned( FDayChange )
              then
                FDayChange( Self, ADay );
              if Assigned( FDateChange )
              then
                FDateChange( Self, FDate );
            end;
          4 :
            begin
              if Assigned( FDateChange )
              then
                FDateChange( Self, FDate );
            end;
        end;

      if not ( csLoading in ComponentState )
      then
        Change;

    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.NextMonth;
  begin

    if Month < 12
    then
      Month := succ( Month )
    else
    begin
      Year := Year + 1;
      Month := 1;
    end;

  end;

{ **************************************************************************** }
procedure TKingCalendar.NextDay;
  begin

    if Day < DaysThisMonth
    then
    begin
      Day := succ( Day );
      UpdateCalendar;
      SetBlockWeekend( FBlockWeekends );
    end
    else
    begin
      NextMonth;
      Day := 1;
    end;

  end;

{ **************************************************************************** }
procedure TKingCalendar.PrevMonth;
  begin

    if Month > 1
    then
      Month := pred( Month )
    else
    begin
      Year := Year - 1;
      Month := 12;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.PrevDay;
  begin

    if Day > 1
    then
    begin
      Day := pred( Day );
      UpdateCalendar;
      SetBlockWeekend( FBlockWeekends );
    end
    else
    begin
      PrevMonth;
      Day := DaysThisMonth;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.NextYear;
  begin

    Year := Year + 1;

  end;

{ **************************************************************************** }
procedure TKingCalendar.PrevYear;
  begin

    Year := Year - 1;

  end;

{ **************************************************************************** }
procedure TKingCalendar.WMSize( var Message : TWMSize );
  var
    GridLines : Integer;
  begin
    GridLines := 6 * GridLineWidth;

    { The following code will resize the canvas to exactly hold the Calendar.
      This prevents that blank space that can appear on the bottom and right
      sides of the calendar when sizing it in Design mode.

      A little convoluted? Maybe but it works, and it's fast! }

    DefaultColWidth := ( Message.Width - GridLines ) div 7;

    FFixedSize := FTitleFont.Size + 4;

    if FFixedHeader
    then
    begin

      DefaultRowHeight := ( ( Message.Height - FFixedSize ) - GridLines ) div 6;
      RowHeights[ 0 ] := FFixedSize;
    end
    else
    begin
      DefaultRowHeight := ( Message.Height - GridLines ) div 7;
    end;

  end;

{ **************************************************************************** }
procedure TKingCalendar.Paint;
  var
    DrawInfo : TGridDrawInfo;
    Sel : TGridRect;
    // hint  I: Integer;
    UpdateRect, FocRect : TRect;
    LineColor : TColor;
    procedure DrawLines(
      Horz, Vert                   : Boolean;
      Col, Row                     : Longint;
      StartX, StartY, StopX, StopY : Integer;
      OnColor, OffColor            : TColor );
      // hint  var
      // hint	  Line: Integer;

        procedure DrawHorz;
          var
            Line : Integer;
            ACol : Longint;
          begin
            with Canvas, DrawInfo do
            begin
              if EffectiveHorzLineWidth <> 0
              then
              begin
                ACol := Col;
                if Horz
                then
                  Pen.Color := OnColor
                else
                  Pen.Color := OffColor;
                Line := StartX + DrawInfo.EffectiveHorzLineWidth shr 1 +
                  ColWidths[ ACol ];
                repeat
                  MoveTo( Line, StartY );
                  LineTo( Line, StopY );
                  Inc( ACol );
                  Inc( Line, ColWidths[ ACol ] +
                    DrawInfo.EffectiveHorzLineWidth );
                until Line > StopX;
              end;
            end;
          end;

        procedure DrawVert;
          var
            Line : Integer;
            ARow : Longint;
          begin
            with Canvas, DrawInfo do
            begin
              if EffectiveVertLineWidth <> 0
              then
              begin
                ARow := Row;
                if ( ARow = 2 ) and ( StartX = ( TitleFont.Size + 4 ) )
                then
                  Dec( ARow );

                if Vert
                then
                  Pen.Color := OnColor
                else
                  Pen.Color := OffColor;
                Line := StartY + DrawInfo.EffectiveVertLineWidth shr 1 +
                  RowHeights[ ARow ];
                repeat
                  MoveTo( StartX, Line );
                  LineTo( StopX, Line );
                  Inc( ARow );
                  Inc( Line, RowHeights[ ARow ] +
                    DrawInfo.EffectiveVertLineWidth );
                until Line > StopY;
              end;
            end;
          end;

      begin
        with DrawInfo do
        begin
          if ( EffectiveHorzLineWidth = 0 ) and ( EffectiveVertLineWidth = 0 )
            or ( StartX = StopX ) or ( StartY = StopY )
          then
            Exit;
          Canvas.Pen.Width := DrawInfo.EffectiveHorzLineWidth;
          if not Horz
          then
          begin
            DrawHorz;
            DrawVert;
          end
          else
          begin
            DrawVert;
            DrawHorz;
          end;
        end;
      end;

    procedure DrawCells(
      ACol, ARow                   : Longint;
      StartX, StartY, StopX, StopY : Integer;
      Color                        : TColor;
      IncludeDrawState             : TGridDrawState );
      var
        CurCol, CurRow : Longint;
        Where : TRect;
        DrawState : TGridDrawState;
        Focused : Boolean;
        TheText : String;
        nText : Integer;
      begin
        CurRow := ARow;
        Where.Top := StartY;
        while Where.Top < StopY do
        begin
          CurCol := ACol;
          Where.Left := StartX;
          Where.Bottom := Where.Top + RowHeights[ CurRow ];
          while Where.Left < StopX do
          begin
            Where.Right := Where.Left + ColWidths[ CurCol ];
            if RectVisible( Canvas.Handle, Where )
            then
            begin
              DrawState := IncludeDrawState;
              Focused := ValidParentForm( Self ).ActiveControl = Self;
              if Focused and ( CurRow = Row ) and ( CurCol = Col )
              then
                Include( DrawState, gdFocused );
              if PointInGridRect( CurCol, CurRow, Sel )
              then
                Include( DrawState, gdSelected );
              if not ( gdFocused in DrawState ) or not ( goEditing in Options )
                or not FEditorMode or ( csDesigning in ComponentState )
              then
              begin
                if DefaultDrawing or ( csDesigning in ComponentState )
                then
                  with Canvas do
                  begin
                    IF ( ARow = 0 )
                    then
                      Font := FTitleFont
                    else
                      Font := Self.Font;
                    if ( gdSelected in DrawState ) and
                      ( not ( gdFocused in DrawState ) or
                      ( goDrawFocusSelected in Options ) )
                    then
                    begin
                      if ( not FActive )
                      then
                      begin
                        Brush.Color := Color;
                        if ( FColorarchy = kcaSetColor )
                        then
                          Font.Color :=
                            GetKingColor
                            ( FHotSpots[ StrToInt( CellText[ CurRow,
                            CurCol ] ) ] )
                        else
                          Font.Color := TodayColor;
                      end
                      else
                      begin
                        Brush.Color := FHighlight;
                        Font.Color := FHighlightText;
                      end
                    end
                    else
                    begin
                      TheText := CellText[ CurRow, CurCol ];
                      if ( CurRow > 0 ) and not ( TheText = '' )
                      then
                      begin
                        nText := StrToInt( TheText );

                        if FBlockedDays[ nText ]
                        then
                          Brush.Color := FBlockedBkgnd
                        else
                          { //\ 1.2 Code }
                          if FCellBackground[ nText ] <> Color
                          then
                            Brush.Color := FCellBackground[ nText ]
                            { //\\ }
                          else
                            Brush.Color := Color;
                      end
                      else
                        Brush.Color := Color;

                    end;

                    FillRect( Where );

                  end;

                DrawCell( CurCol, CurRow, Where, DrawState );
                if DefaultDrawing and ( gdFixed in DrawState ) and Ctl3D
                then
                  with Canvas do
                  begin
                    Pen.Color := clWhite;
                    Polyline( [ Point( Where.Left, Where.Bottom ),
                      Where.TopLeft, Point( Where.Right, Where.Top ) ] );
                  end;
                if DefaultDrawing and not ( csDesigning in ComponentState ) and
                  ( gdFocused in DrawState ) and not ( goEditing in Options )
                  and FActive
                then
                begin
                  Canvas.DrawFocusRect( Where );
                end;
              end;
            end;
            Where.Left := Where.Right + DrawInfo.EffectiveHorzLineWidth;
            Inc( CurCol );
          end;
          Where.Top := Where.Bottom + DrawInfo.EffectiveVertLineWidth;
          Inc( CurRow );
        end;
      end;

  begin
    GetClipBox( Canvas.Handle, UpdateRect );
    CalcDrawInfo( DrawInfo );

    with DrawInfo do
    begin
      { Draw the grid line in the four areas (fixed, fixed), (variable, fixed),
        (fixed, variable) and (variable, variable) }
      // hint	  LineColor := clSilver;
      // hint	  if ColorToRGB(Color) = clSilver then LineColor := clGray;
      DrawLines( goFixedHorzLine in Options, goFixedVertLine in Options, 0, 0,
        0, 0, FixedBoundaryX, FixedBoundaryY, clBlack, FixedColor );
      DrawLines( goFixedHorzLine in Options, goFixedVertLine in Options,
        LeftCol, 0, FixedBoundaryX, 0, GridBoundaryX, FixedBoundaryY, clBlack,
        FixedColor );

      { The following IF..ELSE block simple redraws the gridlines in a nonvisable
        color. This was how I faked out the IDE }

      if FGridLines
      then
        LineColor := GridLineColor { Should be user defineable in future }
      else
        LineColor := CellColor; { Should be user defineable in future }

      DrawLines( goFixedHorzLine in Options, goFixedVertLine in Options, 0,
        TopRow, 0, FixedBoundaryY, FixedBoundaryX, GridBoundaryY, clBlack,
        FixedColor );
      DrawLines( goHorzLine in Options, goVertLine in Options, LeftCol, TopRow,
        FixedBoundaryX, FixedBoundaryY, GridBoundaryX, GridBoundaryY,
        LineColor, Color );

      { Draw the cells in the four areas }
      Sel := Selection;
      DrawCells( 0, 0, 0, 0, FixedBoundaryX, FixedBoundaryY, FixedColor,
        [ gdFixed ] );
      DrawCells( LeftCol, 0, FixedBoundaryX, 0, GridBoundaryX, FixedBoundaryY,
        FixedColor, [ gdFixed ] );
      DrawCells( 0, TopRow, 0, FixedBoundaryY, FixedBoundaryX, GridBoundaryY,
        FixedColor, [ gdFixed ] );
      DrawCells( LeftCol, TopRow, FixedBoundaryX, FixedBoundaryY, GridBoundaryX,
        GridBoundaryY, CellColor, [ ] );

      if not ( csDesigning in ComponentState ) and ( goRowSelect in Options )
        and DefaultDrawing and Focused
      then
      begin
        GridRectToScreenRect( GetSelection, FocRect, False );
        Canvas.DrawFocusRect( FocRect );

      end;

      { Fill in area not occupied by cells }
      if GridBoundaryX < GridWidth
      then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect( Rect( GridBoundaryX, 0, GridWidth, GridBoundaryY ) );
      end;
      if GridBoundaryY < GridHeight
      then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect( Rect( 0, GridBoundaryY, GridWidth, GridHeight ) );
      end;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.CalcDrawInfo( var DrawInfo : TGridDrawInfo );
  begin
    CalcDrawInfoXY( DrawInfo, ClientWidth, ClientHeight );
  end;

{ **************************************************************************** }
procedure TKingCalendar.CalcDrawInfoXY(
  var DrawInfo        : TGridDrawInfo;
  UseWidth, UseHeight : Integer );
  var
    I : Longint;
  begin
    CalcFixedInfo( DrawInfo );
    with DrawInfo do
    begin
      GridHeight := UseHeight;
      GridWidth := UseWidth;

      { Calculate visible area }
      GridBoundaryX := FixedBoundaryX;
      LastFullVisibleCol := LeftCol;
      for I := LeftCol to ColCount - 1 do
      begin
        Inc( GridBoundaryX, ColWidths[ I ] + EffectiveHorzLineWidth );
        if GridBoundaryX > GridWidth
        then
        begin
          GridBoundaryX := GridWidth;
          Break;
        end;
        LastFullVisibleCol := I;
        FullVisBoundaryX := GridBoundaryX;
      end;
      GridBoundaryY := FixedBoundaryY;
      LastFullVisibleRow := TopRow;
      for I := TopRow to RowCount - 1 do
      begin
        Inc( GridBoundaryY, RowHeights[ I ] + EffectiveVertLineWidth );
        if GridBoundaryY > GridHeight
        then
        begin
          GridBoundaryY := GridHeight;
          Break;
        end;
        LastFullVisibleRow := I;
        FullVisBoundaryY := GridBoundaryY;
      end;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.CalcFixedInfo( var DrawInfo : TGridDrawInfo );
  var
    I : Integer;
  begin
    with DrawInfo do
    begin
      { Calculate grid line widths }
      EffectiveHorzLineWidth := 0;
      if [ goFixedHorzLine, goHorzLine ] * Options <> [ ]
      then
        EffectiveHorzLineWidth := GridLineWidth;
      EffectiveVertLineWidth := 0;
      if [ goFixedVertLine, goVertLine ] * Options <> [ ]
      then
        EffectiveVertLineWidth := GridLineWidth;

      { Calculate fixed boundaries }
      FixedBoundaryX := 0;
      for I := 0 to FixedCols - 1 do
        Inc( FixedBoundaryX, ColWidths[ I ] + EffectiveHorzLineWidth );
      FixedBoundaryY := 0;
      for I := 0 to FixedRows - 1 do
        Inc( FixedBoundaryY, RowHeights[ I ] + EffectiveVertLineWidth );
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetGridLines( Value : Boolean );
  begin
    FGridLines := Value;
    Paint; { Force a ReDraw of the Canvas }
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetBackground( oColor : TColor );
  begin
    FHighlight := oColor;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetForeground( oColor : TColor );
  begin
    FHighlightText := oColor;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetCalendarActive( Value : Boolean );
  begin
    FActive := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.Today;
  var
    AYear, AMonth, ADay : Word;
  begin

    DecodeDate( Date, AYear, AMonth, ADay );

    FDate := Date;

    { This is a Dummy Call to Reset The Date with only firing the OnChange }
    SetDateElement( 4, 1 )

  end;

{ **************************************************************************** }
procedure TKingCalendar.NotifyLinks;
  begin
  end;

{ **************************************************************************** }
function TKingCalendar.CalcCoordFromPoint(
  X, Y           : Integer;
  const DrawInfo : TGridDrawInfo ) : TGridCoord;
  var
    I, Start, Stop : Longint;
    Line : Integer;
  begin
    with DrawInfo do
    begin
      if X < FixedBoundaryX
      then
      begin
        Start := 0;
        Stop := FixedCols - 1;
        Line := 0;
      end
      else
      begin
        Start := LeftCol;
        Stop := ColCount - 1;
        Line := FixedBoundaryX;
      end;
      for I := Start to Stop do
      begin
        Result.X := I;
        Inc( Line, ColWidths[ I ] + EffectiveHorzLineWidth );
        if X < Line
        then
          Break;
      end;
      if I > Stop
      then
        Result.X := - 1;
      if Y < FixedBoundaryY
      then
      begin
        Start := 0;
        Stop := FixedRows - 1;
        Line := 0;
      end
      else
      begin
        Start := TopRow;
        Stop := RowCount - 1;
        Line := FixedBoundaryY;
      end;
      for I := Start to Stop do
      begin
        Result.Y := I;
        Inc( Line, RowHeights[ I ] + EffectiveVertLineWidth );
        if Y < Line
        then
          Break;
      end;
      if I > Stop
      then
        Result.Y := - 1;
    end;
    if Result.Y = - 1
    then
      Result.X := - 1
    else if Result.X = - 1
    then
      Result.Y := - 1;
  end;

{ **************************************************************************** }
function TKingCalendar.GetDateFlag( Value : Integer ) : Integer;
  begin
    Result := FHotSpots[ Value ];
  end;

{ **************************************************************************** }
function TKingCalendar.GetMonthFlags : TKingFlags;
  begin
    Result := FHotSpots;
  end;

{ **************************************************************************** }
procedure TKingCalendar.ClearDay( nDay : Integer );
  begin
    SetDateFlag( nDay, 0, '' );
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetDateText(
  nDay : Integer;
  Text : String );
  begin

    Inc( FKingTextCount[ nDay ] );
    FKingText[ nDay ][ FKingTextCount[ nDay ] ] := ShortString( Text );
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetDateFlag(
  nDay, Flag : Integer;
  Text       : String );
  begin

    if ( nDay >= 1 ) and ( nDay <= DaysThisMonth )
    then
    begin
      if ( Flag < 0 ) or ( Flag > 9 )
      then
        Flag := FHotSpots[ nDay ];

      FHotSpots[ nDay ] := Flag;
      Inc( FKingTextCount[ nDay ] );
      FKingTypes[ nDay ][ FKingTextCount[ nDay ] ] := Flag;
      FKingText[ nDay ][ FKingTextCount[ nDay ] ] := ShortString( Text );
      if not ( SuspendUpdate )
      then
        Paint;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetMonthFlags( Value : TKingFlags );
  begin
    FHotSpots := Value;
    if not ( SuspendUpdate )
    then
      Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.UpdateCalendar;
  var
    AYear, AMonth, ADay : Word;
    dFirstDate : TDateTime;
  begin
    FUpdating := True;
    try
      DecodeDate( FDate, AYear, AMonth, ADay );
      dFirstDate := EncodeDate( AYear, AMonth, 1 );
      FMonthOffset := 2 -
        ( ( DayOfWeek( dFirstDate ) - StartingDay + 7 ) mod 7 );
      if FMonthOffset = 2
      then
        FMonthOffset := - 5;
      MoveColRow( ( ADay - FMonthOffset ) mod 7, ( ADay - FMonthOffset ) div 7 +
        1, False, False );

    finally
      FUpdating := False;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.AcceptDropped(
  X, Y, Value : Integer;
  Text        : String );
  var
    DrawInfo : TGridDrawInfo;
    CellHit : TGridCoord;
    CellText : String;
    nDay : Integer;
  begin
    CalcDrawInfo( DrawInfo );
    CellHit := CalcCoordFromPoint( X, Y, DrawInfo );

    CellText := GetCellText( CellHit.Y, CellHit.X );

    if SelectCell( CellHit.X, CellHit.Y )
    then
    begin
      nDay := StrToInt( CellText );
      FHotSpots[ nDay ] := Value;

      Inc( FKingTextCount[ nDay ] );
      FKingText[ nDay ][ FKingTextCount[ nDay ] ] :=
        ShortString( copy( Text, 1, 30 ) );
      FKingTypes[ nDay ][ FKingTextCount[ nDay ] ] := Value;

    end;

    if Assigned( FOnDroppedCell )
    then
      FOnDroppedCell( Self, StrToInt( CellText ) );

    SetFocus;
    Paint;
    { Invalidate; }

  end;

{ **************************************************************************** }
procedure TKingCalendar.WMLButtonDown( var Message : TMessage );
  begin
    inherited;
  end;

{ **************************************************************************** }
procedure TKingCalendar.WMEraseBkgnd( var Message : TMessage );
  begin
    inherited;
  end;

{ **************************************************************************** }
procedure TKingCalendar.ClearAllDays;
  var
    I, X : Integer;
  begin

    for I := 1 to 31 do
      FHotSpots[ I ] := 0;

    for I := 1 to 31 do
      for X := 1 to 10 do
        FKingText[ I ][ X ] := '';

    for X := 1 to 31 do
      FKingTextCount[ X ] := 0;

  end;

{ **************************************************************************** }
procedure TKingCalendar.SetTitleColor( Value : TColor );
  begin
    if FTitleColor <> Value
    then
    begin
      FTitleColor := Value;
      FixedColor := Value;
      Paint;
    end;

  end;

{ **************************************************************************** }
procedure TKingCalendar.SetCellColor( Value : TColor );
  begin
    FCellColor := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetGridLineColor( Value : TColor );
  begin
    FGridLineColor := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetTextPlacement( Value : TKingText );
  begin
    FTextPlacement := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetDowNames( Value : TStrings );
  begin
    FDowNames.Assign( Value );
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetHookEvent( Value : TNotifyEvent );
  begin
    FHookCount := FHookCount + 1;
    FHooks[ FHookCount ] := Value;
  end;

{ **************************************************************************** }
function TKingCalendar.GetApptLevel : Integer;
  begin
    Result := FHotSpots[ Day ];
  end;

{ **************************************************************************** }
procedure TKingCalendar.KeyDown(
  var Key : Word;
  Shift   : TShiftState );
  begin
    Inherited KeyDown( Key, Shift );
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetStartOfWeek( nStart : TDaysInWeek );
  begin
    IF nStart <> FStartofWeek
    then
      if ( nStart >= 0 ) and ( nStart <= 6 )
      then
      begin
        FStartofWeek := nStart;
        UpdateCalendar;
        Invalidate;
      end;
  end;

{ **************************************************************************** }
function TKingCalendar.SelectCell( ACol, ARow : Longint ) : Boolean;
  var
    TheText : String;
    nText : Integer;
  begin
    TheText := CellText[ ARow, ACol ];
    nText := 0;
    if not ( TheText = '' )
    then
      nText := StrToInt( TheText );

    if ( ( not FUpdating ) and ( not FActive ) ) or ( TheText = '' ) or
      ( ( ARow > 0 ) and FBlockedDays[ nText ] )
    then
      Result := False
    else
      Result := inherited SelectCell( ACol, ARow );
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetShowText( Value : Boolean );
  begin
    FShowText := Value;

    if Value and not ( FTextPlacement = ktTopLeft )
    then
      FTextPlacement := ktTopLeft;

    if FShowText
    then
      FShowBars := False;

    Paint;

  end;

{ **************************************************************************** }
procedure TKingCalendar.SetTextFont( Value : TFont );
  begin
    FTextFont.Assign( Value );
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetTitleFont( Value : TFont );
  var
    MyMsg : TWMSize;
  begin
    FTitleFont.Assign( Value );
    FFixedSize := FTitleFont.Size + 4;
    Paint;
    MyMsg.Height := Height;
    MyMsg.Width := Width;
    WMSize( MyMsg );
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetFixedHeader( Value : Boolean );
  var
    MyMsg : TWMSize;
  begin
    FFixedHeader := Value;
    Paint;
    MyMsg.Height := Height;
    MyMsg.Width := Width;
    WMSize( MyMsg );
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetFixedSize( Value : Integer );
  begin
    FFixedSize := Value;
    Paint;
  end;

{ **************************************************************************** }
function TKingCalendar.GetKingColor( Value : Integer ) : TColor;
  begin
    case Value of
      0 :
        Result := clBlack;
      1 :
        Result := FKingColors.ColorSet1;
      2 :
        Result := FKingColors.ColorSet2;
      3 :
        Result := FKingColors.ColorSet3;
      4 :
        Result := FKingColors.ColorSet4;
      5 :
        Result := FKingColors.ColorSet5;
      6 :
        Result := FKingColors.ColorSet6;
      7 :
        Result := FKingColors.ColorSet7;
      8 :
        Result := FKingColors.ColorSet8;
      9 :
        Result := FKingColors.ColorSet9;
      else
        Result := clBlack;
    end;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetUseCellColor( Value : Boolean );
  begin
    FColorCellText := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetUseDayColor( Value : Boolean );
  begin
    FColorCellDay := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetCalDate( Value : TDateTime );
  begin
    FDate := Value;
    Paint;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetDayBlock( nDay : Integer );
  begin
    if ( nDay > 0 ) and ( nDay <= 31 )
    then
      FBlockedDays[ nDay ] := not ( FBlockedDays[ nDay ] );
    if not ( SuspendUpdate )
    then
      Invalidate;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetDateRangeBlock( nStart, nEnd : Integer );
  var
    X : Integer;
  begin
    if ( ( nStart > 0 ) and ( nStart <= 31 ) ) and
      ( ( nEnd > 0 ) and ( nEnd <= 31 ) )
    then
      for X := nStart to nEnd do
        FBlockedDays[ X ] := not ( FBlockedDays[ X ] );

    Invalidate;
  end;

{ **************************************************************************** }
function TKingCalendar.GetDayBlock( nDay : Integer ) : Boolean;
  begin
    Result := False; // Resolve hint
    if ( nDay > 0 ) and ( nDay <= 31 )
    then
      Result := FBlockedDays[ nDay ];
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetBlockBack( Value : TColor );
  begin
    FBlockedBkgnd := Value;
    Invalidate;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetTodayColor( Value : TColor );
  begin
    FTodayColor := Value;
    Invalidate;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetBlockFore( Value : TColor );
  begin
    FBlockedFrgnd := Value;
    Invalidate;
  end;

{ //\\ 1.2 }
{ **************************************************************************** }
procedure TKingCalendar.ClearColorBars;
  var
    X : Integer;
  begin
    for X := ( FCalendarObjects.Count - 1 ) downto 0 do
      if ( copy( FCalendarObjects[ X ], 1, 2 ) = 'CB' )
      then
      begin
        TObject( FCalendarObjects.Objects[ X ] ).Free;
        FCalendarObjects.Delete( X );
      end;
  end;
{ ///\\ }

{ **************************************************************************** }
procedure TKingCalendar.ClearBlockedDays;
  var
    X : Integer;
  begin
    for X := 1 to 31 do
      FBlockedDays[ X ] := False;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetBlockWeekend( Value : Boolean );
  var
    X, nDow, MaxDays : Integer;
    dFirstDate : TDateTime;

  begin
    FBlockWeekends := Value;

    dFirstDate := EncodeDate( Year, Month, 1 );
    nDow := DayOfWeek( dFirstDate );
    MaxDays := DaysThisMonth;

    for X := 1 to MaxDays do
    begin
      if ( nDow = 1 ) or ( nDow = 7 )
      then
        FBlockedDays[ X ] := Value;
      if nDow < 7
      then
        Inc( nDow )
      else
        nDow := 1;
    end;
    Invalidate;

  end;

{ **************************************************************************** }
procedure TKingCalendar.SetSuspendUpdate( Value : Boolean );
  begin

    if FSuspendPaint <> Value
    then
    begin
      FSuspendPaint := Value;

      if not Value
      then
        Paint;

    end;

  end;

{ //\\ 1.2 Code }

{ **************************************************************************** }
procedure TKingCalendar.ClearDateRange( nBack, nFore : TColor );
  begin
    FillBackground( nBack );
    FillForeground( nFore );
  end;

{ **************************************************************************** }
procedure TKingCalendar.ColorDateRange(
  nStart, nEnd : Integer;
  nBack, nFore : TColor );
  var
    X : Integer;
  begin

    if ( nStart >= 1 ) and ( nEnd <= DaysThisMonth )
    then
      for X := nStart to nEnd do
      begin
        FCellBackground[ X ] := nBack;
        FCellForeground[ X ] := nFore;
      end;

    Invalidate;

  end;

{ **************************************************************************** }
procedure TKingCalendar.FillForeground( Value : TColor );
  var
    X : Integer;
  begin

    for X := 1 to 31 do
      FCellForeground[ X ] := Value;

  end;

{ **************************************************************************** }
procedure TKingCalendar.FillBackground( Value : TColor );
  var
    X : Integer;
  begin

    for X := 1 to 31 do
      FCellBackground[ X ] := Value;

  end;

{ **************************************************************************** }
procedure TKingCalendar.AddColorBar(
  nDay   : Integer;
  nColor : TColor );
  var
    oInfoBar : TKingInfoBar;
  begin

    if ( nDay >= 1 ) and ( nDay <= DaysThisMonth )
    then
    begin
      oInfoBar := TKingInfoBar.Create;
      oInfoBar.Color := nColor;
      FCalendarObjects.AddObject( 'CB' + IntToStr( nDay ), oInfoBar );
    end;

  end;

{ **************************************************************************** }
procedure TKingCalendar.MakeBarFromRange(
  nStart, nEnd : Integer;
  nColor       : TColor );
  var
    X : Integer;
  begin

    if ( nStart >= 1 ) and ( nEnd <= DaysThisMonth )
    then
      for X := nStart to nEnd do
        AddColorBar( X, nColor );
  end;

{ **************************************************************************** }
procedure TKingCalendar.RePaint;
  begin
    Invalidate;
  end;

{ **************************************************************************** }
procedure TKingCalendar.SetColorBars( Value : Boolean );
  begin

    FShowBars := Value;

    if FShowBars
    then
      TextInCell := False;

    FTextPlacement := ktTopLeft;

    Paint;

  end;

{ **************************************************************************** }
procedure TKingCalendar.GridRectToScreenRect(
  GridRect       : TGridRect;
  var ScreenRect : TRect;
  IncludeLine    : Boolean );
  var
    DrawInfo : TGridDrawInfo;
    // hint  InvalidRect: TRect;

    function ColPos(
      Col            : Longint;
      const DrawInfo : TGridDrawInfo ) : Integer;
      var
        Start, I : Longint;
      begin
        with DrawInfo do
        begin
          Result := 0;
          if Col < FixedCols
          then
            Start := 0
          else
          begin
            if Col >= LeftCol
            then
              Result := FixedBoundaryX;
            Start := LeftCol;
          end;
          for I := Start to Col - 1 do
          begin
            Inc( Result, ColWidths[ I ] + EffectiveHorzLineWidth );
            if Result > GridWidth
            then
            begin
              Result := 0;
              Exit;
            end;
          end;
        end;
      end;

    function RowPos(
      Row            : Longint;
      const DrawInfo : TGridDrawInfo ) : Integer;
      var
        Start, I : Longint;
      begin
        with DrawInfo do
        begin
          Result := 0;
          if Row < FixedRows
          then
            Start := 0
          else
          begin
            if Row >= TopRow
            then
              Result := FixedBoundaryY;
            Start := TopRow;
          end;
          for I := Start to Row - 1 do
          begin
            Inc( Result, RowHeights[ I ] + EffectiveVertLineWidth );
            if Result > GridHeight
            then
            begin
              Result := 0;
              Exit;
            end;
          end;
        end;
      end;

  begin
    FillChar( ScreenRect, SizeOf( ScreenRect ), 0 );
    if ( GridRect.Left > GridRect.Right ) or ( GridRect.Top > GridRect.Bottom )
    then
      Exit;
    CalcDrawInfo( DrawInfo );
    with DrawInfo do
    begin
      if GridRect.Left > LastFullVisibleCol + 1
      then
        Exit;
      if GridRect.Top > LastFullVisibleRow + 1
      then
        Exit;
      if ( GridRect.Left >= FixedCols ) and ( GridRect.Left < LeftCol )
      then
        if GridRect.Right < LeftCol
        then
          Exit
        else
          GridRect.Left := LeftCol;
      if GridRect.Right > LastFullVisibleCol
      then
      begin
        GridRect.Right := LastFullVisibleCol;
        if GridRect.Right < ColCount - 1
        then
          Inc( GridRect.Right );
        if ColPos( GridRect.Right, DrawInfo ) = 0
        then
          Dec( GridRect.Right );
      end;
      if ( GridRect.Top >= FixedRows ) and ( GridRect.Top < TopRow )
      then
        if GridRect.Bottom < TopRow
        then
          Exit
        else
          GridRect.Top := TopRow;
      if GridRect.Bottom > LastFullVisibleRow
      then
      begin
        GridRect.Bottom := LastFullVisibleRow;
        if GridRect.Bottom < RowCount - 1
        then
          Inc( GridRect.Bottom );
        if RowPos( GridRect.Bottom, DrawInfo ) = 0
        then
          Dec( GridRect.Bottom );
      end;
      ScreenRect.Left := ColPos( GridRect.Left, DrawInfo );
      ScreenRect.Right := ColPos( GridRect.Right, DrawInfo );
      if ScreenRect.Right = 0
      then
        ScreenRect.Right := ScreenRect.Left + ColWidths[ GridRect.Left ]
      else
        Inc( ScreenRect.Right, ColWidths[ GridRect.Right ] );
      if ScreenRect.Right > GridWidth
      then
        ScreenRect.Right := GridWidth;
      if IncludeLine
      then
        Inc( ScreenRect.Right, EffectiveHorzLineWidth );
      ScreenRect.Top := RowPos( GridRect.Top, DrawInfo );
      ScreenRect.Bottom := RowPos( GridRect.Bottom, DrawInfo );
      if ScreenRect.Bottom = 0
      then
        ScreenRect.Bottom := ScreenRect.Top + RowHeights[ GridRect.Top ]
      else
        Inc( ScreenRect.Bottom, RowHeights[ GridRect.Bottom ] );
      if IncludeLine
      then
        Inc( ScreenRect.Bottom, EffectiveVertLineWidth );
      if ScreenRect.Bottom > GridHeight
      then
        ScreenRect.Bottom := GridHeight;
    end;
  end;

{ **************************************************************************** }
function GridRect( Coord1, Coord2 : TGridCoord ) : TGridRect;
  begin
    with Result do
    begin
      Left := Coord2.X;
      if Coord1.X < Coord2.X
      then
        Left := Coord1.X;
      Right := Coord1.X;
      if Coord1.X < Coord2.X
      then
        Right := Coord2.X;
      Top := Coord2.Y;
      if Coord1.Y < Coord2.Y
      then
        Top := Coord1.Y;
      Bottom := Coord1.Y;
      if Coord1.Y < Coord2.Y
      then
        Bottom := Coord2.Y;
    end;
  end;

{ **************************************************************************** }
function TKingCalendar.GetSelection : TGridRect;
  begin
    Result := GridRect( FCurrent, FAnchor );
  end;

{ //\\ End 1.2 Code }

end.
