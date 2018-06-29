{ *                                                                                * }
{ *  unit Caledit2                                                                 * }
{ *  TKingCalendar Property Editor Unit                                            * }
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


unit Caledit2;

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
  Vcl.ExtCtrls;

type
  TFrmColor = class( TForm )
    sR : TScrollBar;
    sG : TScrollBar;
    sB : TScrollBar;
    Label1 : TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    Label4 : TLabel;
    Label5 : TLabel;
    Label6 : TLabel;
    BitBtn1 : TBitBtn;
    BitBtn2 : TBitBtn;
    Image1 : TImage;
    Bevel1 : TBevel;
    procedure sRChange( Sender : TObject );
    procedure sGChange( Sender : TObject );
    procedure sBChange( Sender : TObject );
    procedure FormCreate( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
      procedure DrawSampleColor;
  end;

implementation

{$R *.DFM}

{ *************************************************************************** }
procedure TFrmColor.sRChange( Sender : TObject );
  begin
    Label4.Caption := IntToStr( sR.Position );
    DrawSampleColor;
  end;

{ *************************************************************************** }
procedure TFrmColor.sGChange( Sender : TObject );
  begin
    Label5.Caption := IntToStr( sG.Position );
    DrawSampleColor;
  end;

{ *************************************************************************** }
procedure TFrmColor.sBChange( Sender : TObject );
  begin
    Label6.Caption := IntToStr( sB.Position );
    DrawSampleColor;
  end;

{ *************************************************************************** }
procedure TFrmColor.DrawSampleColor;
  begin
    Image1.Canvas.Brush.Color := RGB( sR.Position, sG.Position, sB.Position );
    Image1.Canvas.FillRect( Image1.Canvas.ClipRect );
  end;

{ *************************************************************************** }
procedure TFrmColor.FormCreate( Sender : TObject );
  begin
    DrawSampleColor;
  end;

end.
