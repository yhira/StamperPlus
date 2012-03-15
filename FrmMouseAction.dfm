object FrameMouseAction: TFrameMouseAction
  Left = 0
  Top = 0
  Width = 411
  Height = 257
  TabOrder = 0
  OnResize = FrameResize
  object GroupBoxMouse: TGroupBox
    Left = 2
    Top = 2
    Width = 409
    Height = 249
    Caption = #12510#12454#12473#21628#20986#12450#12463#12471#12519#12531
    TabOrder = 0
    object LabelMouseHint: TLabel
      Left = 8
      Top = 216
      Width = 393
      Height = 25
      AutoSize = False
      Caption = 'LabelMouseHint'
      WordWrap = True
    end
    object Label1: TLabel
      Left = 200
      Top = 160
      Width = 201
      Height = 41
      AutoSize = False
      Caption = #8251#65411#65438#65405#65400#65412#65391#65420#65439#20840#12390#12398#20301#32622#12391#21628#12403#20986#12375#12383#12356#22580#21512#12399#12289#65411#65438#65405#65400#65412#65391#65420#65439#12398#20184#12367#12418#12398#20840#12390#12434#12481#12455#12483#12463#12375#12390#12367#12384#12373#12356#12290
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object CheckBoxMouseEnabled: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = #26377#21177
      TabOrder = 0
      OnClick = CheckEnabledMouse
    end
    object GroupBoxMouseRtnPoses: TGroupBox
      Left = 200
      Top = 32
      Width = 201
      Height = 121
      Caption = #12510#12454#12473#20301#32622
      Enabled = False
      TabOrder = 3
      object CheckBoxMouseRtnPosAll: TCheckBox
        Left = 8
        Top = 16
        Width = 97
        Height = 17
        Caption = #12393#12371#12391#12418
        TabOrder = 0
        OnClick = CheckBoxMouseRtnPosAllClick
      end
      object CheckBoxMouseRtnPosDeskTop: TCheckBox
        Left = 8
        Top = 48
        Width = 97
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439
        TabOrder = 1
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosTaskBar: TCheckBox
        Left = 8
        Top = 32
        Width = 97
        Height = 17
        Caption = #12479#12473#12463#12496#12540
        TabOrder = 2
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosLT: TCheckBox
        Left = 8
        Top = 64
        Width = 97
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#24038#19978
        TabOrder = 3
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosMT: TCheckBox
        Left = 8
        Top = 80
        Width = 97
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#19978#37096
        TabOrder = 4
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosRT: TCheckBox
        Left = 8
        Top = 96
        Width = 97
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#21491#19978
        TabOrder = 5
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosRM: TCheckBox
        Left = 104
        Top = 16
        Width = 94
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#21491#37096
        TabOrder = 6
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosRB: TCheckBox
        Left = 104
        Top = 32
        Width = 94
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#21491#19979
        TabOrder = 7
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosMB: TCheckBox
        Left = 104
        Top = 48
        Width = 94
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#19979#37096
        TabOrder = 8
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosLB: TCheckBox
        Left = 104
        Top = 64
        Width = 94
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#24038#19979
        TabOrder = 9
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseRtnPosLM: TCheckBox
        Left = 104
        Top = 80
        Width = 94
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#24038#37096
        TabOrder = 10
        OnClick = CheckEnabledMouse
      end
      object ButtonAllDesktop: TButton
        Left = 104
        Top = 101
        Width = 89
        Height = 17
        Caption = #65411#65438#65405#65400#65412#65391#65420#65439#20840#12390
        TabOrder = 11
        OnClick = ButtonAllDesktopClick
      end
    end
    object GroupBoxMouseKeys: TGroupBox
      Left = 8
      Top = 139
      Width = 185
      Height = 73
      Caption = #32068#12415#21512#12431#12379#12508#12479#12531
      Enabled = False
      TabOrder = 2
      object CheckBoxMouseKeyLClk: TCheckBox
        Left = 8
        Top = 16
        Width = 97
        Height = 17
        Caption = #24038#12463#12522#12483#12463
        TabOrder = 0
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseKeyRClk: TCheckBox
        Left = 8
        Top = 32
        Width = 97
        Height = 17
        Caption = #21491#12463#12522#12483#12463
        TabOrder = 1
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseKeyMClk: TCheckBox
        Left = 8
        Top = 48
        Width = 97
        Height = 17
        Caption = #20013#12463#12522#12483#12463
        TabOrder = 2
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseKeyCtrl: TCheckBox
        Left = 88
        Top = 16
        Width = 89
        Height = 17
        Caption = 'Ctrl'
        TabOrder = 3
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseKeyShift: TCheckBox
        Left = 88
        Top = 32
        Width = 81
        Height = 17
        Caption = 'Shift'
        TabOrder = 4
        OnClick = CheckEnabledMouse
      end
      object CheckBoxMouseKeyAlt: TCheckBox
        Left = 88
        Top = 48
        Width = 81
        Height = 17
        Caption = 'Alt'
        TabOrder = 5
        OnClick = CheckEnabledMouse
      end
    end
    object RadioGroupMouseAction: TRadioGroup
      Left = 8
      Top = 32
      Width = 185
      Height = 105
      Caption = #12450#12463#12471#12519#12531
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        #24038#12463#12522#12483#12463
        #24038#12480#12502#12523#12463#12522#12483#12463
        #21491#12463#12522#12483#12463
        #21491#12480#12502#12523#12463#12522#12483#12463
        #20013#12463#12522#12483#12463
        #20013#12480#12502#12523#12463#12522#12483#12463)
      TabOrder = 1
      OnClick = CheckEnabledMouse
    end
  end
end
