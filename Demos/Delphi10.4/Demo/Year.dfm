object FrmYear: TFrmYear
  Left = 85
  Top = 28
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Year At A Glance'
  ClientHeight = 461
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label2: TLabel
    Left = 8
    Top = 16
    Width = 625
    Height = 30
    Alignment = taCenter
    AutoSize = False
    Caption = 'KingCalendar for Delphi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'Albertus Medium'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 22
    Top = 13
    Width = 80
    Height = 13
    Caption = 'Change the Year'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object KingLabel1: TKingLabel
    Left = 0
    Top = 328
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar9
    DateFormat = 'MMMM'
  end
  object KingLabel2: TKingLabel
    Left = 160
    Top = 328
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar10
    DateFormat = 'MMMM'
  end
  object KingLabel3: TKingLabel
    Left = 320
    Top = 328
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar11
    DateFormat = 'MMMM'
  end
  object KingLabel4: TKingLabel
    Left = 480
    Top = 328
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar12
    DateFormat = 'MMMM'
  end
  object KingLabel5: TKingLabel
    Left = 480
    Top = 200
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar8
    DateFormat = 'MMMM'
  end
  object KingLabel6: TKingLabel
    Left = 320
    Top = 200
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar7
    DateFormat = 'MMMM'
  end
  object KingLabel7: TKingLabel
    Left = 160
    Top = 200
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar6
    DateFormat = 'MMMM'
  end
  object KingLabel8: TKingLabel
    Left = 0
    Top = 200
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar5
    DateFormat = 'MMMM'
  end
  object KingLabel9: TKingLabel
    Left = 0
    Top = 72
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar1
    DateFormat = 'MMMM'
  end
  object KingLabel10: TKingLabel
    Left = 160
    Top = 72
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar2
    DateFormat = 'MMMM'
  end
  object KingLabel11: TKingLabel
    Left = 320
    Top = 72
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar3
    DateFormat = 'MMMM'
  end
  object KingLabel12: TKingLabel
    Left = 480
    Top = 72
    Width = 153
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    CalendarSource = KingCalendar4
    DateFormat = 'MMMM'
  end
  object Button1: TButton
    Left = 520
    Top = 16
    Width = 113
    Height = 25
    Hint = 
      'Use this button to randomly color the 12 calendars. This simulat' +
      'es how a real Year at a Glance would look'
    Caption = '&Color the Months'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 24
    Top = 32
    Width = 89
    Height = 22
    Hint = 'Use this SpinEdit to change the currently visible year'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxValue = 0
    MinValue = 0
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 2
    OnChange = SpinEdit1Change
  end
  object KingCalendar1: TKingCalendar
    Left = 0
    Top = 88
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 2
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar2: TKingCalendar
    Left = 160
    Top = 88
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 3
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar3: TKingCalendar
    Left = 320
    Top = 88
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 4
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar4: TKingCalendar
    Left = 480
    Top = 88
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 5
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar5: TKingCalendar
    Left = 0
    Top = 216
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 6
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar6: TKingCalendar
    Left = 160
    Top = 216
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 7
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar7: TKingCalendar
    Left = 320
    Top = 216
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 8
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar8: TKingCalendar
    Left = 480
    Top = 216
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 9
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar9: TKingCalendar
    Left = 0
    Top = 344
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 10
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar10: TKingCalendar
    Left = 160
    Top = 344
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 11
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar11: TKingCalendar
    Left = 320
    Top = 344
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 12
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
  object KingCalendar12: TKingCalendar
    Left = 488
    Top = 344
    Width = 156
    Height = 86
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    IsActive = False
    TabOrder = 13
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
    TitleFont.Height = -9
    TitleFont.Name = 'Small Fonts'
    TitleFont.Style = []
    HeaderUseFixed = False
  end
end
