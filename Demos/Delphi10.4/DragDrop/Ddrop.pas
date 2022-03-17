unit Ddrop;

interface

uses
  System.SysUtils,
  System.Classes,
  System.UITypes,
  WinAPI.Windows,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls,
  VCL.Grids,
  TheKing,
  KingTool;

type
  TFrmMain = class( TForm )
    KingCalendar1 : TKingCalendar;
    ListBox1 : TListBox;
    ListBox2 : TListBox;
    ListBox3 : TListBox;
    Label1 : TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    ListBox4 : TListBox;
    ListBox5 : TListBox;
    ListBox6 : TListBox;
    Label4 : TLabel;
    Label5 : TLabel;
    Label6 : TLabel;
    KingLabel1 : TKingLabel;
    procedure KingCalendar1DragOver(
      Sender, Source : TObject;
      X, Y           : Integer;
      State          : TDragState;
      var Accept     : Boolean );
    procedure KingCalendar1DragDrop(
      Sender, Source : TObject;
      X, Y           : Integer );
    procedure KingCalendar1DayFlag( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  FrmMain : TFrmMain;

implementation

{$R *.DFM}

procedure TFrmMain.KingCalendar1DragOver(
  Sender, Source : TObject;
  X, Y           : Integer;
  State          : TDragState;
  var Accept     : Boolean );
  begin
    Accept := True;
  end;

procedure TFrmMain.KingCalendar1DragDrop(
  Sender, Source : TObject;
  X, Y           : Integer );
  var
    Text : String;
  begin
    if ( Source is TListBox )
    then
      if not ( TListBox( Source ).ItemIndex > TListBox( Source ).Items.Count )
      then
      begin
        Text := TListBox( Source ).Items[ TListBox( Source ).ItemIndex ];
        TKingCalendar( Sender ).AcceptDropped( X, Y,
          TListBox( Source ).Tag, Text );
      end;
  end;

procedure TFrmMain.KingCalendar1DayFlag( Sender : TObject );
  begin
    MessageBeep( MB_ICONQUESTION );
    MessageDlg( 'You have a type ' + IntToStr( KingCalendar1.GetApptLevel ) +
      ' Appointment Today!', mtInformation, [ mbOk ], 0 );
  end;

end.
