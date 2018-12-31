{ *                                                                                * }
{ *  unit Kingcalc                                                                 * }
{ *  TKingCalc Component, Date Calculator                                          * }
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

unit Kingcalc;

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
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  KingSpin;

type
  TKcCalc = class( TForm )
    BitBtn1 : TBitBtn;
    Label1 : TLabel;
    SpeedButton1 : TSpeedButton;
    SpeedButton2 : TSpeedButton;
    Date1 : TKingDateSpin;
    Date2 : TEdit;
    Bevel1 : TBevel;
    dStart : TKingDateSpin;
    dEnd : TKingDateSpin;
    tDays : TEdit;
    wDays : TEdit;
    SpeedButton3 : TSpeedButton;
    Label4 : TLabel;
    Label5 : TLabel;
    Label6 : TLabel;
    Label7 : TLabel;
    NewDate : TEdit;
    Label2 : TLabel;
    Label8 : TLabel;
    Label9 : TLabel;
    Bevel2 : TBevel;
    KingDateSpin1 : TKingDateSpin;
    Label3 : TLabel;
    SpeedButton4 : TSpeedButton;
    WeekYear : TEdit;
    Label10 : TLabel;
    DayYear : TEdit;
    Label11 : TLabel;
    DayWeek : TEdit;
    Label12 : TLabel;
    procedure FormClose(
      Sender     : TObject;
      var Action : TCloseAction );
    procedure SpeedButton2Click( Sender : TObject );
    procedure SpeedButton1Click( Sender : TObject );
    procedure SpeedButton3Click( Sender : TObject );
    procedure SpeedButton4Click( Sender : TObject );
    procedure BitBtn1Click( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
  end;

  TKingCalc = class( TComponent )
    private
      FAbout : String;
    protected
    public
      constructor Create( AOwner : TComponent ); override;
      procedure display;
    published
      property About : String
        read FAbout
        write FAbout;
  end;

var
  KcCalc : TKcCalc;

implementation

uses
  KingTool;

{$R *.DFM}

{ *************************************************************************** }
constructor TKingCalc.Create( AOwner : TComponent );
  begin
    inherited Create( AOwner );
  end;

{ *************************************************************************** }
procedure TKingCalc.display;
  var
    FrmCalc : TKcCalc;
  begin

    FrmCalc := TKcCalc.Create( Self );
    FrmCalc.Show;
    FrmCalc.Update;

  end;

procedure TKcCalc.FormClose(
  Sender     : TObject;
  var Action : TCloseAction );
  begin
    Action := caFree;
  end;

procedure TKcCalc.SpeedButton2Click( Sender : TObject );
  var
    cNewDate : TDateTime;
  begin
    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    if not ( Date2.Text = '' )
    then
    begin
      cNewDate := Date1.Value + StrToInt( Date2.Text );
      // NewDate.Text := DateTimeToStr( cNewDate);
      // Need to pass the local settings in case non-standard date settings
      NewDate.Text := DateTimeToStr( cNewDate, formatSettings );
    end;
  end;

procedure TKcCalc.SpeedButton1Click( Sender : TObject );
  var
    cNewDate : TDateTime;
  begin
    // Furnish the locale format settings record
{$WARN SYMBOL_PLATFORM OFF}
    formatSettings := TFormatSettings.Create( LOCALE_SYSTEM_DEFAULT );
{$WARN SYMBOL_PLATFORM ON}
    if not ( Date2.Text = '' )
    then
    begin
      cNewDate := Date1.Value - StrToInt( Date2.Text );
      // Need to pass the local settings in case non-standard date settings
      NewDate.Text := DateTimeToStr( cNewDate, formatSettings );
      // NewDate.Text := DateTimeToStr( cNewDate );
    end;
  end;

procedure TKcCalc.SpeedButton3Click( Sender : TObject );
  var
    nDays, nWork : Integer;
  begin
    if ( dStart.Value <= dEnd.Value )
    then
    begin
      nDays := ( trunc( dEnd.Value - dStart.Value ) + 1 );
      nWork := kcWorkDays( dStart.Value, dEnd.Value );
      tDays.Text := IntToStr( nDays );
      wDays.Text := IntToStr( nWork );
    end;
  end;

procedure TKcCalc.SpeedButton4Click( Sender : TObject );
  begin
    WeekYear.Text := IntToStr( kcWeekOfYear( KingDateSpin1.Value ) );
    DayYear.Text := IntToStr( kcDayOfYear( KingDateSpin1.Value ) );
    DayWeek.Text := IntToStr( kcDayOfWeek( KingDateSpin1.Value ) );
  end;

procedure TKcCalc.BitBtn1Click( Sender : TObject );
  begin
    Close;
  end;

end.
