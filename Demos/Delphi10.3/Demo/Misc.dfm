object FrmMisc: TFrmMisc
  Left = 190
  Top = 137
  ActiveControl = KingCalendar1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Spinners, Combo'#39's and Labels'
  ClientHeight = 287
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 392
    Top = 176
    Width = 177
    Height = 73
  end
  object Label11: TLabel
    Left = 400
    Top = 184
    Width = 168
    Height = 13
    Caption = 'Notice how each control is updated'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 400
    Top = 200
    Width = 163
    Height = 13
    Caption = 'automaticaly. When then Calendar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 400
    Top = 216
    Width = 153
    Height = 13
    Caption = 'changes, the components all will'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 400
    Top = 232
    Width = 92
    Height = 13
    Caption = 'update themselves!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 448
    Top = 256
    Width = 89
    Height = 25
    Caption = '&Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object KingCalendar1: TKingCalendar
    Left = 8
    Top = 8
    Width = 373
    Height = 171
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    TabOrder = 1
    TextPlacement = ktTopLeft
    DowNames.Strings = (
      'Sun'
      'Mon'
      'Tue'
      'Wed'
      'Thu'
      'Fri'
      'Sat')
    ColorSets.ColorSet1 = clPurple
    ColorSets.ColorSet2 = clBlue
    ColorSets.ColorSet3 = clAqua
    ColorSets.ColorSet4 = clGreen
    ColorSets.ColorSet5 = clLime
    ColorSets.ColorSet6 = clOlive
    ColorSets.ColorSet7 = clYellow
    ColorSets.ColorSet8 = clMaroon
    ColorSets.ColorSet9 = clRed
    StartingDay = 0
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clWindowText
    TextFont.Height = -13
    TextFont.Name = 'System'
    TextFont.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    RowHeights = (
      12
      24
      24
      24
      24
      24
      24)
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 192
    Width = 377
    Height = 89
    Caption = ' ComboBoxes '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 306
      Height = 13
      Caption = 'These three combo boxes make Calendar manipulation a breeze.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 33
      Height = 13
      Caption = 'Month '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 152
      Top = 40
      Width = 19
      Height = 13
      Caption = 'Day'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 264
      Top = 40
      Width = 22
      Height = 13
      Caption = 'Year'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object MonthCombo1: TMonthCombo
      Left = 8
      Top = 56
      Width = 124
      Height = 21
      Hint = 'Use these ComboBoxe'#39's to change the Calendar'#39's Month'
      CalendarSource = KingCalendar1
      ParentShowHint = False
      ShowHint = True
    end
    object DayCombo1: TDayCombo
      Left = 152
      Top = 56
      Width = 97
      Height = 21
      Hint = 'Use these ComboBoxe'#39's to change the Calendar'#39's Day'
      CalendarSource = KingCalendar1
      ParentShowHint = False
      ShowHint = True
    end
    object YearCombo1: TYearCombo
      Left = 264
      Top = 56
      Width = 105
      Height = 21
      Hint = 'Use these ComboBoxe'#39's to change the Calendar'#39's Year'
      CalendarSource = KingCalendar1
      MinYear = 1980
      MaxYear = 2020
      ParentShowHint = False
      ShowHint = True
    end
  end
  object GroupBox2: TGroupBox
    Left = 392
    Top = 8
    Width = 177
    Height = 81
    Caption = ' Spin Controls '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label5: TLabel
      Left = 8
      Top = 16
      Width = 164
      Height = 13
      Caption = 'Spin your way to Calendar Heaven'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 32
      Width = 30
      Height = 13
      Caption = 'Month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 72
      Top = 32
      Width = 19
      Height = 13
      Caption = 'Day'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 136
      Top = 32
      Width = 22
      Height = 13
      Caption = 'Year'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object MonthSpin1: TMonthSpin
      Left = 16
      Top = 48
      Width = 20
      Height = 25
      Hint = 'Use this spin control to change the Calendar'#39's Month'
      DownGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000333303333000000033300033300000003300000330000000300000003000
        00003333333330000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      UpGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000300000003000000033000003300000003330003330000000333303333000
        00003333333330000000}
      CalendarSource = KingCalendar1
    end
    object DaySpin1: TDaySpin
      Left = 72
      Top = 48
      Width = 20
      Height = 25
      Hint = 'Use this spin control to change the Calendar'#39's Day'
      DownGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000333303333000000033300033300000003300000330000000300000003000
        00003333333330000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      UpGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000300000003000000033000003300000003330003330000000333303333000
        00003333333330000000}
      CalendarSource = KingCalendar1
    end
    object YearSpin1: TYearSpin
      Left = 136
      Top = 48
      Width = 20
      Height = 25
      Hint = 'Use this spin control to change the Calendar'#39's Year'
      DownGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000333303333000000033300033300000003300000330000000300000003000
        00003333333330000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      UpGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000300000003000000033000003300000003330003330000000333303333000
        00003333333330000000}
      CalendarSource = KingCalendar1
      MinYear = 1980
      MaxYear = 2020
    end
  end
  object GroupBox3: TGroupBox
    Left = 392
    Top = 96
    Width = 177
    Height = 73
    Caption = ' Label '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 157
      Height = 13
      Caption = 'This label display'#39's the Calendar'#39's'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 32
      Width = 127
      Height = 13
      Caption = 'date, always, automaticaly.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object KingLabel1: TKingLabel
      Left = 8
      Top = 48
      Width = 161
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sunday, December 30, 2018'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      CalendarSource = KingCalendar1
      DateFormat = 'MMMM DD, YYYY'
    end
  end
end
