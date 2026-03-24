object Form1: TForm1
  Left = 152
  Top = 101
  BorderStyle = bsDialog
  Caption = 'Another TKingPopup Example'
  ClientHeight = 230
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 48
    Height = 13
    Caption = 'Start Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 136
    Top = 32
    Width = 45
    Height = 13
    Caption = 'End Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 241
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'TKingDateDialog Component'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 200
    Width = 81
    Height = 25
    Caption = '&Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 80
    Width = 241
    Height = 113
    BorderStyle = bsNone
    Color = clBtnFace
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    Lines.Strings = (
      'Click the SpeedButtons to select the '
      'dates. Notice how the Popup Calendar '
      'Alligns itself to each Edit Box. Double '
      'Click on the date in the Calendar to'
      'Select it. See the code under the '
      'SpeedButtons for the secret!')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object KingDateDialog1: TKingDateDialog
    Left = 8
    Top = 48
    Width = 113
    Height = 22
    KingPopup = KingPopup1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object KingDateDialog2: TKingDateDialog
    Left = 136
    Top = 48
    Width = 113
    Height = 22
    KingPopup = KingPopup1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object KingPopup1: TKingPopup
    AlignSource = KingDateDialog1
    Left = 225
    Top = 15
  end
end
