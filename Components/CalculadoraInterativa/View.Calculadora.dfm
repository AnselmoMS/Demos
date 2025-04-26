object frmCalculadora: TfrmCalculadora
  Left = 0
  Top = 0
  Caption = 'Calculadora'
  ClientHeight = 543
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 432
    Height = 543
    Align = alClient
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end
      item
        Value = 25.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        ColumnSpan = 4
        Control = pnDisplay
        Row = 0
      end
      item
        Column = 0
        Control = btTecla7
        Row = 3
      end
      item
        Column = 1
        Control = btTecla8
        Row = 3
      end
      item
        Column = 2
        Control = btTecla9
        Row = 3
      end
      item
        Column = 3
        Control = btTeclaDividir
        Row = 2
      end
      item
        Column = 0
        Control = btTecla4
        Row = 4
      end
      item
        Column = 1
        Control = btTecla5
        Row = 4
      end
      item
        Column = 2
        Control = btTecla6
        Row = 4
      end
      item
        Column = 3
        Control = btTeclaMultiplicar
        Row = 4
      end
      item
        Column = 0
        Control = btTecla1
        Row = 5
      end
      item
        Column = 1
        Control = btTecla2
        Row = 5
      end
      item
        Column = 2
        Control = btTecla3
        Row = 5
      end
      item
        Column = 3
        Control = btTeclaSoma
        Row = 5
      end
      item
        Column = 0
        Control = btTeclaInverterSinal
        Row = 6
      end
      item
        Column = 1
        Control = btTecla0
        Row = 6
      end
      item
        Column = 2
        Control = btTeclaDecimal
        Row = 6
      end
      item
        Column = 3
        Control = btTeclaIgual
        Row = 6
      end
      item
        Column = 3
        Control = btTeclaSubtrair
        Row = 3
      end
      item
        Column = 0
        Control = btTeclaPercentual
        Row = 2
      end
      item
        Column = 3
        Control = btTeclaBackSpace
        Row = 1
      end
      item
        Column = 2
        Control = btTeclaClear
        Row = 2
      end
      item
        Column = 1
        Control = btTeclaClearNumber
        Row = 2
      end
      item
        Column = 0
        Control = btTeclaSquare
        Row = 1
      end>
    RowCollection = <
      item
        Value = 20.703933747412010000
      end
      item
        Value = 13.250517598343680000
      end
      item
        Value = 13.250517598343680000
      end
      item
        Value = 13.250517598343680000
      end
      item
        Value = 13.250517598343680000
      end
      item
        Value = 13.250517598343680000
      end
      item
        Value = 13.043478260869570000
      end>
    ShowCaption = False
    TabOrder = 0
    object pnDisplay: TPanel
      Left = 1
      Top = 1
      Width = 430
      Height = 81
      Align = alTop
      Anchors = []
      Caption = 'Display'
      Color = clWhite
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      ShowCaption = False
      TabOrder = 0
      object lblHistorico: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 422
        Height = 16
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblHistorico'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 517
        ExplicitTop = 1
        ExplicitWidth = 62
      end
      object lblDisplay: TLabel
        AlignWithMargins = True
        Left = 6
        Top = 28
        Width = 418
        Height = 47
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Alignment = taRightJustify
        Caption = '0'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitLeft = 408
        ExplicitWidth = 16
        ExplicitHeight = 35
      end
    end
    object btTecla7: TButton
      Left = 1
      Top = 255
      Width = 107
      Height = 71
      Align = alClient
      Caption = '7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
    end
    object btTecla8: TButton
      Left = 108
      Top = 255
      Width = 107
      Height = 71
      Align = alClient
      Caption = '8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = False
    end
    object btTecla9: TButton
      Left = 215
      Top = 255
      Width = 107
      Height = 71
      Align = alClient
      Caption = '9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TabStop = False
    end
    object btTeclaDividir: TButton
      Left = 322
      Top = 184
      Width = 109
      Height = 71
      Align = alClient
      Caption = #247
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      TabStop = False
    end
    object btTecla4: TButton
      Left = 1
      Top = 326
      Width = 107
      Height = 71
      Align = alClient
      Caption = '4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      TabStop = False
    end
    object btTecla5: TButton
      Left = 108
      Top = 326
      Width = 107
      Height = 71
      Align = alClient
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      TabStop = False
    end
    object btTecla6: TButton
      Left = 215
      Top = 326
      Width = 107
      Height = 71
      Align = alClient
      Caption = '6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      TabStop = False
    end
    object btTeclaMultiplicar: TButton
      Left = 322
      Top = 326
      Width = 109
      Height = 71
      Align = alClient
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      TabStop = False
    end
    object btTecla1: TButton
      Left = 1
      Top = 397
      Width = 107
      Height = 71
      Align = alClient
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      TabStop = False
    end
    object btTecla2: TButton
      Left = 108
      Top = 397
      Width = 107
      Height = 71
      Align = alClient
      Caption = '2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      TabStop = False
    end
    object btTecla3: TButton
      Left = 215
      Top = 397
      Width = 107
      Height = 71
      Align = alClient
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      TabStop = False
    end
    object btTeclaSoma: TButton
      Left = 322
      Top = 397
      Width = 109
      Height = 71
      Align = alClient
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      TabStop = False
    end
    object btTeclaInverterSinal: TButton
      Left = 1
      Top = 468
      Width = 107
      Height = 74
      Align = alClient
      Caption = #8723
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      TabStop = False
    end
    object btTecla0: TButton
      Left = 108
      Top = 468
      Width = 107
      Height = 74
      Align = alClient
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      TabStop = False
    end
    object btTeclaDecimal: TButton
      Left = 215
      Top = 468
      Width = 107
      Height = 74
      Align = alClient
      Caption = ','
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      TabStop = False
    end
    object btTeclaIgual: TButton
      Left = 322
      Top = 468
      Width = 109
      Height = 74
      Align = alClient
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      TabStop = False
    end
    object btTeclaSubtrair: TButton
      Left = 322
      Top = 255
      Width = 109
      Height = 71
      Align = alClient
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      TabStop = False
    end
    object btTeclaPercentual: TButton
      Left = 1
      Top = 184
      Width = 107
      Height = 71
      Align = alClient
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      TabStop = False
    end
    object btTeclaBackSpace: TButton
      Left = 322
      Top = 113
      Width = 109
      Height = 71
      Align = alClient
      Caption = #8592
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      TabStop = False
    end
    object btTeclaClear: TButton
      Left = 215
      Top = 184
      Width = 107
      Height = 71
      Align = alClient
      Caption = 'C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 20
      TabStop = False
    end
    object btTeclaClearNumber: TButton
      Left = 108
      Top = 184
      Width = 107
      Height = 71
      Align = alClient
      Caption = 'CE'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      TabStop = False
    end
    object btTeclaSquare: TButton
      Left = 1
      Top = 113
      Width = 107
      Height = 71
      Align = alClient
      Caption = 'x'#178
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      TabStop = False
    end
  end
end
