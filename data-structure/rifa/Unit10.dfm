object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Form10'
  ClientHeight = 334
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 284
    Top = 174
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object EdtNumero: TEdit
    Left = 120
    Top = 83
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EdtNumero'
  end
  object EdtNome: TEdit
    Left = 94
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'EdtNome'
  end
  object EdtEndereco: TEdit
    Left = 150
    Top = 243
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'EdtEndereco'
  end
  object EdtTelefone: TEdit
    Left = 152
    Top = 275
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'EdtTelefone'
  end
  object BitBtn2: TBitBtn
    Left = 445
    Top = 66
    Width = 75
    Height = 25
    Caption = 'BitBtn2'
    TabOrder = 5
    OnClick = BitBtn2Click
  end
end
