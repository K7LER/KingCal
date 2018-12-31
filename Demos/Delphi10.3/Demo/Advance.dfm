object FrmAdvance: TFrmAdvance
  Left = 114
  Top = 61
  ActiveControl = KingCalendar1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Advanced Techniques'
  ClientHeight = 430
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 15
    Top = 2
    Width = 202
    Height = 33
  end
  object KingLabel1: TKingLabel
    Left = 23
    Top = 8
    Width = 186
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
  object Label1: TLabel
    Left = 504
    Top = 40
    Width = 64
    Height = 13
    Caption = 'Appointments'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 504
    Top = 128
    Width = 64
    Height = 13
    Caption = 'Calls to Make'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 504
    Top = 216
    Width = 59
    Height = 13
    Caption = 'Things to do'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 21
    Top = 336
    Width = 465
    Height = 89
  end
  object Label4: TLabel
    Left = 29
    Top = 344
    Width = 447
    Height = 13
    Caption = 
      'KingCalendar allows for the dragging and dropping of information' +
      ' right onto the Calendar. In this'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 29
    Top = 360
    Width = 446
    Height = 13
    Caption = 
      'example, simply select any item from the list boxes on the right' +
      ' and drag them onto a date in the'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 29
    Top = 376
    Width = 450
    Height = 13
    Caption = 
      'calendar. Each one has a different color associated with it and ' +
      'the selected text will be drawn in'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 29
    Top = 392
    Width = 448
    Height = 13
    Caption = 
      'the cell in the individual color. All this takes is setting a fe' +
      'w properties of the calendar and about'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 29
    Top = 408
    Width = 105
    Height = 13
    Caption = 'three (3) lines of code!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 529
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
  object ListBox1: TListBox
    Tag = 2
    Left = 504
    Top = 56
    Width = 105
    Height = 65
    Hint = 'Drag and Drop items from this listbox onto the Calendar!'
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ItemHeight = 11
    Items.Strings = (
      'Lunch w/Lance'
      'Haircut'
      'Car to Shop'
      'New Shoes')
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object ListBox2: TListBox
    Tag = 1
    Left = 504
    Top = 144
    Width = 105
    Height = 65
    Hint = 'Drag and Drop items from this listbox onto the Calendar!'
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ItemHeight = 11
    Items.Strings = (
      'Lance Devin'
      'Dave Murphy'
      'Mike Scott'
      'Jamie Meyer'
      'Charlie Calvert')
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object ListBox3: TListBox
    Tag = 4
    Left = 504
    Top = 232
    Width = 105
    Height = 65
    Hint = 'Drag and Drop items from this listbox onto the Calendar!'
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ItemHeight = 11
    Items.Strings = (
      'Get Mailers'
      'Build Disks'
      'Ship Product'
      'Buy Presents'
      'Get a Job')
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 500
    Top = 305
    Width = 129
    Height = 96
    Caption = ' Views '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Button2: TButton
      Left = 8
      Top = 24
      Width = 113
      Height = 25
      Hint = 
        'This button will show you how a Year at a Glance Module might lo' +
        'ok.'
      Caption = '&Year at a Glance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 56
      Width = 113
      Height = 25
      Caption = '3 &Month View'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object Button1: TButton
    Left = 368
    Top = 8
    Width = 129
    Height = 25
    Hint = 'Use this button to toggle the selectability of weekends.'
    Caption = 'Block &Weekends'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = Button1Click
  end
  object KingNavigator1: TKingNavigator
    Left = 232
    Top = 8
    Width = 121
    Height = 21
    CalendarSource = KingCalendar1
    VisibleButtons = [nbPrevYear, nbPrevMonth, nbNextMonth, nbNextYear]
    Highlight = clBlue
    TabOrder = 6
    TodayText = 'Today'
    ParentShowHint = False
  end
  object KingCalendar1: TKingCalendar
    Left = 16
    Top = 40
    Width = 478
    Height = 287
    Day = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Month = 12
    ParentFont = False
    Year = 2018
    OnDragDrop = KingCalendar1DragDrop
    OnDragOver = KingCalendar1DragOver
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
    TextInCell = True
    TextFont.Charset = DEFAULT_CHARSET
    TextFont.Color = clBlack
    TextFont.Height = -9
    TextFont.Name = 'Small Fonts'
    TextFont.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    ColorCellText = True
    ColorCellDay = False
    RowHeights = (
      14
      43
      43
      43
      43
      43
      43)
  end
end
