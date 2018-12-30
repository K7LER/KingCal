unit Advance;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, KingTool, ExtCtrls, TheKing, Grids;

type
  TFrmAdvance = class(TForm)
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    KingLabel1: TKingLabel;
    ListBox1: TListBox;
    Label1: TLabel;
    ListBox2: TListBox;
    Label2: TLabel;
    ListBox3: TListBox;
    Label3: TLabel;
    Bevel2: TBevel;
    GroupBox1: TGroupBox;
    Button2: TButton;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Button1: TButton;
    KingNavigator1: TKingNavigator;
    Button3: TButton;
    KingCalendar1: TKingCalendar;
    procedure KingCalendar1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure KingCalendar1DragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAdvance: TFrmAdvance;

implementation

uses Year, Month3;

{$R *.DFM}

procedure TFrmAdvance.KingCalendar1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TFrmAdvance.KingCalendar1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
 Text: String;
begin
  if ( Source is TListbox ) then
    if not ( TListBox( Source ).ItemIndex > TListBox( Source ).Items.Count ) then
       begin
         Text := TListBox( Source ).Items[ TListBox( Source ).ItemIndex ];
         TKingCalendar( Sender ).AcceptDropped( X, Y, TListBox( Source ).Tag, Text );
       end;
end;

procedure TFrmAdvance.Button2Click(Sender: TObject);
var
  FrmYear: TFrmYear;
begin
 FrmYear := TFrmYear.Create(Self);
 try
   FrmYear.ShowModal;
 finally
   FrmYear.Free;
 end;

 end;

procedure TFrmAdvance.Button1Click(Sender: TObject);
begin
  KingCalendar1.BlockWeekends := not( KingCalendar1.BlockWeekends );
  if KingCalendar1.BlockWeekends then
    Button1.Caption := 'Enable &Weekends'
  else
    Button1.Caption := 'Block &Weekends';
end;

procedure TFrmAdvance.Button3Click(Sender: TObject);
var
  FrmMonth: TFrm3Month;
begin
 FrmMonth := TFrm3Month.Create(Self);
 try
   FrmMonth.ShowModal;
 finally
   FrmMonth.Free;
 end;
end;

procedure TFrmAdvance.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
