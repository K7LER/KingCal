{ *                                                                                * }
{ *  unit KingBase                                                                  * }
{ *  TKingBaseDateEdit - Shared base class for spin/dialog date editors             * }
{ *  KingCalendar Components v2.0 for Delphi                                       * }
{ *                                                                                * }
{ * ***** BEGIN LICENSE BLOCK *****                                                * }
{ * MIT License                                                                    * }
{ *                                                                                * }
{ * Permission is hereby granted, free of charge, to any person obtaining a copy   * }
{ * of this software and associated documentation files (the "Software"), to deal  * }
{ * in the Software without restriction, including without limitation the rights   * }
{ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      * }
{ * copies of the Software, and to permit persons to whom the Software is          * }
{ * furnished to do so, subject to the following conditions:                       * }
{ *                                                                                * }
{ * The above copyright notice and this permission notice shall be included in all * }
{ * copies or substantial portions of the Software.                                * }
{ *                                                                                * }
{ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     * }
{ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       * }
{ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    * }
{ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         * }
{ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  * }
{ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  * }
{ * SOFTWARE.                                                                      * }
{ *                                                                                * }
{ * The Original Code is KingCalendar                                              * }
{ *                                                                                * }
{ * The Initial Developer of the Original Code is Mark Lussier and AppVision       * }
{ *                                                                                * }
{ * ***** END LICENSE BLOCK *****                                                  * }

// LR20260325 - Shared base class extracted from Kingspin, Kingspn1, Kingspnt, Kingdlg

unit KingBase;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.StdCtrls;

type
  TKingBaseDateEdit = class(TCustomEdit)
  strict private
    function GetMinHeight: Integer;
  private
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    FButton: TControl;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetEditRect; virtual;
    procedure UpClick(Sender: TObject); virtual;
    procedure DownClick(Sender: TObject); virtual;
    // LR20260325 - LiveBindings observer support for all spin/dialog editors
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
  end;

implementation

procedure TKingBaseDateEdit.KeyPress( var Key : Char );
  var
    OldKey : Char;
  begin
    OldKey := Key;
    if not IsValidChar( Key )
    then
    begin
      Key := #0;
      if not ( OldKey = '+' ) and not ( OldKey = '-' )
      then
        MessageBeep( 0 )
    end;
    if ( OldKey = '+' )
    then
      UpClick( Self );
    if ( OldKey = '-' )
    then
      DownClick( Self );

    if Key <> #0
    then
      inherited KeyPress( Key );
  end;

function TKingBaseDateEdit.IsValidChar( Key : Char ) : Boolean;
  begin
    result := ( ( Key < #32 ) and ( Key <> Chr( VK_RETURN ) ) );
  end;

procedure TKingBaseDateEdit.CreateParams( var Params : TCreateParams );
  begin
    inherited CreateParams( Params );
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
  end;

procedure TKingBaseDateEdit.CreateWnd;
  begin
    inherited CreateWnd;
    SetEditRect;
  end;

procedure TKingBaseDateEdit.SetEditRect;
  var
    Loc : TRect;
  begin
    SendMessage( Handle, EM_GETRECT, 0, LongInt( @Loc ) );
    Loc.Bottom := ClientHeight;
    Loc.Right := ClientWidth - FButton.Width - 2;
    Loc.Top := 0;
    Loc.Left := 0;
    SendMessage( Handle, EM_SETRECTNP, 0, LongInt( @Loc ) );
    SendMessage( Handle, EM_GETRECT, 0, LongInt( @Loc ) ); { debug }
  end;

procedure TKingBaseDateEdit.WMSize( var Message : TWMSize );
  var
    // hint	Loc: TRect;
    MinHeight : Integer;
  begin
    inherited;
    MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
    if Height < MinHeight
    then
      Height := MinHeight
    else if FButton <> nil
    then
    begin
      FButton.SetBounds( Width - FButton.Width, 0, FButton.Width, Height );
      SetEditRect;
    end;
  end;

function TKingBaseDateEdit.GetMinHeight : Integer;
  var
    DC : HDC;
    SaveFont : HFont;
    I : Integer;
    SysMetrics, Metrics : TTextMetric;
  begin
    DC := GetDC( 0 );
    GetTextMetrics( DC, SysMetrics );
    SaveFont := SelectObject( DC, Font.Handle );
    GetTextMetrics( DC, Metrics );
    SelectObject( DC, SaveFont );
    ReleaseDC( 0, DC );
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight
    then
      I := Metrics.tmHeight;
    result := Metrics.tmHeight + I div 4 + GetSystemMetrics
      ( SM_CYBORDER ) * 4 + 2;
  end;

procedure TKingBaseDateEdit.UpClick( Sender : TObject );
  begin
    // LR20260325 - Empty virtual stub; subclasses override
  end;

procedure TKingBaseDateEdit.DownClick( Sender : TObject );
  begin
    // LR20260325 - Empty virtual stub; subclasses override
  end;

{ **************************************************************************** }
// LR20260325 - LiveBindings support: accept edit and control-value observers
function TKingBaseDateEdit.CanObserve(const ID: Integer): Boolean;
begin
  Result := (ID = TObserverMapping.EditLinkID) or
    (ID = TObserverMapping.ControlValueID);
  if not Result then
    Result := inherited CanObserve(ID);
end;

{ **************************************************************************** }
// LR20260325 - LiveBindings support: configure observer on attachment
procedure TKingBaseDateEdit.ObserverAdded(const ID: Integer;
  const Observer: IObserver);
begin
  if ID = TObserverMapping.EditLinkID then
    Observer.OnObserverToggle := ObserverToggle;
  inherited ObserverAdded(ID, Observer);
end;

end.
