unit Mthtext;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, KingTool, KingBase, TheKing;

type
  TFrmMonthText = class(TForm)
    KingCalendar1: TKingCalendar;
    KingLabel1: TKingLabel;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMonthText: TFrmMonthText;

implementation

{$R *.DFM}

end.
