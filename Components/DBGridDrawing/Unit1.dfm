object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 431
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdECF: TDBGrid
    Left = 1
    Top = 18
    Width = 630
    Height = 281
    DataSource = DataSource1
    FixedColor = 6514680
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgAlwaysShowSelection]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdECFDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'conta'
        Title.Alignment = taCenter
        Width = 98
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codauxiliar'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'd. Auxiliar'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Alignment = taCenter
        Width = 368
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'tipo'
        Title.Alignment = taCenter
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 395
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 368
    Width = 121
    Height = 21
    DataField = 'conta'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBCheckBox1: TDBCheckBox
    Left = 534
    Top = 370
    Width = 97
    Height = 17
    Caption = 'DBCheckBox1'
    DataField = 'tipo'
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBEdit2: TDBEdit
    Left = 135
    Top = 368
    Width = 121
    Height = 21
    DataField = 'codauxiliar'
    DataSource = DataSource1
    TabOrder = 4
  end
  object DBEdit3: TDBEdit
    Left = 262
    Top = 368
    Width = 251
    Height = 21
    DataField = 'descricao'
    DataSource = DataSource1
    TabOrder = 5
  end
  object gdMeses: TDBGrid
    Left = 8
    Top = 120
    Width = 516
    Height = 231
    Hint = 
      'X - Ja integrados P - Pr'#233'-integra'#231#245'es E - Com erros de Integra'#231#227 +
      'o N - Integrado sem movimento'
    Color = clBtnFace
    Ctl3D = True
    FixedColor = clGray
    GradientEndColor = clLime
    GradientStartColor = clGreen
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clTeal
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'Apelido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'X1Extra'
        Title.Caption = 'Saldo Inicial'
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'jan'
        Title.Caption = 'Jan'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fev'
        Title.Caption = 'Fev'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mar'
        Title.Caption = 'Mar'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'abr'
        Title.Caption = 'Abr'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mai'
        Title.Caption = 'Mai'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'jun'
        Title.Caption = 'Jun'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'jul'
        Title.Caption = 'Jul'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ago'
        Title.Caption = 'Ago'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sett'
        Title.Caption = 'Set'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'outt'
        Title.Caption = 'Out'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nov'
        Title.Caption = 'Nov'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dez'
        Title.Caption = 'Dez'
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 472
    Top = 216
  end
  object ADMemTable1: TADMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 592
    Top = 256
    object ADMemTable1conta: TStringField
      FieldName = 'conta'
    end
    object ADMemTable1codauxiliar: TIntegerField
      FieldName = 'codauxiliar'
    end
    object ADMemTable1descricao: TStringField
      FieldName = 'descricao'
    end
    object ADMemTable1tipo: TBooleanField
      FieldName = 'tipo'
    end
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 280
    Data = {
      730000009619E0BD010000001800000004000000000003000000730005636F6E
      746101004900000001000557494454480200020014000B636F64617578696C69
      617204000100000000000964657363726963616F010049000000010005574944
      5448020002003200047469706F02000300000000000000}
    object ClientDataSet1conta: TStringField
      FieldName = 'conta'
    end
    object ClientDataSet1codauxiliar: TIntegerField
      FieldName = 'codauxiliar'
    end
    object ClientDataSet1descricao: TStringField
      FieldName = 'descricao'
      Size = 50
    end
    object ClientDataSet1tipo: TBooleanField
      FieldName = 'tipo'
    end
  end
end
