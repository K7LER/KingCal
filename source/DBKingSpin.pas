{ *                                                                                * }
{ *  unit DBKingSpin                                                               * }
{ *  Database-aware KingCalendar spin and dialog components                        * }
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

// LR20260325 - Initial implementation of database-aware KingCalendar components

unit DBKingSpin;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Data.DB,
  Vcl.DBCtrls,
  Vcl.Controls,
  TheKing,
  KingSpin,
  KingSpn1,
  KingSpnt,
  KingDlg;

type

  { TDBKingCalendar }
  // LR20260325 - Database-aware calendar grid bound to a TDateTimeField
  TDBKingCalendar = class(TKingCalendar)
  strict private
    FDataLink: TFieldDataLink;
    // LR20260325 - Stores user-assigned OnChange so we can chain from internal handler
    FUserOnChange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(AValue: TDataSource);
    procedure SetReadOnly(AValue: Boolean);
    function GetField: TField;
    procedure CMExit(var AMessage: TCMExit); message CM_EXIT;
    // LR20260325 - Internal OnChange handler that notifies FDataLink then chains to user handler
    procedure InternalOnChange(Sender: TObject);
  protected
    procedure Notification(
      AComponent : TComponent;
      AOperation : TOperation); override;
    function SelectCell(
      ACol : Longint;
      ARow : Longint): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string
      read GetDataField
      write SetDataField;
    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;
    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;
    // LR20260325 - Expose user OnChange through a separate property name to avoid conflict
    property OnUserChange: TNotifyEvent
      read FUserOnChange
      write FUserOnChange;
  end;

  { TDBKingDateSpin }
  // LR20260325 - Database-aware date spin editor bound to a TDateTimeField
  TDBKingDateSpin = class(TKingDateSpin)
  strict private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(AValue: TDataSource);
    procedure SetReadOnly(AValue: Boolean);
    function GetField: TField;
    procedure CMExit(var AMessage: TCMExit); message CM_EXIT;
  protected
    procedure Notification(
      AComponent : TComponent;
      AOperation : TOperation); override;
    procedure UpClick(Sender: TObject); override;
    procedure DownClick(Sender: TObject); override;
    procedure KeyPress(var AKey: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string
      read GetDataField
      write SetDataField;
    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;
    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;
  end;

  { TDBKingTimeSpin }
  // LR20260325 - Database-aware time spin editor bound to a TDateTimeField
  TDBKingTimeSpin = class(TKingTimeSpin)
  strict private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(AValue: TDataSource);
    procedure SetReadOnly(AValue: Boolean);
    function GetField: TField;
    procedure CMExit(var AMessage: TCMExit); message CM_EXIT;
  protected
    procedure Notification(
      AComponent : TComponent;
      AOperation : TOperation); override;
    procedure UpClick(Sender: TObject); override;
    procedure DownClick(Sender: TObject); override;
    procedure KeyPress(var AKey: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string
      read GetDataField
      write SetDataField;
    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;
    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;
  end;

  { TDBKingMDYSpin }
  // LR20260325 - Database-aware month/day/year spin editor bound to a TDateTimeField
  TDBKingMDYSpin = class(TKingMDYSpin)
  strict private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(AValue: TDataSource);
    procedure SetReadOnly(AValue: Boolean);
    function GetField: TField;
    procedure CMExit(var AMessage: TCMExit); message CM_EXIT;
  protected
    procedure Notification(
      AComponent : TComponent;
      AOperation : TOperation); override;
    procedure UpClick(Sender: TObject); override;
    procedure DownClick(Sender: TObject); override;
    procedure KeyPress(var AKey: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string
      read GetDataField
      write SetDataField;
    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;
    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;
  end;

  { TDBKingHMSpin }
  // LR20260325 - Database-aware hour/minute spin editor bound to a TDateTimeField
  TDBKingHMSpin = class(TKingHMSpin)
  strict private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(AValue: TDataSource);
    procedure SetReadOnly(AValue: Boolean);
    function GetField: TField;
    procedure CMExit(var AMessage: TCMExit); message CM_EXIT;
  protected
    procedure Notification(
      AComponent : TComponent;
      AOperation : TOperation); override;
    procedure UpClick(Sender: TObject); override;
    procedure DownClick(Sender: TObject); override;
    procedure KeyPress(var AKey: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string
      read GetDataField
      write SetDataField;
    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;
    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;
  end;

  { TDBKingDateDialog }
  // LR20260325 - Database-aware date dialog editor bound to a TDateTimeField
  TDBKingDateDialog = class(TKingDateDialog)
  strict private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(AValue: TDataSource);
    procedure SetReadOnly(AValue: Boolean);
    function GetField: TField;
    procedure CMExit(var AMessage: TCMExit); message CM_EXIT;
  protected
    procedure BtnClick(Sender: TObject); override;
    procedure Notification(
      AComponent : TComponent;
      AOperation : TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string
      read GetDataField
      write SetDataField;
    property DataSource: TDataSource
      read GetDataSource
      write SetDataSource;
    property ReadOnly: Boolean
      read GetReadOnly
      write SetReadOnly
      default False;
  end;

implementation

{ **************************************************************************** }
{ TDBKingCalendar                                                              }
{ **************************************************************************** }

// LR20260325 - Initial implementation
constructor TDBKingCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  try
    FDataLink.Control := Self;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnEditingChange := EditingChange;
    FDataLink.OnUpdateData := UpdateData;
  except
    FreeAndNil(FDataLink);
    raise;
  end;
  // LR20260325 - Wire internal OnChange handler to detect calendar modifications
  inherited OnChange := InternalOnChange;
end;

// LR20260325 - Initial implementation
destructor TDBKingCalendar.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

// LR20260325 - Internal OnChange handler; notifies data link then chains to user handler
procedure TDBKingCalendar.InternalOnChange(Sender: TObject);
begin
  if FDataLink <> nil
  then
    FDataLink.Modified;
  if Assigned(FUserOnChange)
  then
    FUserOnChange(Self);
end;

// LR20260325 - Remove DataSource reference when the linked component is destroyed
procedure TDBKingCalendar.Notification(
  AComponent : TComponent;
  AOperation : TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = FDataLink.DataSource)
  then
    DataSource := nil;
end;

// LR20260325 - Read field value into CalendarDate when dataset changes
procedure TDBKingCalendar.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull)
  then
    CalendarDate := FDataLink.Field.AsDateTime;
end;

// LR20260325 - Placeholder for editing state changes
procedure TDBKingCalendar.EditingChange(Sender: TObject);
begin
  // LR20260325 - TKingCalendar has no inherited ReadOnly to toggle;
  // selectability is controlled via SelectCell
end;

// LR20260325 - Write CalendarDate back to the field when the dataset posts
procedure TDBKingCalendar.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil
  then
    FDataLink.Field.AsDateTime := CalendarDate;
end;

// LR20260325 - Guard cell selection: put dataset into edit mode first
function TDBKingCalendar.SelectCell(
  ACol : Longint;
  ARow : Longint): Boolean;
begin
  if not FDataLink.Edit
  then
  begin
    Result := False;
    Exit;
  end;
  Result := inherited SelectCell(ACol, ARow);
end;

// LR20260325 - Flush pending changes when focus leaves the control
procedure TDBKingCalendar.CMExit(var AMessage: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// LR20260325 - Property accessor: DataField
function TDBKingCalendar.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

// LR20260325 - Property accessor: DataField
procedure TDBKingCalendar.SetDataField(const AValue: string);
begin
  FDataLink.FieldName := AValue;
end;

// LR20260325 - Property accessor: DataSource
function TDBKingCalendar.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

// LR20260325 - Property accessor: DataSource
procedure TDBKingCalendar.SetDataSource(AValue: TDataSource);
begin
  FDataLink.DataSource := AValue;
end;

// LR20260325 - Property accessor: ReadOnly
function TDBKingCalendar.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// LR20260325 - Property accessor: ReadOnly
procedure TDBKingCalendar.SetReadOnly(AValue: Boolean);
begin
  FDataLink.ReadOnly := AValue;
end;

// LR20260325 - Property accessor: Field
function TDBKingCalendar.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ **************************************************************************** }
{ TDBKingDateSpin                                                              }
{ **************************************************************************** }

// LR20260325 - Initial implementation
constructor TDBKingDateSpin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  try
    FDataLink.Control := Self;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnEditingChange := EditingChange;
    FDataLink.OnUpdateData := UpdateData;
  except
    FreeAndNil(FDataLink);
    raise;
  end;
end;

// LR20260325 - Initial implementation
destructor TDBKingDateSpin.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

// LR20260325 - Remove DataSource reference when the linked component is destroyed
procedure TDBKingDateSpin.Notification(
  AComponent : TComponent;
  AOperation : TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = FDataLink.DataSource)
  then
    DataSource := nil;
end;

// LR20260325 - Read field value into spin editor when dataset changes
procedure TDBKingDateSpin.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull)
  then
    Value := FDataLink.Field.AsDateTime
  else
    Text := '';
end;

// LR20260325 - Toggle inherited ReadOnly based on dataset editing state
procedure TDBKingDateSpin.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

// LR20260325 - Write spin value back to the field when the dataset posts
procedure TDBKingDateSpin.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil
  then
    FDataLink.Field.AsDateTime := Value;
end;

// LR20260325 - Put dataset into edit mode before incrementing
procedure TDBKingDateSpin.UpClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited UpClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode before decrementing
procedure TDBKingDateSpin.DownClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited DownClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode for +/- key presses
procedure TDBKingDateSpin.KeyPress(var AKey: Char);
begin
  if (AKey = '+') or (AKey = '-')
  then
    FDataLink.Edit;
  inherited KeyPress(AKey);
end;

// LR20260325 - Flush pending changes when focus leaves the control
procedure TDBKingDateSpin.CMExit(var AMessage: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// LR20260325 - Property accessor: DataField
function TDBKingDateSpin.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

// LR20260325 - Property accessor: DataField
procedure TDBKingDateSpin.SetDataField(const AValue: string);
begin
  FDataLink.FieldName := AValue;
end;

// LR20260325 - Property accessor: DataSource
function TDBKingDateSpin.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

// LR20260325 - Property accessor: DataSource
procedure TDBKingDateSpin.SetDataSource(AValue: TDataSource);
begin
  FDataLink.DataSource := AValue;
end;

// LR20260325 - Property accessor: ReadOnly
function TDBKingDateSpin.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// LR20260325 - Property accessor: ReadOnly
procedure TDBKingDateSpin.SetReadOnly(AValue: Boolean);
begin
  FDataLink.ReadOnly := AValue;
end;

// LR20260325 - Property accessor: Field
function TDBKingDateSpin.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ **************************************************************************** }
{ TDBKingTimeSpin                                                              }
{ **************************************************************************** }

// LR20260325 - Initial implementation
constructor TDBKingTimeSpin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  try
    FDataLink.Control := Self;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnEditingChange := EditingChange;
    FDataLink.OnUpdateData := UpdateData;
  except
    FreeAndNil(FDataLink);
    raise;
  end;
end;

// LR20260325 - Initial implementation
destructor TDBKingTimeSpin.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

// LR20260325 - Remove DataSource reference when the linked component is destroyed
procedure TDBKingTimeSpin.Notification(
  AComponent : TComponent;
  AOperation : TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = FDataLink.DataSource)
  then
    DataSource := nil;
end;

// LR20260325 - Read field value into spin editor when dataset changes
procedure TDBKingTimeSpin.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull)
  then
    Value := FDataLink.Field.AsDateTime
  else
    Text := '';
end;

// LR20260325 - Toggle inherited ReadOnly based on dataset editing state
procedure TDBKingTimeSpin.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

// LR20260325 - Write spin value back to the field when the dataset posts
procedure TDBKingTimeSpin.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil
  then
    FDataLink.Field.AsDateTime := Value;
end;

// LR20260325 - Put dataset into edit mode before incrementing
procedure TDBKingTimeSpin.UpClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited UpClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode before decrementing
procedure TDBKingTimeSpin.DownClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited DownClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode for +/- key presses
procedure TDBKingTimeSpin.KeyPress(var AKey: Char);
begin
  if (AKey = '+') or (AKey = '-')
  then
    FDataLink.Edit;
  inherited KeyPress(AKey);
end;

// LR20260325 - Flush pending changes when focus leaves the control
procedure TDBKingTimeSpin.CMExit(var AMessage: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// LR20260325 - Property accessor: DataField
function TDBKingTimeSpin.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

// LR20260325 - Property accessor: DataField
procedure TDBKingTimeSpin.SetDataField(const AValue: string);
begin
  FDataLink.FieldName := AValue;
end;

// LR20260325 - Property accessor: DataSource
function TDBKingTimeSpin.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

// LR20260325 - Property accessor: DataSource
procedure TDBKingTimeSpin.SetDataSource(AValue: TDataSource);
begin
  FDataLink.DataSource := AValue;
end;

// LR20260325 - Property accessor: ReadOnly
function TDBKingTimeSpin.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// LR20260325 - Property accessor: ReadOnly
procedure TDBKingTimeSpin.SetReadOnly(AValue: Boolean);
begin
  FDataLink.ReadOnly := AValue;
end;

// LR20260325 - Property accessor: Field
function TDBKingTimeSpin.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ **************************************************************************** }
{ TDBKingMDYSpin                                                               }
{ **************************************************************************** }

// LR20260325 - Initial implementation
constructor TDBKingMDYSpin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  try
    FDataLink.Control := Self;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnEditingChange := EditingChange;
    FDataLink.OnUpdateData := UpdateData;
  except
    FreeAndNil(FDataLink);
    raise;
  end;
end;

// LR20260325 - Initial implementation
destructor TDBKingMDYSpin.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

// LR20260325 - Remove DataSource reference when the linked component is destroyed
procedure TDBKingMDYSpin.Notification(
  AComponent : TComponent;
  AOperation : TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = FDataLink.DataSource)
  then
    DataSource := nil;
end;

// LR20260325 - Read field value into spin editor when dataset changes
procedure TDBKingMDYSpin.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull)
  then
    Value := FDataLink.Field.AsDateTime
  else
    Text := '';
end;

// LR20260325 - Toggle inherited ReadOnly based on dataset editing state
procedure TDBKingMDYSpin.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

// LR20260325 - Write spin value back to the field when the dataset posts
procedure TDBKingMDYSpin.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil
  then
    FDataLink.Field.AsDateTime := Value;
end;

// LR20260325 - Put dataset into edit mode before incrementing
procedure TDBKingMDYSpin.UpClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited UpClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode before decrementing
procedure TDBKingMDYSpin.DownClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited DownClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode for +/- key presses
procedure TDBKingMDYSpin.KeyPress(var AKey: Char);
begin
  if (AKey = '+') or (AKey = '-')
  then
    FDataLink.Edit;
  inherited KeyPress(AKey);
end;

// LR20260325 - Flush pending changes when focus leaves the control
procedure TDBKingMDYSpin.CMExit(var AMessage: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// LR20260325 - Property accessor: DataField
function TDBKingMDYSpin.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

// LR20260325 - Property accessor: DataField
procedure TDBKingMDYSpin.SetDataField(const AValue: string);
begin
  FDataLink.FieldName := AValue;
end;

// LR20260325 - Property accessor: DataSource
function TDBKingMDYSpin.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

// LR20260325 - Property accessor: DataSource
procedure TDBKingMDYSpin.SetDataSource(AValue: TDataSource);
begin
  FDataLink.DataSource := AValue;
end;

// LR20260325 - Property accessor: ReadOnly
function TDBKingMDYSpin.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// LR20260325 - Property accessor: ReadOnly
procedure TDBKingMDYSpin.SetReadOnly(AValue: Boolean);
begin
  FDataLink.ReadOnly := AValue;
end;

// LR20260325 - Property accessor: Field
function TDBKingMDYSpin.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ **************************************************************************** }
{ TDBKingHMSpin                                                                }
{ **************************************************************************** }

// LR20260325 - Initial implementation
constructor TDBKingHMSpin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  try
    FDataLink.Control := Self;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnEditingChange := EditingChange;
    FDataLink.OnUpdateData := UpdateData;
  except
    FreeAndNil(FDataLink);
    raise;
  end;
end;

// LR20260325 - Initial implementation
destructor TDBKingHMSpin.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

// LR20260325 - Remove DataSource reference when the linked component is destroyed
procedure TDBKingHMSpin.Notification(
  AComponent : TComponent;
  AOperation : TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = FDataLink.DataSource)
  then
    DataSource := nil;
end;

// LR20260325 - Read field value into spin editor when dataset changes
procedure TDBKingHMSpin.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull)
  then
    Value := FDataLink.Field.AsDateTime
  else
    Text := '';
