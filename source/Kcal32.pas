{ *                                                                                * }
{ *  unit TheKing                                                                  * }
{ *  Component Registration Module                                                 * }
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

unit KCal32;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  ToolsAPI,
  Vcl.Graphics,
  Vcl.Dialogs,
  DesignIntf,
  DesignEditors,
  VCLEditors

    ;

{$R KingCalSplash.res}
procedure Register;

implementation

uses
  System.Classes,
  Vcl.Forms,
  kccmpedt,
  TheKing,
  KingTool,
  KingPop,
  KingProp,
  KingSpin,
  KingCalc,
  KingDlg,
  KingSpn1,
  KingSpnt,
  KingCore;

type
  TAboutProperty = class( TStringProperty )
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
    procedure SetValue( const Value : string ); override;
  end;

  { TKingCalendarProperty }
  TKingCalendarProperty = class( TAboutProperty )
    procedure Edit; override;
  end;

  { Component Editor for all components who need a CalendarSource }
  TKingAttachEditor = class( TComponentEditor )
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerb( Index : Integer ) : string; override;
    function GetVerbCount : Integer; override;
  end;

  { Component Editor for all components who need a CalendarSource }
  TKingVisualEditor = class( TComponentEditor )
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerb( Index : Integer ) : string; override;
    function GetVerbCount : Integer; override;
  end;

var
  AboutBoxServices : IOTAAboutBoxServices = nil;
  AboutBoxIndex : Integer = 0;

procedure RegisterWithSplashScreen;
  var
    Bmp : TBitmap;
  begin
    Bmp := TBitmap.Create;
    Bmp.LoadFromResourceName( HInstance, 'KINGSPLASH' );

    try
      SplashScreenServices.AddPluginBitmap( 'King Calendar v' + vcdVersion,
        Bmp.Handle, False, 'MIT 1.0' );
    finally
      Bmp.Free;
    end;
  end;

{ *************************************************************************** }
procedure Register;
  begin
    ForceDemandLoadState( dlDisable );

    RegisterComponents( 'KingCalendar', [ TKingCalendar, TKingNavigator,
      TMonthBar, TMonthCombo, TDayCombo, TYearCombo, TMonthSpin, TDaySpin,
      TYearSpin, TKingLabel, TKingWeekLabel, TKingPopup, TKingDateDialog,
      // TDBKingDlg,
      TKingTimeSpin, TKingDateSpin, TKingMDYSpin, TKingHMSpin, TKingCalc ] );

    RegisterPropertyEditor( TypeInfo( string ), TKingCalendar, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingNavigator, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TMonthBar, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingPopup, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingDateDialog, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingLabel, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingWeekLabel, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TYearSpin, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TMonthSpin, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TDaySpin, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TMonthCombo, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TYearCombo, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TDayCombo, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingTimeSpin, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingDateSpin, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingCalc, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingMDYSpin, 'About',
      TKingCalendarProperty );
    RegisterPropertyEditor( TypeInfo( string ), TKingHMSpin, 'About',
      TKingCalendarProperty );
    // RegisterPropertyEditor( TypeInfo( String ), TDBKingDlg,
    // 'About', TKingCalendarProperty );
    RegisterComponentEditor( TKingNavigator, TKingAttachEditor );
    RegisterComponentEditor( TMonthBar, TKingAttachEditor );
    RegisterComponentEditor( TKingLabel, TKingAttachEditor );
    RegisterComponentEditor( TKingWeekLabel, TKingAttachEditor );
    RegisterComponentEditor( TMonthCombo, TKingAttachEditor );
    RegisterComponentEditor( TDayCombo, TKingAttachEditor );
    RegisterComponentEditor( TYearCombo, TKingAttachEditor );
    RegisterComponentEditor( TMonthSpin, TKingAttachEditor );
    RegisterComponentEditor( TDaySpin, TKingAttachEditor );
    RegisterComponentEditor( TYearSpin, TKingAttachEditor );
    RegisterComponentEditor( TKingCalendar, TKingVisualEditor );

  end;

{ TKingCalendarProperty }
{ **************************************************************************** }
procedure TKingCalendarProperty.Edit;
  var
    DialogBox : TVcdAboutBox;
  begin
    DialogBox := TVcdAboutBox.Create( Application );
    try
      with DialogBox do
      begin
        vcdEdition.Caption := 'Calendar Components for Delphi';
        vcdRelease.Caption := 'Release ' + vcdVersion + ' (' +
          vcdBuildDate + ')';
        vcdCopyright.Caption :=
          'Portions Copyright © 1995,1996 AppVision Software - MPL 2.0 SourceForge.com/p/kingcalendar';
        vcdComponent.Caption := GetComponent( 0 ).ClassName + ' Component';
        ShowModal;
      end;
    finally
      DialogBox.Free;
    end;
  end;

{ TAboutProperty }
function TAboutProperty.GetAttributes : TPropertyAttributes;
  begin
    Result := [ paDialog ];
  end;

function TAboutProperty.GetValue : string;
  begin
    Result := '(Click Me)';
  end;

procedure TAboutProperty.SetValue( const Value : string );
  begin
  end;

{ When the user either double clicks on the component or chooses the 'Attach
  to Calendar...' option from the right mouse click,this code is executed
  which launches the property editor }

{ *************************************************************************** }
procedure TKingAttachEditor.ExecuteVerb( Index : Integer );
  begin
    DoCalendarAttach( Component.Owner, Component );
  end;

{ *************************************************************************** }
function TKingAttachEditor.GetVerb( Index : Integer ) : string;
  begin
    Result := VerbAttach;
  end;

{ *************************************************************************** }
function TKingAttachEditor.GetVerbCount : Integer;
  begin
    Result := 1;
  end;

{ *************************************************************************** }
procedure TKingVisualEditor.ExecuteVerb( Index : Integer );
  begin
    DoVisualEdit( Component.Owner, Component );
  end;

{ *************************************************************************** }
function TKingVisualEditor.GetVerb( Index : Integer ) : string;
  begin
    Result := VerbVisual;
  end;

{ *************************************************************************** }
function TKingVisualEditor.GetVerbCount : Integer;
  begin
    Result := 1;
  end;

procedure RegisterAboutBox;
  var
    ProductImage : HBITMAP;
  begin
    Supports( BorlandIDEServices, IOTAAboutBoxServices, AboutBoxServices );
    ProductImage := LoadBitmap( FindResourceHInstance( HInstance ),
      'KINGSPLASH' );
    AboutBoxIndex := AboutBoxServices.AddPluginInfo
      ( 'King Calendar Components - ' + 'Release ' + vcdVersion + ' (' +
      vcdBuildDate + ')',
      'Please visit https://github.com/K7LER/KingCal for more information ' +
      #13#10#13#10 + 'Copyright © 1995-2018 Mark Lussier and AppVision Software'
      + #13#10 + 'All Rights Reserved', ProductImage, False, 'MIT 1.0' );
  end;

procedure UnRegisterAboutBox;
  begin
    if ( AboutBoxIndex <> 0 ) and Assigned( AboutBoxServices )
    then
    begin
      AboutBoxServices.RemovePluginInfo( AboutBoxIndex );
      AboutBoxIndex := 0;
      AboutBoxServices := nil;
    end;
  end;

initialization

RegisterWithSplashScreen( );
RegisterAboutBox( );

finalization

UnRegisterAboutBox( );

end.
