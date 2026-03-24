program Dragdrop;

uses
  Forms,
  DDROP in 'DDROP.PAS' {FrmMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
