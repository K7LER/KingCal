object FrmNavigate: TFrmNavigate
  Left = 175
  Top = 103
  ActiveControl = KingCalendar1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Navigational Components'
  ClientHeight = 375
  ClientWidth = 591
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
  object KingLabel1: TKingLabel
    Left = 8
    Top = 0
    Width = 401
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sunday, December 30, 2018'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    CalendarSource = KingCalendar1
    DateFormat = 'MMMM DD, YYYY'
  end
  object BitBtn1: TBitBtn
    Left = 496
    Top = 8
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
    Tag = 1
    Left = 8
    Top = 24
    Width = 401
    Height = 167
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
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'System'
    TitleFont.Style = []
    RowHeights = (
      14
      23
      23
      23
      23
      23
      23)
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 200
    Width = 401
    Height = 89
    Caption = ' TKingNavigator Component '
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
      Width = 389
      Height = 13
      Caption = 
        'This navigator bar allows for rapid movement around the calendar' +
        ' with the ability to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 174
      Height = 13
      Caption = 'return to the current date at any time.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object KingNavigator1: TKingNavigator
      Left = 8
      Top = 56
      Width = 381
      Height = 21
      CalendarSource = KingCalendar1
      Highlight = clBlue
      TabOrder = 0
      TodayText = '12/11/18'
      ParentShowHint = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 296
    Width = 401
    Height = 73
    Caption = ' TMonthBar Component '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 303
      Height = 13
      Caption = 
        'Use the monthbar to rapidly scroll through the months of the yea' +
        'r'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object MonthBar1: TMonthBar
      Left = 8
      Top = 40
      Width = 313
      Height = 18
      CalendarSource = KingCalendar1
      Highlight = clBlue
      ParentShowHint = False
    end
  end
  object CheckBox1: TCheckBox
    Left = 416
    Top = 48
    Width = 169
    Height = 17
    Hint = 
      'This will toggle the value displayed in the Today (middle) butto' +
      'n of the Navigator. When checked, the words TODAY are displayed.' +
      ' When not checked, the currently focused date is displayed.'
    Caption = 'Display Text  in Navigator'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object GroupBox3: TGroupBox
    Left = 416
    Top = 88
    Width = 169
    Height = 241
    Caption = ' Misc. Components '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 142
      Height = 13
      Caption = 'These components, while not '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 32
      Width = 130
      Height = 13
      Caption = 'actually connectable to any'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 48
      Width = 141
      Height = 13
      Caption = 'KingCalendar, are included in '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 64
      Width = 125
      Height = 13
      Caption = 'the package as an added '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 80
      Width = 132
      Height = 13
      Caption = 'bonus. These are especially'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 96
      Width = 138
      Height = 13
      Caption = 'useful if your application uses'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 112
      Width = 93
      Height = 13
      Caption = 'date and time input.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 32
      Top = 136
      Width = 83
      Height = 13
      Caption = 'Date Spin Control'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 32
      Top = 184
      Width = 83
      Height = 13
      Caption = 'Time Spin Control'
    end
    object KingTimeSpin1: TKingTimeSpin
      Left = 32
      Top = 152
      Width = 105
      Height = 22
      TimeFormat = 'hh:mm AMPM'
      StartTime = '06:00 AM'
      AutoSelect = False
      ReadOnly = True
    end
    object KingDateSpin1: TKingDateSpin
      Left = 32
      Top = 203
      Width = 105
      Height = 22
      DateFormat = 'M/d/yy'
      StartDate = '4/29/95'
      AutoSelect = False
      ReadOnly = True
    end
  end
end
