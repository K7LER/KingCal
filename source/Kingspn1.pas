{ *                                                                                * }
{ *  unit KingSpn2                                                                 * }
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

unit KingSpn1;

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
  TheKing,
  // LR20260325 - Added KingBase for TKingBaseDateEdit base class
  KingBase;

type
  TDateChangeType = ( yyMonth, yyDay, yyYear, yyUnknown );

  { TKingMDYSpin }
  // LR20260325 - Changed base class from TCustomEdit to TKingBaseDateEdit
  // TKingMDYSpin = class( TCustomEdit )
  TKingMDYSpin = class( TKingBaseDateEdit )
    private
      fChange : TDateChangeType;
      FSelected : boolean;
      FSelStart : Integer;
      FSelLength : Integer;
      fOffset1 : Integer;
      fOffset2 : Integer;
      FIncrement : Integer;
      FAbout : String;
      FDateFormat : String;
      FStartDate : String;
      // LR20260325 - FButton now inherited from TKingBaseDateEdit
      // FButton : TSpinButton;
      // LR20260325 - GetMinHeight now inherited from TKingBaseDateEdit
      // function GetMinHeight : Integer;
      function GetValue : TDateTime;
      procedure SetValue( NewValue : TDateTime );
      function GetSelValue : word;
      procedure SetSelValue( NewValue : word );
      function GetSelected : boolean;
      // LR20260325 - SetEditRect now inherited from TKingBaseDateEdit
      // procedure SetEditRect;
      // LR20260325 - WMSize now inherited from TKingBaseDateEdit
      // procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure CMEnter( var Message : TCMGotFocus ); message CM_ENTER;
      procedure CMExit( var Message : TCMExit ); message CM_EXIT;
      procedure WMKeyDown( var Message : TWMKeyDown ); message WM_KEYDOWN;
      procedure GetDivOffset;
    protected
      // LR20260325 - IsValidChar now inherited from TKingBaseDateEdit
      // function IsValidChar( Key : Char ) : boolean; virtual;
      procedure MouseDown(
        Button : TMouseButton;
        shift  : TShiftState;
        x, y   : Integer ); override;
      procedure MouseUp(
        Button : TMouseButton;
        shift  : TShiftState;
        x, y   : Integer ); override;
      {
        procedure MouseMove(shift: TShiftState; x, y: integer ); dynamic;
      }
      procedure GotoPre( Sender : TObject ); virtual;
      Procedure GotoNxt( Sender : TObject ); virtual;
      procedure UpClick( Sender : TObject ); override;
      procedure DownClick( Sender : TObject ); override;
      procedure KeyDown(
        var Key : word;
        shift   : TShiftState ); override;
      // LR20260325 - KeyPress now inherited from TKingBaseDateEdit
      // procedure KeyPress( var Key : Char ); override;
      // LR20260325 - CreateParams now inherited from TKingBaseDateEdit
      // procedure CreateParams( var Params : TCreateParams ); override;
      // LR20260325 - CreateWnd now inherited from TKingBaseDateEdit
      // procedure CreateWnd; override;
      procedure SetFormat( NewValue : String );
    public
      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;
      // LR20260325 - FButton is now TControl in base; cast to TSpinButton
      function GetSpinButton : TSpinButton;
      property Button : TSpinButton
        read GetSpinButton;
      property Value : TDateTime
        read GetValue
        write SetValue;
      property SelValue : word
        read GetSelValue
        write SetSelValue;
      property Selected : boolean
        read GetSelected
        write FSelected;
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

function kcIsLeapYear( nYear : Integer ) : boolean;
  begin
    Result := ( nYear mod 4 = 0 ) and
      ( ( nYear mod 100 <> 0 ) or ( nYear mod 400 = 0 ) );
  end;

function kcMonthDays( nMonth, nYear : Integer ) : Integer;
  const
    DaysPerMonth : array [ 1 .. 12 ] of Integer = ( 31, 28, 31, 30, 31, 30, 31,
      31, 30, 31, 30, 31 );
  begin
    Result := DaysPerMonth[ nMonth ];
    if ( nMonth = 2 ) and kcIsLeapYear( nYear )
    then
      Inc( Result );
  end;

