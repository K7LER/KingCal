program Startday;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  TStyleManager.TrySetStyle('Windows10 Green');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
