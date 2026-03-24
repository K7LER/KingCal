unit Misc;

interface

uses
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.Math,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls,
  VCL.Buttons,
  VCL.ExtCtrls,
  VCL.Grids,
  Vcl.Samples.Spin,
  TheKing,
  KingTool;

type
  TFrmMisc = class( TForm )
    BitBtn1 : TBitBtn;
    KingCalendar1 : TKingCalendar;
    GroupBox1 : TGroupBox;
    Label1 : TLabel;
    MonthCombo1 : TMonthCombo;
    DayCombo1 : TDayCombo;
    YearCombo1 : TYearCombo;
    Label2 : TLabel;
    Label3 : TLabel;
    Label4 : TLabel;
    GroupBox2 : TGroupBox;
    Label5 : TLabel;
    MonthSpin1 : TMonthSpin;
    DaySpin1 : TDaySpin;
    YearSpin1 : TYearSpin;
    Label6 : TLabel;
    Label7 : TLabel;
    Label8 : TLabel;
    GroupBox3 : TGroupBox;
    Label9 : TLabel;
    Label10 : TLabel;
    KingLabel1 : TKingLabel;
    Bevel1 : TBevel;
    Label11 : TLabel;
    Label12 : TLabel;
    Label13 : TLabel;
    Label14 : TLabel;
    procedure BitBtn1Click( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  FrmMisc : TFrmMisc;

implementation

{$R *.DFM}

procedure TFrmMisc.BitBtn1Click( Sender : TObject );
  begin
    Close;
  end;

end.
