unit Helper;

interface

uses Windows, SysUtils, Classes, Forms, FrShowMsg, Controls, Graphics,
  SkRegExpW, ShellApi, ComObj, ShlObj, ActiveX, yhINet, jconvertex, ComDef,
  NkDIB, IconUtils, IconEx, Dialogs, ComItems, Menus, yhOthers, yhFiles,
  IconRes, ActnList, SQLiteTable3, Dbg, HTTPApp;

type
  TLinkFileInfo =packed record
    Filename  : string; //リンクしているファイル名
    WorkDir   : string; //作業ディレクトリ
    Arguments : string; //コマンドライン引数
    Hotkey    : Word;    //設定されているホットキー
    ShowCmd   : Integer; //実行時の表示状態
  end;

  TWebSiteInfo = record
    Html: string;
    Title: string;
    Description: string;
    Keywords: string;
    IconUrl: string;
  end;


procedure p(Msg: string);
procedure pi(i: Integer);   
procedure pb(b: Boolean);
procedure ClearList(AList: TList); 
function FormatPropDate(DateTime: TDateTime): string;
function DtoS(DateTime: TDateTime): string; 
procedure ShowHintWindow(AOwner: TForm; Msg: string);
procedure CloseHintWindow;   
function GetAvailablenessLine(AText: string): string; 
function IsUrl(s: string): Boolean;
function IsFileName(s: string): Boolean;
function IsMutch(reg, s: string): Boolean;
function GetInfofromLinkFile(LinkFilename: string):TLinkFileInfo;
function ExtractAssociatedIconFromExt(FileName: string): HICON;
function ExtractIconEx(FileName: string; IconIndex: Cardinal = 0): HICON;
function GetWebSiteInfo(url: string; var WSI: TWebSiteInfo): Boolean;
procedure GetWebSiteIcon(url: string; icon: TIcon);
procedure ExtractFileIcon(FileName: string; AIcon: TIcon);
procedure Msg(Text: String);
function GetNotSameItemSql(EditingItem: TCommonItem): string;
function KeyExsist(Cls: TItemClass; id: Int64; sKey: string): Boolean; 
function GetKeyId(Cls: TItemClass; id: Int64; sKey: string): Int64; 
function DeleteKey(Cls: TItemClass; id: Int64; sKey: string): Int64;
function GetMouseItemExistSqlAfterWhere(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): string;
function MouseItemExist(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): Boolean; 
function GetMouseItemId(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): Int64; 
function DeleteMouseKey(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): Int64;
procedure ExcuteKeyMacro(h: HWND; Macro: string);  
function KeyStrToVKey(KeyStr: string): Word;
function VKeyToKeyStr(Key: Word): string;   
function ExistActionShortCut(al: TActionList; sc: TShortCut): Boolean;  
function MakeLaunchTag(pn, cn: string): string;

var hw: THintWindow;

implementation

uses Types;

procedure ExcuteKeyMacro(h: HWND; Macro: string);
var sl: TStringList; i, vKey: Integer; s: string;
  IsShift, IsCtrl, IsAlt: Boolean;
begin
  IsShift := False; IsAlt := False; IsCtrl := False;
  //ターゲットウィンドウを前面に
  SetForegroundWindow(h);
  SetFocus(h);
  Application.ProcessMessages;
  Sleep(50);
  //マクロ実行
  sl := TStringList.Create;
  try
    sl.CommaText := Macro;
    for i := 0 to sl.Count-1 do begin
      s := sl[i];
      if s = '' then Continue;
      vKey := KeyStrToVKey(s);
      if vKey = $00 then Continue;
//      vKey := StrToIntDef('$' + s, 0);
      if IsShift then
        keybd_event(VK_SHIFT, 0, 0, 0);
      if IsAlt then
        keybd_event(VK_MENU, 0, 0, 0);
      if IsCtrl then
        keybd_event(VK_CONTROL, 0, 0, 0);

      if vKey = VK_SHIFT then begin
        IsShift := True;
        Continue;
      end;
      if vKey = VK_MENU then begin
        IsAlt := True;
        Continue;
      end;
      if vKey = VK_CONTROL then begin
        IsCtrl := True;
        Continue;
      end;
      keybd_event(vKey, 0, 0, 0);
      keybd_event(vKey, 0, KEYEVENTF_KEYUP, 0);
      
      if IsShift then begin
        keybd_event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
        IsShift := False;
      end;
      if IsAlt then begin
        keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0); 
        IsAlt := False;
      end;
      if IsCtrl then begin
        keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
        IsCtrl := False;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure pi(i: Integer);
begin
  p(IntToStr(i));
end;

