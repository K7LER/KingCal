unit Year;

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
  TFrmYear = class( TForm )
    Button1 : TButton;
    SpinEdit1 : TSpinEdit;
    Label1 : TLabel;
    Label2 : TLabel;
    KingCalendar1 : TKingCalendar;
    KingCalendar2 : TKingCalendar;
    KingCalendar3 : TKingCalendar;
    KingCalendar4 : TKingCalendar;
    KingCalendar5 : TKingCalendar;
    KingCalendar6 : TKingCalendar;
    KingCalendar7 : TKingCalendar;
    KingCalendar8 : TKingCalendar;
    KingCalendar9 : TKingCalendar;
    KingCalendar10 : TKingCalendar;
    KingCalendar11 : TKingCalendar;
    KingCalendar12 : TKingCalendar;
    KingLabel1 : TKingLabel;
    KingLabel2 : TKingLabel;
    KingLabel3 : TKingLabel;
    KingLabel4 : TKingLabel;
    KingLabel5 : TKingLabel;
    KingLabel6 : TKingLabel;
    KingLabel7 : TKingLabel;
    KingLabel8 : TKingLabel;
    KingLabel9 : TKingLabel;
    KingLabel10 : TKingLabel;
    KingLabel11 : TKingLabel;
    KingLabel12 : TKingLabel;
    procedure FormCreate( Sender : TObject );
    procedure Button1Click( Sender : TObject );
    procedure SpinEdit1Change( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  FrmYear : TFrmYear;

implementation

{$R *.DFM}

procedure TFrmYear.FormCreate( Sender : TObject );
  var
    AYear, AMonth, ADay : Word;
    ActiveMonth : TComponent;
    Y : Integer;
  begin
    DecodeDate( Date, AYear, AMonth, ADay );

    for Y := 1 to 12 do
    begin
      ActiveMonth := FindComponent( 'KingCalendar' + IntToStr( Y ) );
      TKingCalendar( ActiveMonth ).Month := Y;
      TKingCalendar( ActiveMonth ).Year := AYear;
    end;

    SpinEdit1.text := IntToStr( AYear );

  end;

procedure TFrmYear.Button1Click( Sender : TObject );
  var
    W, X, Y, Z : Integer;
    ACalendar : TComponent;
    aColoring : Array [ 1 .. 12 ] of TKingFlags;
  begin

    Screen.Cursor := crHourglass;
    for W := 1 to 40 do
    begin
//      X := Random( 12 );
//      if ( X = 0 )
//      then
//        X := 1;

      Y := Random( 28 );
      if ( Y = 0 )
      then
        Y := 1;

      Z := Random( 9 );
      if ( Z = 0 )
      then
        Z := 1;

      aColoring[ Z ][ Y ] := Z;
    end;

    for X := 1 to 12 do
    begin
      ACalendar := FindComponent( 'KingCalendar' + IntToStr( X ) );
      TKingCalendar( ACalendar ).SetMonthFlags( aColoring[ X ] );
    end;

    Screen.Cursor := crDefault;
  end;

procedure TFrmYear.SpinEdit1Change( Sender : TObject );
  var
    X, nYear : Integer;
    ACOmponent : TComponent;
  begin
    nYear := StrToInt( SpinEdit1.text );
    for X := 1 to 12 do
    begin
      ACOmponent := FindComponent( 'KingCalendar' + IntToStr( X ) );
      TKingCalendar( ACOmponent ).Year := nYear;
    end;
  end;

end.
