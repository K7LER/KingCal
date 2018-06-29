unit Main;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, KingPop, StdCtrls, Buttons, KingDlg;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    KingPopup1: TKingPopup;
    KingDateDialog1: TKingDateDialog;
    KingDateDialog2: TKingDateDialog;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
