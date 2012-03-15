object FormCallAction: TFormCallAction
  Left = 547
  Top = 130
  BorderStyle = bsDialog
  Caption = #21628#12403#20986#12375#12450#12463#12471#12519#12531
  ClientHeight = 376
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = CheckEnabledMouse
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Bevel1: TBevel
    Left = 0
    Top = 72
    Width = 409
    Height = 9
    Shape = bsTopLine
  end
  inline FrameShortcutAndHotKey: TFrameShortcutAndHotKey
    Left = 0
    Top = 0
    Width = 409
    Height = 67
    TabOrder = 0
    inherited EditShortcutKey: TShortcutKeyEdit
      OnChange = FrameShortcutAndHotKeyEditShortcutKeyChange
    end
    inherited ButtonClearShortcutKey: TButton
      Width = 65
      TabStop = False
    end
    inherited EditHotKey: TShortcutKeyEdit
      OnChange = FrameShortcutAndHotKeyEditHotKeyChange
    end
    inherited ButtonClearHotKey: TButton
      Left = 320
      Width = 65
      TabStop = False
    end
  end
  inline FrameMouseAction: TFrameMouseAction
    Left = 0
    Top = 80
    Width = 411
    Height = 257
    TabOrder = 1
    inherited GroupBoxMouse: TGroupBox
      inherited CheckBoxMouseEnabled: TCheckBox
        OnClick = CheckEnabledMouse
      end
      inherited GroupBoxMouseRtnPoses: TGroupBox
        inherited CheckBoxMouseRtnPosAll: TCheckBox
          OnClick = FrameMouseActionCheckBoxMouseRtnPosAllClick
        end
        inherited CheckBoxMouseRtnPosDeskTop: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosTaskBar: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosLT: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosMT: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosRT: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosRM: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosRB: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosMB: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosLB: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseRtnPosLM: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited ButtonAllDesktop: TButton
          TabStop = False
        end
      end
      inherited GroupBoxMouseKeys: TGroupBox
        inherited CheckBoxMouseKeyLClk: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseKeyRClk: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseKeyMClk: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseKeyCtrl: TCheckBox
          OnClick = CheckEnabledMouse
        end
        inherited CheckBoxMouseKeyShift: TCheckBox
          OnClick = CheckEnabledMouse
        end
      end
      inherited RadioGroupMouseAction: TRadioGroup
        OnClick = CheckEnabledMouse
      end
    end
  end
  object OKBtn: TButton
    Left = 256
    Top = 344
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 336
    Top = 344
    Width = 75
    Height = 25
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 3
  end
  object ButtonDelDbShortcut: TButton
    Left = 387
    Top = 8
    Width = 17
    Height = 17
    Hint = #37325#35079#12471#12519#12540#12488#12459#12483#12488#12461#12540#12434#21066#38500'|'
    Caption = #215
    Enabled = False
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    TabStop = False
    OnClick = ButtonDelDbShortcutClick
  end
  object ButtonDelDbHot: TButton
    Left = 387
    Top = 40
    Width = 17
    Height = 17
    Hint = #37325#35079#12507#12483#12488#12461#12540#12434#21066#38500'|'
    Caption = #215
    Enabled = False
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TabStop = False
    OnClick = ButtonDelDbHotClick
  end
  object ButtonDelDbMouse: TButton
    Left = 64
    Top = 96
    Width = 17
    Height = 17
    Hint = #37325#35079#12510#12454#12473#12450#12463#12471#12519#12531#12434#21066#38500'|'
    Caption = #215
    Enabled = False
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    TabStop = False
    OnClick = ButtonDelDbMouseClick
  end
end
