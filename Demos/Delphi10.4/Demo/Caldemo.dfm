object FrmCalendar: TFrmCalendar
  Left = 134
  Top = 124
  ActiveControl = KingCalendar1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Examples of using the Calendar'
  ClientHeight = 374
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 432
    Top = 64
    Width = 103
    Height = 13
    Caption = 'First Day of the Week'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TLabel
    Left = 104
    Top = 320
    Width = 74
    Height = 13
    Caption = 'Change the..'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TLabel
    Left = 336
    Top = 272
    Width = 74
    Height = 13
    Caption = 'Change the..'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox2: TGroupBox
    Left = 3
    Top = 267
    Width = 448
    Height = 102
    Caption = ' Change '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object BitBtn1: TBitBtn
    Left = 504
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
    Left = 8
    Top = 8
    Width = 415
    Height = 249
    Hint = 'An example of the TKingCalendar Component'
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
    TextFont.Color = clBlack
    TextFont.Height = -9
    TextFont.Name = 'Small Fonts'
    TextFont.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    RowHeights = (
      12
      37
      37
      37
      37
      37
      37)
  end
  object ComboBox1: TComboBox
    Left = 432
    Top = 80
    Width = 145
    Height = 21
    Hint = 
      'Use this ComboBox to select which day of the week the Calendar d' +
      'isplay starts with.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = 'ComboBox1'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday')
  end
  object CheckBox1: TCheckBox
    Left = 432
    Top = 40
    Width = 161
    Height = 17
    Caption = 'Display Gridlines'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 456
    Top = 240
    Width = 145
    Height = 121
    Caption = ' Placement of Day '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Centered'
      'Lower Left'
      'Upper Left'
      'Upper Right'
      'Lower Right')
    ParentFont = False
    TabOrder = 4
    OnClick = RadioGroup1Click
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 288
    Width = 89
    Height = 25
    Hint = 
      'Use this button the change the font used to drisplay the day of ' +
      'the month in the cell'
    Caption = 'Cell Font'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 8
    Top = 328
    Width = 89
    Height = 25
    Hint = 
      'Use this button to change the font used to display the days of t' +
      'he week in the title bar'
    Caption = 'Title Font'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 192
    Top = 288
    Width = 137
    Height = 25
    Hint = 
      'Use this button to change the color used as the background for t' +
      'he focused day'
    Caption = 'Focused Background'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = BitBtn4Click
  end
  object BitBtn5: TBitBtn
    Left = 104
    Top = 288
    Width = 81
    Height = 25
    Hint = 'Use this button to change the color used in the title bar'
    Caption = 'Title Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 192
    Top = 328
    Width = 137
    Height = 25
    Hint = 
      'Use this button to change the color used in the foreground of th' +
      'e focused day'
    Caption = 'Focused Foreground'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = BitBtn6Click
  end
  object BitBtn7: TBitBtn
    Left = 104
    Top = 328
    Width = 81
    Height = 25
    Hint = 
      'Use this button to change the color used to draw the individual ' +
      'cells'
    Caption = 'Cell Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = BitBtn7Click
  end
  object BitBtn8: TBitBtn
    Left = 336
    Top = 288
    Width = 105
    Height = 25
    Hint = 
      'Use this button to change the color used to highlight Today'#39's Da' +
      'te'
    Caption = 'Today'#39's Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = BitBtn8Click
  end
  object BitBtn9: TBitBtn
    Left = 336
    Top = 328
    Width = 105
    Height = 25
    Hint = 
      'Use this button to change the color used for drawing the gridlin' +
      'es'
    Caption = 'Gridline Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = BitBtn9Click
  end
  object GroupBox1: TGroupBox
    Left = 432
    Top = 112
    Width = 169
    Height = 121
    Caption = ' Other Examples '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    object Button1: TButton
      Left = 8
      Top = 24
      Width = 153
      Height = 25
      Hint = 
        'This example randomly shows how you can color invidual days with' +
        'in a calendar to represent Appointments, Todos, etc.'
      Caption = 'Example of Cell Coloring'
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
    object Button2: TButton
      Left = 8
      Top = 56
      Width = 153
      Height = 25
      Hint = 'This example shows how you can place text inside of cells'
      Caption = 'Example of Text in Cells'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 88
      Width = 153
      Height = 25
      Hint = 
        'This button will clear any coloring or text from the Calendar th' +
        'at was added by either of the two examples'
      Caption = 'Reset Calendar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    Left = 432
    Top = 240
  end
  object ColorDialog1: TColorDialog
    Left = 408
    Top = 240
  end
end
