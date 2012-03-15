{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
unit IconEx;

interface

uses
  Windows, SysUtils, Classes, Graphics;

type
  EIconExError = class(Exception);

  TIconEx = class(TGraphic)
  private
    FImage: TMemoryStream;      // アイコンファイルイメージ
    FHandle: HICON;             // アイコンハンドル
    FWidth: Integer;            // 幅、高さ
    FHeight: Integer;
    procedure HandleNeeded;     // ハンドルを作る
    procedure ImageNeeded;      // アイコンファイルイメージを作る
    function GetHandle: THandle;// ハンドルを取得する
    // アイコンハンドルをセットする
    procedure SetHandle(const Value: THandle);
  protected
    // 実装必須の標準インターフェース
    function GetWidth: Integer; override;
    function GetHeight: Integer; override;
    procedure SetWidth(Value: Integer); override;
    procedure SetHeight(Value: Integer); override;
    function GetEmpty: Boolean; override;
    function GetTransParent: Boolean; override;
    procedure SetTransparent(Value: Boolean); override;
  public
    // 実装必須の標準インターフェース
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
                                      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
                                    var APalette: HPALETTE); override;

    constructor Create; override;
    destructor  Destroy; override;

    // アイコンハンドル
    property Handle: THandle read GetHandle write SetHandle;
  end;

var
  IConExClipboardFormatID: Integer; // アイコンファイルイメージの
                                    // クリップボード形式ID

procedure Register;

implementation

uses Clipbrd;

procedure Register;
begin end;


type
  // アイコンファイルイメージの宣言
  PIconFileHeader = ^TIconFileHeader;
  TIconFileHeader = packed record
    Reserved: Word;
    wType: Word;  // 種別。アイコンかカーソルかを示す。
    Count: Word;  // アイコンの数
  end;

  // アイコンディレクトリのレコード(アイコン情報)の宣言
  PIconInfo = ^TIconRec;
  TIconRec = packed record
    Width: Byte;       // 幅
    Height: Byte;      // 高さ
    Colors: Word;      // 色数
    Reserved1: Word;
    Reserved2: Word;
    DIBSize: Longint;  // アイコンイメージの大きさ。
                       // 2個のDIBイメージを含む
    DIBOffset: Longint;// アイコンイメージのファイルの
                       // 先頭からの位置
  end;



{ TIconEx }

procedure TIconEx.Assign(Source: TPersistent);
var
  Clip: TClipBoard;
  AData: THandle;
begin
  if Source is TIconEx then // 代入元が TIconEx
  begin
    // 幅、高さとアイコンファイルイメージをコピーする
    FImage.Size := 0;
    FImage.CopyFrom((Source as TIconEx).FImage, 0);
    FWidth := (Source as TIconEx).FWidth;
    FHEight := (Source as TIconEX).FHeight;
    if FHandle <> 0 then
    begin
      DestroyIcon(FHandle);
      FHandle := 0;
    end;
  end
  // 代入元がクリップボード
  else if Source is TClipBoard then begin
    Clip := Source as TClipBoard;
    Clip.Open;
    //　アイコンファイルイメージを引き取る
    try
      // クリップボードから ClipboardFormat 型のデータを取得
      AData := Clip.GetAsHandle(IconExClipboardFormatID);

      // ここで、データが取得できたかのチェックはしない。
      // ADataのチェックは LoadFromClipboardFormat が行う。

      // データを押し込む
      LoadFromClipboardFormat(IconExClipboardFormatID, AData, 0);
    finally
      Clip.Close;
    end;
  end
  else
    inherited;
end;

// コンストラクタ。デフォルトの大きさは System Large Size
constructor TIconEx.Create;
begin
  inherited;
  FImage := TMemoryStream.Create;
  FWidth := GetSystemMetrics(SM_CXICON);
  FHeight := GetSystemMetrics(SM_CYICON);
end;

destructor TIconEx.Destroy;
begin
  FImage.Free;
  if FHandle <> 0 then
    DestroyIcon(FHandle);
  inherited;
end;

procedure TIconEx.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  if Empty then Exit; // 空なら描かない

  DrawIconEx(ACanvas.Handle, Rect.Left, Rect.Top,
             Handle, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
             0, 0, DI_NORMAL);
end;

function TIconEx.GetEmpty: Boolean;
begin
  // アイコンファイルイメージが無い＝空
  if FImage.Size = 0 then
    Result := True
  else
    Result := False;
end;

