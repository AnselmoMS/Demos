object frmPessoaPesquisa: TfrmPessoaPesquisa
  Left = 0
  Top = 0
  Caption = 'Pesquisar Pessoas'
  ClientHeight = 294
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dbgridResultado: TDBGrid
    Left = 11
    Top = 48
    Width = 361
    Height = 233
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgridResultadoDblClick
  end
  object edtNome: TEdit
    Left = 11
    Top = 19
    Width = 121
    Height = 21
    TabOrder = 1
    TextHint = 'Nome'
  end
  object Edit2: TEdit
    Left = 155
    Top = 19
    Width = 121
    Height = 21
    TabOrder = 2
    TextHint = 'Idade'
  end
  object btnPesquisar: TButton
    Left = 297
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 3
  end
  object dsResultado: TDataSource
    Left = 320
    Top = 229
  end
end
