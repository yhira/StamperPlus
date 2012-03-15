object FormStancher: TFormStancher
  Left = 441
  Top = 128
  Width = 664
  Height = 584
  Caption = 'Stamper'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 400
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object ToolBarTag: TToolBar
    Left = 0
    Top = 47
    Width = 656
    Height = 25
    ButtonHeight = 15
    ButtonWidth = 75
    Caption = #12479#12464
    Customizable = True
    EdgeBorders = []
    Flat = True
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = False
    TabOrder = 2
  end
  object PageControlMain: TPageControl
    Left = 0
    Top = 72
    Width = 656
    Height = 447
    ActivePage = TabPaste
    Align = alClient
    MultiLine = True
    TabOrder = 3
    OnChange = PageControlMainChange
    OnChanging = PageControlMainChanging
    OnDragDrop = PageControlMainDragDrop
    OnDragOver = PageControlMainDragOver
    OnMouseDown = PageControlMainMouseDown
    object TabAllSearch: TTabSheet
      Caption = #26908#32034
      OnShow = TabAllSearchShow
      object ListViewAllSearch: TStnListView
        Left = 0
        Top = 0
        Width = 648
        Height = 420
        Align = alClient
        Columns = <>
        FullDrag = True
        HideSelection = False
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        HoverTime = 10000000
        LargeImages = ImageListSearchL
        OwnerData = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        PopupMenu = PopupAllSearchList
        ShowWorkAreas = True
        ShowHint = False
        SmallImages = ImageListSearchS
        TabOrder = 0
        ViewStyle = vsList
        OnColumnClick = ListViewPasteColumnClick
        OnData = ListViewPasteData
        OnDblClick = ListViewAllSearchDblClick
        OnKeyDown = ListViewAllSearchKeyDown
        OnSelectItem = ListViewAllSearchSelectItem
      end
    end
    object TabPaste: TTabSheet
      Caption = #36028#12426#20184#12369
      ImageIndex = 1
      object SplitterPaste: TSplitter
        Left = 185
        Top = 0
        Height = 420
      end
      object PanelPasteL: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 420
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'PanelPasteL'
        Constraints.MinWidth = 100
        ParentColor = True
        TabOrder = 0
        object TreePaste: TStnTreeView
          Left = 0
          Top = 0
          Width = 185
          Height = 420
          Align = alClient
          AutoExpand = True
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 19
          ParentShowHint = False
          PopupMenu = PopupPasteTree
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
          OnAddition = TreePasteAddition
          OnChange = TreePasteChange
          OnChanging = TreePasteChanging
          OnClick = TreePasteClick
          OnCollapsing = TreePasteCollapsing
          OnCompare = TreeCompare
          OnDeletion = TreePasteDeletion
          OnDragDrop = TreePasteDragDrop
          OnDragOver = TreePasteDragOver
          OnEnter = TreePasteEnter
          OnExit = TreePasteExit
          OnKeyDown = TreePasteKeyDown
          OnKeyPress = TreePasteKeyPress
          OnMouseMove = TreePasteMouseMove
          CopyMode = cmCopy
        end
      end
      object PanelPasteR: TPanel
        Left = 188
        Top = 0
        Width = 460
        Height = 420
        Align = alClient
        BevelOuter = bvNone
        Caption = 'PanelPasteR'
        Constraints.MinWidth = 150
        ParentColor = True
        TabOrder = 1
        object SplitterPasteText: TSplitter
          Left = 0
          Top = 328
          Width = 460
          Height = 3
          Cursor = crVSplit
          Align = alBottom
        end
        object ListViewPaste: TStnListView
          Left = 0
          Top = 0
          Width = 460
          Height = 328
          Align = alClient
          Columns = <>
          DragMode = dmAutomatic
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          FullDrag = True
          HideSelection = False
          HotTrack = True
          HotTrackStyles = [htHandPoint, htUnderlineHot]
          HoverTime = 10000000
          LargeImages = ImageListPasteL
          MultiSelect = True
          OwnerData = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupPasteList
          ShowHint = True
          SmallImages = ImageListPasteS
          TabOrder = 0
          ViewStyle = vsReport
          OnChange = ListViewPasteChange
          OnClick = ListViewPasteClick
          OnColumnClick = ListViewPasteColumnClick
          OnCustomDraw = ListViewPasteCustomDraw
          OnData = ListViewPasteData
          OnDblClick = ListViewPasteDblClick
          OnDragDrop = ListViewPasteDragDrop
          OnDragOver = ListViewPasteDragOver
          OnInfoTip = ListViewPasteInfoTip
          OnKeyDown = ListViewPasteKeyDown
          OnMouseMove = ListViewPasteMouseMove
          OnSelectItem = ListViewPasteSelectItem
        end
        object PanelPasteB: TPanel
          Left = 0
          Top = 331
          Width = 460
          Height = 89
          Align = alBottom
          Caption = 'PanelPasteB'
          TabOrder = 1
          object ToolBarPaste: TToolBar
            Left = 1
            Top = 59
            Width = 458
            Height = 29
            Hint = #36028#12426#20184#12369#12514#12540#12489#12434#36984#25246#12391#12365#12414#12377#12290
            Align = alBottom
            Caption = 'ToolBarPaste'
            EdgeBorders = []
            Enabled = False
            Flat = True
            Images = ImageListPasteMode
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnCustomDraw = ToolBarPasteCustomDraw
            object ToolButtonPP: TToolButton
              Left = 0
              Top = 0
              Hint = #12506#12540#12473#12488#12514#12540#12489
              Caption = #12506#12540#12473#12488#12514#12540#12489
              Enabled = False
              Grouped = True
              ImageIndex = 0
              Style = tbsCheck
              OnClick = ToolButtonPasteModeClick
            end
            object ToolButtonPC: TToolButton
              Left = 23
              Top = 0
              Hint = #12467#12500#12540#12514#12540#12489
              Caption = #12467#12500#12540#12514#12540#12489
              Enabled = False
              Grouped = True
              ImageIndex = 1
              Style = tbsCheck
              OnClick = ToolButtonPasteModeClick
            end
            object ToolButtonPCR: TToolButton
              Left = 46
              Top = 0
              Hint = #12461#12515#12524#12483#12488#20301#32622#25351#23450#12514#12540#12489
              Caption = #12461#12515#12524#12483#12488#20301#32622#25351#23450#12514#12540#12489
              Enabled = False
              Grouped = True
              ImageIndex = 2
              Style = tbsCheck
              OnClick = ToolButtonPasteModeClick
            end
            object ToolButtonPKM: TToolButton
              Left = 69
              Top = 0
              Hint = #12510#12463#12525#12514#12540#12489
              Caption = #12510#12463#12525#12514#12540#12489
              Enabled = False
              Grouped = True
              ImageIndex = 3
              Style = tbsCheck
              OnClick = ToolButtonPasteModeClick
            end
            object ToolButtonPL: TToolButton
              Left = 92
              Top = 0
              Hint = #12521#12531#12481#12514#12540#12489
              Caption = 'ToolButtonPL'
              Enabled = False
              Grouped = True
              ImageIndex = 4
              Style = tbsCheck
              OnClick = ToolButtonPasteModeClick
            end
            object ToolButtonPB: TToolButton
              Left = 115
              Top = 0
              Hint = #12502#12521#12454#12474#12514#12540#12489
              Caption = 'ToolButtonPB'
              Enabled = False
              Grouped = True
              ImageIndex = 5
              Style = tbsCheck
              OnClick = ToolButtonPasteModeClick
            end
          end
          object MemoPasteText: TMemo
            Left = 1
            Top = 1
            Width = 458
            Height = 58
            TabStop = False
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
    end
    object TabBkmk: TTabSheet
      Caption = #12502#12483#12463#12510#12540#12463
      ImageIndex = 3
      object SplitterBkmk: TSplitter
        Left = 185
        Top = 0
        Height = 420
      end
      object PanelBkmkL: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 420
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel1'
        Constraints.MinWidth = 100
        ParentColor = True
        TabOrder = 0
        object TreeBkmk: TStnTreeView
          Left = 0
          Top = 0
          Width = 185
          Height = 420
          Align = alClient
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 19
          ParentShowHint = False
          PopupMenu = PopupPasteTree
          ReadOnly = True
          RowSelect = True
          ShowHint = True
          TabOrder = 0
          OnAddition = TreePasteAddition
          OnChange = TreePasteChange
          OnChanging = TreePasteChanging
          OnClick = TreePasteClick
          OnCollapsing = TreePasteCollapsing
          OnCompare = TreeCompare
          OnDeletion = TreePasteDeletion
          OnDragDrop = TreePasteDragDrop
          OnDragOver = TreePasteDragOver
          OnEnter = TreePasteEnter
          OnExit = TreePasteExit
          OnKeyDown = TreePasteKeyDown
          OnKeyPress = TreePasteKeyPress
          OnMouseMove = TreePasteMouseMove
          CopyMode = cmCopy
        end
      end
      object PanelBkmkR: TPanel
        Left = 188
        Top = 0
        Width = 460
        Height = 420
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel5'
        Constraints.MinWidth = 150
        ParentColor = True
        TabOrder = 1
        object ListViewBkmk: TStnListView
          Left = 0
          Top = 0
          Width = 460
          Height = 420
          Align = alClient
          Columns = <>
          DragMode = dmAutomatic
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          FullDrag = True
          HideSelection = False
          HotTrack = True
          HotTrackStyles = [htHandPoint, htUnderlineHot]
          HoverTime = 10000000
          LargeImages = ImageListBkmkL
          MultiSelect = True
          OwnerData = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupPasteList
          ShowHint = True
          SmallImages = ImageListBkmkS
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = ListViewPasteColumnClick
          OnCustomDraw = ListViewPasteCustomDraw
          OnData = ListViewPasteData
          OnDblClick = ListViewPasteDblClick
          OnDragDrop = ListViewPasteDragDrop
          OnDragOver = ListViewPasteDragOver
          OnInfoTip = ListViewPasteInfoTip
          OnKeyDown = ListViewPasteKeyDown
          OnSelectItem = ListViewLaunchSelectItem
        end
      end
    end
    object TabLaunch: TTabSheet
      Caption = #12521#12531#12481#12515#12540
      ImageIndex = 2
      object SplitterLaunch: TSplitter
        Left = 185
        Top = 0
        Height = 420
      end
      object PanelLaunchL: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 420
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel1'
        Constraints.MinWidth = 150
        ParentColor = True
        TabOrder = 0
        object TreeLaunch: TStnTreeView
          Left = 0
          Top = 0
          Width = 185
          Height = 420
          Align = alClient
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 19
          ParentShowHint = False
          PopupMenu = PopupPasteTree
          ReadOnly = True
          RowSelect = True
          ShowHint = True
          TabOrder = 0
          OnAddition = TreePasteAddition
          OnChange = TreePasteChange
          OnChanging = TreePasteChanging
          OnClick = TreePasteClick
          OnCollapsing = TreePasteCollapsing
          OnCompare = TreeCompare
          OnDeletion = TreePasteDeletion
          OnDragDrop = TreePasteDragDrop
          OnDragOver = TreePasteDragOver
          OnEnter = TreePasteEnter
          OnExit = TreePasteExit
          OnKeyDown = TreePasteKeyDown
          OnKeyPress = TreePasteKeyPress
          OnMouseMove = TreePasteMouseMove
          CopyMode = cmCopy
        end
      end
      object PanelR: TPanel
        Left = 188
        Top = 0
        Width = 460
        Height = 420
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel5'
        ParentColor = True
        TabOrder = 1
        object ListViewLaunch: TStnListView
          Left = 0
          Top = 0
          Width = 460
          Height = 420
          Align = alClient
          Columns = <>
          DragMode = dmAutomatic
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          FullDrag = True
          HideSelection = False
          HotTrack = True
          HotTrackStyles = [htHandPoint, htUnderlineHot]
          HoverTime = 10000000
          LargeImages = ImageListLaunchL
          MultiSelect = True
          OwnerData = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupPasteList
          ShowHint = True
          SmallImages = ImageListLaunchS
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = ListViewPasteColumnClick
          OnCustomDraw = ListViewPasteCustomDraw
          OnData = ListViewPasteData
          OnDblClick = ListViewPasteDblClick
          OnDragDrop = ListViewPasteDragDrop
          OnDragOver = ListViewPasteDragOver
          OnInfoTip = ListViewPasteInfoTip
          OnKeyDown = ListViewPasteKeyDown
          OnSelectItem = ListViewLaunchSelectItem
        end
      end
    end
    object TabClip: TTabSheet
      Caption = #12463#12522#12483#12503#12508#12540#12489#23653#27508
      ImageIndex = 4
      OnShow = TabClipShow
      object SplitterClip: TSplitter
        Left = 185
        Top = 0
        Height = 420
        Visible = False
      end
      object PanelClipL: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 420
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel1'
        Constraints.MinWidth = 100
        ParentColor = True
        TabOrder = 0
        Visible = False
        object TreeClip: TStnTreeView
          Left = 0
          Top = 0
          Width = 185
          Height = 420
          Align = alClient
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 19
          ReadOnly = True
          RightClickSelect = True
          RowSelect = True
          TabOrder = 0
          OnDragDrop = TreeClipDragDrop
          OnEnter = TreePasteEnter
          OnExit = TreePasteExit
          OnKeyDown = TreePasteKeyDown
          OnKeyPress = TreePasteKeyPress
          CopyMode = cmCopy
        end
      end
      object PanelClipR: TPanel
        Left = 188
        Top = 0
        Width = 460
        Height = 420
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel5'
        Constraints.MinWidth = 150
        ParentColor = True
        TabOrder = 1
        object SplitterClipText: TSplitter
          Left = 0
          Top = 328
          Width = 460
          Height = 3
          Cursor = crVSplit
          Align = alBottom
        end
        object ListViewClip: TStnListView
          Left = 0
          Top = 0
          Width = 460
          Height = 328
          Align = alClient
          Columns = <>
          DragMode = dmAutomatic
          Font.Charset = SHIFTJIS_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
          Font.Style = []
          FullDrag = True
          HideSelection = False
          HotTrack = True
          HotTrackStyles = [htHandPoint, htUnderlineHot]
          HoverTime = 10000000
          LargeImages = ImageListClipL
          MultiSelect = True
          OwnerData = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupClipList
          ShowHint = True
          SmallImages = ImageListClipS
          TabOrder = 0
          ViewStyle = vsReport
          OnChange = ListViewClipChange
          OnClick = ListViewPasteClick
          OnColumnClick = ListViewPasteColumnClick
          OnData = ListViewPasteData
          OnDblClick = ListViewPasteDblClick
          OnDragDrop = ListViewPasteDragDrop
          OnDragOver = ListViewPasteDragOver
          OnInfoTip = ListViewPasteInfoTip
          OnKeyDown = ListViewPasteKeyDown
          OnMouseMove = ListViewClipMouseMove
          OnSelectItem = ListViewPasteSelectItem
        end
        object PanelClipB: TPanel
          Left = 0
          Top = 331
          Width = 460
          Height = 89
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'PanelClipB'
          Constraints.MinHeight = 60
          ParentColor = True
          TabOrder = 1
          object MemoClipText: TMemo
            Left = 0
            Top = 0
            Width = 460
            Height = 60
            TabStop = False
            Align = alClient
            Font.Charset = SHIFTJIS_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            WordWrap = False
          end
          object ToolBarClip: TToolBar
            Left = 0
            Top = 60
            Width = 460
            Height = 29
            Align = alBottom
            Caption = 'ToolBar2'
            Enabled = False
            Flat = True
            Images = ImageListPasteMode
            TabOrder = 1
            OnCustomDraw = ToolBarPasteCustomDraw
            object ToolButtonCP: TToolButton
              Left = 0
              Top = 0
              Hint = #12506#12540#12473#12488#12514#12540#12489
              Caption = #12506#12540#12473#12488#12514#12540#12489
              Enabled = False
              Grouped = True
              ImageIndex = 0
              Style = tbsCheck
              OnClick = ClipToolButtonClick
            end
            object ToolButtonCC: TToolButton
              Left = 23
              Top = 0
              Hint = #12467#12500#12540#12514#12540#12489
              Caption = #12467#12500#12540#12514#12540#12489
              Enabled = False
              Grouped = True
              ImageIndex = 1
              Style = tbsCheck
              OnClick = ClipToolButtonClick
            end
          end
        end
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 519
    Width = 656
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
    ParentColor = True
    ParentFont = True
    UseSystemFont = False
    OnResize = StatusBarResize
  end
  object ToolBarMenu: TToolBar
    Left = 0
    Top = 0
    Width = 656
    Height = 22
    AutoSize = True
    ButtonWidth = 25
    Caption = 'ToolBarMenu'
    EdgeBorders = []
    Flat = True
    Images = ImageListManu
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ToolButton11: TToolButton
      Left = 0
      Top = 0
      Action = ActCreateDir
    end
    object ToolButton12: TToolButton
      Left = 25
      Top = 0
      Action = ActEditDir
    end
    object ToolButton10: TToolButton
      Left = 50
      Top = 0
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButton13: TToolButton
      Left = 58
      Top = 0
      Action = ActCreateItem
    end
    object ToolButton14: TToolButton
      Left = 83
      Top = 0
      Action = ActEditItem
    end
    object ToolButton15: TToolButton
      Left = 108
      Top = 0
      Width = 8
      Caption = 'ToolButton15'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 116
      Top = 0
      Action = ActTopMostWnd
    end
    object ToolButton8: TToolButton
      Left = 141
      Top = 0
      Action = ActStealth
    end
    object ToolButton16: TToolButton
      Left = 166
      Top = 0
      Width = 8
      Caption = 'ToolButton16'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButton19: TToolButton
      Left = 174
      Top = 0
      Action = ActPasteDate
    end
    object ToolButton20: TToolButton
      Left = 199
      Top = 0
      Action = ActPasteTime
    end
    object ToolButton21: TToolButton
      Left = 224
      Top = 0
      Action = ActPasteDateTime
    end
    object ToolButton18: TToolButton
      Left = 249
      Top = 0
      Width = 8
      Caption = 'ToolButton18'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 257
      Top = 0
      Action = ActClipToFilePath
      Visible = False
    end
    object ToolButton2: TToolButton
      Left = 282
      Top = 0
      Action = ActClipToPic
      Visible = False
    end
    object ToolButton4: TToolButton
      Left = 307
      Top = 0
      Action = ActClipToFile
    end
    object ToolButton3: TToolButton
      Left = 332
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object ToolButton17: TToolButton
      Left = 340
      Top = 0
      Action = ActOption
    end
  end
  object ToolBarQuery: TToolBar
    Left = 0
    Top = 22
    Width = 656
    Height = 25
    Caption = 'ToolBarQuery'
    EdgeBorders = []
    Flat = True
    Images = ImageListManu
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnResize = ToolBarQueryResize
    DesignSize = (
      656
      25)
    object LabelQuery: TLabel
      Left = 0
      Top = 0
      Width = 9
      Height = 22
      Align = alLeft
      AutoSize = False
    end
    object EditQuery: TEdit
      Left = 9
      Top = 0
      Width = 465
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnDblClick = EditQueryDblClick
      OnKeyPress = EditQueryKeyPress
    end
    object ToolButton9: TToolButton
      Left = 474
      Top = 0
      Action = ActQuery
      ParentShowHint = False
      ShowHint = False
    end
    object ButtonQuery: TSpeedButton
      Left = 497
      Top = 0
      Width = 23
      Height = 22
      Action = ActQuery
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000F7F7F7FFDFDF
        DFFFDEDEDEFFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF888888FF6666
        67FF7B6767FFA9A9A9FFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF667986FF4472
        C2FF8A7EA2FF786565FFA9A9A9FFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF55B3FEFF48AF
        FFFF4474C4FF8A7EA2FF786565FFA9A9A9FFFBFBFBFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF55B3
        FEFF48AFFFFF4374C6FF8A7EA2FF786565FFA9A9A9FFFBFBFBFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF55B3FEFF48AFFFFF4374C6FF8A7EA2FF806D6DFFE8E8E8FFF5F5F5FFDCDC
        DCFFD5D5D5FFD7D7D7FFEFEFEFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF55B3FEFF48AFFFFF4374C6FF6B6B6BFF777777FF8D6C6CFF9966
        66FFC69393FFA47E7EFF615D5DFFA7A7A7FFF9F9F9FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF52B1FEFFBCBCBCFF857B7BFFD7A990FFFFEBBCFFFFFD
        D1FFFFFFD6FFFFFFD9FFF1E7C8FF846565FF999999FFFBFBFBFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFD4D4D4FFE2B093FFFFFCCFFFFFF0BEFFFFFF
        D3FFFFFFE2FFFFFFECFFFFFFFFFFF9F7E7FF655555FFD5D5D5FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC79D9DFFFFE7BCFFFFE2AFFFFFF6C2FFFFFF
        D8FFFFFFEBFFFFFFF9FFFFFFFCFFFFFFDDFFB78F85FF909090FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFEFEFEFFD6A89CFFFFFAC9FFFFDEABFFFFF2BFFFFFFF
        D6FFFFFFE5FFFFFFEEFFFFFFEBFFFFFFDCFFEDE2B9FF6E6E6EFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFE4BFA5FFFFF8C6FFFFD6A3FFFFEAB7FFFFFD
        CCFFFFFFD8FFFFFFDFFFFFFFDDFFFFFFD1FFFFF2BFFF7D7D7DFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFCEA098FFFFFCD0FFFFE3B8FFFFDBABFFFFF1
        BFFFFFF9C7FFFFFFCDFFFFFDC9FFFFFBC8FFD9B797FFB0B0B0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFE6D3D3FFFFF1C1FFFFFFFFFFFFF8EDFFFFD9
        A7FFFFE2AFFFFFE5B1FFFFE7B3FFFFE7B8FF976A6AFFEFEFEFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBE8E8EFFFFFFFFFFFFFCEDFFFFF7
        D3FFFFDDAAFFFFF4C1FFFFE6BAFFBF8D80FFD8D8D8FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5A2A2FFD7B79BFFFFE7
        B4FFFFE2AFFFEDC6A2FFB78787FFEAEAEAFFFFFFFFFFFFFFFFFF}
      Visible = False
    end
  end
  object MainMenu: TMainMenu
    Images = ImageListManu
    Left = 16
    Top = 40
    object F1: TMenuItem
      Caption = #12501#12449#12452#12523'(&F)'
      OnAdvancedDrawItem = MenuAdvancedDrawItem
      object D8: TMenuItem
        Action = ActCreateDir
      end
      object D9: TMenuItem
        Action = ActDeleteDir
        Caption = #12501#12457#12523#12480#12398#21066#38500'(&D)'
      end
      object P4: TMenuItem
        Action = ActEditDir
        Caption = #12501#12457#12523#12480#12398#12503#12525#12497#12486#12451'(&P)'
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N12: TMenuItem
        Action = ActCreateItem
        Caption = #12450#12452#12486#12512#12398#26032#35215#20316#25104'(&N)'
      end
      object D10: TMenuItem
        Action = ActDeleteItem
        Caption = #12450#12452#12486#12512#12398#21066#38500'(&D)'
      end
      object P5: TMenuItem
        Action = ActEditItem
        Caption = #12450#12452#12486#12512#12398#12503#12525#12497#12486#12451'(&P)'
      end
      object N56: TMenuItem
        Caption = '-'
      end
      object N57: TMenuItem
        Action = ActClipToFilePath
      end
      object N58: TMenuItem
        Action = ActClipToPic
      end
      object N43: TMenuItem
        Caption = '-'
      end
      object N49: TMenuItem
        Caption = #12452#12531#12509#12540#12488
        object ActImportXml1: TMenuItem
          Action = ActImportXml
        end
        object N50: TMenuItem
          Caption = '-'
        end
        object I3: TMenuItem
          Action = ActImportXmlOldVer
        end
      end
      object N48: TMenuItem
        Caption = #12456#12463#12473#12509#12540#12488
        object A3: TMenuItem
          Action = ActExportAll
        end
        object ActExportSel1: TMenuItem
          Action = ActExportSel
        end
      end
      object N47: TMenuItem
        Caption = '-'
      end
      object Q1: TMenuItem
        Action = ActClose
      end
    end
    object N18: TMenuItem
      Caption = #32232#38598'(&E)'
      Visible = False
      OnAdvancedDrawItem = MenuAdvancedDrawItem
    end
    object D1: TMenuItem
      Caption = #34920#31034'(&D)'
      OnAdvancedDrawItem = MenuAdvancedDrawItem
      object N27: TMenuItem
        Action = ActTopMostWnd
      end
      object N55: TMenuItem
        Action = ActStealth
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object N45: TMenuItem
        Caption = #12467#12531#12488#12525#12540#12523#12497#12493#12523
        object M1: TMenuItem
          Action = ActVisibleMenuToolBar
        end
        object Q3: TMenuItem
          Action = ActVisibleSearchToolBar
        end
        object T3: TMenuItem
          Action = ActVisibleTagToolBar
        end
        object N46: TMenuItem
          Caption = '-'
        end
        object S3: TMenuItem
          Action = ActVisibleStatusBar
        end
      end
      object N53: TMenuItem
        Caption = #12479#12502#34920#31034'(&P)'
        object S4: TMenuItem
          Action = ActDispSearchTab
        end
        object N54: TMenuItem
          Caption = '-'
        end
        object P14: TMenuItem
          Action = ActDispPasteTab
        end
        object L1: TMenuItem
          Action = ActDispLaunchchTab
        end
        object B4: TMenuItem
          Action = ActDispBkmkTab
        end
        object C6: TMenuItem
          Action = ActDispClipTab
        end
      end
      object T2: TMenuItem
        Caption = #12484#12522#12540#12398#20006#12409#26367#12360'(&T)'
        object ActSortTreeUser2: TMenuItem
          Action = ActSortTreeUser
        end
        object ActSortTreeName2: TMenuItem
          Action = ActSortTreeName
        end
        object ActSortTreeCr2: TMenuItem
          Action = ActSortTreeCr
        end
        object ActSortTreeUse2: TMenuItem
          Action = ActSortTreeUse
        end
        object ActSortTreeUp2: TMenuItem
          Action = ActSortTreeUp
        end
        object ActSortTreeAc2: TMenuItem
          Action = ActSortTreeAc
        end
        object ActSortTreeRep2: TMenuItem
          Action = ActSortTreeRep
        end
        object N32: TMenuItem
          Caption = '-'
        end
        object ActSortTreeRevers2: TMenuItem
          Action = ActSortTreeRevers
          AutoCheck = True
        end
      end
      object N28: TMenuItem
        Caption = #12522#12473#12488#12459#12521#12512#12398#34920#31034'(&C)'
        object C2: TMenuItem
          Action = ActColumnCrVisible
        end
        object U1: TMenuItem
          Action = ActColumnUpVisible
        end
        object A1: TMenuItem
          Action = ActColumnAcVisible
        end
        object V2: TMenuItem
          Action = ActColumnUseVisible
        end
        object R1: TMenuItem
          Action = ActColumnRepVisible
        end
        object P9: TMenuItem
          Action = ActColumnParentVisible
        end
        object K1: TMenuItem
          Action = ActColumnCommentVisible
        end
      end
      object S2: TMenuItem
        Caption = #12522#12473#12488#12398#20006#12403#26367#12360'(&L)'
        object O2: TMenuItem
          Action = ActSortListUser
          AutoCheck = True
        end
        object N30: TMenuItem
          Action = ActSortListName
          AutoCheck = True
        end
        object C3: TMenuItem
          Action = ActSortListCr
          AutoCheck = True
        end
        object U2: TMenuItem
          Action = ActSortListUp
          AutoCheck = True
        end
        object A2: TMenuItem
          Action = ActSortListAc
          AutoCheck = True
        end
        object V3: TMenuItem
          Action = ActSortListUse
          AutoCheck = True
        end
        object R2: TMenuItem
          Action = ActSortListRep
          AutoCheck = True
        end
        object P10: TMenuItem
          Action = ActSortListParent
          AutoCheck = True
        end
        object K2: TMenuItem
          Action = ActSortListComment
          AutoCheck = True
        end
        object N31: TMenuItem
          Caption = '-'
        end
        object R3: TMenuItem
          Action = ActSortListRevers
          AutoCheck = True
        end
      end
    end
    object N1: TMenuItem
      Caption = #35373#23450'(&O)'
      OnAdvancedDrawItem = MenuAdvancedDrawItem
      object O1: TMenuItem
        Action = ActOption
      end
    end
    object F2: TMenuItem
      Caption = #26085#26178'(&S)'
      object ActPasteDate1: TMenuItem
        Action = ActPasteDate
      end
      object ActPasteTime1: TMenuItem
        Action = ActPasteTime
      end
      object ActPasteDateTime1: TMenuItem
        Action = ActPasteDateTime
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object ActIsDateTimeClipMode1: TMenuItem
        Action = ActIsDateTimeCopy
      end
    end
    object mnuHelp: TMenuItem
      Caption = #12504#12523#12503'(&H)'
      OnAdvancedDrawItem = MenuAdvancedDrawItem
      object V4: TMenuItem
        Action = ActAbput
      end
      object N51: TMenuItem
        Action = ActBugReport
      end
      object N59: TMenuItem
        Caption = '-'
      end
      object K3: TMenuItem
        Action = ActKeyoperationHelp
      end
    end
  end
  object ActionList: TActionList
    Images = ImageListManu
    Left = 48
    Top = 40
    object ActCreateDir: TAction
      Category = #12501#12449#12452#12523
      Caption = #12501#12457#12523#12480#12398#20316#25104'(&D)'
      Hint = #12501#12457#12523#12480#12398#20316#25104'|'#12484#12522#12540#12395#12501#12457#12523#12480#12434#20316#25104#12375#12414#12377#12290
      ImageIndex = 0
      ShortCut = 16452
      OnExecute = ActCreateDirExecute
    end
    object ActEditDir: TAction
      Category = #12501#12449#12452#12523
      Caption = #12503#12525#12497#12486#12451'(&P)'
      Hint = #12501#12457#12523#12480#12398#12503#12525#12497#12486#12451'|'#12501#12457#12523#12480#12398#12503#12525#12497#12486#12451#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
      ImageIndex = 2
      OnExecute = ActEditDirExecute
    end
    object ActDeleteDir: TAction
      Category = #12501#12449#12452#12523
      Caption = #21066#38500'(&D)'
      Hint = #12501#12457#12523#12480#12398#21066#38500'|'#36984#25246#12375#12390#12356#12427#12501#12457#12523#12480#12434#21066#38500#12375#12414#12377#12290
      OnExecute = ActDeleteDirExecute
    end
    object ActCreateItem: TAction
      Category = #12501#12449#12452#12523
      Caption = #26032#35215#20316#25104'(&N)'
      Hint = #12450#12452#12486#12512#12398#26032#35215#20316#25104'|'#36984#25246#12501#12457#12523#12480#12395#12450#12452#12486#12512#12434#26032#35215#20316#25104#12375#12414#12377#12290
      ImageIndex = 3
      ShortCut = 16462
      OnExecute = ActCreateItemExecute
    end
    object ActEditItem: TAction
      Category = #12501#12449#12452#12523
      Caption = #12503#12525#12497#12486#12451'(&P)'
      Hint = #12450#12452#12486#12512#12398#12503#12525#12497#12486#12451'|'#12450#12452#12486#12512#12398#12503#12525#12497#12486#12451#12480#12452#12450#12525#12464#12434#38283#12365#12414#12377#12290
      ImageIndex = 5
      OnExecute = ActEditItemExecute
    end
    object ActDeleteItem: TAction
      Category = #12501#12449#12452#12523
      Caption = #21066#38500'(&D)'
      Hint = #12450#12452#12486#12512#12398#21066#38500'|'#36984#25246#12450#12452#12486#12512#12434#21066#38500#12375#12414#12377#12290
      OnExecute = ActDeleteItemExecute
    end
    object ActDspDirOnList: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = 'ActDspDirOnList'
      Checked = True
    end
    object ActSortListUser: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #12518#12540#12470#12540#23450#32681'(&O)'
      GroupIndex = 21
      Hint = #12518#12540#12470#12540#23450#32681'|'#12518#12540#12470#12540#12364#27770#12417#12383#38918#30058#12393#12362#12426#12395#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListUserExecute
    end
    object ActSortListName: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #21517#21069'(&N)'
      GroupIndex = 21
      Hint = #21517#21069'(|'#21517#21069#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListNameExecute
    end
    object ActSortListCr: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #20316#25104#26085'(&C)'
      GroupIndex = 21
      Hint = #20316#25104#26085'|'#20316#25104#26085#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListCrExecute
    end
    object ActSortListUp: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #26356#26032#26085'(&U)'
      GroupIndex = 21
      Hint = #26356#26032#26085'|'#26356#26032#26085#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListUpExecute
    end
    object ActSortListAc: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #26368#32066#20351#29992#26085'(&A)'
      GroupIndex = 21
      Hint = #26368#32066#20351#29992#26085'|'#26368#32066#20351#29992#26085#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListAcExecute
    end
    object ActSortListUse: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #20351#29992#22238#25968'(&V)'
      GroupIndex = 21
      Hint = #20351#29992#22238#25968'|'#20351#29992#22238#25968#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListUseExecute
    end
    object ActSortListRep: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #20351#29992#38971#24230'(&R)'
      GroupIndex = 21
      Hint = #20351#29992#38971#24230'|'#20351#29992#38971#24230#38918#12391#20006#12403#26367#12360#12414#12377#12290#25968#20516#12399#19968#26085#12354#12383#12426#12398#21033#29992#22238#25968#12391#12377#12290
      OnExecute = ActSortListRepExecute
    end
    object ActSortListParent: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #35242#12501#12457#12523#12480'(&P)'
      GroupIndex = 21
      Hint = #35242#12501#12457#12523#12480'|'#35242#12501#12457#12523#12480#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListParentExecute
    end
    object ActSortListComment: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #12467#12513#12531#12488'(&K)'
      GroupIndex = 21
      Hint = #12467#12513#12531#12488'|'#12467#12513#12531#12488#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListCommentExecute
    end
    object ActSortListRevers: TAction
      Category = #12522#12473#12488#12477#12540#12488
      AutoCheck = True
      Caption = #36870#38918'(&R)'
      Hint = #36870#38918'|'#36870#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortListReversExecute
    end
    object ActCopyDir: TAction
      Category = #12501#12449#12452#12523
      Caption = #12467#12500#12540'(&C)'
      Hint = #12501#12457#12523#12480#12398#12467#12500#12540'|'#12501#12457#12523#12480#12434#12467#12500#12540#12375#12414#12377#12290
      OnExecute = ActCopyDirExecute
    end
    object ActCutDir: TAction
      Category = #12501#12449#12452#12523
      Caption = #20999#12426#21462#12426'(&T)'
      Hint = #12501#12457#12523#12480#12398#20999#12426#21462#12426'|'#12501#12457#12523#12480#12434#20999#12426#21462#12426#12414#12377#12290
      OnExecute = ActCutDirExecute
    end
    object ActCopyItem: TAction
      Category = #12501#12449#12452#12523
      Caption = #12467#12500#12540'(&C)'
      Hint = #12450#12452#12486#12512#12398#12467#12500#12540'|'#12450#12452#12486#12512#12434#12467#12500#12540#12375#12414#12377#12290
      OnExecute = ActCopyItemExecute
    end
    object ActCutItem: TAction
      Category = #12501#12449#12452#12523
      Caption = #20999#12426#21462#12426'(&T)'
      Hint = #12450#12452#12486#12512#12398#20999#12426#21462#12426'|'#12450#12452#12486#12512#12434#20999#12426#21462#12426#12414#12377#12290
      OnExecute = ActCutItemExecute
    end
    object ActPaste: TAction
      Category = #12501#12449#12452#12523
      Caption = #36028#12426#20184#12369'(&P)'
      Hint = #12458#12502#12472#12455#12463#12488#12434#36028#12426#20184#12369#12414#12377#12290
      OnExecute = ActPasteExecute
    end
    object ActOption: TAction
      Category = #12458#12503#12471#12519#12531
      Caption = #12458#12503#12471#12519#12531'(&O)'
      Hint = #12458#12503#12471#12519#12531'|'#12477#12501#12488#12398#35443#32048#35373#23450#12434#12375#12414#12377#12290
      ImageIndex = 9
      ShortCut = 16463
      OnExecute = ActOptionExecute
    end
    object ActDispListIcon: TAction
      Category = #12522#12473#12488#34920#31034
      Caption = #22823#12365#12356#12450#12452#12467#12531'(&B)'
      GroupIndex = 22
      Hint = #22823#12365#12356#12450#12452#12467#12531'|'#21508#38917#30446#12434#19979#12395#12521#12505#12523#12398#20184#12356#12383#12501#12523#12469#12452#12474#12398#12450#12452#12467#12531#12392#12375#12390#34920#31034#12377#12427#12290
      OnExecute = ActDispListIconExecute
    end
    object ActDispListSmallIcon: TAction
      Category = #12522#12473#12488#34920#31034
      Caption = #23567#12373#12356#12450#12452#12467#12531'(&S)'
      GroupIndex = 22
      Hint = #23567#12373#12356#12450#12452#12467#12531'|'#21508#38917#30446#12434#21491#20596#12395#12521#12505#12523#12398#20184#12356#12383#23567#12373#12356#12450#12452#12467#12531#12392#12375#12390#34920#31034#12377#12427#12290
      OnExecute = ActDispListSmallIconExecute
    end
    object ActDispListList: TAction
      Category = #12522#12473#12488#34920#31034
      Caption = #12522#12473#12488'(&L)'
      GroupIndex = 22
      Hint = #12522#12473#12488'|'#21508#38917#30446#12434#21491#20596#12395#12521#12505#12523#12398#20184#12356#12383#23567#12373#12356#12450#12452#12467#12531#12392#12375#12390#34920#31034#12377#12427#12290
      OnExecute = ActDispListListExecute
    end
    object ActDispListReport: TAction
      Category = #12522#12473#12488#34920#31034
      Caption = #35443#32048'(&D)'
      GroupIndex = 22
      Hint = 
        #35443#32048'|'#21508#38917#30446#12395' 1 '#34892#12434#21106#12426#24403#12390#65292#21015#24418#24335#12391#24773#22577#12434#37197#32622#12377#12427#12290#19968#30058#24038#12398#21015#12395#23567#12373#12356#12450#12452#12467#12531#12392#12521#12505#12523#12434#34920#31034#12375#65292#12381#12428#12395#32154#12367#21015#12395#12450#12503#12522#12465#12540#12471 +
        #12519#12531#12391#25351#23450#12375#12383#19979#20301#38917#30446#12434#20837#12428#12427#12290
      OnExecute = ActDispListReportExecute
    end
    object ActSortTreeUser: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #12518#12540#12470#12540#23450#32681'(&O)'
      GroupIndex = 11
      Hint = #12518#12540#12470#12540#23450#32681'|'#12518#12540#12470#12540#12364#27770#12417#12383#38918#30058#12393#12362#12426#12395#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeUserExecute
    end
    object ActSortTreeName: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #21517#21069'(&N)'
      GroupIndex = 11
      Hint = #21517#21069'(|'#21517#21069#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeNameExecute
    end
    object ActSortTreeCr: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #20316#25104#26085'(&C)'
      GroupIndex = 11
      Hint = #20316#25104#26085'|'#20316#25104#26085#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeCrExecute
    end
    object ActSortTreeUp: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #26356#26032#26085'(&U)'
      GroupIndex = 11
      Hint = #26356#26032#26085'|'#26356#26032#26085#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeUpExecute
    end
    object ActSortTreeAc: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #26368#32066#20351#29992#26085'(&A)'
      GroupIndex = 11
      Hint = #26368#32066#20351#29992#26085'|'#26368#32066#20351#29992#26085#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeAcExecute
    end
    object ActSortTreeUse: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #20351#29992#22238#25968'(&V)'
      GroupIndex = 11
      Hint = #20351#29992#22238#25968'|'#20351#29992#22238#25968#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeUseExecute
    end
    object ActSortTreeRep: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #20351#29992#38971#24230'(&R)'
      GroupIndex = 11
      Hint = #20351#29992#38971#24230'|'#20351#29992#38971#24230#38918#12391#20006#12403#26367#12360#12414#12377#12290#25968#20516#12399#19968#26085#12354#12383#12426#12398#21033#29992#22238#25968#12391#12377#12290
      OnExecute = ActSortTreeRepExecute
    end
    object ActSortTreeParent: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #35242#12501#12457#12523#12480'(&P)'
      GroupIndex = 11
      Hint = #35242#12501#12457#12523#12480'|'#35242#12501#12457#12523#12480#38918#12391#20006#12403#26367#12360#12414#12377#12290
    end
    object ActSortTreeComment: TAction
      Category = #12484#12522#12540#12477#12540#12488
      Caption = #12467#12513#12531#12488'(&K)'
      GroupIndex = 11
      Hint = #12467#12513#12531#12488'|'#12467#12513#12531#12488#38918#12391#20006#12403#26367#12360#12414#12377#12290
    end
    object ActSortTreeRevers: TAction
      Category = #12484#12522#12540#12477#12540#12488
      AutoCheck = True
      Caption = #36870#38918'(&R)'
      Hint = #36870#38918'|'#36870#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActSortTreeReversExecute
    end
    object ActClipToPaste: TAction
      Category = #12463#12522#12483#12503#12508#12540#12489
      Caption = #23653#27508#12434#12506#12540#12473#12488#12450#12452#12486#12512#12395#36861#21152
      Hint = #23653#27508#12434#12506#12540#12473#12488#12450#12452#12486#12512#12395#36861#21152'|'#23653#27508#12434#12506#12540#12473#12488#12450#12452#12486#12512#12395#12375#12414#12377#12290'D&D'#12391#32232#38598#12391#12365#12414#12377#12290
      OnExecute = ActClipToPasteExecute
    end
    object ActAddBookMarks: TAction
      Category = #12502#12483#12463#12510#12540#12463#22266#26377
      Caption = #12502#12483#12463#12510#12540#12463#12398#19968#25324#30331#37682'(&B)'
      Hint = #12502#12483#12463#12510#12540#12463#12398#19968#25324#30331#37682'|'#12486#12461#12473#12488#12522#12473#12488#12398'URL'#12363#12425#12502#12483#12463#12510#12540#12463#12398#19968#25324#30331#37682#12375#12414#12377#12290
      OnExecute = ActAddBookMarksExecute
    end
    object ActColumnCrVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #20316#25104#26085'(&C)'
      Hint = #20316#25104#26085'|'#20316#25104#26085#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnCrVisibleExecute
    end
    object ActColumnUpVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #26356#26032#26085'(&U)'
      Hint = #26356#26032#26085'|'#26356#26032#26085#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnUpVisibleExecute
    end
    object ActColumnAcVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #26368#32066#20351#29992#26085'(&A)'
      Hint = #26368#32066#20351#29992#26085'|'#26368#32066#20351#29992#26085#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnAcVisibleExecute
    end
    object ActColumnUseVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #20351#29992#22238#25968'(&V)'
      Hint = #20351#29992#22238#25968'|'#20351#29992#22238#25968#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnUseVisibleExecute
    end
    object ActColumnRepVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #20351#29992#38971#24230'(&R)'
      Hint = #20351#29992#38971#24230'|'#20351#29992#38971#24230#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnRepVisibleExecute
    end
    object ActColumnParentVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #35242#12501#12457#12523#12480'(&P)'
      Hint = #35242#12501#12457#12523#12480'|'#35242#12501#12457#12523#12480#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnParentVisibleExecute
    end
    object ActColumnCommentVisible: TAction
      Category = #12522#12473#12488#12459#12521#12512#12398#34920#31034
      Caption = #12467#12513#12531#12488'(&K)'
      Hint = #12467#12513#12531#12488'|'#12467#12513#12531#12488#12459#12521#12512#12398#34920#31034'/'#38750#34920#31034#12434#20999#12426#26367#12360#12414#12377#12290
      OnExecute = ActColumnCommentVisibleExecute
    end
    object ActTopMostWnd: TAction
      Category = #34920#31034
      Caption = #24120#12395#26368#21069#38754#12395#34920#31034'(&T)'
      Hint = #24120#12395#26368#21069#38754#12395#34920#31034'|'#24120#12395#65297#30058#25163#21069#12395#12501#12457#12540#12512#12434#34920#31034#12375#12414#12377#12290
      ImageIndex = 6
      ShortCut = 16468
      OnExecute = ActTopMostWndExecute
    end
    object ActClipSortAsc: TAction
      Category = #12463#12522#12483#12503#12508#12540#12489
      Caption = 'ActClipSortAsc'
    end
    object ActClipSortDesc: TAction
      Category = #12463#12522#12483#12503#12508#12540#12489
      Caption = 'ActClipSortDesc'
    end
    object ActSendPaste: TAction
      Category = #12501#12449#12452#12523
      Caption = #36028#12426#20184#12369#23455#34892'(&P)'
      Hint = #36028#12426#20184#12369#23455#34892'|'#12479#12540#12466#12483#12488#12454#12451#12531#12489#12454#12395#12486#12461#12473#12488#12434#36028#12426#20184#12369#12414#12377#12290
      OnExecute = ActSendPasteExecute
    end
    object ActSendToClip: TAction
      Category = #12501#12449#12452#12523
      Caption = #12467#12500#12540#23455#34892'(&C)'
      Hint = #12467#12500#12540#23455#34892'|'#12486#12461#12473#12488#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12375#12414#12377#12290
      OnExecute = ActSendToClipExecute
    end
    object ActTidyTrim: TAction
      Category = #25972#24418
      Caption = #24038#21491#12398#31354#30333#38500#21435'(&B)'
      Hint = #65297#34892#12372#12392#12395#12486#12461#12473#12488#12398#24038#21491#12398#31354#30333#12434#38500#21435#12375#12414#12377#12290
      OnExecute = ActTidyTrimExecute
    end
    object ActQuery: TAction
      Category = #12463#12456#12522
      Caption = #26908#32034'(&S)'
      Hint = #26908#32034'|'#12487#12540#12479#12505#12540#12473#12398#20013#12363#12425#26908#32034#12461#12540#12527#12540#12489#12434#21547#12416#12450#12452#12486#12512#12434#25277#20986#12375#12414#12377#12290#26908#32034#12479#12502#12391#26908#32034#12377#12427#12392#12289#20840#12390#12398#12450#12452#12486#12512#12434#26908#32034#12375#12414#12377#12290
      ImageIndex = 8
      OnExecute = ActQueryExecute
    end
    object ActTidyTrimLeft: TAction
      Category = #25972#24418
      Caption = #24038#20596#12398#31354#30333#38500#21435'(&L)'
      Hint = #65297#34892#12372#12392#12395#12486#12461#12473#12488#12398#24038#20596#12398#31354#30333#12434#38500#21435#12375#12414#12377#12290
      OnExecute = ActTidyTrimLeftExecute
    end
    object ActTidyTrimRight: TAction
      Category = #25972#24418
      Caption = #21491#20596#12398#31354#30333#38500#21435'(&R)'
      Hint = #65297#34892#12372#12392#12395#12486#12461#12473#12488#12398#21491#20596#12398#31354#30333#12434#38500#21435#12375#12414#12377#12290
      OnExecute = ActTidyTrimRightExecute
    end
    object ActTidyDeleteEmptyLine: TAction
      Category = #25972#24418
      Caption = #31354#34892#12398#21066#38500'(&E)'
      Hint = #31354#34892#12434#20840#12390#21066#38500#12375#12414#12377#12290
      OnExecute = ActTidyDeleteEmptyLineExecute
    end
    object ActTidySortAsc: TAction
      Category = #25972#24418
      Caption = #12477#12540#12488#65288#26119#38918#65289'(&A)'
      Hint = #12486#12461#12473#12488#12398#34892#12372#12392#12395#26119#38918#12391#20006#12403#26367#12360#12414#12377#12290
      OnExecute = ActTidySortAscExecute
    end
    object ActTidySortDesc: TAction
      Category = #25972#24418
      Caption = #12477#12540#12488#65288#38477#38918#65289'(&D)'
      OnExecute = ActTidySortDescExecute
    end
    object ActConvZenToHan: TAction
      Category = #22793#25563
      Caption = #20840#35282' -> '#21322#35282'(&Z)'
      Hint = #12486#12461#12473#12488#20869#12398#20840#35282#25991#23383#12434#21322#35282#25991#23383#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvZenToHanExecute
    end
    object ActConvHanToZen: TAction
      Category = #22793#25563
      Caption = #21322#35282' -> '#20840#35282'(&H)'
      Hint = #12486#12461#12473#12488#20869#12398#21322#35282#25991#23383#12434#20840#35282#25991#23383#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvHanToZenExecute
    end
    object ActConvKanaToHira: TAction
      Category = #22793#25563
      Caption = #12459#12479#12459#12490' -> '#12402#12425#12364#12394'(&K)'
      Hint = #12486#12461#12473#12488#20869#12398#12459#12479#12459#12490#12434#12402#12425#12364#12394#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvKanaToHiraExecute
    end
    object ActConvHiraToKana: TAction
      Category = #22793#25563
      Caption = #12402#12425#12364#12394' -> '#12459#12479#12459#12490'(&I)'
      Hint = #12486#12461#12473#12488#20869#12398#12402#12425#12364#12394#12434#12459#12479#12459#12490#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvHiraToKanaExecute
    end
    object ActConvLowerToUpper: TAction
      Category = #22793#25563
      Caption = #23567#25991#23383' -> '#22823#25991#23383'(&L)'
      Hint = #12486#12461#12473#12488#20869#12398#23567#25991#23383#12434#22823#25991#23383#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvLowerToUpperExecute
    end
    object ActConvUpperToLower: TAction
      Category = #22793#25563
      Caption = #22823#25991#23383' -> '#23567#25991#23383'(&U)'
      Hint = #12486#12461#12473#12488#20869#12398#22823#25991#23383#12434#23567#25991#23383#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvUpperToLowerExecute
    end
    object ActConvTabToSpace: TAction
      Category = #22793#25563
      Caption = #12479#12502' -> '#12473#12506#12540#12473'(&T)'
      Hint = #12486#12461#12473#12488#20869#12398#12434#12479#12502#12395#12473#12506#12540#12473#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvTabToSpaceExecute
    end
    object ActConvSpaceToTab: TAction
      Category = #22793#25563
      Caption = #12473#12506#12540#12473' -> '#12479#12502'(&S)'
      Hint = #12486#12461#12473#12488#20869#12398#12473#12506#12540#12473#12434#12479#12502#12395#22793#25563#12375#12414#12377#12290
      OnExecute = ActConvSpaceToTabExecute
    end
    object ActStealth: TAction
      Category = #34920#31034
      Caption = #12473#12486#12523#12473
      Hint = #12473#12486#12523#12473#12514#12540#12489'|'#12501#12457#12540#12512#12434#12473#12486#12523#12473#12514#12540#12489#12391#34920#31034#12377#12427#12363#12393#12358#12363#12290
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = ActStealthExecute
    end
    object ActDisplay: TAction
      Category = #34920#31034
      Caption = #34920#31034'(&D)'
      Hint = #34920#31034'|'#12450#12503#12522#12465#12540#12471#12519#12531#12398#12501#12457#12540#12512#12434#34920#31034#12375#12414#12377#12290
      OnExecute = ActDisplayExecute
    end
    object ActClose: TAction
      Category = #12501#12449#12452#12523
      Caption = #38281#12376#12427'(&Q)'
      Hint = #12450#12503#12522#12465#12540#12471#12519#12531#12434#32066#20102#12375#12414#12377#12290
      OnExecute = ActCloseExecute
    end
    object ActVisibleMenuToolBar: TAction
      Category = #34920#31034
      Caption = #12513#12491#12517#12540#12484#12540#12523#12496#12540'(&M)'
      Checked = True
      Hint = #12513#12491#12517#12540#12484#12540#12523#12496#12540#12398#34920#31034#20999#12426#26367#12360
      OnExecute = ActVisibleMenuToolBarExecute
    end
    object ActVisibleTagToolBar: TAction
      Category = #34920#31034
      Caption = #12479#12464#12496#12540'(&T)'
      Checked = True
      Hint = #12513#12491#12517#12540#12484#12540#12523#12496#12540#12398#34920#31034#20999#12426#26367#12360
      OnExecute = ActVisibleTagToolBarExecute
    end
    object ActVisibleStatusBar: TAction
      Category = #34920#31034
      Caption = #12473#12486#12540#12479#12473#12496#12540'(&S)'
      Checked = True
      Hint = #12473#12486#12540#12479#12473#12496#12540#12398#34920#31034#20999#12426#26367#12360
      OnExecute = ActVisibleStatusBarExecute
    end
    object ActVisibleSearchToolBar: TAction
      Category = #34920#31034
      Caption = #26908#32034#12496#12540'(&Q)'
      Checked = True
      Hint = #26908#32034#12496#12540#12398#34920#31034#20999#12426#26367#12360
      OnExecute = ActVisibleSearchToolBarExecute
    end
    object ActExportSel: TAction
      Category = #12456#12463#12473#12509#12540#12488
      Caption = #36984#25246#12506#12540#12473#12488#12501#12457#12523#12480#12434#12456#12463#12473#12509#12540#12488'(&S)'
      Hint = #36984#25246#12506#12540#12473#12488#12501#12457#12523#12480#12434'XML'#12501#12449#12452#12523#12395#12456#12463#12473#12509#12540#12488#12375#12414#12377#12290
      OnExecute = ActExportSelExecute
    end
    object ActExportAll: TAction
      Category = #12456#12463#12473#12509#12540#12488
      Caption = #20840#12390#12398#12506#12540#12473#12488#12501#12457#12523#12480#12434#12456#12463#12473#12509#12540#12488'(&A)'
      Hint = #20840#12390#12398#12506#12540#12473#12488#12501#12457#12523#12480#12434'XML'#12501#12449#12452#12523#12395#12456#12463#12473#12509#12540#12488#12375#12414#12377#12290
      OnExecute = ActExportAllExecute
    end
    object ActImportXml: TAction
      Category = #12452#12531#12509#12540#12488
      Caption = #12506#12540#12473#12488#12450#12452#12486#12512#12398#12452#12531#12509#12540#12488'(&I)'
      Hint = #36984#25246#12375#12390#12356#12427#12501#12457#12523#12480#12395'XML'#12501#12449#12452#12523#12363#12425#12506#12540#12473#12488#12450#12452#12486#12512#12434#12452#12531#12509#12540#12488#12375#12414#12377#12290
      OnExecute = ActImportXmlExecute
    end
    object ActAbput: TAction
      Category = #12504#12523#12503
      Caption = #12496#12540#12472#12519#12531#24773#22577'(&V)'
      Hint = #12496#12540#12472#12519#12531#24773#22577#12434#34920#31034#12375#12414#12377#12290
      ImageIndex = 13
      OnExecute = ActAbputExecute
    end
    object ActImportXmlOldVer: TAction
      Category = #12452#12531#12509#12540#12488
      Caption = #20197#21069#12398#12496#12540#12472#12519#12531#12398#12506#12540#12473#12488#12450#12452#12486#12512#12434#12452#12531#12509#12540#12488'(&O)'
      Hint = #36984#25246#12375#12390#12356#12427#12501#12457#12523#12480#12395#20197#21069#12398#12496#12540#12472#12519#12531#12398'XML'#12501#12449#12452#12523#12363#12425#12506#12540#12473#12488#12450#12452#12486#12512#12434#12452#12531#12509#12540#12488#12375#12414#12377#12290
      OnExecute = ActImportXmlOldVerExecute
    end
    object ActBugReport: TAction
      Category = #12504#12523#12503
      Caption = #12496#12464#12524#12509#12540#12488'(&B)'
      Hint = #12496#12464#12524#12509#12540#12488#12398#12383#12417#12398#12486#12531#12503#12524#12540#12488#12391#12377
      OnExecute = ActBugReportExecute
    end
    object ActPasteDate: TAction
      Category = #27231#33021
      Caption = #26085#20184'(&D)'
      Hint = #26085#20184'|'#29694#22312#12398#26085#20184#12434#12467#12500#12540#12418#12375#12367#12399#12506#12540#12473#12488#12375#12414#12377#12290
      ImageIndex = 10
      OnExecute = ActPasteDateExecute
    end
    object ActPasteTime: TAction
      Category = #27231#33021
      Caption = #26178#21051'(&T)'
      Hint = #26178#21051'|'#29694#22312#12398#26178#21051#12434#12467#12500#12540#12418#12375#12367#12399#12506#12540#12473#12488#12375#12414#12377#12290
      ImageIndex = 11
      OnExecute = ActPasteTimeExecute
    end
    object ActPasteDateTime: TAction
      Category = #27231#33021
      Caption = #26085#26178'(&S)'
      Hint = #26085#26178'|'#29694#22312#12398#26085#26178#12434#12467#12500#12540#12418#12375#12367#12399#12506#12540#12473#12488#12375#12414#12377#12290
      ImageIndex = 12
      OnExecute = ActPasteDateTimeExecute
    end
    object ActIsDateTimeCopy: TAction
      Category = #27231#33021
      Caption = #12467#12500#12540#12514#12540#12489'(&C)'
      Hint = #12467#12500#12540#12514#12540#12489'|'#26085#26178#25991#23383#21015#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12377#12427#12363#12479#12540#12466#12483#12488#12395#36028#12426#20184#12369#12427#12363#12393#12358#12363#12290
      OnExecute = ActIsDateTimeCopyExecute
    end
    object ActOpenLaunchDir: TAction
      Category = #12501#12449#12452#12523
      Caption = 'ActOpenLaunchDir'
      Hint = #12521#12531#12481#12515#12540#12501#12449#12452#12523#12398#35242#12501#12457#12523#12480#12434#38283#12365#12414#12377#12290
      OnExecute = ActOpenLaunchDirExecute
    end
    object ActTabMove: TAction
      Category = #25805#20316
      Caption = #34920#31034#12479#12502#22793#26356
      ShortCut = 16393
      OnExecute = ActTabMoveExecute
    end
    object ActReloadDir: TAction
      Category = #12501#12449#12452#12523
      Caption = #26368#26032#12398#24773#22577#12395#26356#26032'(&R)'
      Hint = #12484#12522#12540#24773#22577#12434#35501#12415#30452#12375#12414#12377#12290
      OnExecute = ActReloadDirExecute
    end
    object ActDispSearchTab: TAction
      Category = #12479#12502#34920#31034
      Caption = #26908#32034#12479#12502'(&S)'
      Hint = #26908#32034#12479#12502'|'#26908#32034#12479#12502#12434#34920#31034#12377#12427#12363#12393#12358#12363#25351#23450#12375#12414#12377#12290
      OnExecute = ActDispSearchTabExecute
    end
    object ActDispPasteTab: TAction
      Category = #12479#12502#34920#31034
      Caption = #36028#12426#20184#12369#12479#12502'(&P)'
      Hint = #36028#12426#20184#12369#12479#12502'|'#36028#12426#20184#12369#12479#12502#12434#34920#31034#12377#12427#12363#12393#12358#12363#25351#23450#12375#12414#12377#12290
      OnExecute = ActDispPasteTabExecute
    end
    object ActDispLaunchchTab: TAction
      Category = #12479#12502#34920#31034
      Caption = #12521#12531#12481#12515#12540#12479#12502'(&L)'
      Hint = #12521#12531#12481#12515#12540#12479#12502'|'#12521#12531#12481#12515#12540#12479#12502#12434#34920#31034#12377#12427#12363#12393#12358#12363#25351#23450#12375#12414#12377#12290
      OnExecute = ActDispLaunchchTabExecute
    end
    object ActDispBkmkTab: TAction
      Category = #12479#12502#34920#31034
      Caption = #12502#12483#12463#12510#12540#12463#12479#12502'(&B)'
      Hint = #12502#12483#12463#12510#12540#12463#12479#12502'|'#12502#12483#12463#12510#12540#12463#12479#12502#12434#34920#31034#12377#12427#12363#12393#12358#12363#25351#23450#12375#12414#12377#12290
      OnExecute = ActDispBkmkTabExecute
    end
    object ActDispClipTab: TAction
      Category = #12479#12502#34920#31034
      Caption = #12463#12522#12483#12503#12508#12540#12489#23653#27508#12479#12502'(&C)'
      Hint = #12463#12522#12483#12503#12508#12540#12489#23653#27508#12479#12502'|'#12463#12522#12483#12503#12508#12540#12489#23653#27508#12479#12502#12434#34920#31034#12377#12427#12363#12393#12358#12363#25351#23450#12375#12414#12377#12290
      OnExecute = ActDispClipTabExecute
    end
    object ActForcusTree: TAction
      Category = #25805#20316
      Caption = #12484#12522#12540#12395#12501#12457#12540#12459#12473
      ShortCut = 16454
      OnExecute = ActForcusTreeExecute
    end
    object ActForcusList: TAction
      Category = #25805#20316
      Caption = #12522#12473#12488#12395#12501#12457#12540#12459#12473
      ShortCut = 16457
      OnExecute = ActForcusListExecute
    end
    object ActForcusQuery: TAction
      Category = #25805#20316
      Caption = #26908#32034#12508#12483#12463#12473#12395#12501#12457#12540#12459#12473
      ShortCut = 16465
      OnExecute = ActForcusQueryExecute
    end
    object ActForcusMove: TAction
      Category = #25805#20316
      Caption = #12484#12522#12540' - '#12522#12473#12488#38291#31227#21205
      ShortCut = 16461
      OnExecute = ActForcusMoveExecute
    end
    object ActClipToFilePath: TAction
      Category = #12463#12522#12483#12503#12508#12540#12489
      Caption = #12463#12522#12483#12503#12508#12540#12489#12398#12501#12449#12452#12523#12497#12473#21462#24471
      Hint = #12463#12522#12483#12503#12508#12540#12489#12398#12501#12449#12452#12523#12497#12473#21462#24471'|'#12463#12522#12483#12503#12508#12540#12489#12395#36028#12426#20184#12369#12425#12428#12383#12501#12449#12452#12523#12497#12473#12434#21462#24471#12375#12414#12377#12290
      ImageIndex = 15
      OnExecute = ActClipToFilePathExecute
    end
    object ActClipToPic: TAction
      Category = #12463#12522#12483#12503#12508#12540#12489
      Caption = #12463#12522#12483#12503#12508#12540#12489#12398#30011#20687#21462#24471
      Hint = #12463#12522#12483#12503#12508#12540#12489#12398#30011#20687#21462#24471'|'#12463#12522#12483#12503#12508#12540#12489#12395#36028#12426#20184#12369#12425#12428#12390#12356#12427#30011#20687#12434#12501#12450#12452#12523#12395#20445#23384#12375#12414#12377#12290
      ImageIndex = 16
      OnExecute = ActClipToPicExecute
    end
    object ActKeyoperationHelp: TAction
      Category = #12504#12523#12503
      Caption = #12461#12540#25805#20316#12504#12523#12503'(&K)'
      Hint = #12461#12540#12509#12540#12489#12391#25805#20316#12377#12427#12383#12417#12398#12471#12519#12540#12488#12459#12483#12488#12290
      OnExecute = ActKeyoperationHelpExecute
    end
    object ActReloadList: TAction
      Category = #12501#12449#12452#12523
      Caption = #26368#26032#12398#24773#22577#12395#26356#26032'(&R)'
      OnExecute = ActReloadListExecute
    end
    object ActClipToFile: TAction
      Category = #12463#12522#12483#12503#12508#12540#12489
      Caption = #12463#12522#12483#12503#12508#12540#12489#12487#12540#12479#21462#12426#20986#12375
      Hint = #12463#12522#12483#12503#12508#12540#12489#12487#12540#12479#21462#12426#20986#12375'|'#12463#12522#12483#12503#12508#12540#12489#12487#12540#12479#12434#12501#12449#12452#12523#12395#20445#23384#12375#12414#12377#12290
      ImageIndex = 17
      ShortCut = 16453
      OnExecute = ActClipToFileExecute
    end
  end
  object ImageListSearchL: TImageList
    Left = 204
    Top = 41
  end
  object ImageListSearchS: TImageList
    Left = 232
    Top = 73
  end
  object ImageListPasteL: TImageList
    Height = 32
    Width = 32
    Left = 240
    Top = 41
  end
  object ImageListPasteS: TImageList
    ImageType = itMask
    Left = 264
    Top = 73
  end
  object ImageListLaunchL: TImageList
    Height = 32
    Width = 32
    Left = 272
    Top = 40
  end
  object ImageListLaunchS: TImageList
    Left = 296
    Top = 73
  end
  object ImageListBkmkL: TImageList
    Left = 304
    Top = 41
  end
  object ImageListBkmkS: TImageList
    Left = 344
    Top = 73
  end
  object ImageListClipL: TImageList
    Height = 32
    Width = 32
    Left = 336
    Top = 41
  end
  object ImageListClipS: TImageList
    Left = 376
    Top = 73
  end
  object ImageListManu: TImageList
    Left = 116
    Top = 41
    Bitmap = {
      494C010112001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      000000000000000000000000000000000000D5D5D5FFC6C6C6FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFF1F1F1FF000000000000000000000000354F57003D4F
      6000395464003D586700445D6A00455F6B004E647600536A7B00536A7B005C71
      84005F76870067707B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F5F5F5FFF3F3F3FFF2F2F2FFF0F0
      F0FFEFEFEFFFEEEEEEFFEDEDEDFFEBEBEBFFEAEAEAFFE9E9E9FFE8E8E8FFE7E7
      E7FFE7E7E7FFE6E6E6FFC6C6C6FF000000000000000000000000C3D2D500EBEC
      EA00EEF0ED00ECEEF400F0F0ED00EEF1F000F0F1F000F0F1F000F0F0ED00EFEF
      EA00EBECEA008E979C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F6F6F6FF58BDBCFF4FBBB8FF51B8
      B7FF49AFA3FF53B3A0FF58B09DFF66B6AEFF84CFD2FF92DEDDFF98E4E4FF94E4
      E4FF91E1E4FFE7E7E7FFC6C6C6FF000000000000000000000000BFCDCF00E2E9
      E90092A5BA00D6E6EE00E7F2F800F7F6F100F6F7F600F6F7F600F6F7F600F7F6
      F100F4F3EF0090999E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F7FF77CDC9FF82E4E3FF31AA
      7EFF40C37FFF51D690FF30B46FFF179756FF249072FF61D4CDFF74E1DCFF8CF1
      F0FF9EFCFFFFE8E8E8FFC6C6C6FF000000000000000000000000B7C4CA00EFF1
      F400F5F6F500E8F5F80094BCE0006D9AC700F5F8F800FCFAF900F9FCF200F9F7
      F400F7F6F10090999E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F9F9FF90D4CEFFA1EDE8FF32AC
      71FF3AC07BFF5FDA9DFF32B471FF159551FF5DBCA0FFA2F7F5FF83E1D9FF79D4
      C9FF78D4C9FFE9E9E9FFC6C6C6FF000000000000000000000000ADB9C000F0F6
      F800F6F7F600F5F8F800EEF9FC00FDFDF600CBE7F2005AA0C200B6CBDD00EFF9
      F900F8F8F200919D9F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFAFAFFA4E3E2FFBBFDFDFFB3F4
      EFFF2BB26BFF64D99EFF2EB06DFF04823FFFB0F8F3FFABDEDDFF9EECEBFF9DF8
      F8FF93DBC9FFEAEAEAFFC6C6C6FF000000000000000000000000A0AEB600F6FC
      FA00FAFCFA00FDFDFC00FDFCFA00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFC
      FA00FCFAF900949FA20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBFBFBFFA1D0C2FFB1E7D9FFB4EC
      EBFF3BB275FF66D79FFF26A964FF54AF80FFDF8180FFDC8886FFC29A8FFFC491
      88FFBD9D8FFFEBEBEBFFC6C6C6FF00000000000000000000000098A4AD00F6FC
      FA00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFC
      FA00FDFCFA00939FA10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFB0DACBFF3073B3FF034C
      B7FF055DA0FF61D398FF11934DFFCAFDF4FFEA8686FFDF8D8AFFCA857DFFCB81
      7DFFBCA9A8FFECECECFFC6C6C6FF000000000000000000000000949FA900F6FC
      FA00FAFCFA00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFD
      FC00FDFDFC00919D9F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFDFFB7DECFFF0457CDFF0C6A
      CDFF0B57D1FF3EB48AFF5AB485FFD1F5E1FFEC9595FFE48988FFD16965FFD269
      67FFDD9587FFEDEDEDFFC6C6C6FF0000000000000000000000008F9DA600FDFD
      FC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFD
      FC00FDFCFA0097A2A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFEFFE5D3AAFF0A81CEFF28AA
      D3FF0071D0FFD2D9B0FFFDE5BAFFFFE6BBFFFDE1C4FFFEEAD0FFFDE4CCFFFDDE
      BFFFFEDFB9FFEFEFEFFFC6C6C6FF0000000000000000000000008F9DA600FDFD
      FC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFCFA00FCFA
      F900FCFAF90097A3A60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFE5BE8DFFFFD496FFD1CD
      A5FFF8D198FFFFD197FFFFD197FFFFD197FFFFD197FFFFD197FFFFD197FFFFD1
      97FFFFD197FFF0F0F0FFC6C6C6FF0000000000000000000000008F98A500FDFD
      FC00FDFDFC00FDFDFC00FDFDFC00FDFDFC00FDFCFA00FDFCFA00FDFCFA00FDFC
      FA00FCFAF60097A3A60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFE5B179FFFFC17FFFFFC1
      7FFFFFC17FFFFFC17FFFFFC17FFFFFC17FFFFFC07FFFFFC07FFFFEC07EFFFEC0
      7EFFFEBE7CFFF2F2F2FFC6C6C6FF0000000000000000000000008B95A000FDFD
      FC00FDFDFC00FAFCFA00FCFAF900FCFAF900FCFAF600FCFAF600FCFAF600FDFC
      FA00FDFCFA0099A5A70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFFFEFEFEFFFDFDFDFFFCFCFCFFFBFBFBFFFAFAFAFFF8F8F8FFF7F7F7FFF6F6
      F6FFF5F5F5FFF3F3F3FFC6C6C6FF0000000000000000000000008B9BA200FDFD
      F600D2DAD700B5C5BF00BBC2C100BBC2C100BEC5C000BEC5C000BFC7C200BFC9
      C300F8F8F200A3A9AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C6FFC6C6C6FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FF000000000000000000000000909EA800EBF5
      F800DFE8EF00A8B7BD008CA3A900A6BEAF00838E85008A99970092A1A400D0D9
      DF00D8DBE0008D9CAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AFBEC8003A5B
      7600355E7800385F7A00507181006B858F003645560070878F0042617A003D62
      7B00375E78008AA0A90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B3C0C70097AEB70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F5F5F5FFDFDFDFFFE6E6
      E6FF000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C7FF8E8E8FFF6E6E6FFF7B7B7CFFA8A8A9FFE9E9E9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C7FF8E8E8FFF6E6E6FFF7B7B7CFFA8A8A9FFE9E9E9FF0000
      00000000000000000000000000000000000000000000F7F7F7FFDFDFDFFFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFE7E7E7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000676769FF92979AFFB3BABFFFB2B7
      BCFF7A7F80FFB2B2B2FF0000000000000000000000000000000000000000B0B0
      B0FFBFBFBFFFD2D1D1FF826C65FF834E43FF80584EFFA19896FFEBEBEBFF8F8F
      8FFFEBEBEBFF000000000000000000000000000000000000000000000000B0B0
      B0FFBFBFBFFFD1CECEFF88685DFF8F5543FF945847FFA4867EFFEBEBEBFF8E8E
      8FFFEBEBEBFF00000000000000000000000000000000CFCFCFFFF5F6F6FFF5F6
      F6FFF5F6F6FFF5F6F6FFF5F6F6FFF5F6F6FFF5F6F6FFF5F6F6FF9F9F9FFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006E6F71FFBFC5CAFFB6BEC3FFB5BCC0FFB5BD
      C0FFB5BBBFFFB8BEC3FFA7A7A7FF000000000000000000000000909091FFD9D8
      D8FF934932FFB24628FFBD4424FFB53516FFB83718FFC3482AFFB44A32FF8B71
      6DFFD3D3D3FFD1D1D1FF000000000000000000000000000000008F8F90FFD9D9
      D9FF864122FF9C4B2AFFAB5637FFB05133FFC3593CFFCA5136FFD1492DFFA25F
      4EFFD3D3D3FFD1D1D1FF000000000000000000000000CFCFCFFFF6F7F7FFF6F7
      F7FFF6F7F7FFF6F7F7FFF6F7F7FFF6F7F7FFF6F7F7FFF6F7F7FF636363FF9F9F
      9FFFE7E7E7FF0000000000000000000000000000000000000000000000000000
      00000000000000000000A9A9A9FFC8CDD4FFBFC5CDFFC1C6CBFFC0C4CBFFBCC2
      C9FFC1C8CEFFABB0B4FFADB3B7FF0000000000000000959595FFC0BEBEFFA24A
      2DFFB34320FFB8421EFFB9401EFFF6F5F5FFDDCBC7FFB93012FFC64123FFBF46
      2AFF894F41FFD4D4D4FFEBEBEBFF0000000000000000959595FFC0C0BFFF8B2F
      07FF8E3813FF994624FFB88877FFD5D5D8FFC3ABA3FFC6563BFFCA5136FFCC50
      33FFB74B34FFD4D4D4FFEBEBEBFF0000000000000000CFCFCFFFF7F8F8FFF7F8
      F8FFF7F8F8FFF7F8F8FFF7F8F8FFF7F8F8FFF7F8F8FFF7F8F8FF999A9AFFF6F7
      F7FFC3C3C3FFE7E7E7FF0000000000000000F3F3F3FF9A9A9AFF787878FF7878
      78FF7D7D7DFF888888FF97999CFFC6CED3FFC7CFD4FFC7CFD5FFC4CBCFFF7D80
      84FF18181AFFBEC3CAFFC9CFD7FFB8B9B9FFD9D9D9FFEDEDEDFF9E4B2FFFB045
      1FFFB3421EFFB5411EFFB94622FFE6E9EBFFF2F3F3FFB52F0EFFC44121FFC240
      20FFBA4527FF887069FF8F8F8FFF00000000D9D9D9FFEDEDEDFF913109FF9135
      0CFF90360EFF94401DFFB9A097FFBAB6B7FFD1C9C7FFBE593CFFC2593DFFC557
      3DFFC4553AFFA0614FFF8E8E8FFF0000000000000000CFCFCFFFF7F9F9FFF7F9
      F9FFF7F9F9FFF7F9F9FFF7F9F9FFF7F9F9FFF7F9F9FFF7F9F9FF999A9AFFF6F7
      F7FFD6D7D7FF9F9F9FFF0000000000000000D2D2D2FF7D8283FF8B8F92FF9194
      98FF979B9FFF9EA3A8FFB7BEC1FFC9D3D7FFCDD6DCFFCDD7DCFF959A9EFF787C
      7FFFCCD3D6FFC3C8CDFFC7CFD2FFABABABFF7F7F80FF89736DFFAC4824FFB045
      1FFFB1411DFFB1411DFFB94624FFC2C6C7FFE9EBEBFFB1300EFFBE401EFFBD3F
      1FFFBB401EFFA8492EFFEBEBEBFFE9E9E9FF7E7E7FFF8E7B73FF9D3A11FF9837
      10FF94370EFF963C17FF99431EFFA25132FFAB5131FFB45C3FFFB95C3EFFBB5B
      3EFFBB5B3DFFBB593BFFEAE9E9FFE9E9E9FF00000000CFCFCFFFF9FAFAFFF9FA
      FAFFF9FAFAFFF9FAFAFFF9FAFAFFF9FAFAFFF9FAFAFFF9FAFAFF9A9B9BFFF7F8
      F8FFD7D8D8FF9F9F9FFF0000000000000000D3D3D3FFDDE4E4FFDFE8EAFFD9E2
      E3FFCFD6DAFFD7DEE1FFB7BCC0FFCED6DDFFD2D8DFFFD0D7DEFF5E6061FFD2DB
      E1FFCAD3D8FFC9D3D7FFD5DDE2FFC4C4C4FFC0C0C0FFAA5D41FFB9522CFFAF46
      1FFFAF421DFFB0421DFFB64823FFAFB3B4FFE1E4E4FFAD300DFFB73F1DFFB73F
      1CFFB63F1DFFAE4322FF9F9794FFA8A8A9FFC0C0C0FFAE5837FFAD4F28FFA13E
      14FF9B3A11FF993A13FFA8674BFFD1CFD3FFA06C59FFA75637FFAD5A3BFFB05A
      3CFFB05A3CFFB0563AFFA28073FFA8A8A9FF00000000CFCFCFFFFAFBFBFFFAFB
      FBFFFAFBFBFFFAFBFBFFFAFBFBFFFAFBFBFFFAFBFBFFFAFBFBFF9B9B9BFFF9F9
      F9FFD8D9D9FF9F9F9FFF0000000000000000EEEEEEFFD9E3EAFFE4EEF5FFE4EE
      F5FFE2EDF4FF545758FF3F4040FFD5DCE4FFD3D8DFFFD6DBE3FF686A6BFFD4DA
      E2FFCFD6DDFFCED6DDFFEDF4F8FF00000000EDEDEDFFB96342FFC55D36FFBC52
      2CFFAE431EFFAE431CFFB54925FFA9AEAFFFDEE0E1FFA7300CFFB13E1BFFB03E
      1BFFAF3F1AFFAC401EFF78554AFF7B7B7CFFEDEDEDFFC05A33FFB85832FFB051
      28FFA43F15FFA03C14FFA0451EFFC6C3C4FFC4BEBEFF96401DFFA2512FFFA351
      32FFA55231FFA55131FF934E34FF7B7B7CFF00000000CFCFCFFFFBFCFCFFFBFC
      FCFFFBFCFCFFFBFCFCFFFBFCFCFFFBFCFCFFFBFCFCFFFBFCFCFF9C9C9CFFFAFA
      FAFFD9DADAFF9F9F9FFF000000000000000000000000C4CDD2FFDCE6EEFFDCE7
      EEFFDDE7EFFFBFC8CDFFABB1B6FF9EA1A2FFD4DCE2FFD5DAE1FFA8ABAFFFD4D9
      E0FFD3D8DFFFE8F0F7FFB3B3B3FF00000000FBFBFBFFC16946FFC9633BFFCA63
      3DFFC55C35FFAB411BFFB14924FFB7B9BCFFDEE0E1FFA52F0AFFAD3F1AFFAD3F
      1AFFAC3F1AFFAA411CFF7B4E41FF6E6E6FFFFBFBFBFFCC633AFFC35D36FFBE5C
      33FFB75932FFAB471FFFA23C13FFAC745EFFB6B1B2FFD6D4D6FF903B17FF9A45
      21FF994422FF9A4421FF90492BFF6E6E6FFF00000000CFCFCFFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFF9D9D9DFFFBFB
      FBFFDADBDBFF9F9F9FFF000000000000000000000000A7AEB2FFD6DFE6FFD4DE
      E5FFD6DFE6FFB6BFC6FF4B4D4EFF5F6264FF626363FFECF1F5FFE3E9EFFFE0E6
      EBFFC1C6C8FF60605EFF0000000000000000DADADAFFC37250FFCF6A43FFD06B
      41FFD06941FFD16941FFBE5630FFCACDD0FFE3E4E5FFA3310BFFAB411BFFAC41
      1AFFAB411BFFA8431FFF84716AFF8E8E8FFFDADADAFFD56D47FFCC663DFFC661
      3BFFC25D36FFBB5B35FFB75A32FFAD4C24FFB88675FFDED8D8FFD5C2BBFF9A3F
      19FF99411CFF97401CFF8B5843FF8E8E8FFF00000000CFCFCFFFFDFDFDFFFDFD
      FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFE0E0E0FFA8A8A8FFFCFC
      FCFFDBDCDCFF9F9F9FFF00000000000000000000000091979AFFCDD6DCFFD0DB
      DFFFD6E2E6FF313131FF434444FFA9B1B5FF373737FF484A4AFFC2CDD1FFC5CE
      D3FFD3DEE3FF7E7E7EFF0000000000000000A2A2A2FFBC8773FFD5734AFFD771
      49FFD67149FFD57048FFD36B45FFD6714DFFD5714DFFBF5630FFB84F28FFB44B
      26FFB54D27FFAD5432FFD3D2D2FFC6C6C7FFA1A1A1FFCE9783FFD4673DFFCF66
      3EFFCA643CFFCF9078FFAE512CFFB44F26FFCE9983FFFAF8F8FFF7F6F5FFA64E
      28FFA34F2CFFA14E2AFFD2CCCBFFC6C6C7FF00000000CFCFCFFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFE0E0E1FFEAEAEAFFFDFD
      FDFFDCDCDCFF9F9F9FFF000000000000000000000000777B7CFFC6D0D5FFCDD5
      DBFFD3DCE4FF313130FF555859FFCBD4D9FF373736FF7C8083FFC9D2D7FFC6CF
      D4FFC5CBD0FFA7A7A7FF0000000000000000A9A9AAFFC1C0BFFFD87E5AFFDD79
      52FFDC7950FFDC7850FFD97047FFEAD4CCFFCBA292FFD26942FFCB643EFFC761
      39FFC05C37FF9F5E47FFBFBFBFFF00000000A9A9AAFFC3C3C3FFE27953FFD86D
      43FFD3683EFFEEC4B6FFFFFFFFFFFFFFFFFFFFFFFFFFFAF8F8FFD9B8AAFFAE51
      2CFFA84F2AFF9C411EFFBFBFBFFF0000000000000000CFCFCFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E1FFA7A7A7FFB4B4B4FFB4B4
      B4FFEEEEEEFF9F9F9FFF0000000000000000000000005F5F5FFFC6CBCFFFC9CE
      D0FFCBD2D2FFB9C0C0FF3F3F3DFF2F2E2BFF60625FFFCDD4D5FFC4C9CDFFC1C7
      CAFFC3C9CBFFBCBCBCFF000000000000000000000000B8B8B9FFCBAB9FFFE183
      5EFFE38159FFE37F56FFE3835CFFFFFFFFFFFFFFFFFFD06539FFD06B42FFC968
      40FFB46849FFDAD9D9FFB0B0B0FF0000000000000000B7B7B8FFDAC0B6FFDF6D
      41FFDB6E45FFDD7C55FFFFF1EBFFFFFFFFFFFFFCFAFFE3B4A3FFB9542CFFB557
      30FFAE4B23FFDCDBDBFFB0B0B0FF0000000000000000CFCFCFFFCFCFCFFFCFCF
      CFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFEBEBEBFFB4B4B4FFE0E0E1FFEAEA
      EAFFE0E0E0FFAAAAAAFF000000000000000000000000636368FF5E65B1FF6066
      ACFF575EADFF5B62B5FF6F75BFFF696FB9FF5B61AFFF6166B5FF696EB2FF6167
      B2FF5D64AFFFE9E9E9FF000000000000000000000000D7D7D8FFE1E1E1FFD8BB
      AEFFE58B68FFE98661FFE7835BFFF2AC91FFE68C68FFDA784FFFD1734DFFB971
      54FFC4C2C1FF909091FF000000000000000000000000D7D7D8FFE1E1E1FFDFC8
      BFFFE87C52FFDE6D44FFD96A41FFD36337FFCD6337FFCA643CFFC45F38FFBB51
      27FFCBC8C7FF8F8F90FF0000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6C8FFEBEBEBFFFEFE
      FEFFE0E0E1FFECECECFF000000000000000000000000838384FF5D63A6FF9094
      C5FFC3C5DBFFB5B7D2FF898EC1FFECEEF5FFF8F9FDFF7E83B5FFB0B3D0FF5A61
      ADFF565C9FFF0000000000000000000000000000000000000000D7D7D8FFB8B8
      B9FFCAC8C7FFE6B19CFFE19071FFDE8967FFD78461FFC87D61FF9F887FFFEDED
      EDFF959595FF0000000000000000000000000000000000000000D7D7D8FFB7B7
      B8FFCACACAFFDFAD9BFFE3744CFFE06C41FFD8663AFFD1673EFFBF988AFFEDED
      EDFF959595FF0000000000000000000000000000000000000000000000000000
      0000CFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0
      E1FFECECECFF00000000000000000000000000000000A4A4A3FF6368A7FF6469
      A6FF7276AEFF7276B0FF666BA6FF6F73ACFF686CA8FF7E83B6FF7074ABFF5F63
      9FFF52558DFF0000000000000000000000000000000000000000000000000000
      0000A9A9AAFFA2A2A2FFDADADAFFFBFBFBFFEDEDEDFFC0C0C0FF7F7F80FFD9D9
      D9FF000000000000000000000000000000000000000000000000000000000000
      0000A9A9AAFFA1A1A1FFDADADAFFFBFBFBFFEDEDEDFFC0C0C0FF7E7E7FFFD9D9
      D9FF000000000000000000000000000000000000000000000000000000000000
      0000CFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFECEC
      ECFF00000000000000000000000000000000BEBEBEFFC0C0C0FFFAFAFAFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C7C7C7FF686868FF262626FF050505FF050505FF262626FF686868FFC7C7
      C7FF00000000000000000000000000000000EFEDEFFF6C6B6BFFBBBBBBFFE6E6
      E6FFEDEDEDFFFCFCFCFF000000000000000000000000FCFCFCFFFAFAFAFFFAFA
      FAFFFDFDFDFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009E6446FFB98C68FFA26B4AFF0000
      0000000000009F6747FF9F6747FF0000000000000000FDFDFDFFEDEDEDFFE4E4
      E4FFE4E4E4FFE8E8E8FFE9E9E9FFE8E8E8FFE7E7E7FFE8E8E8FFE8E8E8FFEDED
      EDFFF4F4F4FFF4F4F4FFF6F6F6FFFAFAFAFF0000000000000000000000006868
      68FF303030FFB2B2B2FFDDDDDDFFE2E2E2FFE2E2E2FFDBDBDBFFAFAFAFFF2F2F
      2FFF686868FF000000000000000000000000E6E2E2FFF4EFF2FF8E8E8DFFCBCA
      CBFFFDFDFDFFF9F9F9FFF8F8F8FFF9F9F9FFFAFAFAFFFAFAFAFFFBFBFBFFFBFB
      FBFFFCFCFCFFFDFDFDFFFDFDFDFF000000000000000000000000000000000000
      000000000000FAFAF9FFCDCAC6FF9E988FFF9E6446FFB28360FFA77252FFADA6
      97FFDCDBD9FF9F6747FF9F6747FF00000000E6E6E6FF3C3D3DFF454648FF494B
      4DFF4A4C4EFF4D5051FF4E5153FF4F5154FF535558FF525455FF4E4F52FF4C4D
      4EFF494B4DFF464747FF313333FFF8F8F8FF0000000000000000474747FF9090
      90FFE5E5E5FFE7E7E7FFE7E7E7FFB6B6B6FFB5B5B5FFE5E5E5FFE3E3E3FFE1E1
      E1FF8D8D8DFF474747FF000000000000000000000000F7F6F6FFF1E9EBFFAFAF
      AFFFCFCFCFFF00000000FDFDFDFFF8F8F8FFD8D8D8FFD4D2CFFFE2E2E2FFFEFE
      FEFFFEFEFEFFFEFEFEFF000000000000000000000000FAFAF9FFCFCCC6FFA49C
      92FF958C7EFF968C7DFF92897AFF8E8577FF9E6446FFDFC5A1FFAF7B5BFFAFA7
      98FFAFA799FFBF9373FFBF9373FF00000000E6E6E6FF656668FF777B7DFF7C80
      82FF7E8183FF828789FF83888BFF868B8DFF868B8EFF808588FF7F8486FF8184
      85FF838788FF7E8183FF545556FF0000000000000000686868FF909090FFE8E8
      E8FFE9E9E9FFEAEAEAFFEAEAEAFFEAEAEAFFE9E9E9FFE8E8E8FFE6E6E6FFE4E4
      E4FFE2E2E2FF8D8D8DFF686868FF000000000000000000000000FEFEFEFFE2D8
      DAFFCDCCCDFFB9B9B9FFC8C8C8FFE4E3DFFFFCFBFBFFFBFAF8FFF9F6F5FFE6E1
      D8FFE6E4E1FF000000000000000000000000A7A096FFB6AE9EFFB4AB9CFFADA5
      96FFA79F8FFFA09889FF9C9385FF8F8778FF9E6646FFDFC5A1FFB1815FFFAFA7
      97FFAFA797FFDDBF9DFFDDBF9DFF00000000EDEDEDFFE7F3F7FFF6FFFFFFF6FF
      FFFFF6FFFFFFEEF9FFFFD0DBDEFFE4EFF6FFF3FFFFFFE5F1F8FFE4EDF5FFE1EC
      F3FFB7BFC4FF949A9DFFA7AEB2FF00000000C7C7C7FF313131FFE8E8E8FFEBEB
      EBFFECECECFFEDEDEDFFEEEEEEFFEDEDEDFFECECECFFEBEBEBFFE9E9E9FFE7E7
      E7FFE4E4E4FFE1E1E1FF2F2F2FFFC7C7C7FF0000000000000000000000000000
      0000BBB9B9FFCCCCCCFFEFEEEAFFFAF9F6FFFBF9F8FFFAF9F6FFF9F8F5FFF7F4
      F0FFE5DED4FFABAAA7FF0000000000000000A9A297FFCAC2B2FFCAC2B2FFC2BB
      ABFFB8B1A2FFAFA999FFA79F91FFBBBDB5FFA46C4BFFDDBF9EFFB1815FFFB1AA
      9BFFA79F8FFFA77151FFA77151FFEDEDEDFF00000000BCC5CAFFE2EDF4FFE1EC
      F3FFDFEBF1FFD8E3E9FF2A2929FF313030FF343333FFCCD5DBFFDBE6EDFFDBE6
      EDFFDBE6EDFFCCD6DCFF74787AFF00000000686868FFB6B6B6FFEBEBEBFFEEEE
      EEFFEFEFEFFFF1F1F1FFF1F1F1FFF1F1F1FFEFEFEFFFEEEEEEFFB9B9B9FF0000
      00FFE6E6E6FFE3E3E3FFB0B0B0FF686868FF0000000000000000000000000000
      0000BBBBBBFFEBE7E4FFF7F5F1FFF9F6F5FFF9F8F5FFFAF7F5FFF9F6F4FFF8F5
      F3FFF5F1EBFFA8A8A8FFEEEEEEFF00000000AFA79CFFDDD5C4FFBBBDB5FFBDB7
      ADFFCFCAB9FFD1CDBCFFC7C4B2FFACAFADFFA87352FFD8B897FFB1815FFF857D
      71FFB8B2A3FFA77151FF985F42FFFBFBFBFF000000009FA6AAFFDAE6ECFFDAE6
      ECFFDBE6EDFFDCE6EDFFDFE8F0FFBCC4C9FF363636FF302F2EFFDFEBF1FFDBE6
      EDFFDAE6ECFFD8E3E9FF6B6F72FF00000000262626FFE4E4E4FFEEEEEEFFF0F0
      F0FFF2F2F2FFF4F4F4FFF4F4F4FFF4F4F4FFF2F2F2FFBDBDBDFF000000FFB9B9
      B9FFE8E8E8FFE5E5E5FFDBDBDBFF262626FF000000000000000000000000FEFE
      FEFFC0C0BFFFF6F2EDFFF8F5F2FFF9F5F3FFF9F5F2FFF8F6F3FFF8F6F2FFF8F5
      F2FFF5F1ECFFD1CCC6FFA3A3A3FF00000000B5AE9FFFC7C2B2FFACAFADFF9E96
      87FFAAA394FFB9B3A4FFB8B2A3FFB6AF9FFFAE7958FFD5B38FFFB1815FFF746B
      60FF7F776BFFA77151FF975E41FF0000000000000000777B7EFFD5DFE5FFD4DE
      E5FFD5DEE5FFDBE6ECFF4F5051FF333231FF595B5CFF3A3A3AFFA1A7ACFFD9E4
      E9FFD7E1E6FFD3DEE4FF5F5F61FF00000000050505FFEBEBEBFFBCBCBCFFF2F2
      F2FFF5F5F5FFF7F7F7FFF8F8F8FFF8F8F8FFC8C8C8FF171717FFBEBEBEFFECEC
      ECFFE9E9E9FFB5B5B5FFE2E2E2FF050505FF000000000000000000000000D4D4
      D4FFD4CEC8FFF4F0E9FFF7F4F0FFF6F4EFFFF7F3F0FFF7F4F0FFF7F4F0FFF8F5
      F1FFF6F3EFFFDED7CEFFB0B0B0FF00000000B9B2A4FFDCD5C2FFE0D9C8FFE5E2
      D7FFEDEBE5FFE8E7DFFFD0CEC3FFB7B1A6FFB07F5DFFD1AF8AFFB1815FFF978E
      81FF847B71FFACACACFF646464FF00000000000000006A6D6EFFCED6DCFFCFD9
      E0FFCFDBE0FF5F6162FF393939FF8F9599FF727577FF3A3A3AFF83888BFFD1DC
      E3FFCFDAE1FFCCD6DBFF666768FF00000000050505FFECECECFFBDBDBDFFF4F4
      F4FFF8F8F8FFFBFBFBFFFBFBFBFFFBFBFBFF3F3F3FFFCDCDCDFFF3F3F3FFEEEE
      EEFFEAEAEAFFB6B6B6FFE3E3E3FF050505FF000000000000000000000000B1B1
      B1FFEAE1D5FFF3EFE8FFF6F2EEFFF5F2EEFFF5F2EEFFF5F2EEFFF6F2EFFFF5F2
      EFFFF4EFEAFFD8D1C8FFAFAFAFFF00000000C2BCB6FFF9F6EFFFE6E1D5FFD7D0
      BFFF736C63FFB2AE9FFFC4BFAFFFC4BFB1FFB07F5DFFEEDBBCFFB1815FFFE9E8
      E6FF00000000A7A7A7FF646464FF0000000000000000686A6BFFC7D0D6FFCCD4
      D8FFCED7DDFF66696AFF373737FFCAD3D9FF8B9094FF393939FFADB5B9FFC8D2
      D8FFC7D0D6FFC5CBD1FF818181FF00000000262626FFE7E7E7FFF2F2F2FFF5F5
      F5FFF9F9F9FFFCFCFCFFFFFFFFFFFCFCFCFF5E5E5EFFF7F7F7FFF4F4F4FFF1F1
      F1FFEBEBEBFFE7E7E7FFDDDDDDFF262626FF000000000000000000000000ACAC
      ACFFE8DED2FFF1ECE5FFF4F0EBFFF4F0EBFFF4F0E9FFF3EEE8FFF2EDE5FFF4EF
      E9FFF2EFE9FFCCC9C6FFA6A6A6FF0000000000000000E3E1DEFFB9B3AAFFC0BB
      ADFFBEB9AFFF5E5E5BFFBDBCBAFF555558FF828384FFA7A7A8FF848484FF0000
      000000000000A7A7A7FF646464FF0000000000000000707070FFC4CAD0FFC5CA
      CEFFC7CFD4FFCED7DCFF454545FF2B2A2AFF2F2F2EFF606264FFC8CFD3FFC2C8
      CDFFBFC5CBFFC0C4CAFF797979FF00000000686868FFBBBBBBFFF3F3F3FFF6F6
      F6FFF9F9F9FFFCFCFCFFFCFCFCFFFCFCFCFF7C7C7CFFF8F8F8FFF5F5F5FFF1F1
      F1FFEDEDEDFFE8E8E8FFB2B2B2FF686868FF000000000000000000000000B2B2
      B2FFD8C7B2FFF1ECE5FFF2EDE6FFF2EDE6FFF3EFE9FFF4F0EAFFF4F1ECFFF4F1
      EDFFF2ECE5FFBCBCBCFFCDCDCDFF000000000000000000000000000000000000
      0000000000000000000000000000828384FFCCCCCCFFB4B4B4FFA7A7A7FFCCCC
      CCFF00000000A7A7A7FF646464FF0000000000000000909090FF7A80BAFF7D82
      B8FF747AB6FF6E74B5FF8085C1FF8B92C5FF8890C8FF6E74B6FF7D83B9FF888D
      BCFF7E84B9FF787EB7FFB1B1B0FF00000000C7C7C7FF343434FFF1F1F1FFF6F6
      F6FFF9F9F9FFFBFBFBFFFCFCFCFFFCFCFCFF9A9A9AFFF8F8F8FFF5F5F5FFF2F2
      F2FFEDEDEDFFE8E8E8FF303030FFC7C7C7FF000000000000000000000000E1E1
      E1FFA99479FFF1EBE3FFF3EFEAFFF3EFEAFFF3EFEAFFF3EFEBFFF4F0ECFFF3EE
      E8FFD8CBBAFFCDCDCDFFFEFEFEFF000000000000000000000000000000000000
      000000000000000000000000000088898AFFC0C1C2FFEFEFEFFFCCCCCCFFB4B4
      B4FF00000000A7A7A7FF646464FF0000000000000000B6B5B5FF5D63ABFF595E
      A9FFADAFCFFFF4F5F9FFE8E7F0FFA9ADD3FFA1A4C6FFF0F1F7FF9B9FC8FF6D71
      AFFF5B61ADFF5D63AEFFEEEEEEFF0000000000000000686868FFA0A0A0FFF5F5
      F5FFF8F8F8FFFAFAFAFFFBFBFBFFFCFCFCFFB4B4B4FFF9F9F9FFF6F6F6FFF2F2
      F2FFEDEDEDFF969696FF686868FF00000000000000000000000000000000FEFE
      FEFF807F7CFFDACCB7FFF3EEE9FFF3EEE9FFF3EEE9FFF3EFEAFFF3EFEAFFD8CB
      B7FFE7E7E7FFE0E0E0FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDCDCDFFA7A7A7FFC0C1C2FFDEDE
      DEFF00000000A7A7A7FF646464FF0000000000000000CFCFCFFF5E62A4FF585D
      9DFFBEC1DCFF6065A8FFC9CCE3FF5359A2FFCFD0E6FF666AABFFC8CAE2FFD7D8
      EAFF5A5EA0FF5A5E9DFF00000000000000000000000000000000474747FFA6A6
      A6FFF6F6F6FFF9F9F9FFFBFBFBFFF7F7F7FFC0C0C0FFF8F8F8FFF5F5F5FFF1F1
      F1FF9D9D9DFF474747FF00000000000000000000000000000000000000000000
      0000F3F3F3FF8F8170FFDACAB5FFEEE8DEFFF0EBE2FFE9E1D5FFCBB79DFFF9F9
      F9FFE2E2E2FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EDEDEDFF00000000828384FFA4A5
      A5FF00000000A7A7A7FF848484FF0000000000000000F7F7F7FF6B6C73FF6E6F
      76FF6A6B73FF6D6F75FF6A6C72FF6A6C70FF67696EFF6A6C71FF6E6E72FF6F6F
      76FF727278FF727277FFFAFAFAFF000000000000000000000000000000006868
      68FF3D3D3DFFD0D0D0FFF5F5F5FFFAFAFAFFF9F9F9FFF1F1F1FFC9C9C9FF3939
      39FF686868FF0000000000000000000000000000000000000000000000000000
      000000000000FDFDFDFFC3C7C4FFC4B59EFFBDAC94FFC0BAB2FFDADADAFFFBFB
      FBFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000828384FFA5A7A7FF0000
      000000000000A7A7A7FFA7A7A7FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C7C7C7FF686868FF262626FF050505FF050505FF262626FF686868FFC7C7
      C7FF000000000000000000000000000000000000000000000000F0F0F0FFD4D4
      D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4
      D4FFD0D0D0FFEEEEEEFF0000000000000000000000000000000000000000DAD4
      CEFFC5BCB5FFB9A99DFFDDDCDBFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFF7F7F7FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFE3E3E3FF00000000000000000000000000000000B6AFA7FFC0A9
      91FFAC947CFFC9A787FF816F55FFCFCBC7FFF7F7F7FFF6F7F7FFF6F7F7FFF6F7
      F7FFF6F7F7FFF5F6F6FFF5F6F6FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003131310000000000BBA690FFC0B6ADFFC2B8AEFFC3B9
      B0FFC4BAB1FFC4BAB1FFC4BAB1FFC4BAB0FFC3B9AFFFC2B8AEFFC0B6ADFFBFB5
      ABFFBDB3AAFFBCB2A8FFBAB1A7FFC4AE93FF0000000000000000F5F6F6FFF8F8
      F8FFF7F8F8FFF7F8F8FFF7F7F7FFF7F7F7FFF5F6F6FFEFEFEFFFEEEFEFFFF4F5
      F5FFEEEFEFFFE3E3E3FF000000000000000000000000E4DED8FFE7D9CCFFD2BF
      B1FFC9BAA7FFCAB99DFFCFBD9EFFF4E7C7FF9D9D9BFFF0F1F1FFF6F7F7FFF6F7
      F7FFF6F7F7FFF6F7F7FFF5F6F6FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000313131009C9C9C0000000000C0B2A2FFC9C9C9FFCBCBCBFFCCCC
      CDFFCECECEFFCECECFFFCECECFFFCDCDCEFFCCCCCDFFCACACBFFC8C8C9FFC6C6
      C6FFC3C3C4FFC1C1C2FFBFBFC0FFC8BDB1FF0000000000000000F6F6F6FFF8F9
      F9FFF8F8F8FFF8F8F8FFF3F4F4FFEAEAEAFFE4E5E5FFB5B6B6FFB4B5B5FFDCDD
      DDFFEEEFEFFFE3E3E3FF0000000000000000EFECE8FFDECEBDFFE1D5C3FFF9EA
      D1FFB1B0AEFFD9C7ACFFD5CCB7FF8F7C62FFF7F7F7FFE1E2E2FFF7F7F7FFF7F7
      F7FFF6F7F7FFF6F7F7FFF6F7F7FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000313131009C9C9C000000000000000000C3B4A3FFCDCDCEFFD0D0D0FFD1D1
      D2FFD3D3D3FFD3D3D4FFD3D3D4FFD3D3D3FFD1D1D2FFCFCFD0FFCDCDCDFFCACA
      CBFFC7C7C8FFC3C3C4FFC1C1C2FFC8BDB0FF0000000000000000F6F6F6FFF9F9
      F9FFF8F9F9FFCDCECEFFCCCDCDFFB8B9B9FFC6AF9AFFF5DFBEFFA2876BFFCECE
      CEFFEEEFEFFFE3E3E3FF0000000000000000EFEFEBFFEDD8CBFFC9BEA2FFF9F9
      F9FFF0F0F0FFF8F9F9FFF2E2C4FFDDCFB7FF7A674EFFF7F7F7FFF7F7F7FFF7F7
      F7FFF7F7F7FFF6F7F7FFF6F7F7FFDFDFDFFF0000000000000000000000000000
      000000000000A5A57B00ADAD7B00B5B58400BDBD8C0000000000000000003131
      31009C9C9C00000000000000000000000000C6B7A4FFD2D2D2FFD4D4D4FFD6D6
      D6FFD6D6D6FFD7D7D7FFD7D7D7FFD6D6D6FFD6D6D6FFD4D4D4FFD1D1D2FFCECE
      CFFFCBCBCBFFC7C7C8FFC3C3C4FFC8BDAFFF0000000000000000F6F6F6FFF9FA
      FAFFCFD0D0FFA18B74FFBDA77FFFADADADFFFFFEE5FFA6A7A7FFDAC4A4FFE1E2
      E2FFEFEFEFFFE3E3E3FF0000000000000000BEA18BFFF5D8C5FF92735AFFF9FA
      FAFFF9F9F9FFF9F9F9FFF6DCBCFFECE7DAFFCAB7A7FFF7F8F8FFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF6F7F7FFDFDFDFFF0000000000000000000000000000
      00009C9C7300C6C6A500C6C6AD00CECEAD00B5B58C00BDBD9400313131009C9C
      9C0000000000000000000000000000000000C9B9A5FFD6D6D6FFD6D6D6FFD7D7
      D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD6D6D6FFD5D5D6FFD2D2
      D3FFCFCFCFFFCACACBFFC6C6C7FFC9B9A4FF0000000000000000F6F7F7FFF6F6
      F6FFC7BCA0FFFFFFDEFFFFFFC5FFFFEFB7FFD5B792FFFFFFE7FF8F7259FFF7F7
      F7FFEFEFEFFFE3E3E3FF0000000000000000CFB7A1FFAF977FFF8C6548FFFAFA
      FAFFF9FAFAFFE9E1D8FFF7F4E8FFEAE2D0FFDEDDDCFFF8F8F8FFF7F8F8FFF7F8
      F8FFF7F7F7FFF7F7F7FFF7F7F7FFDFDFDFFF0000000000000000000000000000
      0000A5A57B00CECEAD00BDBD8C00C6C69400D6D6B500C6C69400C6C69400CECE
      CE0000000000000000000000000000000000CABAA5FFD7D7D7FFD7D7D7FFD7D7
      D7FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD7D7D7FFD7D7D7FFD7D7D7FFD6D6
      D6FFD2D2D2FFCECECEFFC9C9CAFFCAB596FF0000000000000000F7F7F7FFEBEC
      ECFFFFFFE7FF818B97FFF5F6F6FFF9F9F9FFFFFFD9FFACADADFFCECFCFFFF7F8
      F8FFEFEFEFFFE3E3E3FF0000000000000000FCFAF9FFF1E5D2FFEAD5C7FFB5A6
      9DFFB9ADA4FFEDE3D7FFF8F6F0FFCCC0AAFFA99887FFF8F9F9FFF8F8F8FFF7F8
      F8FFF7F8F8FFF7F7F7FFF7F7F7FFDFDFDFFF0000000000000000000000000000
      0000B5B58400B5B58C00BDBD8C00C6C69400C6C69400C6C69400C6C69C00CECE
      9C0000000000000000000000000000000000CABAA3FFD7D7D7FFD8D8D8FFD8D8
      D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD7D7D7FFD7D7
      D7FFD5D5D5FFD0D0D1FFCCCCCCFFC8B598FF0000000000000000F7F7F7FFC7A8
      94FFFFFFE0FFA8A8A8FFC1C1C1FFD7D7D7FFFFFFD8FFCCB995FFE8E8E8FFF7F8
      F8FFEFF0F0FFE3E3E3FF0000000000000000DFD7CFFFD1B8A2FFE5CEBDFFE7DC
      CFFFD9CCBAFFE6D8C9FFA99979FFF9FAFAFFF9F9F9FFF9F9F9FFF8F9F9FFF8F8
      F8FFF7F8F8FFF7F8F8FFF7F7F7FFDFDFDFFF0000000000000000000000000000
      000000000000848463008C8C6B00949473009C9C7B00CECE9C00CECE9C00CECE
      A500DEDEC600000000000000000000000000CAB9A2FFD8D8D8FFD8D8D8FFD9D9
      D9FFD9D9D9FFD9D9D9FFD9D9D9FFD9D9D9FFD8D8D8FFD8D8D8FFD7D7D7FFD7D7
      D7FFD6D6D6FFD2D2D3FFCECECEFFC8BCAAFF0000000000000000F7F7F7FFFCFD
      FDFFFFFFE5FFA7926EFFB3B4B4FFAF9C80FFFFFFFCFF84715BFFF5F5F5FFF8F9
      F9FFF0F0F0FFE3E3E3FF000000000000000000000000FAF7F6FFEAC7B4FFD5C7
      B5FFDFD2C6FFBEAD93FFAF9B80FFF9F9F9FFF9FAFAFFF9F9F9FFF9F9F9FFF8F9
      F9FFF8F8F8FFF7F8F8FFF7F8F8FFDFDFDFFF0000000000000000000000000000
      0000000000007B7B6300B5B58C00CECE9C009C9C7B00CECE9C00CECE9C00D6D6
      A500E7E7C600000000000000000000000000CAB9A0FFD8D8D8FFD8D8D8FFD9D9
      D9FFD9D9D9FFDADADAFFDADADAFFD9D9D9FFD9D9D9FFD8D8D8FFD8D8D8FFD7D7
      D7FFD7D7D7FFD4D4D4FFCFCFCFFFC8BCA9FF0000000000000000F7F7F7FFFDFD
      FDFFFCFDFDFFFFF2DCFFFFFFFFFFFFFFFEFFD6C9C0FFF7F7F7FFF9F9F9FFFFFF
      FFFFD8D8D8FFE2E2E2FF0000000000000000FEFEFEFF00000000EAE8E3FFFAF9
      F9FFB2A592FFFCFCFCFFFCFCFCFFFBFCFCFFFAFAFAFFF9FAFAFFF9FAFAFFF9F9
      F9FFF8F9F9FFF8F9F9FFF8F8F8FFDFDFDFFF0000000000000000000000000000
      000073735A00ADAD8400C6C69C00CECEA5009C9C7B00CECEA500CECEA500D6D6
      AD00E7E7C600000000000000000000000000CAB99EFFD8D8D8FFD9D9D9FFD9D9
      D9FFDADADAFFDADADAFFDADADAFFDADADAFFD9D9D9FFD9D9D9FFD8D8D8FFD7D7
      D7FFD7D7D7FFD5D5D5FFD0D0D0FFC8BBA7FF0000000000000000F7F7F7FFFDFD
      FDFFFDFDFDFFFDFDFDFFB4967DFFFCFCFCFFFBFCFCFFFFFFFFFFA4A6A6FFA5A5
      A5FFB5B5B5FFF5F5F5FF000000000000000000000000FEFEFEFF00000000FDFD
      FDFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFBFCFCFFFAFAFAFFFAFAFAFFF9FA
      FAFFF9F9F9FFF8F9F9FFF8F9F9FFDFDFDFFF000000009C9C7B00949473007B7B
      6300B5B58C00C6C69C00D6D6AD00E7E7C600D6D6AD00D6D6A500D6D6AD00D6D6
      AD00E7E7C600000000000000000000000000C6B397FFD2D2D1FFD3D2D1FFD4D3
      D2FFD4D3D2FFD4D4D3FFD4D4D3FFD4D3D2FFD4D3D2FFD3D2D1FFD2D2D1FFD2D1
      D0FFD1D1D0FFD0D0CFFFCCCCCBFFC5B293FF0000000000000000F8F8F8FFFDFE
      FEFFFDFDFDFFFDFDFDFFFCFDFDFFFCFCFCFFFCFCFCFFFFFFFFFFE6E6E6FFD0D0
      D0FFFBFBFBFF000000000000000000000000000000000000000000000000FDFD
      FDFFFDFDFDFFFDFDFDFFFCFDFDFFFCFCFCFFFCFCFCFFFBFCFCFFFAFAFAFFFAFA
      FAFFF9FAFAFFCECECEFFB7B7B7FFE4E4E4FF00000000ADAD8400C6C6AD00D6D6
      B5009C9C7B00D6D6B500E7E7C6000000000000000000DEDEC600E7E7C600E7E7
      C60000000000000000000000000000000000B6A281FFBDBAB5FFBDBAB5FFBDBA
      B5FFBDBAB5FFBDBAB5FFBDBAB5FFBDBAB5FFBDBAB5FFBDBAB5FFBDBAB5FFBDBA
      B5FFBDBAB5FFBDBAB5FFBDBAB5FFB8A88EFF0000000000000000FEFEFEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFC6C6C6FF0000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFDFDFFFCFCFCFFFCFCFCFFFBFCFCFFFAFA
      FAFFF5F5F5FFE2E2E2FFAEAEAEFFFCFCFCFF00000000BDBD8C00B5B58C00C6C6
      9C00D6D6AD00A5A58C0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B07D28FFB48539FFB48539FFB485
      39FFB48539FFB48539FFB48539FFB48539FFB48539FFB48539FFB48539FFB485
      39FFB38335FFB58638FFB58638FFB27E2BFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFE
      FEFFC4BFBFFFFDFDFDFFC4BFBFFFFCFCFCFFC4BFBFFFFCFCFCFFC4BFBFFFFCFC
      FCFFE4E4E4FFB3B3B3FFFCFCFCFF000000000000000000000000C6C69400CECE
      A500D6D6B500DEDEB50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B78D45FFBF9D62FFBF9D62FFBF9D
      62FFBF9D62FFBF9D62FFBF9D62FFBF9D62FFBF9D62FFBF9D62FFBF9D62FFBF9D
      62FFBD995CFFBD9755FFBD9755FFB88C42FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFE
      FEFFC4BFBFFFFDFDFDFFC4BFBFFFFDFDFDFFC4BFBFFFFCFCFCFFC4BFBFFFDCDC
      DCFFB3B3B3FFFBFBFBFF0000000000000000000000000000000000000000CECE
      A500D6D6AD00D6D6AD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F4FFCDCDD4FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F7F7FFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFF7F7F7FF00000000000000009BE7F7FF94E5F7FF8CE3F4FF88E0
      F2FF84E0F2FF81DFF1FF7FDEF0FF7BDBEFFF7BDCF0FF7CDBF0FF79BDD6FF98D7
      EDFFADC9D5FFBABABAFF00000000000000006D78D3FF1F35D0FF7BBED7FF9DE6
      F7FF8FE4F4FF89E1F2FF4F7DAFFF83DFF1FF7FDEF1FF7CDCF0FF7ADBEFFF7CDC
      EFFF7AD4EAFF8AC7DDFF81C1D7FF000000009BE7F7FF94E5F7FF8CE3F4FF88E0
      F2FF84E0F2FF81DFF1FF7FDEF0FF7BDBEFFF7BDCF0FF7CDBF0FF79BDD6FF98D7
      EDFFADC9D5FFBABABAFF00000000000000000000000000000000D6D6D6FFF8F9
      F9FFF8F8F8FFF7F8F8FFF7F8F8FFF7F7F7FFF7F7F7FFF7F7F7FFF6F7F7FFF6F7
      F7FFFAFAFAFFDFDFDFFF00000000000000009EE8F7FF8FE3F7FF81DFF2FF7DDD
      F1FF79DBF0FF76DBEFFF72D8EFFF6FD7EFFF6DD7EFFF76D9EFFF75B9D4FF84CB
      E7FFD5B396FFBFBFBFFFF2F2F2FF00000000999DF2FF1B37DDFF689FD5FF98E6
      F7FF84E1F2FF60A5C5FF6EC2D8FF77DBF0FF73D9EFFF6FD7EFFF6DD7EEFF6FD7
      EEFF7CDAEFFF74BFDAFFD5BFA5FF75B1C9FF9EE8F7FF8FE3F7FF81DFF2FF7DDD
      F1FF79DBF0FF76DBEFFF72D8EFFF6FD7EFFF6DD7EFFF76D9EFFF75B9D4FF84CB
      E7FFD5B396FFBFBFBFFFF2F2F2FF000000000000000000000000D6D6D6FFF9F9
      F9FFF8F9F9FFF8F9F9FFF8F8F8FFF7F8F8FFF7F8F8FFF7F7F7FFF7F7F7FFF6F7
      F7FFFAFAFAFFDFDFDFFF00000000000000009FE9F7FF8FE4F7FF80E0F2FF7CDF
      F1FF78DDF0FF73DAEFFF6FD8EFFF6BD7EFFF6AD6EEFF74D9EFFF76BBD5FF79C8
      E7FFFFFFFFFFEEEEEEFFECECECFFFBFBFBFF00000000354ADAFF2438B1FF99E7
      F7FF81DCEEFF203CD2FF7ADEF1FF77DCF0FF71D9EFFF6DD7EFFF69D6EEFF6ED7
      EEFF7CDAEFFF6DBCDCFFFFFFFFFF75B3CAFF9FE9F7FF8FE4F7FF80E0F2FF7CDF
      F1FF78DDF0FF73DAEFFF6FD8EFFF6BD7EFFF6AD6EEFF74D9EFFF76BBD5FF79C8
      E7FFFFFFFFFFEEEEEEFFECECECFFFBFBFBFF0000000000000000D6D6D6FFF9FA
      FAFFF9F9F9FFF8F9F9FFF8F9F9FFF8F8F8FFF7F8F8FFF7F7F7FFF7F7F7FFF7F7
      F7FFFAFAFAFFDFDFDFFF0000000000000000A3E9F8FF95E7F7FF87E4F5FF83E2
      F4FF7EDFF2FF79DEF1FF76DBF0FF71D9EFFF70D8EFFF78DCEFFF78BDD7FF7ECE
      EAFFFFFFFFFF00000000000000000000000000000000000000001C35D2FF3F5E
      AEFF1532F2FF84E1F2FF80E0F2FF7CDFF1FF77DDF0FF73DAEFFF6FD8EFFF73D9
      EFFF81DDEFFF71C1DEFFFFFFFFFF77B4CDFFA3E9F8FF95E7F7FF87E4F5FF83E2
      F4FF74CCDDFF67BDCEFF63BBCDFF60BACCFF5FB8CAFF67BBCCFF67A0B7FF6BAF
      C7FFD8D8D8FFD9D9D9FFDCDCDCFFF8F8F8FF0000000000000000D6D6D6FFFAFA
      FAFFF9FAFAFFF9F9F9FFF9F9F9FFF8F9F9FFF8F8F8FFF7F8F8FFF7F7F7FFF7F7
      F7FFFBFCFCFFDFDFDFFF0000000000000000A7EBF9FF97E7F7FF8EE7F6FF88E5
      F5FF85E3F4FF80E0F2FF7BDFF1FF77DDF0FF76DCEFFF7CDDF0FF7CC0D8FF85D4
      EDFFFFFFFFFF00000000000000000000000000000000000000006187C5FF0922
      DAFF2645C7FF8CE6F5FF87E4F4FF82E1F2FF7EDFF2FF79DEF1FF76DBF0FF77DB
      F0FF84DFF0FF76C6DFFFFFFFFFFF7BB9D0FFA7EBF9FF97E7F7FF8EE7F6FF88E5
      F5FFF7F7F7FFE7E7E7FFE1E1E1FFE7E7E7FFE7E7E7FFE1E1E1FFE7E7E7FFE1E1
      E1FFE1E1E1FFE7E7E7FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFAFA
      FAFFFAFAFAFFF9FAFAFFF9F9F9FFF9F9F9FFF8F9F9FFF7F8F8FFF7F8F8FFF7F7
      F7FFFBFCFCFFDFDFDFFF0000000000000000ABEEF9FF9DE9F7FF94EAF7FF8FE7
      F6FF8AE6F5FF87E4F4FF81E0F2FF7DDEF1FF7BDEF1FF7FDFF2FF80C2DAFF91DC
      EFFFABE9F8FF000000000000000000000000DADADFFF6D7AE6FF4057F5FF8BC2
      E1FF74A4EFFF344BB1FF8DE7F6FF88E5F5FF85E2F4FF7FDFF2FF7BDEF1FF7BDE
      F1FF87E0F2FF80CDE2FFA4E8F9FF7DBBD3FFABEEF9FF9DE9F7FF94EAF7FF8FE7
      F6FFF7F7F7FFFFFFFFFFFFFFFFFFB6B6B6FFFFFFFFFFFFFFFFFFB6B6B6FFFFFF
      FFFFFFFFFFFFB6B6B6FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFCFC
      FCFFFBFCFCFFFAFAFAFFF9FAFAFFF9FAFAFFF9F9F9FFF8F8F8FFF7F8F8FFF7F8
      F8FFFCFCFCFFDFDFDFFF0000000000000000AFEFFAFFA1EBF8FF99ECF7FF96E9
      F7FF90E7F7FF8DE6F6FF88E4F5FF84E2F4FF80DFF2FF81DFF2FF8EE4F4FF97CE
      DFFFA3D1E3FF00000000000000000000000095A3F8FF8C98E9FF8FCCE4FFAAED
      FAFF9EEDF8FF96E6F7FF778FEEFF67A5BCFF8AE5F5FF86E3F4FF81E0F2FF7FDF
      F1FF85E1F2FF88D0E6FF88C3DBFFDBEDF4FFAFEFFAFFA1EBF8FF99ECF7FF96E9
      F7FFF7F7F7FF4E733CFFE9ECD6FFB6B6B6FFA5B5A3FF6F7C90FFB6B6B6FF0362
      ADFF92D9E7FFB6B6B6FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFCFC
      FCFFFCFCFCFFFBFCFCFFFAFAFAFFFAFAFAFFF9FAFAFFF8F9F9FFF8F8F8FFF7F8
      F8FFFCFCFCFFDFDFDFFF0000000000000000B3F2FCFFA5EFF9FF9FEFF9FF9BED
      F8FF97EBF7FF93E8F7FF8FE7F6FF89E5F5FF86E3F4FF84E1F2FF9DE7F6FF5DB5
      E9FF00000000000000000000000000000000000000000000000097D7E8FFAEEF
      FCFFA2EFF9FF9DEEF8FF98ECF7FF94E9F7FF90E7F6FF8DE6F6FF87E4F5FF85E2
      F4FF87E3F4FF94E6F5FF0000000000000000B3F2FCFFA5EFF9FF9FEFF9FF9BED
      F8FFF7F7F7FFC7C7C7FFB6B6B6FFC7C7C7FFC7C7C7FFB6B6B6FFC7C7C7FFB6B6
      B6FFB6B6B6FFC7C7C7FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFCFD
      FDFFFCFCFCFFFCFCFCFFFBFCFCFFFAFAFAFFFAFAFAFFF9F9F9FFF8F9F9FFF8F9
      F9FFFCFCFCFFDFDFDFFF0000000000000000B7F3FDFFA9F0FAFFA5F1FAFFA0EF
      F9FF9DEEF8FF98ECF7FF94E9F7FF8FE7F6FF8CE6F5FF62C6F2FFBBEFF9FF1498
      EFFFE9F4FDFFFAFCFDFFF9FAFAFF0000000000000000000000009CDAECFFB2F0
      FCFFA8F1FAFFA2F0F9FF9FEFF8FF9BEDF8FF97EBF7FF93E8F7FF8EE7F6FF89E5
      F5FF8AE5F5FF96E7F6FF0000000000000000B7F3FDFFA9F0FAFFA5F1FAFFA0EF
      F9FFF7F7F7FF734254FF084DB9FFB6B6B6FF5C4F0BFFC5C189FFB6B6B6FF2CC9
      6EFF8EF1ECFFB6B6B6FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFDFD
      FDFFFCFDFDFFFCFCFCFFFCFCFCFFFBFCFCFFFAFAFAFFF9FAFAFFF9F9F9FFF8F9
      F9FFFCFDFDFFDFDFDFFF0000000000000000B8F5FDFFAEF3FCFFAAF4FCFFA6F1
      FAFFA2EFF9FF9FEFF8FF9BEDF8FF96EAF7FFA4EDF7FF4FB9F4FF1297EAFF0DA4
      F7FF77C3F5FF079AF1FFE4F1FAFF0000000000000000000000009FDDEEFFB5F3
      FDFFADF5FCFFA7F2FAFFA3F0FAFFA0EFF9FF9DEEF8FF98ECF7FF94EAF7FF8FE7
      F6FF91E7F6FF9AEAF6FF0000000000000000B8F5FDFFAEF3FCFFAAF4FCFFA6F1
      FAFFF7F7F7FFFFFFFFFFFFFFFFFFD7D7D7FFFFFFFFFFFFFFFFFFD7D7D7FFFFFF
      FFFFFFFFFFFFD7D7D7FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFDFD
      FDFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFAFAFAFFF9FAFAFFCECE
      CEFFB7B7B7FFE4E4E4FF0000000000000000BDF6FEFFB1F4FDFFAEF6FDFFABF4
      FCFFA7F2FAFFA3F0FAFF9FEFF9FF9DEEF8FFBFF2FAFF8FD8F7FF1BADF7FF07B7
      FFFF06ADFFFF65BBF4FFF4F9FDFF000000000000000000000000A2DFEFFFB8F4
      FEFFB1F7FDFFADF5FCFFAAF4FCFFA6F1FAFFA1EFF9FF9EEEF8FF99EDF7FF96EA
      F7FF97E9F7FF9FECF7FF0000000000000000BDF6FEFFB1F4FDFFAEF6FDFFABF4
      FCFFF7F7F7FFFFFFFFFFFFFFFFFFB6B6B6FFFFFFFFFFFFFFFFFFB6B6B6FFFFFF
      FFFFFFFFFFFFB6B6B6FF97918FFFF2F2F2FF0000000000000000D6D6D6FFFDFD
      FDFFFDFDFDFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFAFAFAFFF5F5F5FFE2E2
      E2FFAEAEAEFFFCFCFCFF0000000000000000BFF7FFFFB6F5FEFFB3F7FEFFAFF7
      FDFFADF5FCFFA8F4FCFFA6F1FAFFA4EFF9FF1D9BEEFF15A6F7FF17CAFFFF08C3
      FFFF07B8FFFF0BA4FCFF1298EFFF89CBF2FF0000000000000000A6E1F1FFB9F6
      FEFFB5F7FEFFB1F7FDFFAEF6FDFFABF4FCFFA7F2FAFFA4F0F9FF9FEFF9FF9CED
      F8FF9DECF7FFA5EEF8FF0000000000000000BFF7FFFFB6F5FEFFB3F7FEFFAFF7
      FDFFF7F7F7FFF6C786FFF9F0C2FFC7C7C7FF88A8A6FFFEC58FFFC7C7C7FF0020
      91FFF4FEEDFFC7C7C7FF97918FFFF2F2F2FF0000000000000000D6D6D6FFECE9
      E9FFF1EFEFFFECE9E9FFF1EFEFFFECE9E9FFF1EFEFFFFCFCFCFFE4E4E4FFB3B3
      B3FFFCFCFCFF000000000000000000000000BFF7FFFFB8F6FFFFB7F8FEFFB5F7
      FEFFB1F7FDFFAFF6FDFFACF4FCFFAAF2FAFFC7F6FCFFB1EAFAFF2DC7FFFF37D2
      FFFF28BCF8FF2FA9EFFF00000000000000000000000000000000A7E5F4FFBDF7
      FFFFB8F9FFFFB6F8FEFFB3F7FEFFAFF6FDFFADF5FCFFABF3FCFFA7F1FAFFA2EF
      F9FFA2EFF9FFAAEFF9FF0000000000000000BFF7FFFFB8F6FFFFB7F8FEFFB5F7
      FEFFCDCCCAFFCDCCCAFFCDCCCAFFCDCCCAFFCDCCCAFFCDCCCAFFCDCCCAFFCDCC
      CAFFCDCCCAFFCDCCCAFF97918FFFF8F8F8FF0000000000000000D6D6D6FFECE9
      E9FFF2EFEFFFECE9E9FFF2EFEFFFECE9E9FFF2EFEFFFDCDCDCFFAEACACFFFBFB
      FBFF00000000000000000000000000000000C0F7FFFFBEF7FFFFBFFCFFFFBEFB
      FFFFBCFAFEFFB9F8FEFFB7F7FDFFB4F6FCFFBDF7FCFF0A94EEFFAFE6FAFF2CAE
      F7FFBEE2F8FF54B5F3FFA2D6F4FF000000000000000000000000A9E6F5FFBFF7
      FFFFC0FCFFFFBFFBFFFFBDF9FEFFBBF8FEFFB8F7FDFFB5F7FDFFB2F5FCFFAFF4
      FCFFAFF3FAFFB2F2FAFF0000000000000000C0F7FFFFBEF7FFFFBFFCFFFFBEFB
      FFFFBCFAFEFFB9F8FEFFB7F7FDFFB4F6FCFFB0F5FCFFAFF4FCFFB0F3FAFF9FDC
      EEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A9E6F500A9E6F5FFA9E6F5FFA9E6
      F5FFA8E5F4FFA7E4F4FFA6E3F2FFA6E2F2FFA6E1F1FFA7E1F0FFB6E7F4FF1F9C
      EFFFF7FBFEFF0000000000000000000000000000000000000000C5EDF7FFA9E6
      F5FFA9E6F5FFA9E6F5FFA8E5F5FFA8E5F4FFA7E4F4FFA6E2F2FFA6E2F1FFA4E1
      F1FFA4E0F0FFA3DFEFFF0000000000000000A9E6F5FFA9E6F5FFA9E6F5FFA9E6
      F5FFA8E5F4FFA7E4F4FFA6E3F2FFA6E2F2FFA6E1F1FFA5E0F0FFA2DFF0FFC4E9
      F5FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF000001C003000000000001C00300000000
      0001C003000000000001C003000000000001C003000000000001C00300000000
      0001C003000000000001C003000000000001C003000000000001C00300000000
      0001C003000000000001C003000000000001C003000000000001C00300000000
      FFFFC00300000000FFFFFE7F00000000FF8FF81FF81F801FFF03E007E007801F
      FE01C003C0038007FC0180018001800300000001000180030000000000008003
      0000000000008003000100000000800380010000000080038003000000008003
      800300000000800380030001000180038003800180018003800380038003E003
      8007C007C007F0078007F00FF00FF00F1FFFFFFFFFFFF00F0387FF198000E007
      0001F8010000C0038403800100018001C007000100010000F003000080010000
      F001000080010000E001000180010000E001000180010000E001000980010000
      E001801980010000E001FE0980010000E001FE0980018001E003FF098003C003
      F007FF498001E007F80FFF99FFFFF00FC003E000FFFFFFFFC003C000FFFD0000
      C0038000FFF90000C0030000FFF30000C0030000F8670000C0030000F00F0000
      C0030000F00F0000C0030000F00F0000C0030000F8070000C0038000F8070000
      C0034000F0070000C003A00080070000C007E000818F0000C01FE00083FF0000
      FFFFE001C3FF0000FFFFE003E3FFFFFFFFFF3FFFFFFFC003000300010003C003
      000100000001C003000080000000C0030007C0000000C0030007C0000000C003
      000700000000C003000700000000C003000FC0030000C0030001C0030000C003
      0001C0030000C0030001C0030000C0030000C0030000C0070003C0030000C00F
      0001C003000FFFFF0007C003000FFFFF00000000000000000000000000000000
      000000000000}
  end
  object IniConfig: TExtIniFile
    DefaultFolder = dfUser
    UpdateAtOnce = True
    Left = 28
    Top = 126
  end
  object PopupPasteTree: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 20
    Top = 214
    object D3: TMenuItem
      Action = ActCreateDir
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ActCopyDir1: TMenuItem
      Action = ActCopyDir
    end
    object ActCutDir1: TMenuItem
      Action = ActCutDir
    end
    object P7: TMenuItem
      Action = ActPaste
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object D2: TMenuItem
      Action = ActDeleteDir
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object S1: TMenuItem
      Caption = #20006#12409#26367#12360'(&S)'
      object ActSortTreeUser1: TMenuItem
        Action = ActSortTreeUser
      end
      object ActSortTreeName1: TMenuItem
        Action = ActSortTreeName
      end
      object ActSortTreeCr1: TMenuItem
        Action = ActSortTreeCr
      end
      object ActSortTreeUp1: TMenuItem
        Action = ActSortTreeUp
      end
      object ActSortTreeAc1: TMenuItem
        Action = ActSortTreeAc
      end
      object ActSortTreeUse1: TMenuItem
        Action = ActSortTreeUse
      end
      object ActSortTreeRep1: TMenuItem
        Action = ActSortTreeRep
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object ActSortTreeRevers1: TMenuItem
        Action = ActSortTreeRevers
        AutoCheck = True
      end
    end
    object R4: TMenuItem
      Action = ActReloadDir
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object P1: TMenuItem
      Action = ActEditDir
    end
  end
  object PopupLaunchTree: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 52
    Top = 214
    object D5: TMenuItem
      Action = ActCreateDir
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object D4: TMenuItem
      Action = ActDeleteDir
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object P2: TMenuItem
      Action = ActEditDir
    end
  end
  object PopupBkmkTree: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 84
    Top = 214
    object D7: TMenuItem
      Action = ActCreateDir
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object D6: TMenuItem
      Action = ActDeleteDir
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object P3: TMenuItem
      Action = ActEditDir
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 152
    Top = 48
  end
  object PopupAllSearchList: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 232
    Top = 110
  end
  object PopupPasteList: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 264
    Top = 110
    object P11: TMenuItem
      Action = ActSendPaste
    end
    object C4: TMenuItem
      Action = ActSendToClip
    end
    object N33: TMenuItem
      Caption = '-'
    end
    object N19: TMenuItem
      Caption = #34920#31034'(&V)'
      object ActDispListIcon1: TMenuItem
        Action = ActDispListIcon
      end
      object ActDispListSmallIcon1: TMenuItem
        Action = ActDispListSmallIcon
      end
      object ActDispListList1: TMenuItem
        Action = ActDispListList
      end
      object ActDispListReport1: TMenuItem
        Action = ActDispListReport
      end
    end
    object I1: TMenuItem
      Caption = #12450#12452#12467#12531#12398#25972#21015'(&I)'
      object ActSortListUser1: TMenuItem
        Action = ActSortListUser
        AutoCheck = True
      end
      object ActSortListName1: TMenuItem
        Action = ActSortListName
        AutoCheck = True
      end
      object ActSortListCr1: TMenuItem
        Action = ActSortListCr
        AutoCheck = True
      end
      object ActSortListUp1: TMenuItem
        Action = ActSortListUp
        AutoCheck = True
      end
      object ActSortListAc1: TMenuItem
        Action = ActSortListAc
        AutoCheck = True
      end
      object ActSortListUse1: TMenuItem
        Action = ActSortListUse
        AutoCheck = True
      end
      object ActSortListRep1: TMenuItem
        Action = ActSortListRep
        AutoCheck = True
      end
      object ActSortListParent1: TMenuItem
        Action = ActSortListParent
        AutoCheck = True
      end
      object ActSortListComment1: TMenuItem
        Action = ActSortListComment
        AutoCheck = True
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object ActSortListRevers1: TMenuItem
        Action = ActSortListRevers
        AutoCheck = True
      end
    end
    object R5: TMenuItem
      Action = ActReloadList
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Action = ActCreateItem
    end
    object B2: TMenuItem
      Action = ActAddBookMarks
    end
    object ActOpenLaunchDir2: TMenuItem
      Action = ActOpenLaunchDir
      Caption = #35242#12501#12457#12523#12480#12434#38283#12367'(&Q)'
    end
    object C1: TMenuItem
      Action = ActCopyItem
    end
    object T1: TMenuItem
      Action = ActCutItem
    end
    object P8: TMenuItem
      Action = ActPaste
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object ActDeleteItem1: TMenuItem
      Action = ActDeleteItem
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object ActEditItem1: TMenuItem
      Action = ActEditItem
    end
  end
  object PopupLaunchList: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 296
    Top = 110
    object N13: TMenuItem
      Action = ActCreateItem
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object ActOpenLaunchDir1: TMenuItem
      Action = ActOpenLaunchDir
    end
    object D11: TMenuItem
      Action = ActDeleteItem
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object P6: TMenuItem
      Action = ActEditItem
    end
  end
  object PopupBkmkList: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 328
    Top = 110
  end
  object PopupClipList: TPopupMenu
    Images = ImageListManu
    OnPopup = PopupItem
    Left = 360
    Top = 110
    object P12: TMenuItem
      Action = ActSendPaste
    end
    object C5: TMenuItem
      Action = ActSendToClip
    end
    object MenuItemEditText: TMenuItem
      Caption = #32232#38598#24460#36028#12426#20184#12369'(&E)'
      object N35: TMenuItem
        Caption = #25972#24418'(&T)'
        object ActTidyTrim1: TMenuItem
          Action = ActTidyTrim
        end
        object ActTidyTrimLeft1: TMenuItem
          Action = ActTidyTrimLeft
        end
        object ActTidyTrimRight1: TMenuItem
          Action = ActTidyTrimRight
        end
        object N38: TMenuItem
          Caption = '-'
        end
        object ActTidyDeleteEmptyLine1: TMenuItem
          Action = ActTidyDeleteEmptyLine
        end
        object N39: TMenuItem
          Caption = '-'
        end
        object ActTidySortAsc1: TMenuItem
          Action = ActTidySortAsc
        end
        object ActTidySortDesc1: TMenuItem
          Action = ActTidySortDesc
        end
      end
      object N36: TMenuItem
        Caption = #22793#25563'(&C)'
        object ActConvUpperToLower1: TMenuItem
          Action = ActConvUpperToLower
        end
        object B3: TMenuItem
          Action = ActConvLowerToUpper
        end
        object N40: TMenuItem
          Caption = '-'
        end
        object ActConvHanToZen1: TMenuItem
          Action = ActConvHanToZen
        end
        object ActConvZenToHan1: TMenuItem
          Action = ActConvZenToHan
        end
        object N41: TMenuItem
          Caption = '-'
        end
        object ActConvHiraToKana1: TMenuItem
          Action = ActConvHiraToKana
        end
        object ActConvKanaToHira1: TMenuItem
          Action = ActConvKanaToHira
        end
        object N42: TMenuItem
          Caption = '-'
        end
        object ActConvTabToSpace1: TMenuItem
          Action = ActConvTabToSpace
        end
        object ActConvSpaceToTab1: TMenuItem
          Action = ActConvSpaceToTab
        end
      end
      object MenuLineTops: TMenuItem
        Caption = #34892#38957'(&L)'
      end
      object MenuLineTopBottoms: TMenuItem
        Caption = #34892#12372#12392#12395#22258#12416'(&K)'
      end
    end
    object N34: TMenuItem
      Caption = '-'
    end
    object V1: TMenuItem
      Caption = #34920#31034'(&V)'
      object ActDispListIcon2: TMenuItem
        Action = ActDispListIcon
      end
      object ActDispListSmallIcon2: TMenuItem
        Action = ActDispListSmallIcon
      end
      object ActDispListList2: TMenuItem
        Action = ActDispListList
      end
      object ActDispListReport2: TMenuItem
        Action = ActDispListReport
      end
    end
    object I2: TMenuItem
      Caption = #12450#12452#12467#12531#12398#25972#21015'(&I)'
      object O3: TMenuItem
        Action = ActSortListUser
        AutoCheck = True
      end
      object ActSortListName2: TMenuItem
        Action = ActSortListName
        AutoCheck = True
      end
      object ActSortListCr2: TMenuItem
        Action = ActSortListCr
        AutoCheck = True
      end
      object ActSortListUp2: TMenuItem
        Action = ActSortListUp
        AutoCheck = True
      end
      object ActSortListAc2: TMenuItem
        Action = ActSortListAc
        AutoCheck = True
      end
      object ActSortListUse2: TMenuItem
        Action = ActSortListUse
        AutoCheck = True
      end
      object ActSortListRep2: TMenuItem
        Action = ActSortListRep
        AutoCheck = True
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object ActSortListComment2: TMenuItem
        Action = ActSortListRevers
        AutoCheck = True
      end
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object N26: TMenuItem
      Action = ActClipToPaste
    end
    object N24: TMenuItem
      Caption = '-'
    end
    object B1: TMenuItem
      Action = ActDeleteItem
    end
  end
  object ClipboardWatcher: TClipboardWatcher
    Enabled = False
    Chain = True
    OnChange = ClipboardWatcherChange
    Left = 148
    Top = 94
  end
  object DropFilesLaunch: TDropFiles
    TargetControl = ListViewLaunch
    OnDrop = DropFilesLaunchDrop
    Left = 84
    Top = 102
  end
  object DropTextPaste: TNkTextDropTarget
    OnTextDrop = DropTextPasteTextDrop
    Window = ListViewPaste
    Left = 52
    Top = 94
  end
  object DropTextBkmk: TNkTextDropTarget
    OnTextDrop = DropTextBkmkTextDrop
    Window = ListViewBkmk
    Left = 116
    Top = 102
  end
  object ImageListPasteMode: TImageList
    Left = 200
    Top = 370
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DBD4
      CEFFC5BDB4FFB9A99DFFDDDCDBFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFF7F7F7FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F6F6F6FFF0F0F0FFF0F0F0FFF7F7F7FF0000
      0000000000000000000000000000000000000000000000000000B7AFA7FFC1AA
      92FFAC947CFFCAA887FF826F55FFD0CBC8FFF7F8F8FFF6F7F7FFF6F7F7FFF6F7
      F7FFF6F7F7FFF5F6F6FFF5F6F6FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEE89CFFFBC50DFFFBC2
      08FFFFC806FFD3AF46FF788945FF849B58FFC17F56FFBE995EFF8E8A7FFFBBBB
      BBFFD3D3D3FFFAFAFAFF000000000000000000000000E5DED8FFE7DACBFFD3C0
      B2FFCABBA8FFCBBA9DFFCFBD9EFFF4E8C8FF9D9D9BFFF1F2F2FFF6F7F7FFF6F7
      F7FFF6F7F7FFF6F7F7FFF5F6F6FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F7FFDADADAFFE0E0
      E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0
      E0FFDDDDDDFFEFEFEFFF0000000000000000FDCE4EFFFCBE2DFFFDD75EFFFFD2
      36FFFFD51EFFFFD89AFFFFDFC3FFFFDE8EFFE2E897FFD2B19BFFC3965BFFC59D
      5FFFE9E9E9FFFBFBFBFF0000000000000000EFECE9FFDECEBDFFE2D5C3FFFAEB
      D2FFB2B1ADFFDAC8ADFFD5CCB7FF907C62FFF8F8F8FFE2E3E3FFF7F8F8FFF7F7
      F7FFF6F7F7FFF6F7F7FFF6F7F7FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDD1ACFFF0DBBBFFF2D9
      B3FFF4D7ACFFF6D5A3FFF7D299FFF9CE8FFFFACC86FFFBCA7CFFFDC671FFFEC5
      6AFFFFC262FFE1D9CFFF0000000000000000FBB931FF0000000000000000833F
      3CFF9C454DFF38882AFFF3D35AFFFFE3B1FFFFF1F2FFFFF1D7FFF1E1D3FFA86B
      49FFDBB391FF000000000000000000000000EFEFEBFFEDD9CBFFCABEA3FFFAFA
      FAFFF1F1F1FFF9FAFAFFF3E3C4FFDDCFB7FF7A684EFFF8F8F8FFF7F8F8FFF7F8
      F8FFF7F7F7FFF6F7F7FFF6F7F7FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBF3E9FFE6AA62FFE0B475FFFBFB
      FBFFFBFBFBFFFBFBFBFFFBFBFBFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFF9F9
      F9FFEEB055FFE1B37AFFFCFCFCFF00000000FAB81FFF00000000C19B93FF812B
      1EFF56601EFF0C7104FF0B950CFF7ACC8DFFFFE5ACFFFFFAD6FFFFFFFEFFA864
      53FF8E482EFFFEFDFCFF0000000000000000BFA08BFFF5D9C5FF93745AFFFAFB
      FBFFFAFAFAFFFAFAFAFFF6DCBBFFECE8DAFFCBB8A7FFF7F9F9FFF8F8F8FFF7F8
      F8FFF7F8F8FFF7F8F8FFF6F7F7FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAEAD8FFEBB575FFD5AA60FFFCFC
      FCFFF7C67DFFF5C276FFF2BB6DFFEEB361FFEAAB56FFE6A24AFFE29A3EFFF6E5
      D1FFD69B43FFE8A24AFFF4F4F4FF00000000FDDB74FFFFE88BFF6A1D14FF882A
      20FF875E30FF6B8435FFB86B40FFC26036FFBC5D39FFBE5E4DFFC06C63FFA136
      28FFA85A26FF987366FF0000000000000000D0B8A2FFAF977FFF8D6549FFFBFB
      FBFFFAFBFBFFEAE2D9FFF7F4E9FFEBE3D1FFDEDDDCFFF9F9F9FFF7F9F9FFF7F9
      F9FFF7F8F8FFF7F8F8FFF7F8F8FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAE9D5FFF8E2C8FFE6CDA7FFF9F1
      E6FFF9D6A4FFFBE5C4FFF8DCB0FFF7D39AFFF5C983FFF3BE6BFFF2B758FFE6A5
      52FFE0BD86FFF7B75AFFEAEAEAFF0000000000000000FFCF2AFF601415FF6158
      23FFCB5D2AFFB19246FFD29333FFD49639FFCF8A3EFFC67442FFBD5F46FFA546
      2CFF009738FFEBB902FF0000000000000000FCFAF9FFF2E5D3FFEBD5C7FFB5A6
      9DFFBAADA4FFEDE3D7FFF9F5F1FFCCC1AAFFAA9987FFF9FAFAFFF9F9F9FFF7F9
      F9FFF7F9F9FFF8F8F8FFF7F8F8FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E9C28DFFE7C5
      93FFFDFCFBFFF9E4C3FFF9EFE5FFFEF8F0FFFDF7EBFFFDF5E9FFF7E7D6FFE297
      39FFF8F6F3FFFCC165FFE1D3C1FF0000000000000000000000006F191FFF9150
      32FFC28B37FFE5B73BFFE8C84BFFE7C548FFDEB141FFD19349FFC3744BFF9D70
      49FF46D083FF57B456FFFDBE07FF00000000DFD7CFFFD2B9A3FFE5CEBDFFE8DC
      D0FFDACDBBFFE6D9CAFFAA9A79FFFAFBFBFFFAFAFAFFFAFAFAFFF9FAFAFFF9F9
      F9FFF7F9F9FFF7F9F9FFF8F8F8FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FBEEDEFFF7DFC2FFE8BB75FFD7B3
      6FFFFDFDFDFFF6CB8AFFD39F83FFFEF9F1FFFEF7EEFFFDF6EAFFFDF4E6FFE1A1
      55FFFBFBFBFFE4C58DFFE6C28BFFFBFBFBFF0000000000000000822417FF1FAF
      1FFF2ABF33FFF6DE64FFFBF386FFF9ED76FFECD260FFD8A753FFC78152FFC24C
      32FF47DB98FFAEBB98FFFFFBEFFFFEEFBDFF00000000FAF7F6FFEBC8B4FFD5C7
      B5FFE0D3C5FFBEAD93FFB09B81FFFAFAFAFFFAFBFBFFFAFAFAFFFAFAFAFFF9FA
      FAFFF9F9F9FFF7F9F9FFF7F9F9FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7EAD4FFE9D5
      B1FFFDFCFCFFF8DDB1FFFCEBD2FFF0D1A9FFEEC692FFEDBE81FFECBB7BFFF5C8
      7FFFF2D3ABFFD8AD65FFEDBB6EFFF4F4F4FF0000000000000000E6CDC5FF23DE
      37FF33CC46FF93EFCBFFF1F9CDFFFFFFB3FFF7E367FFDCB25EFFCA8957FF86C5
      7CFF7E6F4FFF0000000000000000F9BD00FFFEFEFEFF00000000EAE8E3FFFBFA
      FAFFB3A693FFFCFCFCFFFCFCFCFFFBFCFCFFFBFBFBFFFAFBFBFFFAFBFBFFFAFA
      FAFFF9FAFAFFF9FAFAFFF9F9F9FFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAEBD9FFF8E3C9FFF5D4ADFFF2E0
      C5FFF4E6D0FFFEFEFEFFFEFEFEFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFC
      FCFFFCFCFCFFF1E2C9FFFAD193FFF3F3F3FF0000000000000000000000006289
      1EFF38CF53FF7CDDA6FFB1F7E7FFE9EFA4FFF9E562FFDCB064FFCA895AFF61D5
      7AFFC9C584FF00000000FFF9E6FFFCCF42FF00000000FEFEFEFF00000000FDFD
      FDFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFBFCFCFFFBFBFBFFFBFBFBFFFAFB
      FBFFFAFAFAFFF9FAFAFFF9FAFAFFDFDFDFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCF4EAFFFCF2E6FFFAE9D7FFE9C1
      84FFF7EDDFFFFAEFE1FFF8E9D3FFF6E0BEFFF7D7A8FFF7D297FFFAD194FFFBD6
      9CFFFDDDADFFFEE5C0FFFFE7C1FFF7E9D3FF0000000000000000000000000000
      000054B436FF5BD36FFFB4CC72FFE8D569FFE8DDB6FFCAB66BFFCCAF72FFA4B6
      4FFFFFD139FFF8C320FFFBCD3EFF00000000000000000000000000000000FDFD
      FDFFFDFDFDFFFDFDFDFFFCFDFDFFFCFCFCFFFCFCFCFFFBFCFCFFFBFBFBFFFBFB
      FBFFFAFBFBFFCECECEFFB8B8B8FFE4E4E4FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFBF9FFC8D6A6FFB8D2ACFFC6AC7CFFE1B080FF000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFDFDFFFCFCFCFFFCFCFCFFFBFCFCFFFBFB
      FBFFF5F5F5FFE3E3E3FFAEAEAEFFFCFCFCFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFE
      FEFFC4BFBFFFFDFDFDFFC4BFBFFFFCFCFCFFC4BFBFFFFCFCFCFFC4BFBFFFFCFC
      FCFFE4E4E4FFB3B3B3FFFCFCFCFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFE
      FEFFC4BFBFFFFDFDFDFFC4BFBFFFFDFDFDFFC4BFBFFFFCFCFCFFC4BFBFFFDCDC
      DCFFB3B3B3FFFBFBFBFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F1F1F1FFECECECFFECECECFFECECECFFECECECFFECECECFFECEC
      ECFFECECECFFECECECFFFAFAFAFF000000000000000000000000000000000000
      0000F1F1F1FFECECECFFECECECFFECECECFFECECECFFECECECFFECECECFFECEC
      ECFFECECECFFECECECFFFAFAFAFF000000000000000000000000D8D8D8FFDFDF
      DFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDF
      DFFFDFDFDFFFF7F7F7FF00000000000000000000000000000000000000000000
      0000EEEEEEFFE5E5E5FFD5D5D5FFC8C8C8FFC6C6C6FFD1D1D1FFE2E2E2FFEDED
      EDFFF4F4F4FF0000000000000000000000000000000000000000000000000000
      000000000000949494FF878787FF878787FF878787FF878787FF878787FF8787
      87FF878787FF878787FFECECECFF000000000000000000000000000000000000
      00008F8F8FFF878787FF878787FF878787FF878787FF878787FF878787FF8787
      87FF878787FF878787FFECECECFF000000000000000000000000D6D6D6FFF7F7
      F7FFF6F7F7FFF6F6F7FFF6F6F7FFF5F6F7FFF5F6F7FFF5F6F7FFF4F6F7FFF5F6
      F6FFF4F6F6FFDFDFDFFF00000000000000000000000000000000F5F5F5FFEBEB
      EBFFCAC9C9FFBAB7B4FFC2BCB7FFC3BDB7FFB7B3AFFFA8A7A6FFA9A9A9FFC0C0
      C0FFE6E6E6FFF3F3F3FF00000000000000000000000000000000000000000000
      000000000000FFFFFFFFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9
      F9FFFBFBFBFF878787FFECECECFF0000000000000000FAFAFAFFECECECFFECEC
      ECFFFFFFFFFFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9
      F9FFFBFBFBFF878787FFECECECFF000000000000000000000000D6D6D6FFF7F7
      F7FFD2C7C7FFD2C7C7FFD2C7C7FFD2C7C7FFD2C7C7FFD2C7C7FFD2C7C7FFF5F5
      F7FFF4F6F7FFDFDFDFFF000000000000000000000000F5F5F5FFE9E9E8FFD2C5
      B6FFD79E65FFCE7C29FFC8690AFFC8690AFFCE7C29FFD99F66FFD2C3B3FFAAA9
      A8FFB2B2B2FFE2E2E2FFF3F3F3FF0000000000000000D5D5D5FFC5C5C5FFC5C5
      C5FFC5C5C5FFFFFFFFFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFA
      FAFFFBFBFBFF878787FFECECECFF0000000000000000B1B1B1FFA5A5A5FFA5A5
      A5FFFFFFFFFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFA
      FAFFFBFBFBFF878787FFECECECFF000000000000000000000000D6D6D6FFF7F8
      F8FFF8F9F9FFD2C7C7FFECE7E7FFB17C49FFC09467FFC79D79FFD4B399FFF5F5
      F7FFF5F6F7FFDFDFDFFF000000000000000000000000ECEBEAFFDBB691FFC96D
      11FFDA9D61FFEBCCAEFFF3E5D6FFF3E5D6FFEBCCAEFFDA9D61FFC96D11FFDEB7
      91FFAFADAAFFB2B2B2FFE6E6E6FFF4F4F4FF0000000095CAE3FF95CAE3FF94C9
      E3FF93C8E3FFFFFFFFFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFDFDFDFF878787FFECECECFF0000000000000000B6B6B6FFF7F7F7FFF7F7
      F7FFFFFFFFFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
      FBFFFCFCFCFF878787FFECECECFF000000000000000000000000D6D6D6FFF7F8
      F9FFF9F9F9FFF8F8F8FFF7F8F8FF5C6B4BFFA7AD89FFD0C5A2FFE6E4CDFFF5F6
      F7FFF5F6F7FFDFDFDFFF0000000000000000EFEFEFFFDCB793FFCB7117FFEBCE
      B1FFF6EBE0FFF6EBE1FFF6EBE1FFF6EBE1FFF6EBE1FFF6EBE0FFEBCFB2FFCB71
      18FFDEB791FFAAA9A8FFC0C0C0FFEDEDEDFF0000000099CBE3FF4EA5CEFF4CA5
      CEFF4BA4CEFFFFFFFFFFFEFEFEFFDBCDBFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCD
      BFFFFEFEFEFF878787FFECECECFF0000000000000000B6B6B6FFFAFAFAFFFAFA
      FAFFFFFFFFFFFDFDFDFFDBCDBFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCD
      BFFFFEFEFEFF878787FFECECECFF000000000000000000000000D6D6D6FFF8F8
      F9FFF9FAFAFFF8F9F9FFF8F9F9FFFFCE9FFFFFC99EFFFED8B1FFFED4A6FFF6F6
      F7FFF5F6F7FFDFDFDFFF0000000000000000E9DFD4FFC96D10FFEBCEB0FFF6EB
      E0FFF6EBE1FFF6EBE1FFF6EBE1FFF6EBE1FFF6EBE1FFF6EBE1FFF6EBE0FFEBCE
      B1FFC96D11FFD3C3B6FFA9A9A9FFE2E2E2FF000000009CCDE3FF53A8CFFF52A7
      CFFF50A6CFFFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFF878787FFECECECFF0000000000000000B6B6B6FFFBFBFBFFFBFB
      FBFFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFF878787FFECECECFF000000000000000000000000D6D6D6FFF9F9
      FAFFFAFAFAFFF9F9F9FFF8F9F9FFF8F9F9FFF8F8F8FFF7F8F8FFF7F8F8FFF6F7
      F7FFF6F6F7FFDFDFDFFF0000000000000000D8A066FFDA9C5EFFF5E9DDFFF6EA
      DFFFF6EADFFFC6B7A9FFF3E7DCFFF6EADFFFF6EADFFFF6EADFFFF6EADFFFF5EA
      DEFFDA9C5FFFD89E64FFA8A7A6FFD1D1D1FF000000009FCEE3FF58AACFFF56A9
      CFFF55A9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF878787FFECECECFF0000000000000000B6B6B6FFFDFDFDFFDBCD
      BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF878787FFECECECFF000000000000000000000000D6D6D6FFFAFA
      FAFFFAFAFAFFF9FAFAFFF9F9F9FFF9F9F9FFF8F9F9FFF8F8F8FFF7F8F8FFF7F7
      F8FFF6F7F7FFDFDFDFFF0000000000000000CD7A27FFE9C8A8FFF4E7DAFFF4E7
      DAFFF4E7DBFFC86C12FFAA6D31FFB7A492FFECDFD4FFF4E7DBFFF4E7DBFFF4E7
      DAFFE9C9A9FFCE7B28FFB7B3AFFFC7C7C7FF00000000A1CFE4FF5CACD0FF5BAB
      D0FF59ABCFFFFFFFFFFFFFFFFFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCD
      BFFFFFFFFFFF878787FFECECECFF0000000000000000B6B6B6FFFEFEFEFFFEFE
      FEFFFFFFFFFFFFFFFFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCDBFFFDBCD
      BFFFFFFFFFFF878787FFECECECFF000000000000000000000000D6D6D6FFF9F9
      FAFFC1BD88FFB0AB66FF9E973FFF908821FF908B24FF979032FF9F9B46FFF7F7
      F7FFF7F7F8FFDFDFDFFF0000000000000000C8690AFFF1E0CEFFF3E6D8FFF3E6
      D8FFF3E6D8FFC96B0EFFC96C10FFC86B0EFFB1671EFFAB9178FFE5D8CAFFF3E6
      D8FFF1E0CEFFC8690AFFC2BCB6FFC8C8C8FF00000000A3D0E4FF60AED0FF5EAD
      D0FF5DACD0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF0F0F0FFB5B5B5FFF2F2F2FF0000000000000000B6B6B6FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF878787FFECECECFF000000000000000000000000D6D6D6FFFBFB
      FCFFF9DFE0FFD8716FFFF8F9F9FFF8AEADFFF8AEADFFF8F9F9FFF8F8F9FFF7F7
      F9FFF7F7F8FFDFDFDFFF0000000000000000C8690AFFF2E2D2FFF5E8DCFFF5E8
      DCFFF5E8DCFFCB7016FFCB7016FFCA7016FFCA7015FFB97938FFCFBDABFFF5E8
      DCFFF2E2D2FFC8690AFFC3BEB9FFD5D5D5FF00000000A5D1E4FF63AFD0FF62AF
      D0FF60AED0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF1F1F1FFE5E5E5FF000000000000000000000000B6B6B6FFFFFFFFFFDBCD
      BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFB5B5B5FFEDEDEDFF000000000000000000000000D6D6D6FFFBFB
      FCFFF9AFAFFFEF5E5EFFFEFEFEFFF8AEADFFFDFDFDFFFFFFFFFFF7F8F9FFCECE
      CEFFB7B7B7FFE4E4E4FF0000000000000000CD7A27FFEBCDAFFFF6EBE0FFF6EB
      E0FFF6EBE0FFD18132FFCF8032FFBE8954FFD4C3B1FFF4E9DEFFF6EBE0FFF6EB
      E0FFEBCDAFFFCF7C2AFFBBB9B7FFE5E5E5FF00000000A6D2E4FF65B0D0FF64B0
      D0FF62AFD0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FFF1F1
      F1FFE5E5E5FF00000000000000000000000000000000B6B6B6FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECEC
      ECFFD1D1D1FFBABABAFFFAFAFAFF000000000000000000000000D6D6D6FFFCFB
      FDFFFBFFFFFFF84B4BFFFEFEFEFFF8AEADFFF9F9FAFFF8F9F9FFF5F5F5FFE2E2
      E2FFAEAEAEFFFCFCFCFF0000000000000000DBA46FFFDB9F64FFF7EDE4FFF7ED
      E4FFF7EDE4FFC2986FFFDBCDC0FFF6ECE3FFF7EDE4FFF7EDE4FFF7EDE4FFF7ED
      E4FFDB9F64FFD9A26AFFCACAC9FFEEEEEEFF00000000A7D2E4FF67B1D1FF66B1
      D1FF64B0D0FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFE1E1
      E1FF0000000000000000000000000000000000000000B6B6B6FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1
      F1FFBABABAFFFAFAFAFF00000000000000000000000000000000D6D6D6FFFCFC
      FCFFFBFBFCFFFBFCFCFFFBFBFCFFFBFAFCFFF9FAFAFFF9F9FAFFE4E4E4FFB3B3
      B3FFFCFCFCFF000000000000000000000000F3ECE4FFC96D11FFEED3B9FFF8F0
      E8FFF8F0E8FFF7EFE7FFF8F0E8FFF8F0E8FFF8F0E8FFF8F0E8FFF8F0E8FFEED3
      B9FFC96E12FFD4CBC1FFEBEBEBFF0000000000000000A8D2E4FF69B2D1FF68B1
      D1FF488FB0FF387A9CFF2B6A8DFF225F83FF5AABCFFF55A9CFFF2C537AFFECEC
      ECFF0000000000000000000000000000000000000000B6B6B6FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAFFBCBC
      BCFFFAFAFAFF0000000000000000000000000000000000000000D6D6D6FFFCFC
      FDFFFCFCFDFFFBFCFDFFFBFCFDFFFBFBFDFFFAFBFCFFDCDCDCFFB3B3B3FFFBFB
      FBFF0000000000000000000000000000000000000000E7C7A7FFCB7219FFEED5
      BCFFF9F2ECFFF9F2ECFFF9F2ECFFF9F2ECFFF9F2ECFFF9F2ECFFEED5BCFFCB72
      19FFDDBC9BFFE8E8E8FFF5F5F5FF0000000000000000A9D3E4FF6AB2D1FF69B2
      D1FF8E8E8EFF8E8E8EFF8E8E8EFF656565FF5BABD0FF82C0DCFF2C547BFFECEC
      ECFF0000000000000000000000000000000000000000B6B6B6FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAFFC3C3C3FFE5E5E5FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C7A8FFC96E
      12FFDCA369FFEED5BCFFF7EEE5FFF7EEE5FFEED5BCFFDCA369FFCA6E12FFE0C1
      A0FFECECEBFFF5F5F5FF0000000000000000000000003184B3FF3184B3FF3184
      B3FFC2C2C2FFC2C2C2FFC2C2C2FF939393FF3184B3FF3184B3FF3B769FFFFAFA
      FAFF0000000000000000000000000000000000000000B6B6B6FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3FFE5E5E5FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3EA
      E2FFDDA873FFCD7C2AFFC8690BFFC8690BFFCF7D2CFFDCA772FFEAE2D8FFEFEF
      EFFF00000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFE0000000FFFFFE1FC0000000
      FFFF800380000000800300030000000080036007000000000001400300000000
      00010003000000000001800300000000C001C001000000000000C00080000000
      C000C006400000000000E004A00000000000F001E0000000FFFFF83FE0000000
      FFFFFFFFE0010000FFFFFFFFE0030000F801F001C003F007F801F001C003C003
      F8018001C003800180018001C003800080018001C003000080018001C0030000
      80018001C003000080018001C003000080018001C003000080018001C0030000
      80038001C003000080078001C0030000800F8003C0070001800F8007C00F8001
      800F801FFFFFC003800F803FFFFFE00F00000000000000000000000000000000
      000000000000}
  end
  object TimerGetForground: TTimer
    Interval = 100
    OnTimer = TimerGetForgroundTimer
    Left = 148
    Top = 118
  end
  object ActionListShorteCut: TActionList
    Left = 116
    Top = 134
  end
  object XPManifest1: TXPManifest
    Left = 80
    Top = 37
  end
  object TaskTrayIcon: TTHTaskTrayIcon
    Enabled = True
    OnClick = TaskTrayIconClick
    Left = 84
    Top = 118
  end
  object PopupTask: TPopupMenu
    Left = 92
    Top = 158
    object D12: TMenuItem
      Action = ActDisplay
    end
    object N37: TMenuItem
      Caption = '-'
    end
    object P13: TMenuItem
      Action = ActOption
    end
    object N44: TMenuItem
      Caption = '-'
    end
    object Q2: TMenuItem
      Action = ActClose
    end
  end
  object XMLDoc: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 124
    Top = 214
    DOMVendorDesc = 'MSXML'
  end
  object Progress: TProgress
    Left = 156
    Top = 214
  end
  object XmlSaveDialog: TSaveDialog
    DefaultExt = 'xml'
    Filter = 'XML'#12501#12449#12452#12523'(*.xml)|*.xml|'#12377#12409#12390#12398#12501#12449#12452#12523'(*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 124
    Top = 246
  end
  object XmlOpenDialog: TOpenDialog
    DefaultExt = 'xml'
    Filter = 'XML'#12501#12449#12452#12523'(*.xml)|*.xml|'#12377#12409#12390#12398#12501#12449#12452#12523'(*.*)|*.*'
    Left = 156
    Top = 246
  end
  object ImageListTask: TImageList
    Left = 60
    Top = 158
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000034547D0014488A0067A5
      EC001E4C86000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000112D00000936001E48
      7900000C33000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001F4E8600467AB6004DA4E7002D99E0008EFCFF007EFD
      FE008AFFFF00334E860000000000000000000000000000000000000000000000
      00000000000000000000000D3300082B54000D48750000407000398385002E84
      850036858500000D330000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002C4E7C00284D7F003165
      8D00369BE900379DE60064CDFE0075E0FF006EE9FD0079F6FA00BAFDFE0087FF
      FB00A3FFFF009DF4FE00284687000000000000000000000D2D00000D2F00001D
      380000427700004375001C64850028708500237784002B7F8200578485003485
      830047858500437E850000083400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000499CE0005FAFF60050A1E4004FA3
      E50059B9FB0061C6FD005FC0E4006EE1FC0075EFFF0078FFFD00BDFFFE008EFF
      FD00B1FFFF00AEFDFF00BCFDFE00000000000A427000194F7F000F4673000E47
      7400155683001A5F8400195B730023718300287B85002A858400598585003985
      8400518585004F84850058848500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000057B9F90050A1E40050A1E40061B7
      FD0055B0F30061C9FE0067D6FC006EE7FA0066D6FF00379EE700389EE600A2FE
      FF003D97D800C3FFFF00FAFEFF00E8FFE500145681000F4673000F4673001A55
      840012507D001A6185001E6A8300237582001E6A850000447500004475004685
      8500023F6B005D85850082858500768574000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000057B3FA0050A1E40056AFF9003499
      E700339FE60060C8FF006ADEFD006EE7FF0076F5FF00B3FFFE00BEFEFE00D0FE
      FF00E2FFF6003E9DDC00F5FDFC00D3F9FD00145282000F467300134F81000040
      7500004475001A608500206F840023758500297F850052858500598585006685
      850072857F0003436E007F848300688184000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000229DED004DA1E90050A1E40064AE
      EE0050A1E40066C3FB000F1CD2000C09CA000F0DE2001B2DB60094FFFD00D2FE
      FF00E7FEFF00E3FFFF00D2F7FF0057A4DD00004379000D4677000F4673001C4F
      7A000F4673001E5D8300000067000000620000007200000054003D8584006785
      850075858500738585006780850014486E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000060B3FE0051A0
      DF0051A2E50052A3E7000B10DD000E14F7000C0EEE005155FA0037A3D900339D
      F4003CA3E2006CB1EA00000000000000000000000000000000001A5285000F45
      70000F4674001047750000006E000000800000007A000F12820000476C000043
      7E00014772002251770084848500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000065BA
      E0003893EE0050B2E00000000000130EEB002224FA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001D57
      7000003C7A000F51700000000000000078000000820000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000518D5003938FC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000069000000830000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000F1AD600524DFC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000006A00100D830000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000818E0006565FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000070001D1D850000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000518CD002739F2000F16D7000D16D800A0A5FA002517D0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000640000007D0000006A0000006B0045488200000066000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000363BFC005053FB006E71FB008E8FFD00A9ACFD00C3C8FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000183000F11830023258300393A84004B4D84005D6085000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003B3FFC00575BFA00757AFB009A9BFD00BDBDFD00EAE8FE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000103830014168200282B83004142840059598400777685000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001A23E500807DF800ADA2FE00161EC900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000074002F2D81004E46850000006100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF87FF8700000000FC03FC0300000000
      8001800100000000000100010000000000000000000000000000000000000000
      0000000000000000C003C00100000000E27FE27F00000000FE7FFE7F00000000
      FE7FFE7F00000000FE7FFE7F00000000F81FF81F00000000F81FF81F00000000
      F81FF81F00000000FC3FFC3F0000000000000000000000000000000000000000
      000000000000}
  end
  object TimerAutoBackup: TTimer
    Interval = 600000
    OnTimer = TimerAutoBackupTimer
    Left = 20
    Top = 321
  end
  object TextDropTargetQuery: TNkTextDropTarget
    OnTextDrop = TextDropTargetQueryTextDrop
    Window = EditQuery
    Left = 528
    Top = 16
  end
  object TimerShowMouseCslRtn: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerShowMouseCslRtnTimer
    Left = 76
    Top = 428
  end
  object TimerMouseCslRtn: TTimer
    Interval = 50
    OnTimer = TimerMouseCslRtnTimer
    Left = 80
    Top = 392
  end
  object DropTextSourceClip: TDropTextSource
    DragTypes = [dtCopy]
    OnAfterDrop = DropTextSourceClipAfterDrop
    Left = 224
    Top = 263
  end
  object DropTextSourcePaste: TDropTextSource
    DragTypes = [dtCopy]
    OnAfterDrop = DropTextSourceClipAfterDrop
    Left = 192
    Top = 263
  end
  object TimerTextDrop: TTimer
    Interval = 100
    OnTimer = TimerTextDropTimer
    Left = 512
    Top = 271
  end
  object ClipboardViewerTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = ClipboardViewerTimerTimer
    Left = 140
    Top = 415
  end
  object AutoExpandTimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = AutoExpandTimerTimer
    Left = 12
    Top = 479
  end
end
