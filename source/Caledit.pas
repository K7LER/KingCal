{ *                                                                                * }
{ *  unit Caledit                                                                  * }
{ *  Visual Calendar Editor Support Module                                         * }
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

unit Caledit;

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
  Vcl.ExtCtrls,
  Vcl.Tabs,
  TheKing,
  Vcl.ColorGrd,
  Vcl.Grids;

type
  TFrmCalEdit = class( TForm )
    Notebook1 : TNotebook;
    Label1 : TLabel;
    ListBox1 : TListBox;
    ColorGrid1 : TColorGrid;
    KingCalendar1 : TKingCalendar;
    Bevel1 : TBevel;
    BitBtn1 : TBitBtn;
    BitBtn2 : TBitBtn;
    Label2 : TLabel;
    Label3 : TLabel;
    Button1 : TButton;
    ListBox2 : TListBox;
    Label4 : TLabel;
    Button2 : TButton;
    Memo1 : TMemo;
    Label5 : TLabel;
    RadioGroup1 : TRadioGroup;
    KingCalendar2 : TKingCalendar;
    Label6 : TLabel;
    Button3 : TButton;
    checkFixed : TCheckBox;
    RadioGroup2 : TRadioGroup;
    TabSet1 : TTabSet;
    KingCalendar3 : TKingCalendar;
    Label7 : TLabel;
    BitBtn3 : TBitBtn;
    BitBtn4 : TBitBtn;
    BitBtn5 : TBitBtn;
    FontDialog1 : TFontDialog;
    cBlock : TCheckBox;
    cGridLines : TCheckBox;
    cReadOnly : TCheckBox;
    procedure TabSet1Change(
      Sender          : TObject;
      NewTab          : Integer;
      var AllowChange : Boolean );
    procedure ColorGrid1Click( Sender : TObject );
    procedure Button1Click( Sender : TObject );
    procedure BitBtn1Click( Sender : TObject );
    procedure ListBox2Click( Sender : TObject );
    procedure Button2Click( Sender : TObject );
    procedure RadioGroup1Click( Sender : TObject );
    procedure Button3Click( Sender : TObject );
    procedure checkFixedClick( Sender : TObject );
    procedure BitBtn2Click( Sender : TObject );
    procedure RadioGroup2Click( Sender : TObject );
    procedure TabSet1Click( Sender : TObject );
    procedure BitBtn3Click( Sender : TObject );
    procedure BitBtn4Click( Sender : TObject );
    procedure BitBtn5Click( Sender : TObject );
    procedure cBlockClick( Sender : TObject );
    procedure cGridLinesClick( Sender : TObject );
    procedure cReadOnlyClick( Sender : TObject );
    procedure FormActivate( Sender : TObject );
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  FrmCalEdit : TFrmCalEdit;

implementation

{$R *.DFM}

uses
  Caledit2;

const

  TColorByName : Array [ 0 .. 34 ] of TColor = ( clBlack, clMaroon, clGreen,
    clOlive, clNavy, clPurple, clTeal, clGray, clSilver, clRed, clLime, clBlue,
    clFuchsia, clAqua, clWhite, clBackground, clActiveCaption,
    clInactiveCaption, clMenu, clWindow, clWindowFrame, clMenuText,
    clWindowText, clCaptionText, clActiveBorder, clInactiveBorder,
    clAppWorkSpace, clHighlight, clHighlightText, clBtnFace, clBtnShadow,
    clGrayText, clBtnText, clInactiveCaptionText, clBtnHighlight );

  { *************************************************************************** }
