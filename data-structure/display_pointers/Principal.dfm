object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 433
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 554
    Height = 433
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Vetor Est'#225'tico'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 546
        Height = 405
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object GridDisplay: TStringGrid
          Left = 8
          Top = 149
          Width = 537
          Height = 240
          DefaultColWidth = 100
          FixedCols = 0
          RowCount = 2
          TabOrder = 0
        end
        object BitBtn1: TBitBtn
          Left = 8
          Top = 9
          Width = 122
          Height = 33
          Caption = 'Vetor est'#225'tico'
          TabOrder = 1
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 136
          Top = 9
          Width = 137
          Height = 33
          Caption = 'BitBtn2'
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Vetor Din'#226'mico'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 546
        Height = 405
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object BitBtn3: TBitBtn
          Left = 31
          Top = 31
          Width = 122
          Height = 34
          Caption = 'Vetor din'#225'mico'
          TabOrder = 0
          OnClick = BitBtn3Click
        end
        object GridVDinamico: TStringGrid
          Left = 8
          Top = 141
          Width = 529
          Height = 240
          DefaultColWidth = 100
          FixedCols = 0
          RowCount = 2
          TabOrder = 1
        end
        object BitBtn4: TBitBtn
          Left = 320
          Top = 32
          Width = 75
          Height = 25
          Caption = 'BitBtn4'
          TabOrder = 2
          OnClick = BitBtn4Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Matriz Est'#225'tica'
      ImageIndex = 2
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 546
        Height = 405
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object BitBtn5: TBitBtn
          Left = 31
          Top = 31
          Width = 122
          Height = 34
          Caption = 'Processar'
          TabOrder = 0
        end
        object StringGrid1: TStringGrid
          Left = 8
          Top = 141
          Width = 529
          Height = 240
          DefaultColWidth = 100
          FixedCols = 0
          RowCount = 2
          TabOrder = 1
        end
      end
    end
  end
end
