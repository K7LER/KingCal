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
  VCL.Buttons,
  VCL.ExtCtrls;

type
  TFrmMain = class( TForm )
    Label1 : TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    GroupBox1 : TGroupBox;
    Label4 : TLabel;
    Label5 : TLabel;
    Button3 : TButton;
    GroupBox2 : TGroupBox;
    Button4 : TButton;
    Label6 : TLabel;
    Label7 : TLabel;
    GroupBox3 : TGroupBox;
    Label8 : TLabel;
    Label9 : TLabel;
    Button5 : TButton;
    Label10 : TLabel;
    GroupBox4 : TGroupBox;
    Label11 : TLabel;
    Label12 : TLabel;
    Label13 : TLabel;
    Button6 : TButton;
    Label14 : TLabel;
    Label15 : TLabel;
    Button7 : TButton;
    procedure Button2Click( Sender : TObject );
    procedure Button3Click( Sender : TObject );
    procedure Button7Click( Sender : TObject );
    procedure Button1Click( Sender : TObject );
    procedure Button4Click( Sender : TObject );
    procedure Button6Click( Sender : TObject );
    procedure Button5Click( Sender : TObject );
    procedure BitBtn1Click( Sender : TObject );

    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  FrmMain : TFrmMain;

implementation

uses
  Order,
  CalDemo,
  Popup,
  Info,
  Nav,
  Misc,
  Advance,
  Other;

{$R *.DFM}

procedure TFrmMain.Button2Click( Sender : TObject );
  begin
    Application.HelpJump( 'Ordering_Information' );
  end;

procedure TFrmMain.Button3Click( Sender : TObject );
  var
    FrmCalendar : TFrmCalendar;
  begin
    FrmCalendar := TFrmCalendar.Create( Self );
    try
      FrmCalendar.ShowModal;
    finally
      FrmCalendar.Free;
    end;

  end;

procedure TFrmMain.Button7Click( Sender : TObject );
  var
    FrmPopup : TFrmPopup;
  begin
    FrmPopup := TFrmPopup.Create( Self );
    try
      FrmPopup.ShowModal;
    finally
      FrmPopup.Free;
    end;
  end;

procedure TFrmMain.Button1Click( Sender : TObject );
  begin
    Application.HelpJump( 'Product_Information' );
  end;

procedure TFrmMain.Button4Click( Sender : TObject );
  var
    FrmNavigate : TFrmNavigate;
  begin
    FrmNavigate := TFrmNavigate.Create( Self );
    try
      FrmNavigate.ShowModal;
    finally
      FrmNavigate.Free;
    end;

  end;

procedure TFrmMain.Button6Click( Sender : TObject );
  var
    FrmMisc : TFrmMisc;
  begin
    FrmMisc := TFrmMisc.Create( Self );
    try
      FrmMisc.ShowModal;
    finally
      FrmMisc.Free;
    end;

  end;

procedure TFrmMain.Button5Click( Sender : TObject );
  var
    FrmAdvance : TFrmAdvance;
  begin

    FrmAdvance := TFrmAdvance.Create( Self );

    try
      FrmMain.Hide;
      FrmAdvance.ShowModal;
      FrmMain.Show;
    finally
      FrmAdvance.Free;
    end;

  end;

procedure TFrmMain.BitBtn1Click( Sender : TObject );
  var
    FrmOther : TFrmOther;
  begin
    FrmOther := TFrmOther.Create( Self );
    try
      FrmOther.ShowModal;
    finally
      FrmOther.Free;
    end;

  end;

end.