procedure pb(b: Boolean);
begin
  p(BoolToStr(b, True));
end;

procedure p(Msg: string);
begin
  if FormShowMsg = nil then FormShowMsg := TFormShowMsg.Create(Application);
  FormShowMsg.Memo1.Lines.Add(Msg);
  if not FormShowMsg.Visible then FormShowMsg.Show;
end;

procedure ClearList(AList: TList);
var i: Integer;
begin
  for i := AList.Count-1 downto 0 do TObject(AList[i]).Free;
  AList.Clear;
end;

function FormatPropDate(DateTime: TDateTime): string;
begin
  Result := FormatDateTime('yyyy年mm月dd日、hh:nn:ss', DateTime);
end;

function DtoS(DateTime: TDateTime): string;
begin
  Result := FormatDateTime('yyyy/mm/dd hh:nn:ss', DateTime);
end;

procedure ShowHintWindow(AOwner: TForm; Msg: string);
var sl: TStringList; r: TRect;
begin
  if hw = nil then begin
    hw := THintWindow.Create(AOwner);
    hw.Color := $00DFDFFF;
  end;
  if not AOwner.Visible then Exit;
  sl := TStringList.Create;
  try
    sl.Text := Msg;
    with hw do begin
      r := CalcHintRect(AOwner.Width, Msg, nil);
      r.Left := AOwner.Left;
      r.Top := AOwner.Top + AOwner.Height;
      r.Right := AOwner.Left + AOwner.Width;    
      r.Bottom := r.Bottom + r.Top;
      ActivateHint(r, Msg);
//      yhOthers.StayOnTop(hw.Handle, True);
    end;
  finally
    sl.Free;
  end;
end;

procedure CloseHintWindow;
begin
  if hw <> nil then begin
    hw.ReleaseHandle;
    hw.Free;
    hw := nil;
  end;
end;

function GetAvailablenessLine(AText: string): string;
var
  r: TSkRegExp;
begin
  Result := '';
  r := TSkRegExp.Create;  //オブジェクトを生成
  try
    //正規表現パターンを設定
    r.MultiLine := True;
    r.Expression := '^.+$';
    //検索開始
    if r.Exec (AText) then Result := Trim(r.Match[0]);//p(r.Match[0]);
  finally
    r.Free;   //オブジェクトを解放
  end;
end;

function IsMutch(reg, s: string): Boolean;
var r: TSkRegExp;
begin
  Result := False;
  r := TSkRegExp.Create;
  try
    //正規表現パターンを設定
    r.MultiLine := True;
    r.Expression := reg;
    //検索開始
    if r.Exec(s) then Result := True;
  finally
    r.Free;
  end;
end;

function IsFileName(s: string): Boolean;
const
  REG_FILE = '^[^\/;*?"<>|]+$';
begin
  Result := IsMutch(REG_FILE, s);
end;

function IsUrl(s: string): Boolean;
const
  REG_URL = '^https?(:\/\/[-_.!~*\''()a-zA-Z0-9;\/?:\@&=+\$,%#]+)$';
begin
  Result := IsMutch(REG_URL, s);
end;

function ExtractIconEx(FileName: string; IconIndex: Cardinal): HICON;
var ext: string; //lfi: TLinkFileInfo; i: Word;
begin
  FileName := LowerCase(FileName);
  ext := ExtractFileExt(FileName);
  if ext = '.lnk' then begin
    FileName := GetInfofromLinkFile(FileName).Filename;
  end;              
  ext := ExtractFileExt(FileName);
  if {(ext = '.dll') or }(ext = '.ico') or (ext = '.exe') then begin
    Result := ShellApi.ExtractIcon(HInstance, PChar(FileName), IconIndex);
  end else begin
    Result := ExtractAssociatedIconFromExt(FileName);
//    i := Word(IconIndex);
//    Result := ExtractAssociatedIcon(HInstance, PChar(FileName), i);
  end;
end;

function GetInfofromLinkFile(LinkFilename: string):TLinkFileInfo;
var
  ShellLink     :IShellLink;
  PersistFile   :IPersistFile;
  WFilename     :Widestring;
  Win32FindData :TWin32FindData;
  S, Work, Arg  :string;
  Hot           :Word;
  Cmd           :Integer;
