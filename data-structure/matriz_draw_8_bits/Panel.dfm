object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 418
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 440
    Top = 32
    Width = 80
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 8
    Width = 377
    Height = 402
    ColCount = 100
    DefaultColWidth = 20
    DefaultRowHeight = 20
    RowCount = 100
    TabOrder = 1
  end
end
