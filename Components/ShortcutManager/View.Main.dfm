object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 40
    Width = 121
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = 'Shift+Enter (Vazio)'
    TextHint = 'Shift+Enter (Vazio)'
  end
  object Edit2: TEdit
    Left = 224
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 32
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit4: TEdit
    Left = 224
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 225
    Top = 158
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 202
    Width = 169
    Height = 89
    Lines.Strings = (
      'CTRL+Enter (pr'#243'ximo controle)')
    TabOrder = 6
  end
  object Edit5: TEdit
    Left = 32
    Top = 160
    Width = 121
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = 'CTRL+ ENTER'
    TextHint = 'CTRL+ ENTER'
  end
  object Memo2: TMemo
    Left = 207
    Top = 202
    Width = 169
    Height = 89
    Lines.Strings = (
      'CTRL+Enter (pr'#243'ximo controle)')
    TabOrder = 7
  end
end