end;

// LR20260325 - Toggle inherited ReadOnly based on dataset editing state
procedure TDBKingHMSpin.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

// LR20260325 - Write spin value back to the field when the dataset posts
procedure TDBKingHMSpin.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil
  then
    FDataLink.Field.AsDateTime := Value;
end;

// LR20260325 - Put dataset into edit mode before incrementing
procedure TDBKingHMSpin.UpClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited UpClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode before decrementing
procedure TDBKingHMSpin.DownClick(Sender: TObject);
begin
  if FDataLink.Edit
  then
  begin
    inherited DownClick(Sender);
    FDataLink.Modified;
  end;
end;

// LR20260325 - Put dataset into edit mode for +/- key presses
procedure TDBKingHMSpin.KeyPress(var AKey: Char);
begin
  if (AKey = '+') or (AKey = '-')
  then
    FDataLink.Edit;
  inherited KeyPress(AKey);
end;

// LR20260325 - Flush pending changes when focus leaves the control
procedure TDBKingHMSpin.CMExit(var AMessage: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// LR20260325 - Property accessor: DataField
function TDBKingHMSpin.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

// LR20260325 - Property accessor: DataField
procedure TDBKingHMSpin.SetDataField(const AValue: string);
begin
  FDataLink.FieldName := AValue;
end;

// LR20260325 - Property accessor: DataSource
function TDBKingHMSpin.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

// LR20260325 - Property accessor: DataSource
procedure TDBKingHMSpin.SetDataSource(AValue: TDataSource);
begin
  FDataLink.DataSource := AValue;
end;

// LR20260325 - Property accessor: ReadOnly
function TDBKingHMSpin.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// LR20260325 - Property accessor: ReadOnly
procedure TDBKingHMSpin.SetReadOnly(AValue: Boolean);
begin
  FDataLink.ReadOnly := AValue;
end;

// LR20260325 - Property accessor: Field
function TDBKingHMSpin.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ **************************************************************************** }
{ TDBKingDateDialog                                                            }
{ **************************************************************************** }