procedure TFrmCalEdit.TabSet1Change(
  Sender          : TObject;
  NewTab          : Integer;
  var AllowChange : Boolean );
  begin
    Notebook1.PageIndex := TabSet1.TabIndex;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.ColorGrid1Click( Sender : TObject );
  var
    tempFont : TFont;
  begin

    if ( ListBox1.ItemIndex <= ListBox1.Items.Count - 1 )
    then
    begin

      case ListBox1.ItemIndex of
        0 :
          KingCalendar1.BlockedBkgnd := ColorGrid1.ForegroundColor;
        1 :
          KingCalendar1.BlockedFrgnd := ColorGrid1.ForegroundColor;
        2 :
          KingCalendar1.CellColor := ColorGrid1.ForegroundColor;
        3 :
          KingCalendar1.Highlight := ColorGrid1.ForegroundColor;
        4 :
          KingCalendar1.HighlightText := ColorGrid1.ForegroundColor;
        5 :
          KingCalendar1.GridLineColor := ColorGrid1.ForegroundColor;
        6 :
          KingCalendar1.TitleColor := ColorGrid1.ForegroundColor;
        7 :
          begin
            tempFont := KingCalendar1.TitleFont;
            tempFont.Color := ColorGrid1.ForegroundColor;
            KingCalendar1.TitleFont := tempFont;
            if assigned( tempFont )
            then
              freeAndNil( tempFont );
          end;
        8 :
          KingCalendar1.TodayColor := ColorGrid1.ForegroundColor;
        9 :
          KingCalendar1.ColorSets.ColorSet1 := ColorGrid1.ForegroundColor;
        10 :
          KingCalendar1.ColorSets.ColorSet2 := ColorGrid1.ForegroundColor;
        11 :
          KingCalendar1.ColorSets.ColorSet3 := ColorGrid1.ForegroundColor;
        12 :
          KingCalendar1.ColorSets.ColorSet4 := ColorGrid1.ForegroundColor;
        13 :
          KingCalendar1.ColorSets.ColorSet5 := ColorGrid1.ForegroundColor;
        14 :
          KingCalendar1.ColorSets.ColorSet6 := ColorGrid1.ForegroundColor;
        15 :
          KingCalendar1.ColorSets.ColorSet7 := ColorGrid1.ForegroundColor;
        16 :
          KingCalendar1.ColorSets.ColorSet8 := ColorGrid1.ForegroundColor;
        17 :
          KingCalendar1.ColorSets.ColorSet9 := ColorGrid1.ForegroundColor;
      end;
    end;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.Button1Click( Sender : TObject );
  var
    tempFont : TFont;
  begin

    if ( ListBox1.ItemIndex <= ListBox1.Items.Count - 1 )
    then
    begin

      case ListBox1.ItemIndex of
        0 :
          KingCalendar1.BlockedBkgnd := clSilver;
        1 :
          KingCalendar1.BlockedFrgnd := clGray;
        2 :
          KingCalendar1.CellColor := clWhite;
        3 :
          KingCalendar1.Highlight := clHighlight;
        4 :
          KingCalendar1.HighlightText := clHighlightText;
        5 :
          KingCalendar1.GridLineColor := clGray;
        6 :
          KingCalendar1.TitleColor := clSilver;
        7 :
          begin
            tempFont := KingCalendar1.TitleFont;
            tempFont.Color := clBlack;
            KingCalendar1.TitleFont := tempFont;
            if assigned( tempFont )
            then
              freeAndNil( tempFont );
          end;
        8 :
          KingCalendar1.TodayColor := clBlack;
        9 :
          KingCalendar1.ColorSets.ColorSet1 := clPurple;
        10 :
          KingCalendar1.ColorSets.ColorSet2 := clBlue;
        11 :
          KingCalendar1.ColorSets.ColorSet3 := clAqua;
        12 :
          KingCalendar1.ColorSets.ColorSet4 := clGreen;
        13 :
          KingCalendar1.ColorSets.ColorSet5 := clLime;
        14 :
          KingCalendar1.ColorSets.ColorSet6 := clOlive;
        15 :
          KingCalendar1.ColorSets.ColorSet7 := clYellow;
        16 :
          KingCalendar1.ColorSets.ColorSet8 := clMaroon;
        17 :
          KingCalendar1.ColorSets.ColorSet9 := clRed;
      end;
    end;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.BitBtn1Click( Sender : TObject );
  begin
    Close;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.ListBox2Click( Sender : TObject );
  var
    tempFont : TFont;
  begin
    if ( ListBox1.ItemIndex <= ListBox1.Items.Count - 1 )
    then
    begin
      case ListBox1.ItemIndex of
        0 :
          KingCalendar1.BlockedBkgnd := TColorByName[ ListBox2.ItemIndex ];
        1 :
          KingCalendar1.BlockedFrgnd := TColorByName[ ListBox2.ItemIndex ];
        2 :
          KingCalendar1.CellColor := TColorByName[ ListBox2.ItemIndex ];
        3 :
          KingCalendar1.Highlight := TColorByName[ ListBox2.ItemIndex ];
        4 :
          KingCalendar1.HighlightText := TColorByName[ ListBox2.ItemIndex ];
        5 :
          KingCalendar1.GridLineColor := TColorByName[ ListBox2.ItemIndex ];
        6 :
          KingCalendar1.TitleColor := TColorByName[ ListBox2.ItemIndex ];
        7 :
          begin
            tempFont := KingCalendar1.TitleFont;
            tempFont.Color := TColorByName[ ListBox2.ItemIndex ];
            KingCalendar1.TitleFont := tempFont;
            if assigned( tempFont )
            then
              freeAndNil( tempFont );
          end;
        8 :
          KingCalendar1.TodayColor := TColorByName[ ListBox2.ItemIndex ];
        9 :
          KingCalendar1.ColorSets.ColorSet1 :=
            TColorByName[ ListBox2.ItemIndex ];
        10 :
          KingCalendar1.ColorSets.ColorSet2 :=
            TColorByName[ ListBox2.ItemIndex ];
        11 :
          KingCalendar1.ColorSets.ColorSet3 :=
            TColorByName[ ListBox2.ItemIndex ];
        12 :
          KingCalendar1.ColorSets.ColorSet4 :=
            TColorByName[ ListBox2.ItemIndex ];
        13 :
          KingCalendar1.ColorSets.ColorSet5 :=
            TColorByName[ ListBox2.ItemIndex ];
        14 :
          KingCalendar1.ColorSets.ColorSet6 :=
            TColorByName[ ListBox2.ItemIndex ];
        15 :
          KingCalendar1.ColorSets.ColorSet7 :=
            TColorByName[ ListBox2.ItemIndex ];
        16 :
          KingCalendar1.ColorSets.ColorSet8 :=
            TColorByName[ ListBox2.ItemIndex ];
        17 :
          KingCalendar1.ColorSets.ColorSet9 :=
            TColorByName[ ListBox2.ItemIndex ];
      end;
    end;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.Button2Click( Sender : TObject );
  var
    FrmColor : TFrmColor;
    nColor : LongInt;
    tempFont : TFont;
  begin

    nColor := RGB( 192, 192, 192 );

    case ListBox1.ItemIndex of
      0 :
        nColor := ColorToRGB( KingCalendar1.BlockedBkgnd );
      1 :
        nColor := ColorToRGB( KingCalendar1.BlockedFrgnd );
      2 :
        nColor := ColorToRGB( KingCalendar1.CellColor );
      3 :
        nColor := ColorToRGB( KingCalendar1.Highlight );
      4 :
        nColor := ColorToRGB( KingCalendar1.HighlightText );
      5 :
        nColor := ColorToRGB( KingCalendar1.GridLineColor );
      6 :
        nColor := ColorToRGB( KingCalendar1.TitleColor );
      7 :
        nColor := ColorToRGB( KingCalendar1.TitleFont.Color );
      8 :
        nColor := ColorToRGB( KingCalendar1.TodayColor );
      9 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet1 );
      10 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet2 );
      11 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet3 );
      12 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet4 );
      13 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet5 );
      14 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet6 );
      15 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet7 );
      16 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet8 );
      17 :
        nColor := ColorToRGB( KingCalendar1.ColorSets.ColorSet9 );
    end;

    FrmColor := TFrmColor.Create( Self );

    FrmColor.sR.Position := GetRValue( nColor );
    FrmColor.sG.Position := GetGValue( nColor );
    FrmColor.sB.Position := GetBValue( nColor );

    try
      if ( FrmColor.ShowModal = mrOk )
      then;
      begin

        nColor := RGB( FrmColor.sR.Position, FrmColor.sG.Position,
          FrmColor.sB.Position );

        case ListBox1.ItemIndex of
          0 :
            KingCalendar1.BlockedBkgnd := nColor;
          1 :
            KingCalendar1.BlockedFrgnd := nColor;
          2 :
            KingCalendar1.CellColor := nColor;
          3 :
            KingCalendar1.Highlight := nColor;
          4 :
            KingCalendar1.HighlightText := nColor;
          5 :
            KingCalendar1.GridLineColor := nColor;
          6 :
            KingCalendar1.TitleColor := nColor;
          7 :
            begin
              tempFont := KingCalendar1.TitleFont;
              tempFont.Color := nColor;
              KingCalendar1.TitleFont := tempFont;
              if assigned( tempFont )
              then
                freeAndNil( tempFont );
            end;
          8 :
            KingCalendar1.TodayColor := nColor;
          9 :
            KingCalendar1.ColorSets.ColorSet1 := nColor;
          10 :
            KingCalendar1.ColorSets.ColorSet2 := nColor;
          11 :
            KingCalendar1.ColorSets.ColorSet3 := nColor;
          12 :
            KingCalendar1.ColorSets.ColorSet4 := nColor;
          13 :
            KingCalendar1.ColorSets.ColorSet5 := nColor;
          14 :
            KingCalendar1.ColorSets.ColorSet6 := nColor;
          15 :
            KingCalendar1.ColorSets.ColorSet7 := nColor;
          16 :
            KingCalendar1.ColorSets.ColorSet8 := nColor;
          17 :
            KingCalendar1.ColorSets.ColorSet9 := nColor;
        end;
      end;
    finally
      FrmColor.Free;
    end;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.RadioGroup1Click( Sender : TObject );
  begin
    KingCalendar2.StartingDay := RadioGroup1.ItemIndex;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.Button3Click( Sender : TObject );
  begin
    KingCalendar2.DowNames := Memo1.Lines;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.checkFixedClick( Sender : TObject );
  begin
    KingCalendar2.HeaderUseFixed := checkFixed.Checked;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.BitBtn2Click( Sender : TObject );
  begin
    ModalResult := mrOk;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.RadioGroup2Click( Sender : TObject );
  begin
    case RadioGroup2.ItemIndex of
      0 :
        KingCalendar2.TextPlacement := ktCenter;
      1 :
        KingCalendar2.TextPlacement := ktLowerLeft;
      2 :
        KingCalendar2.TextPlacement := ktTopLeft;
      3 :
        KingCalendar2.TextPlacement := ktTopRight;
      4 :
        KingCalendar2.TextPlacement := ktLowerRight;
    end;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.TabSet1Click( Sender : TObject );
  begin
    Notebook1.PageIndex := TabSet1.TabIndex;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.BitBtn3Click( Sender : TObject );
  begin
    FontDialog1.Font := KingCalendar3.TitleFont;

    IF FontDialog1.Execute
    then
      KingCalendar3.TitleFont := FontDialog1.Font;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.BitBtn4Click( Sender : TObject );
  begin
    FontDialog1.Font := KingCalendar3.Font;
    IF FontDialog1.Execute
    then
      KingCalendar3.Font := FontDialog1.Font;

  end;