// LR20260325 - Typed accessor for FButton (TControl in base)
function TKingMDYSpin.GetSpinButton : TSpinButton;
  begin
    Result := TSpinButton( FButton );
  end;

constructor TKingMDYSpin.Create( AOwner : TComponent );
  var
    LFormatSettings : TFormatSettings;
    // LR20260325 - Local typed variable for TSpinButton-specific setup
    LBtn : TSpinButton;
  begin
    inherited Create( AOwner );
    // LR20260325 - Create TSpinButton and assign to inherited FButton (TControl)
    LBtn := TSpinButton.Create( Self );
    FButton := LBtn;
    LBtn.Width := 17;
    LBtn.Height := 17;
    LBtn.Visible := True;
    LBtn.Parent := Self;
    LBtn.FocusControl := Self;
    LBtn.OnUpClick := UpClick;
    LBtn.OnDownClick := DownClick;
    // Grab the local settings, in case International Formats
    // Furnish the locale format settings record
    // LR20260325 - Use local format settings to avoid mutating global
{$WARN SYMBOL_PLATFORM OFF}
    LFormatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    FDateFormat := LFormatSettings.ShortDateFormat; { 'MM/DD/YY'; }

    DateTimeToString( FStartDate, FDateFormat, Date, LFormatSettings );
    Text := FStartDate;
    Width := 89;
    ControlStyle := ControlStyle - [ csSetCaption ];
    AutoSelect := False;
    ReadOnly := True;
    FIncrement := 1;
  end;

destructor TKingMDYSpin.Destroy;
  begin
    FButton := nil;
    inherited Destroy;
  end;

procedure TKingMDYSpin.GetDivOffset;
  var
    i : Integer;
    tText : String;
  begin
    fOffset1 := 0;
    fOffset2 := 0;
    tText := Text;

    { looks for the 2nd Offset }
    i := Length( tText );
    repeat
      try;
        // tChk := StrToInt( tText[i] );
      except
        on E : EConvertError do
        begin
          fOffset2 := i - 1;
          tText := Copy( tText, 1, fOffset2 - 1 );
        end;
      end;
      Dec( i );
    until ( fOffset2 <> 0 ) or ( i = 0 );

    { looks for the 1st Offset }
    i := Length( tText );
    repeat
      try;
        // tChk := StrToInt( tText[i] );
      except
        on E : EConvertError do
          fOffset1 := i - 1;
      end;
      Dec( i );
    until ( fOffset1 <> 0 ) or ( i = 0 );
  end;

procedure TKingMDYSpin.Loaded;
  begin
    inherited Loaded;
    Text := FStartDate;

    GetDivOffset;
    SelStart := 0;
    SelLength := fOffset1;
    FSelStart := 0;
    FSelLength := fOffset1;
    Modified := True;
  end;

procedure TKingMDYSpin.SetFormat( NewValue : String );
  begin
    FDateFormat := NewValue;
    SetValue( Value );
  end;

procedure TKingMDYSpin.SetStartDate( oTime : String );
  begin
    FStartDate := oTime;
    Text := FStartDate;
  end;

procedure TKingMDYSpin.GotoPre( Sender : TObject );
  begin
    case fChange of
      yyMonth :
        begin
          fChange := yyYear;
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
      yyDay :
        begin
          fChange := yyMonth;
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
      yyYear :
        begin
          fChange := yyDay;
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
    end; { case }
  end;

procedure TKingMDYSpin.GotoNxt( Sender : TObject );
  begin
    case fChange of
      yyMonth :
        begin
          fChange := yyDay;
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
      yyDay :
        begin
          fChange := yyYear;
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
      yyYear :
        begin
          fChange := yyMonth;
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
    end; { case }
  end;

procedure TKingMDYSpin.WMKeyDown( var Message : TWMKeyDown );
  begin
    inherited;

    SelStart := FSelStart;
    SelLength := FSelLength;
    Modified := True;
  end;