function TIconEx.GetHandle: THandle;
begin
  HandleNeeded; // アイコンハンドルが未作成なら作る
  Result := FHandle;
end;

function TIconEx.GetHeight: Integer;
begin
  Result := FWidth;
end;

function TIconEx.GetTransParent: Boolean;
begin
  Result := True; // アイコンは常に透明(塗り残しがある可能性有り)
end;

function TIconEx.GetWidth: Integer;
begin
  Result := FHeight;
end;

// DDB のサイズを拡大縮小する
function ResizeDDB(Handle: HBITMAP; cx, cy: Integer): HBITMAP;
var
  Dest, Source: TBitmap;
  BitmapData: Windows.TBitmap;
begin
  Dest := TBitmap.Create;
  try
    // コピー先を作る
    GetObject(Handle, SizeOf(BitmapData), @BitmapData);
    if BitmapData.bmPlanes * BitmapData.bmBitsPixel = 1 then
      Dest.MonoChrome := True;
    Dest.Width := cx; Dest.Height := cy;
    Source := TBitmap.Create;
    try
      Source.Handle := Handle;
      try
        // コピー
        Dest.Canvas.CopyRect(Rect(0, 0, cx, cy),
                             Source.Canvas,
                             Rect(0, 0, Source.Width, Source.Height));
        Result := Dest.ReleaseHandle;
      except
        Source.ReleaseHandle;
        Raise;
      end;
    finally
      Source.Free;
    end;
  finally
    Dest.Free;
  end;
end;

// アイコンファイルイメージからアイコンハンドルを作る
procedure TIconEx.HandleNeeded;
var
  Header: TIconFileHeader;       // アイコンのファイルヘッダ
  IconDir: array of TIconRec;    // アイコンディレクトリ
  IconImage: array of Byte;      // アイコンの DIB情報
  XORBitmap, ANDBitmap: HBITMAP; // アイコンのXORイメージ
  pDIBHeader: PBitmapInfoHeader; // アイコンのANDイメージ
  nColors: Integer;              // 色数
  DC: HDC;                       // GetDC(0)のハンドル
  pBits: PChar;                  // アイコンの DIB のピクセル
                                 //  データ
  IconInfo: TIconInfo;           // CreateIocn 用 Icon情報

  DummyIndex:Integer;
  IconIndex: Integer;            // 選択されたアイコンイメージを
                                 // 表すインデックス
  BestColorCount: Integer;       // アイコンイメージ選択中の
                                 // 最も良い色数
  MaxColorCount: Int64;          // アイコンイメージ選択時の
                                 // アイコンの色数の限界値
  ColorCount: Integer;           // 処理中のアイコンイメージの色数
  i: Integer;
  temp: THandle;

// TRGBQUAD の黒
const Black: TRGBQuad =
  (rgbBlue: 0; rgbGreen: 0; rgbRed: 0; rgbReserved: 0);

// TRGBQUAD の白
const White: TRGBQuad =
  (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0);