// LR20260325 - Initial implementation
constructor TDBKingDateDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  try
    FDataLink.Control := Self;
    FDataLink.OnDataChange := DataChange;
    FDataLink.OnEditingChange := EditingChange;
    FDataLink.OnUpdateData := UpdateData;
  except
    FreeAndNil(FDataLink);
    raise;
  end;
end;

// LR20260325 - Initial implementation
destructor TDBKingDateDialog.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

// LR20260325 - Remove DataSource reference when the linked component is destroyed
procedure TDBKingDateDialog.Notification(
  AComponent : TComponent;
  AOperation : TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = FDataLink.DataSource)
  then
    DataSource := nil;
end;

// LR20260325 - Read field value into text display when dataset changes
procedure TDBKingDateDialog.DataChange(Sender: TObject);
var
  LFormatSettings: TFormatSettings;
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull)
  then
  begin
{$WARN SYMBOL_PLATFORM OFF}
    LFormatSettings := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
{$WARN SYMBOL_PLATFORM ON}
    Text := DateToStr(FDataLink.Field.AsDateTime, LFormatSettings);
  end
  else
    Text := '';
end;

// LR20260325 - Toggle inherited ReadOnly based on dataset editing state
procedure TDBKingDateDialog.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

// LR20260325 - Write text value back to the field when the dataset posts
procedure TDBKingDateDialog.UpdateData(Sender: TObject);
var
  LFormatSettings: TFormatSettings;
