object FormPassEdit: TFormPassEdit
  Left = 985
  Top = 128
  BorderStyle = bsDialog
  Caption = #36215#21205#12497#12473#12527#12540#12489#12398#35373#23450
  ClientHeight = 154
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    433
    154)
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 93
    Height = 12
    Caption = #36215#21205#12497#12473#12527#12540#12489'(&P)'
    FocusControl = PassEdit
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 141
    Height = 12
    Caption = #30906#35469#12398#12383#12417#12418#12358#19968#24230#20837#21147'(&C)'
    FocusControl = RePassEdit
  end
  object Label3: TLabel
    Left = 24
    Top = 64
    Width = 386
    Height = 12
    Caption = #65288#27880#65289#12371#12371#12391#35373#23450#12375#12383#12497#12473#12527#12540#12489#12434#24536#12428#12427#12392#12289#12503#12525#12464#12521#12512#12364#36215#21205#12391#12365#12394#12367#12394#12426#12414#12377
  end
  object Label4: TLabel
    Left = 40
    Top = 80
    Width = 273
    Height = 12
    Caption = #12367#12428#12368#12428#12418#24536#12428#12383#12426#12289#38291#36949#12387#12383#12426#12375#12394#12356#12424#12358#12372#27880#24847#19979#12373#12356
  end
  object Label5: TLabel
    Left = 16
    Top = 104
    Width = 333
    Height = 12
    Caption = #12497#12473#12527#12540#12489#12399#21322#35282#33521#25968#23383'4'#25991#23383#20197#19978'16'#25991#23383#20197#19979#12391#20837#21147#12375#12390#12367#12384#12373#12356
  end
  object PassEdit: TEdit
    Left = 160
    Top = 10
    Width = 265
    Height = 20
    ImeMode = imClose
    PasswordChar = '*'
    TabOrder = 0
    OnKeyDown = PassEditKeyDown
  end
  object RePassEdit: TEdit
    Left = 160
    Top = 34
    Width = 265
    Height = 20
    ImeMode = imClose
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = PassEditKeyDown
  end
  object OKButton: TButton
    Left = 272
    Top = 123
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 352
    Top = 123
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #12461#12515#12531#12475#12523
    TabOrder = 3
    OnClick = CancelButtonClick
  end
end
