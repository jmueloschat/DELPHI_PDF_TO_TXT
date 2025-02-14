object TAppPDF2TXT: TTAppPDF2TXT
  Left = 0
  Top = 0
  ActiveControl = btProcessar
  Anchors = [akLeft, akTop, akRight]
  Caption = 'App'
  ClientHeight = 217
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbUrlBase: TLabel
    Left = 24
    Top = 24
    Width = 45
    Height = 13
    Caption = 'URL base'
  end
  object lbDataCotacao: TLabel
    Left = 24
    Top = 67
    Width = 60
    Height = 13
    Caption = 'Quarta-feira'
  end
  object lbCotacao: TLabel
    Left = 24
    Top = 110
    Width = 40
    Height = 13
    Caption = 'Cota'#231#227'o'
  end
  object edUrl: TEdit
    Left = 24
    Top = 40
    Width = 556
    Height = 21
    TabOrder = 0
  end
  object btProcessar: TButton
    Left = 505
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Processar'
    TabOrder = 1
    OnClick = btProcessarClick
  end
  object dtCotacao: TDateTimePicker
    Left = 24
    Top = 83
    Width = 97
    Height = 21
    Date = 45702.463187511570000000
    Time = 45702.463187511570000000
    TabOrder = 2
  end
  object edCotacao: TEdit
    Left = 24
    Top = 126
    Width = 97
    Height = 21
    TabOrder = 3
  end
end
