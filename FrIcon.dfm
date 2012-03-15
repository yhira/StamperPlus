object FormIcon: TFormIcon
  Left = 752
  Top = 190
  BorderStyle = bsDialog
  Caption = #12450#12452#12467#12531#36984#25246
  ClientHeight = 234
  ClientWidth = 386
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 12
  object OKBtn: TButton
    Left = 304
    Top = 8
    Width = 75
    Height = 25
    Caption = #36984#25246
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 304
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 2
  end
  object ButtonAdd: TButton
    Left = 304
    Top = 88
    Width = 75
    Height = 25
    Caption = #36861#21152
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonSub: TButton
    Left = 304
    Top = 120
    Width = 75
    Height = 25
    Caption = #32622#25563
    TabOrder = 4
    OnClick = ButtonSubClick
  end
  object ButtonDel: TButton
    Left = 304
    Top = 152
    Width = 75
    Height = 25
    Caption = #21066#38500
    TabOrder = 5
    OnClick = ButtonDelClick
  end
  object IconGrid: TIconGrid
    Left = 0
    Top = 0
    Width = 289
    Height = 234
    GridLine = False
    Align = alLeft
    DefaultColWidth = 32
    DefaultRowHeight = 32
    TabOrder = 0
    OnDblClick = IconGridDblClick
    OnDrawCell = IconGridDrawCell
  end
  object OpenPictureDialog: TOpenPictureDialog
    DefaultExt = 'ico'
    Filter = #12450#12452#12467#12531' (*.ico)|*.ico|'#12377#12409#12390#12398#12501#12449#12452#12523' (*.*)|*.*'
    Left = 296
    Top = 184
  end
end
