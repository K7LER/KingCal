program Kingcal;

uses
  Forms,
  MAIN in 'MAIN.PAS' {FrmMain},
  CALDEMO in 'CALDEMO.PAS' {FrmCalendar},
  POPUP in 'POPUP.PAS' {FrmPopup},
  NAV in 'NAV.PAS' {FrmNavigate},
  MISC in 'MISC.PAS' {FrmMisc},
  ADVANCE in 'ADVANCE.PAS' {FrmAdvance},
  YEAR in 'YEAR.PAS' {FrmYear},
  MONTH3 in 'MONTH3.PAS' {Frm3Month},
  OTHER in 'OTHER.PAS' {FrmOther},
  Vcl.Themes,
  Vcl.Styles;

{$R *.RES}

begin
  TStyleManager.TrySetStyle('Windows10 Blue');
  Application.Title    := 'KingCalendar Demonstration';
  Application.HelpFile := '';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
