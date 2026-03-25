{
   TKingCalendar Database Date Dialog Component
   KingCalendar Components v1.3 for Delphi v1.x, v2.x && 3.x
   Copyright © 1995,1996 AppVision Software, All Rights Reserved
}

unit DBKing;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, Buttons, Spin, kingpop, ExtCtrls, DB,
  DBTables,
  dbctrls,
  Mask;


type
  TDBKingDlg = class(TCustomMaskEdit)
  private
    FAbout: String;
    FButton: TSpeedButton;
    FPopup: TKingPopup;
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
    FTextMargin: Integer;
    procedure CalcTextMargin;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    function GetMinHeight: Integer;
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  protected
    procedure BtnClick (Sender: TObject); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Reset; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: TSpeedButton read FButton;
    procedure Loaded; override;
    property Field: TField read GetField;

  published
    property About: String read FAbout write FAbout;
    property KingPopup: TKingPopup read FPopup write FPopup;
    property DragCursor;
    property DragMode;

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;


implementation

uses DBIErrs, DBITypes, Clipbrd, DBConsts;

{***************************************************************************}
constructor TDBKingDlg.Create(AOwner: TComponent);
Var
  I: Integer;

begin
  inherited Create(AOwner);
  inherited ReadOnly := True;

  FButton              := TSpeedButton.Create (Self);
  FButton.Width        := 21;
  FButton.Height       := 17;
  FButton.Visible      := True;
  FButton.Glyph.Handle := LoadBitmap( HInstance, 'BTN_CALENDAR' );
  FButton.NumGlyphs    := 1;
  FButton.OnClick      := BtnClick;
  FButton.Parent       := Self;
  FButton.Cursor       := crArrow;

  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;
  FDataLink.OnDataChange    := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData    := UpdateData;

  Width := 113;

  ControlStyle := ControlStyle - [csSetCaption];

  for I := 0 to TForm( AOwner ).ComponentCount-1 do begin
      if TForm( AOwner ).Components[I] is TKingPopup then begin
        FPopup := TKingPopup( TForm( AOwner ).Components[I]);
        Break;
      end;
  end;

  if Assigned( FPopup ) and ( TKingpopup( FPopup ).AlignSource = nil ) then
     TKingPopup( FPopup ).AlignSource := Self;

  CalcTextMargin;
end;


{***************************************************************************}
destructor TDBKingDlg.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  FButton := nil;
  inherited Destroy;
end;


{***************************************************************************}
procedure TDBKingDlg.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;

  if ( Operation = opRemove ) and ( AComponent = FPopup ) then
     FPopup := nil;

end;


{***************************************************************************}
procedure TDBKingDlg.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

{***************************************************************************}
procedure TDBKingDlg.KeyPress(var Key: Char);
begin
	inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

{***************************************************************************}
function TDBKingDlg.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

{***************************************************************************}
procedure TDBKingDlg.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

{***************************************************************************}
procedure TDBKingDlg.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

{***************************************************************************}
procedure TDBKingDlg.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

{***************************************************************************}
function TDBKingDlg.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{***************************************************************************}
procedure TDBKingDlg.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

{***************************************************************************}
function TDBKingDlg.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;


{***************************************************************************}
procedure TDBKingDlg.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{***************************************************************************}
function TDBKingDlg.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{***************************************************************************}
procedure TDBKingDlg.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{***************************************************************************}
function TDBKingDlg.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{***************************************************************************}
procedure TDBKingDlg.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if FDataLink.Field.DataType = ftString then
      MaxLength := FDataLink.Field.Size else
      MaxLength := 0;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
      EditText := FDataLink.Field.DisplayText;
  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    MaxLength := 0;
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

{***************************************************************************}
procedure TDBKingDlg.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

{***************************************************************************}
procedure TDBKingDlg.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

{***************************************************************************}
procedure TDBKingDlg.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

{***************************************************************************}
procedure TDBKingDlg.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

{***************************************************************************}
procedure TDBKingDlg.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

{***************************************************************************}
procedure TDBKingDlg.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  SetCursor(0);
  DoExit;
end;

{***************************************************************************}
procedure TDBKingDlg.WMPaint(var Message: TWMPaint);
var
  Width, Indent, Left, I: Integer;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
  if (FAlignment = taLeftJustify) or FFocused then
  begin
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      S := EditText;
      if PasswordChar <> #0 then
      begin
        for I := 1 to Length(S) do
          S[I] := PasswordChar;
      end;
      Width := TextWidth(S);
      if BorderStyle = bsNone then Indent := 0 else Indent := FTextMargin;
      if FAlignment = taRightJustify then
        Left := R.Right - Width - Indent else
        Left := (R.Left + R.Right - Width) div 2;
      TextRect(R, Left, Indent, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

{***************************************************************************}
procedure TDBKingDlg.CMFontChanged(var Message: TMessage);
begin
  inherited;
  CalcTextMargin;
end;

{***************************************************************************}
procedure TDBKingDlg.CalcTextMargin;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  FTextMargin := I div 4;
end;

{***************************************************************************}
procedure TDBKingDlg.Loaded;
begin
  inherited Loaded;

end;

{***************************************************************************}
procedure TDBKingDlg.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {  Params.Style := Params.Style and not WS_BORDER;  }
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;


{***************************************************************************}
procedure TDBKingDlg.CreateWnd;
//hint var
//hint  Loc: TRect;
begin
  inherited CreateWnd;
  SetEditRect;
end;


{***************************************************************************}
procedure TDBKingDlg.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight;
  Loc.Right := ClientWidth - FButton.Width - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));  {debug}
end;

{***************************************************************************}
procedure TDBKingDlg.WMSize(var Message: TWMSize);
var
//hint  Loc: TRect;
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    FButton.SetBounds (Width - FButton.Width, 0, FButton.Width, Height);
    SetEditRect;
  end;
end;

{***************************************************************************}
function TDBKingDlg.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

{***************************************************************************}
procedure TDBKingDlg.BtnClick (Sender: TObject);
begin
  if Assigned( FPopup ) then begin
     try
       if fDataLink.Field <> nil then begin
         if fDataLink.Field.AsDateTime <> 0 then { MDS - if date is not null, set to current value}
            FPopup.PopupDate:= fDataLink.Field.AsDateTime
         else
            FPopup.PopupDate:= Now;

         FPopup.AlignSource := Self; {MDS - Align to current control}
         if FPopup.execute then Begin
           fDataLink.Edit;
           Text := DateToStr( FPopup.Popupdate );
           fDataLink.Field.AsDateTime:= FPopup.PopupDate;
         end;
         end;
     except
       raise;
     end;
  end;

end;


end.


