{ *                                                                                * }
{ *  unit KingToolCtrl                                                            * }
{ *  KingCalendar Spin, Combo, and Label Controls                                 * }
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

// LR20260325 - Extracted spin, combo, and label controls from KingTool.pas

unit KingToolCtrl;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  VCL.Samples.Spin,
  Vcl.Themes,
  TheKing;

type

  { TKingLabel }
  TKingLabel = class( TLabel )
    private
      FAbout : String;
      FCalendarSource : TKingCalendar;
      FFormat : String;
      FIncludeWeekNum: Boolean;
    protected
      procedure SetSource( Value : TKingCalendar );
      procedure SetFormat( Value : String );
      procedure SetIncludeWeekNum ( Value : Boolean );
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
      property IncludeWeekNum : Boolean
        read FIncludeWeekNum
        write SetIncludeWeekNum;
      property ParentShowHint;
      property ShowHint;
      property DragCursor;
      property DragMode;
      property Visible;
  end;

  { TKingWeekLabel }
  TKingWeekLabel = class( TLabel )
    private
      FAbout : String;
      FCalendarSource : TKingCalendar;
      FIncludeCaption: boolean;
      FOnChange : TNotifyEvent;
    protected
      procedure SetSource( Value : TKingCalendar );
      procedure SetFormat( Value : String );
      procedure SetIncludeCaption (Value : Boolean );
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
      procedure Change;

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
      property IncludeCaption : Boolean
        read FIncludeCaption
        write SetIncludeCaption;
      property OnChange : TNotifyEvent
        read FOnChange
        write FOnChange;
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

implementation

const
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
    // FMaxYear := 2020;

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

    for I := 0 to Owner.ComponentCount - 1 do
    begin
      if Owner.Components[ I ] is TKingCalendar
      then
      begin
        FCalendarSource := TKingCalendar( Owner.Components[ I ] );
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
    begin
      // LR20260325 - Unhook before nilling to prevent dangling pointer
      FCalendarSource.UnhookEvent( Hooked );
      FCalendarSource := nil;
    end;

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

    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[ I ] is TKingCalendar
      then
      begin
        FCalendarSource := TKingCalendar( AOwner.Components[ I ] );
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
    begin
      // LR20260325 - Unhook before nilling to prevent dangling pointer
      FCalendarSource.UnhookEvent( Hooked );
      FCalendarSource := nil;
    end;

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
    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[ I ] is TKingCalendar
      then
      begin
        FCalendarSource := TKingCalendar( AOwner.Components[ I ] );
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
    begin
      // LR20260325 - Unhook before nilling to prevent dangling pointer
      FCalendarSource.UnhookEvent( TheDateChanged );
      FCalendarSource := nil;
    end;

  end;

{ *************************************************************************** }
procedure TDayCombo.TheDateChanged( Sender : TObject );
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
  TKingLabel
  =========================================================================== }
constructor TKingLabel.Create( AOwner : TComponent );
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    FFormat := 'MMMM DD, YYYY';
    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( AOwner.Components[ I ] );
        Break;
      end;
    end;
    FIncludeWeekNum := False;
    self.AutoSize := True;


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

procedure TKingLabel.SetIncludeWeekNum(Value: Boolean);
begin
  FIncludeWeekNum := Value;
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
    begin
      // LR20260325 - Unhook before nilling to prevent dangling pointer
      FCalendarSource.UnhookEvent( DateChange );
      FCalendarSource := nil;
    end;

  end;

{ *************************************************************************** }
procedure TKingLabel.UpdateLabel;
  var
    cDate : String;
    ldf : string;
    LFormatSettings : TFormatSettings;
  begin

    if ( FCalendarSource <> nil )
    then
    begin
      // LR20260325 - Use local format settings to avoid mutating global
      // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
      // formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
      LFormatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
      ldf := LFormatSettings.LongDateFormat;

      DateTimeToString( cDate, ldf, CalendarSource.CalendarDate,
        LFormatSettings );
      // DateTimeToString( cDate, FFormat, CalendarSource.CalendarDate );
      Caption := cDate;

      if FIncludeWeekNum then
        Caption := Caption + ' - Week Number ' + WeekOfTheYear( CalendarSource.CalendarDate ).ToString;
    end;

    self.Invalidate;

  end;

{ TKingWeekLabel }

procedure TKingWeekLabel.Change;

  begin
    if Assigned( FOnChange )
    then
      FOnChange( Self );


end;

constructor TKingWeekLabel.Create(AOwner: TComponent);
  var
    I : Integer;
  begin
    inherited Create( AOwner );
    FIncludeCaption := True;
    for I := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[ I ] is TKingCalendar
      then
      begin
        CalendarSource := TKingCalendar( AOwner.Components[ I ] );
        Break;
      end;
    end;
    self.AutoSize := True;

end;

procedure TKingWeekLabel.DateChange(Sender: TObject);
begin
    UpdateLabel;
end;

procedure TKingWeekLabel.Loaded;
begin
    inherited Loaded;

    UpdateLabel;

    if ( FCalendarSource <> nil )
    then
      CalendarSource.HookEvent := DateChange;

end;

procedure TKingWeekLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited Notification( AComponent, Operation );

    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FCalendarSource )
    then
    begin
      // LR20260325 - Unhook before nilling to prevent dangling pointer
      FCalendarSource.UnhookEvent( DateChange );
      FCalendarSource := nil;
    end;

end;

procedure TKingWeekLabel.SetFormat(Value: String);
begin
    if ( FCalendarSource <> nil )
    then
      UpdateLabel;

end;

procedure TKingWeekLabel.SetIncludeCaption(Value: Boolean);
begin
  FIncludeCaption := Value;
  UpdateLabel;
end;

procedure TKingWeekLabel.SetSource(Value: TKingCalendar);
begin
    FCalendarSource := Value;
    UpdateLabel;

end;

procedure TKingWeekLabel.UpdateLabel;
  begin

    if ( FCalendarSource <> nil )
    then
    begin
      if FIncludeCaption then
        Caption := 'Week: ' + WeekOfTheYear( CalendarSource.CalendarDate ).ToString
      else
        Caption := WeekOfTheYear( CalendarSource.CalendarDate ).ToString;
    end;
    self.Invalidate;

    if not ( csLoading in ComponentState )
      then
        Change;
end;

end.
