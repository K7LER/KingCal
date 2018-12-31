program Navexmpl;

uses
  Forms,
  MAIN in 'MAIN.PAS' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  TStyleManager.TrySetStyle('Windows10 Blue');
  TStyleManager.TrySetStyle('Windows10 Blue');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