var MonoBitmap: TBitmap; // マスクビットマップをモノクロ化用。
begin
  DC := GetDC(0);
  try
    if FHandle <> 0 then Exit;
    if Empty then raise EIconExError.Create('TIconEx is Empty');

    FImage.Position := 0;
    // ファイルヘッダを読む
    FImage.ReadBuffer(Header, SizeOf(Header));
    // アイコンディレクトリを読む
    SetLength(IconDir, Header.Count);
    FImage.ReadBuffer(IconDir[0], SizeOf(TIconRec) * Header.Count);

    // ビデオモードから色の最大値を算出する
    MaxColorCount := Int64(1) shl (GetDeviceCaps(DC, PLANES) *
                                   GetDeviceCaps(DC, BITSPIXEL));
    // 256色を越える色数を区別しない
    if MaxColorCount > 256 then
      MaxColorCount := 99999;

    // とりあえず最初のアイコンを候補にする
    IconIndex := 0;
    BestColorCount := IconDir[0].Colors;
    // 256色以上の色数を区別しない
    if BestColorCount >= 256 then BestColorCount := 99999;

    // アイコンディレクトリの中の全てのアイコンイメージの
    // 中からよさそうなものを探す。
    for i := 1 to Header.Count-1 do
    begin
      // アイコンイメージの色数を取得する
      // 256色以上の色数を区別しない
      ColorCount := IconDir[i].Colors;
      if (ColorCount = 0) or (ColorCount >= 256) then
        ColorCount := 99999;

      // より良いアイコンイメージの条件：
      // 色が最大色数に近い
      // サイズが縦横とも指定サイズに近い
      // サイズ差が同じなら小さいほうが良い
      if (BestColorCount <= ColorCount) and
         (ColorCount <= MaxColorCount)  and
         (abs(IconDir[i].Width - FWidth) <=
          abs(IconDir[IconIndex].Width - FWidth)) and
         (abs(IconDir[i].Height - FHeight) <=
          abs(IconDir[IconIndex].Height - FHeight)) and
         ((IconDir[i].Width <= FWidth) or
          (IconDir[i].Width <= IconDir[IconIndex].Width)) and
         ((IconDir[i].Height <= FHeight) or
          (IconDir[i].Width <= IconDir[IconIndex].Width)) then
      begin
        // より良いものが見つかった！
        IconIndex := i;
        BestColorCount := ColorCount;
      end;
    end;

    // アイコンイメージを読み込む
    FImage.Seek(IconDir[IconIndex].DIBOffset, soFromBeginning);
    SetLength(IconImage, IconDir[IconIndex].DIBSize);
    pDIBHeader := @IconImage[0];
    FImage.ReadBuffer(IconImage[0], IconDir[IconIndex].DIBSize);

    with pDIBHeader^ do
    begin
      // XORイメージをビットマップ化する

      // 高さはXOR とANDイメージの2個分になっているので2で割る
      biHeight := biHeight div 2;
      // 色ビット数は後で使うのでセーブしておく
      // 色数を計算
      if biBitCount > 8 then nColors := 0
                        else nColors := 1 shl biBitCount;

      biSizeImage := 0;
      // ピクセルデータの先頭位置を計算する
      pBits := PCHAR(LongInt(pDIBHeader) +
                     SizeOf(TBitmapInfoHeader) +
                     SizeOf(TRGBQUAD) * nColors);

      // ビットマップヘッダとピクセルデータから Xor イメージを DDB に変換する。
      XORBitmap := CreateDIBitmap(DC, pDIBHeader^, CBM_INIT,
                                  pBits,
                                  PBitmapInfo(pDIBHeader)^,
                                  DIB_RGB_COLORS);

      if XorBitmap = 0 then
        raise EIconExError.Create('Cannot Create XorBitmap');
      try
        // AND のピクセルデータは XOR のピクセルデータの
        // 後ろにあるので、その位置を計算する
        pBits := PChar(LongInt(pBits) +
                       biHeight * ((biBitCount * biWidth + 31) div 32) * 4);

        // ANDイメージはモノクロなので、DIB情報を修正する
        biBitCount := 1;     // モノクロ
        // モノクロに修正
        biSizeImage := 0;
        biClrUsed := 2;      //  モノクロ
        biClrImportant := 2;

        // モノクロ用にカラーテーブルを書き換える
        PBitmapInfo(pDIBHeader).bmiColors[0] := Black;
        DummyIndex := 1;
        PBitmapInfo(pDIBHeader).bmiColors[DummyIndex] := White;

        // ビットマップヘッダとピクセルデータから AND イメージを DDB に変換する。
        ANDBitmap := CreateDIBitmap(DC, pDIBHeader^, CBM_INIT,
                                    pBits,
                                    PBitmapInfo(pDIBHeader)^,
                                    DIB_RGB_COLORS);

        if AndBitmap = 0 then
          raise EIconExError.Create('Cannot Create AndBitmap');
        try
          // Width, Height にあわせて DDB 伸縮する。
          XorBitmap := ResizeDDB(XorBitmap, FWidth, FHeight);
          AndBitmap := ResizeDDB(AndBitmap, FWidth, FHeight);

          MonoBitmap := TBitmap.Create;
          try

            // この段階で AndBitmap はスクリーン互換 DDB だが
            // Windows 95 系列の Windows は AndBitmap をモノクロビットマップ
            // と仮定しているので、モノクロ化する必要がある。そうしないと
            // おかしなアイコンができてしまう。
            // NT系列では不要な処置だが互換性のために必要
            MonoBitmap.Handle := AndBitmap;
            AndBitmap := 0;
            MonoBitmap.Monochrome := True;

            // CreateIcon 用にアイコン情報を作成する
            IconInfo.fIcon := True;
            IconInfo.xHotspot := 0;
            IconInfo.yHotspot := 0;
            IconInfo.hbmMask := MonoBitmap.Handle;
            IconInfo.hbmColor := XorBitmap;

            // アイコンを作成する
            temp := CreateIconIndirect(IconInfo);
            if temp = 0 then
              raise EIconExError.Create('Cannot Create Icon Handle');
            // 出来上がり(^^
            FHandle := temp;
          finally
            MonoBitmap.Free;
          end;
        finally
          if AndBitmap <> 0 then
            DeleteObject(AndBitmap);
        end;
      finally
        DeleteObject(XorBitmap);
      end;
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