begin
  if LowerCase(ExtractFileExt(LinkFilename)) <>'.lnk' then Exit;

  ShellLink :=CreateComObject(CLSID_ShellLink) as IShellLink;
  PersistFile :=ShellLink as IPersistFile;

  //Unicodeにキャスト
  WFilename :=LinkFilename;

  if Succeeded(PerSistFile.Load(PWChar(WFilename), STGM_READ)) then
  begin
    ShellLink.Resolve(0, SLR_ANY_MATCH);

    SetLength(S, MAX_PATH);
    SetLength(Work, MAX_PATH);
    SetLength(Arg, MAX_PATH);
    //ショートカットファイルの参照先を取得
    ShellLink.GetPath(PChar(S), MAX_PATH, Win32FindData,
                      SLGP_UNCPRIORITy);
    //作業ディレクトリを取得
    ShellLInk.GetWorkingDirectory(PChar(Work), MAX_PATH);
    //コマンドライン引数を取得
    ShellLink.GetArguments(PChar(Arg), MAX_PATH);
    //ホットキーを取得
    ShellLink.GetHotkey(Hot);
    //実行時の表示状態を取得
    ShellLink.GetShowCmd(Cmd);

    //関数の戻り値にセット
    with Result do begin
      Filename  :=PChar(S);
      WorkDir   :=PChar(Work);
      Arguments :=PChar(Arg);
      Hotkey    :=Hot;
      ShowCmd   :=Cmd;
    end;
  end;
end;

function ExtractAssociatedIconFromExt(FileName: string): HICON;
var
  SHFinfo :TSHFileinfo;
  ext: string;
begin
  ext := ExtractFileExt(FileName);
  ext := '*' + ext;
  SHGetFileInfo(PChar(ext),
                FILE_ATTRIBUTE_NORMAL,
                SHFInfo,            //TSHFileinfo構造体
                SizeOf(SHFInfo),    //TSHFileinfo構造体のサイズ
                SHGFI_ICON or
                SHGFI_LARGEICON or  //SHGFI_SMALLICONで小さいアイコン
                SHGFI_USEFILEATTRIBUTES or
                SHGFI_DISPLAYNAME or
                SHGFI_TYPENAME);
//  DOut(SHFinfo.szDisplayName);
//  DOut(SHFinfo.szTypeName);
  Result :=SHFinfo.hIcon;
end;

procedure GetWebSiteIcon(url: string; icon: TIcon);
var fn: string;
//  ico: TIconEx; dib: TNkDIB; bmp: TBitmap;
begin
  fn := TmpPath + FormatDateTime('yyyymmddhhnnsszzz".ico"', Now);
  if DownloadFileEx(url, fn) then begin

//    bmp := TBitmap.Create;
//    dib := TNkDIB.Create;
//    ico := TIconEx.Create;
    try
//      ico.LoadFromFile(fn);
//      bmp.Width := 32;
//      bmp.Height := 32;
//      bmp.Canvas.Draw(0, 0, ico);
//      dib.Assign(bmp);
//      SaveIcon(dib, fn);

//      icon.Transparent
//      icon.Transparent := True;
      try
        Icon.LoadFromFile(fn);
      except
        icon.Assign(TIconItem(BkmkIcons[0]).Icon);
      end;

      DeleteFile(fn);
    finally
//      ico.Free;
//      dib.Free;
//      bmp.Free;
    end;
  end else
    icon.Assign(TIconItem(BkmkIcons[0]).Icon);
end;

function GetWebSiteInfo(url: string; var WSI: TWebSiteInfo): Boolean;
  function GetCurrentDir(AUrl: string): string;
  var i, n: Integer;
  begin
    n := 0;
    for i := 1 to Length(AUrl) do begin
      if AUrl[i] = '/' then Inc(n);
    end;
    if n = 3 then begin
      Result := AUrl;
    end else if n = 2 then begin
      Result := AUrl + '/';
    end else begin
      for i := Length(AUrl) downto 1 do begin
        if AUrl[i] <> '/' then Delete(AUrl, i, 1) else begin
          Result := AUrl;
          Exit;
        end;
      end;
    end;
  end;
var sHtml, sTitle, sKeywords, sDescription, sIconUrl,
  title_reg, keywords_reg,description_reg, icon_reg,
  entity_reg: string; r: TSkRegExp;    
const
  REG_URL = '([https?:\/\/]*[-_.!~*\''()a-zA-Z0-9;\/?:\@&=+\$,%#]+)';
  REG_URLTOP = '(https?:\/\/[-_.!~*\''()a-zA-Z0-9;\?:\@&=+\$,%#]+)';
  FEVICON = 'favicon.ico';
