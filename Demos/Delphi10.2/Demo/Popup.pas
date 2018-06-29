unit Popup;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, KingPop, ExtCtrls;

type
  TFrmPopup = class(TForm)
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    KingPopup1: TKingPopup;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPopup: TFrmPopup;

implementation

{$R *.DFM}

procedure TFrmPopup.BitBtn1Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmPopup.FormCreate(Sender: TObject);
begin
  Edit1.Text := DateToStr( Date );
  Edit2.Text := DateToStr( Date );
end;

procedure TFrmPopup.SpeedButton1Click(Sender: TObject);
begin
  KingPopup1.PopupDate := StrToDate( Edit1.Text );
  KingPopup1.AlignSource := Edit1;
  if KingPopup1.Execute then
    Edit1.Text := DateToStr( KingPopup1.PopupDate );
end;

procedure TFrmPopup.SpeedButton2Click(Sender: TObject);
begin
  KingPopup1.PopupDate := StrToDate( Edit2.Text );
  KingPopup1.AlignSource := Edit2;
  if KingPopup1.Execute then
    Edit2.Text := DateToStr( KingPopup1.PopupDate );

end;

procedure TFrmPopup.Edit1DblClick(Sender: TObject);
begin
  SpeedButton1Click( Sender );
end;

procedure TFrmPopup.Edit2DblClick(Sender: TObject);
begin
  SpeedButton2Click( Sender );
end;

end.
