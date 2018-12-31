unit Caldemo;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, TheKing, ExtCtrls, Grids;

type
  TFrmCalendar = class(TForm)
    BitBtn1: TBitBtn;
    KingCalendar1: TKingCalendar;
    ComboBox1: TComboBox;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalendar: TFrmCalendar;

implementation

uses Year, Month;

{$R *.DFM}

procedure TFrmCalendar.ComboBox1Change(Sender: TObject);
begin
  KingCalendar1.StartingDay := Combobox1.ItemIndex;
end;

procedure TFrmCalendar.FormCreate(Sender: TObject);
begin
  Combobox1.ItemIndex := 0;
end;

procedure TFrmCalendar.CheckBox1Click(Sender: TObject);
begin
  KingCalendar1.ShowGridLines := Checkbox1.Checked;
end;

procedure TFrmCalendar.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0: KingCalendar1.TextPlacement := ktCenter;
    1: KingCalendar1.TextPlacement := ktLowerLeft;
    2: KingCalendar1.TextPlacement := ktTopLeft;
    3: KingCalendar1.TextPlacement := ktTopRight;
    4: KingCalendar1.TextPlacement := ktLowerRight;
  end;
end;

procedure TFrmCalendar.BitBtn2Click(Sender: TObject);
begin
  FontDialog1.Font.Assign( KingCalendar1.Font );
  if FontDialog1.Execute then
    KingCalendar1.Font := FontDialog1.Font;
end;

procedure TFrmCalendar.BitBtn3Click(Sender: TObject);
begin
 FontDialog1.Font.Assign( KingCalendar1.TitleFont );
  if FontDialog1.Execute then
    KingCalendar1.TitleFont := FontDialog1.Font ;

 end;

procedure TFrmCalendar.BitBtn5Click(Sender: TObject);
begin
  ColorDialog1.Color := KingCalendar1.TitleColor;
  if ColorDialog1.Execute then
    KingCalendar1.TitleColor := ColorDialog1.Color;
end;

procedure TFrmCalendar.BitBtn4Click(Sender: TObject);
begin
  ColorDialog1.Color := KingCalendar1.Highlight;
  if ColorDialog1.Execute then
    KingCalendar1.Highlight := ColorDialog1.Color;
end;

procedure TFrmCalendar.BitBtn6Click(Sender: TObject);
begin
  ColorDialog1.Color := KingCalendar1.HighlightText;
  if ColorDialog1.Execute then
    KingCalendar1.HighlightText := ColorDialog1.Color;
end;

procedure TFrmCalendar.BitBtn7Click(Sender: TObject);
begin
  ColorDialog1.Color := KingCalendar1.CellColor;
  if ColorDialog1.Execute then
    KingCalendar1.CellColor := ColorDialog1.Color;
end;

procedure TFrmCalendar.BitBtn8Click(Sender: TObject);
begin
  ColorDialog1.Color := KingCalendar1.TodayColor;
  if ColorDialog1.Execute then
    KingCalendar1.TodayColor := ColorDialog1.Color;
end;

procedure TFrmCalendar.BitBtn9Click(Sender: TObject);
begin
  ColorDialog1.Color := KingCalendar1.GridLineColor;
  if ColorDialog1.Execute then
    KingCalendar1.GridLineColor := ColorDialog1.Color;
end;

procedure TFrmCalendar.Button3Click(Sender: TObject);
begin
  KingCalendar1.ClearAllDays;
  KingCalendar1.TextInCell := False;
  KingCalendar1.TextPlacement := ktCenter;
end;

procedure TFrmCalendar.Button1Click(Sender: TObject);
var
Flags: TKingFlags;
  X, Level, Day: Integer;
begin
  KingCalendar1.TextInCell    := False;
  KingCalendar1.ColorCellText := False;
  KingCalendar1.ColorCellDay  := True;
  for x := 1 to DaysInAMonth(YearOf(KingCalendar1.CalendarDate),MonthOf(KingCalendar1.CalendarDate)) do
    begin
      Level := Random( 10 );
      Day   := RandomRange(1, DaysInAMonth(YearOf(KingCalendar1.CalendarDate),MonthOf(KingCalendar1.CalendarDate)) );
      Flags[ Day ] := Level;
    end;

  KingCalendar1.SetMonthFlags( Flags );
  KingCalendar1.UpdateCalendar;

end;

procedure TFrmCalendar.Button2Click(Sender: TObject);
var
  X, Level, Day: Integer;
begin
  KingCalendar1.TextInCell    := True;
  KingCalendar1.ColorCellText := True;
  KingCalendar1.ColorCellDay  := False;
  KingCalendar1.TextPlacement := ktTopLeft;
  for x := 1 to DaysInAMonth(YearOf(KingCalendar1.CalendarDate),MonthOf(KingCalendar1.CalendarDate)) do
   begin
    Level := Random(10);
    Day   := RandomRange(1, DaysInAMonth(YearOf(KingCalendar1.CalendarDate),MonthOf(KingCalendar1.CalendarDate)) );
    KingCalendar1.SetDateFlag( Day, Level, 'Example Text' );
   end;
   KingCalendar1.UpdateCalendar;

end;

procedure TFrmCalendar.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