// アイコンハンドルからアイコンファイルイメージを作る
procedure TIconEx.ImageNeeded;
var
  IconInfo: TIconInfo;          // アイコン情報
  Header: TIconFileHeader;      // アイコンヘッダ
  IconRec: TIconRec;            // アイコン情報(アイコンディレクトリ用)
  BitmapData: Windows.TBITMAP;  // DDB のデータ
  ColorScanlineLength: Integer; // XOR イメージの Scanline のサイズ
  MonoScanlineLength: Integer;  // AND イメージの Scanline のサイズ
  // ビットマップ情報
  BitmapInfo: array[0..SizeOf(TBitmapInfoHeader) +
                       SizeOf(TRGBQUAD) * 259-1] of Byte;
  // ビットマップのピクセルデータ
  BitmapBits: array of Byte;
  pHeader: PBitmapInfoHeader;
  DC: HDC;
begin
  if FImage.Size > 0 then Exit;

  if FHandle = 0 then
    raise EInvalidOperation.Create('No Handle');

  // まずアイコンハンドルから2個のビットマップ(XOR, AND)を
  // 取得する
  GetIconInfo(FHandle, IconInfo);
  try
    try
      // ストリームにアイコンヘッダを書き込む
      Header.Reserved := 0;
      Header.wType := 1;
      Header.Count := 1; // イメージは1個！
      FImage.WriteBuffer(Header, SizeOf(Header));

      GetObject(IconInfo.hbmColor, SizeOf(BitmapData), @BitmapData);

      // アイコン情報を元に Width/Heightプロパティを更新する。
      FWidth := BitmapData.bmWidth;
      FHeight := BitmapData.bmHeight;

      // アイコン情報を作ってストリームに書き込む
      IconRec.Width := FWidth;
      IconRec.Height := FHeight;

      IconRec.Colors := 16; // 色数は16色固定

      IconRec.DIBOffset := SizeOf(Header) + SizeOf(IconRec);

      ColorScanLineLength := (4 * BitmapData.bmWidth + 31)
                             div 32 *4;
      MonoScanlineLength  := (BitmapData.bmWidth + 31) div 32 *4;
      IconRec.DIBSize := SizeOf(TBitmapInfoHeader) +
                         SizeOf(TRGBQuad) * 16 +
                         ColorScanlineLength * BitmapData.bmHeight +
                         MonoScanlineLength * BitmapData.bmHeight;
      FImage.WriteBuffer(IconRec, SizeOf(IconRec));


      DC := GetDC(0);
      try
        // XOR イメージ(DDB) を DIB に変換しストリームに書く
        pHeader := PBitmapInfoHeader(@BitmapInfo);
        pHeader.biSize := SizeOf(TBitmapInfoHeader);
        pHeader.biWidth := FWidth;
        pHeader.biHeight := FHeight;
        pHeader.biPlanes := 1;
        pHeader.biBitCount := 4; // 16色固定
        pHeader.biCompression := BI_RGB;
        SetLength(BitmapBits, ColorScanLineLength * BitmapData.bmHeight);
        GetDIBits(DC, IconInfo.hbmColor, 0, BitmapData.bmHeight,
                  BitmapBits, pBitmapInfo(pHeader)^, DIB_RGB_COLORS);
        pHeader.biHeight := pHeader.biHeight * 2;
        pHeader.biSizeImage := ((4 * FWidth + 31) div 32) * 4 * FHeight +
                               ((1 * FWidth + 31) div 32) * 4 * FHeight;
        FImage.WriteBuffer(pHeader^,
                           SizeOf(pHeader^) +
                           SizeOf(TRGBQuad) * 16);
        FImage.WriteBuffer(BitmapBits[0], Length(BitmapBits));


        // AND イメージ(DDB) を DIB に変換しストリームに書く
        pHeader.biHeight := FHeight;
        pHeader.biBitCount := 1;
        SetLength(BitmapBits, MonoScanLineLength * BitmapData.bmHeight);
        GetDIBits(DC, IconInfo.hbmMask, 0, BitmapData.bmHeight,
                  BitmapBits, pBitmapInfo(pHeader)^, DIB_RGB_COLORS);
        FImage.WriteBuffer(BitmapBits[0], Length(BitmapBits));
      finally
        ReleaseDC(0, DC);
      end;
    except
      FImage.Size := 0;
      raise;
    end;
  finally
    DeleteObject(IconInfo.hbmMask);
    DeleteObject(IconInfo.hbmColor);
  end;
