{
ボタンを押してオープンダイアログでリソースDLLかEXEファイルを選択すると
カレントフォルダにグループアイコン全てを抽出し保存します。

アイコン抽出といえばExtractIconかExtractIconExですが
HICONから作ったIconインスタンスをSaveすると16色の単一アイコンでしか保存できません。
それを解決する方法をネットで探したのですがDelphiの例が無いようなので
作成してみました。スマートな方法ではないかもしれませんがご了承ください。

参考サイト

実行ファイルからアイコンを取り出す
http://hp.vector.co.jp/authors/VA016117/rsrc2icon.html
ICO(CUR) ファイルフォーマット
http://www14.ocn.ne.jp/~setsuki/ext/ico.htm
アイコンファイルフォーマット
http://www.river.sannet.ne.jp/yuui/fileformat/icon.html
}
unit IconRes;

interface

uses
  Windows, SysUtils, Classes, Graphics, Registry, yhFiles;


//ファイルに関連付けられているリソース情報を得る
function GetDefaultIconResInfo(const FileName: string;
    var ResFileName: string; var ResIndex: Integer): Boolean;
//ファイル内のアイコンを保存する
function SaveIcons(FileName: string; Index: Integer; Icon: TIcon): Boolean;
//アイコンの列挙に使われるコールバック関数
function EnumResNameProc(hModule: HWND; lpszType: LPCTSTR;
                lpszName: LPTSTR; lParam: Longint): Boolean; stdcall;

implementation

type
  //アイコンファイルのヘッダ情報
  PIconFileHeader = ^TIconFileHeader;
  TIconFileHeader = packed record
    Reserved: Word;
    wType: Word;  // 種別。アイコンかカーソルかを示す。
    Count: Word;  // アイコンの数
  end;

  PIconFileInfo = ^TIconFileInfo;
  TIconFileInfo = packed record
    Width: Byte;       // 幅
    Height: Byte;      // 高さ
    Colors: Word;      // 色数
    Reserved1: Word;
    Reserved2: Word;
    Size: DWORD;     // アイコンイメージの大きさ。
                     // 2個のDIBイメージを含む
    Offset: DWORD;   // アイコンイメージのファイルの
                     // 先頭からの位置
  end;

  //アイコンリソースのヘッダ情報
  PIconResHeader = ^TIconResHeader;
  TIconResHeader = TIconFileHeader;

  PIconResInfo = ^TIconResInfo;
  TIconResInfo = packed record
    Width: Byte;       // 幅
    Height: Byte;      // 高さ
    Colors: Word;      // 色数
    Reserved1: Word;
    Reserved2: Word;
    Size: DWORD;       // アイコンイメージの大きさ。
                       // 2個のDIBイメージを含む
    ID: Word;          //各アイコンのリソースＩＤ
  end;
  TIconResInfos  = array of TIconResInfo;
  TIconFileInfos = array of TIconFileInfo;

var
  g_Index: Integer;
  g_Icon: TIcon;
  hFile: HWND;

//ファイルに関連付けられているリソース情報を得る
function GetDefaultIconResInfo(const FileName: string;
    var ResFileName: string; var ResIndex: Integer): Boolean;
var ext, FileType, ClassType, IconResStr, rfn, ri: string; reg: TRegistry;
  commaPos: Integer;
