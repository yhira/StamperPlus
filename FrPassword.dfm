object FormPassword: TFormPassword
  Left = 713
  Top = 129
  BorderStyle = bsDialog
  Caption = #12497#12473#12527#12540#12489#20837#21147
  ClientHeight = 92
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 146
    Height = 12
    Caption = #12497#12473#12527#12540#12489#12434#20837#21147#12375#12390#12367#12384#12373#12356
  end
  object EditPassWord: TEdit
    Left = 8
    Top = 24
    Width = 257
    Height = 20
    PasswordChar = '*'
    TabOrder = 0
    Text = 'EditPassWord'
    OnKeyPress = EditPassWordKeyPress
  end
  object ButtonOK: TButton
    Left = 112
    Top = 56
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object ButtonCancel: TButton
    Left = 192
    Top = 56
    Width = 75
    Height = 25
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
end