begin
  if FDataLink.Field <> nil
  then
  begin
{$WARN SYMBOL_PLATFORM OFF}
    LFormatSettings := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
{$WARN SYMBOL_PLATFORM ON}
    FDataLink.Field.AsDateTime := StrToDateTime(Text, LFormatSettings);
  end;
end;

// LR20260325 - Put dataset into edit mode, launch popup, then mark modified
procedure TDBKingDateDialog.BtnClick(Sender: TObject);
begin
  if not FDataLink.Edit
  then
    Exit;
  inherited BtnClick(Sender);
  FDataLink.Modified;
end;

// LR20260325 - Flush pending changes when focus leaves the control
procedure TDBKingDateDialog.CMExit(var AMessage: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

// LR20260325 - Property accessor: DataField
function TDBKingDateDialog.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

// LR20260325 - Property accessor: DataField
procedure TDBKingDateDialog.SetDataField(const AValue: string);
begin
  FDataLink.FieldName := AValue;
end;

// LR20260325 - Property accessor: DataSource
function TDBKingDateDialog.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

// LR20260325 - Property accessor: DataSource
procedure TDBKingDateDialog.SetDataSource(AValue: TDataSource);
begin
  FDataLink.DataSource := AValue;
end;

// LR20260325 - Property accessor: ReadOnly
function TDBKingDateDialog.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

// LR20260325 - Property accessor: ReadOnly
procedure TDBKingDateDialog.SetReadOnly(AValue: Boolean);
begin
  FDataLink.ReadOnly := AValue;
end;

// LR20260325 - Property accessor: Field
function TDBKingDateDialog.GetField: TField;
begin
  Result := FDataLink.Field;
end;

end.