procedure TKingMDYSpin.KeyDown(
  var Key : word;
  shift   : TShiftState );
  begin
    if Key = VK_UP
    then
      UpClick( Self )
    else if Key = VK_DOWN
    then
      DownClick( Self )
    else if Key = VK_LEFT
    then
      GotoPre( Self )
    else if Key = VK_RIGHT
    then
      GotoNxt( Self );

    inherited KeyDown( Key, shift );
  end;

// LR20260325 - KeyPress now inherited from TKingBaseDateEdit
{$IFDEF KINGBASE_LEGACY}
procedure TKingMDYSpin.KeyPress( var Key : Char );
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
{$ENDIF KINGBASE_LEGACY}

procedure TKingMDYSpin.MouseUp(
  Button : TMouseButton;
  shift  : TShiftState;
  x, y   : Integer );
  begin
    Inherited MouseUp( Button, shift, x, y );

    if ( SelLength = Length( Text ) )
    then
    begin
      FSelStart := 0;
      FSelLength := 0;
    end
    else
      case fChange of
        yyMonth :
          begin
            FSelStart := 0;
            FSelLength := fOffset1;
          end;
        yyDay :
          begin
            FSelStart := fOffset1 + 1;
            FSelLength := fOffset2 - fOffset1 - 1;
          end;
        yyYear :
          begin
            FSelStart := fOffset2 + 1;
            FSelLength := Length( Text ) - fOffset2 - 1;
          end;
        else
          begin
            FSelStart := 0;
            FSelLength := 0;
          end;
      end; { case }

    SelStart := FSelStart;
    SelLength := FSelLength;
  end;

procedure TKingMDYSpin.MouseDown(
  Button : TMouseButton;
  shift  : TShiftState;
  x, y   : Integer );
  begin
    Inherited MouseDown( Button, shift, x, y );

    FSelStart := SelStart;
    if ( SelStart < fOffset1 )
    then
    begin
      fChange := yyMonth;
      FSelStart := 0;
      FSelLength := fOffset1;
    end
    else if ( SelStart = fOffset1 )
    then
    begin
      fChange := yyUnknown;
      FSelStart := 0;
      FSelLength := 0;
    end
    else if ( SelStart > fOffset1 ) and ( SelStart < fOffset2 )
    then
    begin
      fChange := yyDay;
      FSelStart := fOffset1 + 1;
      FSelLength := fOffset2 - fOffset1 - 1;
    end
    else if ( SelStart > fOffset2 )
    then
    begin
      fChange := yyYear;
      FSelStart := fOffset2 + 1;
      FSelLength := Length( Text ) - fOffset2 - 1;
    end
    else
    begin
      fChange := yyUnknown;
      FSelStart := 0;
      FSelLength := 0;
    end;

    SelStart := FSelStart;
    SelLength := FSelLength;
  end;

