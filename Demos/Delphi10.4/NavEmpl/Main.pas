unit Main;

interface

uses
  System.SysUtils,
  System.Classes,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls,
  VCL.Samples.Spin,
  VCL.Grids,
  KingTool,
  VCL.ExtCtrls,
  TheKing;

type
  TForm1 = class( TForm )
    GroupBox1 : TGroupBox;
    KingCalendar1 : TKingCalendar;
    GroupBox2 : TGroupBox;
    KingNavigator1 : TKingNavigator;
    GroupBox3 : TGroupBox;
    MonthBar1 : TMonthBar;
    GroupBox4 : TGroupBox;
    MonthCombo1 : TMonthCombo;
    YearCombo1 : TYearCombo;
    GroupBox5 : TGroupBox;
    MonthSpin1 : TMonthSpin;
    DaySpin1 : TDaySpin;
    Label1 : TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    Memo1 : TMemo;
    YearSpin1 : TYearSpin;
    DayCombo1 : TDayCombo;
    GroupBox6 : TGroupBox;
    KingLabel1 : TKingLabel;
    GroupBox7: TGroupBox;
    KingWeekLabel1: TKingWeekLabel;
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  Form1 : TForm1;

implementation

{$R *.DFM}

end.
