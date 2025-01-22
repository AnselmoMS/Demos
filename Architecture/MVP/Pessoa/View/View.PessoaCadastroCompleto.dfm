object frmPessoaCadastroCompleto: TfrmPessoaCadastroCompleto
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 440
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblId: TLabel
    Left = 16
    Top = 17
    Width = 20
    Height = 13
    Caption = 'lblId'
  end
  object edtNome: TEdit
    Left = 16
    Top = 49
    Width = 312
    Height = 21
    TabOrder = 0
  end
  object btnNovo: TButton
    Left = 8
    Top = 210
    Width = 81
    Height = 25
    Caption = 'Novo'
    TabOrder = 3
    OnClick = btnNovoClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 272
    Width = 320
    Height = 120
    DataSource = dsLista
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 142
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Idade'
        Visible = True
      end>
  end
  object dbnavLista: TDBNavigator
    Left = 8
    Top = 241
    Width = 320
    Height = 25
    DataSource = dsLista
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    TabOrder = 8
  end
  object spnedtIdade: TSpinEdit
    Left = 16
    Top = 96
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 1
  end
  object btnExcluir: TButton
    Left = 253
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 6
    OnClick = btnExcluirClick
  end
  object btnSalvar: TButton
    Left = 170
    Top = 210
    Width = 77
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btnSalvarClick
  end
  object btnEditar: TButton
    Left = 89
    Top = 210
    Width = 77
    Height = 25
    Caption = 'Editar'
    TabOrder = 5
    OnClick = btnEditarClick
  end
  object chkShowRecordOnScroll: TCheckBox
    Left = 8
    Top = 187
    Width = 320
    Height = 17
    Caption = 'Exibir registro ao selecionar na lista'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object memLog: TMemo
    Left = 334
    Top = 210
    Width = 355
    Height = 190
    TabOrder = 7
  end
  object pbLista: TProgressBar
    Left = 8
    Top = 391
    Width = 320
    Height = 9
    Max = 5000
    Step = 1
    TabOrder = 10
  end
  object dsLista: TJvDataSource
    AutoEdit = False
    DisableEventsOnLoading = False
    OnDataSetScrolled = dsListaDataSetScrolled
    Left = 280
    Top = 304
  end
  object ADGUIxWaitCursor1: TADGUIxWaitCursor
    Left = 440
    Top = 344
  end
end