{ *************************************************************************** }
procedure TFrmCalEdit.BitBtn5Click( Sender : TObject );
  begin
    FontDialog1.Font := KingCalendar3.TextFont;
    IF FontDialog1.Execute
    then
      KingCalendar3.TextFont := FontDialog1.Font;

  end;

{ *************************************************************************** }
procedure TFrmCalEdit.cBlockClick( Sender : TObject );
  begin
    KingCalendar2.BlockWeekends := cBlock.Checked;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.cGridLinesClick( Sender : TObject );
  begin
    KingCalendar2.ShowGridlines := cGridLines.Checked;
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.cReadOnlyClick( Sender : TObject );
  begin
    KingCalendar2.IsActive := not ( cReadOnly.Checked );
  end;

{ *************************************************************************** }
procedure TFrmCalEdit.FormActivate( Sender : TObject );
  begin
    KingCalendar1.NextDay;
    Memo1.Lines := KingCalendar2.DowNames;

    KingCalendar3.SetDateFlag( 1, 2, 'Test' );
    KingCalendar3.SetDateFlag( 4, 7, 'Test' );
    KingCalendar3.SetDateFlag( 12, 3, 'Test' );
    KingCalendar3.SetDateFlag( 17, 4, 'Test' );
    KingCalendar3.SetDateFlag( 21, 6, 'Test' );
    KingCalendar3.SetDateFlag( 19, 5, 'Test' );

    cBlock.Checked := KingCalendar2.BlockWeekends;
    cGridLines.Checked := KingCalendar2.ShowGridlines;
    cReadOnly.Checked := not ( KingCalendar2.IsActive );

    RadioGroup1.ItemIndex := KingCalendar2.StartingDay;
    case KingCalendar2.TextPlacement of
      ktCenter :
        RadioGroup2.ItemIndex := 0;
      ktLowerLeft :
        RadioGroup2.ItemIndex := 1;
      ktTopLeft :
        RadioGroup2.ItemIndex := 2;
      ktTopRight :
        RadioGroup2.ItemIndex := 3;
      ktLowerRight :
        RadioGroup2.ItemIndex := 4;
    end;
  end;

{ *************************************************************************** }
end.
