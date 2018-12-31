{ *                                                                                * }
{ *  unit KingSpin                                                                 * }
{ *  TKingTimeSpin Component                                                       * }
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

unit KingSpin;

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
  Vcl.Menus,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  VCL.Samples.Spin,
  Vcl.Buttons;

type

  { TKingTimeSpin }
  TKingTimeSpin = class( TCustomEdit )
    private
      FAbout : String;
      FTimeFormat : String;
      FStartTime : String;
      // hint	  FCanvas: TCanvas;
      FIncrement : Integer;
      FButton : TSpinButton;
      function GetMinHeight : Integer;
      function GetValue : TDateTime;
      procedure SetValue( NewValue : TDateTime );
      procedure SetEditRect;
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure CMEnter( var Message : TCMGotFocus ); message CM_ENTER;
      procedure CMExit( var Message : TCMExit ); message CM_EXIT;
    protected
      function IsValidChar( Key : Char ) : Boolean; virtual;
      procedure UpClick( Sender : TObject ); virtual;
      procedure DownClick( Sender : TObject ); virtual;
      procedure KeyDown(
        var Key : Word;
        Shift   : TShiftState ); override;
      procedure KeyPress( var Key : Char ); override;
      procedure CreateParams( var Params : TCreateParams ); override;
      procedure CreateWnd; override;
      function IncrementTime( nIncBy : Integer ) : TDateTime;
      function DecrementTime( nIncBy : Integer ) : TDateTime;
    public
      procedure IncrementBy( nIncBy : Integer );
      procedure DecrementBy( nIncBy : Integer );
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      property Button : TSpinButton
        read FButton;
      property Value : TDateTime
        read GetValue
        write SetValue;
      procedure Loaded; override;
      procedure SetStartTime( oTime : String );
    published
      property About : String
        read FAbout
        write FAbout;
      property TimeFormat : String
        read FTimeFormat
        write FTimeFormat;
      property Increment : Integer
        read FIncrement
        write FIncrement
        default 1;
      property StartTime : String
        read FStartTime
        write SetStartTime;
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
      property Visible;
  end;

  { TKingDateSpin }
  TKingDateSpin = class( TCustomEdit )
    private
      FIncrement : Integer;
      FAbout : String;
      FDateFormat : String;
      FStartDate : String;
      // hint    FCanvas: TCanvas;
      FButton : TSpinButton;
      function GetMinHeight : Integer;
      function GetValue : TDateTime;
      procedure SetValue( NewValue : TDateTime );
      procedure SetEditRect;
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure CMEnter( var Message : TCMGotFocus ); message CM_ENTER;
      procedure CMExit( var Message : TCMExit ); message CM_EXIT;
    protected
      function IsValidChar( Key : Char ) : Boolean; virtual;
      procedure UpClick( Sender : TObject ); virtual;
      procedure DownClick( Sender : TObject ); virtual;
      procedure KeyDown(
        var Key : Word;
        Shift   : TShiftState ); override;
      procedure KeyPress( var Key : Char ); override;
      procedure CreateParams( var Params : TCreateParams ); override;
      procedure CreateWnd; override;
      procedure SetFormat( NewValue : String );
    public
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      property Button : TSpinButton
        read FButton;
      property Value : TDateTime
        read GetValue
        write SetValue;
      procedure Loaded; override;
      procedure SetStartDate( oTime : String );
    published
      property About : String
        read FAbout
        write FAbout;
      property DateFormat : String
        read FDateFormat
        write SetFormat;
      property StartDate : String
        read FStartDate
        write SetStartDate;
      property Increment : Integer
        read FIncrement
        write FIncrement
        default 1;
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
      property Visible;
  end;

implementation

function kcIsLeapYear( nYear : Integer ) : Boolean;
  begin
    result := IsLeapYear( nYear );

    // Result := ( nYear mod 4 = 0 ) and
    // ( ( nYear mod 100 <> 0 ) or ( nYear mod 400 = 0 ) );
  end;

function kcMonthDays( nMonth, nYear : Integer ) : Integer;
  // const
  // DaysPerMonth : array [ 1 .. 12 ] of Integer = ( 31, 28, 31, 30, 31, 30, 31,
  // 31, 30, 31, 30, 31 );
  begin
    result := DaysInAMonth( nYear, nMonth );

    // Result := DaysPerMonth[ nMonth ];
    // if ( nMonth = 2 ) and kcIsLeapYear( nYear )
    // then
    // Inc( Result );
  end;

{ TKingTimeSpin }
constructor TKingTimeSpin.Create( AOwner : TComponent );
  begin
    inherited Create( AOwner );
    FButton := TSpinButton.Create( Self );
    FButton.Width := 17;
    FButton.Height := 17;
    FButton.Visible := True;
    FButton.Parent := Self;
    FButton.FocusControl := Self;
    FButton.OnUpClick := UpClick;
    FButton.OnDownClick := DownClick;
    FTimeFormat := 'hh:mm AMPM';
    FStartTime := '06:00 AM';
    Text := FStartTime;
    Width := 89;
    ControlStyle := ControlStyle - [ csSetCaption ];
    FIncrement := 1;
    AutoSelect := False;
    ReadOnly := True;
  end;

