program Navexmpl;

uses
  Forms,
  MAIN in 'MAIN.PAS' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  TStyleManager.TrySetStyle('Glow');
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
