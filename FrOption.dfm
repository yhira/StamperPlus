object FormOption: TFormOption
  Left = 228
  Top = 229
  BorderStyle = bsDialog
  Caption = #12458#12503#12471#12519#12531#35373#23450
  ClientHeight = 390
  ClientWidth = 589
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 356
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    ParentColor = True
    TabOrder = 0
    object PageControl: TPageControl
      Left = 129
      Top = 5
      Width = 455
      Height = 346
      ActivePage = TabBasic
      Align = alClient
      TabOrder = 0
      OnChange = PageControlChange
      object TabBasic: TTabSheet
        Caption = #22522#26412#35373#23450
        object CheckAutoExpand: TCheckBox
          Left = 8
          Top = 8
          Width = 161
          Height = 17
          Hint = #12527#12531#12463#12522#12483#12463#12391#12484#12522#12540#12398#12501#12457#12523#12480#12434#38283#12365#12414#12377#12290
          Caption = #12458#12540#12488#12456#12461#12473#12497#12531#12489
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 240
          Width = 425
          Height = 73
          Caption = #38899#35373#23450
          TabOrder = 1
          object CheckUseSound: TCheckBox
            Left = 8
            Top = 16
            Width = 161
            Height = 17
            Hint = #12450#12452#12486#12512#12398#23455#34892#26178#12395#38899#12434#40180#12425#12377#12363#12393#12358#12363#12290
            Caption = #12450#12452#12486#12512#23455#34892#26178#38899#12434#40180#12425#12377
            TabOrder = 0
            OnClick = CheckUseSoundClick
          end
          object EditSoundFile: TEdit
            Left = 8
            Top = 40
            Width = 385
            Height = 20
            Hint = #38899#12501#12449#12452#12523#12497#12473#12398#35373#23450#12290
            TabOrder = 1
            Text = 'EditSoundFile'
          end
          object ButtonSoundFile: TButton
            Left = 392
            Top = 40
            Width = 20
            Height = 20
            Hint = #12480#12452#12450#12525#12464#12434#38283#12367#12290
            Caption = '...'
            TabOrder = 2
            OnClick = ButtonSoundFileClick
          end
        end
        object CheckBoxOneClickExcute: TCheckBox
          Left = 8
          Top = 32
          Width = 177
          Height = 17
          Hint = #12471#12531#12464#12523#12463#12522#12483#12463#12391#12450#12452#12486#12512#12395#38306#36899#20184#12369#12425#12428#12383#21205#20316#12434#23455#34892#12375#12414#12377#12290
          Caption = #12471#12531#12464#12523#12463#12522#12483#12463#12391#23455#34892#12377#12427
          TabOrder = 2
        end
        object gbPass: TGroupBox
          Left = 8
          Top = 192
          Width = 425
          Height = 41
          Caption = #31777#26131#12475#12461#12517#12522#12486#12451#12540#35373#23450
          TabOrder = 3
          object CheckIsPassword: TCheckBox
            Left = 8
            Top = 16
            Width = 193
            Height = 17
            Hint = #36215#21205#12497#12473#12527#12540#12489#12434#35373#23450#12377#12427#12392#12365#12399#12481#12455#12483#12463#12375#12390#12367#12384#12373#12356#12290
            Caption = #36215#21205#12497#12473#12527#12540#12489#35373#23450
            TabOrder = 0
            OnClick = CheckIsPasswordClick
            OnMouseUp = CheckIsPasswordMouseUp
          end
          object ButtonPassword: TButton
            Left = 344
            Top = 11
            Width = 75
            Height = 25
            Hint = #36215#21205#12497#12473#12527#12540#12489#12434#22793#26356#12375#12414#12377#12290
            Caption = #22793#26356
            Enabled = False
            TabOrder = 1
            OnClick = ButtonPasswordClick
          end
        end
        object CheckIsClipToDirName: TCheckBox
          Left = 8
          Top = 56
          Width = 297
          Height = 17
          Hint = #12501#12457#12523#12480#26032#35215#20316#25104#26178#12289#12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12501#12457#12523#12480#12479#12452#12488#12523#12395#12375#12414#12377#12290
          BiDiMode = bdLeftToRight
          Caption = #12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12501#12457#12523#12480#12479#12452#12488#12523#12395#12377#12427
          ParentBiDiMode = False
          TabOrder = 4
        end
        object CheckIsClipToPasteName: TCheckBox
          Left = 8
          Top = 80
          Width = 321
          Height = 17
          Hint = #12506#12540#12473#12488#12450#12452#12486#12512#26032#35215#20316#25104#26178#12289#12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12506#12540#12473#12488#12450#12452#12486#12512#12398#12479#12452#12488#12523#12395#12375#12414#12377#12290
          Caption = #12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12506#12540#12473#12488#12450#12452#12486#12512#12398#12479#12452#12488#12523#12395#12377#12427
          TabOrder = 5
        end
        object CheckIsClipToLauncherName: TCheckBox
          Left = 8
          Top = 104
          Width = 313
          Height = 17
          Hint = #12521#12531#12481#12515#12540#12450#12452#12486#12512#26032#35215#20316#25104#26178#12289#12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12521#12531#12481#12515#12540#12450#12452#12486#12512#12398#12479#12452#12488#12523#12395#12375#12414#12377#12290
          Caption = #12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12521#12531#12481#12515#12540#12450#12452#12486#12512#12398#12479#12452#12488#12523#12395#12377#12427
          TabOrder = 6
        end
        object CheckIsClipToBkmkName: TCheckBox
          Left = 8
          Top = 128
          Width = 369
          Height = 17
          Hint = #12502#12483#12463#12510#12540#12463#12450#12452#12486#12512#26032#35215#20316#25104#26178#12289#12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12502#12483#12463#12510#12540#12463#12450#12452#12486#12512#12398#12479#12452#12488#12523#12395#12375#12414#12377#12290
          Caption = #12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12502#12483#12463#12510#12540#12463#12450#12452#12486#12512#12398#12479#12452#12488#12523#12395#12377#12427
          TabOrder = 7
        end
        object CheckIsClipToPasteTexs: TCheckBox
          Left = 8
          Top = 152
          Width = 353
          Height = 17
          Hint = #12506#12540#12473#12488#12450#12452#12486#12512#26032#35215#20316#25104#26178#12289#12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12506#12540#12473#12488#12450#12452#12486#12512#12398#26412#25991#12395#12375#12414#12377#12290
          Caption = #12463#12522#12483#12503#12508#12540#12489#25991#23383#21015#12434#12506#12540#12473#12488#12450#12452#12486#12512#12398#26412#25991#12395#12377#12427
          TabOrder = 8
        end
        object CheckIsStartup: TCheckBox
          Left = 200
          Top = 8
          Width = 177
          Height = 17
          Hint = 'Windows '#36215#21205#26178#12371#12398#12450#12503#12522#12434#36215#21205#12377#12427#12363#12393#12358#12363#12434#25351#23450#12375#12414#12377#12290
          Caption = #12473#12479#12540#12488#12450#12483#12503#12395#30331#37682#12377#12427
          TabOrder = 9
        end
      end
      object TabEdit: TTabSheet
        Caption = #32232#38598
        ImageIndex = 7
        object Label2: TLabel
          Left = 8
          Top = 16
          Width = 89
          Height = 12
          Caption = #12479#12502#12398#12473#12506#12540#12473#25968
        end
        object SpinEditTabSpaceCount: TSpinEdit
          Left = 104
          Top = 16
          Width = 41
          Height = 21
          Hint = #12479#12502#12434#12473#12506#12540#12473#12395#22793#25563#12375#12383#12392#12365#12398#12473#12506#12540#12473#25968#12290
          Increment = 2
          MaxValue = 16
          MinValue = 2
          TabOrder = 0
          Value = 2
        end
        object TGroupBox
          Left = 0
          Top = 88
          Width = 153
          Height = 209
          Caption = #34892#38957#25407#20837#25991#23383
          TabOrder = 1
          object LabelLineTop: TLabel
            Left = 2
            Top = 14
            Width = 149
            Height = 27
            Align = alTop
            AutoSize = False
            Caption = 'LabelLineTop'
            Color = clBtnFace
            ParentColor = False
            Layout = tlCenter
          end
          inline FrameInputLineTop: TFrameInput
            Left = 8
            Top = 40
            Width = 138
            Height = 169
            TabOrder = 0
            inherited ListBox: TListBox
              Left = 0
              OnClick = FrameInput1ListBoxClick
            end
            inherited Edit: TEdit
              Left = 0
            end
            inherited ButtonAdd: TButton
              OnClick = FrameInputLineHeadButtonAddClick
            end
            inherited ButtonChange: TButton
              OnClick = FrameInputLineHeadButtonChangeClick
            end
            inherited ButtonDelete: TButton
              OnClick = FrameInputLineHeadButtonDeleteClick
            end
          end
        end
        object TGroupBox
          Left = 160
          Top = 88
          Width = 153
          Height = 209
          Caption = #22258#12415#25991#23383
          TabOrder = 2
          object LabelLineTopBottom: TLabel
            Left = 2
            Top = 14
            Width = 149
            Height = 27
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'LabelLineTopBottom'
            Color = clBtnFace
            ParentColor = False
            Layout = tlCenter
          end
          inline FrameInputLineTopBottom: TFrameInput2
            Left = 7
            Top = 37
            Width = 138
            Height = 172
            TabOrder = 0
            inherited ButtonAdd: TButton
              OnClick = FrameInputLineTopBottomButtonAddClick
            end
            inherited ButtonChange: TButton
              OnClick = FrameInputLineTopBottomButtonChangeClick
            end
            inherited ButtonDelete: TButton
              OnClick = FrameInputLineTopBottomButtonDeleteClick
            end
            inherited StringGrid: TStringGrid
              OnClick = FrameInputLineTopBottomStringGridClick
            end
          end
        end
      end
      object TabPath: TTabSheet
        Caption = #12497#12473
        ImageIndex = -1
        object CheckUseBrowser: TCheckBox
          Left = 8
          Top = 16
          Width = 97
          Height = 17
          Hint = #12502#12483#12463#12510#12540#12463#12434#38283#12367#12502#12521#12454#12470#12434#25351#23450#12377#12427#12363#12393#12358#12363#12290
          Caption = #12502#12521#12454#12470#25351#23450
          TabOrder = 0
        end
        object EditBrowserPath: TLabeledEdit
          Left = 8
          Top = 56
          Width = 273
          Height = 20
          Hint = #12502#12521#12454#12470#12398#12497#12473#12434#35373#23450#12375#12414#12377#12290
          EditLabel.Width = 67
          EditLabel.Height = 12
          EditLabel.Caption = #12502#12521#12454#12470#12497#12473
          TabOrder = 1
        end
        object ButtonBrowserPath: TButton
          Left = 280
          Top = 56
          Width = 20
          Height = 20
          Hint = #12480#12452#12450#12525#12464#12434#38283#12367#12290
          Caption = '...'
          TabOrder = 2
          OnClick = ButtonBrowserPathClick
        end
        object EditEditorPath: TLabeledEdit
          Left = 8
          Top = 104
          Width = 273
          Height = 20
          Hint = #12506#12540#12473#12488#12450#12452#12486#12512#12398#20869#23481#12434#22806#37096#12456#12487#12451#12479#12391#32232#38598#12377#12427#12392#12365#12398#12456#12487#12451#12479#12398#12497#12473#12434#35373#23450#12375#12414#12377#12290
          EditLabel.Width = 63
          EditLabel.Height = 12
          EditLabel.Caption = #12456#12487#12451#12479#12497#12473
          TabOrder = 3
        end
        object ButtonEditorPath: TButton
          Left = 280
          Top = 104
          Width = 20
          Height = 20
          Hint = #12480#12452#12450#12525#12464#12434#38283#12367#12290
          Caption = '...'
          TabOrder = 4
          OnClick = ButtonEditorPathClick
        end
      end
      object TabDisp: TTabSheet
        Caption = #34920#31034
        object RadioGroupTabPosition: TRadioGroup
          Left = 8
          Top = 248
          Width = 185
          Height = 57
          Hint = #12501#12457#12540#12512#12398#12479#12502#20301#32622#12434#25351#23450#12375#12414#12377#12290
          Caption = #12479#12502#20301#32622
          Columns = 4
          Items.Strings = (
            #19978
            #19979
            #24038
            #21491)
          TabOrder = 0
          Visible = False
          OnClick = RadioGroupTabPositionClick
        end
        object CheckHotTrack: TCheckBox
          Left = 8
          Top = 8
          Width = 153
          Height = 17
          Hint = #12484#12522#12540#12420#12522#12473#12488#12499#12517#12540#12391#12510#12454#12473#12364#12522#12473#12488#12398#38917#30446#19978#12434#36890#36942#12375#12383#12392#12365#12395#38917#30446#12434#24375#35519#34920#31034#12377#12427#12363#12393#12358#12363#12434#25351#23450#12375#12414#12377#12290
          Caption = #12507#12483#12488#12488#12521#12483#12463
          TabOrder = 1
        end
        object CheckListHintVisible: TCheckBox
          Left = 8
          Top = 32
          Width = 225
          Height = 17
          Hint = #12522#12473#12488#12398#12509#12483#12503#12450#12483#12503#12498#12531#12488#12434#34920#31034#12377#12427#12363#12393#12358#12363#12434#25351#23450#12375#12414#12377#12290
          Caption = #12522#12473#12488#12498#12531#12488#12398#34920#31034
          TabOrder = 2
        end
        object CheckTreeHintVisible: TCheckBox
          Left = 8
          Top = 56
          Width = 161
          Height = 17
          Hint = #12484#12522#12540#12398#12509#12483#12503#12450#12483#12503#12498#12531#12488#12434#34920#31034#12377#12427#12363#12393#12358#12363#12434#25351#23450#12375#12414#12377#12290
          Caption = #12484#12522#12540#12498#12531#12488#12398#34920#31034
          TabOrder = 3
        end
        object RadioGroupTabStyle: TRadioGroup
          Left = 200
          Top = 248
          Width = 185
          Height = 57
          Caption = #12479#12502#12473#12479#12452#12523
          Columns = 3
          Items.Strings = (
            #12479#12502
            #12508#12479#12531
            #12501#12521#12483#12488)
          TabOrder = 4
          Visible = False
        end
        object CheckDispLauncherExt: TCheckBox
          Left = 8
          Top = 80
          Width = 249
          Height = 17
          Hint = #12521#12531#12481#12515#12540#12450#12452#12486#12512#12398#34920#31034#21517#12434#25313#24373#23376#12434#21547#12416#12501#12449#12452#12523#21517#12395#12377#12363#12393#12358#12363#12434#25351#23450#12375#12414#12377#12290
          Caption = #12521#12531#12481#12515#12540#12398#34920#31034#21517#12434#12501#12449#12452#12523#21517#12395#12377#12427
          TabOrder = 5
        end
        object CheckDispItemAddInfo: TCheckBox
          Left = 8
          Top = 104
          Width = 209
          Height = 17
          Hint = #12501#12457#12523#12480#12364#31354#12398#26178#12289#12522#12473#12488#12395#12450#12452#12486#12512#30331#37682#26696#20869#12434#34920#31034#12377#12427#12363#12393#12358#12363#12290
          Caption = #12450#12452#12486#12512#36861#21152#26696#20869#12398#34920#31034
          TabOrder = 6
        end
      end
      object TabDesign: TTabSheet
        Caption = #12487#12470#12452#12531
        ImageIndex = 9
        object Label1: TLabel
          Left = 8
          Top = 176
          Width = 56
          Height = 12
          Caption = #12501#12457#12540#12512#33394
          Visible = False
        end
        object TLabel
          Left = 8
          Top = 16
          Width = 43
          Height = 12
          Caption = #12484#12522#12540#33394
        end
        object TLabel
          Left = 8
          Top = 56
          Width = 40
          Height = 12
          Caption = #12522#12473#12488#33394
        end
        object TLabel
          Left = 8
          Top = 136
          Width = 39
          Height = 12
          Caption = #12498#12531#12488#33394
        end
        object TLabel
          Left = 8
          Top = 96
          Width = 36
          Height = 12
          Caption = #20869#23481#27396
        end
        object ColorBoxFormColor: TColorBox
          Left = 80
          Top = 176
          Width = 145
          Height = 22
          DefaultColorColor = clBtnFace
          Selected = clBtnFace
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 0
          Visible = False
        end
        object ColorBoxTreeColor: TColorBox
          Left = 80
          Top = 16
          Width = 145
          Height = 22
          Hint = #12484#12522#12540#12398#32972#26223#33394#12434#25351#23450#12375#12414#12377#12290
          DefaultColorColor = clWindow
          Selected = clWindow
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 1
        end
        object ColorBoxListColor: TColorBox
          Left = 80
          Top = 56
          Width = 145
          Height = 22
          Hint = #12522#12473#12488#12398#32972#26223#33394#12434#25351#23450#12375#12414#12377#12290
          DefaultColorColor = clWindow
          Selected = clWindow
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 2
        end
        object ButtonTreeFont: TButton
          Left = 248
          Top = 16
          Width = 105
          Height = 25
          Hint = #12484#12522#12540#12398#12501#12457#12531#12488#12434#25351#23450#12375#12414#12377#12290
          Caption = #12484#12522#12540#12501#12457#12531#12488
          TabOrder = 3
          OnClick = ButtonTreeFontClick
        end
        object ButtonListFont: TButton
          Left = 248
          Top = 56
          Width = 105
          Height = 25
          Hint = #12522#12473#12488#12398#12501#12457#12531#12488#12434#25351#23450#12375#12414#12377#12290
          Caption = #12522#12473#12488#12501#12457#12531#12488
          TabOrder = 4
          OnClick = ButtonListFontClick
        end
        object ColorBoxHintColor: TColorBox
          Left = 80
          Top = 136
          Width = 145
          Height = 22
          Hint = #12509#12483#12503#12450#12483#12503#12498#12531#12488#12398#32972#26223#33394#12434#25351#23450#12375#12414#12377#12290
          DefaultColorColor = clCream
          Selected = clCream
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 5
        end
        object ColorBoxMemoColor: TColorBox
          Left = 80
          Top = 96
          Width = 145
          Height = 22
          Hint = #12522#12473#12488#12398#32972#26223#33394#12434#25351#23450#12375#12414#12377#12290
          DefaultColorColor = clWindow
          Selected = clWindow
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 6
        end
        object ButtonMemoFont: TButton
          Left = 248
          Top = 96
          Width = 105
          Height = 25
          Hint = #12522#12473#12488#12398#12501#12457#12531#12488#12434#25351#23450#12375#12414#12377#12290
          Caption = #20869#23481#27396#12501#12457#12531#12488
          TabOrder = 7
          OnClick = ButtonMemoFontClick
        end
      end
      object TabCall: TTabSheet
        Caption = #21628#12403#20986#12375
        ImageIndex = 10
        object TLabel
          Left = 328
          Top = 232
          Width = 44
          Height = 12
          Caption = #12510#12540#12472#12531
        end
        object Label4: TLabel
          Left = 64
          Top = 315
          Width = 375
          Height = 12
          Caption = #8251#12510#12454#12473#12459#12540#12477#12523#20301#32622#21628#20986#12384#12392#12289#12479#12502#12420#12450#12452#12486#12512#12372#12392#12395#21628#20986#12399#20986#26469#12414#12379#12435#12290
        end
        object TGroupBox
          Left = 0
          Top = 0
          Width = 249
          Height = 297
          Caption = #34920#31034#20301#32622
          TabOrder = 0
          object PaintBoxDesktop: TPaintBox
            Left = 8
            Top = 16
            Width = 233
            Height = 137
            Hint = #12473#12486#12523#12473#21628#12403#20986#12375#26178#12398#12501#12457#12540#12512#12398#29366#24907#12290
            Color = clBtnFace
            ParentColor = False
            OnPaint = PaintBoxDesktopPaint
          end
          object RadioGroupDspPos: TRadioGroup
            Left = 8
            Top = 160
            Width = 233
            Height = 129
            Hint = #12473#12486#12523#12473#21628#12403#20986#12375#26178#12398#12501#12457#12540#12512#12398#20301#32622#12434#25351#23450#12375#12414#12377#12290
            Caption = #12501#12457#12540#12512#34920#31034#20301#32622
            ItemIndex = 1
            Items.Strings = (
              #20803#12398#20301#32622
              #12510#12454#12473#12459#12540#12477#12523#12398#20301#32622
              #30011#38754#24038#31471'or'#21491#31471
              #30011#38754#19978#31471'or'#19979#31471)
            TabOrder = 0
            OnClick = RadioGroupDspPosClick
          end
        end
        object TGroupBox
          Left = 256
          Top = 0
          Width = 185
          Height = 225
          Caption = #12479#12502#21628#12403#20986#12375#35373#23450
          TabOrder = 1
          object ButtonCallLastUse: TButton
            Left = 8
            Top = 24
            Width = 169
            Height = 25
            Hint = #26368#24460#12395#34920#31034#12375#12390#12356#12383#12479#12502#12398#21628#12403#20986#12375#26041#27861#12434#25351#23450#12375#12414#12377#12290
            Caption = #26368#24460#12395#34920#31034#12375#12390#12356#12383#12479#12502
            TabOrder = 0
            OnClick = ButtonCallLastUseClick
          end
          object ButtonCallAllSearch: TButton
            Left = 8
            Top = 56
            Width = 169
            Height = 25
            Hint = #26908#32034#12479#12502#12398#21628#12403#20986#12375#26041#27861#12434#25351#23450#12375#12414#12377#12290
            Caption = #26908#32034#12479#12502
            TabOrder = 1
            OnClick = ButtonCallAllSearchClick
          end
          object ButtonCallPaste: TButton
            Left = 8
            Top = 88
            Width = 169
            Height = 25
            Hint = #36028#12426#20184#12369#12479#12502#12398#21628#12403#20986#12375#26041#27861#12434#25351#23450#12375#12414#12377#12290
            Caption = #36028#12426#20184#12369#12479#12502
            TabOrder = 2
            OnClick = ButtonCallPasteClick
          end
          object ButtonCallLaunch: TButton
            Left = 8
            Top = 120
            Width = 169
            Height = 25
            Hint = #12521#12531#12481#12515#12540#12479#12502#12398#21628#12403#20986#12375#26041#27861#12434#25351#23450#12375#12414#12377#12290
            Caption = #12521#12531#12481#12515#12540#12479#12502
            TabOrder = 3
            OnClick = ButtonCallLaunchClick
          end
          object ButtonCallBkmk: TButton
            Left = 8
            Top = 152
            Width = 169
            Height = 25
            Hint = #12502#12483#12463#12510#12540#12463#12479#12502#12398#21628#12403#20986#12375#26041#27861#12434#25351#23450#12375#12414#12377#12290
            Caption = #12502#12483#12463#12510#12540#12463#12479#12502
            TabOrder = 4
            OnClick = ButtonCallBkmkClick
          end
          object ButtonCallClip: TButton
            Left = 8
            Top = 184
            Width = 169
            Height = 25
            Hint = #12463#12522#12483#12503#12508#12540#12489#23653#27508#12479#12502#12398#21628#12403#20986#12375#26041#27861#12434#25351#23450#12375#12414#12377#12290
            Caption = #12463#12522#12483#12503#12508#12540#12489#23653#27508#12479#12502
            TabOrder = 5
            OnClick = ButtonCallClipClick
          end
        end
        object SpinEditCallBackMargin: TSpinEdit
          Left = 384
          Top = 232
          Width = 57
          Height = 21
          Hint = '0'#12398#22580#21512#12510#12454#12473#12459#12540#12477#12523#12364#12501#12457#12540#12512#12363#12425#38626#12428#12427#12392#12501#12457#12540#12512#12364#12473#12486#12523#12473#29366#24907#12395#25147#12426#12414#12377#12290
          MaxValue = 100
          MinValue = 0
          TabOrder = 2
          Value = 20
        end
        object RadioGroupCallMethod: TRadioGroup
          Left = 256
          Top = 256
          Width = 185
          Height = 57
          Caption = #12510#12454#12473#21628#12403#20986#12375#26041#24335
          Items.Strings = (
            #12510#12454#12473#12463#12522#12483#12463
            #12510#12454#12473#12459#12540#12477#12523#20301#32622)
          TabOrder = 3
          OnClick = RadioGroupCallMethodClick
        end
        object ButtonCallMethod: TButton
          Left = 392
          Top = 290
          Width = 43
          Height = 17
          Hint = #12510#12454#12473#12459#12540#12477#12523#20301#32622#21628#20986#12398#12300#21628#12403#20986#12375#20301#32622#12301#12300#21628#12403#20986#12375#12456#12522#12450#24133#12301#12300#21628#12403#20986#12377#12414#12391#12398#26178#38291#12301#12434#35373#23450#12375#12414#12377#12290
          Caption = #35373#23450
          TabOrder = 4
          TabStop = False
          OnClick = ButtonCallMethodClick
        end
      end
      object TabHistory: TTabSheet
        Caption = #23653#27508
        ImageIndex = 8
        object TLabel
          Left = 8
          Top = 16
          Width = 60
          Height = 12
          Caption = #26368#22823#23653#27508#25968
        end
        object SpinEditMaxClipHistory: TSpinEdit
          Left = 88
          Top = 16
          Width = 73
          Height = 21
          Hint = #12463#12522#12483#12503#12508#12540#12489#23653#27508#12398#26368#22823#20445#23384#25968#12434#35373#23450#12375#12414#12377#12290
          MaxValue = 1000
          MinValue = 50
          TabOrder = 0
          Value = 100
        end
        object CheckUseClipItemToTop: TCheckBox
          Left = 8
          Top = 56
          Width = 249
          Height = 17
          Hint = #26368#36817#20351#29992#12375#12383#12463#12522#12483#12503#12508#12540#12489#12450#12452#12486#12512#12434#12522#12473#12488#12398#19968#30058#19978#12395#31227#21205#12373#12379#12414#12377#12290
          Caption = #20351#29992#12375#12383#12463#12522#12483#12503#12450#12452#12486#12512#12434#12488#12483#12503#12395#31227#21205
          TabOrder = 1
        end
      end
      object TabSearch: TTabSheet
        Caption = #26908#32034
        ImageIndex = 6
        object CheckSearchDispDir: TCheckBox
          Left = 8
          Top = 8
          Width = 209
          Height = 17
          Hint = #12450#12452#12486#12512#12398#26908#32034#32080#26524#12395#12501#12457#12523#12480#12434#34920#31034#12377#12427#12363#12434#25351#23450#12375#12414#12377#12290
          Caption = #26908#32034#32080#26524#12395#12501#12457#12523#12480#12434#34920#31034#12377#12427
          TabOrder = 0
        end
      end
      object TabDateTime: TTabSheet
        Caption = #26085#26178#24418#24335
        ImageIndex = 9
        DesignSize = (
          447
          319)
        object MemoDateTimeHint: TMemo
          Left = 8
          Top = 120
          Width = 433
          Height = 186
          Hint = #12501#12457#12540#12510#12483#12488#24418#24335#25991#23383#12391#12377#12290
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          Lines.Strings = (
            'e'#9#24180#12434#29694#22312#12398#24180#21495#12434#20351#12387#12390#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427
            'ee'#9#24180#12434#29694#22312#12398#24180#21495#12434#20351#12387#12390#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427
            'g'#9#24180#21495#12434#30465#30053#24418#12391#34920#31034#12377#12427
            'gg'#9#24180#21495#12434#23436#20840#24418#12391#34920#31034#12377#12427
            'yy'#9#24180#12434' 2 '#26689#12398#25968#23383#65288'00 '#65374' 99'#65289#12391#34920#31034#12377#12427
            'yyyy'#9#24180#12434' 4 '#26689#12398#25968#23383#65288'0000 '#65374' 9999'#65289#12391#34920#31034#12377#12427
            'd'#9#26085#12434#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427#65288'1 '#65374' 31'#65289
            'dd'#9#26085#12434#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427#65288'01 '#65374' 31'#65289
            'm'#9#26376#12434#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427#65288'1 '#65374' 12'#65289
            'mm'#9#26376#12434#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427#65288'01 '#65374' 12'#65289
            'h'#9#26178#12434#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427#65288'0 '#65374' 23'#65289
            'hh'#9#26178#12434#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427#65288'00 '#65374' 23'#65289
            'n'#9#20998#12434#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427#65288'0 '#65374' 59'#65289
            'nn'#9#20998#12434#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427#65288'00 '#65374' 59'#65289
            's'#9#31186#12434#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427#65288'0 '#65374' 59'#65289
            'ss'#9#31186#12434#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427#65288'00 '#65374' 59'#65289
            'z'#9#12511#12522#31186#12434#20808#38957#12398#12476#12525#12394#12375#12391#34920#31034#12377#12427#65288'0 '#65374' 999'#65289
            'zzz'#9#12511#12522#31186#12434#20808#38957#12398#12476#12525#20184#12365#12391#34920#31034#12377#12427#65288'000 '#65374' 999'#65289
            'aaa '#9#26332#26085#12434#34920#31034#12377#12427'('#26085#65374#22303')'
            'aaaa '#9#26332#26085#12434#34920#31034#12377#12427'('#26085#26332#26085#65374#22303#26332#26085')'
            'am/pm '#9'am'#12418#12375#12367#12399'pm'#12434#34920#31034#12377#12427
            'a/p '#9'a'#12418#12375#12367#12399'p'#12434#34920#31034#12377#12427
            '/'#9#21306#20999#12426' / '#12434#34920#31034#12377#12427
            ': '#9#21306#20999#12426' : '#12434#34920#31034#12377#12427
            #39'xx'#39#9#21336#24341#29992#31526#12391#22258#12414#12428#12383#25991#23383#12399#12381#12398#12414#12414#34920#31034#12373#12428#12427)
          ParentColor = True
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object EditDateFmt: TLabeledEdit
          Left = 64
          Top = 8
          Width = 369
          Height = 20
          Hint = #26085#20184#12398#24418#24335#12434#25351#23450#12375#12414#12377#12290
          AutoSize = False
          EditLabel.Width = 48
          EditLabel.Height = 12
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = #26085#20184#24418#24335
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 1
        end
        object EditTimeFmt: TLabeledEdit
          Left = 64
          Top = 32
          Width = 369
          Height = 20
          Hint = #26178#21051#12398#24418#24335#12434#25351#23450#12375#12414#12377#12290
          AutoSize = False
          EditLabel.Width = 48
          EditLabel.Height = 12
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = #26178#21051#24418#24335
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 2
        end
        object EditDateTimeFmt: TLabeledEdit
          Left = 64
          Top = 56
          Width = 369
          Height = 20
          Hint = #26085#26178#12398#24418#24335#12434#25351#23450#12375#12414#12377#12290
          AutoSize = False
          EditLabel.Width = 48
          EditLabel.Height = 12
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = #26085#26178#24418#24335
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          LabelSpacing = 10
          TabOrder = 3
        end
        object EditListDateTimeFmt: TLabeledEdit
          Left = 64
          Top = 88
          Width = 369
          Height = 20
          Hint = #26085#26178#12398#24418#24335#12434#25351#23450#12375#12414#12377#12290
          AutoSize = False
          EditLabel.Width = 52
          EditLabel.Height = 12
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = #12522#12473#12488#34920#31034
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpLeft
          LabelSpacing = 5
          TabOrder = 4
        end
      end
      object TabBackup: TTabSheet
        Caption = #12496#12483#12463#12450#12483#12503
        ImageIndex = 10
        object LabelLastBackupDate: TLabel
          Left = 8
          Top = 288
          Width = 111
          Height = 12
          Caption = 'LabelLastBackupDate'
        end
        object Label3: TLabel
          Left = 168
          Top = 8
          Width = 193
          Height = 12
          Caption = #12501#12457#12523#12480#12395#27531#12377#12496#12483#12463#12450#12483#12503#12501#12449#12452#12523#25968
        end
        object CheckAutoBacup: TCheckBox
          Left = 16
          Top = 8
          Width = 129
          Height = 17
          Hint = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12395#33258#21205#12391#12487#12540#12479#12434#12496#12483#12463#12450#12483#12503#12375#12414#12377#12290
          Caption = #33258#21205#12496#12483#12463#12450#12483#12503
          TabOrder = 0
        end
        object RadioGroupBackupMode: TRadioGroup
          Left = 16
          Top = 32
          Width = 153
          Height = 89
          Hint = #26368#24460#12395#12496#12483#12463#12450#12483#12503#12375#12390#12363#12425#27425#22238#12496#12483#12463#12450#12483#12503#12414#12391#12398#38291#38548#12290
          Caption = #12496#12483#12463#12450#12483#12503#38291#38548
          Items.Strings = (
            #65297#26085#12372#12392
            #65297#36913#38291#12372#12392
            #65297#12534#26376#12372#12392)
          TabOrder = 1
        end
        object EditBackupDir: TLabeledEdit
          Left = 16
          Top = 136
          Width = 393
          Height = 20
          Hint = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12434#25351#23450#12375#12414#12377#12290
          EditLabel.Width = 105
          EditLabel.Height = 12
          EditLabel.Caption = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480
          TabOrder = 2
        end
        object ButtonBackupDir: TButton
          Left = 408
          Top = 136
          Width = 20
          Height = 20
          Hint = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12434#36984#25246#12375#12414#12377#12290
          Caption = '...'
          TabOrder = 3
          OnClick = ButtonBackupDirClick
        end
        object ButtonBackupNow: TButton
          Left = 16
          Top = 168
          Width = 153
          Height = 25
          Hint = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12395#12487#12540#12479#12505#12540#12473#12434#12496#12483#12463#12450#12483#12503#12375#12414#12377#12290
          Caption = #20170#12377#12368#12496#12483#12463#12450#12483#12503#12377#12427
          TabOrder = 4
          OnClick = ButtonBackupNowClick
        end
        object ButtonOpenBackupDir: TButton
          Left = 176
          Top = 168
          Width = 153
          Height = 25
          Hint = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12434#12456#12463#12473#12503#12525#12540#12521#12540#12391#38283#12365#12414#12377#12290
          Caption = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12434#38283#12367
          TabOrder = 5
          OnClick = ButtonOpenBackupDirClick
        end
        object TPanel
          Left = 8
          Top = 208
          Width = 409
          Height = 73
          BevelOuter = bvLowered
          TabOrder = 6
          object LabelBackup: TLabel
            Left = 1
            Top = 1
            Width = 407
            Height = 71
            Align = alClient
            AutoSize = False
            Caption = #12497#12473#12527#12540#12489#12434#35373#23450#12375#12390#12356#12427#22580#21512#12399#12289#21516#12376#12497#12473#12527#12540#12489#12434#36215#21205#26178#25351#23450#12375#12394#12356#12392#12524#12473#12488#12450#12391#12365#12414#12379#12435#12290
            Layout = tlCenter
            WordWrap = True
          end
        end
        object SpinEditLeaveBackupFiles: TSpinEdit
          Left = 376
          Top = 8
          Width = 41
          Height = 21
          Hint = #12496#12483#12463#12450#12483#12503#12501#12457#12523#12480#12395#27531#12377#12501#12449#12452#12523#25968#12434#25351#23450#12375#12414#12377#12290#12501#12449#12452#12523#25968#12434#36229#12360#12383#12501#12449#12452#12523#12399#21476#12356#12418#12398#12363#12425#21066#38500#12373#12428#12414#12377#12290
          MaxValue = 10
          MinValue = 1
          TabOrder = 7
          Value = 3
          OnChange = SpinEditLeaveBackupFilesChange
        end
      end
      object TabConf: TTabSheet
        Caption = #30906#35469
        ImageIndex = 7
        object CheckConfDelDir: TCheckBox
          Left = 8
          Top = 8
          Width = 161
          Height = 17
          Hint = #12501#12457#12523#12480#12434#21066#38500#12377#12427#21069#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
          Caption = #12501#12457#12523#12480#12434#21066#38500#12377#12427#21069
          TabOrder = 0
        end
        object CheckConfDelItem: TCheckBox
          Left = 8
          Top = 32
          Width = 161
          Height = 17
          Hint = #12522#12473#12488#12450#12452#12486#12512#12434#21066#38500#12377#12427#21069#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
          Caption = #12450#12452#12486#12512#12434#21066#38500#12377#12427#21069
          TabOrder = 1
        end
        object CheckConfPasteXmlExport: TCheckBox
          Left = 8
          Top = 56
          Width = 249
          Height = 17
          Hint = #12506#12540#12473#12488#12450#12452#12486#12512#12434#12456#12463#12473#12509#12540#12488#12377#12427#21069#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
          Caption = #12506#12540#12473#12488#12450#12452#12486#12512#12434#12456#12463#12473#12509#12540#12488#12377#12427#21069
          TabOrder = 2
        end
        object CheckConfDelDbShortcut: TCheckBox
          Left = 8
          Top = 80
          Width = 217
          Height = 17
          Hint = #37325#35079#12471#12519#12540#12488#12459#12483#12488#12461#12540#12434#21066#38500#12377#12427#21069#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
          Caption = #37325#35079#12471#12519#12540#12488#12459#12483#12488#12461#12540#12434#21066#38500#12377#12427#21069
          TabOrder = 3
        end
        object CheckConfDelDbHot: TCheckBox
          Left = 8
          Top = 104
          Width = 193
          Height = 17
          Hint = #37325#35079#12507#12483#12488#12461#12540#12434#21066#38500#12377#12427#21069#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
          Caption = #37325#35079#12507#12483#12488#12461#12540#12434#21066#38500#12377#12427#21069
          TabOrder = 4
        end
        object CheckConfDelDbMouse: TCheckBox
          Left = 8
          Top = 128
          Width = 273
          Height = 17
          Hint = #37325#35079#12510#12454#12473#12450#12463#12471#12519#12531#12434#21066#38500#12377#12427#21069#12395#30906#35469#12480#12452#12450#12525#12464#12434#34920#31034#12375#12414#12377#12290
          Caption = #37325#35079#12510#12454#12473#12450#12463#12471#12519#12531#12434#21066#38500#12377#12427#21069
          TabOrder = 5
        end
      end
    end
    object TreeMenu: TTreeView
      Left = 5
      Top = 5
      Width = 124
      Height = 346
      Align = alLeft
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      HideSelection = False
      Indent = 19
      ParentFont = False
      ReadOnly = True
      RightClickSelect = True
      RowSelect = True
      ShowButtons = False
      ShowLines = False
      ShowRoot = False
      TabOrder = 1
      OnChange = TreeMenuChange
      OnCollapsing = TreeMenuCollapsing
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 356
    Width = 589
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      589
      34)
    object LabelHint: TLabel
      Left = 8
      Top = 0
      Width = 409
      Height = 33
      AutoSize = False
      Caption = 'LabelHint'
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object OKBtn: TButton
      Left = 428
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 508
      Top = 2
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #12461#12515#12531#12475#12523
      ModalResult = 2
      TabOrder = 1
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    Left = 21
    Top = 308
  end
  object OpenDialogSound: TOpenDialog
    DefaultExt = 'wav'
    Filter = #12469#12454#12531#12489#12501#12449#12452#12523'(*.wav)|*.wav|'#20840#12390#12398#12501#12449#12452#12523'(*,*)|*.*'
    Title = #12469#12454#12531#12489#12501#12449#12452#12523#12398#36984#25246
    Left = 56
    Top = 304
  end
  object OpenDialogExe: TOpenDialog
    DefaultExt = 'exe'
    Filter = #23455#34892#12501#12449#12452#12523'(*.exe)|*.exe|'#20840#12390#12398#12501#12449#12452#12523'(*,*)|*.*'
    Title = #23455#34892#12501#12449#12452#12523#12398#36984#25246
    Left = 88
    Top = 304
  end
  object FolderDialog: TFolderDialog
    RootFolder = rfDeskTop
    Title = #12501#12457#12523#12480#12540#12434#36984#25246#12375#12390#19979#12373#12356#12290
    Left = 16
    Top = 280
  end
end
