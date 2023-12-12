object KcCalc: TKcCalc
  Left = 194
  Top = 118
  ActiveControl = Date2
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'KingCalendar Date Calculator'
  ClientHeight = 225
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF007777
    7777777777777777777777777777777777777777777777777777777777777000
    000000000000000000000000000770FFFFFFFFFFFFFFFFFFFFFFFFFFFF0770F0
    0000FF00000FF00000FF00000F0770FFFFFFFFFFFFFFFFFFFFFFFFFFFF0770F0
    0000FF00000FF00000FF00000F0770FFFFFFFFFFFFFFFFFFFFFFFFFFFF0770F0
    0000FF00000FF00000FF00000F0770FFFFFFFFFFFFFFFFFFFFFFFFFFFF0770F0
    0000FF00000FF00000FF00000F0770FFFFFFFFFFFFFFFFFFFFFFFFFFFF0770F4
    4444444444444444444444444F0770F44444444444444444444444444F0770FF
    FFFFFFFFFFFFFFFFFFFFFFFFFF07700000000000000000000000000000077777
    0FFFFFFF1FFFFFF1FFFFF007777777770FFFFFFF1FFFFFF1FFFFF00777777777
    0FFFFF111FFFF111FFFFF007777777770FFFFFF11FFFFF11FFFFF00777777777
    0FFFFFFF1FFFFFF1FFFFF007777777770FFFFFFFFFFFFFFFFFFFF00777777777
    000000000000000000000007777777770EEEEEEEEEEEEEEEEEEEE00777777777
    0EEEEEEEEEEEEEEEEEEEE007777777770EEE0EEEEEEEEEEE0EEEE00777777777
    0000000000000000000000777777777777077707777777077707777777777777
    7770007777777770007777777777777777777777777777777777777777777777
    7777777777777777777777777777777777777777777777777777777777770000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 200
    Top = 24
    Width = 13
    Height = 24
    Caption = '='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 96
    Top = 40
    Width = 17
    Height = 17
    Hint = 'Subtract number of days from date'
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 96
    Top = 16
    Width = 17
    Height = 17
    Hint = 'Add number of days to date to '
    Caption = '+'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton2Click
  end
  object Bevel1: TBevel
    Left = 8
    Top = 64
    Width = 353
    Height = 1
    Style = bsRaised
  end
  object SpeedButton3: TSpeedButton
    Left = 192
    Top = 88
    Width = 25
    Height = 25
    Hint = 
      'Calculate the Total Number of Days and the Total number of Work ' +
      'Days'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
      73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
      0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
      0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
      0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
      0333337F777777737F333308888888880333337F333333337F33330888888888
      03333373FFFFFFFF733333700000000073333337777777773333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton3Click
  end
  object Label4: TLabel
    Left = 8
    Top = 72
    Width = 48
    Height = 13
    Caption = 'Start Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 96
    Top = 72
    Width = 45
    Height = 13
    Caption = 'End Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 224
    Top = 72
    Width = 51
    Height = 13
    Caption = 'Total Days'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 296
    Top = 72
    Width = 53
    Height = 13
    Caption = 'Work Days'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 224
    Top = 8
    Width = 48
    Height = 13
    Caption = 'New Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Base Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 120
    Top = 8
    Width = 58
    Height = 13
    Caption = 'Days to Add'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 6
    Top = 128
    Width = 355
    Height = 1
    Style = bsRaised
  end
  object Label3: TLabel
    Left = 8
    Top = 136
    Width = 23
    Height = 13
    Caption = 'Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton4: TSpeedButton
    Left = 104
    Top = 152
    Width = 25
    Height = 25
    Hint = 'Calculate the Week and Day of the Year for the Specified Date'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      003337777777777777F330FFFFFFFFFFF03337F3333FFF3337F330FFFF000FFF
      F03337F33377733337F330FFFFF0FFFFF03337F33337F33337F330FFFF00FFFF
      F03337F33377F33337F330FFFFF0FFFFF03337F33337333337F330FFFFFFFFFF
      F03337FFF3F3F3F3F7F33000F0F0F0F0F0333777F7F7F7F7F7F330F0F000F070
      F03337F7F777F777F7F330F0F0F0F070F03337F7F7373777F7F330F0FF0FF0F0
      F03337F733733737F7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
      F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
      333337FFFFFFFF77333330000000000333333777777777733333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton4Click
  end
  object Label10: TLabel
    Left = 136
    Top = 136
    Width = 66
    Height = 13
    Caption = 'Week of Year'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 216
    Top = 136
    Width = 56
    Height = 13
    Caption = 'Day of Year'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 296
    Top = 136
    Width = 63
    Height = 13
    Caption = 'Day of Week'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 264
    Top = 192
    Width = 97
    Height = 25
    Caption = '&Close'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Date1: TKingDateSpin
    Left = 8
    Top = 24
    Width = 81
    Height = 26
    DateFormat = 'M/d/yy'
    StartDate = '12/30/18'
    AutoSelect = False
    ReadOnly = True
  end
  object Date2: TEdit
    Left = 120
    Top = 24
    Width = 73
    Height = 24
    TabOrder = 2
  end
  object dStart: TKingDateSpin
    Left = 8
    Top = 88
    Width = 81
    Height = 26
    DateFormat = 'M/d/yy'
    StartDate = '12/30/18'
    AutoSelect = False
    ReadOnly = True
  end
  object dEnd: TKingDateSpin
    Left = 96
    Top = 88
    Width = 89
    Height = 26
    DateFormat = 'M/d/yy'
    StartDate = '12/31/18'
    AutoSelect = False
    ReadOnly = True
  end
  object tDays: TEdit
    Left = 224
    Top = 88
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object wDays: TEdit
    Left = 296
    Top = 88
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object NewDate: TEdit
    Left = 224
    Top = 24
    Width = 73
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object KingDateSpin1: TKingDateSpin
    Left = 8
    Top = 152
    Width = 89
    Height = 26
    DateFormat = 'M/d/yy'
    StartDate = '12/30/18'
    AutoSelect = False
    ReadOnly = True
  end
  object WeekYear: TEdit
    Left = 136
    Top = 152
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object DayYear: TEdit
    Left = 216
    Top = 152
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object DayWeek: TEdit
    Left = 296
    Top = 152
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
end
