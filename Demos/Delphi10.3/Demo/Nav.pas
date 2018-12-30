unit Nav;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, TheKing, ExtCtrls, KingTool,
  KingSpin, Grids;

type
  TFrmNavigate = class(TForm)
    BitBtn1: TBitBtn;
    KingCalendar1: TKingCalendar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    KingNavigator1: TKingNavigator;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    MonthBar1: TMonthBar;
    CheckBox1: TCheckBox;
    KingLabel1: TKingLabel;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    KingTimeSpin1: TKingTimeSpin;
    KingDateSpin1: TKingDateSpin;
    Label11: TLabel;
    Label12: TLabel;
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNavigate: TFrmNavigate;

implementation

{$R *.DFM}


procedure TFrmNavigate.CheckBox1Click(Sender: TObject);
begin
  KingNavigator1.CaptionInToday := Checkbox1.Checked;
end;

procedure TFrmNavigate.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
