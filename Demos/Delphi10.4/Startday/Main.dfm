object Form1: TForm1
  Left = 215
  Top = 102
  Caption = 'KingCalendar StartingDay Example'
  ClientHeight = 228
  ClientWidth = 325
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
  object KingCalendar1: TKingCalendar
    Left = 8
    Top = 8
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
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 136
    Width = 321
    Height = 97
    Caption = ' Starting Day Of Week '
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednsday'
      'Thursday'
      'Friday'
      'Saturday')
    ParentFont = False
    TabOrder = 1
    OnClick = RadioGroup1Click
  end
end
