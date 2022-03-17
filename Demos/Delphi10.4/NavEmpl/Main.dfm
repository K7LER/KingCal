object Form1: TForm1
  Left = 177
  Top = 156
  BorderStyle = bsDialog
  Caption = 'KingCalendar Navigator Example'
  ClientHeight = 389
  ClientWidth = 530
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 145
    Caption = ' TKingCalendar '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object KingCalendar1: TKingCalendar
      Left = 8
      Top = 18
      Width = 317
      Height = 117
      Day = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Month = 12
      ParentFont = False
      Year = 2018
      TabOrder = 0
      TextPlacement = ktTopLeft
      DowNames.Strings = (
        'Sun'
        'Mon'
        'Tue'
        'Wed'
        'Thu'
        'Fri'
        'Sat')
      ColorSets.ColorSet1 = clRed
      ColorSets.ColorSet2 = clLime
      ColorSets.ColorSet3 = clBlue
      ColorSets.ColorSet4 = clTeal
      ColorSets.ColorSet5 = clGreen
      ColorSets.ColorSet6 = clFuchsia
      ColorSets.ColorSet7 = clMaroon
      ColorSets.ColorSet8 = clAqua
      ColorSets.ColorSet9 = clYellow
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
        15
        15
        15
        15
        15
        15)
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 160
    Width = 337
    Height = 49
    Caption = ' TKingNavigator '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object KingNavigator1: TKingNavigator
      Left = 8
      Top = 18
      Width = 316
      Height = 21
      CalendarSource = KingCalendar1
      Highlight = clBlue
      TabOrder = 0
      TodayText = 'Today'
      ParentShowHint = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 215
    Width = 337
    Height = 41
    Caption = ' TMonthBar '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object MonthBar1: TMonthBar
      Left = 8
      Top = 16
      Width = 313
      Height = 18
      CalendarSource = KingCalendar1
      Highlight = clBlue
      ParentShowHint = False
    end
  end
  object GroupBox4: TGroupBox
    Left = 352
    Top = 6
    Width = 169
    Height = 114
    Caption = ' Month/Year Combos '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object MonthCombo1: TMonthCombo
      Left = 8
      Top = 16
      Width = 145
      Height = 21
      CalendarSource = KingCalendar1
    end
    object YearCombo1: TYearCombo
      Left = 8
      Top = 48
      Width = 145
      Height = 21
      CalendarSource = KingCalendar1
      MinYear = 1980
      MaxYear = 2020
    end
    object DayCombo1: TDayCombo
      Left = 7
      Top = 79
      Width = 145
      Height = 21
      CalendarSource = KingCalendar1
    end
  end
  object GroupBox5: TGroupBox
    Left = 352
    Top = 124
    Width = 169
    Height = 49
    Caption = ' M/D/Y Spins '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 32
      Top = 24
      Width = 28
      Height = 11
      Caption = 'Month'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 88
      Top = 24
      Width = 16
      Height = 11
      Caption = 'Day'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 136
      Top = 24
      Width = 19
      Height = 11
      Caption = 'Year'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
    object MonthSpin1: TMonthSpin
      Left = 8
      Top = 16
      Width = 20
      Height = 25
      DownGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000333303333000000033300033300000003300000330000000300000003000
        00003333333330000000}
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
      Left = 64
      Top = 16
      Width = 20
      Height = 25
      DownGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000333303333000000033300033300000003300000330000000300000003000
        00003333333330000000}
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
      Left = 112
      Top = 16
      Width = 20
      Height = 25
      DownGlyph.Data = {
        A6000000424DA600000000000000760000002800000009000000060000000100
        0400000000003000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333000
        0000333303333000000033300033300000003300000330000000300000003000
        00003333333330000000}
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
  object Memo1: TMemo
    Left = 352
    Top = 176
    Width = 169
    Height = 129
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    Lines.Strings = (
      'All of these controls are '
      'wired up to the Calendar. '
      'Click on any of them and '
      'watch the calendar respond. '
      'The current date can be '
      'found in the '
      'TKingNavigator'#39's'
      'middle button!')
    ParentFont = False
    TabOrder = 5
  end
  object GroupBox6: TGroupBox
    Left = 7
    Top = 262
    Width = 339
    Height = 43
    Caption = ' TKingLabel '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object KingLabel1: TKingLabel
      Left = 2
      Top = 16
      Width = 335
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sunday, December 30, 2018 - Week Number 52'
      CalendarSource = KingCalendar1
      DateFormat = 'MMMM DD, YYYY'
      IncludeWeekNum = True
    end
  end
  object GroupBox7: TGroupBox
    Left = 8
    Top = 311
    Width = 339
    Height = 43
    Caption = ' TKingWeekLabel '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object KingWeekLabel1: TKingWeekLabel
      Left = 3
      Top = 16
      Width = 333
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '52'
      CalendarSource = KingCalendar1
      IncludeCaption = True
    end
  end
end
