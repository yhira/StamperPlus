unit ModClip;

interface

uses
  SysUtils, Classes, Dialogs, ExtIniFile, Clipbrd, Windows, Graphics,
  gifimage, Jpeg, pngimage, TextDlgs, ExtDlgs, ShlObj, FrText, XPMan;

type
  TSavePicMode = (spmBmp = 1, spmJpg = 2, spmPng = 3, spmGif = 4{, spmIco = 5, spmWmf = 6});

  TDataModule1 = class(TDataModule)
    ExtIniFile1: TExtIniFile;
    SavePictureDialog1: TSavePictureDialog;
    TextSaveDialog1: TTextSaveDialog;
    XPManifest1: TXPManifest;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private 宣言 }
    procedure SetDefaultExt(SavePicMode: TSavePicMode);
    procedure GetCopyFiles(sl: TStringList);
  public
    { Public 宣言 }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

uses FrMain, ComDef;

function WideStrLen(WideStr:PWideChar):Cardinal;
begin
  result := lstrlenW(WideStr);
end;

procedure GetFilesW(MS:TMemoryStream; offset:Cardinal; Files:TStrings);
var
  ws:WideString;
  p:pointer;
  pEnd:Cardinal;
begin
  pEnd := Cardinal(MS.Memory)+Cardinal(MS.Size);
  p := pointer(Cardinal(MS.Memory)+offset);
  repeat
    SetString(ws,PWideChar(p),WideStrLen(p));
    Files.Add(ws);
    p := pointer(integer(p)+Length(ws)*2+2);
  until (Cardinal(p) >= pEnd) or (PWord(p)^ = 0);
end;

procedure GetFilesA(MS:TMemoryStream; offset:Cardinal; Files:TStrings);
var
  s:string;
  p:pointer;
  pEnd:Cardinal;
begin
  pEnd := Cardinal(MS.Memory)+Cardinal(MS.Size);
  p := pointer(Cardinal(MS.Memory)+offset);
  repeat
    SetString(s,PChar(p),StrLen(PChar(p)));
    Files.Add(s);
    p := pointer(integer(p)+Length(s)+1);
  until (Cardinal(p) >= pEnd) or (PByte(p)^ = 0);
end;

procedure TDataModule1.GetCopyFiles(sl: TStringList);var
  MS:TMemoryStream;
  hBuf:THandle;
  DF:TDropFiles;
  p:pointer;
begin
  MS := TMemoryStream.Create;
  try
    if Clipboard.HasFormat(CF_HDROP) then begin
      ClipBoard.Open;
      hBuf := Clipboard.GetAsHandle(CF_HDROP);
      p := GlobalLock(hBuf);
      MS.WriteBuffer(p^,GlobalSize(hBuf));
      GlobalUnlock(hBuf);
      Clipboard.Close;

      MS.Position := 0;
      MS.Read(DF,SizeOf(TDropFiles));
      if DF.fWide then begin
        GetFilesW(MS,DF.pFiles,sl);
      end else begin
        GetFilesA(MS,DF.pFiles,sl);
      end;
    end;
  finally
    MS.Free;
  end;

end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);var SavePicMode: TSavePicMode;
  Bmp: TBitmap;
  Pic: TGraphic;
  sl: TStringList;
begin
  ExtIniFile1.DefaultFolder := dfUser;
  ExtIniFile1.FileName := ConfigPath + 'clip.ini';
  if Clipboard.HasFormat(CF_BITMAP) then begin
    with SavePictureDialog1, ExtIniFile1 do begin
      Bmp := TBitmap.Create;
      Bmp.Assign(Clipboard);
      SavePicMode := TSavePicMode(ReadInt('PictureDialog', 'SavePicMode', Integer(spmBmp)));
      FilterIndex := Integer(SavePicMode);
      InitialDir := ReadStr('PictureDialog', 'InitialDir', ExtractFileDir(ParamStr(0)));
      SetDefaultExt(SavePicMode);
      SavePictureDialog1.FileName := 'Image（' + IntToStr(Bmp.Width) + '×' + IntToStr(Bmp.Height) + '）';
      if Execute then begin
        SavePicMode := TSavePicMode(FilterIndex);
        SetDefaultExt(SavePicMode);
        case SavePicMode of
          spmJpg: Pic := TJPEGImage.Create;
          spmPng: Pic := TPNGObject.Create;
          spmGif: Pic := TGIFImage.Create;
        else Pic := TBitmap.Create;
        end;
        Pic.Assign(Bmp);
        Pic.SaveToFile(SavePictureDialog1.FileName);

        WriteInt('PictureDialog', 'SavePicMode', FilterIndex);
        WriteStr('PictureDialog', 'InitialDir', ExtractFileDir(SavePictureDialog1.FileName));
      end;
      Bmp.Free;
      Pic.Free;
    end;
  end else if Clipboard.HasFormat(CF_TEXT) then begin
    with TextSaveDialog1, ExtIniFile1 do begin
      InitialDir := ReadStr('TextSaveDialog', 'InitialDir', ExtractFileDir(ParamStr(0)));
      if Execute then begin
        sl := TStringList.Create;
        sl.Text := Clipboard.AsText;
        sl.SaveToFile(TextSaveDialog1.FileName);
        sl.Free;
        WriteStr('TextSaveDialog', 'InitialDir', ExtractFileDir(TextSaveDialog1.FileName));
      end;
    end;
  end else if Clipboard.HasFormat(CF_HDROP) then begin
    sl := TStringList.Create;
    GetCopyFiles(sl);
    TextForm := TTextForm.Create(Self);
    try
      with TextForm.TextSaveDialog1 do begin
        InitialDir := ExtIniFile1.ReadStr('FilePathSaveDialog', 'InitialDir', ExtractFileDir(ParamStr(0)));
        Filter := TextSaveDialog1.Filter;
        FileName := 'CopyFiles.txt';
        DefaultExt := 'txt';
        Title := 'コピーされたファイルリストに名前を付けて保存';
      end;
      TextForm.Memo1.Text := sl.Text;
      TextForm.ShowModal;
//      TextForm.Hide;
    finally
      TextForm.Release;
      sl.Free;
    end;
  end else begin
    MessageDlg('クリップボードが空か未サポートのフォーマットです。', mtInformation, [mbOK], 0);
  end;
  Self.Free;;
end;

procedure TDataModule1.SetDefaultExt(SavePicMode: TSavePicMode);
var DefExt: string;
begin
  case SavePicMode of
    spmJpg: DefExt := 'jpg';
    spmPng: DefExt := 'png';
    spmGif: DefExt := 'gif';
  else DefExt := 'bmp';
  end;
  SavePictureDialog1.DefaultExt := DefExt;
end;

end.
