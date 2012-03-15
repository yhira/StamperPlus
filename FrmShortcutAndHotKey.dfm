object FrameShortcutAndHotKey: TFrameShortcutAndHotKey
  Left = 0
  Top = 0
  Width = 409
  Height = 67
  TabOrder = 0
  object LabelShortcutkey: TLabel
    Left = 8
    Top = 8
    Width = 96
    Height = 12
    Caption = #12471#12519#12540#12488#12459#12483#12488#12461#12540#65306
  end
  object LabelHotkey: TLabel
    Left = 8
    Top = 40
    Width = 58
    Height = 12
    Caption = #12507#12483#12488#12461#12540#65306
  end
  object EditShortcutKey: TShortcutKeyEdit
    Left = 112
    Top = 8
    Width = 201
    Height = 20
    TabOrder = 0
    WordWrap = False
  end
  object ButtonClearShortcutKey: TButton
    Left = 320
    Top = 8
    Width = 75
    Height = 20
    Caption = #12463#12522#12450
    TabOrder = 1
    OnClick = ButtonClearShortcutKeyClick
  end
  object EditHotKey: TShortcutKeyEdit
    Left = 112
    Top = 40
    Width = 201
    Height = 20
    TabOrder = 2
    WordWrap = False
  end
  object ButtonClearHotKey: TButton
    Left = 318
    Top = 40
    Width = 75
    Height = 20
    Caption = #12463#12522#12450
    TabOrder = 3
    OnClick = ButtonClearHotKeyClick
  end
end