begin
  Result := False;
  if GetHtml(url, sHtml) then begin
    r := TSkRegExp.Create;
    try
      sHtml := ConvertJCode(sHtml, SJIS_OUT);
      r.IgnoreCase := True;
      r.MultiLine := True;
      keywords_reg    := '<\s*meta\s+.*?name\s*=\s*"?keywords"?\s+.*?content\s*=\s*"((.|\s)*?)".*?>';
      description_reg := '<\s*meta\s+.*?name\s*=\s*"?description"?\s+.*?content\s*=\s*"((.|\s)*?)".*?>';
      icon_reg := '<link\s+.*?rel\s*=\s*"?SHORTCUT ICON"?\s+.*?href\s*=\s*"?' + REG_URL + '"?.*?>';
      title_reg := '<\s*title\s*>((.|\s)*?)<\s*/\s*title\s*>';
      entity_reg := '(&#x\h+;){4,}';
      r.Expression := keywords_reg;
      r.Exec(sHtml);
      sKeywords := Trim(r.Match[1]);
      r.Expression := entity_reg;
      if r.Exec(sKeywords) then sKeywords := '';
//      sKeywords := HTTPDecode(sKeywords);
      r.Expression := description_reg;
      r.Exec(sHtml);
      sDescription := Trim(r.Match[1]);
      r.Expression := entity_reg;
      if r.Exec(sDescription) then sDescription := '';
//      sDescription := ut(HTTPDecode(sDescription), SJIS_OUT);
      r.Expression := icon_reg;
      r.Exec(sHtml);
      sIconUrl := Trim(r.Match[1]);
      if sIconUrl = '' then begin
        r.Expression := REG_URLTOP;
        r.Exec(url);
        sIconUrl := r.Match[0];
        sIconUrl := ExcludeTrailingPathDelimiter(sIconUrl);
        sIconUrl := sIconUrl + '/' + FEVICON;
      end else if Pos('http', sIconUrl) = 0 then begin
        sIconUrl := GetCurrentDir(url) + sIconUrl;
      end;
      r.Expression := title_reg;
      r.Exec(sHtml);
      sTitle := Trim(r.Match[1]);
      if sTitle = '' then sTitle := url;
      if sTitle = '404 Not Found' then Exit;

      WSI.Html := sHtml;
      WSI.Title := sTitle;
      WSI.Description := sDescription;
      WSI.Keywords := sKeywords;
      WSI.IconUrl := sIconUrl;

      Result := True;
//      p(title);
//      p(tag);
//      p(comment);
//      p(icon);
    finally
      r.Free;
    end;
  end else begin
    Result := False;
//    MessageDlg('サイト情報の取得に失敗しました。', mtInformation, [mbOK], 0);
  end;
end;
/////////////////////////////////////  
const
  rc3_StockIcon = 0;
  rc3_Icon = 1;
  rc3_Cursor = 2;

type
  PCursorOrIcon = ^TCursorOrIcon;
  TCursorOrIcon = packed record
    Reserved: Word;
    wType: Word;
    Count: Word;
  end;

  PIconRec = ^TIconRec;
  TIconRec = packed record
    Width: Byte;
    Height: Byte;
    Colors: Word;
    Planes: Word;
    BitCount: Word;
    DIBSize: Longint;
    DIBOffset: Longint;
  end;

procedure SaveBitmapToStreamAsIcon(Bitmap: TBitmap; Stream: TStream);
const
  CI: TCursorOrIcon = (Reserved: 0; wType: rc3_Icon; Count: 1);
  MaxBitmapInfoSize = SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) * 256;
var
  ColorInfoSize: Cardinal;
  ColorImageSize: Cardinal;
  MaskInfoSize: Cardinal;
  MaskImageSize: Cardinal;
  ColorCount: Integer;
  Size: Integer;
  Buf: Pointer;
  IconRec: PIconRec;
  ColorInfo: PBitmapInfo;
  ColorImage: Pointer;
  MaskImage: Pointer;
  MaskInfo: array[0..MaxBitmapInfoSize-1] of Byte;
begin
  GetDIBSizes(Bitmap.Handle, ColorInfoSize, ColorImageSize);
  GetDIBSizes(Bitmap.MaskHandle, MaskInfoSize, MaskImageSize);
  Size := SizeOf(TCursorOrIcon) + SizeOf(TIconRec)
             + ColorInfoSize + ColorImageSize + MaskImageSize;
  Buf := AllocMem(Size);
  try
    Integer(IconRec) := Integer(Buf) + SizeOf(TCursorOrIcon);
    Integer(ColorInfo) := Integer(IconRec) + SizeOf(TIconRec);
    Integer(ColorImage) := Cardinal(ColorInfo) + ColorInfoSize;
    Integer(MaskImage) := Cardinal(ColorImage) + ColorImageSize;
    PCursorOrIcon(Buf)^ := CI;
    GetDIB(Bitmap.Handle, 0, ColorInfo^, ColorImage^);
    GetDIB(Bitmap.MaskHandle, 0, MaskInfo, MaskImage^);
    with IconRec^, ColorInfo^.bmiHeader do begin
      if (biWidth >= 1) and (biWidth < 256) then Width := biWidth;
      if (biHeight >= 1) and (biHeight < 256) then Height := biHeight;
      ColorCount := 1 shl (biPlanes * biBitCount);
      if (ColorCount >= 1) and (ColorCount < 256) then
        Colors := ColorCount;
      Planes := biPlanes;
      BitCount := biBitCount;
      DIBSize := Size;
      DIBOffset := SizeOf(TCursorOrIcon) + SizeOf(TIconRec);
    end;
    with PBitmapInfoHeader(ColorInfo)^ do biHeight := biHeight * 2;
    Stream.WriteBuffer(Buf^, Size);
  finally
    FreeMem(Buf);
  end;
