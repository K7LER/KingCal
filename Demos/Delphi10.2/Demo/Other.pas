unit Other;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, KingSpin, StdCtrls, Kingcalc, KingDlg, KingPop;

type
  TFrmOther = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    KingTimeSpin1: TKingTimeSpin;
    KingDateSpin1: TKingDateSpin;
    Label12: TLabel;
    Label13: TLabel;
    KingCalc1: TKingCalc;
    GroupBox3: TGroupBox;
    KingPopup1: TKingPopup;
    KingDateDialog1: TKingDateDialog;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOther: TFrmOther;

implementation

{$R *.DFM}

procedure TFrmOther.Button1Click(Sender: TObject);
begin
 KingCalc1.Display;
end;

procedure TFrmOther.FormCreate(Sender: TObject);
begin
  KingDateDialog1.Text := DateToStr( Date );
end;

end.
