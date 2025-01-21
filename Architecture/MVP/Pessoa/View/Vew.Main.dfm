object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 40
    Top = 24
    Width = 113
    Height = 25
    Caption = 'Cadastro Completo'
    TabOrder = 0
    OnClick = Button1Click
  end
  object btnBuscarRegistro: TButton
    Left = 40
    Top = 72
    Width = 113
    Height = 25
    Caption = 'Buscar registro'
    TabOrder = 1
    OnClick = btnBuscarRegistroClick
  end
  object btnViewFromPresenter: TButton
    Left = 168
    Top = 24
    Width = 121
    Height = 25
    Caption = 'Cadastro Presenter'
    TabOrder = 2
    OnClick = btnViewFromPresenterClick
  end
end
