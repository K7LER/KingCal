{ *                                                                                * }
{ *  unit KingSpnt                                                                 * }
{ *  TKingHMSpin Component                                                         * }
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

unit KingSpnt;

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
  TheKing;

type
  TTimeChangeType = ( yyHour, yyMin, yySec, yyMicroSec, yyDay, yyUnknown );

  { TKingHMSpin }
  TKingHMSpin = class( TCustomEdit )
    private
      fUseDay : boolean;
      fChange : TTimeChangeType;
      FSelected : boolean;
      FSelStart : Integer;
      FSelLength : Integer;
      fOffset1 : Integer;
      fOffset2 : Integer;
      FAbout : String;
      FTimeFormat : String;
      FStartTime : String;
      // hint    FCanvas: TCanvas;
      FIncrement : Integer;
      FButton : TSpinButton;
      function GetMinHeight : Integer;
      function GetValue : TDateTime;
      procedure SetValue( NewValue : TDateTime );
      function GetSelected : boolean;
      procedure WMKeyDown( var Message : TWMKeyDown ); message WM_KEYDOWN;
      procedure GetDivOffset;
      procedure GotoPre( Sender : TObject );
      procedure GotoNxt( Sender : TObject );
      procedure SetEditRect;
      procedure WMSize( var Message : TWMSize ); message WM_SIZE;
      procedure CMEnter( var Message : TCMGotFocus ); message CM_ENTER;
      procedure CMExit( var Message : TCMExit ); message CM_EXIT;
    protected
      procedure MouseDown(
        Button : TMouseButton;
        shift  : TShiftState;
        x, y   : Integer ); override;
      procedure MouseUp(
        Button : TMouseButton;
        shift  : TShiftState;
        x, y   : Integer ); override;
      function IsValidChar( Key : Char ) : boolean; virtual;
      procedure UpClick( Sender : TObject ); virtual;
      procedure DownClick( Sender : TObject ); virtual;
      procedure KeyDown(
        var Key : Word;
        shift   : TShiftState ); override;
      procedure KeyPress( var Key : Char ); override;
      procedure CreateParams( var Params : TCreateParams ); override;
      procedure CreateWnd; override;
      function IncrementTime( nIncBy : Integer ) : TDateTime;
      function DecrementTime( nIncBy : Integer ) : TDateTime;
      function IncrementSelValue( nIncBy : Integer ) : TDateTime;
      function DecrementSelValue( nIncBy : Integer ) : TDateTime;
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
      property Selected : boolean
        read GetSelected
        write FSelected;
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

implementation

{ TKingHMSpin }
constructor TKingHMSpin.Create( AOwner : TComponent );
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
    fUseDay := True;
  end;

destructor TKingHMSpin.Destroy;
  begin
    FButton := nil;
    inherited Destroy;
  end;

procedure TKingHMSpin.GetDivOffset;
  var
    // tChk: Integer;
    // tPos : Integer;
    i : Integer;
    tText : String;
    { This Offset counts from 0 }
  begin
    fOffset1 := 0;
    fOffset2 := 0;
    tText := Text;

    { looks for the 2nd Offset }
    i := Length( tText );
    repeat
      if ( tText[ i ] = ' ' )
      then
      begin
        fOffset2 := i - 1;
        tText := Copy( tText, 1, fOffset2 - 1 );
      end
      else
        try;
          // tChk := StrToInt( tText[i] );
        except
          on E : EConvertError do
            if ( uppercase( tText[ i ] ) <> 'A' ) and
              ( uppercase( tText[ i ] ) <> 'P' ) and
              ( uppercase( tText[ i ] ) <> 'M' )
            then
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
      if ( tText[ i ] = ' ' )
      then
      begin
        fOffset1 := i - 1;
        tText := Copy( tText, 1, fOffset1 - 1 );
      end
      else
        try
          // tChk := StrToInt( tText[i] );
            ;
        except
          on E : EConvertError do
            if ( uppercase( tText[ i ] ) <> 'A' ) and
              ( uppercase( tText[ i ] ) <> 'P' ) and
              ( uppercase( tText[ i ] ) <> 'M' )
            then
              fOffset1 := i - 1;
        end;
      Dec( i );
    until ( fOffset1 <> 0 ) or ( i = 0 );

    if ( Pos( 'A', uppercase( Text ) ) > 0 ) or
      ( Pos( 'P', uppercase( Text ) ) > 0 )
    then
      fUseDay := True
    else
      fUseDay := False;
  end;

procedure TKingHMSpin.Loaded;
  begin
    inherited Loaded;
    Text := FStartTime;

    GetDivOffset;
    SelStart := 0;
    SelLength := fOffset1;
    FSelStart := 0;
    FSelLength := fOffset1;
    Modified := True;
  end;

