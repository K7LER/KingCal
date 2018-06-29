{ *                                                                                * }
{ *  unit KingPop                                                                  * }
{ *  TKingPopup Component                                                          * }
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

unit KingPop;

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
  Vcl.Menus,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  TheKing,
  KingTool,
  Vcl.Grids;

type

  TkcPopup = class( TForm )
    KingCalendar1 : TKingCalendar;
    KingNavigator1 : TKingNavigator;
    SpeedButton1 : TSpeedButton;
    SpeedButton2 : TSpeedButton;
    procedure KingCalendar1Change( Sender : TObject );
    procedure FormActivate( Sender : TObject );
    procedure KingCalendar1DblClick( Sender : TObject );
    procedure SpeedButton1Click( Sender : TObject );
    procedure SpeedButton2Click( Sender : TObject );
    procedure FormClose(
      Sender     : TObject;
      var Action : TCloseAction );
    private
      FDate : TDateTime;
      { Private declarations }
    public
      { Public declarations }
    published
      property PopupDate : TDateTime
        read FDate
        write FDate;
  end;

  TKingPopup = class( TComponent )
    private
      FAbout : String;
      FDate : TDateTime;
      FSource : TWinControl;
      FHints : Boolean;
    protected
      procedure Notification(
        AComponent : TComponent;
        Operation  : TOperation ); override;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure SetPopupDate( Value : TDateTime );
      property PopupDate : TDateTime
        read FDate
        write SetPopupDate;
    published
      function Execute : Boolean;
      property AlignSource : TWinControl
        read FSource
        write FSource;
      property About : String
        read FAbout
        write FAbout;
      property ShowHint : Boolean
        read FHints
        write FHints
        default True;
  end;

implementation

{$R *.DFM}

{ *************************************************************************** }
procedure TkcPopup.KingCalendar1Change( Sender : TObject );
  var
    cDate : String;
  begin
    cDate := FormatDateTime( 'mmmm d, yyyy', KingCalendar1.CalendarDate );
    Caption := cDate;
  end;

{ *************************************************************************** }
procedure TkcPopup.FormActivate( Sender : TObject );
  // hint var
  // hint cDate: String;
  begin
    { Execure the KingCalendar1Change procedure. The code is the same so
      why duplicate it }
    KingCalendar1Change( Sender );
  end;

{ *************************************************************************** }
procedure TkcPopup.KingCalendar1DblClick( Sender : TObject );
  begin
    PopupDate := KingCalendar1.CalendarDate;
    if not ( DateToStr( PopupDate ) = '' )
    then
      Close;
  end;

{ *************************************************************************** }
procedure TkcPopup.SpeedButton1Click( Sender : TObject );
  begin
    { Execure the KingCalendar1DblClick procedure. The code is the same so
      why duplicate it }
    KingCalendar1DblClick( Sender );
  end;

{ *************************************************************************** }
procedure TkcPopup.SpeedButton2Click( Sender : TObject );
  begin
    ModalResult := - 1;
  end;

{ *************************************************************************** }
procedure TkcPopup.FormClose(
  Sender     : TObject;
  var Action : TCloseAction );
  begin
    if ( PopupDate = 0 )
    then
      ModalResult := - 1;
  end;

{ ===========================================================================
  TKingPopup
  =========================================================================== }

constructor TKingPopup.Create( AOwner : TComponent );
  begin
    inherited Create( AOwner );
    FHints := True;
    FDate := Date;
  end;

procedure TKingPopup.SetPopupDate( Value : TDateTime );
  begin
    FDate := Value;
  end;

function TKingPopup.Execute : Boolean;
  var
    ThePopup : TkcPopup;
    FormRect : TRect;
    FormPoint, PopupPoint : TPoint;
  begin
    ThePopup := TkcPopup.Create( Application );

    ThePopup.KingCalendar1.CalendarDate := PopupDate;
    ThePopup.KingCalendar1.UpdateCalendar;
    ThePopup.PopupDate := 0;

    ThePopup.BorderStyle := bsSingle;

    if ShowHint
    then
      ThePopup.KingNavigator1.ShowHint := True
    else
      ThePopup.KingNavigator1.ShowHint := False;

    if ( AlignSource <> nil )
    then
    begin
      { Get the Parents Cleint Bounds. Starts at 0 }
      FormRect := AlignSource.Parent.ClientRect;

      { Get the Top/Left of the Aligned Control, as relative to it's parent }
      FormPoint := Point( FormRect.Top, FormRect.Left );

      { Convert that Top/Left into absolute Screen Coordinates }
      PopupPoint := AlignSource.Parent.ClientToScreen( FormPoint );

      { Set the Popup's Top to the Bottom Left hand corner of the associated
        TWinControl. Takes into consideration Frame and Caption size }
      ThePopup.Top :=
        ( PopupPoint.Y + ( AlignSource.Top + AlignSource.Height ) );

      IF ( GetSystemMetrics( SM_CYSCREEN ) <
        ( ThePopup.Top + ThePopup.Height ) )
      then
        ThePopup.Top := ( AlignSource.Top - ( ThePopup.Height + 2 ) +
          PopupPoint.Y );

      { Set the Popup's left hand position, taking into consideration the
        Frame Size }
      ThePopup.Left := ( PopupPoint.X + AlignSource.Left );

    end;

    try
      begin
        if not ( ThePopup.ShowModal = - 1 )
        then
        begin;
          PopupDate := ThePopup.PopupDate;
          Result := True;
        end
        else
          Result := False;
      end;
    finally
      ThePopup.Free;
    end;
  end;

{ *************************************************************************** }
procedure TKingPopup.Notification(
  AComponent : TComponent;
  Operation  : TOperation );
  begin
    inherited Notification( AComponent, Operation );
    { If the wired TKingCalendar has been deleted, NIL the connection }
    if ( Operation = opRemove ) and ( AComponent = FSource )
    then
      FSource := nil;
  end;

end.
