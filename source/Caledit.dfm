object FrmCalEdit: TFrmCalEdit
  Left = 254
  Top = 147
  BorderStyle = bsDialog
  Caption = 'KingCalendar Visual Editor'
  ClientHeight = 312
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 521
    Height = 281
  end
  object Notebook1: TNotebook
    Left = 16
    Top = 16
    Width = 505
    Height = 273
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    PageIndex = 2
    ParentFont = False
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Colors'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 13
        Caption = 'Color Settings'
      end
      object Label2: TLabel
        Left = 176
        Top = 8
        Width = 93
        Height = 13
        Caption = 'Choose by Color'
      end
      object Label3: TLabel
        Left = 176
        Top = 128
        Width = 90
        Height = 13
        Caption = 'Visual Example '
      end
      object Label4: TLabel
        Left = 376
        Top = 8
        Width = 96
        Height = 13
        Caption = 'Choose by Name'
      end
      object ListBox1: TListBox
        Left = 8
        Top = 24
        Width = 161
        Height = 236
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'Blocked Background'
          'Blocked Foreground'
          'Cell Background'
          'Current Cell Background'
          'Current Cell Foregound'
          'Gridline Color'
          'Title Background'
          'Title Foreground'
          'Today'#39's Date Color'
          'ColorSet 1 Color'
          'ColorSet 2 Color'
          'ColorSet 3 Color'
          'ColorSet 4 Color'
          'ColorSet 5 Color'
          'ColorSet 6 Color'
          'ColorSet 7 Color'
          'ColorSet 8 Color'
          'ColorSet 9 Color')
        ParentFont = False
        TabOrder = 0
      end
      object ColorGrid1: TColorGrid
        Left = 176
        Top = 24
        Width = 192
        Height = 88
        BackgroundEnabled = False
        TabOrder = 1
        OnClick = ColorGrid1Click
      end
      object KingCalendar1: TKingCalendar
        Left = 176
        Top = 144
        Width = 317
        Height = 119
        Day = 30
        Month = 12
        Year = 2018
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
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'System'
        TitleFont.Style = []
        RowHeights = (
          14
          15
          15
          15
          15
          15
          15)
      end
      object Button1: TButton
        Left = 408
        Top = 120
        Width = 81
        Height = 20
        Hint = 'Reset the color to it'#39's default'
        Caption = '&Default'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button1Click
      end
      object ListBox2: TListBox
        Left = 376
        Top = 24
        Width = 121
        Height = 89
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'clBlack'
          'clMaroon'
          'clGreen'
          'clOlive'
          'clNavy'
          'clPurple'
          'clTeal'
          'clGray'
          'clSilver'
          'clRed'
          'clLime'
          'clBlue'
          'clFuchsia'
          'clAqua'
          'clWhite'
          'clBackground'
          'clActiveCaption'
          'clInactiveCaption'
          'clMenu'
          'clWindow'
          'clWindowFrame'
          'clMenuText'
          'clWindowText'
          'clCaptionText'
          'clActiveBorder'
          'clInactiveBorder'
          'clAppWorkSpace'
          'clHighlight'
          'clHightlightText'
          'clBtnFace'
          'clBtnShadow'
          'clGrayText'
          'clBtnText'
          'clInactiveCaptionText'
          'clBtnHighlight')
        ParentFont = False
        TabOrder = 4
        OnClick = ListBox2Click
      end
      object Button2: TButton
        Left = 320
        Top = 120
        Width = 81
        Height = 20
        Hint = 'Select a Custom Color'
        Caption = '&Custom'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Button2Click
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'DOWNames'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 117
        Height = 13
        Caption = 'Day of Week Names'
      end
      object Label6: TLabel
        Left = 184
        Top = 8
        Width = 86
        Height = 13
        Caption = 'Visual Example'
      end
      object Memo1: TMemo
        Left = 8
        Top = 24
        Width = 161
        Height = 105
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 160
        Width = 161
        Height = 105
        Caption = ' Week Starting Day '
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
          'Wednesday'
          'Thursday'
          'Friday'
          'Saturday')
        ParentFont = False
        TabOrder = 1
        OnClick = RadioGroup1Click
      end
      object KingCalendar2: TKingCalendar
        Left = 184
        Top = 24
        Width = 317
        Height = 143
        Day = 30
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Month = 12
        ParentFont = False
        Year = 2018
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
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'System'
        TitleFont.Style = []
        RowHeights = (
          14
          19
          19
          19
          19
          19
          19)
      end
      object Button3: TButton
        Left = 24
        Top = 134
        Width = 121
        Height = 21
        Hint = 'Apply new Day of Week Names to Calendar'
        Caption = '&Apply New Names'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button3Click
      end
      object checkFixed: TCheckBox
        Left = 328
        Top = 184
        Width = 153
        Height = 17
        Caption = 'Use Fixed Size Title'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 4
        OnClick = checkFixedClick
      end
      object RadioGroup2: TRadioGroup
        Left = 176
        Top = 176
        Width = 145
        Height = 89
        Caption = ' Text Placement '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Centered'
          'Lower Left'
          'Top Left'
          'Top Right'
          'Lower Right')
        ParentFont = False
        TabOrder = 5
        OnClick = RadioGroup2Click
      end
      object cBlock: TCheckBox
        Left = 328
        Top = 200
        Width = 137
        Height = 17
        Caption = 'Block Weekends'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = cBlockClick
      end
      object cGridLines: TCheckBox
        Left = 328
        Top = 216
        Width = 153
        Height = 17
        Caption = 'Show Grid Lines'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = cGridLinesClick
      end
      object cReadOnly: TCheckBox
        Left = 328
        Top = 232
        Width = 169
        Height = 17
        Caption = 'Calendar Read Only'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = cReadOnlyClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Fonts'
      object Label7: TLabel
        Left = 8
        Top = 8
        Width = 86
        Height = 13
        Caption = 'Visual Example'
      end
      object KingCalendar3: TKingCalendar
        Left = 8
        Top = 24
        Width = 478
        Height = 185
        Day = 30
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Small Fonts'
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
        TextFont.Height = -13
        TextFont.Name = 'System'
        TextFont.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'System'
        TitleFont.Style = []
        ColorCellText = True
        ColorCellDay = False
        RowHeights = (
          14
          26
          26
          26
          26
          26
          26)
      end
      object BitBtn3: TBitBtn
        Left = 8
        Top = 216
        Width = 129
        Height = 33
        Hint = 'Change the Title Font'
        Caption = 'Title Font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333FFF33FFFFF33333300033000
          00333337773377777333333330333300033333337FF33777F333333330733300
          0333333377FFF777F33333333700000073333333777777773333333333033000
          3333333337FF777F333333333307300033333333377F777F3333333333703007
          33333333377F7773333333333330000333333333337777F33333333333300003
          33333333337777F3333333333337007333333333337777333333333333330033
          3333333333377333333333333333033333333333333733333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 176
        Top = 216
        Width = 129
        Height = 33
        Hint = 'Change the Cell Text Font'
        Caption = 'Cell Font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333FFF33FFFFF33333300033000
          00333337773377777333333330333300033333337FF33777F333333330733300
          0333333377FFF777F33333333700000073333333777777773333333333033000
          3333333337FF777F333333333307300033333333377F777F3333333333703007
          33333333377F7773333333333330000333333333337777F33333333333300003
          33333333337777F3333333333337007333333333337777333333333333330033
          3333333333377333333333333333033333333333333733333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 352
        Top = 216
        Width = 129
        Height = 33
        Hint = 'Change the Text in Cell Font'
        Caption = 'Text in Cell Font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333FFF33FFFFF33333300033000
          00333337773377777333333330333300033333337FF33777F333333330733300
          0333333377FFF777F33333333700000073333333777777773333333333033000
          3333333337FF777F333333333307300033333333377F777F3333333333703007
          33333333377F7773333333333330000333333333337777F33333333333300003
          33333333337777F3333333333337007333333333337777333333333333330033
          3333333333377333333333333333033333333333333733333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BitBtn5Click
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 536
    Top = 39
    Width = 89
    Height = 25
    Hint = 'Abort Changes and Return to Delphi'
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 536
    Top = 8
    Width = 89
    Height = 25
    Hint = 'Accept Changes and Return to Delphi'
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object TabSet1: TTabSet
    Left = 8
    Top = 288
    Width = 521
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Tabs.Strings = (
      'Colors'
      'Display Defaults'
      'Fonts')
    TabIndex = 0
    OnClick = TabSet1Click
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Style = []
    Left = 568
    Top = 152
  end
end
