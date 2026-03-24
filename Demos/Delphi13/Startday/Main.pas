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
  VCL.ExtCtrls,
  VCL.Buttons,
  KingTool,
  TheKing,
  KingPop,
  KingDlg;

type
  TForm1 = class( TForm )
    KingCalendar1 : TKingCalendar;
    RadioGroup1 : TRadioGroup;
    procedure RadioGroup1Click( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  Form1 : TForm1;

implementation

{$R *.DFM}

procedure TForm1.RadioGroup1Click( Sender : TObject );
  begin
    KingCalendar1.StartingDay := RadioGroup1.ItemIndex;
    KingCalendar1.SetFocus;
  end;

end.
