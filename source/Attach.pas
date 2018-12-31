{ *                                                                                * }
{ *  unit Attach                                                                   * }
{ *  TKingCalendar Attachment Property Editor                                      * }
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
{ * Portions created by Mark Lussier and AppVision are Copyright (c) 1995-2000     * }
{ * Mark Lussier and AppVision. All Rights Reserved.                               * }
{ *                                                                                * }
{ * Contributor(s):                                                                * }
{ * Lance Rasmussen - lanceRasmussen@gmail.com - Github                            * }
{ *                                                                                * }
{ * ***** END LICENSE BLOCK *****                                                  * }

unit Attach;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  TheKing;

type
  TFrmAttach = class( TForm )
    ListBox1 : TListBox;
    Label1 : TLabel;
    BitBtn1 : TBitBtn;
    BitBtn2 : TBitBtn;
    BitBtn3 : TBitBtn;
    procedure ListBox1DblClick( Sender : TObject );
    procedure BitBtn1Click( Sender : TObject );
    procedure BitBtn3Click( Sender : TObject );
    private
      { Private declarations }
      FContainer : TWinControl;
      FChosen : TKingCalendar;
      procedure SetContainer( Value : TWinControl );
    public
      { Public declarations }
      property Container : TWinControl
        read FContainer
        write SetContainer;
      property Chosen : TKingCalendar
        read FChosen
        write FChosen;
  end;

var
  FrmAttach : TFrmAttach;

implementation

{$R *.DFM}
{ *************************************************************************** }

procedure TFrmAttach.SetContainer( Value : TWinControl );
  var
    X : Integer;
    oControl : TControl;
  begin
    FContainer := Value;

    for X := 0 to ( FContainer.ControlCount - 1 ) do
    begin
      oControl := FContainer.Controls[ X ];
      if oControl is TKingCalendar
      then
        ListBox1.Items.AddObject( oControl.Name, oControl );
    end;

  end;

{ *************************************************************************** }

procedure TFrmAttach.ListBox1DblClick( Sender : TObject );
  begin
    if ( ListBox1.ItemIndex <= ( ListBox1.Items.Count - 1 ) )
    then
      FChosen := ( ListBox1.Items.Objects[ ListBox1.ItemIndex ]
        as TKingCalendar );

    ModalResult := mrOk;
  end;

{ *************************************************************************** }

procedure TFrmAttach.BitBtn1Click( Sender : TObject );
  begin
    ListBox1DblClick( Sender );
  end;

{ *************************************************************************** }

procedure TFrmAttach.BitBtn3Click( Sender : TObject );
  begin
    FChosen := nil;
    ModalResult := mrOk;
  end;

end.