// LR20260325 - IsValidChar, CreateParams, CreateWnd, SetEditRect,
// WMSize, GetMinHeight now inherited from TKingBaseDateEdit
{$IFDEF KINGBASE_LEGACY}
function TKingMDYSpin.IsValidChar( Key : Char ) : boolean;
  begin
    Result := ( ( Key < #32 ) and ( Key <> Chr( VK_RETURN ) ) );
  end;

procedure TKingMDYSpin.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

procedure TKingMDYSpin.CreateWnd;
  begin
    inherited CreateWnd;
    SetEditRect;
  end;

procedure TKingMDYSpin.SetEditRect;
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

procedure TKingMDYSpin.WMSize( var Message : TWMSize );
  var
    MinHeight : Integer;
  begin
    inherited;
    MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does not display the text }
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

function TKingMDYSpin.GetMinHeight : Integer;
  var
    DC : HDC;
    SaveFont : HFont;
    i : Integer;
    SysMetrics, Metrics : TTextMetric;
  begin
    DC := GetDC( 0 );
    GetTextMetrics( DC, SysMetrics );
    SaveFont := SelectObject( DC, Font.Handle );
    GetTextMetrics( DC, Metrics );
    SelectObject( DC, SaveFont );
    ReleaseDC( 0, DC );
    i := SysMetrics.tmHeight;
    if i > Metrics.tmHeight
    then
      i := Metrics.tmHeight;
    Result := Metrics.tmHeight + i div 4 + GetSystemMetrics
      ( SM_CYBORDER ) * 4 + 2;
  end;
{$ENDIF KINGBASE_LEGACY}

procedure TKingMDYSpin.UpClick( Sender : TObject );
  begin
    if Selected
    then
      SelValue := SelValue + FIncrement
    else
      Value := Value + FIncrement;
  end;

procedure TKingMDYSpin.DownClick( Sender : TObject );
  begin
    if Selected
    then
      SelValue := SelValue - FIncrement
    else
      Value := Value - FIncrement;
  end;

procedure TKingMDYSpin.CMExit( var Message : TCMExit );
  begin
    inherited;
    SetValue( Value );
  end;

function TKingMDYSpin.GetValue : TDateTime;
  var
    LFormatSettings : TFormatSettings;
  // var
  // cTemp : String;
  begin
    if ( Text = '' )
    then
      Text := FStartDate;

    // LR20260325 - Use local format settings to avoid mutating global
    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    LFormatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    Result := StrToDateTime( Text, LFormatSettings );
  end;

procedure TKingMDYSpin.SetValue( NewValue : TDateTime );
  var
    NewDate : String;
    LFormatSettings : TFormatSettings;
  begin
    // LR20260325 - Use local format settings to avoid mutating global
    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    LFormatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    DateTimeToString( NewDate, LFormatSettings.ShortDateFormat, NewValue,
      LFormatSettings );

    Text := NewDate;

    GetDivOffset;
    case fChange of
      yyMonth :
        begin
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
      yyDay :
        begin
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
      yyYear :
        begin
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
    end; { case }
    SelStart := FSelStart;
    SelLength := FSelLength;
    Modified := True;
  end;

function TKingMDYSpin.GetSelected : boolean;
  begin
    Result := ( SelText <> '' );
  end;

function TKingMDYSpin.GetSelValue : word;
  var
    yy, mm, dd : word;
  begin
    if ( SelText = '' )
    then
      Result := 0
    else
    begin
      { Result := StrToInt( SelText ); }
      DecodeDate( Value, yy, mm, dd );
      case fChange of
        yyMonth :
          Result := mm;
        yyDay :
          Result := dd;
        yyYear :
          Result := yy;
        else
          Result := 0;
      end; { case }
    end;
  end;

procedure TKingMDYSpin.SetSelValue( NewValue : word );
  var
    yy, mm, dd : word;

    procedure AdjustMonth( var month, year : word );
      begin
        if month > 12
        then
        begin
          Inc( year );
          month := 1;
        end
        else if month < 1
        then
        begin
          Dec( year );
          month := 12;
        end;
      end;

    procedure AdjustDay( var Day, month, year : word );
      begin
        if Day < 1
        then
        begin
          Dec( month );
          AdjustMonth( month, year );
          Day := kcMonthDays( month, year );
        end
        else if Day > kcMonthDays( month, year )
        then
        begin
          Inc( month );
          AdjustMonth( month, year );
          Day := 1;
        end;
      end;

  begin
    DecodeDate( Value, yy, mm, dd );

    case fChange of
      yyMonth :
        begin
          AdjustMonth( NewValue, yy );
          Value := EncodeDate( yy, NewValue, dd );
        end;
      yyDay :
        begin
          AdjustDay( NewValue, mm, yy );
          Value := EncodeDate( yy, mm, NewValue );
        end;
      yyYear :
        begin
          if ( dd = kcMonthDays( mm, yy ) )
          then
            dd := kcMonthDays( mm, NewValue );
          Value := EncodeDate( NewValue, mm, dd );
        end;
    end; { case }
  end;

procedure TKingMDYSpin.CMEnter( var Message : TCMGotFocus );
  begin
    if AutoSelect and not ( csLButtonDown in ControlState )
    then
      SelectAll;
    inherited;
  end;

end.
