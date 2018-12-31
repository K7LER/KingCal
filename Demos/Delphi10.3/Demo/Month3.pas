unit Month3;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, KingTool, TheKing, ExtCtrls, Buttons,
  Grids;

type
  TFrm3Month = class(TForm)
    KingLabel1: TKingLabel;
    KingLabel2: TKingLabel;
    KingLabel3: TKingLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    OkButton: TSpeedButton;
    BadButton: TSpeedButton;
    Cal1: TKingCalendar;
    Cal2: TKingCalendar;
    Cal3: TKingCalendar;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm3Month: TFrm3Month;

implementation

{$R *.DFM}

uses
  System.DateUtils;

procedure TFrm3Month.FormCreate(Sender: TObject);
var
//  nYear, nMonth, nDay: Word;
  MyDate: TDateTime;
begin
//  DecodeDate( Date, nYear, nMonth, nDay );

  MyDate := Now;
  Cal1.Month := System.DateUtils.MonthOf(MyDate);
  Cal2.Month := System.DateUtils.MonthOf(IncMonth(Now,1));
  Cal1.Month := System.DateUtils.MonthOf(IncMonth(Now,2));


//  Cal1.Month := nMonth;
//  Cal2.Month := ( nMonth + 1 );
//  Cal3.Month := ( nMonth + 2 );

end;

procedure TFrm3Month.BitBtn4Click(Sender: TObject);
begin
  Cal1.BlockWeekends := not( Cal1.BlockWeekends );
  Cal2.BlockWeekends := not( Cal2.BlockWeekends );
  Cal3.BlockWeekends := not( Cal3.BlockWeekends );
  if Cal1.BlockWeekends then
    begin
      BitBtn4.Caption := 'Enable &Weekends';
      BitBtn4.Glyph   := OKButton.Glyph;
    end
  else
    begin
      BitBtn4.Caption := 'Block &Weekends';
      BitBtn4.Glyph   := BadButton.Glyph;
    end;

end;

procedure TFrm3Month.BitBtn2Click(Sender: TObject);
begin
  Cal1.NextMonth;
  Cal2.NextMonth;
  Cal3.NextMonth;
end;

procedure TFrm3Month.BitBtn3Click(Sender: TObject);
begin
  Cal1.PrevMonth;
  Cal2.PrevMonth;
  Cal3.PrevMonth;
end;

procedure TFrm3Month.BitBtn1Click(Sender: TObject);
begin
  Close
end;

end.
