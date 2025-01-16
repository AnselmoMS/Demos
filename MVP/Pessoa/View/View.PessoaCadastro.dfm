object frmPessoaCadastro: TfrmPessoaCadastro
  Left = 0
  Top = 0
  Caption = 'frmPessoaCadastro'
  ClientHeight = 221
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    Top = 178
    Width = 82
    Height = 25
    Caption = 'Novo'
    TabOrder = 1
  end
  object spnedtIdade: TSpinEdit
    Left = 16
    Top = 96
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 1
  end
  object btnExcluir: TButton
    Left = 293
    Top = 178
    Width = 76
    Height = 25
    Caption = 'Excluir'
    TabOrder = 3
  end
  object btnSalvar: TButton
    Left = 210
    Top = 178
    Width = 78
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
  end
  object btnEditar: TButton
    Left = 95
    Top = 178
    Width = 78
    Height = 25
    Caption = 'Editar'
    TabOrder = 5
  end
end
