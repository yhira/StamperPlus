object FormAddText: TFormAddText
  Left = 558
  Top = 128
  Width = 487
  Height = 266
  Caption = #12502#12483#12463#12510#12540#12463#12398#30331#37682
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 200
    Width = 305
    Height = 25
    AutoSize = False
    Caption = 'URL'#12522#12473#12488#12434#20837#21147#12375#12390#19979#12373#12356#12290
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 479
    Height = 193
    Align = alTop
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 320
    Top = 200
    Width = 75
    Height = 25
    Caption = #30331#37682
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 400
    Top = 200
    Width = 75
    Height = 25
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
end