end;

procedure TIconEx.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPALETTE);
var
  pData: Pointer;
  MS: TMemoryStream;
begin
  if AFormat <> IconExClipboardFormatID then
    raise EIconExError.Create('Invalid Clipboard Format');

  if AData = 0 then
    raise EIconExError.Create('No Data');

  MS := TMemoryStream.Create;
  try
    pData := GlobalLock(AData);
    try
      MS.Write(pData^, GlobalSize(AData));
      MS.Position := 0;
      LoadFromStream(MS);
    finally
      GlobalUnlock(AData);
    end;
  finally
    MS.Free;
  end;
end;

// アイコンファイルイメージを読み込む
procedure TIconEx.LoadFromStream(Stream: TStream);
begin
  FImage.Size := (Stream.Size - Stream.Position);
  FImage.CopyFrom(Stream, FImage.Size);
  if FHandle <> 0 then
  begin
    DestroyIcon(FHandle);
    FHandle := 0;
  end;
  Changed(Self);
end;

// クリップボードデータ(アイコンファイルイメージ)をセーブする
procedure TIconEx.SaveToClipboardFormat(var AFormat: Word;
  var AData: THandle; var APalette: HPALETTE);
var
  MS: TMemoryStream;
  MemHandle: THandle;
  pData: Pointer;
begin
  if Empty then 
  begin
    AFormat := IconExClipboardFormatID;
    AData := 0;
    Exit;
  end;

  AFormat := IconExClipboardFormatID;
  APAlette := 0;

  MS := TMemoryStream.Create;
  try
    SaveToStream(MS);
    MemHandle := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, MS.SIze);
    if MemHandle = 0 then
      raise EIconExError.Create('Cannot Allocate Memory');
    pData := GlobalLock(MemHandle);
    try
      MS.Position := 0;
      MS.ReadBuffer(pData^, MS.Size);
    finally
      GlobalUnlock(MemHandle);
    end;
    AData := MemHandle;
  finally
    MS.Free;
  end;

end;

//アイコンファイルイメージをストリームに書き出す
procedure TIconEx.SaveToStream(Stream: TStream);
begin
  if Empty then Exit;
  FImage.Position := 0;
  Stream.CopyFrom(FImage, FImage.Size);
end;

procedure TIconEx.SetHandle(const Value: THandle);
var
  ImageSave: TMemoryStream;
  HandleSave: HICON;
begin
  HandleSave := 0;
  ImageSave := TMemoryStream.Create;
  try
    ImageSave.CopyFrom(FImage, 0);
    HandleSave := FHandle;
    try
      if FImage.Size <> 0 then FImage.Size := 0;
      FHandle := Value;
      if FHandle <> 0 then // 0 が代入されると TIconは空になる
        ImageNeeded;       // <> 0 ならファイルイメージが作成される
    except
      FHandle := HandleSave;
      HandleSave := 0;
      FImage.Free;
      FImage := ImageSave;
      ImageSave := Nil;
      raise EIconExError.Create('Cannot Set Handle');
    end;
  finally
    if HandleSave <> 0 then DestroyIcon(HandleSave);
    ImageSave.Free;
  end;
  Changed(Self);
end;

// 高さの変更
procedure TIconEx.SetHeight(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if FHandle <> 0 then    //ハンドルを破棄して、新しい
    begin                   //ハンドルの作成を促す
      DestroyIcon(FHandle);
      FHandle := 0;
    end;
    Changed(Self);
  end;
end;

procedure TIconEx.SetTransparent(Value: Boolean);
begin
  // 何もしない。
end;

// 幅の変更
procedure TIconEx.SetWidth(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if FHandle <> 0 then      //ハンドルを破棄して、新しい
    begin                     //ハンドルの作成を促す
      DestroyIcon(FHandle);
      FHandle := 0;
    end;
    Changed(Self);
  end;
end;

initialization

IconExClipboardFormatID :=
  RegisterClipboardFormat('TIconExClipboardFormatIDTakuoNakamura');

TPicture.RegisterClipboardFormat(IconExClipboardFormatID, TIconEx);

finalization

TPicture.UnregisterGraphicClass(TIconEx);

end.
