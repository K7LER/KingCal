object FrmMain: TFrmMain
  Left = 197
  Top = 83
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'KingCalendar Demonstration'
  ClientHeight = 398
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 209
    Height = 29
    Caption = 'KingCalendar v2.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 238
    Top = 11
    Width = 156
    Height = 13
    Caption = 'Powerful Calendar Oriented'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 238
    Top = 24
    Width = 129
    Height = 13
    Caption = 'Components for Delphi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 43
    Width = 385
    Height = 121
    Caption = ' The Calendars '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 270
      Height = 13
      Caption = 'The most versitile and powerful calendar control available'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 32
      Width = 267
      Height = 13
      Caption = 'for Delphi. Use it in PIM'#39's, to select dates or display data.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 48
      Width = 199
      Height = 13
      Caption = 'This is the heart and soul of KingCalendar.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 8
      Top = 80
      Width = 238
      Height = 13
      Caption = 'Use the amazing Popup Calendar to enhance your'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 8
      Top = 96
      Width = 158
      Height = 13
      Caption = 'products power and presentation.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Button3: TButton
      Left = 288
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Display...'
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button7: TButton
      Left = 288
      Top = 80
      Width = 89
      Height = 25
      Caption = 'Display...'
      TabOrder = 1
      OnClick = Button7Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 170
    Width = 385
    Height = 49
    Caption = ' Navigational Components '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label6: TLabel
      Left = 8
      Top = 16
      Width = 234
      Height = 13
      Caption = 'Quickly navigate around the calendar using these'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 8
      Top = 32
      Width = 164
      Height = 13
      Caption = 'powerful navigational components.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Button4: TButton
      Left = 288
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Display...'
      TabOrder = 0
      OnClick = Button4Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 304
    Width = 385
    Height = 49
    Caption = ' Advanced Techniques '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label8: TLabel
      Left = 8
      Top = 16
      Width = 258
      Height = 13
      Caption = 'Display Text inside the Calendar, Utilize Drag and Drop'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 32
      Width = 58
      Height = 13
      Caption = 'techniques. '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Button5: TButton
      Left = 288
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Display...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button5Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 225
    Width = 385
    Height = 73
    Caption = ' Spinners, ComboBox'#39's and Labels '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label11: TLabel
      Left = 8
      Top = 16
      Width = 259
      Height = 13
      Caption = 'Tons of neat controls. ComboBox'#39's for manipulating the'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 32
      Width = 267
      Height = 13
      Caption = 'Month, Day and Year. Spin Controls to do the same. And'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 8
      Top = 48
      Width = 258
      Height = 13
      Caption = 'a label control to automaticaly display the date, always.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Button6: TButton
      Left = 288
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Display...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button6Click
    end
  end
  object LblStyle: TLabel
    Left = 8
    Top = 363
    Width = 54
    Height = 13
    Caption = 'VCL Style:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object CboStyle: TComboBox
    Left = 80
    Top = 360
    Width = 313
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = CboStyleChange
  end
end
