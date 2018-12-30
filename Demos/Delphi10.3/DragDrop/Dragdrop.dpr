program Dragdrop;

uses
  Forms,
  DDROP in 'DDROP.PAS' {FrmMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  TStyleManager.TrySetStyle('Windows10 Blue');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
