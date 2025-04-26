object frmPessoaCadastroCompleto: TfrmPessoaCadastroCompleto
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 439
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 13
  object lblId: TLabel
    Left = 16
    Top = 17
    Width = 20
    Height = 13
    Caption = 'lblId'
  end
  object lblIdade: TLabel
    Left = 184
    Top = 104
    Width = 38
    Height = 13
    Caption = 'lblIdade'
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
    TabOrder = 2
    OnClick = btnNovoClick
  end
  object DBGridListagem: TDBGrid
    Left = 8
    Top = 272
    Width = 320
    Height = 120
    DataSource = dsListagem
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridListagemDblClick
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
  object btnExcluir: TButton
    Left = 253
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object btnSalvar: TButton
    Left = 170
    Top = 210
    Width = 77
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btnSalvarClick
  end
  object btnEditar: TButton
    Left = 89
    Top = 210
    Width = 77
    Height = 25
    Caption = 'Editar'
    TabOrder = 4
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
    TabOrder = 1
  end
  object memLog: TMemo
    Left = 334
    Top = 210
    Width = 355
    Height = 190
    TabOrder = 6
  end
  object pbLista: TProgressBar
    Left = 8
    Top = 391
    Width = 320
    Height = 9
    Max = 5000
    Step = 1
    TabOrder = 8
  end
  object Button1: TButton
    Left = 8
    Top = 406
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 9
  end
  object meDataNascimento: TMaskEdit
    Left = 16
    Top = 96
    Width = 118
    Height = 21
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 10
    Text = '  /  /    '
  end
  object cdsListagem: TClientDataSet
    PersistDataPacket.Data = {
      4C0000009619E0BD0100000018000000030000000000030000004C0002496404
      00010000000000044E6F6D650100490000000100055749445448020002001400
      05496461646504000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 320
    object cdsListagemId: TIntegerField
      FieldName = 'Id'
    end
    object cdsListagemNome: TStringField
      FieldName = 'Nome'
    end
    object cdsListagemIdade: TIntegerField
      FieldName = 'Idade'
    end
  end
  object dsListagem: TDataSource
    DataSet = cdsListagem
    Enabled = False
    OnDataChange = dsListagemDataChange
    Left = 168
    Top = 320
  end
end