destructor TKingTimeSpin.Destroy;
  begin
    FButton := nil;
    inherited Destroy;
  end;

procedure TKingTimeSpin.Loaded;
  begin
    inherited Loaded;
    Text := FStartTime;
  end;

procedure TKingTimeSpin.SetStartTime( oTime : String );
  begin
    FStartTime := oTime;
    Text := FStartTime;
  end;

procedure TKingTimeSpin.KeyDown(
  var Key : Word;
  Shift   : TShiftState );
  begin
    if Key = VK_UP
    then
      UpClick( Self )
    else if Key = VK_DOWN
    then
      DownClick( Self );
    inherited KeyDown( Key, Shift );
  end;

procedure TKingTimeSpin.KeyPress( var Key : Char );
  var
    OldKey : Char;
  begin
    OldKey := Key;
    if not IsValidChar( Key )
    then
    begin
      Key := #0;
      if not ( OldKey = '+' ) and not ( OldKey = '-' )
      then
        MessageBeep( 0 )
    end;
    if ( OldKey = '+' )
    then
      UpClick( Self );
    if ( OldKey = '-' )
    then
      DownClick( Self );

    if Key <> #0
    then
      inherited KeyPress( Key );
  end;

function TKingTimeSpin.IsValidChar( Key : Char ) : Boolean;
  begin
    result := ( ( Key < #32 ) and ( Key <> Chr( VK_RETURN ) ) );
  end;

procedure TKingTimeSpin.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    { Params.Style := Params.Style and not WS_BORDER; }
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

procedure TKingTimeSpin.CreateWnd;
  // hint var
  // hint  Loc: TRect;
  begin
    inherited CreateWnd;
    SetEditRect;
  end;

procedure TKingTimeSpin.SetEditRect;
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

procedure TKingTimeSpin.WMSize( var Message : TWMSize );
  var
    // hint	Loc: TRect;
    MinHeight : Integer;
  begin
    inherited;
    MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
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

function TKingTimeSpin.GetMinHeight : Integer;
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
    result := Metrics.tmHeight + I div 4 + GetSystemMetrics
      ( SM_CYBORDER ) * 4 + 2;
  end;

procedure TKingTimeSpin.UpClick( Sender : TObject );
  begin
    Value := IncrementTime( FIncrement );
    { Value := Value + FIncrement; }
  end;

procedure TKingTimeSpin.DownClick( Sender : TObject );
  begin
    Value := DecrementTime( FIncrement );
    { Value := Value - FIncrement; }
  end;

procedure TKingTimeSpin.CMExit( var Message : TCMExit );
  begin
    inherited;
    SetValue( Value );
  end;

function TKingTimeSpin.GetValue : TDateTime;
  begin
    if ( Text = '' )
    then
      Text := FStartTime;

    result := StrToTime( Text );
  end;

procedure TKingTimeSpin.SetValue( NewValue : TDateTime );
  var
    NewTime : String;
  begin
    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    DateTimeToString( NewTime, TimeFormat, NewValue, formatSettings );
    // DateTimeToString( NewTime, TimeFormat, NewValue );
    Text := NewTime;
  end;

procedure TKingTimeSpin.CMEnter( var Message : TCMGotFocus );
  begin
    if AutoSelect and not ( csLButtonDown in ControlState )
    then
      SelectAll;
    inherited;
  end;

function TKingTimeSpin.IncrementTime( nIncBy : Integer ) : TDateTime;
  var
    Hour, Min, Sec, mSec : Word;
    min2 : Integer;
  begin

    DecodeTime( Value, Hour, Min, Sec, mSec );
    min2 := Min;

    If ( ( 59 - Min ) < nIncBy )
    then
    begin
      if Hour = 23
      then
        Hour := 0
      else
        Hour := Hour + 1;

      min2 := 0 - ( 60 - min2 );

    end;

    Min := min2 + nIncBy;

    result := EncodeTime( Hour, Min, 0, 0 );

  end;

function TKingTimeSpin.DecrementTime( nIncBy : Integer ) : TDateTime;
  var
    Hour, Min, Sec, mSec : Word;
  begin

    DecodeTime( Value, Hour, Min, Sec, mSec );

    If ( Min <= nIncBy )
    then
    begin
      if Hour = 0
      then
        Hour := 23
      else
        Hour := Hour - 1;
      Min := ( 60 + Min );
    end;

    Min := Min - nIncBy;

    if ( Min = 60 )
    then
    begin
      Min := 0;
      Hour := Hour + 1;
    end;

    result := EncodeTime( Hour, Min, 0, 0 );

  end;

procedure TKingTimeSpin.IncrementBy( nIncBy : Integer );
  begin
    Value := IncrementTime( nIncBy );
  end;

procedure TKingTimeSpin.DecrementBy( nIncBy : Integer );
  begin
    Value := DecrementTime( nIncBy );
  end;

{ TKingDateSpin }
constructor TKingDateSpin.Create( AOwner : TComponent );
  begin
    inherited Create( AOwner );
    FButton := TSpinButton.Create( Self );
    FButton.Width := 17;
    FButton.Height := 17;
    FButton.Visible := True;
    FButton.Parent := Self;
    FButton.FocusControl := Self;
    FButton.OnUpClick := UpClick;
    FButton.OnDownClick := DownClick;

    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    FDateFormat := formatSettings.ShortDateFormat; { 'MM/DD/YY'; }

    DateTimeToString( FStartDate, FDateFormat, Now, formatSettings );
    // DateTimeToString( FStartDate, FDateFormat, Date );
    Text := FStartDate;
    Width := 89;
    ControlStyle := ControlStyle - [ csSetCaption ];
    AutoSelect := False;
    ReadOnly := True;
    FIncrement := 1;
  end;

destructor TKingDateSpin.Destroy;
  begin
    FButton := nil;
    inherited Destroy;
  end;

procedure TKingDateSpin.Loaded;
  begin
    inherited Loaded;
    Text := FStartDate;
  end;

procedure TKingDateSpin.SetFormat( NewValue : String );
  begin
    FDateFormat := NewValue;
    SetValue( Value );
  end;

procedure TKingDateSpin.SetStartDate( oTime : String );
  begin
    FStartDate := oTime;
    Text := FStartDate;
  end;

procedure TKingDateSpin.KeyDown(
  var Key : Word;
  Shift   : TShiftState );
  begin
    if Key = VK_UP
    then
      UpClick( Self )
    else if Key = VK_DOWN
    then
      DownClick( Self );
    inherited KeyDown( Key, Shift );
  end;

procedure TKingDateSpin.KeyPress( var Key : Char );
  var
    OldKey : Char;
  begin

    OldKey := Key;

    if not IsValidChar( Key )
    then
    begin
      Key := #0;
      if not ( OldKey = '+' ) and not ( OldKey = '-' )
      then
        MessageBeep( 0 )
    end;
    if ( OldKey = '+' )
    then
      UpClick( Self );
    if ( OldKey = '-' )
    then
      DownClick( Self );

    if Key <> #0
    then
      inherited KeyPress( Key );
  end;

function TKingDateSpin.IsValidChar( Key : Char ) : Boolean;
  begin
    result := ( ( Key < #32 ) and ( Key <> Chr( VK_RETURN ) ) );
  end;

procedure TKingDateSpin.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    { Params.Style := Params.Style and not WS_BORDER; }
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

procedure TKingDateSpin.CreateWnd;
  // hint var
  // hint	Loc: TRect;
  begin
    inherited CreateWnd;
    SetEditRect;
  end;

procedure TKingDateSpin.SetEditRect;
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

procedure TKingDateSpin.WMSize( var Message : TWMSize );
  var
    // hint	Loc: TRect;
    MinHeight : Integer;
  begin
    inherited;
    MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
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

function TKingDateSpin.GetMinHeight : Integer;
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
    result := Metrics.tmHeight + I div 4 + GetSystemMetrics
      ( SM_CYBORDER ) * 4 + 2;
  end;

procedure TKingDateSpin.UpClick( Sender : TObject );
  begin
    Value := Value + FIncrement;
  end;

procedure TKingDateSpin.DownClick( Sender : TObject );
  begin
    Value := Value - FIncrement;
  end;

procedure TKingDateSpin.CMExit( var Message : TCMExit );
  begin
    inherited;
    SetValue( Value );
  end;

function TKingDateSpin.GetValue : TDateTime;
  // var
  // cTemp : String;
  begin
    if ( Text = '' )
    then
      Text := FStartDate;

    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    // cTemp := FormatSettings.ShortDateFormat;
    // FormatSettings.ShortDateFormat := FDateFormat;
    result := StrToDateTime( Text, formatSettings );
    // Result := StrToDateTime( Text );
    // FormatSettings.ShortDateFormat := cTemp;

  end;

procedure TKingDateSpin.SetValue( NewValue : TDateTime );
  var
    NewDate : String;
  begin
    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    DateTimeToString( NewDate, formatSettings.ShortDateFormat, NewValue,
      formatSettings );
    // DateTimeToString( NewDate, DateFormat, NewValue );
    Text := NewDate;
  end;

procedure TKingDateSpin.CMEnter( var Message : TCMGotFocus );
  begin
    if AutoSelect and not ( csLButtonDown in ControlState )
    then
      SelectAll;
    inherited;
  end;

end.
