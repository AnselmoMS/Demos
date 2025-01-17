object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnLocalNonNil: TButton
    Left = 264
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Local not Nil'
    TabOrder = 0
    OnClick = btnLocalNonNilClick
  end
  object btnFreeAndNil: TButton
    Left = 264
    Top = 216
    Width = 75
    Height = 25
    Caption = 'FreeAndNil - OK'
    TabOrder = 1
    OnClick = btnFreeAndNilClick
  end
  object btnFreeAndNilAfterFree: TButton
    Left = 200
    Top = 256
    Width = 153
    Height = 25
    Caption = 'btnFreeAndNilAfterFree - Invalid Pointer Operation'
    TabOrder = 2
    OnClick = btnFreeAndNilAfterFreeClick
  end
  object btnLocalNil: TButton
    Left = 368
    Top = 168
    Width = 75
    Height = 25
    Caption = 'btnLocalNil'
    TabOrder = 3
    OnClick = btnLocalNilClick
  end
  object btnLocalFree: TButton
    Left = 368
    Top = 199
    Width = 75
    Height = 25
    Caption = 'btnLocalFreeAssigned'
    TabOrder = 4
    OnClick = btnLocalFreeClick
  end
  object btnSafeRecreate: TButton
    Left = 320
    Top = 72
    Width = 209
    Height = 57
    Caption = 'btnSafeRecreate'
    TabOrder = 5
    OnClick = btnSafeRecreateClick
  end
end
