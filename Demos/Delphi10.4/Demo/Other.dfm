object FrmOther: TFrmOther
  Left = 124
  Top = 80
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Other Calendar Oriented Components'
  ClientHeight = 400
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 449
    Height = 105
    Caption = ' Date Calculator '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 318
      Height = 13
      Caption = 
        'The Date Calculator is a non-visual component that when displaye' +
        'd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 325
      Height = 13
      Caption = 
        'gives the user a mode-les calculator that allows them to do such' +
        ' date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 48
      Width = 330
      Height = 13
      Caption = 
        'calculations as the number of work days between to dates. Return' +
        ' the'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 64
      Width = 317
      Height = 13
      Caption = 
        'current week or day of the year and even get the current day of ' +
        'the'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 80
      Width = 296
      Height = 13
      Caption = 'week. This is a superb tools for accounting based applications.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 352
      Top = 16
      Width = 89
      Height = 25
      Caption = 'Display...'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 120
    Width = 449
    Height = 185
    Caption = ' Spin Edit Components '
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
      Width = 282
      Height = 13
      Caption = 'The TimeSpin Component provides you with a powerful spin'
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
      Width = 273
      Height = 13
      Caption = 'based edit control for allowing time oriented input. Ideal for'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 8
      Top = 48
      Width = 297
      Height = 13
      Caption = 'such applications as appointment books and event scheduling.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 80
      Width = 310
      Height = 13
      Caption = 'The DateSpin Components is the exact equivilent of the TimeSpin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 96
      Width = 136
      Height = 13
      Caption = 'but based around date input.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 8
      Top = 128
      Width = 414
      Height = 13
      Caption = 
        'Both components provide properties to set the increment level al' +
        'lowing you to have total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 144
      Width = 413
      Height = 13
      Caption = 
        'control over the inital value of each edit as well as the ammoun' +
        't in which they increment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 8
      Top = 160
      Width = 182
      Height = 13
      Caption = 'and decrement with each mouse click.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object KingTimeSpin1: TKingTimeSpin
      Left = 344
      Top = 16
      Width = 89
      Height = 22
      TimeFormat = 'hh:mm AMPM'
      StartTime = '06:00 AM'
      AutoSelect = False
      ReadOnly = True
    end
    object KingDateSpin1: TKingDateSpin
      Left = 344
      Top = 80
      Width = 89
      Height = 22
      DateFormat = 'M/d/yy'
      StartDate = '5/15/95'
      AutoSelect = False
      ReadOnly = True
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 312
    Width = 449
    Height = 81
    Caption = ' Date Edit Dialog '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label14: TLabel
      Left = 8
      Top = 16
      Width = 299
      Height = 13
      Caption = 'The TKingDateDialog Component simplifies the need for an edit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 8
      Top = 32
      Width = 298
      Height = 13
      Caption = 
        'field that is used to select a date. This component provides the' +
        ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 8
      Top = 48
      Width = 296
      Height = 13
      Caption = 'user with a button to bring up a TKingPopup Calendar to select'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 8
      Top = 64
      Width = 33
      Height = 13
      Caption = 'a date.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object KingDateDialog1: TKingDateDialog
      Left = 328
      Top = 16
      Width = 113
      Height = 22
      KingPopup = KingPopup1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object KingCalc1: TKingCalc
    Left = 384
    Top = 64
  end
  object KingPopup1: TKingPopup
    AlignSource = KingDateDialog1
    Left = 312
    Top = 304
  end
end