end;

procedure SaveBitmapToFileAsIcon(Bitmap: TBitmap; const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveBitmapToStreamAsIcon(Bitmap, Stream);
  finally
    Stream.Free;
  end;
end;
//////////////////////////////////////////////
     
procedure ExtractFileIcon(FileName: string; AIcon: TIcon);
var ext, res: string; idx: Integer;
begin
  if AIcon = nil then raise Exception.Create('アイコンが生成されていません。');
  ext := LowerCase(ExtractFileExt(FileName));
  //ショートカットだったとき
  if ext = '.lnk' then begin
    FileName := GetInfofromLinkFile(FileName).Filename;
    ext := LowerCase(ExtractFileExt(FileName));
  end;
  if (ext = '.ico') then            //アイコン
    AIcon.LoadFromFile(FileName)
  else if (ext = '.exe') then begin //実行ファイル
    if not SaveIcons(FileName, 0, AIcon) then
      //実行ファイルがリソースを持たないときshell32.dllから取得
      SaveIcons(IncludeTrailingPathDelimiter(GetSystemDir) + 'shell32.dll', 2, AIcon);
  end else begin                    //その他アイコンリソースを持たないファイル
    GetDefaultIconResInfo(FileName, res, idx); //関連付けからリソース情報を取得
    ext := LowerCase(ExtractFileExt(res));
    if (ext = '.ico') then          
      AIcon.LoadFromFile(res)      //アイコン
    else
      SaveIcons(res, idx, AIcon);  //その他リソースファイル
  end;
end;

//procedure ExtractFileIcon(FileName: string; AIcon: TIcon);
//var bmp: TBitmap;dib: TNkDIB; fn: string; Icon: TIcon;
//begin
//  dib := TNkDIB.Create;
//  bmp := TBitmap.Create;
//  Icon := TIcon.Create;
//  try
//    Icon.Transparent := True;
//    Icon.Handle := ExtractIconEx(FileName);
//    dib.Width := 32; dib.Height := 32;
//    dib.Transparent := True;
//    bmp.Height := 32; bmp.Width := 32;
//    bmp.TransparentMode := tmAuto;
//    bmp.Canvas.Draw(0, 0, Icon);
//    bmp.Transparent := True;
//    bmp.TransparentColor := clWhite;
//    dib.Assign(bmp);
//    fn := TmpPath + FormatDateTime('yyyymmddhhnnsszzz".ico"', Now);
////    SaveBitmapToFileAsIcon(bmp, fn);
//    SaveIcon(dib, fn);
//    AIcon.Transparent := True;
////    AIcon.Assign(Icon);
//    AIcon.LoadFromFile(fn);
//  finally
//    if FileExists(fn) then
//      DeleteFile(fn);
//    bmp.Free;
//    dib.Free;
//    Icon.Free;
//  end;
//end;

procedure Msg(Text: String);
begin
  MessageDlg(Text, mtInformation, [mbOK], 0);
end;

function GetNotSameItemSql(EditingItem: TCommonItem): string;
begin
  Result := '';
  if Assigned(EditingItem) then
    Result := ' AND ( NOT (' +
      CN_TABLE_ID + ' = ' + IntToStr(EditingItem.MyTableID) + ' AND ' +
      CN_PARENT_ID + ' = ' + IntToStr(EditingItem.ID) + ' ))';
end;
      
function GetKeySql(Cls: TItemClass; id: Int64; sKey: string): string;
begin
  Result := '(' + CN_KEY+'='+IntToStr(Word(TextToShortCut(sKey))) + ') AND ' +
    '(' + CN_KEY + ' <> ' + '0' +  ') AND ' +
    '(NOT(' + CN_ID + ' = ' + IntToStr(id) + '));';
end;

function KeyExsist(Cls: TItemClass; id: Int64; sKey: string): Boolean;
begin
  Result := Cls.RecordCount(GetKeySql(Cls, id, sKey)) <> 0;
//  Result := Cls.RecordCount(
//    '(' + CN_KEY+'='+IntToStr(Word(TextToShortCut(sKey))) + ') AND ' +
//    '(' + CN_KEY + ' <> ' + '0' +  ') AND ' +
//    '(NOT(' + CN_ID + ' = ' + IntToStr(id) + '));'
//    ) <> 0;
end;

function DeleteKey(Cls: TItemClass; id: Int64; sKey: string): Int64;
var table: string;
begin
  if Cls = TShortcutKeyItem then
    table := TB_SHORTCUT_KEYS
  else
    table := TB_HOT_KEYS;
  Result := GetKeyId(Cls, id, sKey);
  if Result = 0 then Exit;
  SQLiteDB.ExecSQL('UPDATE ' + table + ' SET ' +
    CN_KEY + ' = 0 WHERE ' + CN_ID + ' = ' + IntToStr(Result));
end;

function GetKeyId(Cls: TItemClass; id: Int64; sKey: string): Int64;
var tb: TSQLiteTable;
begin
  Result := 0;                         
  tb := Cls.Select(GetKeySql(Cls, id, sKey));
  try
    if not tb.MoveFirst then Exit;
    Result := tb.FieldAsInteger(tb.FieldIndex[CN_ID]);
  finally
    tb.Free;
  end;
end;

function GetMouseItemExistSqlAfterWhere(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): string;
var s: string;
begin
  if id = 0 then s := ';'
  else s := 'AND (NOT(' + CN_ID + ' = ' + IntToStr(id) + '))';
  Result := 
      '(' + CN_ENABLED + ' = ' + IntToStr(Integer(Enable)) + ') AND ' +
      '(' + CN_ACTION + ' = ' + IntToStr(Ord(MouseAction)) + ') AND ' +
      '(' + CN_KEY_FLAGS + ' = ' + IntToStr(MouseKeyFlags) + ') AND ' +
      ' ((' + CN_RTN_POSES  + ' & ' + IntToStr(Word(MouseRtnPoses)) + ') <> 0) ' +
      s
      ;
end;

function GetMouseItemId(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): Int64;
var tb: TSQLiteTable;
begin
  Result := 0;
  tb := TMouseItem.Select(GetMouseItemExistSqlAfterWhere(
    id, Enable, MouseAction, MouseKeyFlags, MouseRtnPoses));
  try
    if not tb.MoveFirst then Exit;
    Result := tb.FieldAsInteger(tb.FieldIndex[CN_ID]);
  finally
    tb.Free;
  end;
end;

function DeleteMouseKey(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): Int64;
begin
  Result := GetMouseItemId(id, Enable, MouseAction, MouseKeyFlags, MouseRtnPoses);
  if Result = 0 then Exit;
  SQLiteDB.ExecSQL('UPDATE ' + TB_MOUSE_ITEMS + ' SET ' +
    CN_ENABLED + ' = 0, ' +
    CN_ACTION + ' = 0, ' +
    CN_KEY_FLAGS + ' = 0, ' +
    CN_RTN_POSES + ' = 0 ' +
    ' WHERE ' + CN_ID + ' = ' + IntToStr(Result));
end;

function MouseItemExist(id: Int64; Enable: Boolean;
  MouseAction: TMouseAction; MouseKeyFlags: Integer; MouseRtnPoses: TMouseRtnPoses): Boolean;
//var s: string;
begin
//  if id = 0 then s := ';'
//  else s := 'AND (NOT(' + CN_ID + ' = ' + IntToStr(id) + '))';
  Result := TMouseItem.RecordCount(GetMouseItemExistSqlAfterWhere(
    id, Enable, MouseAction, MouseKeyFlags, MouseRtnPoses)) > 0;
end;

function VKeyToKeyStr(Key: Word): string;
//var IsShift: Boolean;
begin
//  IsShift:=(GetKeyState(VK_SHIFT)   and (1 shl 15))<>0;
  Result := IntToHex(Key, 2);
  case Key of
    $30..$39, //0-9
    $41..$5A  //A-Z
      : Result := Char(Key);
    $60..$69: Result := Char(Key - $30); //0-9テンキー
    VK_BACK: Result := '[BS]';
    VK_TAB: Result := '[Tab]';
    VK_CLEAR: Result := '[Clear]';
    VK_RETURN, VK_SEPARATOR: Result := '[Enter]';
    VK_SHIFT, VK_LSHIFT, VK_RSHIFT: Result := '[Shift]';
    VK_CONTROL, VK_LCONTROL, VK_RCONTROL: Result := '[Ctrl]';
    VK_MENU, VK_LMENU, VK_RMENU: Result := '[Alt]';
    VK_PAUSE: Result := '[Pause]';
    VK_CAPITAL: Result := '[CapsLock]';
    VK_KANA: Result := '[Kana]';
    VK_KANJI: Result := '[Kanji]';
    VK_ESCAPE: Result := '[Esc]';
    VK_CONVERT: Result := '[Convert]';
    VK_NONCONVERT: Result := '[NonConvert]';
    VK_MODECHANGE: Result := '[ModeChange]';
    VK_SPACE: Result := '[Space]';
    VK_PRIOR: Result := '[PageUp]';
    VK_NEXT: Result := '[PageDown]';
    VK_END: Result := '[End]';
    VK_HOME: Result := '[Home]';
    VK_LEFT: Result := '[Left]';
    VK_UP: Result := '[Up]';
    VK_RIGHT: Result := '[Right]';
    VK_DOWN: Result := '[Down]';
    VK_SELECT: Result := '[Select]';
    VK_PRINT: Result := '[Print]';
    VK_EXECUTE: Result := '[Execute]';
    VK_SNAPSHOT: Result := '[PrintScreen]';
    VK_INSERT: Result := '[Insert]';
    VK_DELETE: Result := '[Delete]';
    VK_HELP: Result := '[Help]';
    VK_LWIN, VK_RWIN: Result := '[Win]';
    VK_APPS: Result := '[Apps]';
    $5F{VK_SLEEP}: Result := '[Sleep]';
    VK_MULTIPLY: Result := '[*]';
    VK_ADD: Result := '[+]';
    VK_SUBTRACT: Result := '[-]';
    VK_DECIMAL: Result := '[.]';
    VK_DIVIDE: Result := '[/]';
    VK_F1: Result := '[F1]';
    VK_F2: Result := '[F2]';
    VK_F3: Result := '[F3]';
    VK_F4: Result := '[F4]';
    VK_F5: Result := '[F5]';
    VK_F6: Result := '[F6]';
    VK_F7: Result := '[F7]';
    VK_F8: Result := '[F8]';
    VK_F9: Result := '[F9]';
    VK_F10: Result := '[F10]';
    VK_F11: Result := '[F11]';
    VK_F12: Result := '[F12]';
    VK_F13: Result := '[F13]';
    VK_F14: Result := '[F14]';
    VK_F15: Result := '[F15]';
    VK_F16: Result := '[F16]';
    VK_F17: Result := '[F17]';
    VK_F18: Result := '[F18]';
    VK_F19: Result := '[F19]';
    VK_F20: Result := '[F20]';
    VK_F21: Result := '[F21]';
    VK_F22: Result := '[F22]';
    VK_F23: Result := '[F23]';
    VK_F24: Result := '[F24]';
    VK_NUMLOCK: Result := '[NumLock]';
    VK_SCROLL: Result := '[ScrollLock]';
//    $31: Result := '!';
//    $32: Result := '"';
//    $33: Result := '#';
//    $35: Result := '%';
//    $36: Result := '&';
//    $37: Result := '''';
//    $38: Result := '(';
//    $39: Result := ')';
//    $3A: Result := '[$]';
//    $6E: Result := '.';
    $BA: {if IsShift then Result := '[*]' else }Result := '[:]';
    $BB: {if IsShift then Result := '[+]' else }Result := '[;]';
    $BC: {if IsShift then Result := '[<]' else }Result := '[,]';
    $BD: {if IsShift then Result := '[=]' else }Result := '[-]';
    $BE: {if IsShift then Result := '[>]' else }Result := '[.]';
    $BF: {if IsShift then Result := '[*]' else }Result := '[/]';
    $C0: {if IsShift then Result := '[`]' else }Result := '[@]';
    $DB: {if IsShift then Result := '{' else }Result := '[';
    $DC: {if IsShift then Result := '[|]' else }Result := '[\]';
    $DD: {if IsShift then Result := ']' else }Result := ']';
    $DE: {if IsShift then Result := '[~]' else }Result := '[^]';
    $E2: Result := '[_]';
//  else Result := IntToHex(Key, 2);
  end;
end;

function KeyStrToVKey(KeyStr: string): Word;
begin
  Result := $00;
  if Length(KeyStr) = 1 then begin
    Result := Ord(KeyStr[1]);
  end else if Length(KeyStr) = 3 then begin
    Result := Ord(KeyStr[2]);
  end else begin
    if KeyStr = '[BS]' then Result := VK_BACK
    else if KeyStr = '[Tab]' then Result := VK_TAB
    else if KeyStr = '[Clear]' then Result := VK_CLEAR
    else if KeyStr = '[Enter]' then Result := VK_RETURN
    else if KeyStr = '[Shift]' then Result := VK_SHIFT
    else if KeyStr = '[Ctrl]' then Result := VK_CONTROL
    else if KeyStr = '[Alt]' then Result := VK_MENU
    else if KeyStr = '[Pause]' then Result := VK_PAUSE
    else if KeyStr = '[CapsLock]' then Result := VK_CAPITAL
    else if KeyStr = '[Kana]' then Result := VK_KANA
    else if KeyStr = '[Kanji]' then Result := VK_KANJI
    else if KeyStr = '[Esc]' then Result := VK_ESCAPE
    else if KeyStr = '[Convert]' then Result := VK_CONVERT
    else if KeyStr = '[NonConvert]' then Result := VK_NONCONVERT
    else if KeyStr = '[ModeChange]' then Result := VK_MODECHANGE
    else if KeyStr = '[Space]' then Result := VK_SPACE
    else if KeyStr = '[PageUp]' then Result := VK_PRIOR
    else if KeyStr = '[PageDown]' then Result := VK_NEXT
    else if KeyStr = '[End]' then Result := VK_END
    else if KeyStr = '[Home]' then Result := VK_HOME
    else if KeyStr = '[Left]' then Result := VK_LEFT
    else if KeyStr = '[Up]' then Result := VK_UP
    else if KeyStr = '[Right]' then Result := VK_RIGHT
    else if KeyStr = '[Down]' then Result := VK_DOWN
    else if KeyStr = '[Select]' then Result := VK_SELECT
    else if KeyStr = '[Print]' then Result := VK_PRINT
    else if KeyStr = '[Execute]' then Result := VK_EXECUTE
    else if KeyStr = '[PrintScreen]' then Result := VK_SNAPSHOT
    else if KeyStr = '[Insert]' then Result := VK_INSERT
    else if KeyStr = '[Delete]' then Result := VK_DELETE
    else if KeyStr = '[Help]' then Result := VK_HELP
    else if KeyStr = '[Win]' then Result := VK_LWIN
    else if KeyStr = '[Apps]' then Result := VK_APPS
    else if KeyStr = '[Sleep]' then Result := $5F
    else if KeyStr = '[F1]' then Result := VK_F1
    else if KeyStr = '[F2]' then Result := VK_F2
    else if KeyStr = '[F3]' then Result := VK_F3
    else if KeyStr = '[F4]' then Result := VK_F4
    else if KeyStr = '[F5]' then Result := VK_F5
    else if KeyStr = '[F6]' then Result := VK_F6
    else if KeyStr = '[F7]' then Result := VK_F7
    else if KeyStr = '[F8]' then Result := VK_F8
    else if KeyStr = '[F9]' then Result := VK_F9
    else if KeyStr = '[F10]' then Result := VK_F10
    else if KeyStr = '[F11]' then Result := VK_F11
    else if KeyStr = '[F12]' then Result := VK_F12
    else if KeyStr = '[F13]' then Result := VK_F13
    else if KeyStr = '[F14]' then Result := VK_F14
    else if KeyStr = '[F15]' then Result := VK_F15
    else if KeyStr = '[F16]' then Result := VK_F16
    else if KeyStr = '[F17]' then Result := VK_F17
    else if KeyStr = '[F18]' then Result := VK_F18
    else if KeyStr = '[F19]' then Result := VK_F19
    else if KeyStr = '[F20]' then Result := VK_F20
    else if KeyStr = '[F21]' then Result := VK_F21
    else if KeyStr = '[F22]' then Result := VK_F22
    else if KeyStr = '[F23]' then Result := VK_F23
    else if KeyStr = '[F24]' then Result := VK_F24
    else if KeyStr = '[NumLock]' then Result := VK_NUMLOCK
    else if KeyStr = '[ScrollLock]' then Result := VK_SCROLL;
  end;
end;

function ExistActionShortCut(al: TActionList; sc: TShortCut): Boolean;
var i: Integer;
begin
  Result := False;
  if sc = 0 then Exit;
  for i := 0 to al.ActionCount-1 do begin
    if sc = TAction(al.Actions[i]).ShortCut then begin
      Result := True;
      Exit;
    end;
  end;
end;

function MakeLaunchTag(pn, cn: string): string;
begin
  Result := '';
  if Trim(pn) <> '' then
    Result := AnsiQuotedStr(pn, '"') + ',';
  if Trim(cn) <> '' then
    Result := Result + AnsiQuotedStr(cn, '"') + ',';
  Result := Copy(Result, 1, Length(Result)-1);
end;

end.