procedure TKingHMSpin.SetStartTime( oTime : String );
  begin
    FStartTime := oTime;
    Text := FStartTime;
  end;

procedure TKingHMSpin.GotoPre( Sender : TObject );
  begin
    case fChange of
      yyHour :
        begin
          if fUseDay
          then
            fChange := yyDay
          else
            fChange := yySec;
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
      yyMin :
        begin
          fChange := yyHour;
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
      yyDay :
        begin
          fChange := yyMin;
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
      yySec :
        begin
          fChange := yyMin;
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
    end; { case }
  end;

procedure TKingHMSpin.GotoNxt( Sender : TObject );
  begin
    case fChange of
      yyHour :
        begin
          fChange := yyMin;
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
      yyMin :
        begin
          if fUseDay
          then
            fChange := yyDay
          else
            fChange := yySec;
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
      yyDay :
        begin
          fChange := yyHour;
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
      yySec :
        begin
          fChange := yyHour;
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
    end; { case }
  end;

procedure TKingHMSpin.WMKeyDown( var Message : TWMKeyDown );
  begin
    inherited;

    SelStart := FSelStart;
    SelLength := FSelLength;
    Modified := True;
  end;

procedure TKingHMSpin.MouseUp(
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
        yyHour :
          begin
            FSelStart := 0;
            FSelLength := fOffset1;
          end;
        yyMin :
          begin
            FSelStart := fOffset1 + 1;
            FSelLength := fOffset2 - fOffset1 - 1;
          end;
        yyDay :
          begin
            FSelStart := fOffset2 + 1;
            FSelLength := Length( Text ) - fOffset2 - 1;
          end;
        yySec :
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

procedure TKingHMSpin.MouseDown(
  Button : TMouseButton;
  shift  : TShiftState;
  x, y   : Integer );
  // var
  // hint tStr : String;
  // hint  tInt : Integer;
  // hint  tChk : Integer;
  begin
    Inherited MouseDown( Button, shift, x, y );

    FSelStart := SelStart;
    if ( SelStart < fOffset1 )
    then
    begin
      fChange := yyHour;
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
      fChange := yyMin;
      FSelStart := fOffset1 + 1;
      FSelLength := fOffset2 - fOffset1 - 1;
    end
    else if ( SelStart > fOffset2 )
    then
    begin
      if fUseDay
      then
        fChange := yyDay
      else
        fChange := yySec;
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

procedure TKingHMSpin.KeyDown(
  var Key : Word;
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

procedure TKingHMSpin.KeyPress( var Key : Char );
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

function TKingHMSpin.IsValidChar( Key : Char ) : boolean;
  begin
    Result := ( ( Key < #32 ) and ( Key <> Chr( VK_RETURN ) ) );
  end;

procedure TKingHMSpin.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

procedure TKingHMSpin.CreateWnd;
  // var
  // Loc: TRect;
  begin
    inherited CreateWnd;
    SetEditRect;
  end;

procedure TKingHMSpin.SetEditRect;
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

procedure TKingHMSpin.WMSize( var Message : TWMSize );
  var
    // Loc: TRect;
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

function TKingHMSpin.GetMinHeight : Integer;
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

procedure TKingHMSpin.UpClick( Sender : TObject );
  begin
    if Selected
    then
      Value := IncrementSelValue( FIncrement )
    else
      Value := IncrementTime( FIncrement );
  end;

procedure TKingHMSpin.DownClick( Sender : TObject );
  begin
    if Selected
    then
      Value := DecrementSelValue( FIncrement )
    else
      Value := DecrementTime( FIncrement );
  end;

procedure TKingHMSpin.CMExit( var Message : TCMExit );
  begin
    inherited;
    SetValue( Value );
  end;

function TKingHMSpin.GetValue : TDateTime;
  begin
    if ( Text = '' )
    then
      Text := FStartTime;

    Result := StrToTime( Text );
  end;

procedure TKingHMSpin.SetValue( NewValue : TDateTime );
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

    GetDivOffset;
    case fChange of
      yyHour :
        begin
          FSelStart := 0;
          FSelLength := fOffset1;
        end;
      yyMin :
        begin
          FSelStart := fOffset1 + 1;
          FSelLength := fOffset2 - fOffset1 - 1;
        end;
      yySec :
        begin
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
      yyDay :
        begin
          FSelStart := fOffset2 + 1;
          FSelLength := Length( Text ) - fOffset2 - 1;
        end;
    end; { case }
    SelStart := FSelStart;
    SelLength := FSelLength;
    Modified := True;
  end;

procedure TKingHMSpin.CMEnter( var Message : TCMGotFocus );
  begin
    if AutoSelect and not ( csLButtonDown in ControlState )
    then
      SelectAll;
    inherited;
  end;

function TKingHMSpin.IncrementSelValue( nIncBy : Integer ) : TDateTime;
  var
    Hour, Min, Sec, mSec : Word;
    Min2, Sec2 : Word;
  begin
    DecodeTime( Value, Hour, Min, Sec, mSec );

    case fChange of
      yyHour :
        Hour := ( Hour + nIncBy ) mod 24;
      yyMin :
        begin
          Min := Min + nIncBy;
          if ( Min > 59 )
          then
          begin
            Min2 := Min;
            Min := Min mod 60;
            Hour := Hour + ( Min2 div 60 );
          end;
        end;
      yySec :
        begin
          Sec := Sec + nIncBy;
          if ( Sec > 59 )
          then
          begin
            Sec2 := Sec;
            Sec := Sec mod 60;
            Min := Min + ( Sec2 div 60 );
          end;
        end;
      yyDay :
        Hour := ( Hour + ( 12 * nIncBy ) ) mod 24;
    end; { case }

    if fUseDay
    then
      Result := EncodeTime( Hour, Min, 0, 0 )
    else
      Result := EncodeTime( Hour, Min, Sec, 0 );
  end;

function TKingHMSpin.DecrementSelValue( nIncBy : Integer ) : TDateTime;
  var
    Hour, Min, Sec, mSec : Word;
    // min2, sec2 : word;
  begin
    DecodeTime( Value, Hour, Min, Sec, mSec );

    case fChange of
      yyHour :
        begin
          if Hour = 0
          then
            Hour := 24;
          Hour := ( Hour - nIncBy ) mod 24;
        end;
      yyMin :
        begin
          if ( Min - nIncBy < 0 )
          then
          begin
            Min := ( 60 + Min ) - nIncBy;
            Hour := Hour - 1;
            if Hour = 0
            then
              Hour := 24;
          end
          else
            Min := Min - nIncBy;
          {
            if ( Min < 0 )then begin
            min2 := min;
            Min := 60 - ( min mod 60 );
            Hour := Hour - ( min2 div 60 );
            end;
          }
        end;
      yySec :
        begin
          if ( Sec - nIncBy < 0 )
          then
          begin
            Sec := ( 60 + Sec - nIncBy );
            if ( Min = 0 )
            then
            begin
              Min := 59;
              if ( Hour - 1 = 0 )
              then
                Hour := 24
              else
                Hour := Hour - 1;
            end
            else
              Min := Min - 1;
          end
          else
            Sec := Sec - nIncBy;
          {
            if ( sec < 0 ) then begin
            Sec := 60 - ( sec mod 60 );
            Min := Min - ( sec2 div 60 );
            end;
          }
        end;
      yyDay :
        begin
          if ( Hour - ( 12 * nIncBy ) <= 0 )
          then
            Hour := ( Hour + 24 - ( 12 * nIncBy ) ) mod 24
          else
            Hour := ( Hour - ( 12 * nIncBy ) ) mod 24;
          if Hour = 0
          then
            Hour := 24;
        end;
    end; { case }

    if fUseDay
    then
      Result := EncodeTime( Hour, Min, 0, 0 )
    else
      Result := EncodeTime( Hour, Min, Sec, 0 );
  end;

function TKingHMSpin.IncrementTime( nIncBy : Integer ) : TDateTime;
  var
    Hour, Min, Sec, mSec : Word;
    Min2 : Integer;
  begin
    DecodeTime( Value, Hour, Min, Sec, mSec );
    Min2 := Min;

    If ( ( 59 - Min ) < nIncBy )
    then
    begin
      if Hour = 23
      then
        Hour := 0
      else
        Hour := Hour + 1;
      Min2 := 0 - ( 60 - Min2 );
    end;

    Min := Min2 + nIncBy;
    Result := EncodeTime( Hour, Min, 0, 0 );
  end;

function TKingHMSpin.DecrementTime( nIncBy : Integer ) : TDateTime;
  var
    Hour, Min, Sec, mSec : Word;
  begin
    DecodeTime( Value, Hour, Min, Sec, mSec );

    If ( Min <= nIncBy )
    then
    begin
      if Hour <= 0
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

    Result := EncodeTime( Hour, Min, 0, 0 );
  end;

procedure TKingHMSpin.IncrementBy( nIncBy : Integer );
  begin
    Value := IncrementTime( nIncBy );
  end;

procedure TKingHMSpin.DecrementBy( nIncBy : Integer );
  begin
    Value := DecrementTime( nIncBy );
  end;

function TKingHMSpin.GetSelected : boolean;
  begin
    Result := ( SelText <> '' );
  end;

end.
