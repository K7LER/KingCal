unit Month;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, KingTool, TheKing, ExtCtrls, Grids;

type
  TFrmMonthColor = class(TForm)
    KingCalendar1: TKingCalendar;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMonthColor: TFrmMonthColor;

implementation

{$R *.DFM}

procedure TFrmMonthColor.FormCreate(Sender: TObject);
begin
  KingCalendar1.SetDateFlag( 02, 01, 'Call Lance' );
  KingCalendar1.SetDateFlag( 10, 02, 'Heather Bday' );
  KingCalendar1.SetDateFlag( 10, 01, 'Call Mom' );
  KingCalendar1.SetDateFlag( 10, 05, 'Dry Cleaning!' );
  KingCalendar1.SetDateFlag( 09, 03, 'Lunch w/Dave' );
  KingCalendar1.SetDateFlag( 15, 04, '' );
  KingCalendar1.SetDateFlag( 06, 05, '' );
  KingCalendar1.SetDateFlag( 12, 06, '' );
  KingCalendar1.SetDateFlag( 25, 07, '' );
  KingCalendar1.SetDateFlag( 19, 08, '' );
  KingCalendar1.SetDateFlag( 21, 09, '' );
end;

end.