begin
  ext := ExtractFileExt(FileName);
  //初期値設定
  //アイコンリソース取得失敗の際は
  //リソースファイル=%SystemRoot%\System32\shell32.dll
  //リソースインデックス= 0 になる
  Result := False;
  ResFileName := IncludeTrailingPathDelimiter(GetSystemDir) + 'shell32.dll';
  ResIndex := 0;
  IconResStr := '';

  reg := TRegistry.Create(KEY_READ);
  try
    //「拡張子」に対して関連付けられたアイコンリソース文字列の取得
    reg.RootKey := HKEY_CLASSES_ROOT;
    if not reg.OpenKey(ext, False) then Exit;
    //ファイルタイプの取得
    FileType := reg.ReadString('');
    if FileType = '' then Exit;

    //HKEY_LOCAL_MACHINE\Software\Classes\以下から取得
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('Software\Classes\' + FileType + '\DefaultIcon', False) then
      IconResStr := reg.ReadString('');
    if IconResStr = '' then begin
      //HKEY_CLASSES_ROOT\以下から取得
      reg.RootKey := HKEY_CLASSES_ROOT;
      if reg.OpenKey(FileType + '\DefaultIcon', False) then
        IconResStr := reg.ReadString('');
    end;

    //↑でアイコンリソース文字列の取得に失敗しても
    //「分類」に対して関連付けがある場合取得
    reg.OpenKey(ext, False);
    if (IconResStr = '') and reg.ValueExists('PerceivedType') then begin
      //分類タイプの取得
      ClassType := reg.ReadString('PerceivedType');
      if ClassType = '' then Exit;

      //HKEY_LOCAL_MACHINE\Software\Classes\以下から取得
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey('Software\Classes\SystemFileAssociations\' + ClassType + '\DefaultIcon', False) then
        IconResStr := reg.ReadString('');
      if IconResStr = '' then begin
        ////HKEY_CLASSES_ROOT\以下から取得
        reg.RootKey := HKEY_CLASSES_ROOT;
        if reg.OpenKey('SystemFileAssociations\' + ClassType + '\DefaultIcon', False) then
          IconResStr := reg.ReadString('');
      end;
    end;
    if IconResStr = '' then Exit;  
    if IconResStr = '%1' then Exit;

    //アイコンリソース文字列をコンマの前後でリソースファイルと
    //リソースインデックス番号（マイナス値だとリソースID）に分解
    commaPos := Pos(',', IconResStr); //コンマ位置
    if commaPos <> 0 then begin
      rfn := Trim(Copy(IconResStr, 1, commaPos-1));
      ri := Trim(Copy(IconResStr, commaPos+1, Length(IconResStr)));
    end else begin
      //コンマがないときはそのまま
      rfn := Trim(IconResStr);
      ri := '0';
    end;

    rfn := ExpandPath(rfn);
    ResFileName := rfn;             //リソースファイルを返す
    ResIndex := StrToIntDef(ri, 0); //リソース数値を返す
    Result := False;
  finally
    reg.Free;
  end;
end;

//指定されたＩＤを持つアイコンのデータをコピーする
function StoreIconData(hFile: HWND; ID: Word; var pMem: PByte): DWORD;
var hIcon,hLoadIcon: HRSRC;
  pLoadIcon: PByte; Size: Cardinal;
begin
  Result := 0;
  //リソースを探す
  hIcon := FindResource(hFile, MakeIntResource(ID), RT_ICON);
  if hIcon = 0 then Exit;
  //リソースのロード
  hLoadIcon := LoadResource(hFile, hIcon);
  if hLoadIcon = 0 then Exit;
  //リソースのロック
  pLoadIcon := LockResource(hLoadIcon);
  if pLoadIcon = nil then Exit;
  //リソースの大きさ
  Size := SizeofResource(hFile, hIcon);
  //リソースポインタを渡す
  pMem := pLoadIcon;

  Result := Size;
end;

//グループアイコンの格納に必要なサイズを取得する
function GetGroupIconSize(IconResInfos: TIconResInfos): Cardinal;
var i, Count: Integer; Size: Cardinal; //pMem: Pointer;
begin
  Count := Length(IconResInfos);
  //それぞれのアイコンのサイズを合計して全体の大きさを求める
  Size := sizeof(TIconFileHeader) + sizeof(TIconFileInfo) * Count;
  for i := Low(IconResInfos) to High(IconResInfos) do
    Size := Size + IconResInfos[i].Size;
  Result := Size;
end;

//アイコンの列挙に使われるコールバック関数
function EnumResNameProc(hModule: HWND; lpszType: LPCTSTR;
                lpszName: LPTSTR; lParam: Longint): Boolean;
var
  pRes, pResInfos, pMem, pMemTmp: PByte;
  irh: PIconResHeader;
  ifh: TIconFileHeader;
  IconResInfos: TIconResInfos;
  IconFileInfos: TIconFileInfos;
  hGIcon,hLoadGIcon: HWND;
  AllSize, HeadSize, IconCount, IconSize: Cardinal;
//  IcoName: string;
//  hFile: HWND;
  ms: TStream;
  i, IconID: Integer;
  pLoadIcon: PByte;
  LoadIconList, IconSizeList: TList;
begin
  Result := True;
  IconID := Integer(lpszName);
  if g_Index <> 0 then begin
    if lParam >= 0 then begin
      if lParam <> g_Index then begin
        Inc(g_Index);
        Exit;
      end;
    end else begin
      if IconID <> Abs(lParam) then begin
        Inc(g_Index);
        Exit;
      end;
    end;
  end;
//  if {(lParam >= 0) and }(g_Index <> lParam) and (g_Index <> 0) then begin
//    Inc(g_Index);
//    Exit;
//  end;
//  DOutI(g_Index);

  //グループアイコンリソースを検索
  hGIcon := FindResource(hFile, lpszName, RT_GROUP_ICON);
  if hGIcon = 0 then Exit;

  //見つけたリソースをロード
  hLoadGIcon := LoadResource(hFile, hGIcon);
  if hLoadGIcon = 0 then Exit;

  //リソースをロックして、メモリアドレスを得る
  pRes := LockResource(hLoadGIcon);

  irh := PIconResHeader(pRes);
  IconCount := irh.Count;
  SetLength(IconResInfos, IconCount);  
  SetLength(IconFileInfos, IconCount);
  pResInfos := Pointer(Cardinal(irh) + sizeof(TIconResHeader));
  //IconResInfosにリソース情報をコピー
  CopyMemory(IconResInfos, pResInfos, sizeof(TIconResInfo) * IconCount);

  //アイコン全体のサイズを計算する
  AllSize := GetGroupIconSize(IconResInfos);

  pMem := GetMemory(AllSize); //アイコンデータのあるアドレス計算用ポインタ
  if pMem = nil then Exit;
//  IcoName := ExtractFilePath(ParamStr(0)) + Format('icon%.3d.ico', [g_Index]);
  //ファイルストリームの作成
  ms := TMemoryStream.Create;
  ms.Position := 0;
  //画像データポインタの保存リスト
  LoadIconList := TList.Create;
  //画像データサイズの保存リスト
  IconSizeList := TList.Create;
  try
    //アイコンファイルヘッダの作成
    ifh.Reserved := 0; //予約
    ifh.Count := IconCount;
    ifh.wType := 1;  //アイコン
    //アイコンファイルヘッダを書き込む
    ms.Write(ifh, sizeof(TIconFileHeader));

    pMemTmp := pMem;
    //アイコンファイルのヘッダサイズの計算
    HeadSize := sizeof(TIconFileHeader) + sizeof(TIconFileInfo) * IconCount;
    Inc(pMemTmp, HeadSize);
    //アイコンヘッダ情報の書き込み
    for i := 0 to IconCount-1 do begin

      IconSize := StoreIconData(hFile, IconResInfos[i].ID, pLoadIcon);
      if IconSize = 0 then Exit;
      //画像データポインタをリストにストック
      LoadIconList.Add(pLoadIcon);
      //画像データサイズをリストにストック
      IconSizeList.Add(Pointer(IconSize));

      //ヘッダ情報の更新
      IconFileInfos[i].Width := IconResInfos[i].Width;
      IconFileInfos[i].Height := IconResInfos[i].Height;
      IconFileInfos[i].Colors := IconResInfos[i].Colors;
      IconFileInfos[i].Size := IconSize;
      //アイコンデータのあるアドレス
      IconFileInfos[i].Offset := Cardinal(pMemTmp) - Cardinal(pMem);

      ms.Write(IconFileInfos[i], SizeOf(TIconFileInfo));
      Inc(pMemTmp, IconSize);
    end;
    //画像の書き込み
    for i := 0 to LoadIconList.Count-1 do begin
      //画像データの書き込み
      ms.Write(LoadIconList[i]^, Cardinal(IconSizeList[i]));
    end;
    ms.Position := 0;
    g_Icon.LoadFromStream(ms);
    Inc(g_Index);
  finally
    ms.Free;
    LoadIconList.Free;
    IconSizeList.Free;
    FreeMemory(pMem);
  end;
end;

//ファイル内のアイコンを保存する
function SaveIcons(FileName: string; Index: Integer; Icon: TIcon): Boolean;
var res: Boolean;
begin
  Result := False;
  g_Index := 0;

  if Icon = nil then Exit;
  g_Icon := Icon;

  hFile := LoadLibraryEx(PChar(FileName), 0,
    LOAD_LIBRARY_AS_DATAFILE or LOAD_WITH_ALTERED_SEARCH_PATH);
  try
    if hFile = 0 then Exit;

    //アイコンを列挙して保存
    res := EnumResourceNames(hFile, RT_GROUP_ICON, @EnumResNameProc, Index);
    if not res then Exit;
  finally
    FreeLibrary(hFile);
  end;

//  Icon := g_Icon;

  Result := True;
end;

end.

