object FrmMain: TFrmMain
  Left = 108
  Top = 66
  Caption = 'KingCalendar Drag and Drop Example'
  ClientHeight = 462
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 17
  object Label1: TLabel
    Left = 536
    Top = 2
    Width = 97
    Height = 16
    AutoSize = False
    Caption = 'Appointments'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 536
    Top = 81
    Width = 97
    Height = 16
    AutoSize = False
    Caption = 'Phone Calls'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 536
    Top = 158
    Width = 97
    Height = 16
    AutoSize = False
    Caption = 'To Do'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 536
    Top = 233
    Width = 89
    Height = 16
    AutoSize = False
    Caption = 'Meetings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 536
    Top = 309
    Width = 97
    Height = 16
    AutoSize = False
    Caption = 'Other'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 536
    Top = 381
    Width = 89
    Height = 16
    AutoSize = False
    Caption = 'Personal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object KingLabel1: TKingLabel
    Left = 7
    Top = 428
    Width = 523
    Height = 31
    Alignment = taCenter
    AutoSize = False
    Caption = 'Monday, March 23, 2026'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    CalendarSource = KingCalendar1
    DateFormat = 'MMMM DD, YYYY'
    IncludeWeekNum = False
  end
  object KingCalendar1: TKingCalendar
    Left = 7
    Top = 4
    Width = 520
    Height = 417
    Day = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    Month = 3
    ParentFont = False
    Year = 2026
    OnDragDrop = KingCalendar1DragDrop
    OnDragOver = KingCalendar1DragOver
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
    OnDayFlag = KingCalendar1DayFlag
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
    TextInCell = True
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clWindowText
    TextFont.Height = -9
    TextFont.Name = 'Segoe UI'
    TextFont.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    ColorCellText = True
    ColorCellDay = False
    RowHeights = (
      17
      65
      65
      65
      65
      65
      65)
  end
  object ListBox1: TListBox
    Tag = 1
    Left = 536
    Top = 18
    Width = 97
    Height = 57
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'BI Video'
      'Lunch w/Lance'
      'Sleep')
    ParentFont = False
    TabOrder = 1
  end
  object ListBox2: TListBox
    Tag = 2
    Left = 536
    Top = 96
    Width = 97
    Height = 57
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'Call DFL'
      'Call Wife'
      'Dave @ Bank')
    ParentFont = False
    TabOrder = 2
  end
  object ListBox3: TListBox
    Tag = 3
    Left = 536
    Top = 173
    Width = 97
    Height = 57
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'Lunch'
      'Lunch'
      'SD95 Booth')
    ParentFont = False
    TabOrder = 3
  end
  object ListBox4: TListBox
    Tag = 4
    Left = 536
    Top = 247
    Width = 97
    Height = 57
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'POS Meeting'
      'Target Marketing')
    ParentFont = False
    TabOrder = 4
  end
  object ListBox5: TListBox
    Tag = 5
    Left = 536
    Top = 324
    Width = 97
    Height = 57
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'Build Disks'
      'Print Brochures')
    ParentFont = False
    TabOrder = 5
  end
  object ListBox6: TListBox
    Tag = 6
    Left = 536
    Top = 396
    Width = 97
    Height = 57
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      'Wash Car')
    ParentFont = False
    TabOrder = 6
  end
end
