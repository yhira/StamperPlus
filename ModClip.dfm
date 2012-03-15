object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 443
  Top = 129
  Height = 150
  Width = 215
  object ExtIniFile1: TExtIniFile
    Left = 16
    Top = 8
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 
      #12499#12483#12488#12510#12483#12503' (*.bmp)|*.bmp|JPEG '#12452#12513#12540#12472#12501#12449#12452#12523' (*.jpg)|*.jpg;*.ipeg|PNG '#12452#12513#12540#12472 +
      #12501#12449#12452#12523' (*.png)|*.png|GIF '#12452#12513#12540#12472#12501#12449#12452#12523' (*.gif)|*.gif'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = #12463#12522#12483#12503#12508#12540#12489#30011#20687#12395#21517#21069#12434#20184#12369#12390#20445#23384
    Left = 104
    Top = 8
  end
  object TextSaveDialog1: TTextSaveDialog
    DefaultExt = 'txt'
    FileName = 'ClipboardText.txt'
    Filter = #12486#12461#12473#12488#12501#12449#12452#12523'(*.txt)|*.txt|'#12377#12409#12390#12398#12501#12449#12452#12523'|*.*'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Title = #12463#12522#12483#12503#12508#12540#12489#12486#12461#12473#12488#12395#21517#21069#12434#20184#12369#12390#20445#23384
    ShowPlacesBar = True
    Preview = True
    Left = 104
    Top = 56
  end
  object XPManifest1: TXPManifest
    Left = 16
    Top = 56
  end
end
