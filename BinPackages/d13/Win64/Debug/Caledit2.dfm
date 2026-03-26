object FrmColor: TFrmColor
  Left = 364
  Top = 95
  BorderStyle = bsDialog
  Caption = 'Create a Custom Color'
  ClientHeight = 120
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 80
    Width = 185
    Height = 33
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 24
    Height = 13
    Caption = 'Red'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 35
    Height = 13
    Caption = 'Green'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 26
    Height = 13
    Caption = 'Blue'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 344
    Top = 8
    Width = 22
    Height = 13
    Caption = '192'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 344
    Top = 32
    Width = 22
    Height = 13
    Caption = '192'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 344
    Top = 56
    Width = 22
    Height = 13
    Caption = '192'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image1: TImage
    Left = 10
    Top = 82
    Width = 181
    Height = 29
  end
  object sR: TScrollBar
    Left = 48
    Top = 8
    Width = 289
    Height = 17
    Max = 255
    PageSize = 0
    Position = 192
    TabOrder = 0
    OnChange = sRChange
  end
  object sG: TScrollBar
    Left = 48
    Top = 32
    Width = 289
    Height = 17
    Max = 255
    PageSize = 0
    Position = 192
    TabOrder = 1
    OnChange = sGChange
  end
  object sB: TScrollBar
    Left = 48
    Top = 56
    Width = 289
    Height = 17
    Max = 255
    PageSize = 0
    Position = 192
    TabOrder = 2
    OnChange = sBChange
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 88
    Width = 89
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 200
    Top = 88
    Width = 89
    Height = 25
    Caption = '&Apply'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
  end
end
