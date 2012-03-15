/////////////////////////////////////////////////////////////
//
// Unit NkDIB  -- DIB 用 グラフィッククラス
//
// Coded By T.Nakamura
//
//
//  履歴
//
//  Ver 0.11: Mar. 22 '97  α版   初版
//
//  Ver 0.12: Mar. 24 '97  α２版 大幅なバグ修正。
//                         BitCount Property の Write 処理を追加。
//  Ver 0.13: Mar. 25 '97  α３版 ConvertTo8BitRGB のメモリーリークを修正
//  Ver 0.21: Mar. 29 '97  α４版Palette Property への書き込みをサポート
//                         TNkDIBCanvas を追加
//                         1 bpp DIB をサポート
//  Ver 0.22: Apr. 7  '97  TNkDIBCanvas が TNkDIB 間の DIB の共有を考慮して
//                         いない件を修正
//  Ver 0.23: Apr. 27 '97  α6版 ENkDIBOutOfResource 例外を廃止。一般的な
//                         EOutOfResources に置き換えた。
//  Ver 0.31: May. 2  '97  α７版。設計時に DIB ファイル(*.dib) を読み込む機能
//                         を追加。また、TNkDIBCanvas の Destructor のバグを
//                         修正。
//  Ver 0.32: May.  4  '97  α８版。TNkGraphic の宣言を NkGraphic.pas に分離
//
//  Ver 0.34: Jun. 29  '97  α10版。Delphi 3.0J に対応するため、若干修正。
//                          ClipboradFormat Property を新設。
//  Ver 0.41: Aug. 25  '97  α11版。TNkCanvas を高速化。Pixels Property 高速化
//                          ScanLine Property を新設。
//  Ver 0.42: Aug. 28  '97  α12版。Pixels Property をさらに高速化
//  Ver 0.44: Sep. 17  '97  α14版。TNkDIB.Draw のパレットのバグを修正。
//  Ver 0.45: Sep. 18  '97  α15版。BitCount Property が 1bpp を許容する
//                          ように修正しました。
//  Ver 0.51: Oct. 12  '97  α16版。16bpp/32bpp をサポート
//                          Delphi 3.0J の Palette Modified Property を
//                          サポート(^^;
//  Ver 0.52: Oct. 13  '97  α17版。α16版改造漏れ修正 申し訳ない (^^;
//  Ver 0.53: Nov.  1  '97  α18版。 C++Builder 不具合対処
//  Ver 0.61: Jan. 12  '98  大改造
//      (1) PixelFormat Proeprty 追加。あらゆる形式間で変換が可能になった。
//          関連して ConvertMode Property(True Color からの減色精度の指定)と
//          関連してBgColor Property(1bpp 非圧縮への変換時 背景色を指定)
//          を追加した。
//      (2) 減色処理で OnProgress Event が起きるようになった。
//      (3) Pixels Property が全非圧縮形式で利用可能になった。
//
//      注意：(1) 非互換性有り。True Color にカラーテーブルが付いている場合
//                0.53 ではその色に減色したが、0.61 では自分で最適化パレットを
//                作る。
//            (2) 古くなった メソッド有り。以下のメソッドは「次版」で廃止する
//                予定
//                ・CreateTrueColorPaletteHigh/CreateTrueColorPaletteLow
//                  -> CreateTrueColorPalette と ConvertMode に集約した。
//                ・ConvertTo8BitRGB/ConvertToTrueColor
//                  -> PixelFormat Property に機能を吸収した。
//
//  Ver 0.62: Jan. 18  '98   LoadFromClipboardFormat のバグを対処
//  Ver 0.63: Jan. 31  '98   TNkDIB.AssignTo メソッドで、Delphi 3.X の場合
//                           代入先が TBitmap の場合、TBitmap をTNkDIB の
//                           DIB に最も近い DIB 形式になるように TBitmap の
//                           PixelFormat を設定してからコピーするように
//                           しました。こうすることで、色の品質を落とすこと
//                           無くビットマップがコピーされます。
//  Ver 0.64: May. 3 '98
//      (1)ハーフトーン化処理を追加
//      (2)AssignTo で代入先が TBitmap で、TBitmap の Width/Height が０でない
//         場合に例外があがる問題を対処
//      (3)IDE や アプリケーション終了時にメモリ不正アクセスが起こる問題を対処。//         Delphi 3.X では VCL がパッケージとして複数に別れていることから
//         NkDIB ユニットの Finalization の処理で Graphics ユニットに登録された
//         NkDIB の拡張子、クリップボードフォーマットの情報を
//         TPicture.UnRegisterGraphicClass で取り除く必要が有る。
//         # Borland さん こういう重要な情報は互換性情報にしっかり書いてくれ！！//      (4)コンパイラ指令をソースに埋め込んだ(^^;
//      (5)NkDIB.inc を追加 TNkDIB の Version 情報を識別するためのシンボルを
//         作った。詳細は NkDIB.inc を参照のこと。
// Ver 0.65: May. 5 '98  C++Builder 3.0J に対応
// Ver 0.66: Sep. 27 '98 Delphi 4.0J に対応。
// Ver 0.70: Nov. 3 '99
//      (1) Delphi 2/ C++Builder 1 のサポート打ち切りました。
//      (2) Assign メソッドで OnChange イベントが発生しないバグを修正
//      (3) TNkDIB が変更されるとき(OnChange イベントが起きるとき)
//          Modified property が True にならないバグを修正
//      (4) ConvertTo8BitRGB, ConvertToTrueColor, 
//          CreateTrueColorPaletteHigh, CreateTrueColorPaletteLow
//          Compression を廃止
//      (5) XPelsPerMeter/YPelsPerMeter プロパティの追加
//      (6) ビットフィールド形式の DIB を読むとき、
//          RGB 値を 24bpp に変換するときのロジックを改善。
//          (0.66 までは若干暗めに変換されていた)
//      (7) UseFMO プロパティの新設
//      (8) LoadFromStream で ピクセル情報の読み込み位置を bfOffBits に
//          従うように変更
// Ver 0.71: Nov. 8 '99
//      (1) UseFMO 関係で 多数バグ修正(^^;
//      (2) LoadFromClipboardFormat で メモリリークが
//          起きないように修正。
//      (3) LoadFromStream で 例外発生時に メモリリークが
//          起きないように修正。
// Ver. 0.72 1999.11.13
//      (1) NkDefaultUseFMO 関数を追加。マニュアルを改訂。
// Ver. 0.73 2001.7.7
//　　　(1) Delphi 6　日本語ベータで動作確認。マニュアル修正。


// コンパイラ指令
{$ALIGN ON}
{$BOOLEVAL OFF}
{$EXTENDEDSYNTAX ON}
{$IOCHECKS ON}
{$LONGSTRINGS ON}
{$MINENUMSIZE 1}
{$OPENSTRINGS ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}
{$TYPEDADDRESS OFF}
{$WRITEABLECONST ON}


{$INCLUDE NkDIB.inc}  // Version 定義の読み込み


unit NkDIB;

interface
uses Windows, SysUtils, Classes, Controls, Graphics, NkGraph;

// ビットマップヘッダの大きさの最大値。カラーテーブルの大きさを 259 に
// しているのはビットフィールドが 3 DWORD 加わる場合があるため。
const NkBitmapInfoSize = SizeOf(TBitmapInfoHeader) + 259 * SizeOf(TRgbQuad);

type
  // 例外
  ENkDIBError               = class(Exception);
  ENkDIBInvalidDIB          = class(ENkDIBError);   // 不正な DIB
  ENkDIBInvalidDIBFile      = class(ENkDIBError);   // 不正な DIB ファイルヘッダ
  ENkDIBInvalidDIBPara      = class(ENkDIBError);   // 不正パラメータ
  ENkDIBBadDIBType          = class(ENkDIBError);   // DIB Type が適していない
  ENkDIBPaletteIndexRange   = class(ENkDIBError);   // Palette Index Range Error
  ENkDIBPixelPositionRange  = class(ENkDIBError);   // Pixel 位置 Range Error
  ENkDIBInvalidPalette      = class(ENkDIBError);   // SetPalette で不正パレット
  ENkDIBCompressionFailed   = class(ENkDIBError);   // RLE 圧縮失敗
  ENkDIBCanvasFailed        = class(ENkDIBError);   // Canvas 作成不能 

  TNkInternalDIB = class;


  // TrueColor のビットマップデータアクセス用のレコード型
  // Scanline Property で TrueColor のデータをアクセスするときに便利
  TNkTriple = packed record
    B, G, R: Byte;
  end;
  TNkTripleArray = array[0..40000000] of TNkTriple;
  PNkTripleArray = ^TNkTripleArray;

  // Pixel Format Propety の型
  //  nkPf1Bit: 1bpp 非圧縮, nkPf4Bit: 4bpp 非圧縮,  nkPf4BitRLE: 4bpp RLE圧縮
  //  nkPf8Bit: 8bpp 非圧縮, nkPf8BitRLE: 8bpp: RLE 圧縮
  //  nkPf24Bit: True Color
  //  nkPfHalftone: 215色へのハーフトーン化
  //  nkPfHalftoneBW: 白黒へのハーフトーン化
  TNkPixelFormat = (nkPf1Bit, nkPf4Bit, nkPf4BitRLE, nkPf8Bit, nkPf8BitRLE,
                    nkPf24Bit, nkPfHalftone, nkPfHalftoneBW);

  // Convertmode property の型。
  // nkCmNormal: TrueColor を 16Bit精度で減色する。
  // nkCmFine:   TrueColor を 24Bit精度で減色する。
  TNkConvertMode = (nkCmNormal, nkCmFine);


  // Halftone Mode の型
  // nkHtNoHalftone: デフォルト値。ハーフトーン表示を行わない。
  // nkHtHalftone:   215 色ハーフトーン表示を行う
  // nkHtHalftoneBW: 白黒2色のハーフトーン表示を行う。
  TNkHalftoneMode = (nkHtNoHalftone, nkHtHalftone, nkHtHalftoneBW);


//--------------------------------------------------------------------
// Note:
//
// TNKDIB はビットマップデータの全ての TNkInternalDIB の中に入れ、その
// オブジェクト参照を保持する。TNkInternalDIB は複数の TNkDIB から共有される
// ことがある。
//
//   +------+
//   |TNkDIB|-------+
//   +------+       |     +-------------------------+
//                  +---->|TNkInternalDIB           |
//   +------+       +---->|ビットマップ情報／データ |
//   |TNkDIB|-------+     |参照カウント             |
//   +------+             + ------------------------+
//
// TNkInternalDIB の共有は TNkDIB.Assign メソッドでコピーするときに
// 行われる。つまり TNkDIB はコピーされるが TNkInternalDIB はコピーされず
// TNkInternalDIB の参照カウントが増える。逆に TNkDIB が destroy されると
// 参照カウントが減り、０になると TNkInternalDIB も Destroy される。
// ビットマップ情報／データが変更される場合は TNkDIB は TNkInternalDIB を
// コピーして共有を解除し、解除後の TNkInternalDIB を変更する。
// 解除契機は以下の通り
// (1) Pixels Property への書き込み。(2) BitCount Property の変更
// (3) PaletteSize/Colors/Palette Property の変更。(4) LodFromStream メソッド
// (5) LoadFromClipboardFormat (6) PixelFormat Propety の変更
// (7) Scanline Property の参照 (8) CreateTrueColorPalette(High/Low) メソッド
// (9) TNkDIBCanvas のコンストラクト
//
// 解除は UniqueDIB メソッドが担当している。
//
// TNkDIB はほとんどの処理を TNkInternalDIB に委託する。
//
// この方式はメモリの節約になるが、パレットの変化を TNkDIB.PaletteModified
// property に伝えたり、逆 TNkDIB の BGColor(背景色)/ConvertMode(変換モード)
// Property や ProgressHandler ポインタを TNkInternalDIB に伝えるのが
// 面倒である。また OnChange イベントは TNkDIB が担当するなど 役割の
// 切り分けに注意が必要。


/////////////////////////////////////////////////////////////////////////
//
// DIB 専用 のグラフィッククラス
//
  TNkDIB = class(TNkGraphic)
  private
    //////////
    // 変数

    InternalDIB: TNkInternalDIB;                // Internal DIB の Obj. Ref.
    FConvertMode: TNkConvertMode;               // TrueColor -> 4/8 bpp へ
                                                // 減色するときの変換モード
    FBGColor: TColor;                           // 背景色 1bpp へ変換するときに
                                                // '1' に変換される色を指定
    FHalftoneMode: TNkHalftoneMode;             // ハーフトーンモード

    //////////
    // 共有関係
    procedure ReleaseInternalDIB;               // Internal DIB を切り離す。
    procedure UniqueDIB;                        // DIB 共有されている場合、
                                                // コピーする。

    //////////
    // Property 用ヘルパルーチン群

    // PaletteSize Property
    function GetPaletteSize: Integer;           // パレットサイズの取得
    procedure SetPaletteSize(value: Integer);   // パレットサイズの設定

    // BitCountProperty
    function GetBitCount: Integer;              // BitCount の取得
    procedure SetBitCount(Value: Integer);      // BitCount の変更
                                                // ビットマップデータと
                                                // パレットは初期化される！！

    // Colors Property
    function GetColors(Index: Integer): TColor;        // Palette Entry の取得
    procedure SetColors(Index: Integer; Value: TColor);// Palette Entry の設定

    // PixelFormat Property
    function GetPixelFormat: TNkPixelFormat;         // PixelFormat の取得
    procedure SetPixelFormat(Value: TNkPixelFormat); // PixelFormat の変換

    // Pixels Property
    function GetPixels(x, y: Integer): LongInt;         // Pixel 値の取得
    procedure SetPixels(x, y: Integer; Value: LongInt); // Pixel 値の設定

    // ScanLine Property
    function GetScanLine(y: Integer): Pointer; // Scanline ポインタの取得
                                               // y は Top-Down で指定する

    // Halftone Mode property
    procedure SetHalftoneMode(Value: TNkHalftoneMode);

    // XPelsPerMeter Property
    function GetXPelsPerMeter: LongInt;
    procedure SetXPelsPerMeter(Value: LongInt);

    // YPelsPerMeter Property
    function GetYPelsPerMeter: LongInt;
    procedure SetYPelsPerMeter(Value: LongInt);

    // UseFMO Property
    function GetUseFMO: Boolean;
    procedure SetUseFMO(const Value: Boolean);

    //////////
    // その他

    // PaletteModified の更新
    procedure UpdatePaletteModified;

  protected

    //////////
    // Progress 管理用変数群

    // プログレスの ％ を計算するのに使用
    NumberOfProgresses: Integer;    //現在のプログレス数
    MaxNumberOfProgresses: Integer; //最大プログレス数
    // 現在のプログレスの名前 OnProgress イベントで通知される文字
    ProgressString: string;


    //////////
    // TNkGraphic の標準 Propety のヘルパルーチン群

    // Empty Property
    function GetEmpty: Boolean; override;

    // Height Property
    function GetHeight: Integer; override;
    procedure SetHeight(Value: Integer); override;

    // Width Propty
    function GetWidth: Integer; override;
    procedure SetWidth(Value: Integer); override;

    // Palette Property
    function GetPalette: HPalette; override;
    procedure SetPalette(Value: HPalette); override;


    //////////
    // TNkGraphic の標準 Protected ルーチン群

    // Canvas への描画
    procedure Draw(ACanvas: TCanvas; const R: TRect); override;

    // ClipboardFormat Property
    function GetClipboardFormat: UINT; override;


    //////////
    // プログレス関係

    // プログレス変数の初期化。
    procedure InitializeProgressHandler(AMaxNumberOfProgresses: Integer;
                                        AProgressString: string);

    // プログレスハンドラ OnProgress で通知する内容を作成し Progress を呼ぶ
    procedure ProgressHandler(Sender: TObject);

    // プログレス開始 Stage := psStarting, PercentDone = 0 で OnProgress を
    // 起こす。
    procedure StartProgress;

    // プログレス終了 Stage := psEnding, PercentDone = 100 で OnProgress を
    // 起こす。TNkDIB ではこと時だけ RedrawNow が True になる。
    procedure EndProgress;

  public
    constructor Create; override;                         // コンストラクタ
    destructor Destroy; override;                         // デストラクタ


    //////////
    // I/O

    // ストリームから DIB（ファイルヘッダ有り）を読む
    procedure LoadFromStream(Stream: TStream); override;

    // ストリームへ DIB（ファイルヘッダ有り）を書く
    procedure SaveToStream(Stream: TStream); override;

    // ClipBoard との I/O
    procedure LoadFromClipboardFormat(AFormat: Word;
                                      AData: THandle;
                                      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var Format: Word;
                                    var Data: THandle;
                                    var APalette: HPALETTE); override;


    //////////
    // 代入
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;


    //////////
    // 変換

    // True Color DIB の パレットを作成
    procedure CreateTrueColorPalette;     // 精度は ConvertMode に従って
                                          // 最適化カラーテーブルを作成

    //////////////////////
    // Propeties

    //////////
    // 標準 Property

    // Note: Palette Property は TNkGraphic で定義
    property Empty: Boolean read GetEmpty;
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;

    // DIB のパレットのサイズ
    property PaletteSize: Integer read GetPaletteSize write SetPaletteSize;

    // DIB の Pixel 当たりのビット数
    property BitCount: Integer read GetBitCount write SetBitCount;

    // 背景色   nkPf1Bit への変換で 白になる色
    property BGColor: TColor read FBGColor write FBGColor;

    // DIB のカラーテーブルの各エントリの色
    property Colors[Index: Integer]: TColor read GetColors write SetColors;

    // True Color からの減色方法(減色パレットの作成方法)の選択
    property ConvertMode: TNkConvertMode read FConvertMode write FConvertMode;

    // DIB のピクセル形式
    property PixelFormat: TNkPixelFormat read GetPixelFormat
                                         write SetPixelFormat;

    // DIB のピクセルの値 x,y は Top-Down の座標
    property Pixels[x, y: Integer]: LongInt read GetPixels write SetPixels;

    // DIB のスキャンラインへのポインタ y は Top-Down の縦座標
    property ScanLine[y: Integer]: Pointer read GetScanLine;

    // ハーフトーンモード
    property HalftoneMode: TNkHalftoneMode read FHalftoneMode
                                           write SetHalftoneMode;

   // ピクセルの大きさ
   property XPelsPerMeter: LongInt read GetXPelsPerMeter
                                   write SetXPelsPerMeter;
   property YPelsPerMeter: LongInt read GetYPelsPerMeter
                                   write SetYPelsPerMeter;

   // File Mapping Object を使うか指定する
   property UseFMO: Boolean read GetUseFMO write SetUseFMO;
  end;

///////////////////////////////////////////////////////////////////////
//
// TNkDIB 用 Canvas   ---- TNkDIBCanvas
//

  TNkDIBCanvas = class(TCanvas)
  private
    MemDC: HDC;              // DIBSection を選択するメモリデバイスコンテキスト
    hDIBSection: HBitmap;    // DIBSection TNkDIB から作成する。
    DIB: TNkDIB;             // TNkDIB への参照
    OldBitmap: HBITMAP;      // メモリ DC に元々選択されていた
                             // ビットマップ
    OldPalette: HPalette;    // メモリ DCに元々選択されていた
                             // パレット
    pBits: Pointer;          // ビットマップデータへのポインタ。
  public
    // DIB のキャンバスの作成
    constructor Create(ADIB: TNkDIB);
    // DIB のキャンバスの破棄
    destructor Destroy; override;
  end;


///////////////////////////////////////////////////////////////////////
//
// DIB の情報を保持するレコード
//
  TNkDIBInfos = record
    BitsSize: LongInt;                  // ピクセル情報の サイズ
                                        // biSizeImage はたいてい 0 なので
                                        // 計算した値をここに保持する。
    hFile: THandle;                     // ピクセル情報のファイルマッピング
                                        // オブジェクトのハンドル。
    pBits: Pointer;                     // ピクセル情報へのポインタ
    case Integer of
      1:(W3Head: TBitmapInfoHeader;);   // Windows 3.X 形式
      2:(W3HeadInfo: TBitmapInfo;);
      3:(PMHead: TBitmapCoreheader;);   // PM 1.X 形式
      4:(PMHeadInfo: TBitmapCoreInfo;);
        // BitmapInfoHeader と カラーテーブル（最大256個)とビットフィールドを
        // 保持するエリアを確保するためのダミー
      5:(Dummy: array[0..NkBitmapInfoSize] of Byte;); 
  end;




///////////////////////////////////////////////////////////////////////
//
// DIB を保持するクラス。TNkDIB の実体。TNkDIB は参照カウント方式で
// TNkInternalDIB を共有する。

  TNkInternalDIB = class(TObject)
  private
    RefCount: Integer;            // 参照カウント TNkInternalDIB を保持する
                                  // TNkDIB の数
    Width, Height: Integer;       // ビットマップの幅、高さ。高速化のため
                                  // biWidth/biHeight のコピーをここに
                                  // 保持する。但し Height := abs(biHeight);
    Palette: HPalette;            // カラーテーブルから作った論理パレット
    DIBInfos: TNkDIBInfos;        // DIB の本体 ここに全ての情報がある。

    PaletteModified: Boolean;     // パレットの変更が有ったかの記録。

    UseFMO: Boolean;              // FMO を利用するかを示す

    // 無地のDIB を作成 カラーテーブルも初期化されるので注意！
    procedure CreateDIB(AWidth, AHeight, BitCount, NumColors: LongInt);

    // DIB を破棄。ビットマップデータとパレットを破棄する。
    procedure FreeDIB;

    // Stream から DIB(ファイルヘッダ付き）を読み込む
    procedure LoadFromStream(stream: TStream);

    // Stream へ DIB(ファイルヘッダ付き）を書き込む
    procedure SaveToStream(stream: TStream);

    // DIB のカラーテーブルから Palette の作成
    function MakePalette: HPalette;

    // Palette の更新（破棄）
    procedure UpdatePalette;

    // ClipBoard からの DIB(CF_DIB 形式） を読み込む
    procedure LoadFromClipboardFormat(AData: THandle);

    // ClipBoard へ DIB(CF_DIB 形式） を書き込む
    procedure SaveToClipboardFormat(var Data: THandle);


    // PixelFormat を取得する
    function GetPixelFormat: TNkPixelFormat;

    // PixelFormat を変換する
    procedure SetPixelFormat(Value: TNkPixelFormat;         // 新形式
                             ConvertMode: TNkConvertMode;   // 変換モード
                             BGColor: TColor;               // 背景色
                             ProgressHandler: TNotifyEvent  // プログレス
                                                            // ハンドラ
                             );


    // TrueColor DIB 用の Palette を作成する
    procedure CreateTrueColorPalette(ConvertMode: TNkConvertMode; // 変換モード
                                    ProgressHandler: TNotifyEvent // プログレス
                                                                  // ハンドラ
                                     );
  public
    constructor Create(AnUseFMO: Boolean);           // コンストラクタ
    destructor  Destroy; override;// デストラクタ

  end;



function NkSetDefaultUseFMO(DefaultValue: Boolean): Boolean;

{$IFDEF DEBUG}
var
  DebugMA: LongInt; // Debug 用 メモリ アロケーション量
{$ENDIF}


implementation


var PaletteHalfTone: HPalette;     // 215 色 ハーフトーン用パレット
    PaletteBlackWhite: HPalette;   // 2色 白黒ハーフトーン用パレット

const DefaultUseFMO: Boolean = True;

function NkSetDefaultUseFMO(DefaultValue: Boolean): Boolean;
begin
  Result := DefaultUseFMO;
  DefaultUseFMO := DefaultValue;
end;


type
  // 各種バイト配列の宣言
  TByteArray64k = array[0..65535] of Byte;
  PByteArray64k = ^TByteArray64k;
  TByteArray64k3D = array[0..31, 0..63, 0..31] of Byte;
  PByteArray64k3D = ^TByteArray64k3D;
  TByteArray256 = array[0..255] of Byte;

  // WORD 配列 DWORD 配列アクセス用の型。16bpp/32bpp 用
  TWordArray = array[0..100000000] of WORD;
  TDWordArray = array[0..100000000] of DWORD;
  PWordArray = ^TWordArray;
  PDWordArray = ^TDWordArray;


//-------------------------------------------------------------------
// Note: Color Cube
//
// Color Cube は特定の条件に合うピクセル群を一つにまとめたもの
// procedure GetReducedColorsLow では RGB 空間を 32x64x32 の小色空間に分け、
// それぞれに属するピクセルの数と色の平均を格納して使う。この場合、
// Index は RGB 空間内位置を表す。
//
// 8bpp から 4bpp に変換する場合は Index は 8bpp のカラーテーブルの
// インデックス値を表し、n はそのインデックスを持つピクセルの数を表し、
// R, G, B はカラーインデックスに対応する色を表す。
//
// 複数のピクセルをこのようにまとめることで処理を高速化できる (^^
// 
// 注意： TColorCube のメンバ n は２つの意味がある。減色に使う前は
//        ピクセル数を表すが、減色が終了した後は 減色カラーの
//        インデックス値が入ることがある。詳細は
//        CutCubes、GetReducedColorsLow、GetReducedColorsFrom256 を
//        参照されたい。


  // Color Cube Array の定義
  TColorCube = packed record
    R, G, B: LongInt;  // Color Cube に属するピクセルの色の平均値
    n: LongInt;        // Color Cube に属するピクセルの数
                       // またはカラーインデックス。
    Index: LongInt;    // Color Cube のインデックス値
  end;
  
  TColorCubeArray64k = array[0.. 32 * 64 * 32 -1] of TColorCube;
  TColorCubeArray64k3D = array[0..31, 0..63, 0..31] of TColorCube;
  PColorCubeArray64k = ^TColorCubeArray64k;
  PColorCubeArray64k3D = ^TColorCubeArray64k3D;

  // カラーテーブルアクセス用の 配列型
  TRGBQuadArray    = array[0..255] of TRGBQuad;
  PRGBQuadArray    = ^TRGBQuadArray;

  //-----------------------------------------------------------------
  // Note: ピクセル群の分割履歴テーブルの定義
  //
  //   +-- 根元(NodeIndex = 0)
  //   |        Node
  //  +-+       +-+       +-+       +-+
  //  | |------>| |------>| |------>| |      +--- 末端(色インデックスを持つ)
  //  | |--+    | |---+   | |---+   | |      |
  //  +-+  |    +-+   |   +-+   |   +-+     +-+
  //       |          |         +---------->| |
  //       |          |                     | |
  //       |          |                     +-+
  //       |          |                     
  //       |          |                     +-+
  //       |          +-------------------->| |
  //       |                                | |
  //       |    Node                        +-+
  //       |    +-+       +-+
  //       +--->| |------>| |--------->
  //            | |--+    | |--------->
  //            +-+  |    +-+
  //                 +---------------->
  //
  // ピクセル群の分割履歴テーブル は ピクセル群を分割していったときの
  // 履歴。TrueColor から 8bpp/4bpp への変換時 RGB 値から高速に Color Index 
  // を求めるのに利用する。

  TDivideID = (cidRed,       // 赤で分割 子ノードがある。
               cidGreen,     // 緑で分割 子ノードがある。
               cidBlue,      // 青で分割 子ノードがある。
               cidTerminal   // 末端のノード ここに色の決定値(Index)がある。
               );
  TCutHistoryNode = record
    DivideID: TDivideID;        // どの色で分割したか
    ThreshHold: Extended;       // 色の分割値（分割前の色の平均値)
    ColorIndex: Byte;           // カラーインデックス 末端のノードのみ有効
    NextNodeIndexLow: Integer;  // 次のヒストリーノードインデックス
                                // ThreshHold 以下の分割
    NextNodeIndexHigh: Integer; // 次のヒストリーノードインデックス
                                // ThreshHold を超える方の分割
  end;

  // ヒストリーを保持する構造体
  TCutHistory = record
    nNodes: Integer;                         // ノードの数
    Nodes: array[0..511] of TCutHistoryNode; // ノード
  end;


// ハーフトーン用 215 色の色値。
// 6 x 7 x 5 = 210 色 + 5 色
const RedColors:   array[0..5] of Byte = (  0,  51, 102, 153, 204, 255);
      GreenColors: array[0..6] of Byte = (  0,  43,  85, 128, 171, 214, 255);
      BlueColors:  array[0..4] of Byte = (  0,  64, 128, 192, 255);
      SomeRevervedColors: array[0..4] of TColor =
        (clMaroon, clOlive, clPurple, clSilver, clGray);
// 白黒ハーフトーン用の色値
      BWColors: array[0..1] of TRGBQuad =
        ((rgbBlue:0; rgbGreen:0; rgbRed:0; rgbReserved:0),
         (rgbBlue:255; rgbGreen:255; rgbRed:255; rgbReserved:0));



//-------------------------------------------------------------------
// Note: GetMemory/ ReleaseMemory の役割
//
// GetMemory は指定された大きさの メモリ 又は File Mapping Object を取得し，
// hFile には FMO の ハンドルを pBits には先頭ポインタを返す。
//

procedure GetMemory(Size: LongInt;
                    var hFile: THandle;
                    var pBits: Pointer;
                    UseFMO: Boolean);
begin
  if UseFMO then begin
    // 無名のファイルマッピングオブジェクトを作成
    hFile := CreateFileMapping($FFFFFFFF, Nil, PAGE_READWRITE, 0, Size, Nil);
    if hFile = 0 then raise EOutOfResources.Create(
        'GetMemory: Cannot Make File Mapping Object');

    // ファイルマッピングオブジェクトをメモリにマップ
    pBits := MapViewOfFile(hFile, FILE_MAP_WRITE, 0, 0, 0);

    if pBits = Nil then begin
      CloseHandle(hFile);
      raise EOutOfResources.Create('GetMemory: Cannot Make View of File Map');
    end;
  end
  else begin
    pBits := AllocMem(Size); hFile := 0;
  end;
end;

// FMO を破棄する。
procedure ReleaseMemory(hFile: THandle; pBits: Pointer; UseFMO: Boolean);
var Ret: Boolean;
begin
  if UseFMO then begin
    // ファイルマッピングオブジェクトのメモリへのマップを解除
    ret := UnMapViewOfFile(pBits);
    Assert(Ret, 'ReleaseMemory: Failed To Unmap View of File map');
    // ファイルマッピングオブジェクトを破棄
    ret := CloseHandle(hFile);
    Assert(Ret, 'ReleaseMemory: Failed To Close File Map');
  end
  else
    FreeMem(pBits);
end;



// コンストラクタ
constructor TNkInternalDIB.Create(AnUseFMO: Boolean); // Internal DIB の初期化
begin
  RefCount := 1;                // 参照カウント初期化
  DIBInfos.pBits := Nil;        // ピクセル情報へのポインタを初期化
  UseFMO := AnUseFMO;           // FMO を使うか設定
  CreateDIB(1, 1, 8, 256);        // Window 3.X 1x1 8Bit  RGB 256 Color;
end;

// デストラクタ
destructor TNkInternalDIB.Destroy; // Internal DIB の destructor
begin FreeDIB; end;


// 無地の DIB の作成  DIBInfos が空であることを仮定している。
procedure TNkInternalDIB.CreateDIB(AWidth, AHeight, BitCount,
                                   NumColors: LongInt);
var BitsSize: LongInt;  // ビットマップデータの大きさ
    p: Pointer;         // ビットマップデータ用バッファ(FMO)へのポインタ
    h: hFile;           // ビットマップデータ用バッファ(FMO)のハンドル
begin
  // パラメータをチェック AHeight は負(Top-Down)を許可
  If (AWidth <= 0) or (AHeight = 0) or (NumColors < 0) or
     (NumColors > 256) or (not(BitCount in [1, 4, 8, 24])) then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkInternalDIB.CreateDIB: Invalid Parameters');

  // ピクセルデータサイズを計算
  BitsSize := ((BitCount * AWidth + 31) div 32) * 4 * abs(AHeight);

  // ピクセルデータ格納用 FMO を取得 DIBInfos にセット
  GetMemory(BitsSize, h, p, UseFMO);

  FillChar(p^, BitsSize, 0);  // 全てのピクセルは ０
  DIBInfos.hFile    := h;
  DIBInfos.BitsSize := BitsSize;
  DIBInfos.pBits    := p;


  // パレットハンドルを初期化。パレットハンドルは TNkDIB.GetPalette
  // が呼ばれたときに初めて作られるので 0 で初期化しておく。
  Palette := 0;

  // 高さと幅を設定
  Width := AWidth; Height := Abs(AHeight);

  // BitmapInfoHeader を初期化 Windows 3.X 形式
  DIBInfos.W3Head.biSize          := SizeOf(TBitmapInfoHeader);
  DIBInfos.W3Head.biWidth         := Width;    // 幅
  DIBInfos.W3Head.biHeight        := AHeight;  // 高さ。  <0 ならば Top-Down
  DIBInfos.W3Head.biPlanes        := 1;        // プレーン数常に１
  DIBInfos.W3Head.biBitCount      := BitCount; // ビット数 1, 4, 8, 24
  DIBInfos.W3Head.biCompression   := BI_RGB;   // 非圧縮に設定
  DIBInfos.W3Head.biXPelsPerMeter := 3780;     // 96dpi
  DIBInfos.W3Head.biYPelsPerMeter := 3780;     // 96dpi
  DIBInfos.W3Head.biClrUsed       := NumColors; // 色数
  DIBInfos.W3Head.biClrImportant  := 0;

  //カラーテーブルを全て黒で初期化
  FillChar(DIBInfos.W3HeadInfo.bmiColors[0], SizeOf(TRGBQuad)*256, 0);

  PaletteModified := True; // パレットが変更されたことを記録
                           // 後で TNkDIB が拾いに来る。
end;

// DIB の破棄
procedure TNkInternalDIB.FreeDIB;
begin
  // DIB のピクセル情報の破棄
  if DIBInfos.pBits <> Nil then begin  // 念のため DIB があるかチェック
    ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
    DIBInfos.BitsSize := 0;
    DIBInfos.hFile    := 0;
    DIBInfos.pBits    := Nil;
  end;

  // 論理パレットの破棄
  if Palette <> 0 then begin
    DeleteObject(Palette);
    Palette := 0;
  end;
end;


// Bit Count から色数を求める。16/24/32 bpp は ０を返す。
// biClrUsed を補正するのに使う。
// biClrUsed は ０の場合に使うこと（重要！）
function GetNumColors(BitCount: Integer): Integer;
begin
  if BitCount in [1, 4, 8] then
    Result := 1 shl BitCount
  else
    Result := 0;
end;


// ポインタをオフセット分ずらす
function AddOffset(p: Pointer; Offset: LongInt): Pointer;
begin Result := Pointer(LongInt(p) + Offset); end;


// TNkDIBInfos のカラーテーブルからパレットを作る。
function GetPaletteFromDIBInfos(var DIBInfos: TNkDIBInfos): HPALETTE;
var pPal: PLOGPALETTE; // 論理パレット作成のためのパラメータブロックへのポインタ
    PalSize: Integer;  // 論理パレットのパラメータブロックの大きさ
    nColors, i: Integer; // 色数
begin
  Result := 0;

  // 色数を求める
  if DIBInfos.W3Head.biClrUsed = 0 then Exit;

  // TNkInternalDIB では biClrUsed は 1/4/8 bpp では 0 にはならないように
  // 補正ずみなのでこれでよい。
  nColors := DIBInfos.W3Head.biClrUsed;

  // パラメータブロックを作る
  PalSize := SizeOf(TLogPalette) + ((nColors - 1) * SizeOf(TPaletteEntry));
  GetMem(pPal, PalSize);
  try
    pPal^.palNumEntries := nColors;  // 色数
    pPal^.palVersion := $300;

    // 色をパラメータブロックのエントリに設定。
    for i := 0 to nColors - 1 do begin
      pPal^.palPalEntry[i].peRed   := DIBInfos.W3HeadInfo.bmiColors[i].rgbRed;
      pPal^.palPalEntry[i].peGreen := DIBInfos.W3HeadInfo.bmiColors[i].rgbGreen;
      pPal^.palPalEntry[i].peBlue  := DIBInfos.W3HeadInfo.bmiColors[i].rgbBlue;
      pPal^.palPalEntry[i].peFlags := 0;
    end;

    // 作る！！
    Result := CreatePalette(pPal^);

    if Result = 0 then raise EOutOfResources.Create(
      'GetPaletteFromDIBInfos: Cannot Make Palette');

  finally
    // パラメータブロックの破棄
    FreeMem(pPal, PalSize);
  end;
end;


//-------------------------------------------------------------------
// Note:
//
// TNkInternalDIB ではビットマップを常に Windows 3.X 形式で保持する。
// ConvertBitmapHeaderPMToW3 は ファイルなどから PM 形式のビットマップ
// が入力された場合、ヘッダとカラーテーブルを Windows 3.X 形式に変換する
// のに利用する。

// ビットマップ情報を PM1.X 形式から Windows 3.X 形式に変換する
procedure ConvertBitmapHeaderPMToW3(var PmInfos: TNkDIBInfos);
var Infos: TNkDIBInfos;
    i: Integer;
begin
  // PmInfos(PM 形式 BitmapInfo) から BitmapInfoHeader を作る
  Infos := PMInfos;
  Infos.W3Head.biSize          := SizeOf(TBitmapInfoheader);
  Infos.W3Head.biWidth         := PMInfos.PMHead.bcWidth;
  Infos.W3Head.biHeight        := PMInfos.PMHead.bcHeight;
  Infos.W3Head.biPlanes        := PMInfos.PMHead.bcPlanes;
  Infos.W3Head.biBitCount      := PMInfos.PMHead.bcBitCount;
  Infos.W3Head.biCompression   := BI_RGB; // PM 形式に圧縮は無い！！
  Infos.W3Head.biSizeImage     := 0;
  Infos.W3Head.biXPelsPerMeter := 3780;  // 96dpi
  Infos.W3Head.biYPelsPerMeter := 3780;  // 96dpi
  // カラーテーブル長は PM では bcBitCount で決まる。
  Infos.W3Head.biClrUsed       := GetNumColors(PMInfos.PMHead.bcBitCount);
  Infos.W3Head.biClrImportant  := 0;


  // PM と W3 では カラーテーブルの形式が違うので変換する
  for i := 0 to Infos.W3Head.biClrUsed - 1 do begin
    Infos.W3HeadInfo.bmiColors[i].rgbRed :=
          PMInfos.PMHeadInfo.bmciColors[i].rgbtRed;
    Infos.W3HeadInfo.bmiColors[i].rgbGreen :=
          PMInfos.PMHeadInfo.bmciColors[i].rgbtGreen;
    Infos.W3HeadInfo.bmiColors[i].rgbBlue :=
          PMInfos.PMHeadInfo.bmciColors[i].rgbtBlue;
    Infos.W3HeadInfo.bmiColors[i].rgbReserved := 0;
  end;


  PMInfos := Infos;  // 変換結果を書き込む
end;


// BI_BITFIELDS 形式のビットマップの マスクのシフト量を計算する
// >0 は右シフト <0 は左シフトを表す。
//  マスク値が 128 ～ 255(MSB ON) になるようするシフト量を計算する
//    (Mask に ０ が入ると暴走するので注意！！)

function GetMaskShift(Mask: DWORD): Integer;
begin
  Result := 0;

  // Mask が $100 以上なら 右シフト量を求める
  while Mask >= 256 do begin
    Mask := Mask shr 1;
    Result := Result +1;
  end;

  // Mask が $80 未満なら 左シフト量を求める（マイナス値）
  while Mask < 128 do begin
    Mask := Mask shl 1;
    Result := Result -1;
  end;
end;


// Stream から DIB（ファイルヘッダ付き）を読み込む
procedure TNkInternalDIB.LoadFromStream(Stream: TStream);
var Infos: TNkDIBInfos;              // DIB情報
    bfh: TBitmapFileheader;          // ビットマップファイルヘッダ
    i, j, w: LongInt;
    SourceLineSize, DestLineSize: LongInt; // スキャンラインの大きさ
                                    // 16/32 bpp -> 24 bpp 変換用
    RShift, GShift, BShift: LongInt;// マスクのシフト量
    Masks: array[0..2] of DWORD;    // Masks[0]: Red Mask Masks[1]: Green Mask
                                    // Masks[2]: Blue Mask
    pConvertBuffer: Pointer;        // 16/32bpp -> 24bpp 変換用バッファへの
                                    // ポインタ
    pTriple: ^TNkTriple;            // 24 bpp スキャンラインアクセス用ポインタ
                                    // 16/32 bpp -> 24 bpp 変換用
    MaxR, MaxG, MaxB: DWORD;        // BitFields で取り出した R, G, B 値の
                                    // 補正前の最大値
begin
  Infos.pBits := Nil;

  try
    // ファイルヘッダーを読む
    Stream.ReadBuffer(bfh, SizeOf(bfh));

    // ファイルタイプをチェック
    if bfh.bfType <> $4D42 then
      raise ENkDIBInvalidDIBFile.Create(
        'TNkInternalDIB.LoadFromFile: File type is invalid');

    // W3 か PM かを判断するためビットマップヘッダサイズを読み込む
    Stream.ReadBuffer(Infos.W3Head, SizeOf(DWORD));

    if Infos.W3Head.biSize = SizeOf(TBitmapInfoHeader) then begin
      // Windows 3.X 形式
      // BitmapInfoHeader の残りを読み込む
      Stream.ReadBuffer(AddOffset(@Infos.W3Head, SizeOf(DWORD))^,
                        SizeOf(TBitmapInfoHeader) - SizeOf(DWORD));

      // XPelsPerMeter/YPelsPerMeter が 0 なら 3780(96dpi) に補正する。
      if Infos.W3Head.biXPelsPerMeter = 0 then
        Infos.W3Head.biXPelsPerMeter := 3780;
      if Infos.W3Head.biYPelsPerMeter = 0 then
        Infos.W3Head.biYPelsPerMeter := 3780;

      // 色ビット数チェック
      if not (Infos.W3Head.biBitCount in [1, 4, 8, 16, 24, 32]) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid BitCout');

      // 色数を求める。
      if Infos.W3Head.biClrUsed = 0 then
        Infos.W3Head.biClrUsed := GetNumColors(Infos.W3Head.biBitCount);

      // カラーテーブルを読み込む
      //------------------------------
      // Note:
      // カラーテーブルは先頭に 3 DWORD の BitFields を含むことがある。
      // その場合はカラーテーブルの大きさは (3 + biClrUsed) 個に
      // なるので注意が必要である。
      // また biClrUsed が２５７以上になることも有り得るので注意！！

      if Infos.W3Head.biCompression <> BI_BITFIELDS then begin
      // BitFields を含む場合
        if Infos.W3Head.biClrUsed <= 256 then
          Stream.ReadBuffer(
            AddOffset(@Infos.W3Head, SizeOf(TBitmapInfoHeader))^,
                      Infos.W3Head.biClrUsed * SizeOf(TRgbQuad))
        else begin
          // カラーテーブルが２５６個より大きければ先頭256だけ使う。
          // 多分先頭の方が重要なはず。
          Stream.ReadBuffer(
            AddOffset(@Infos.W3Head, SizeOf(TBitmapInfoHeader))^,
                      256 * SizeOf(TRgbQuad));
          // スキップ
          Stream.Seek((Infos.W3Head.biClrUsed - 256)* SizeOf(TRgbQuad), 1);
        end;
      end
      else begin
        if Infos.W3Head.biClrUsed <= 256 then
          Stream.ReadBuffer(
            AddOffset(@Infos.W3Head, SizeOf(TBitmapInfoHeader))^,
                      (Infos.W3Head.biClrUsed+3) * SizeOf(TRgbQuad))
        else begin
          Stream.ReadBuffer(
            AddOffset(@Infos.W3Head, SizeOf(TBitmapInfoHeader))^,
                      (256+3) * SizeOf(TRgbQuad));
          // スキップ
          Stream.Seek((Infos.W3Head.biClrUsed - 256)* SizeOf(TRgbQuad), 1);
        end
      end;

      // ピクセル情報のメモリ量計算(1, 2, 4, 8, 24 Bit 用)
      Infos.BitsSize := bfh.bfSize - bfh.bfOffBits;

      if Infos.W3head.biCompression <> BI_BITFIELDS then begin
        // ファイルヘッダの bfOffBits を過ぎてしまっているかチェック
        if bfh.bfOffBits < (SizeOf(bfh) + Infos.W3Head.biSize +
           Infos.W3Head.biClrUsed * SizeOf(TRgbQuad)) then
          raise ENkDIBInvalidDIB.Create(
            'TNkInternalDIB.LoadFromFile: bfOffBits is too small');

        // bfOffBits に従って 読み取り位置を補正
        Stream.Seek(bfh.bfOffBits - sizeof(bfh) - Infos.W3Head.biSize -
                    Infos.W3Head.biClrUsed * SizeOf(TRgbQuad),
                    soFromCurrent);
      end
      else begin
        // ファイルヘッダの bfOffBits を過ぎてしまっているかチェック
        if bfh.bfOffBits < (SizeOf(bfh) + Infos.W3Head.biSize +
           (Infos.W3Head.biClrUsed + 3) * SizeOf(TRgbQuad)) then
          raise ENkDIBInvalidDIB.Create(
            'TNkInternalDIB.LoadFromFile: bfOffBits is too small');

        // bfOffBits に従って 読み取り位置を補正
        Stream.Seek(bfh.bfOffBits - sizeof(bfh) - Infos.W3Head.biSize -
                    (Infos.W3Head.biClrUsed + 3) * SizeOf(TRgbQuad),
                    soFromCurrent);
      end;


      // ピクセルメモリ量の計算が終わったので カラーテーブルの
      // 色数が多すぎるなら２５６に直す。
      if Infos.W3Head.biClrUsed > 256 then
        Infos.W3Head.biClrUsed := 256;

    end
    else if Infos.PMHead.bcSize = SizeOf(TBitmapCoreHeader) then begin
      // PM 1.X 形式
      // BitmapCoreHeader を読み込む
      Stream.ReadBuffer(AddOffset(@Infos.PMHead, SizeOf(DWORD))^,
                        SizeOf(TBitmapCoreHeader) - SizeOf(DWORD));

      // 色ビット数チェック
      if not (Infos.PMHead.bcBitCount in [1, 4, 8, 24]) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid BitCount');

      // カラーテーブルを読み込む。PM 形式の場合は BitField も無いし
      // カラーテーブルの大きさは bcBitCount で自動的に決まる。
      Stream.ReadBuffer(
        Pointer(LongInt(@Infos.PMHead)+SizeOf(TBitmapCoreHeader))^,
        GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple));

      // ピクセル情報のメモリ量計算
      Infos.BitsSize :=
        bfh.bfSize - SizeOf(bfh) - Infos.PMHead.bcSize -
        GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple);

      // ピクセル情報のメモリ量計算(1, 2, 4, 8, 24 Bit 用)
      Infos.BitsSize := bfh.bfSize - bfh.bfOffBits;

      // ファイルヘッダの bfOffBits を過ぎてしまっているかチェック
      if bfh.bfOffBits < (SizeOf(bfh) + Infos.PMHead.bcSize +
         GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple)) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromFile: bfOffBits is too small');

      // bfOffBits に従って 読み取り位置を補正
      Stream.Seek(bfh.bfOffBits - sizeof(bfh) - Infos.PMHead.bcSize -
                  GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple),
                  soFromCurrent);





      // ビットマップヘッダとカラーテーブルを Windows 3.X 形式に変換
      ConvertBitmapHeaderPmToW3(Infos);
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkInternalDIB.LoadFromStream: Invalid Bitmap Header Size');

    // 高さと幅をチェック
    if (Infos.W3Head.biWidth <= 0) or (Infos.W3head.biHeight = 0) then
      raise ENkDIBInvalidDIB.Create(
        'TNkInternalDIB.LoadFromStream: Invalid Width or Height');

    if Infos.W3Head.biBitCount in [1, 4, 8, 24] then begin
      // ピクセル情報用メモリを確保
      GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);
      // ピクセル情報を読み込む
      Stream.ReadBuffer(Infos.pBits^, Infos.BitsSize);
    end
    else if Infos.W3Head.biBitCount in [16, 32] then begin
      // 16/32bpp の場合

      //-------------------------------------------------------------
      // Note: 16/32 bpp の取り扱い
      //
      // TNkDIB は内部的には 16/32 bpp をサポートしないので
      // 入力時に 24bpp に変換することで対処している。
      // 16 bpp や 24bpp は BitField でマスクしてそうしなければなら
      // 内部形式としては扱いにくい。(これ以上形式を増やしたくない (^^;)

      // 16/32 bpp のスキャンラインの長さ
      if Infos.W3Head.biBitCount = 16 then
        SourceLineSize := ((Infos.W3Head.biWidth*2+3) div 4) * 4
      else
        SourceLineSize := ((Infos.W3Head.biWidth*4+3) div 4) * 4;

      // 24bpp のライン幅
      DestLineSize   := ((Infos.W3Head.biWidth*3+3) div 4) * 4;

      // 16/32 bpp で BitsSize を計算したので 24bpp で再計算
      Infos.BitsSize := DestLineSize * Infos.W3Head.biHeight;

      // 24bpp の Pixel 用メモリを確保
      GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);

      // ビットマスクを得る
      if Infos.W3Head.biCompression = BI_RGB then begin
        // BitFields が無い場合
        // 16bpp 用デフォルトマスクパタンの作成。
        if Infos.W3Head.biBitCount = 16 then begin
          Masks[0] := $7C00; Masks[1] := $03E0; Masks[2] := $001F;
        end
        else begin
        // 32bpp 用デフォルトマスクパタンの作成。
          Masks[0] := $FF0000; Masks[1] := $00FF00; Masks[2] := $0000FF;
        end;
      end
      else begin
        // BitFields から マスクを Masks へコピー。
        Move(Infos.W3HeadInfo.bmiColors[0], Masks[0], SizeOf(DWORD)*3);
      end;

      // マスクが正常かチェック。ビットの歯抜け重なりはチェックしていない(^^
      // 0 かチェックしているのは GetMaskShift が暴走しないようにするため
      if (Masks[0] = 0) or (Masks[1] = 0) or (Masks[2] = 0) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid Masks');


      // マスク後のシフト量を計算
      RShift := GetMaskShift(Masks[0]);
      GShift := GetMaskShift(Masks[1]);
      BShift := GetMaskShift(Masks[2]);

      // 補正前の R, G, B 値の最大値を計算
      if RShift >= 0 then MaxR := Masks[0] shr RShift
                     else MaxR := Masks[0] shl (-RShift);
      if GShift >= 0 then MaxG := Masks[1] shr GShift
                     else MaxG := Masks[1] shl (-GShift);
      if BShift >= 0 then MaxB := Masks[2] shr BShift
                     else MaxB := Masks[2] shl (-BShift);

      // 16/32bpp -> 24 bpp のために 1スキャンライン分の変換バッファを用意
      GetMem(pConvertBuffer, SourceLineSize);

      // 準備完了 読み込みスタート

      try
        for i := 0 to Infos.W3Head.biHeight -1 do begin

          // 1 Line 読み込む
          Stream.ReadBuffer(pConvertBuffer^, SourceLineSize);

          // 変換先を計算
          pTriple := AddOffset(Infos.pBits, DestLineSize * i);

          // おしりを０クリアしておく スキャンラインのパディング
          // が０以外になるのを防ぐため。
          FillChar(AddOffset(pTriple, DestLineSize -4)^, 4, 0);

          w := Infos.W3Head.biWidth -1;

          if Infos.W3Head.biBitCount = 16 then
            // 16bpp の場合
            for j := 0 to w do begin

               // 1 pixel 変換
               if RShift >= 0 then
                 pTriple.R := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[0])
                              shr RShift) * 255 div MaxR
               else
                 pTriple.R := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[0])
                              shl (-RShift)) * 255 div MaxR;
               if GShift >= 0 then
                 pTriple.G := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[1])
                              shr GShift) * 255 div MaxG
               else
                 pTriple.G := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[1])
                              shl (-GShift)) * 255 div MaxG;
               if BShift >= 0 then
                 pTriple.B := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[2])
                              shr BShift) * 255 div MaxB
               else
                 pTriple.B := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[2])
                              shl (-BShift)) * 255 div MaxB;
               inc(pTriple);
            end
          else
            // 32 bpp の場合
            for j := 0 to w do begin
               // 1 pixel 変換
               if RShift >= 0 then
                 pTriple.R := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[0])
                              shr RShift) * 255 div MaxR
               else
                 pTriple.R := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[0])
                              shl (-RShift)) * 255 div MaxR;
               if GShift >= 0 then
                 pTriple.G := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[1])
                              shr GShift) * 255 div MaxG
               else
                 pTriple.G := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[1])
                              shl (-GShift)) * 255 div MaxG;
               if BShift >= 0 then
                 pTriple.B := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[2])
                              shr BShift) * 255 div MaxB
               else
                 pTriple.B := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[2])
                              shl (-BShift)) * 255 div MaxB;
               inc(pTriple);
            end

        end;


        // 全ピクセルは変換できたので今度は ビットマップ情報を書き換える

        with Infos.W3Head do begin
          // カラーテーブルの位置を補正
          if biCompression = BI_BITFIELDS then
            for i := 0 to 255 do
              with Infos.W3HeadInfo do
                bmiColors[i] := bmiColors[i+3];

          // ヘッダを補正 24bpp にする
          biCompression := BI_RGB;
          biBitCount := 24;
          biSizeImage := 0;
        end;

      finally
        FreeMem(PConvertBuffer, SourceLineSize);  // 変換用バッファを破棄
      end;
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkInternalDIB.LoadFromStream: Invalid biBitCount');

    // 仕上げ
    FreeDIB;                          // 古い DIB を削除
    DIBInfos := Infos;                // 新しい DIB ヘッダ＆カラーテーブルを設定

    // 幅と高さを設定
    Width := DIBInfos.W3Head.biWidth;
    Height := abs(DIBInfos.W3Head.biHeight);

    UpdatePalette; // 新しい DIB のパレットにする。
  except
    // 失敗した場合、確保した FMO を捨てる。
    if Infos.pBits <> Nil then ReleaseMemory(Infos.hFile, Infos.pBits, UseFMO);
    raise;  // 再生成を忘れずに！！
  end;
end;

// DIB（ファイルヘッダ付き）をStream に書き出す。これは簡単
procedure TNkInternalDIB.SaveToStream(Stream: TStream);
var bfh: TBitmapFileheader;
begin
  // ファイルヘッダを作る
  FillChar(bfh, SizeOf(bfh), 0);

  // 'BM' をファイルタイプに設定
  bfh.bfType    := $4D42;

  // ファイルサイズを計算して設定
  bfh.bfSize    := SizeOf(bfh) +                 // ファイルヘッダの大きさ
                   SizeOf(TBitmapInfoHeader) +   // ビットマップヘッダの大きさ
                   DIBInfos.W3Head.biClrUsed *   // カラーテーブルの大きさ
                       SizeOf(TRgbQuad) +
                   DIBInfos.BitsSize;            // ビットマップデータの大きさ
                                                 // biSizeImage は使わないこと!
                                                 // 0 の場合がある。

  // ファイルの先頭からピクセル情報までのサイズを計算して設定
  bfh.bfOffBits := SizeOf(bfh) +                 // ファイルヘッダの大きさ
                   SizeOf(TBitmapInfoHeader) +   // ビットマップヘッダの大きさ
                   DIBInfos.W3Head.biClrUsed *   // カラーテーブルの大きさ
                       SizeOf(TRgbQuad);

  // ファイルヘッダを書き込む
  Stream.WriteBuffer(bfh, SizeOf(bfh));

  // ビットマップヘッダ＆カラーテーブルを書き込む
  Stream.WriteBuffer(DIBInfos.W3Head,
                     SizeOf(TBitmapInfoHeader) +
                     DIBInfos.W3Head.biClrUsed * SizeOf(TRgbQuad));
  // ピクセル情報を書き込む
  Stream.WriteBuffer(DIBInfos.pBits^, DIBInfos.BitsSize);
end;


// DIB のカラーテーブルからパレットを作る。
function TNkInternalDIB.MakePalette: HPALETTE;
begin Result := GetPaletteFromDIBInfos(DIBInfos); end;


// 古いパレットを削除。
procedure TNkInternalDIB.UpdatePalette;
begin
  // パレットが 更新されるということは UniqueDIB が呼ばれて 共有が
  // 解除されているはずである。そうでなければバグ
  Assert(RefCount = 1, 'TNkInternalDIB.UpdatePalette: RefCount Must be 1');
  if Palette <> 0 then begin // 旧パレットあり？
    DeleteObject(Palette);
    Palette := 0;
  end;
  PaletteModified := True;
end;

// ClipBoard から DIB を取得
// 入力もとが メモリになるだけで処理はほとんど LoadFromStream と同じなので
// コメントは手抜きです (^^
procedure TNkInternalDIB.LoadFromClipboardFormat(AData: THandle);
var p: Pointer;              // クリップボードデータへのポインタ
    pBih: PBitmapInfoHeader; // ヘッダへのポインタ(Windows 3.X)
    pBch: PBitmapCoreHeader; // ヘッダへのポインタ(PM 1.X)
    HeaderSize: LongInt;     // ビットマップヘッダ＋カラーテーブル の大きさ
    ColorTableSize: LongInt; // カラーテーブルの色数
    Infos: TNkDIBInfos;      // DIB 情報
    SourceLineSize, DestLineSize: LongInt;
    i, j, w: LongInt;
    RShift, GShift, BShift: LongInt;
    Masks: array[0..2] of DWORD; // Masks[0]: Red Mask Masks[1]: Green Mask
                                 // Masks[2]: Blue Mask
    pConvertBuffer: Pointer;           // 16/32bpp -> 24bpp 変換用ポインタ
    pTriple: ^TNkTriple;
    MaxR, MaxG, MaxB: DWORD;        // BitFields で取り出した R, G, B 値の
                                    // 補正前の最大値
begin
  p := GlobalLock(AData);
  try
    Infos.pBits := Nil;
    try
      if PBitmapInfoHeader(p)^.biSize = SizeOf(TBitmapInfoheader) then begin
        // CF_DIB のデータは Windows 3.X 形式

        pBih := p;

        // カラーテーブルの色数を計算
        ColorTableSize := pBih^.biClrUsed;
        if ColorTableSize = 0 then
          ColorTableSize := GetNumColors(pBih^.biBitCount);

        // DIB ヘッダー（カラーテーブルを含む）の合計サイズを計算

        if pBih^.biCompression <> BI_BITFIELDS then
          HeaderSize := SizeOf(TBitmapInfoheader) +
                        ColorTableSize * SizeOf(TRGBQuad)
        else
          HeaderSize := SizeOf(TBitmapInfoheader) +
                        (ColorTableSize+3) * SizeOf(TRGBQuad);

        // DIB ヘッダーをコピー
        if HeaderSize > NkBitmapInfoSize then
          System.Move(p^, Infos.W3Head, NkBitmapInfoSize)
        else
          System.Move(p^, Infos.W3Head, HeaderSize);

        // XPelsPerMeter/YPelsPerMeter が 0 なら 3780(96dpi) に補正する。
        if Infos.W3Head.biXPelsPerMeter = 0 then
          Infos.W3Head.biXPelsPerMeter := 3780;
        if Infos.W3Head.biYPelsPerMeter = 0 then
          Infos.W3Head.biYPelsPerMeter := 3780;



        // 補正したカラーテーブルサイズを書き込み
        if ColorTableSize > 256 then ColorTableSize := 256;
        Infos.W3Head.biClrUsed := ColorTableSize;

        // ピクセル情報用メモリを計算
        Infos.BitsSize := GlobalSize(AData) - HeaderSize;
      end
      else if PBitmapInfoHeader(p)^.biSize =
              SizeOf(TBitmapCoreheader) then begin
        // CF_DIB のデータは PM 1.X 形式

        pBch := p;

        // カラーテーブルの色数を計算
        ColorTableSize := GetNumColors(pBch^.bcBitCount);

        // DIB ヘッダー（カラーテーブルを含む）の合計サイズを計算
        HeaderSize := SizeOf(TBitmapCoreheader) +
                      ColorTableSize * SizeOf(TRGBTriple);

        System.Move(p^, Infos.PMHead, HeaderSize);

        // ピクセル情報用メモリ量を計算。
        Infos.BitsSize := GlobalSize(AData) - HeaderSize;

        // ビットマップヘッダとカラーテーブルを Windows 3.X 形式に変換
        ConvertBitmapHeaderPmToW3(Infos);
      end
      else
        raise ENkDIBInvalidDIB.Create(
          'TNkDIB.LoadFromClipboardFormat: Invalid Clipboard Data');

      if (Infos.W3Head.biWidth = 0) or (Infos.W3head.biHeight = 0) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid Width or Height');


      if Infos.W3Head.biBitCount in [1, 4, 8, 24] then begin
        // ピクセル情報用メモリを確保
        GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);
        // ピクセル情報を読み込む
        System.Move(AddOffset(p, HeaderSize)^, Infos.pBits^, Infos.BitsSize);
      end
      else if Infos.W3Head.biBitCount in [16, 32] then begin   // 16/32bpp
        // 24bpp に変換しながら読む
        
      //-------------------------------------------------------------
      // Note: 16/32 bpp の取り扱い
      //
      // TNkDIB は内部的には 16/32 bpp をサポートしないので
      // 入力時に 24bpp に変換することで対処している。
      // 16 bpp や 24bpp は BitField でマスクしてそうしなければなら
      // 内部形式としては扱いにくい。(これ以上形式を増やしたくない (^^;)


        // 16/32 bpp のライン幅
        if Infos.W3Head.biBitCount = 16 then
          SourceLineSize := ((Infos.W3Head.biWidth*2+3) div 4) * 4
        else
          SourceLineSize := ((Infos.W3Head.biWidth*4+3) div 4) * 4;

        // 24bpp のライン幅
        DestLineSize   := ((Infos.W3Head.biWidth*3+3) div 4) * 4;

        // 24bpp の Bits サイズに補正
        Infos.BitsSize := DestLineSize * Infos.W3Head.biHeight;

        // 24bpp の Pixel 用メモリを確保
        GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);

        if Infos.W3Head.biCompression = BI_RGB then begin
          // 16bpp 用デフォルトマスクパタンの作成。
          if Infos.W3Head.biBitCount = 16 then begin
            Masks[0] := $7C00; Masks[1] := $03E0; Masks[2] := $001F;
          end
          else begin
          // 32bpp 用デフォルトマスクパタンの作成。
            Masks[0] := $FF0000; Masks[1] := $00FF00; Masks[2] := $0000FF;
          end;
        end
        else begin
          // マスクパタンをコピー。
          Move(Infos.W3HeadInfo.bmiColors[0], Masks[0], SizeOf(DWORD)*3);
        end;

        if (Masks[0] = 0) or (Masks[1] = 0) or (Masks[2] = 0) then
          raise ENkDIBInvalidDIB.Create(
            'TNkInternalDIB.LoadFromStream: Invalid Masks');


        // マスク後のシフト量を計算
        RShift := GetMaskShift(Masks[0]);
        GShift := GetMaskShift(Masks[1]);
        BShift := GetMaskShift(Masks[2]);

        // 補正前の R, G, B 値の最大値を計算
        if RShift >= 0 then MaxR := Masks[0] shr RShift
                       else MaxR := Masks[0] shl (-RShift);
        if GShift >= 0 then MaxG := Masks[1] shr GShift
                       else MaxG := Masks[1] shl (-GShift);
        if BShift >= 0 then MaxB := Masks[2] shr BShift
                       else MaxB := Masks[2] shl (-BShift);



        // ここから読み込む
        for i := 0 to Infos.W3Head.biHeight -1 do begin
          // 変換元計算
          pConvertBuffer := AddOffset(p, HeaderSize + SourceLineSize * i);
          // 変換先を計算
          pTriple := AddOffset(Infos.pBits, DestLineSize * i);
          // おしりを０クリアしておく スキャンラインのパディング
          // が０以外になるのを防ぐため。
          FillChar(AddOffset(pTriple, DestLineSize -4)^, 4, 0);

          w := Infos.W3Head.biWidth -1;

          if Infos.W3Head.biBitCount = 16 then
            // 16bpp の場合
            for j := 0 to w do begin

               // 1 pixel 変換
               if RShift >= 0 then
                 pTriple.R := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[0])
                              shr RShift) * 255 div MaxR
               else
                 pTriple.R := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[0])
                              shl (-RShift)) * 255 div MaxR;
               if GShift >= 0 then
                 pTriple.G := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[1])
                              shr GShift) * 255 div MaxG
               else
                 pTriple.G := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[1])
                              shl (-GShift)) * 255 div MaxG;
               if BShift >= 0 then
                 pTriple.B := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[2])
                              shr BShift) * 255 div MaxB
               else
                 pTriple.B := DWORD((PWordArray(pConvertBuffer)^[j] and Masks[2])
                              shl (-BShift)) * 255 div MaxB;
               inc(pTriple);
            end
          else
            // 32 bpp の場合
            for j := 0 to w do begin
               // 1 pixel 変換
               if RShift >= 0 then
                 pTriple.R := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[0])
                              shr RShift) * 255 div MaxR
               else
                 pTriple.R := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[0])
                              shl (-RShift)) * 255 div MaxR;
               if GShift >= 0 then
                 pTriple.G := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[1])
                              shr GShift) * 255 div MaxG
               else
                 pTriple.G := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[1])
                              shl (-GShift)) * 255 div MaxG;
               if BShift >= 0 then
                 pTriple.B := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[2])
                              shr BShift) * 255 div MaxB
               else
                 pTriple.B := DWORD((PDWordArray(pConvertBuffer)^[j] and Masks[2])
                              shl (-BShift)) * 255 div MaxB;
               inc(pTriple);
            end

        end;

        // 24 bpp に形式を補正

        with Infos.W3Head do begin
          // カラーテーブルの位置を補正
          if biCompression = BI_BITFIELDS then
            for i := 0 to 255 do
              with Infos.W3HeadInfo do
                bmiColors[i] := bmiColors[i+3];
 
          // ヘッダを補正
          biCompression := BI_RGB;
          biBitCount := 24;
          biSizeImage := 0;
        end;
      end
      else
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromClipboardFormat: Invalid biBitCount');



      // 仕上げ

      // 古い DIB を破棄
      FreeDIB;

      // DIB 情報を設定
      DIBInfos := Infos;

      // 幅／高さを設定
      Width := DIBInfos.W3Head.biWidth;
      Height := abs(DIBInfos.W3Head.biHeight);

      // 古いパレットを捨てる
      UpdatePalette;
    except
      if Infos.pBits <> Nil then ReleaseMemory(Infos.hFile, Infos.pBits, UseFMO);
      raise;
    end;
  finally
    GlobalUnlock(AData);
  end;
end;

// これも SaveToStream とほとんど同じなのでコメントは手抜き
procedure TNkInternalDIB.SaveToClipboardFormat(var Data: THandle);
var h: THandle;              // クリップボードに渡すメモリハンドル
    p: Pointer;              // クリップボードに渡すメモリへのポインタ
    HeaderSize: LongInt;     // ビットマップヘッダとカラーテーブルの大きさ
begin
  // DIB のヘッダーサイズ（カラーテーブルを含む）を計算する
  HeaderSize := SizeOf(TBitmapInfoHeader) +
                DIBInfos.W3Head.biClrUsed * SizeOf(TRGBQuad);

  // クリップボードに渡すメモリを確保する
  h := GlobalAlloc(GHND, HeaderSize + DIBInfos.BitsSize);
  if h = 0 then
    raise EOutOfMemory.Create(
      'TNkInternalDIB.SaveToClipboardFormat: Out Of Memory');
  p := GlobalLock(h);

  // ヘッダとカラーテーブルを書き込む
  System.Move(DIBInfos.W3Head, p^, HeaderSize);

  // ピクセル情報を書き込む
  System.Move(DIBInfos.pBits^, AddOffset(p, HeaderSize)^, DIBInfos.BitsSize);

  GlobalUnlock(h);
  Data := h;
end;


/////////////////////////////////////////////////////////////////////
// 色群を2分してゆくルーチン
// 全ピクセルの R, G, B の平均値と分散を求め、最も分散の大きい色(R or G or B)
// の平均値を用いて、色群を2分する。これを Max Depth回繰り返せば、
// ピクセル群は最大 2^MaxDepth 個の群に分けられる。各群の平均の色を求め、
// カラーテーブルを作成する。


//-------------------------------------------------------------------
// Note:
//
// CutPixels は力任せに Pixel 群を分割する。計算は全て Pixel 単位で行うので
// とても遅い(^^; ただし品質の良い分割結果が得られる。
// CutPixels は History に分割履歴を残す。このHistory を使えば 
// RGB 値と分割後の色群との対応を高速に計算できる。

procedure CutPixels(Low,   // 色群の最初のピクセルを指すインデックス
                    High,  // 色群の最後のピクセルの次を指すインデックス
                    Depth,                     // 分割の深さ
                    MaxDepth: LongInt;         // 分割の深さの最大値
                   var Bits: TNkTripleArray;   // ピクセル配列
                   var Colors: TRGBQuadArray;  // 減色カラー出力用の
                                               // カラーテーブル
                   var NumColors: LongInt;     // 出力された減色カラー色の数
                   var History: TCutHistory;   // 減色履歴
                   HistoryNodeIndex: Integer;  // 履歴を書き込む
                                               // ノードインデックス
                   ProgressHandler: TNotifyEvent); // プログレスハンドラ
var
  i, j: LongInt;
  RAve, GAve, BAve: Extended;  // 赤、緑、青の平均値
  RD, GD, BD: Extended;        // 赤、緑、青の分散
  Index: Integer;
  temp: TNkTriple;
begin
  if Low = High then begin
    // Low = High なので色群はピクセルを一つも持っていない。

    // 分割の深さが Max ならプログレスハンドラを呼びだす。
    if Depth = MaxDepth then begin
      ProgressHandler(Nil);
      Exit;  // 終わり！！
    end;
    // ダミーの分割 OnProgress エベントを起こすのに必要。
    CutPixels(Low, High, Depth+1, MaxDepth, Bits, Colors, NumColors,
              History, 0, ProgressHandler);
    CutPixels(Low, High, Depth+1, MaxDepth, Bits, Colors, NumColors,
              History, 0, ProgressHandler);
    Exit;
  end;
  // 色群の色の平均と分散を計算する。
  RAve := 0; GAve := 0; BAve := 0;
  RD := 0; GD := 0; BD := 0;


  for i := Low to High-1 do begin
    RAve := RAve + Bits[i].R;
    GAve := GAve + Bits[i].G;
    BAve := BAve + Bits[i].B;
    RD := RD + sqr(Bits[i].R * 1.0);
    GD := GD + sqr(Bits[i].G * 1.0);
    BD := BD + sqr(Bits[i].B * 1.0);
  end;

  RAve := RAve / (High-Low);
  GAve := GAve / (High-Low);
  BAve := BAve / (High-Low);

  RD := RD / (High-Low) - sqr(RAve);
  GD := GD / (High-Low) - sqr(GAve);
  BD := BD / (High-Low) - sqr(BAve);

  // Depth = MaxDepth つまり、2^MaxDepth群に分けられているならば、色の平均を
  // カラーテーブルに登録する。
  if Depth = MaxDepth then begin
    Colors[NumColors].rgbRed      := Round(RAve);
    Colors[NumColors].rgbGreen    := Round(GAve);
    Colors[NumColors].rgbBlue     := Round(BAve);
    Colors[NumColors].rgbReserved := 0;

    // 分割履歴を History に登録する。
    with History.Nodes[HistoryNodeIndex] do begin
      DivideID := cidTerminal;   // 末端のノード
      ThreshHold := 0;
      ColorIndex := NumColors;   // カラーインデックスを登録
      NextNodeIndexLow  := 0;    // 下位ノードは無い。
      NextNodeIndexHigh := 0;
    end;

    // 減色カラーが一つ登録された
    Inc(NumColors);
    ProgressHandler(Nil);
    Exit;
  end;

  // ピクセル群を分割する。

  // 赤、緑、青 のうち、最も分散の大きい色で分割する。但し、比較する時
  // 赤は3倍、緑は4倍、青は2倍してから比較する。緑や赤の方が重要なため、
  // 緑や赤で分割が起きやすい方が、良い品質のカラーテーブルが得られる。

  i := Low; j := High;

  if (RD*3 >= GD*4) and (RD*3 >= BD*2) then begin
    // 赤でピクセル群を分割する
    History.Nodes[HistoryNodeIndex].DivideID   := cidRed;
    History.Nodes[HistoryNodeIndex].ThreshHold := RAve;
    while i < j do begin
      while (i < j) and (Bits[i].R <= RAve) do inc(i);
      while (i < j) and (Bits[j-1].R > RAve) do dec(j);
      if i <> j then begin
        temp := Bits[i];
        Bits[i] := Bits[j-1];
        Bits[j-1] := temp;
      end;
    end;
  end else if (GD*4 >= RD*3) and (GD*4 >= BD*2) then begin
    // 緑でピクセル群を分割する
    History.Nodes[HistoryNodeIndex].DivideID := cidGreen;
    History.Nodes[HistoryNodeIndex].ThreshHold := GAve;
    while i < j do begin
      while (i < j) and (Bits[i].G <= GAve) do inc(i);
      while (i < j) and (Bits[j-1].G >  GAve) do dec(j);
      if i <> j then begin
        temp := Bits[i];
        Bits[i] := Bits[j-1];
        Bits[j-1] := temp;
      end;
    end;
  end else begin
    // 青でピクセル群を分割する
    History.Nodes[HistoryNodeIndex].DivideID := cidBlue;
    History.Nodes[HistoryNodeIndex].ThreshHold := BAve;
    while i < j do begin
      while (i < j) and (Bits[i].B <= BAve) do inc(i);
      while (i < j) and (Bits[j-1].B > BAve) do dec(j);
      if i <> j then begin
        temp := Bits[i];
        Bits[i] := Bits[j-1];
        Bits[j-1] := temp;
      end;
    end;
  end;

  // 分割途中なのでカラーインデックスは無い
  History.Nodes[HistoryNodeIndex].ColorIndex := 0;

  // 分割した2個のピクセル群に対し、再帰的に Cut を呼ぶ。
  
  // History ノード指定は Call 側から行う。
  Index := History.nNodes;
  Inc(History.nNodes);
  History.Nodes[HistoryNodeIndex].NextNodeIndexHigh := Index;

  // 明るい方を先にカットする。この方がカラーテーブルの先頭に
  // 明るい色が集まる。0.53 から改良
  CutPixels(i, High, Depth+1, MaxDepth, Bits, Colors, NumColors,
            History, Index, ProgressHandler);

  Index := History.nNodes;
  Inc(History.nNodes);
  History.Nodes[HistoryNodeIndex].NextNodeIndexLow := Index;

  CutPixels(Low, i, Depth+1, MaxDepth, Bits, Colors, NumColors,
            History, Index, ProgressHandler);
end;

// Color Cube 群を2分してゆくルーチン
// Color Cube 群から全ピクセルの R, G, B の平均値と分散を求め、
// 最も分散の大きい色(R or G or B) の平均値を用いて、
// Color Cube群を2分する。これを MaxDepth 回繰り返せば、
// Color Cube群は最大2^MaxDepth個の群に分けられる。各群の平均の色を求め、
// カラーテーブルを作成する。

//-------------------------------------------------------------------
// Note
//
// CutCubes の Cube の意味は元々 色の小空間の意味で使っていたが、現在は
// 複数のピクセルをまとめたものという意味に変わった(^^
// Cube にはピクセルの個数、色の平均値が入っている。True Color からの減色で
// 使う場合は、色空間を 赤は３２、緑は 64、青は３２に分割した 65536 個の色の
// 小空間に分割し、各小空間 を Cube としてまとめ このルーチンに渡せば減色
// カラーが得られる。
// 8Bit RGB からの減色で使う場合は、Cube を 8Bit RGB の各色に対応させ、
// 各色のピクセル数を数えてから このルーチンに渡せばよい。
//

procedure CutCubes(Low,        // Color Cube 群の最初の Cube を指すインデックス
                   High,       // Color Cube 群の最後の次の Cube を指す
                               //インデックス
                   Depth,             // 分割の深さ
                   MaxDepth: LongInt; // 分割の深さの最大値
                   var Cubes: TColorCubeArray64k; // Color Cube 配列
                   var Colors: TRGBQuadArray;     // 減色カラー出力用の
                                                  // カラーテーブル
                   var NumColors: LongInt;        // 出力された減色カラー色の数
                   ProgressHandler: TNotifyEvent);// プログレスハンドラ
var
  i, j, n, nPoints: LongInt;
  RAve, GAve, BAve: Extended; // 赤、緑、青の平均値
  RD, GD, BD: Extended;       // 赤、緑、青の分散
  temp: TColorCube;
begin
  if Low = High then begin
    // Low = High なので Cube 群は Cube を一つも持っていない。
  
    // 分割の深さが Max ならプログレスハンドラを呼びだす。
    if Depth = MaxDepth then begin
      ProgressHandler(Nil);
      Exit;
    end;
    // ダミーの分割 OnProgress エベントを起こすのに必要。
    CutCubes(Low, High, Depth+1, MaxDepth, Cubes, Colors, NumColors,
             ProgressHandler);
    CutCubes(Low, High, Depth+1, MaxDepth, Cubes, Colors, NumColors,
             ProgressHandler);
    Exit;
  end;

  // Cube 群の色の平均と分散を計算
  RAve := 0; GAve := 0; BAve := 0;
  RD := 0; GD := 0; BD := 0; nPoints := 0;
  for i := Low to High-1 do begin
    n := Cubes[i].n;
    Inc(nPoints, n);  // ピクセルの総数をカウント
    RAve := RAve + (Cubes[i].R * 1.0) * n;
    GAve := GAve + (Cubes[i].G * 1.0) * n;
    BAve := BAve + (Cubes[i].B * 1.0) * n;
    RD := RD + sqr(Cubes[i].R * 1.0) * n;
    GD := GD + sqr(Cubes[i].G * 1.0) * n;
    BD := BD + sqr(Cubes[i].B * 1.0) * n;
  end;

  RAve := RAve / nPoints;
  GAve := GAve / nPoints;
  BAve := BAve / nPoints;
  RD := RD / nPoints - sqr(RAve);
  GD := GD / nPoints - sqr(GAve);
  BD := BD / nPoints - sqr(BAve);

  // Depth = MaxDepth つまり、2^MaxDepth群に分けられているならば、色の平均を
  // カラーテーブルに登録する。
  if Depth = MaxDepth then begin
    Colors[NumColors].rgbRed      := Round(RAve);
    Colors[NumColors].rgbGreen    := Round(GAve);
    Colors[NumColors].rgbBlue     := Round(BAve);
    Colors[NumColors].rgbReserved := 0;
    for i := Low to High -1 do
      Cubes[i].n := NumColors;    // Color Cube に色のインデックス値を
                                  // ここで n の意味が ピクセル数から
                                  // カラーインデックスに変わる。複雑で
                                  // 好ましくないが メモリ消費を押さえるため
                                  // 共用している。Index と n から変換テーブル
                                  // を作ることができる。
    // 減色カラーが一つ登録された
    Inc(NumColors);
    ProgressHandler(Nil);
    Exit;
  end;

  // Color Cube 群を分割する。
  // 赤、緑、青 のうち、最も分散の大きい色で分割する。但し、比較する時
  // 赤は3倍、緑は4倍、青は2倍してから比較する。緑や赤の方が重要なため、
  // 緑や赤で分割が起きやすい方が、良い品質のカラーテーブルが得られる。

  i := Low; j := High;

  if (RD*3 >= GD*4) and (RD*3 >= BD*2) then begin
    // 赤で Color Cube 群を分割する
    while i < j do begin
      while (i < j) and (Cubes[i].R <= RAve) do inc(i);
      while (i < j) and (Cubes[j-1].R > RAve) do dec(j);
      if i <> j then begin
        temp := Cubes[i];
        Cubes[i] := Cubes[j-1];
        Cubes[j-1] := temp;
      end;
    end;
  end else if (GD*4 >= RD*3) and (GD*3 >= BD*2) then begin
    // 緑で Color Cube 群を分割する
    while i < j do begin
      while (i < j) and (Cubes[i].G <= GAve) do inc(i);
      while (i < j) and (Cubes[j-1].G >  GAve) do dec(j);
      if i <> j then begin
        temp := Cubes[i];
        Cubes[i] := Cubes[j-1];
        Cubes[j-1] := temp;
      end;
    end;
  end else begin
    // 青で Color Cube 群を分割する
    while i < j do begin
      while (i < j) and (Cubes[i].B <= BAve) do inc(i);
      while (i < j) and (Cubes[j-1].B > BAve) do dec(j);
      if i <> j then begin
        temp := Cubes[i];
        Cubes[i] := Cubes[j-1];
        Cubes[j-1] := temp;
      end;
    end;
  end;

  // 明るい方を先にカットする。この方がカラーテーブルの先頭に
  // 明るい色が集まる。
  CutCubes(i, High, Depth+1, MaxDepth, Cubes, Colors, NumColors,
           ProgressHandler);
  CutCubes(Low, i, Depth+1, MaxDepth, Cubes, Colors, NumColors,
           ProgressHandler);
end;

/////////////////////////////////////////////////////////////////////
// DIB の形式変換ルーチン群
//
// OldDIBInfos 内の DIB の形式を変換して NewDIBInfos にセットする。
// OldDIBInfos 内の DIB は変化しない。
//

//-------------------------------------------------------------------
// Note:
//
// DIB の形式変換ルーチンはメソッドではなく 単なるProcedure として実装した。
// 理由は すべての形式間での変換ルーチンを書くのが大変なため TNkInternalDIB が
// これらを組み合わせて使うからである。形式変換の途中で例外が生じた場合，
// TNkDIB のポリシーではメソッドを呼ぶ前の状態に戻すことになっているので，
// 変換元は書き換えず，変換元を捨てるのは呼ぶ側の責任になる。
//
// たとえば 4BitRLE から 8BitRLE への変換は
// 4BitRLE -> 4BitRGB への変換，4BitRGB -> 8BitRGB への変換，
// 8BitRGB -> 8BitRLE への変換 の3段階を踏む。これらを呼び出すのは
// TNkInternalDIB の SetPixelFormat で，3個の変換がすべてうまく行くと
// 初めて元の DIB を捨て変換結果をセットする。
//
// 変換ルーチンは以下の種類がある
//
//                                  変換先
//               1BitRGB  4BitRGB  4BitRLE  8BitRGB  8BitRLE  TrueColor
//      変換元
//     1BitRGB               ○                ○                ○
//     4BitRGB      ○                ○       ○                ○
//     4BitRLE               ○
//     8BitRGB      ○       ○                ○       ○       ○
//     8BitRLE                                 ○
//     TrueColor    ○       ○(*)             ○(*)
//
//     (*) 高速タイプ(16Bit制度) と低速タイプ(24Bit制度) の2種類がある。
//
// 計19個
//
// TNkDIB は色数が少なくなる形式変換では減色を行う。この時の TrueColor からの
// 減色の色の品質は ConvertMode Property で決まる。ConvertMode が nkCmFine の
// 時は ConvertTrueColorTo8BitRGBHigh 等が使われるが，これらは Windows API
// (StretchDIBits 等)よりよい品質の減色が得られる(^^
//
// 1 BitRGB への減色は Windows の習慣に従って背景色(BGColor Property)を使って
// 行う。BGColor と一致する色は 1(白), 一致しない色は 0(黒) に変換される。
// 1Bit RGB への変換では カラーテーブルは強制的に 
// 0: $000000(黒), 1: $FFFFFF(白) になる。
//


// 8Bit RLE -> 8Bit RGB  変換
procedure Convert8BitRLETo8BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 8Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  Count,                              // ピクセル数
  Color: BYTE;                        // カラーインデックス(Encode)/
                                      // ピクセル数(Absolute)
  pSourceByte, pByte: ^BYTE;          // 変換元データへのポインタ
begin
  pBits := Nil;

  // 旧DIB が 8BitRLE かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RLE8) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRLETo8BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 座標をリセット
    x := 0; y := 0;

    // 旧／新 DIB のピクセル情報へのポインタを設定
    pSourceByte := OldDIBInfos.pBits;
    pByte := pBits;

    while True do begin
      // 2 Byte 読む
      Count := pSourceByte^; Inc(pSourceByte);
      Color := pSourceByte^; Inc(pSourceByte);

      if Count = 0 then begin // if RLE_ESCAPE
        case Color of
          1{End Of Bitmap}: Break;
          0{EndOf Line  }: begin
            // 座標と出力先ポインタを次のラインに設定
            x := 0; Inc(y);
            pByte := AddOffset(pBits, LineLength * y);
            if y > Height then
              raise ENkDIBInvalidDIB.Create(
                'Convert8BitRLETo8BitRGB: Bad RLE Data 1');
          end;
          2{Delta}: begin
            // Delta はアニメーション用なので、ビットマップファイルには
            // 含まれないはずだが、一応処理
            // スキップ量を読み込み、座標と出力先を補正
            Inc(x, pSourceByte^); Inc(pSourceByte);
            Inc(y, pSourceByte^); Inc(pSourceByte);
            pByte := AddOffset(pBits , LineLength * y + x);
            if (x > Width) or (y > Height) then
              raise ENkDIBInvalidDIB.Create(
                'Convert8BitRLETo8BitRGB: Bad RLE Data 2');
          end;
          else begin // Absolute Mode, Color is Number of Colors to be copied!
            if (x + Color > Width) or (y >= Height) then
              raise ENkDIBInvalidDIB.Create(
                'Convert8BitRLETo8BitRGB: Bad RLE Data 3');
            // 絶対モード、２バイト目の数分だけ、ピクセル値をコピー
            System.Move(pSourceByte^, pByte^, Color);

            // 入力元ポインタをWORD 境界に位置するように更新する。
            Inc(pSourceByte, ((Color + 1) div 2) * 2);
            Inc(x, Color);
            Inc(pByte , Color);
          end;
        end;
      end
      else begin
        // Encoded Mode
        if (x + Count > Width) or (y >= Height) then
          raise ENkDIBInvalidDIB.Create(
            'Convert8BitRLETo8BitRGB: Bad RLE Data 4');
        // Count 数分だけ、Color を出力
        FillChar(pByte^, Count, Color);
        Inc(x, Count);
        Inc(pByte, Count);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit 非圧縮
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;


//-------------------------------------------------------------------
// Note
//
// RLE 圧縮では，圧縮先のピクセルデータ保持用のバッファを元の DIB と
// 同じ大きさにとる。圧縮データが元のデータより大きい場合は
// 失敗するようになっている。

// 8Bit RGB -> 8Bit RLE  変換
procedure Convert8BitRGBTo8BitRLE(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
type
  TRunMode = (rmNoData,   // Run にデータが無い
              rmUnknown,  // Run に1バイトだけデータが有り状態が不定
              rmEncode,   // Encode で出力予定
              rmAbsolute  // Absolute で出力予定
              );
var
  x, y: Integer;                      // 座標
  LineLength,                         // 8Bit RGB のスキャンラインの長さ
  CompBufferSize,                     // 圧縮用バッファのサイズ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pCompBuffer: ^Byte;                 // 圧縮用バッファ
  pByte:       ^Byte;                 // 圧縮バッファへの書き込み用ポインタ；
  pSourceByte: PByteArray64k;         // 変換元データへのポインタ
  RunBuffer: array[0..255] of Byte;   // Run バッファ
  RunIndex: Integer;                  // Run バッファアクセス用インデックス
  ColorIndex: Byte;                   // ピクセル値
  RunMode: TRunMode;                  // Run バッファの状態



  function GetRest: LongInt; // 圧縮用バッファの残量を得る。
  begin
    result := CompBufferSize - (LongInt(pByte) - LongInt(pCompBuffer));
  end;

  procedure CompFail;
  begin
    raise ENkDIBCompressionFailed.Create(
            'Convert8BitRGBTo8BitRLE: Compression Failed');
  end;

  // Encode Mode を書く ピクセル数(Count > 0) と カラーインデックス(Color)
  procedure WriteEncode(Color, Count: Byte);
  begin
    // メモリ残量チェック 4 は EndOfLine と EndOfBitmap の分
    if GetRest < (4 + 2) then CompFail;
    pByte^ := Count; Inc(pByte);
    pByte^ := Color; Inc(pByte);
  end;

  // Absolute Mode を書く ピクセル数とカラーインデックス列
  procedure WriteAbsolute;
  begin
    Assert(RunIndex > 0,
      'Convert8BitRGBTo8BitRLE: WriteAbsolute Error');

    // メモリ残量チェック 4 は EndOfLine と EndOfBitmap の分
    if GetRest < ( 4 + 2 + (((RunIndex + 1) div 2) * 2) ) then CompFail;

    // Run の長さが 2 以下の場合 Absolute モードではピクセル数が 3 以上で
    // なくてはならないため 2個の Encode Mode で書く。
    if RunIndex <= 2 then begin
      WriteEncode(RunBuffer[0], 1);
      if RunIndex = 2 then WriteEncode(RunBuffer[1], 1);
    end
    else begin
      // Run の長さが３以上の場合
      pByte^ := 0; Inc(pByte);
      pByte^ := RunIndex; Inc(pByte);
      System.Move(RunBuffer, pByte^, RunIndex);
      Inc(pByte, RunIndex);

      // ピクセル数が奇数個なら １ピクセル分パディングを書く(Run は偶数境界)
      if (RunIndex mod 2) <> 0 then begin
        pByte^ := 0; Inc(pByte);
      end;
    end;
  end;

  // EOL を書く
  procedure WriteEndOfLine;
  begin
    // メモリ残量チェック 2 は EndOfBitmap の分
    if GetRest < (2 + 2) then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 0; Inc(pByte);
  end;

  // End Of Bitmap を書く
  procedure WriteEndOfBitmap;
  begin
    if GetRest < 2 then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 1; Inc(pByte);
  end;

begin
  pBits := Nil;

  // 旧DIB が 8BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRGBTo8BitRLE: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // 圧縮用バッファサイズを RGB 形式と同じ大きさとする。これを越えたら
  // 変換失敗。
  CompBufferSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMem(pCompBuffer, CompBufferSize);

  try
    pByte := Pointer(pCompBuffer);  // 書き込み用ポインタを初期化

    for y := 0 to Height-1 do begin
      // 圧縮元のスキャンラインの先頭を求める。
      // 圧縮結果は常に Bottom-Up 形式でなければならないため biHeight の符号で
      // 読む順番を変える
      if OldDIBInfos.W3Head.biHeight > 0 then
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*y)
      else
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*(Height - 1 -y));

      RunMode := rmNodata;   // Run Mode 初期化
      for x := 0 to Width-1 do begin
        ColorIndex := pSourceByte^[x];
        case RunMode of
          rmNoData: begin
            RunBuffer[0] := ColorIndex;
            RunIndex := 1;
            RunMode := rmUnknown;
          end;
          rmUnknown:
            // 最初の２ピクセルの色が一致するなら Encode Mode にする。
            if RunBuffer[0] = ColorIndex then begin
              RunBuffer[1] := 2;  // Runbuffer[1] をカウンタとして使う
              RunMode := rmEncode;
            end
            else begin
            // 最初の２ピクセルの色が違うなら Absolute Mode にする。
              RunBuffer[RunIndex] := ColorIndex;
              Inc(RunIndex);
              RunMode := rmAbsolute;
            end;
          rmEncode:
            if (RunBuffer[1] < 255) and (RunBuffer[0] = ColorIndex) then
              Inc(RunBuffer[1])
            else begin
              // Encode Mode の切れ目を発見！！
              // (同色が途切れているか 255 に達した
              WriteEncode(RunBuffer[0], RunBuffer[1]);
              RunBuffer[0] := ColorIndex;
              RunIndex := 1;
              RunMode := rmUnknown;
            end;
          rmAbsolute:
            if (RunIndex < 255) and
               (RunBuffer[RunIndex-1] <> ColorIndex) then begin
              RunBuffer[RunIndex] := ColorIndex;
              Inc(RunIndex);
            end
            else begin
              // Absolute Mode の切れ目を発見！！
              // (同色が見つかったか 255 に達した
              if RunBuffer[RunIndex-1] <> ColorIndex then begin
                WriteAbsolute;
                RunBuffer[0] := ColorIndex;
                RunIndex := 1;
                RunMode := rmUnknown;
              end
              else begin
                Dec(RunIndex);
                WriteAbsolute;
                RunBuffer[0] := RunBuffer[RunIndex];
                RunBuffer[1] := 2;
                RunMode := rmEncode;
              end;
            end;
        end;
      end;
      // EOL に達したので RunBuffer の中身をかき出す。
      case RunMode of
        rmUnknown:  WriteEnCode(RunBuffer[0], 1);
        rmEncode:   WriteEncode(RunBuffer[0], RunBuffer[1]);
        rmAbsolute: WriteAbsolute;
      end;
      WriteEndOfLine;
    end;
    WriteEndOfBitmap;

    // 出力用バッファを確保する。
    BitsSize := LongInt(pByte) - LongInt(pCompBuffer); // 圧縮後のサイズ
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      System.Move(pCompBuffer^, pBits^, BitsSize);

      // しあげ
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biHeight := Height;         // RLE はいつも BottomUp
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit RLE
      NewDIBInfos.W3Head.biCompression := BI_RLE8;
      NewDIBInfos.W3Head.biSizeImage := BitsSize;
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);//失敗 新DIBを捨てる。
      raise;
    end;
  finally
    FreeMem(pCompBuffer, CompBufferSize);
  end;
end;

//-------------------------------------------------------------------
// Note
//
// 4Bit RLE 圧縮では少し手抜きをしている。4Bit RLE では本来 Enode/Abslute
// モードでピクセル数に奇数を指定できる。しかしそれでは大変なので EOL の直前
// 以外は偶数に限定した。こうすることで Encode Mode の処理がぐっと楽になる。
//
// 例： 本来は Encode Mode 07 45  ->   4 5 4 5 4 5 4 などとできるが
//      TNkDIB では        06 45  ->   4 5 4 5 4 5   という風に偶数ピクセルに
//      限定する。こうすることでほとんどバイト単位の処理で 4Bit RLE 圧縮が
//      できる。


// 4Bit RGB -> 4Bit RLE  変換
procedure Convert4BitRGBTo4BitRLE(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
type
  TRunMode = (rmNoData,   // Run にデータが無い
              rmUnknown,  // Run に1バイトだけデータが有り状態が不定
              rmEncode,   // Encode で出力予定
              rmAbsolute  // Absolute で出力予定
              );
var
  x, y: Integer;                      // 座標
  LineLength,                         // 4Bit RGB のスキャンラインの長さ
  CompBufferSize,                     // 圧縮ようバッファのサイズ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pCompBuffer: ^Byte;                 // 圧縮用バッファ
  pByte:       ^Byte;                 // 圧縮バッファへの書き込み用ポインタ；
  pSourceByte: PByteArray64k;         // 変換元データへのポインタ
  RunBuffer: array[0..255] of Byte;   // Run バッファ
  RunIndex: Integer;                  // Run バッファアクセス用インデックス
  ColorIndex: Byte;                   // ピクセル値
  PixelCounter: Integer;              // スキャンラインに書き込んだピクセル数
  RunMode: TRunMode;                  // Run バッファの状態


  function GetRest: LongInt; // 圧縮用バッファの残量を得る。
  begin
    result := CompBufferSize - (LongInt(pByte) - LongInt(pCompBuffer));
  end;

  procedure CompFail;
  begin
    raise ENkDIBCompressionFailed.Create(
            'Convert4BitRGBTo4BitRLE: Compression Failed');
  end;

  // Encode Mode を書く ピクセル数(Count*2 > 0) と カラーインデックス(Color)
  procedure WriteEncode(Color, Count: Byte);
  begin
    // メモリ残量チェック 4 は EndOfLine と EndOfBitmap の分
    if GetRest < (4 + 2) then CompFail;

    if (Width - PixelCounter) < (Count * 2) then begin
      // スキャンラインの長さが奇数なら，ライン末のEncode を書き込むとき
      // (Width - PixelCounter) = (Count * 2) -1 になるはず。
      // その場合は残ピクセル数をセットする。
      pByte^ := Width - PixelCounter; PixelCounter := Width; Inc(pByte);
    end
    else begin
      // ピクセル数はバイト数の2倍
      pByte^ := Count*2; Inc(PixelCounter, Count*2); Inc(pByte);
    end;
    pByte^ := Color; Inc(pByte);
  end;

  // Absolute Mode を書く ピクセル数(RunIndex*2)とカラーインデックス列
  procedure WriteAbsolute;
  begin
    Assert(RunIndex > 0,
      'Convert4BitRGBTo4BitRLE: WriteAbsolute Error');

    // メモリ残量チェック 4 は EndOfLine と EndOfBitmap の分
    if GetRest < ( 4 + 2 + (((RunIndex + 1) div 2) * 2) ) then CompFail;

    if RunIndex <= 1 then begin 
      // Run の長さが 2 ピクセル以下の場合 Absolute モードではピクセル数が 
      // 3 以上でなくてはならないため 1個の Encode Mode で書く。
      WriteEncode(RunBuffer[0], 1);
    end
    else begin
      // Run の長さが３ピクセル以上の場合
      pByte^ := 0; Inc(pByte);
      if (Width - PixelCounter) < (RunIndex * 2) then begin
        // スキャンラインの長さが奇数なら，ライン末の abslute を書き込むとき
        // (Width - PixelCounter) = (RunIndex * 2) -1 になるはず。
        // その場合は残ピクセル数をセットする。
        pByte^ := Width - PixelCounter; PixelCounter := Width; Inc(pByte);
      end
      else begin
        // Abslute の長さ RunIndex（バイト長)*2 を書く
        pByte^ := RunIndex*2; Inc(PixelCounter, RunIndex*2); Inc(pByte);
      end;
      System.Move(RunBuffer, pByte^, RunIndex);
      Inc(pByte, RunIndex);

      // バイト長が奇数なら １バイト分パディングを書く
      // (Run は偶数境界)
      if (RunIndex mod 2) <> 0 then begin
        pByte^ := 0; Inc(pByte);
      end;
    end;
  end;

  // EOL を書く
  procedure WriteEndOfLine;
  begin
    // メモリ残量チェック 2 は  EndOfBitmap の分
    if GetRest < (2 + 2) then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 0; Inc(pByte);
  end;

  // End Of Bitmap を書く
  procedure WriteEndOfBitmap;
  begin
    if GetRest < 2 then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 1; Inc(pByte);
  end;

begin
  pBits := Nil;

  // 旧DIB が 4BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBTo4BitRLE: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 4 + 31) div 32) * 4;

  // 圧縮用バッファサイズを RGB 形式と同じ大きさとする。これを越えたら
  // 変換失敗。
  CompBufferSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMem(pCompBuffer, CompBufferSize);

  try
    pByte := Pointer(pCompBuffer);  // 書き込み用ポインタを初期化

    for y := 0 to Height-1 do begin
      // 圧縮元のスキャンラインの先頭を求める。
      // 圧縮結果は常に Bottom-Up 形式でなければならないため biHeight の符号に
      // 読む順番を変える
      if OldDIBInfos.W3Head.biHeight > 0 then
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*y)
      else
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*(Height - 1 -y));

      RunMode := rmNodata;  // Run Mode 初期化
      PixelCounter := 0;

      // Width が奇数なら Width + 1 (バイト境界)まで処理する。
      for x := 0 to ((Width+1) div 2) -1 do begin
        ColorIndex := pSourceByte^[x];
        case RunMode of
          rmNoData: begin
            RunBuffer[0] := ColorIndex;
            RunIndex := 1;
            RunMode := rmUnknown;
          end;
          rmUnknown:
            // 最初の２バイトが一致するなら Encode Mode にする。
            if RunBuffer[0] = ColorIndex then begin
              RunBuffer[1] := 2;  // Runbuffer[1] をカウンタとして使う
              RunMode := rmEncode;
            end
            else begin
            // 最初の２バイトが違うなら Absolute Mode にする。
              RunBuffer[RunIndex] := ColorIndex;
              Inc(RunIndex);
              RunMode := rmAbsolute;
            end;
          rmEncode:
              // Encode Mode の切れ目を発見！！
              // 同バイト値が途切れているか 254 Pixelに達した場合
              // Note: 本来は 255 Pixel だが偶数 Pixel のみ対象にするため
            if (RunBuffer[1] < 127) and (RunBuffer[0] = ColorIndex) then
              Inc(RunBuffer[1])
            else begin
              WriteEncode(RunBuffer[0], RunBuffer[1]);
              RunBuffer[0] := ColorIndex;
              RunIndex := 1;
              RunMode := rmUnknown;
            end;
          rmAbsolute:
            if (RunIndex < 127) and
               (RunBuffer[RunIndex-1] <> ColorIndex) then begin
              RunBuffer[RunIndex] := ColorIndex;
              Inc(RunIndex);
            end
            else begin
              // Absolute Mode の切れ目を発見！！
              // (同バイト値が見つかったか 255 に達した
              if RunBuffer[RunIndex-1] <> ColorIndex then begin
                WriteAbsolute;
                RunBuffer[0] := ColorIndex;
                RunIndex := 1;
                RunMode := rmUnknown;
              end
              else begin
                Dec(RunIndex);
                WriteAbsolute;
                RunBuffer[0] := RunBuffer[RunIndex];
                RunBuffer[1] := 2;
                RunMode := rmEncode;
              end;
            end;
        end;
      end;
      // EOL に達したので RunBuffer の中身をかき出す。
      case RunMode of
        rmUnknown:  WriteEnCode(RunBuffer[0], 1);
        rmEncode:   WriteEncode(RunBuffer[0], RunBuffer[1]);
        rmAbsolute: WriteAbsolute;
      end;
      WriteEndOfLine;
    end;
    WriteEndOfBitmap;

    // 出力用バッファを確保する。
    BitsSize := LongInt(pByte) - LongInt(pCompBuffer); // 圧縮後のサイズ
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      System.Move(pCompBuffer^, pBits^, BitsSize);

      // しあげ
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biHeight := Height;         // RLE はいつも BottomUp
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 4;            // 4 Bit RLE
      NewDIBInfos.W3Head.biCompression := BI_RLE4;
      NewDIBInfos.W3Head.biSizeImage := BitsSize;
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新DIBを捨てる。
      raise;
    end;
  finally
    FreeMem(pCompBuffer, CompBufferSize);
  end;
end;


// 4Bit RGB -> 8Bit RGB  変換
procedure Convert4BitRGBTo8BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 8Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte, pByte: ^BYTE;          // 変換元スキャンラインへのポインタ
begin
  pBits := Nil;

  // 旧DIB が 4BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBTo8BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 旧 DIB のラインの大きさを計算
    SourceLineLength := ((Width * 4 + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を 4Bit づつ取り出して 8Bit づつ書き込む
      for x := 0 To Width -1 do begin
        if (x mod 2) = 0 then begin
          pByte^ := (pSourceByte^ shr 4) and $0f;
          Inc(pByte);
        end
        else begin
          pByte^ := pSourceByte^ and $0f;
          Inc(pByte);
          Inc(pSourceByte);
        end;
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit 非圧縮
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIBを捨てる。
    raise;
  end;
end;

// 1Bit RGB -> 8Bit RGB  変換
procedure Convert1BitRGBTo8BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 8Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte, pByte: ^BYTE;          // 変換元スキャンラインへのポインタ
  Bits8: Byte;                        // ビット操作用変数。
begin
  pBits := Nil;
  Bits8 := 0; // コンパイラの警告を黙らせるため

  // 旧DIB が 1BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 1) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert1BitRGBTo8BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 旧 DIB のラインの大きさを計算
    SourceLineLength := ((Width + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);
       // 旧のピクセル値を 1Bit づつ取り出して 8Bit づつ書き込む
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := pSourceByte^;
          Inc(pSourceByte);
        end;
         // 1 Bit -> 8 Bit
        if (Bits8 and $80) <> 0 then pByte^ := 1 else pByte^ := 0;
        Bits8 := (Bits8 and $7f) shl 1;
        Inc(pByte);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit 非圧縮
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;

// 1Bit RGB -> 4Bit RGB  変換
procedure Convert1BitRGBTo4BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 4Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte, pByte: ^BYTE;          // 変換元スキャンラインへのポインタ
  Bits8: Byte;                        // ビット操作用変数。
begin
  pBits := Nil;
  Bits8 := 0; // コンパイラの警告を黙らせるため

  // 旧DIB が 1BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 1) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert1BitRGBTo4BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 4 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 旧 DIB のラインの大きさを計算
    SourceLineLength := ((Width + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);
       // 旧のピクセル値を 1Bit づつ取り出して 4Bit づつ書き込む
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := pSourceByte^;
          Inc(pSourceByte);
        end;
         // 1 Bit -> 8 Bit
        if (Bits8 and $80) <> 0 then begin
          if (x mod 2) = 0 then
            pByte^ := 16
          else begin
            pByte^ := pByte^ or 1;
            Inc(pByte);
          end;
        end
        else begin
          if (x mod 2) = 0 then
            pByte^ := 0
          else begin
            pByte^ := pByte^ or 0;
            Inc(pByte);
          end;
        end;

        Bits8 := (Bits8 and $7f) shl 1;
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit 非圧縮
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;


// 4Bit RLE -> 4Bit RGB  変換
procedure Convert4BitRLETo4BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  i: Integer;
  x, y: Integer;                      // 座標
  LineLength,                         // 4Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  Width2: Integer;                    // Width を偶数に切り上げたもの
  Count,                              // Encode Mode のピクセル値
  Color: BYTE;                        // Encode Mode の Color Index 
                                      // Absolute Mode のピクセル数。
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte,                        // 変換元データへのポインタ
  pByte,                              // 変換先データへのポインタ
  pTemp: ^Byte;

begin
  pBits := Nil;

  // 旧DIB が 4BitRLE かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RLE4) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRLETo4BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width * 4 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 座標をリセット
    x := 0; y := 0;

    // 旧／新 DIB のピクセル情報へのポインタを設定
    pSourceByte := OldDIBInfos.pBits;
    pByte := pBits;


    // 4Bit RLE の場合、 幅が奇数ピクセルの場合、1ピクセル余分に Encode
    // されるケースがある。そのため、幅のチェックを偶数ピクセル数で
    // 行うようにする。
    // 
    // Note: 本来不正なビットマップだが かなりの数が存在するのでやもうえない。
    //       Windows API も文句を言わないようだ(StretchDIBits など)
    Width2 := ((Width + 1) div 2) * 2;

    while True do begin
      //２バイト読む
      Count := pSourceByte^; Inc(pSourceByte);
      Color := pSourceByte^; Inc(pSourceByte);

      if Count = 0 then begin // if RLE_ESCAPE
        case Color of
          1{End Of Bitmap}: Break;
          0{End Of Line  }: begin
            // 座標と出力先ポインタを次のラインに設定
            x := 0; Inc(y);
            pByte := AddOffset(pBits, LineLength * y);
            if y > Height then
              raise ENkDIBInvalidDIB.Create(
                'Convert4BitRLETo4BitRGB: Bad RLE Data 5');
          end;
          2{Delta}: begin
            // Delta はアニメーション用なので、ビットマップファイルには
            // 含まれないはずだが、一応処理
            // スキップ量を読み込み、座標と出力先を補正
            Inc(x, pSourceByte^); Inc(pSourceByte);
            Inc(y, pSourceByte^); Inc(pSourceByte);
            pByte := AddOffset(pBits , LineLength * y + x);
            if (x > Width2) or (y > Height) then
              raise ENkDIBInvalidDIB.Create(
                'Convert4BitRLETo4BitRGB: Bad RLE Data 6');
          end;
          else begin // Absolute Mode, Color is Number of Colors to be copied!
            if (x + Color > Width2) or (y >= Height) then
              raise ENkDIBInvalidDIB.Create(
                'Convert4BitRLETo4BitRGB: Bad RLE Data 7');

            // 絶対モード、２バイト目の数分だけ、ピクセル値をコピー
            pTemp := pSourceByte;

            for i := 0 to Color -1 do
              if (i mod 2) = 0 then begin
                if ((x + i) mod 2) = 0 then
                  pByte^ := pTemp^ and $f0
                else begin
                  pByte^ := pByte^ or ((pTemp^ shr 4) and $0f);
                  Inc(pByte);
                end;
              end
              else begin
                if ((x + i) mod 2) = 0 then
                  pByte^ := (pTemp^ shl 4) and $f0
                else begin
                  pByte^ := pByte^ or (pTemp^ and $0f);
                  Inc(pByte);
                end;
                Inc(pTemp);
              end;
            // 入力元ポインタをWORD 境界に位置するように更新する。
            Inc(pSourceByte, ((Color * 4 + 15) div 16) * 2);
            Inc(x, Color);
          end;
        end;
      end
      else begin
        // Encoded Mode
        if (x + Count > Width2) or (y >= Height) then
          raise ENkDIBInvalidDIB.Create(
            'Convert4BitRLETo4BitRGB: Bad RLE Data 8');

        // Count 数分だけ、Color を出力
        for i := 0 to Count -1 do
          if (i mod 2) = 0 then begin
            if ((x + i) mod 2) = 0 then
              pByte^ := Color and $f0
            else begin
              pByte^ := pByte^ or ((Color shr 4) and $0f);
              Inc(pByte);
            end;
          end
          else begin
            if ((x + i) mod 2) = 0 then
              pByte^ := (Color shl 4) and $f0
            else begin
              pByte^ := pByte^ or (Color and $0f);
              Inc(pByte);
            end;
          end;

          Inc(x, Count);
        end;
      end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit 非圧縮
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;

// 1Bit RGB を TrueColor に変換。
procedure Convert1BitRGBToTrueColor(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // TrueColorスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte: ^Byte;                 // 変換元データへのポインタ
  pTriple: ^TNkTriple;                // 変換先データへのポインタ
  Bits8: Byte;                        // ビット操作用変数。
  ColorIndex: Byte;                   // カラーのインデックス
begin
  pBits := Nil;
  Bits8 := 0; // コンパイラの警告を黙らせるため

  // 旧DIB が 1BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 1) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert1BitRGBToTrueColor: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 1Bit -> True Color  変換

    // 旧 DIB のラインの大きさを計算
    SourceLineLength := ((Width + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pTriple := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を 1Bit づつ取り出して 24Bit づつ書き込む
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := pSourceByte^;
          Inc(pSourceByte);
        end;

        // 1Bit -> 24 Bit 変換
        if (Bits8 and $80) <> 0 then ColorIndex := 1 else ColorIndex := 0;

        pTriple.R := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbRed;
        pTriple.G := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbGreen;
        pTriple.B := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbBlue;

         Bits8 := (Bits8 and $7f) shl 1;
        Inc(pTriple);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 24;            // True Color
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;


// 4Bit RGB を TrueColor に変換。
procedure Convert4BitRGBToTrueColor(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // TrueColor のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte: ^Byte;                 // 変換元データへのポインタ
  pTriple: ^TNkTriple;                // 変換先データへのポインタ
  ColorIndex: Byte;                   // カラーのインデックス

begin
  pBits := Nil;

  // 旧DIB が 4BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBToTrueColor: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 4Bit -> True Color  変換

    // 旧 DIB のラインの大きさを計算
    SourceLineLength := ((Width*4 + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pTriple := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を 4Bit づつ取り出して 24Bit づつ書き込む
      for x := 0 To Width -1 do begin
        if (x mod 2) = 0 then
          ColorIndex := (pSourceByte^ shr 4) and $0f
        else begin
          ColorIndex := pSourceByte^ and $0f;
          Inc(pSourceByte);
        end;

        // 4Bit -> 24 Bit 変換
        pTriple.R := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbRed;
        pTriple.G := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbGreen;
        pTriple.B := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbBlue;

        Inc(pTriple);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 24;            // True Color
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;

// 8Bit RGB を TrueColor に変換。
procedure Convert8BitRGBToTrueColor(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // TrueColor のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte: ^Byte;                 // 変換元データへのポインタ
  pTriple: ^TNkTriple;                // 変換先データへのポインタ
  ColorIndex: Byte;                   // カラーのインデックス

begin
  pBits := Nil;

  // 旧DIB が 8BitRGB かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRGBToTrueColor: ' +
          'Invalid Bitcount & Compression Combination');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 4Bit -> True Color  変換

    // 旧 DIB のラインの大きさを計算
    SourceLineLength := ((Width*8 + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pTriple := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を 8Bit づつ取り出して 24Bit づつ書き込む
      for x := 0 To Width -1 do begin
        ColorIndex := pSourceByte^;
        Inc(pSourceByte);

        // 8Bit -> 24 Bit 変換
        pTriple.R := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbRed;
        pTriple.G := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbGreen;
        pTriple.B := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbBlue;

        Inc(pTriple);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 24;            // True Color
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;



// True Color を 16bit 精度で減色するルーチン。
// MaxDepth で色数を指定する。 4: 16色  8: 256 色
// 色空間を 赤は３２、緑は 64、青は３２に分割した 65536 個の色の
// 小空間に分割し、各小空間 を Cube としてまとめ CutCubes で減色する。

// TrueColor ビットマップから 最適化された減色カラーを得る。１６ビット精度
procedure GetReducedColorsLow(var DIBInfos:TNkDIBInfos;
                              var NumColors: LongInt;
                              var Colors: TRGBQuadArray;
                              var ColorTransTable: TByteArray64k3D;
                                  MaxDepth: Integer;
                                  ProgressHandler: TNotifyEvent);
var
  i, j,
  Width, Height,                    // ビットマップの大きさ
  SourceLineLength,                 // True Color のスキャンラインの長さ
  NumCubes: LongInt;                // 小空間の数
  pColorTransTable1: PByteArray64k; // 色変換テーブルへのポインタ
  pCubes1: PColorCubeArray64k;      // 小空間配列へのポインタ（１次元）
  pCubes2: PColorCubeArray64k3D;    // 小空間配列へのポインタ（３次元）
  pSourceTriple: PNkTripleArray;    // TrueColor ビットマップアクセス用ポインタ
  ri, gi, bi, n: LongInt;           // ピクセル の RGB 値の 上位の部分を
                                    // 抜き出したもの
                                    // 赤: 上位5ビット  緑: 上位6ビット
                                    // 青: 上位5ビット
begin
  Width := DIBInfos.W3Head.biWidth;
  Height := abs(DIBInfos.W3Head.biHeight);
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  //色変換テーブルのメモリを確保
  pCubes1 := Nil;
  pColorTransTable1 := @ColorTransTable;
  try
    // True Color ビットマップから 2^MaxDepth 色の最適化カラーを抽出する。

    // まず、Cubes（色の小空間配列) を作る

    // Color Cube Array の メモリを確保
    GetMem(pCubes1,  SizeOf(TColorCubeArray64k));
    pCubes2 := PColorCubeArray64k3D(pCubes1);

    // Color Cube Array を初期化
    FillChar(pCubes1^, SizeOf(TColorCubeArray64k), 0);
    for i := 0 to 65535 do
      pCubes1^[i].Index := i; // Color Cube の元の位置が分かるように
                              // Index を付ける。色変換テーブルを作るときに使う

    // Color Cube Array にピクセル情報を積算
    for i := 0 to Height-1 do begin

      // DIB のラインの先頭アドレスを算出
      pSourceTriple := AddOffset(DIBInfos.pBits, SourceLineLength * i);

      // ラインに対して
      for j := 0 to Width-1 do begin

        //Color Cube のインデックス値を求める
        ri := pSourceTriple^[j].R shr 3;
        gi := pSourceTriple^[j].G shr 2;
        bi := pSourceTriple^[j].B shr 3;

        // RGB 値のインデックス値に対する差分だけを積算する。
        // こうすることで、32Bit でも積算できる。
        Inc(pCubes2^[ri, gi, bi].R, pSourceTriple^[j].R and $07);
        Inc(pCubes2^[ri, gi, bi].G, pSourceTriple^[j].G and $03);
        Inc(pCubes2^[ri, gi, bi].B, pSourceTriple^[j].B and $07);
        Inc(pCubes2^[ri, gi, bi].n);
      end;
    end;

    // 各 Color Cube の RGB 値の平均値を得る。
    for ri := 0 to 31 do
      for gi := 0 to 63 do
        for bi := 0 to 31 do begin
          n := pCubes2^[ri, gi, bi].n;
          if n <> 0 then begin
            pCubes2^[ri, gi, bi].R :=
              (ri shl 3) + pCubes2^[ri, gi, bi].R div n;
            pCubes2^[ri, gi, bi].G :=
              (gi shl 2) + pCubes2^[ri, gi, bi].G div n;
            pCubes2^[ri, gi, bi].B :=
              (bi shl 3) + pCubes2^[ri, gi, bi].B div n;
          end;
        end;

    // カラーテーブルを作る。

    // ピクセルが1個以上入っている Color Cube だけを選ぶ
    // こうすることで、色の偏りが激しい場合、計算量が激減する可能性が高い。
    NumCubes := 0;

    for i := 0 to 32*64*32-1 do
      if pCubes1^[i].n <> 0 then begin
        pCubes1^[NumCubes] := pCubes1^[i];
        Inc(NumCubes);
      end;


    NumColors := 0; //抽出される色数を初期設定
    // 色を抽出する
    CutCubes(0, NumCubes, 0, MaxDepth, pCubes1^, Colors, NumColors,
             ProgressHandler);

    // 色変換テーブルを作る。Index が n に変換されるテーブルを
    // 作ればよい。
    FillChar(pColorTransTable1^, SizeOf(TByteArray64k), 0);
    for i := 0 to NumCubes-1 do
      pColorTransTable1^[pCubes1^[i].Index] := pCubes1^[i].n;

  finally
    // Color Cube Array を破棄する。
    if pCubes1 <> Nil then FreeMem(pCubes1,  SizeOf(TColorCubeArray64k));
  end;
end;


// TrueColor を 8BitRGB に変換。16Bit 精度
procedure ConvertTrueColorTo8BitRGBLow(var OldDIBInfos: TNkDIBInfos;
                                       var NewDIBInfos: TNkDIBInfos;
                                       ProgressHandler: TNotifyEvent;
                                       UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 8Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Colors: TRGBQuadArray;              // 抽出されたカラーテーブル。
  pColorTransTable: PByteArray64k3D;  // 色変換テーブル。
  ColorTriple: TNkTriple;             // ピクセル値 True Color -> 8 Bit 変換用
  NumColors: LongInt;                 // 抽出された色の数
begin
  pBits := Nil;

  // 旧DIB が TrueColor かチェック
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo8BitRGBLow: ' +
          'Invalid Bitcount');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*8 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    GetMem(pColorTransTable, SizeOf(TByteArray64k));
    try

      // 減色カラーと色変換テーブルを得る。
      GetReducedColorsLow(OldDIBInfos, NumColors, Colors,
                          pColorTransTable^, 8, ProgressHandler);

      // さあ、変換開始！！

      for y := 0 to Height -1 do begin
        // 新／旧 DIB のラインの先頭へのポインタを作成
        pByte := AddOffset(pBits, LineLength * y);
        pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

        // 旧のピクセル値を取り出し 変換テーブルを引いて
        // 色のインデックス値を書き込む
        for x := 0 To Width -1 do begin

          // ピクセル値を取り出す
          ColorTriple := pSourceTriple^[x];

          // 変換して書き込む
          pByte^ := pColorTransTable^[ColorTriple.R shr 3,
                                      ColorTriple.G shr 2,
                                      ColorTriple.B shr 3];
          Inc(pByte);
        end;
      end;
    finally
      // 色変換テーブルを破棄する
      if pColorTransTable <> Nil then
        FreeMem(pColorTransTable, Sizeof(TByteArray64k));
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    // 減色された新しいカラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := NumColors;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;

// TrueColor を 4BitRGB に変換。16Bit 精度
procedure ConvertTrueColorTo4BitRGBLow(var OldDIBInfos: TNkDIBInfos;
                                       var NewDIBInfos: TNkDIBInfos;
                                       ProgressHandler: TNotifyEvent;
                                       UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 4Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Colors: TRGBQuadArray;              // 抽出されたカラーテーブル。
  pColorTransTable: PByteArray64k3D;  // 色変換テーブル。
  ColorTriple: TNkTriple;             // ピクセル値 True Color -> 8 Bit 変換用
  NumColors: LongInt;                 // 抽出された色の数
  ColorIndex: LongInt;                // カラーインデックス
begin
  pBits := Nil;

  // 旧DIB が TrueColor かチェック
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo4BitRGBLow: ' +
          'Invalid Bitcount');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*4 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    GetMem(pColorTransTable, SizeOf(TByteArray64k));
    try

      // 減色カラーと色変換テーブルを得る。
      GetReducedColorsLow(OldDIBInfos, NumColors, Colors,
                          pColorTransTable^, 4, ProgressHandler);

      // さあ、変換開始！！
      for y := 0 to Height -1 do begin
        // 新／旧 DIB のラインの先頭へのポインタを作成
        pByte := AddOffset(pBits, LineLength * y);
        pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

        // 旧のピクセル値を取り出し 変換テーブルを引いて
        // 色のインデックス値を書き込む
        for x := 0 To Width -1 do begin

          // ピクセル値を取り出す
          ColorTriple := pSourceTriple^[x];

          // 変換して書き込む
          ColorIndex := pColorTransTable^[ColorTriple.R shr 3,
                                          ColorTriple.G shr 2,
                                          ColorTriple.B shr 3];
          if (x mod 2) = 0 then
            pByte^ := (ColorIndex shl 4) and $f0
          else begin
            pByte^ := pByte^ or ColorIndex;
            Inc(pByte);
          end;
        end;
      end;
    finally
      // 色変換テーブルを破棄する
      if pColorTransTable <> Nil then
        FreeMem(pColorTransTable, Sizeof(TByteArray64k));
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    // 減色された新しいカラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := NumColors;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;



//
// このルーチンは TrueColor から減色カラーと分割履歴を得る。
// 処理はほとんど CutPixel が行うので、 GetReducedColorsHigh が行うのは
// ピクセルを1次元配列に直すことだけである。
//

// TrueColor ビットマップから 最適化された減色カラーを得る。24ビット精度
procedure GetReducedColorsHigh(var DIBInfos:TNkDIBInfos;
                               var NumColors: LongInt;
                               var Colors: TRGBQuadArray;
                               var History: TCutHistory;
                                   MaxDepth: Integer;
                               ProgressHandler: TNotifyEvent);
var
  pBits: PNkTripleArray;             // ピクセルの配列へのポインタ
  LineWidth: LongInt;                // DIB の1ラインの大きさ
  NumPixels, i: LongInt;             // 総ピクセル数
  Width, Height: LongInt;            // 高さ，幅
begin
  Width := DIBInfos.W3Head.biWidth;
  Height := abs(DIBInfos.W3Head.biHeight);

  History.nNodes := 1;

  NumColors := 0;              // 選ばれる色を０に初期設定
  NumPixels := Width * Height; // 総ピクセル数計算

  // DIB の1ラインの大きさを計算
  LineWidth := ((Width * 3 + 3) div 4) * 4;

  // ピクセルデータ処理用のバッファを確保
  GetMem(pBits, Width * Height * 3 + 4);
  try
    // ピクセルを詰めてバッファにコピー（ライン間の隙間を削除する）
    for i := 0 to Height-1 do
      System.Move(AddOffset(DIBInfos.pBits, LineWidth * i)^,
                  pBits^[Width * i], LineWidth);

    // 色を抽出
    CutPixels(0, NumPixels, 0, MaxDepth, pBits^, Colors, NumColors, History, 0,
              ProgressHandler);

  finally
    // 作業用バッファを破棄する。
    FreeMem(pBits, Width * Height * 3 + 4);
  end;
end;


//-------------------------------------------------------------------
// Note:
//
// 以下の2ルーチン ConvertTrueColorTo8BitRGBHight と
// ConvertTrueColorTo4BitRGBHight は GetReducedColrosHigh を使って減色を
// し、形式変換を行う。これらのルーチンでは減色された色へ色変換を行うとき
// 24Bit 精度で色変換を行うため色変換テーブルが使えない。千6百万色分の色変換
// テーブルなど作るのは不可能だからだ。その代わりに、減色の過程を記録した
// 履歴を元に、最大 MaxDepth回の比較で RGB値を Color Index に変換する。
// 分割履歴の詳細は CutPixels を参照されたい。

// TrueColor を 8BitRGB に変換。24Bit 精度
procedure ConvertTrueColorTo8BitRGBHigh(var OldDIBInfos: TNkDIBInfos;
                                        var NewDIBInfos: TNkDIBInfos;
                                        ProgressHandler: TNotifyEvent;
                                        UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 8Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Colors: TRGBQuadArray;              // 抽出されたカラーテーブル。
  ColorTriple: TNkTriple;             // ピクセル値 True Color -> 8 Bit 変換用
  NumColors: LongInt;                 // 抽出された色の数
  History: TCutHistory;               // 減色履歴
  HistoryIndex: Integer;              // 履歴インデックス
begin
  pBits := Nil;

  // 旧DIB が TrueColor かチェック
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo8BitRGBHigh: ' +
          'Invalid Bitcount');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*8 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    // 減色カラー（256色）と分割履歴を得る。
    GetReducedColorsHigh(OldDIBInfos, NumColors, Colors,
                           History, 8, ProgressHandler);

    // さあ、変換開始！！
    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を取り出し 変換テーブルを引いて
      // 色のインデックス値を書き込む
      for x := 0 To Width -1 do begin

        // ピクセル値を取り出す
        ColorTriple := pSourceTriple^[x];

        // RGB -> Color Index 変換
        HistoryIndex := 0;
        while History.Nodes[HistoryIndex].DivideID <> cidTerminal do
          with History.Nodes[HistoryIndex] do
            case DivideID of
              cidRed:   if ColorTriple.R <= ThreshHold then
                          HistoryIndex := NextNodeIndexLow
                        else
                          HistoryIndex := NextNodeIndexHigh;
              cidGreen: if ColorTriple.G <= ThreshHold then
                          HistoryIndex := NextNodeIndexLow
                        else
                          HistoryIndex := NextNodeIndexHigh;
              cidBlue:  if ColorTriple.B <= ThreshHold then
                          HistoryIndex := NextNodeIndexLow
                        else
                          HistoryIndex := NextNodeIndexHigh;
              else     Assert(False,
                         'ConvertTrueColorTo8BitRGBHigh: Invalid DivideID');
            end;

        // 変換して書き込む
        pByte^ := History.Nodes[HistoryIndex].ColorIndex;
        Inc(pByte);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    // 減色された新しいカラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := NumColors;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;

// TrueColor を 4BitRGB に変換。24Bit 精度
procedure ConvertTrueColorTo4BitRGBHigh(var OldDIBInfos: TNkDIBInfos;
                                        var NewDIBInfos: TNkDIBInfos;
                                        ProgressHandler: TNotifyEvent;
                                        UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 4Bit のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Colors: TRGBQuadArray;              // 抽出されたカラーテーブル。
  ColorTriple: TNkTriple;             // ピクセル値 True Color -> 8 Bit 変換用
  NumColors: LongInt;                 // 抽出された色の数
  History: TCutHistory;               // 減色履歴
  HistoryIndex: Integer;              // 減色履歴インデックス
begin
  pBits := Nil;

  // 旧DIB が TrueColor かチェック
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo4BitRGBHigh: ' +
          'Invalid Bitcount');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*4 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    // 減色カラー（16色）と分割履歴を得る。
    GetReducedColorsHigh(OldDIBInfos, NumColors, Colors,
                           History, 4, ProgressHandler);
    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を取り出し 変換テーブルを引いて
      // 色のインデックス値を書き込む
      for x := 0 To Width -1 do begin

        // ピクセル値を取り出す
        ColorTriple := pSourceTriple^[x];

        // RGB -> Color Index 変換
        HistoryIndex := 0;
        while History.Nodes[HistoryIndex].DivideID <> cidTerminal do
          with History.Nodes[HistoryIndex] do
            case DivideID of
              cidRed:   if ColorTriple.R <= ThreshHold then
                          HistoryIndex := NextNodeIndexLow
                        else
                          HistoryIndex := NextNodeIndexHigh;
              cidGreen: if ColorTriple.G <= ThreshHold then
                          HistoryIndex := NextNodeIndexLow
                        else
                          HistoryIndex := NextNodeIndexHigh;
              cidBlue:  if ColorTriple.B <= ThreshHold then
                          HistoryIndex := NextNodeIndexLow
                        else
                          HistoryIndex := NextNodeIndexHigh;
              else     Assert(False,
                         'ConvertTrueColorTo8BitRGBHigh: Invalid DivideID');
            end;

        // 変換して書き込む
        if (x mod 2) = 0 then
          pByte^ := (History.Nodes[HistoryIndex].ColorIndex shl 4) and $f0
        else begin
          pByte^ := pByte^ or (History.Nodes[HistoryIndex].ColorIndex and $0f);
          Inc(pByte);
        end;
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    // 減色された新しいカラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := NumColors;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;


//-------------------------------------------------------------------
// Note:
//
// 256 色ビットマップから 16 色への減色は CutCubes を使う
// 256 色ビットマップは色が256色しかないので、各色のピクセル数を数え
// 各色を一つの Color Cube にまとめて CutCubes に渡せばよい。
// 

// 256色 ビットマップから 最適化された16色減色カラーを得る。
procedure GetReducedColorsFrom256(var DIBInfos:TNkDIBInfos;
                                  var NumColors: LongInt;
                                  var Colors: TRGBQuadArray;
                                  var ColorTransTable: TByteArray256;
                                  ProgressHandler: TNotifyEvent);
var
  i, j, 
  Width, Height,                // ビットマップの大きさ
  SourceLineLength,             // スキャンラインの長さ
  NumCubes: LongInt;            // 減色された色の数
  pCubes: PColorCubeArray64k;   // Color Cube へのポインタ
  pSourceByte: ^Byte;           // ビットマップデータへのポインタ
begin
  Width := DIBInfos.W3Head.biWidth;
  Height := abs(DIBInfos.W3Head.biHeight);
  SourceLineLength := ((Width*8 + 31) div 32) * 4;

  //色変換テーブルのメモリを確保
  pCubes := Nil;
  try
    // Color Cube Array のメモリを確保
    GetMem(pCubes,  SizeOf(TColorCube)*256);

    // Color Cube Array を初期化
    FillChar(pCubes^, SizeOf(TColorCube)*256, 0);
    for i := 0 to 255 do begin
      pCubes^[i].Index := i; // Color Cube の元の位置が分かるように
                             // Index を付ける。
      pCubes^[i].R := DIBInfos.W3HeadInfo.bmiColors[i].rgbRed;
      pCubes^[i].G := DIBInfos.W3HeadInfo.bmiColors[i].rgbGreen;
      pCubes^[i].B := DIBInfos.W3HeadInfo.bmiColors[i].rgbBlue;
    end;

    // Color Cube Array にピクセル数を色別に積算
    for i := 0 to Height-1 do begin

      // DIB のラインの先頭アドレスを算出
      pSourceByte := AddOffset(DIBInfos.pBits, SourceLineLength * i);

      // ラインに対して
      for j := 0 to Width-1 do begin
        Inc(pCubes^[pSourceByte^].n);
        Inc(pSourceByte);
      end;
    end;

    // カラーテーブルを作る。

    // ピクセルが1個以上入っている Color Cube だけを選ぶ
    NumCubes := 0;

    for i := 0 to 255 do
      if pCubes^[i].n <> 0 then begin
        pCubes^[NumCubes] := pCubes^[i];
        Inc(NumCubes);
      end;


    NumColors := 0; //抽出される色数を初期設定
    // 色を抽出する
    CutCubes(0, NumCubes, 0, 4, pCubes^, Colors, NumColors, ProgressHandler);

    // 色変換テーブルを作る
    FillChar(ColorTransTable, SizeOf(TByteArray256), 0);
    for i := 0 to NumCubes-1 do
      ColorTransTable[pCubes^[i].Index] := pCubes^[i].n;

  finally
    // Color Cube Array を破棄する。
    if pCubes <> Nil then FreeMem(pCubes,  SizeOf(TColorCube)*256);
  end;
end;


// 8BitRGB を 4BitRGB に変換。
procedure Convert8BitRGBTo4BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos;
                                  ProgressHandler: TNotifyEvent;
                                  UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 4Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte: ^Byte;                 // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Colors: TRGBQuadArray;              // 抽出されたカラーテーブル。
  NumColors: LongInt;                 // 抽出された色の数
  ColorTransTable: TByteArray256;     // 色変換テーブル。

begin
  pBits := Nil;

  // 旧DIB が TrueColor かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRGBTo4BitRGB: ' +
          'Invalid Bitcount or Compression');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //スキャンラインの長さを計算
  LineLength := ((Width*4 + 31) div 32) * 4;
  SourceLineLength := ((Width*8 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    // 減色カラー（16色）と色変換テーブルを得る。
    GetReducedColorsFrom256(OldDIBInfos, NumColors, Colors, ColorTransTable,
                            ProgressHandler);

    // さあ、変換開始！！
    for y := 0 to Height -1 do begin
      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を取り出し 変換テーブルを引いて
      // 色のインデックス値を書き込む
      for x := 0 To Width -1 do begin
         // 変換して書き込む
        if ( x mod 2 ) = 0 then
          pByte^ := (ColorTransTable[pSourceByte^] shl 4) and $f0
        else begin
          pByte^ := pByte^ or (ColorTransTable[pSourceByte^] and $0f);
          Inc(pByte);
        end;
        Inc(pSourceByte);
      end;
    end;

    // しあげ
    NewDIBInfos := OldDIBInfos;
    // 減色された新しいカラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := NumColors;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;
end;

// TrueColor を 1Bit RGB に変換。
procedure ConvertTrueColorTo1BitRGB(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos;
                                    BGColor: TColor; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 1Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;     // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  ColorTriple: TNkTriple;             // ピクセル値 True Color -> 1 Bit 変換用
  Bits8: Byte;                        // ビット操作用
  R, G, B: Byte;                      // R, G, B 値
const Colors: array[0..1] of TRGBQuad =
  ((rgbBlue:   0; rgbGreen:   0; rgbRed:   0; rgbReserved: 0),
   (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0));
begin
  pBits := Nil;
  Bits8 := 0; // コンパイラの警告を黙らせるため

  // 旧DIB が TrueColor かチェック
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo1BitRGB: ' +
          'Invalid Bitcount');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  R := GetRValue(BGColor);
  G := GetGValue(BGColor);
  B := GetBValue(BGColor);

  //スキャンラインの長さを計算
  LineLength := ((Width + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    for y := 0 to Height -1 do begin

      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を取り出し 変換テーブルを引いて
      // 色のインデックス値を書き込む
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := $80; pByte^ := 0;
        end;

        // ピクセル値を取り出す
        ColorTriple := pSourceTriple^[x];
        if (ColorTriple.R = R) and (ColorTriple.G = G) and
           (ColorTriple.B = B) then
          pByte^ := pByte^ or Bits8;

        Bits8 := Bits8 shr 1;
        if (x mod 8) = 7 then Inc(pByte);
      end;
    end;


    // しあげ
    NewDIBInfos := OldDIBInfos;
    // カラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := 2;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0], SizeOf(Colors));
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 1;            // 1Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;

end;

// 8Bit RGB を 1Bit RGB に変換。
procedure Convert8BitRGBTo1BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos;
                                  BGColor: TColor; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 1Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte: PByteArray64k;         // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Bits8: Byte;                        // ビット操作用
  R, G, B: Byte;                      // R, G, B 値
  ColorQuad: TRGBQuad;                // ピクセル値  -> 1 Bit 変換用
const Colors: array[0..1] of TRGBQuad =
  ((rgbBlue:   0; rgbGreen:   0; rgbRed:   0; rgbReserved: 0),
   (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0));
begin
  pBits := Nil;
  Bits8 := 0; // コンパイラの警告を黙らせるため

  // 旧DIB が TrueColor かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitTo1BitRGB: ' +
          'Invalid Bitcount or Compression');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  R := GetRValue(BGColor);
  G := GetGValue(BGColor);
  B := GetBValue(BGColor);

  //スキャンラインの長さを計算
  LineLength := ((Width + 31) div 32) * 4;
  SourceLineLength := ((Width*8 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    for y := 0 to Height -1 do begin

      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を取り出し 変換テーブルを引いて
      // 色のインデックス値を書き込む
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := $80; pByte^ := 0;
        end;

        // ピクセル値を取り出す
        ColorQuad := OldDIBInfos.W3HeadInfo.bmiColors[pSourceByte^[x]];
        if (ColorQuad.rgbRed = R) and (ColorQuad.rgbGreen = G) and
           (ColorQuad.rgbBlue = B) then
          pByte^ := pByte^ or Bits8;

        Bits8 := Bits8 shr 1;
        if (x mod 8) = 7 then Inc(pByte);
      end;
    end;


    // しあげ
    NewDIBInfos := OldDIBInfos;
    // カラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := 2;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0], SizeOf(Colors));
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 1;            // 1Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;

end;

// 4Bit RGB を 1Bit RGB に変換。
procedure Convert4BitRGBTo1BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos;
                                  BGColor: TColor; UseFMO: Boolean);
var
  x, y: Integer;                      // 座標
  LineLength,                         // 1Bit RGB のスキャンラインの長さ
  BitsSize,                           // 変換後のビットマップデータのサイズ
  Width, Height: Integer;             // ビットマップの大きさ
  SourceLineLength: Integer;          // 変換元のスキャンラインの長さ
  hFile: THandle;                     // 変換後のビットマップデータバッファ
  pBits: Pointer;
  pSourceByte: PByteArray64k;         // 変換元データへのポインタ
  pByte: ^Byte;                       // 変換先データへのポインタ
  Bits8: Byte;                        // ビット操作用
  R, G, B: Byte;                      // R, G, B 値
  ColorQuad: TRGBQuad;                // ピクセル値  -> 1 Bit 変換用
  ColorIndex: Byte;                   // 色のインデックス

const Colors: array[0..1] of TRGBQuad =
  ((rgbBlue:   0; rgbGreen:   0; rgbRed:   0; rgbReserved: 0),
   (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0));
begin
  pBits := Nil;
  Bits8 := 0; // コンパイラの警告を黙らせるため

  // 旧DIB が TrueColor かチェック
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBTo1BitRGB: ' +
          'Invalid Bitcount');

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  R := GetRValue(BGColor);
  G := GetGValue(BGColor);
  B := GetBValue(BGColor);

  //スキャンラインの長さを計算
  LineLength := ((Width + 31) div 32) * 4;
  SourceLineLength := ((Width*4 + 31) div 32) * 4;

  // Pixel データの大きさを計算。
  BitsSize   :=  LineLength * Height;

  // ピクセル情報用メモリ（出力先）を確保
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    for y := 0 to Height -1 do begin

      // 新／旧 DIB のラインの先頭へのポインタを作成
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // 旧のピクセル値を取り出し 変換テーブルを引いて
      // 色のインデックス値を書き込む
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := $80; pByte^ := 0;
        end;

        // ピクセル値を取り出す
        if (x mod 2) = 0 then
          ColorIndex := (pSourceByte^[x div 2] shr 4) and $0f
        else
          ColorIndex := pSourceByte^[x div 2] and $0f;

        ColorQuad := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex];
        if (ColorQuad.rgbRed = R) and (ColorQuad.rgbGreen = G) and
           (ColorQuad.rgbBlue = B) then
          pByte^ := pByte^ or Bits8;

        Bits8 := Bits8 shr 1;
        if (x mod 8) = 7 then Inc(pByte);
      end;
    end;


    // しあげ
    NewDIBInfos := OldDIBInfos;
    // カラーテーブルをセットする
    NewDIBInfos.W3Head.biClrUsed := 2;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0], SizeOf(Colors));
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 1;            // 1Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新 DIB を捨てる。
    raise;
  end;

end;

// DIB をハーフトーン化
procedure ConvertToHalfTone(var OldDIBInfos: TNkDIBInfos;
                            var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
type
  TErrorElement = record
    RError, GError, BError: SmallInt;
  end;
  TErrorArray = array[-1..10000] of TErrorElement;
  PErrorArray = ^TErrorArray;


var Width, Height: Integer;
    x, y, i: Integer;

    pErrors: PErrorArray;            // 処理中のスキャンラインの色の誤差
    pPrevLineErrors: PErrorArray;    // 一つ前のスキャンラインの色の誤差
    BitsSize: Integer;               // 変換先ピクセルデータの大きさ
    LineLength: Integer;             // 変換先スキャンラインの長さ
    SourceLineLength: Integer;       // 変換元スキャンラインの長さ
    hFile: THandle;                  // 変換先のビットマップデータバッファ
    pBits: Pointer;
    RIndex, GIndex, BIndex: Integer; // 減色後の各色のインデックス値
                                     // RedColors, GreenColors, BlueColors
                                     // 配列のインデックス値をを表わす
    RValue, GValue, BValue: Integer; // ピクセルの RGB 値
    RErr, GErr, BErr: Integer;       // 色誤差
    OldRErr, OldGErr, OldBErr: Integer; // 一つ前の色誤差
    ColorIndex: LongInt;             // カラーインデックス(1, 4, 8 bpp DIB 用)
    pLine: PNkTripleArray;           // ピクセルポインタ (24 bpp 用)
    pByte: ^Byte;                    // ピクセルポインタ(1,4,8 bpp 用)
    pDest: ^Byte;                    // ピクセルポインタ(変換先)
    Mask: Byte;                      // ビットマスク(1 bpp 用)

    // 減色テーブル  RGB 値を RedColors, GreenColors, BlueColors に変換する。
    RTrans, GTrans, BTrans: array[-256..512] of Byte;
const Bits8: BYTE = $80;             // Mask の初期値
begin
  Assert(OldDIBInfos.W3Head.biCompression = BI_RGB,
           'ConvertToHalfTone: Invalid DIB Format');


  // 減色テーブルを初期化する。
  // 赤
  FillChar(RTrans[-256], 256 + 26, 0);
  FillChar(RTrans[26], 51, 1);
  FillChar(RTrans[77], 51, 2);
  FillChar(RTrans[128], 51, 3);
  FillChar(RTrans[179], 52, 4);
  FillChar(RTrans[231], 25 + 257, 5);

  // 緑
  FillChar(GTrans[-256], 256 + 22, 0);
  FillChar(GTrans[22], 42, 1);
  FillChar(GTrans[64], 43, 2);
  FillChar(GTrans[107], 43, 3);
  FillChar(GTrans[150], 43, 4);
  FillChar(GTrans[193], 41, 5);
  FillChar(GTrans[234], 22 + 257, 6);

  // 青
  FillChar(BTrans[-256], 256 + 32, 0);
  FillChar(BTrans[32], 64, 1);
  FillChar(BTrans[96], 64, 2);
  FillChar(BTrans[160], 64, 3);
  FillChar(BTrans[224], 32 + 257, 4);

  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  pErrors := Nil;
  pPrevLineErrors := Nil;
  pBits := Nil;

  RValue := 0; GValue := 0; BValue := 0; // コンパイラを黙らせるため

  try
    // 誤差拡散用の誤差格納用バッファを初期化
    GetMem(pErrors, SizeOf(TErrorElement) * (Width+2));
    GetMem(pPrevLineErrors, SizeOf(TErrorElement) * (Width+2));
    FillChar(pErrors^, SizeOf(TErrorElement) * (Width+2), 0);

    // 変換元、変換先のスキャンラインの長さを計算
    LineLength := ((Width * 8 + 31) div 32) * 4;

    SourceLinelength := ((Width * OldDIBInfos.W3head.biBitCount + 31)
                         div 32) * 4;

    // 変換先(8 bpp DIB) のピクセルデータ格納領域を確保
    BitsSize := Linelength * Height;
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      // 変換開始
      for y := 0 to Height-1 do begin    // 各スキャンライン毎に
        // 現スキャンラインの色誤差バッファを前スキャンラインの
        // 色誤差バッファへコピー
        Move(pErrors^, pPrevLineErrors^, SizeOf(TErrorElement)*(Width+2));


        /////////////////////
        // Note:
        //
        // 誤差拡散はスキャンライン毎に誤差の伝播方向逆転させる
        // こうすると画質があがるようだ(^^

        // ピクセルのスキャン開始位置をセット
        // 偶数行 -> 左から、奇数行 ->右から

        if (y mod 2) = 0 then begin
          x := 0; pDest := AddOffset(pBits, LineLength * y);
        end
        else begin
          x := Width-1; pDest := AddOffset(pBits, LineLength * y + Width -1);
        end;

        // 1ピクセル前の色誤差をクリア
        OldRErr := 0; OldGErr := 0; OldBErr := 0;

        // ピクセルの RGB 値を取り出す
        while (x >= 0) and (x <= Width-1) do begin
          with OldDIBInfos do begin
            if W3Head.biBitCount = 24 then begin
              // True Color
              pLine := AddOffset(pBits, SourceLineLength * y);
              RValue := pLine^[x].R;
              GValue := pLine^[x].G;
              BValue := pLine^[x].B;
            end
            else if W3Head.biBitCount = 8 then begin
              // 8Bit 非圧縮
              pByte := AddOffset(pBits, SourceLineLength * y + x);
              ColorIndex := pByte^;  // カラーテーブルのインデックスを返す
            end
            else if W3Head.biBitCount = 4 then begin
              pByte := AddOffset(pBits, SourceLineLength * y + x div 2);
              // インデックス値を読む
              if ( x mod 2) = 0 then ColorIndex := (pByte^ shr 4) and $0f
              else                   ColorIndex := pByte^ and $0f;
            end
            else if W3Head.biBitCount = 1 then begin
              pByte := AddOffset(pBits, SourceLineLength * y + x div 8);

              Mask := Bits8 shr (x mod 8);
              if (pByte^ and Mask) <> 0 then ColorIndex := 1
              else                           ColorIndex := 0;
            end
            else
              Assert(False, 'ConvertToHalfTone: Invalid Bit Count');
           if W3Head.biBitCount <> 24 then
             with W3HeadInfo.bmiColors[ColorIndex] do begin
               RValue := rgbRed; GValue := rgbGreen; BValue := rgbBlue;
             end;
         end;

         ////////////////////
         // Note:
         //
         // 色誤差は以下の様に計算している(左からスキャンする場合)
         //
         //
         //  +--------+--------+
         //  |  (1)   |  (2)   |
         //  | 誤差x5 | 誤差x12|
         //  |--------| -------|    <-- 前のスキャンライン
         //  |   32   |    32  |
         //  +--------+--------+
         //  |  (3)   |        |
         //  | 誤差x12|   現   |
         //  |--------|ピクセル|    <-- 現在のスキャンライン
         //  |   32   |        |
         //  +--------+--------+
         //
         //  現ピクセルの色の補正値 = -(1) - (2) - (3)


         // 現ピクセルの「上」のピクセルの色誤差を誤差に加える
         with pPrevLineErrors^[x] do begin
           RErr := RError*12;
           GErr := GError*12;
           BErr := BError*12;
         end;

         // 現ピクセルの「一つ前」のピクセルの色誤差を加える
         Inc(RErr, OldRErr*12);
         Inc(GErr, OldGErr*12);
         Inc(BErr, OldBErr*12);

         // 現ピクセルの「一つ前」のピクセルの「上」のピクセルの色誤差を加える。
         if (y and 1) = 0 then begin
           with pPrevLineErrors^[x-1] do begin
             Inc(RErr, RError*5);
             Inc(GErr, GError*5);
             Inc(BErr, BError*5);
           end;
         end
         else begin
           with pPrevLineErrors^[x+1] do begin
             Inc(RErr, RError*5);
             Inc(GErr, GError*5);
             Inc(BErr, BError*5);
           end;
         end;

         RErr := RErr div 32; GErr := GErr div 32; BErr := BErr div 32;

         // 誤差を打ち消す方向に現ピクセルの RGB 値を補正する
         Dec(RValue, RErr); Dec(GValue, GErr); Dec(BValue, BErr);


         // 210 色に減色する。
         RIndex := RTrans[RValue];
         GIndex := GTrans[GValue];
         BIndex := BTrans[BValue];

         with pErrors^[x] do begin
           RError := RedColors  [RIndex] - RValue;
           GError := GreenColors[GIndex] - GValue;
           BError := BlueColors [BIndex] - BValue;
           // 現ピクセルの色誤差を算出する。
           OldRErr := RError; OldGErr := GError; OldBErr := BError;
         end;

         // 減色後の色（インデックス）を変換先に書き込む
         pDest^ := RIndex * 7 * 5 + GIndex * 5 + BIndex;

         // 現ピクセルを1個先に進める
         if (y and 1) = 0 then begin Inc(x); Inc(pDest); end
         else                  begin Dec(x); Dec(pDest); end;
        end;
      end;

      // 仕上げ
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biClrUsed := 215;
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit RGB
      NewDIBInfos.W3Head.biCompression := BI_RGB;
      NewDIBInfos.W3Head.biSizeImage := 0;

      // カラーテーブルに 固定 215 色を書き込む
      for RIndex := 0 to 5 do
        for GIndex := 0 to 6 do
          for BIndex := 0 to 4 do
            with NewDIBInfos.W3HeadInfo.bmiColors[RIndex * 7*5 +
                                                  GIndex * 5 +
                                                  BIndex] do begin
              rgbRed := RedColors[RIndex];
              rgbGreen := GreenColors[GIndex];
              rgbBlue := BlueColors[BIndex];
              rgbReserved := 0;
            end;
      with NewDIBInfos.W3HeadInfo do
        for i := 0 to 4 do begin
          bmiColors[210+i].rgbRed       := GetRValue(SomeRevervedColors[i]);
          bmiColors[210+i].rgbGreen     := GetGValue(SomeRevervedColors[i]);
          bmiColors[210+i].rgbBlue      := GetBValue(SomeRevervedColors[i]);
          bmiColors[210+i].rgbReserved  := 0;
        end;
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新DIBを捨てる。
      raise;
    end;

  finally
    // 誤差保時用バッファの解放
    if pErrors <> Nil then FreeMem(pErrors);

    if pPrevLineErrors <> Nil then FreeMem(pPrevLineErrors);
  end;
end;

// DIB を2値にハーフトーン化
procedure ConvertToHalfToneBW(var OldDIBInfos: TNkDIBInfos;
                              var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
type
  TErrorElement = record
    RError, GError, BError: SmallInt;
  end;
  TErrorArray = array[-1..10000] of TErrorElement;
  PErrorArray = ^TErrorArray;

var Width, Height: Integer;
    x, y, i: Integer;

    pErrors: PErrorArray;            // 処理中のスキャンラインの色の誤差
    pPrevLineErrors: PErrorArray;    // 一つ前のスキャンラインの色の誤差
    BitsSize: Integer;               // 変換先ピクセルデータの大きさ
    LineLength: Integer;             // 変換先スキャンラインの長さ
    SourceLineLength: Integer;       // 変換元スキャンラインの長さ
    hFile: THandle;                  // 変換先のビットマップデータバッファ
    pBits: Pointer;
                                     // 配列のインデックス値をを表わす
    RValue, GValue, BValue: Integer; // ピクセルの RGB 値
    RErr, GErr, BErr: Integer;       // 色誤差
    OldRErr, OldGErr, OldBErr: Integer; // 一つ前の色誤差
    ColorIndex: LongInt;             // カラーインデックス(1, 4, 8 bpp DIB 用)
    pLine: PNkTripleArray;           // ピクセルポインタ (24 bpp 用)
    pByte: ^Byte;                    // ピクセルポインタ(1,4,8 bpp 用)
    pDest: ^Byte;                    // ピクセルポインタ(変換先)
    Mask: Byte;                      // ビットマスク(1 bpp 用)
    BWValue: Integer;                // 白黒値

const Bits8: BYTE = $80;             // Mask の初期値

begin
  Assert(OldDIBInfos.W3Head.biCompression = BI_RGB,
           'ConvertToHalfToneBW: Invalid DIB Format');


  // 高速化のため Width と Height を変数に入れる。
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  pErrors := Nil;
  pPrevLineErrors := Nil;
  pBits := Nil;
  RValue := 0; GValue := 0; BValue := 0; // コンパイラを黙らせるため

  try
    // 誤差拡散用の誤差格納用バッファを初期化
    GetMem(pErrors, SizeOf(TErrorElement) * (Width+2));
    GetMem(pPrevLineErrors, SizeOf(TErrorElement) * (Width+2));
    FillChar(pErrors^, SizeOf(TErrorElement) * (Width+2), 0);

    // 変換元、変換先のスキャンラインの長さを計算
    LineLength := ((Width * 1 + 31) div 32) * 4;

    SourceLinelength := ((Width * OldDIBInfos.W3head.biBitCount + 31)
                         div 32) * 4;

    // 変換先(1 bpp DIB) のピクセルデータ格納領域を確保
    BitsSize := Linelength * Height;
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      // 変換開始
      for y := 0 to Height-1 do begin    // 各スキャンライン毎に
        // 現スキャンラインの色誤差バッファを前スキャンラインの
        // 色誤差バッファへコピー
        Move(pErrors^, pPrevLineErrors^, SizeOf(TErrorElement)*(Width+2));


        /////////////////////
        // Note:
        //
        // 誤差拡散はスキャンライン毎に誤差の伝播方向逆転させる
        // こうすると画質があがるようだ(^^

        // ピクセルのスキャン開始位置をセット
        // 偶数行 -> 左から、奇数行 ->右から

        if (y mod 2) = 0 then begin
          x := 0; pDest := AddOffset(pBits, LineLength * y);
        end
        else begin
          x := Width-1;
          pDest := AddOffset(pBits, LineLength * y + (Width -1) div 8);
        end;

        // 1ピクセル前の色誤差をクリア
        OldRErr := 0; OldGErr := 0; OldBErr := 0;

        // ピクセルの RGB 値を取り出す
        while (x >= 0) and (x <= Width-1) do begin
          with OldDIBInfos do begin
            if W3Head.biBitCount = 24 then begin
              // True Color
              pLine := AddOffset(pBits, SourceLineLength * y);
              RValue := pLine^[x].R;
              GValue := pLine^[x].G;
              BValue := pLine^[x].B;
            end
            else if W3Head.biBitCount = 8 then begin
              // 8Bit 非圧縮
              pByte := AddOffset(pBits, SourceLineLength * y + x);
              ColorIndex := pByte^;  // カラーテーブルのインデックスを返す
            end
            else if W3Head.biBitCount = 4 then begin
              pByte := AddOffset(pBits, SourceLineLength * y + x div 2);
              // インデックス値を読む
              if ( x mod 2) = 0 then ColorIndex := (pByte^ shr 4) and $0f
              else                   ColorIndex := pByte^ and $0f;
            end
            else if W3Head.biBitCount = 1 then begin
              pByte := AddOffset(pBits, SourceLineLength * y + x div 8);

              Mask := Bits8 shr (x mod 8);
              if (pByte^ and Mask) <> 0 then ColorIndex := 1
              else                           ColorIndex := 0;
            end
            else
              Assert(False, 'ConvertToHalfToneBW: Invalid Bit Count');
           if W3Head.biBitCount <> 24 then
             with W3HeadInfo.bmiColors[ColorIndex] do begin
               RValue := rgbRed; GValue := rgbGreen; BValue := rgbBlue;
             end;
         end;

         ////////////////////
         // Note:
         //
         // 色誤差は以下の様に計算している(左からスキャンする場合)
         //
         //
         //  +--------+--------+
         //  |  (1)   |  (2)   |
         //  | 誤差x5 | 誤差x12|
         //  |--------| -------|    <-- 前のスキャンライン
         //  |   32   |    32  |
         //  +--------+--------+
         //  |  (3)   |        |
         //  | 誤差x12|   現   |
         //  |--------|ピクセル|    <-- 現在のスキャンライン
         //  |   32   |        |
         //  +--------+--------+
         //
         //  現ピクセルの色の補正値 = -(1) - (2) - (3)


         // 現ピクセルの「上」のピクセルの色誤差を誤差に加える
         with pPrevLineErrors^[x] do begin
           RErr := RError*12;
           GErr := GError*12;
           BErr := BError*12;
         end;

         // 現ピクセルの「一つ前」のピクセルの色誤差を加える
         Inc(RErr, OldRErr*12);
         Inc(GErr, OldGErr*12);
         Inc(BErr, OldBErr*12);

         // 現ピクセルの「一つ前」のピクセルの「上」のピクセルの色誤差を加える。
         if (y and 1) = 0 then begin
           with pPrevLineErrors^[x-1] do begin
             Inc(RErr, RError*5);
             Inc(GErr, GError*5);
             Inc(BErr, BError*5);
           end;
         end
         else begin
           with pPrevLineErrors^[x+1] do begin
             Inc(RErr, RError*5);
             Inc(GErr, GError*5);
             Inc(BErr, BError*5);
           end;
         end;

         RErr := RErr div 32; GErr := GErr div 32; BErr := BErr div 32;

         // 誤差を打ち消す方向に現ピクセルの RGB 値を補正する
         Dec(RValue, RErr); Dec(GValue, GErr); Dec(BValue, BErr);


         // 2 色に減色する。
         if RValue + GValue + BValue >= 384 then BWValue := 1
                                            else BWValue := 0;
         with pErrors^[x] do begin
           // 現ピクセルの色誤差を算出する。
           if BWValue = 1 then begin
             RError := 255 - RValue;
             GError := 255 - GValue;
             BError := 255 - BValue;
           end
           else begin
             RError := - RValue;
             GError := - GValue;
             BError := - BValue;
           end;
           OldRErr := RError; OldGErr := GError; OldBErr := BError;
         end;

         // 減色後の色（インデックス）を変換先に書き込む
         Mask := Bits8 shr (x mod 8);
         if BWValue = 1 then
           pDest^ := pDest^ or Mask
         else
           pDest^ := pdest^ and not Mask;

         // 現ピクセルを1個先に進める
         if (y and 1) = 0 then begin
           if (x mod 8) = 7 then Inc(pDest);
           Inc(x);
         end
         else begin
           if (x mod 8) = 0 then Dec(pDest);
           Dec(x);
         end;
        end;
      end;

      // 仕上げ
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biClrUsed := 2;
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 1;            // 8Bit RGB
      NewDIBInfos.W3Head.biCompression := BI_RGB;
      NewDIBInfos.W3Head.biSizeImage := 0;

      // カラーテーブルに 固定 2 色を書き込む
      for i := 0 to 1 do
        NewDIBInfos.W3HeadInfo.bmiColors[i] := BWColors[i];
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// 失敗 新DIBを捨てる。
      raise;
    end;

  finally
    // 誤差保時用バッファの解放
    if pErrors <> Nil then FreeMem(pErrors);
    if pPrevLineErrors <> Nil then FreeMem(pPrevLineErrors);
  end;
end;






// True Color 用 Palette 作成
procedure TNkInternalDIB.CreateTrueColorPalette(ConvertMode: TNkConvertMode;
                                                ProgressHandler: TNotifyEvent);
var
  NumColors: LongInt;                // 選ばれた色の数
  Colors: TRGBQuadArray;             // 選ばれた色 最大256色
  History: TCutHistory;              // 色分割履歴
  pColorTransTable: ^TByteArray64k3D; // ダミー

begin
  // True Color のみが対象
  if DIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
      'TNkInternalDIB.CreateTrueColorPalette: Bad DIB Type');

  // 減色カラーテーブルを得る。
  case ConvertMode of
    nkCmFine: GetReducedColorsHigh(DIBInfos, NumColors, Colors, History, 8,
                                   ProgressHandler);
    nkCmNormal: begin
      GetMem(pColorTransTable,  SizeOf(TByteArray64k3D)); //ダミー
      try
        GetReducedColorsLow(DIBInfos, NumColors, Colors,
                            pColorTransTable^, 8, ProgressHandler);
      finally
        FreeMem(pColorTransTable,  SizeOf(TByteArray64k3D)); //ダミー
      end;
    end;
  end;

  DIBInfos.W3Head.biClrUsed := NumColors;
  System.Move(Colors, DIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
  // 旧パレットを廃棄
  UpdatePalette;
end;

// PixelFormat を取得する。

function TNkInternalDIB.GetPixelFormat: TNkPixelFormat;
begin
  with DIBInfos.W3Head do begin
    case biBitCount of
      1: case biCompression of
           BI_RGB: Result := nkPf1Bit;
           else raise ENkDIBInvalidDIB.Create(
             'TNkInternalDIB.GetPixelFormat: Invalid DIB(1Bit)');
         end;
      4: case biCompression of
           BI_RGB:  Result := nkPf4Bit;
           BI_RLE4: Result := nkPf4BitRLE;
           else raise ENkDIBInvalidDIB.Create(
             'TNkInternalDIB.GetPixelFormat: Invalid DIB(4Bit)');
         end;
      8: case biCompression of
           BI_RGB:  Result := nkPf8Bit;
           BI_RLE8: Result := nkPf8BitRLE;
           else raise ENkDIBInvalidDIB.Create(
             'TNkInternalDIB.GetPixelFormat: Invalid DIB(8Bit)');
         end;
     24: case biCompression of
           BI_RGB: Result := nkPf24Bit;
           else raise ENkDIBInvalidDIB.Create(
             'TNkInternalDIB.GetPixelFormat: Invalid DIB(24Bit)');
         end;
      else raise ENkDIBInvalidDIB.Create(
             'TNkInternalDIB.GetPixelFormat: Invalid DIB(Illegal BitCount)');
    end;
  end;
end;




// Pixel Format の変更(DIB の形式変換)
// このルーチンは大きいがやっていることはほとんど自明
// 例外がおきたときに後戻りするようになっていることに注意
procedure TNkInternalDIB.SetPixelFormat(Value: TNkPixelFormat;
                                        ConvertMode: TNkConvertMode;
                                        BGColor: TColor;
                                        ProgressHandler: TNotifyEvent);
var NewDIBInfos, NewDIBInfos2, NewDIBInfos3: TNkDIBInfos;
  procedure ConvErr;
  begin Assert(False, 'TNkIntenalDIB.SetPixelsFormat: PixelFormat Error');
  end;
begin
  if Value = nkPfHalfTone then begin
    case GetPixelFormat of
      nkPf4BitRLE: begin
        Convert4BitRLETo4bitRGB(DIBInfos, NewDIBInfos, UseFMO);
        try
          ConvertToHalfTone(NewDIBInfos, NewDIBInfos2, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, useFMO);
          DIBInfos := NewDIBInfos2;
        finally
          ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
        end;
      end;
      nkPf8BitRLE: begin
        Convert8BitRLETo8bitRGB(DIBInfos, NewDIBInfos, UseFMO);
        try
          ConvertToHalfTone(NewDIBInfos, NewDIBInfos2, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos2;
        finally
          ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
        end;
      end;
      else begin
        ConvertToHalftone(DIBInfos, NewDIBInfos, UseFMO);
        ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
        DIBInfos := NewDIBInfos;
        UpdatePalette;
      end;
    end;
    Exit;
  end;

  if Value = nkPfHalfToneBW then begin
    case GetPixelFormat of
      nkPf4BitRLE: begin
        Convert4BitRLETo4bitRGB(DIBInfos, NewDIBInfos, UseFMO);
        try
          ConvertToHalfToneBW(NewDIBInfos, NewDIBInfos2, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos2;
        finally
          ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, USeFMO);
        end;
      end;
      nkPf8BitRLE: begin
        Convert8BitRLETo8bitRGB(DIBInfos, NewDIBInfos, UseFMO);
        try
          ConvertToHalfToneBW(NewDIBInfos, NewDIBInfos2, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos2;
        finally
          ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
        end;
      end;
      else begin
        ConvertToHalftoneBW(DIBInfos, NewDIBInfos, UseFMO);
        ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
        DIBInfos := NewDIBInfos;
        UpdatePalette;
      end;
    end;
    Exit;
  end;

  case GetPixelFormat of
    nkPf1Bit:
      case Value of
        nkPf1Bit: ConvErr;
        nkPf4Bit: begin
          Convert1BitRGBTo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4BitRLE: begin;
          Convert1BitRGBTo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert4BitRGBTo4BitRLE(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf8Bit: begin
          Convert1BitRGBTo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf8BitRLE: begin
          Convert1BitRGBTo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert8BitRGBTo8BitRLE(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf24Bit: begin
          Convert1BitRGBToTrueColor(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        else ConvErr;
      end;
    nkPf4BitRLE:
      case Value of
        nkPf1Bit: begin
          Convert4BitRLETo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert4BitRGBTo1BitRGB(NewDIBInfos, NewDIBInfos2, BGColor, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf4Bit: begin
          Convert4BitRLETo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4BitRLE: ConvErr;
        nkPf8Bit: begin
          Convert4BitRLETo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert4BitRGBTo8BitRGB(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf8BitRLE: begin
          Convert4BitRLETo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert4BitRGBTo8BitRGB(NewDIBInfos, NewDIBInfos2, UseFMO);
            try
              Convert8BitRGBTo8BitRLE(NewDIBInfos2, NewDIBInfos3, UseFMO);
              ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
              DIBInfos := NewDIBInfos3;
              UpdatePalette;
            finally
              ReleaseMemory(NewDIBInfos2.hFile, NewDIBInfos2.pBits, UseFMO);
            end;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf24Bit: begin;
          Convert4BitRLETo4BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert4BitRGBToTrueColor(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        else       ConvErr;
      end;
    nkPf4Bit:
      case Value of
        nkPf1Bit: begin
          Convert4BitRGBTo1BitRGB(DIBInfos, NewDIBInfos, BGColor, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4Bit: ConvErr;
        nkPf4BitRLE: begin
          Convert4BitRGBTo4BitRLE(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf8Bit: begin
          Convert4BitRGBTo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf8BitRLE: begin
          Convert4BitRGBTo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert8BitRGBTo8BitRLE(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf24Bit: begin
          Convert4BitRGBToTrueColor(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        else       ConvErr;
      end;
    nkPf8BitRLE:
      case Value of
        nkPf1Bit: begin
          Convert8BitRLETo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert8BitRGBTo1BitRGB(NewDIBInfos, NewDIBInfos2, BGColor, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf4Bit: begin
          Convert8BitRLETo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert8BitRGBTo4BitRGB(NewDIBInfos, NewDIBInfos2,
                                    ProgressHandler, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf4BitRLE: begin
          Convert8BitRLETo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert8BitRGBTo4BitRGB(NewDIBInfos, NewDIBInfos2,
                                    ProgressHandler, UseFMO);
            try
              Convert4BitRGBTo4BitRLE(NewDIBInfos2, NewDIBInfos3, UseFMO);
              ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
              DIBInfos := NewDIBInfos3;
              UpdatePalette;
            finally
              ReleaseMemory(NewDIBInfos2.hFile, NewDIBInfos2.pBits, UseFMO);
            end;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf8Bit: begin
          Convert8BitRLETo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf8BitRLE: ConvErr;
        nkPf24Bit: begin
          Convert8BitRLETo8BitRGB(DIBInfos, NewDIBInfos, UseFMO);
          try
            Convert8BitRGBToTrueColor(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        else       ConvErr;
      end;
    nkPf8Bit:
      case Value of
        nkPf1Bit: begin
          Convert8BitRGBTo1BitRGB(DIBInfos, NewDIBInfos, BGColor, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4Bit: begin
          Convert8BitRGBTo4BitRGB(DIBInfos, NewDIBInfos, ProgressHandler, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4BitRLE: begin
          Convert8BitRGBTo4BitRGB(DIBInfos, NewDIBInfos, ProgressHandler, UseFMO);
          try
            Convert4BitRGBTo4BitRLE(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf8Bit: ConvErr;
        nkPf8BitRLE: begin
          Convert8BitRGBTo8BitRLE(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf24Bit: begin
          Convert8BitRGBToTrueColor(DIBInfos, NewDIBInfos, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        else       ConvErr;
      end;
    nkPf24Bit:
      case Value of
        nkPf1Bit: begin
          ConvertTrueColorTo1BitRGB(DIBInfos, NewDIBInfos, BGColor, UseFMO);
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4Bit: begin
          case ConvertMode of
            nkCmNormal: ConvertTrueColorTo4BitRGBLow(DIBInfos, NewDIBInfos,
                                                     ProgressHandler, UseFMO);
            nkCmFine:   ConvertTrueColorTo4BitRGBHigh(DIBInfos, NewDIBInfos,
                                                      ProgressHandler, UseFMO);
            else ConvErr;
          end;
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf4BitRLE: begin
          case ConvertMode of
            nkCmNormal: ConvertTrueColorTo4BitRGBLow(DIBInfos, NewDIBInfos,
                                                     ProgressHandler, UseFMO);
            nkCmFine:   ConvertTrueColorTo4BitRGBHigh(DIBInfos, NewDIBInfos,
                                                      ProgressHandler, UseFMO);
            else ConvErr;
          end;
          try
            Convert4BitRGBTo4BitRLE(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf8Bit: begin
          case ConvertMode of
            nkCmNormal: ConvertTrueColorTo8BitRGBLow(DIBInfos, NewDIBInfos,
                                                     ProgressHandler, UseFMO);
            nkCmFine:   ConvertTrueColorTo8BitRGBHigh(DIBInfos, NewDIBInfos,
                                                      ProgressHandler, UseFMO);
            else ConvErr;
          end;
          ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
          DIBInfos := NewDIBInfos;
          UpdatePalette;
        end;
        nkPf8BitRLE: begin
          case ConvertMode of
            nkCmNormal: ConvertTrueColorTo8BitRGBLow(DIBInfos, NewDIBInfos,
                                                     ProgressHandler, UseFMO);
            nkCmFine:   ConvertTrueColorTo8BitRGBHigh(DIBInfos, NewDIBInfos,
                                                      ProgressHandler, UseFMO);
            else ConvErr;
          end;
          try
            Convert8BitRGBTo8BitRLE(NewDIBInfos, NewDIBInfos2, UseFMO);
            ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
            DIBInfos := NewDIBInfos2;
            UpdatePalette;
          finally
            ReleaseMemory(NewDIBInfos.hFile, NewDIBInfos.pBits, UseFMO);
          end;
        end;
        nkPf24Bit: ConvErr;
        else       ConvErr;
      end;
    else ConvErr;
  end;
end;


// コンストラクタ
constructor TNkDIB.Create;
begin
  inherited Create;
  // Internal DIB を作る
  InternalDIB := TNkInternalDIB.Create(DefaultUseFMO);
  UpdatePaletteModified;
  FConvertMode := nkCmNormal;      // デフォルトの変換モードはノーマル
  FBGColor := clWhite;             // デフォルトの背景色は白
  FHalftoneMode := nkHtNoHalftone; // ハーフトーン無し。
end;

destructor TNkDIB.Destroy;
begin
  // Internal DIB との結びつきを切断
  ReleaseInternalDIB;
  inherited Destroy;
end;

// DIB との結びつきを切断
procedure TNkDIB.ReleaseInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNKDIB.ReleaseInternalDIB: InternalDIB should not be Nil');

  // 参照カウントデクリメント
  Dec(InternalDIB.RefCount);
  // 参照カウントが ０ なら Internal DIB を削除
  if InternalDIB.RefCount = 0 then InternalDIB.Free;

  InternalDIB := Nil;
end;


// ストリームから DIB(ファイルヘッダ付き) を読み込む
procedure TNkDIB.LoadFromStream(Stream: TStream);
var temp: TNkInternalDIB;
begin
  // Internal DIB を切り離し、新しい Internal DIB を確保
  temp := TNkInternalDIB.Create(UseFMO);
  try
    temp.LoadFromStream(Stream);
  except
    temp.Free;
    raise;
  end;
  // 古い Internal DIB を切り離す
  ReleaseInternalDIB;

  // 新しい Internal DIB をセットする。
  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;

// ストリームへ DIB(ファイルヘッダ付き) を書き出す
procedure TNkDIB.SaveToStream(Stream: TStream);
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SaveToStream: InternalDIB Should not be Nil');

  InternalDIB.SaveToStream(Stream);
end;

procedure TNkDIB.Draw(ACanvas: TCanvas; const R: TRect);
var SavedPalette: HPALETTE;      // 旧パレット
    OldMode: Integer;            // 旧ストレッチモード
    PaletteSelected: Boolean;    // パレットが選択されているかを表す
    HalftoneDIB: TNkDIB;         // ハーフトーン化用 DIB
    HalftoneCanvas: TNkDIBCanvas;// ハーフトーン化用キャンバス
    HalftoneModeSave: TNkHalftoneMode;
begin
  SavedPalette := 0; // コンパイラを黙らせるため
  
  if InternalDIB <> Nil then begin
    case FHalftoneMode of
      nkHtNoHalftone: begin
        // DIB のパレットを BG 実体化
        PaletteSelected := False;
        if Palette <> 0 then begin
          SavedPalette := SelectPalette(ACanvas.Handle, Palette, True);
          RealizePalette(ACanvas.Handle);
          PaletteSelected := True;
        end;
        // ストレッチモードはカラー オン カラー
        OldMode := SetStretchBltMode(ACanvas.Handle, COLORONCOLOR);
        // 描く
        StretchDIBits(ACanvas.Handle, R.Left, R.Top,
                      R.Right - R.Left, R.Bottom - R.Top,
                      0, 0, InternalDIB.Width, InternalDIB.Height,
                      InternalDIB.DIBInfos.pBits,
                      InternalDIB.DIBInfos.W3HeadInfo,
                      DIB_RGB_COLORS, ACanvas.CopyMode);
        // ストレッチモードを元に戻す
        SetStretchBltMode(ACanvas.Handle, OldMode);
        // パレットを元に戻す
        if PaletteSelected then
          SelectPalette(ACanvas.Handle, SavedPalette, True);
      end;
      nkHtHalftone, nkHtHalftoneBW: begin
        // 表示領域に面積が無い場合は何も描かない
        if (R.Right = R.Left) or (R.Top = R.Bottom) then Exit;
        HalftoneDIB := TNkDIB.Create;
        try
          // DIB をコピーするため 一時的にハーフトーンモードを解除
          HalfToneModeSave := FHalfToneMode;
          FHalfToneMode := nkHtNoHalfTone;
          try
            // DIB を表示領域の大きさにあわせて拡大縮小してコピー
            HalftoneDIB.Width := abs(R.Right - R.Left);
            HalftoneDIB.Height := abs(R.Bottom - R.Top);
            HalftoneDIB.BitCount := BitCount;
            HalftoneDIB.Palette := CopyPalette(Palette);
            HalftoneCanvas := TNkDIBCanvas.Create(HalftoneDIB);
            try
              HalftoneCanvas.StretchDraw(
                Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), Self);
            finally
              HalftoneCanvas.Free;
            end;
          finally
            FHalfToneMode := HalfToneModeSave;
          end;

          // コピーした DIB をハーフトーン化する
          case FHalftoneMode of
            nkHtHalftone:   HalftoneDIB.PixelFormat := nkPfHalftone;
            nkHtHalftoneBW: HalftoneDIB.PixelFormat := nkPfHalftoneBW;
          end;

          // 表示する
          HalftoneDIB.Draw(ACanvas, R);
        finally
          HalftoneDIB.Free;
        end;
      end;
    end;
  end;
end;

// Assign の実装
procedure TNkDIB.Assign(Source: TPersistent);
var temp: TNkInternalDIB;
    bm: Windows.TBitmap;
    BitCount: Integer;
    OldPal: HPalette;
    h: HDC;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.Assign: InternalDIB Should not be Nil');

  if (Source = nil) then begin
    // Internal DIB を離し、デフォルトの DIB を作る。
    temp := TNkInternalDIB.Create(UseFMO);
    ReleaseInternalDIB;
    InternalDIB := temp;
    UpdatePaletteModified;
    Modified := True;
  end
  else if Source is TNKDIB then begin
    if Self <> Source then begin
      ReleaseInternalDIB; // 自分の Internal DIB は切り離す。
      // Source と Internal DIB を共有する。
      Inc((Source as TNkDIB).InternalDIB.RefCount);
      InternalDIB := (Source as TNkDIB).InternalDIB;

      // TNkDIB が持つ Property 値の コピー
      FBGColor     := (Source as TNkDIB).FBGColor;
      FConvertMode := (Source as TNkDIB).FConvertMode;
      FHalftoneMode := (Source as TNkDIB).FHalftoneMode;

      // 共有で見かけ上新しい DIB が出来たのだから
      // PaletteModified は True がよいだろう．．．
      PaletteModified := True;
      Modified := True;
    end
    else  // Source is Self
      Exit;
  end
  else if Source is TBitmap then begin
    // DDB のパラメータを得る
    GetObject((Source as TBitmap).Handle, SizeOf(bm), @bm);

    // 取り敢えず デフォルトの DIB を作る
    temp := TnkInternalDIB.Create(UseFMO);
    try
      // DIB を DDB のパラメータを元に作り直す
      temp.FreeDIB;
      BitCount := BM.bmBitsPixel * BM.bmPlanes;
      if BitCount in [16, 32] then BitCount := 24;
      temp.CreateDIB(bm.bmWidth, bm.bmHeight, BitCount, 0);

      // DDB を DIB へコピーする。
      h := GetDC(0);
      OldPal := SelectPalette(h, (Source as TBitmap).Palette, True);
      RealizePalette(h);
      GetDIBits(h, (Source as TBitmap).Handle, 0, temp.Height,
                temp.DIBInfos.pBits, temp.DIBInfos.W3HeadInfo, DIB_RGB_COLORS);
      if OldPal <> 0 then
        SelectPalette(h, OldPal, True);

      ReleaseDC(0, h);

      // カラーテーブルサイズを補正する。
      if temp.DIBInfos.W3Head.biClrUsed = 0 then
        temp.DIBInfos.W3Head.biClrUsed :=
          GetNumColors(temp.DIBInfos.W3Head.biBitCount);

      // XPelsPerMeter/YPelsPerMeter を補正する
      if temp.DIBInfos.W3head.biXPelsPerMeter = 0 then
         temp.DIBInfos.W3head.biXPelsPerMeter := 3780;
      if temp.DIBInfos.W3head.biYPelsPerMeter = 0 then
         temp.DIBInfos.W3head.biYPelsPerMeter := 3780;

      // 古い DIB を切り離す
      ReleaseInternalDIB;

      // 新しい DIB にする
      InternalDIB := temp;
      InternalDIB.UpdatePalette;

      UpdatePaletteModified;
      Modified := True;
    except
      temp.Free;
      raise;
    end;
  end
  else
    Inherited Assign(Source);
end;

// AssignTo の実装
procedure TNkDIB.AssignTo(Dest: TPersistent);
var bm: TBitmap;
    HalftoneModeSave: TNkHalftoneMode;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.AssignTo: InternalDIB Should not be Nil');

  if Dest is TNkDIB then Dest.Assign(Self)
  else if Dest is TBitmap then begin
    bm := (Dest as TBitmap);
    bm.Height := Self.Height;
    bm.Width  := Self.Width;

    case PixelFormat of
      nkPf1Bit:                  bm.PixelFormat := pf1Bit;
      nkPf4Bit, nkPf4BitRLE:     bm.PixelFormat := pf4Bit;
      nkPf8Bit, nkPf8BitRLE:     bm.PixelFormat := pf8Bit;
      nkPf24Bit:                 bm.PixelFormat := pf24Bit;
      else Assert(False, 'TNkDIB.AssignTo: Illegal PixelFormat');
    end;

    // パレットをコピーするためハーフトーンモードを解除
    HalftoneModeSave := Self.FHalftoneMode;
    Self.FHalftoneMode := nkHtNoHalftone;
    try
      bm.Palette := CopyPalette(Self.Palette);
    finally
      Self.FHalftoneMode := HalftoneModeSave;
    end;

    StretchDIBits(bm.Canvas.Handle, 0, 0, Width, Height, 0, 0, Width, Height,
                  InternalDIB.DIBInfos.pBits, InternalDIB.DIBInfos.W3HeadInfo,
                  DIB_RGB_COLORS, SRCCOPY);
  end
  else
    inherited AssignTo(Dest);
end;



// ClipBoard から DIB(CF_DIB) を取得
procedure TNkDIB.LoadFromClipboardFormat(AFormat: Word;
                                         AData: THandle;
                                         APalette: HPALETTE);
var temp: TNkInternalDIB;
begin
  // データ形式のチェック
  if (AFormat <> CF_DIB) or (AData = 0) then
    raise EInvalidGraphic.Create(
      'TNkDIB.LoadFromClipboardFormat: Invalid Clipboard Format or No Data');

  // DIB を切り離し、新しい DIB を作る。
  temp := TNkInternalDIB.Create(UseFMO);
  try
    // DIB を ClipBoard から読み込む。
    temp.LoadFromClipboardFormat(AData);
  except
    temp.Free;
    raise;
  end;

  ReleaseInternalDIB;

  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;

// ClipBoard へ DIB(CF_DIB) をセットする
procedure TNkDIB.SaveToClipboardFormat(var Format: Word;
                                       var Data: THandle;
                                       var APalette: HPALETTE);
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SaveToClipboardFormat: InternalDIB Should not be Nil');

  Format := CF_DIB;                        // クリップボード形式をセット
  APalette := 0;                           // パレット無し
  InternalDIB.SaveToClipBoardFormat(Data); // クリップボードへ
end;



function TNkDIB.GetEmpty: Boolean;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetEmpty: InternalDIB Should not be Nil');
  Result := False;  // 空の状態は無い！！
end;

// DIB の高さ
function TNkDIB.GetHeight: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetHeight: InternalDIB Should not be Nil');

  Result := InternalDIB.Height;
end;

// DIB の幅
function TNkDIB.GetWidth: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetWidth: InternalDIB Should not be Nil');

  Result := InternalDIB.Width;
end;


//-------------------------------------------------------------------
// Note:
//
// TNkDIB の Width/Height/BitCount Property の変更は新しい DIB を作る
// 作られる DIB は常に非圧縮形式。特に BitCount property の役割は重要で
// PixelFormat は既存の画像を「変換」するのに対し BitCount は無地の DIB を
// 作るので BitCount の変更のほうがはるかに早い。TNkDIB を使い始めるときは
// 必ず BitCount で色数を指定すること。なお、この時 カラーテーブルも初期化
// されるので注意！！


// 幅の変更  新しい DIB を作る
procedure TNkDIB.SetWidth(Value: Integer);
var temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetWidth: InternalDIB Should not be Nil');

  if Value <= 0 then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkDIB.SetWidth: Invalid Width');

  if Value = InternalDIB.Width then Exit;

  // 新しい Internal DIB を作る
  temp := TNkInternalDIB.Create(UseFMO);
  try
    temp.FreeDIB;
    temp.CreateDIB(Value, InternalDIB.Height,
                   InternalDIB.DIBInfos.W3Head.biBitCount,
                   InternalDIB.DIBInfos.W3Head.biClrUsed);
  except
    temp.Free;
    raise;
  end;
  // 古い Internal DIB を切り離す
  ReleaseInternalDIB;

  // 新しい Internal DIB をセットする。
  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;


// 高さの変更 新しい DIB を作る
procedure TNkDIB.SetHeight(Value: Integer);
var temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetWidth: InternalDIB Should not be Nil');

  if Value = 0 then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkDIB.SetWidth: Invalid Height');

  // 新しい Internal DIB を作る
  if Value = InternalDIB.Height then Exit;

  temp := TNkInternalDIB.Create(UseFMO);
  try
    temp.FreeDIB;
    temp.CreateDIB(InternalDIB.Width, Value,
                   InternalDIB.DIBInfos.W3Head.biBitCount,
                   InternalDIB.DIBInfos.W3Head.biClrUsed);
  except
    temp.Free;
    raise;
  end;

  // 古い Internal DIB を切り離す
  ReleaseInternalDIB;

  // 新しい Internal DIB をセットする。
  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;


// BitCount の変更  新しい DIB を作る
procedure TNkDIB.SetBitCount(Value: Integer);
var temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetBitCount: InternalDIB Should not be Nil');

  if not (Value in [1, 4, 8, 24]) then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkDIB.SetBitCount: Invalid BitCount');

  if Value = InternalDIB.DIBInfos.W3Head.biBitCount then Exit;

  // 新しい Internal DIB を作る
  temp := TNkInternalDIB.Create(UseFMO);
  try
    temp.FreeDIB;
    temp.CreateDIB(InternalDIB.Width, InternalDIB.Height,
                   Value,
                   GetNumColors(Value));
  except
    temp.Free;
    raise;
  end;

  // 古い Internal DIB を切り離す
  ReleaseInternalDIB;
  InternalDIB := temp;
  // 新しい Internal DIB をセットする。
  UpdatePaletteModified;
  Modified := True;
end;



// Palette Peroperty のヘルパ
function TNkDIB.GetPalette: HPalette;
var PalSize, i: Integer;
    pPal: PLOGPALETTE;
    RIndex, GIndex, BIndex: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetPalette: InternalDIB Should not be Nil');

  if HalfTonemode = nkHtHalftone then begin
    if PaletteHalftone <> 0 then
      Result := PaletteHalftone
    else begin
      // パラメータブロックを作る
      PalSize := SizeOf(TLogPalette) + ((215 - 1) * SizeOf(TPaletteEntry));
      GetMem(pPal, PalSize);
      try
        pPal^.palNumEntries := 215;  // 色数
        pPal^.palVersion := $300;


        for RIndex := 0 to 5 do
          for GIndex := 0 to 6 do
            for BIndex := 0 to 4 do
              with pPal.palPalEntry[RIndex*7*5 + GIndex*5 + BIndex] do begin
                peRed := RedColors[RIndex];
                peGreen := GreenColors[GIndex];
                peBlue := BlueColors[BIndex];
                peFlags := 0;
              end;

      for i := 0 to 4 do
        with pPal.palPalEntry[210+i] do begin
          peRed       := GetRValue(SomeRevervedColors[i]);
          peGreen     := GetGValue(SomeRevervedColors[i]);
          peBlue      := GetBValue(SomeRevervedColors[i]);
          peFlags     := 0;
        end;

        // 作る！！
        Result := CreatePalette(pPal^);

        if Result = 0 then raise EOutOfResources.Create(
          'TNkDIB.GetPalette: Cannot Make Palette(1)');

        PaletteHalftone := Result;

      finally
        // パラメータブロックの破棄
        if pPal <> Nil then FreeMem(pPal, PalSize);
      end;
    end;
  end
  else if HalftoneMode = nkHtHalftoneBW then begin
    if PaletteBlackWhite <> 0 then
      Result := PaletteBlackWhite
    else begin
      // パラメータブロックを作る
      PalSize := SizeOf(TLogPalette) + ((2 - 1) * SizeOf(TPaletteEntry));
      GetMem(pPal, PalSize);
      try
        pPal^.palNumEntries := 2;  // 色数
        pPal^.palVersion := $300;


      for i := 0 to 1 do
        with pPal.palPalEntry[i] do begin
          peRed       := BWColors[i].rgbRed;
          peGreen     := BWColors[i].rgbGreen;
          peBlue      := BWColors[i].rgbBlue;
          peFlags     := 0;
        end;

        // 作る！！
        Result := CreatePalette(pPal^);

        if Result = 0 then raise EOutOfResources.Create(
          'TNkDIB.GetPalette: Cannot Make Palette(1)');

        PaletteBlackWhite := Result;

      finally
        // パラメータブロックの破棄
        if pPal <> Nil then FreeMem(pPal, PalSize);
      end;
    end;
  end
  else begin
    // Palette = 0 で 色数が 0 でないなら パレットを作る
    if (InternalDIB.Palette = 0) then
      if InternalDIB.DIBInfos.W3Head.biClrUsed <> 0 then
        InternalDIB.Palette := InternalDIB.MakePalette;
       Result := InternalDIB.Palette;
  end;
end;


//-------------------------------------------------------------------
// Note
//
// パレットはカラーテーブルに変換され設定される。
// PaletteSize Property や Colors Property も変化する。
// パレットハンドルは TNkDIB の管理下に入るので、パレットをセットした側で
// パレットハンドルを破棄してはならない。

// パレットを設定する
procedure TNkDIB.SetPalette(Value: HPalette);
var i, n: Integer;
    Colors: array[0..255] of TPALETTEENTRY;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetPalette: InternalDIB Should not be Nil');

  UniqueDIB;

  if Value = 0 then
    InternalDIB.DIBInfos.W3Head.biClrUsed := 0
  else begin
    n := GetPaletteEntries(Value, 0, 256, Colors);
    if n = 0 then raise ENkDIBInvalidPalette.Create(
      'TNkDIB.SetPalette: Invalid Palette');
    InternalDIB.DIBInfos.W3Head.biClrUsed := n;
    for i := 0 to n-1 do begin
      InternalDIB.DIBInfos.W3HeadInfo.bmiColors[i].rgbRed   := Colors[i].peRed;
      InternalDIB.DIBInfos.W3HeadInfo.bmiColors[i].rgbGreen := Colors[i].peGreen;
      InternalDIB.DIBInfos.W3HeadInfo.bmiColors[i].rgbBlue  := Colors[i].peBlue;
      InternalDIB.DIBInfos.W3HeadInfo.bmiColors[i].rgbReserved := 0;
    end;
    InternalDIB.Palette := Value;
  end;
  UpdatePaletteModified;
  Modified := True;
end;


// PaletteSize Property のヘルパ
function TNkDIB.GetPaletteSize: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetPalette: InternalDIB Should not be Nil');

  // biClrUsed は ０ であることもあるが、 InternalDIB 内では
  // 補正して有るので問題無い
  Result := InternalDIB.DIBInfos.W3Head.biClrUsed
end;

procedure TNkDIB.SetPaletteSize(value: Integer); // パレットサイズの設定
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetPaletteSize: InternalDIB Should not be Nil');

  // True Color ならパレットは無くてもよい
  if (InternalDIB.DIBInfos.W3Head.biBitCount = 24) and
     ((Value < 0) or (Value > 256)) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.SetPaletteSize: Palette Index is Out of Range 1');

  // 8/4 ビットなら、1色は無いと困る。
  if (InternalDIB.DIBInfos.W3Head.biBitCount <> 24) and
     ((Value < 1) or (Value > 256)) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.SetPaletteSize: Palette Index is Out of Range 2');

  if InternalDIB.DIBInfos.W3Head.biClrUsed <> Value then begin
    UniqueDIB;  // Internal DIB の共有を止める
    InternalDIB.DIBInfos.W3Head.biClrUsed := Value;
    InternalDIB.DIBInfos.W3Head.biClrImportant := 0;  // 念のため
    InternalDIB.UpdatePalette;                        // 旧パレットを捨てる
    UpdatePaletteModified;
    Modified := True;
  end;
end;

// ClipboardFormat Property のヘルパ    常に CF_DIB を返す。
function TNkDIB.GetClipboardFormat: UINT;
begin Result := CF_DIB; end;

// BitCount Peoprty のヘルパ
function TNkDIB.GetBitCount: Integer;    // BitCount の取得
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetBitCount: InternalDIB Should not be Nil');

  Result := InternalDIB.DIBInfos.W3Head.biBitCount;
end;

// Colors Property のヘルパ
// Colors Property の取得
function TNkDIB.GetColors(Index: Integer): TColor;
var Color: TRGBQuad;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetColors: InternalDIB Should not be Nil');

  if (Index < 0) or (Index > 255) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.GetColors: Palette Index is Out of Range');

  // カラーテーブルのエントリ値を取得
  Color := InternalDIB.DIBInfos.W3HeadInfo.bmiColors[Index];
  // TRGBQuad 型から TColor 型に変換
  Result := RGB(Color.rgbRed, Color.rgbGreen, Color.rgbBlue);
end;

// Colors Property の設定
procedure TNkDIB.SetColors(Index: Integer; Value: TColor);
var Color: TRGBQuad;
    RGB: LongInt;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetColors: InternalDIB Should not be Nil');

  if (Index < 0) or (Index > 255) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.GetColors: Palette Index is Out of Range');

  // 新しいパレットを作るため、共有を止める
  UniqueDIB;

  // TColor を TRGBQuad に変換
  RGB := ColorToRGB(Value);
  Color.rgbRed   := GetRValue(RGB);
  Color.rgbGreen := GetGValue(RGB);
  Color.rgbBlue  := GetBValue(RGB);
  Color.rgbReserved := 0;

  InternalDIB.DIBInfos.W3HeadInfo.bmiColors[Index] := Color;
  {$RANGECHECKS ON}
  //古いパレットを削除
  InternalDIB.UpdatePalette;
  // 変更を通知
  UpdatePaletteModified;
  Modified := True;
end;

// Pixels Property のヘルパ

//-------------------------------------------------------------------
// Note:
//
// Pixels Property は LongInt 型だが 1/4/8 RGB 型ではカラーインデックス値に
// なる。TrueColor では RGB 値になる。

// Pixel 値の取得
function TNkDIB.GetPixels(x, y: Integer): LongInt;  // Pixel 値の取得
var pLine: PNkTripleArray;
    pByte: ^Byte;
    Mask: Byte;
const Bits8: BYTE = $80;
begin
  // 圧縮フォーマットでのピクセル値の取得は困難なのでエラーにする
  // また、現在は 非効率なので 1/4Bit 非圧縮もサポートしない。
  // 8 Bit 非圧縮に変換してから処理すること
  with InternalDIB.DIBInfos.W3Head do begin
    if (biCompression <> BI_RGB) then
      raise ENkDIBBadDIBType.Create('TNkDIB.GetPixels: Bad DIB Type');

    // 範囲チェック
    if (x < 0) or ( x >= biWidth) or (y < 0) or (y >= abs(biHeight)) then
      raise ENkDIBPixelPositionRange.Create(
        'TNkDIB.GetPixels: Pixel Position is Out of Range');


    if biBitCount = 8 then begin
      // 8Bit 非圧縮

      // ピクセルアドレスを計算（左上原点！！）
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 3) div 4) * 4 * (biHeight - y - 1) + x)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 3) div 4) * 4 * y + x);
      Result := pByte^;  // カラーテーブルのインデックスを返す
    end
    else if biBitCount = 24 then begin
      // True Color

      // ラインの先頭アドレスを計算（左上原点！！！）
      if biHeight > 0 then
        pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth * 3 + 3) div 4) * 4 * (biHeight - y - 1))
    else
      pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                       ((biWidth * 3 + 3) div 4) * 4 * y);
      // TColor 型を返す
      Result := RGB(pLine^[x].R, pLine^[x].G, pLine^[x].B);
    end
    else if biBitCount = 4 then begin
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth*4 + 31) div 32) * 4 *
                            (biHeight - y - 1) + x div 2)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                         ((biWidth*4 + 31) div 32) * 4 * y + x div 2);
      // インデックス値を読む
      if ( x mod 2) = 0 then
        Result := (pByte^ shr 4) and $0f
      else
        Result := pByte^ and $0f;
    end
    else if biBitCount = 1 then begin
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 31) div 32) * 4 *
                            (biHeight - y - 1) + x div 8)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                         ((biWidth + 31) div 32) * 4 * y + x div 8);
      // カラーテーブルのインデックス値を書き込む
      Mask := Bits8 shr (x mod 8);
      if (pByte^ and Mask) <> 0 then Result := 1
      else Result := 0;
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkDIB.GetPixels: GetPixel supports only Uncompressed DIB');
  end;
end;


// ピクセルの変更
// 注意！！ ピクセルの変更は 効率の確保のため OnChange Event を起こさない
// 従って、 TNkImage に変更を報せるには TNkImage の Invalidate メソッドを
// 呼び出す必要がある
procedure TNkDIB.SetPixels(x, y: Integer; Value: LongInt); // Pixel 値の設定
var pLine: PNkTripleArray;
    pByte: ^Byte;
    Mask: BYTE;
const Bits8: BYTE = $80;
begin
  // DIB の内容が変化するため、共有を止める
  if InternalDIB.RefCount <> 1 then
    UniqueDIB;

  with InternalDIB.DIBInfos.W3Head do begin
    if (biCompression <> BI_RGB) then
      raise ENkDIBBadDIBType.Create('TNkDIB.SetPixels: Bad DIB Type');


    if (x < 0) or ( x >= biWidth) or (y < 0) or (y >= abs(biHeight)) then
      raise ENkDIBPixelPositionRange.Create(
        'TNkDIB.SetPixels: Pixel Position is Out of Range');


    if biBitCount = 8 then begin
      // 8Bit 非圧縮

      // ピクセルアドレスを計算（左上原点！！）
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 3) div 4) * 4 * (biHeight - y - 1) + x)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                         ((biWidth + 3) div 4) * 4 * y + x);
      // カラーテーブルのインデックス値を書き込む
      pByte^ := Value;
    end
    else if biBitCount = 24 then begin
      // True Color

      // ラインの先頭アドレスを計算（左上原点）
      if biHeight > 0 then
        pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth * 3 + 3) div 4) * 4 * (biHeight - y - 1))
      else
        pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth * 3 + 3) div 4) * 4 * y);

      // ピクセル情報を書き込み (TColor -> TRGBTriple)
      pLine^[x].R := GetRValue(Value);
      pLine^[x].G := GetGValue(Value);
      pLine^[x].B := GetBValue(Value);
    end
    else if biBitCount = 4 then begin
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth*4 + 31) div 32) * 4 *
                            (biHeight - y - 1) + x div 2)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                         ((biWidth*4 + 31) div 32) * 4 * y + x div 2);
      // カラーテーブルのインデックス値を書き込む
      if ( x mod 2) = 0 then
        pByte^ := (pByte^ and $0f) or ((Value shl 4) and $f0)
      else
        pByte^ := (pByte^ and $f0) or (Value and $0f);
    end
    else if biBitCount = 1 then begin
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 31) div 32) * 4 *
                            (biHeight - y - 1) + x div 8)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                         ((biWidth + 31) div 32) * 4 * y + x div 8);
      // カラーテーブルのインデックス値を書き込む
      Mask := Bits8 shr (x mod 8);
      if Value <> 0 then
        pByte^ := (pByte^ and (not Mask)) or Mask
      else
        pByte^ := (pByte^ and (not Mask));
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkDIB.SetPixels: GetPixel supports only Uncompressed 8 or 24 bit DIB');
  end;
  // UpdatePaletteModified;
end;

// ScanLine ポインタの取得
// 注意！！ ScanLine ポインタを介したピクセルの変更は OnChange Event を
// 起こさない
// 従って、 TNkImage に変更を報せるには TNkImage の Invalidate メソッドを
// 呼び出す必要がある

function TNkDIB.GetScanLine(y: Integer): Pointer; // Scanline ポインタの取得
var LineWidth: Integer;
begin
  if InternalDIB.RefCount <> 1 then begin
    UniqueDIB;
    UpdatePaletteModified;
  end;

  with InternalDIB.DIBInfos.W3Head do begin

    if (y < 0) or (y >= abs(biHeight)) then
      raise ENkDIBPixelPositionRange.Create(
        'TNkDIB.GetScanLine: y is Out of Range');


   if biCompression <> BI_RGB then
     raise ENkDIBBadDIBType.Create('TNkDIB.GetScanLine: Bad DIB Type');

   LineWidth := ((biWidth * biBitCount + 31) div 32) * 4;

    if biHeight > 0 then
      Result := AddOffset(InternalDIB.DIBInfos.pBits,
                          LineWidth * (biHeight - y - 1))
    else
      Result := AddOffset(InternalDIB.DIBInfos.pBits, LineWidth * y);
  end;
end;


// Pixel Format の取得
function TNkDIB.GetPixelFormat: TNkPixelFormat;
begin
//  Assert(InternalDIB <> Nil,
//    'TNkDIB.GetPixelFormat: InternalDIB Should not be Nil');

  Result := InternalDIB.GetPixelFormat;
end;

// Pixel Format の変換
// ここでの処理はほとんど TNkInternalDIB 任せだが、TNkDIB 側では以下の処理を
// 行う。
//  (1) PixelFormat が変更されるのかチェックし、変更されないのなら何もしない。
//  (2) UniqueDIB を呼んで共有を解く。
//  (3) OnProgress を起こす必要があるか判断し、必要なら プログレスハンドラの
//      初期化を行い StartProgres(OnProgress で State = psStarting を起こす)を
//      呼ぶ。
//  (4) 変換する(TNkInternalDIB の SetPixelFormat を呼ぶ)
//  (5) StartProgres を呼んだ場合は「必ず」EndProgress を呼び出し
//      State = psEnding の OnProgress イベントを起こす。
//  (6) パレットの変更を拾い出し、OnChange イベントを起こす。
procedure TNkDIB.SetPixelFormat(Value: TNkPixelFormat);
var ProgressFlag: Boolean;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetPixelFormat: InternalDIB Should not be Nil');

  if PixelFormat <> Value then begin
    UniqueDIB;

    ProgressFlag := False;

    case PixelFormat of
      nkPf24Bit:
        case Value of
          nkPf4Bit: begin
            ProgressFlag := True;
            InitializeProgressHandler(16, 'PixelFormat 24Bit -> 4Bit');
            StartProgress;
          end;
          nkPf4BitRLE: begin
            ProgressFlag := True;
            InitializeProgressHandler(16, 'PixelFormat 24Bit -> 4BitRLE');
            StartProgress;
          end;
          nkPf8Bit: begin
            ProgressFlag := True;
            InitializeProgressHandler(256, 'PixelFormat 24Bit -> 8Bit');
            StartProgress;
          end;
          nkPf8BitRLE: begin
            ProgressFlag := True;
            InitializeProgressHandler(256, 'PixelFormat 24Bit -> 8BitRLE');
            StartProgress;
          end;
        end;
      nkPf8Bit:
        case Value of
          nkPf4Bit: begin
            ProgressFlag := True;
            InitializeProgressHandler(16, 'PixelFormat 8Bit -> 4Bit');
            StartProgress;
          end;
          nkPf4BitRLE: begin
            ProgressFlag := True;
            InitializeProgressHandler(16, 'PixelFormat 8Bit -> 4BitRLE');
            StartProgress;
          end;
        end;
      nkPf8BitRLE:
        case Value of
          nkPf4Bit: begin
            ProgressFlag := True;
            InitializeProgressHandler(16, 'PixelFormat 8BitRLE -> 4Bit');
            StartProgress;
          end;
          nkPf4BitRLE: begin
            ProgressFlag := True;
            InitializeProgressHandler(16, 'PixelFormat 8BitRLE -> 4BitRLE');
            StartProgress;
          end;
        end;
    end;

    try
      InternalDIB.SetPixelFormat(Value, FConvertMode, ColorToRGB(FBGColor),
                               ProgressHandler);
    finally
      UpdatePaletteModified;
      if ProgressFlag then EndProgress;
    end;

    UpdatePaletteModified;
    Modified := True;
  end;
end;


// ハーフトーンモードの設定

procedure TNkDIB.SetHalftoneMode(Value: TNkHalftoneMode);
begin
  if FHalfToneMode = Value then Exit;

  FHalftoneMode := Value;
  PaletteModified := True;
  Modified := True;
end;


// XpelsPerMeter/YPelsPerMeter のヘルパ

function TNkDIB.GetXPelsPerMeter: LongInt;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetXPelsPerMeter: InternalDIB Should not be Nil');

  Result := InternalDIB.DIBInfos.W3Head.biXPelsPerMeter;
end;

procedure TNkDIB.SetXPelsPerMeter(Value: LongInt);
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetXPelsPerMeter: InternalDIB Should not be Nil');

  UniqueDIB;
  InternalDIB.DIBInfos.W3Head.biXPelsPerMeter := Value;
  Modified := True;
end;

function TNkDIB.GetYPelsPerMeter: LongInt;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetYPelsPerMeter: InternalDIB Should not be Nil');

  Result := InternalDIB.DIBInfos.W3Head.biYPelsPerMeter;
end;

procedure TNkDIB.SetYPelsPerMeter(Value: LongInt);
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetYPelsPerMeter: InternalDIB Should not be Nil');

  UniqueDIB;
  InternalDIB.DIBInfos.W3Head.biYPelsPerMeter := Value;
  Modified := True;
end;




// Delphi 3.0J の PaletteModified Property の更新処理
// この処理は一見 共有されている InternalDIB.PaletteModified を
// 更新しているので危険に思われるが、Palette の更新時には
// RefCount = 1 のはずなので問題無い。

procedure TNkDIB.UpdatePaletteModified;
begin
  Assert(InternalDIB.RefCount = 1, 'TNkDIB.UpdatePaletteModified RefCount Must be 1');
  if InternalDIB.PaletteModified = True then begin
    InternalDIB.PaletteModified := False;
    PaletteModified := True;
  end;
end;



// TNkDIB 間で Internal DIB が共有されている場合は、コピーして切り離す。
procedure TNkDIB.UniqueDIB;
var Temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.UniqueDIB: InternalDIB Should not be Nil');

  // Internal DIB が共有されていなければ何もしない
  if InternalDIB.RefCount = 1 then Exit;

  // Internal DIB を作る
  Temp := TNkInternalDIB.Create(UseFMO);
  try
    // デフォルトで出来る 1 X 1 Pixel の DIB を捨てる
    temp.FreeDIB;


    // Internal DIB をコピー
    temp.Height   := InternalDIB.Height;
    temp.Width    := InternalDIB.Width;
    temp.DIBInfos := InternalDIB.DIBInfos;
    temp.DIBInfos.pBits := Nil;
    temp.UseFMO   := InternalDIB.UseFMO;
    with temp.DIBInfos do
      GetMemory(BitsSize, hFile, pBits, temp.UseFMO);

    System.Move(InternalDIB.DIBInfos.pBits^, temp.DIBInfos.pBits^,
                temp.DIBInfos.BitsSize);
    // 共有されている Internal DIB を切り離す
    ReleaseInternalDIB;

    // コピーされた DIB をつなぐ
    InternalDIB := temp;
    UpdatePaletteModified;
  except
    temp.Free;
    raise;
  end;
end;



// True Color DIB にカラーテーブルを作成する
procedure TNkDIB.CreateTrueColorPalette;
begin
  UniqueDIB;
  InitializeProgressHandler(256, 'Create True Color Palette');
  StartProgress;
  try
    InternalDIB.CreateTrueColorPalette(FConvertMode, ProgressHandler);
  finally
    UpdatePaletteModified;
    EndProgress;
  end;
  Modified := True;
end;


//-------------------------------------------------------------------
// Note
//
// OnProgress イベントは TNkDIB.ProgressHandler が呼び出されると起きるように
// した。TNkDIB 内にイベントカウンタを持ち これで PercentDone を計算して
// OnProgress イベントを起こす。
// TNkDIB では プログレスの途中で描画することはできないため EndProgress で
// OnProgress イベントを起こすときのみ RedrawNow を True にしている。
//


// プログレスハンドラの初期化
// AMaxNumberOfProgress: プログレスの最大回数。PercentDone を計算するのに使う。
// AProgressString:      OnProgress で通知されるメッセージ

procedure TNkDIB.InitializeProgressHandler(AMaxNumberOfProgresses: Integer;
                                          AProgressString: string);
begin
  ProgressString := AProgressString;
  MaxNumberOfProgresses := AMaxNumberOfProgresses;
  NumberOfProgresses := 0;
end;

// プログレスハンドラ OnProgress(Stage = psRunning)を起こす。
procedure TNkDIB.ProgressHandler(Sender: TObject);
begin
  Inc(NumberOfProgresses);
  if NumberOfProgresses <> MaxNumberOfProgresses then
    Progress(Self, psRunning, NumberOfProgresses * 100 div MaxNumberOfProgresses,
             False, Rect(0, 0, Width, Height), ProgressString);
end;

// OnProgress(PercentDone = 0%, Stage=psStarting) を起こす。
procedure TNkDIB.StartProgress;
begin
  Progress(Self, psStarting, 0, False, Rect(0, 0, Width, Height), ProgressString);
end;

// OnProgress(PercentDone = 0%, Stage=psEnding) を起こす。
procedure TNkDIB.EndProgress;
begin
  Progress(Self, psEnding, 100, True, Rect(0, 0, Width, Height), ProgressString);
end;

function TNkDIB.GetUseFMO: Boolean;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetUseFMO: InternalDIB Should not be Nil');

  Result := InternalDIB.UseFMO;
  { DONE : GetUseFMO のコードを完成させる InternalDIB に UseFMO が必要}
end;

procedure TNkDIB.SetUseFMO(const Value: Boolean);
var Temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetUseFMO: InternalDIB Should not be Nil');

  // UseFMO が変化しないなら何もしない
  if UseFMO = Value then Exit;

  // Internal DIB を作る
  Temp := TNkInternalDIB.Create(Value);
  try
    // デフォルトで出来る 1 X 1 Pixel の DIB を捨てる
    temp.FreeDIB;

    // Internal DIB をコピー
    temp.Height   := InternalDIB.Height;
    temp.Width    := InternalDIB.Width;
    temp.DIBInfos := InternalDIB.DIBInfos;
    temp.DIBInfos.pBits := Nil;
    with temp.DIBInfos do
      GetMemory(BitsSize, hFile, pBits, temp.UseFMO);

    System.Move(InternalDIB.DIBInfos.pBits^, temp.DIBInfos.pBits^,
                temp.DIBInfos.BitsSize);
    // 共有されている Internal DIB を切り離す
    ReleaseInternalDIB;

    // コピーされた DIB をつなぐ
    InternalDIB := temp;
    UpdatePaletteModified;
  except
    temp.Free;
    raise;
  end;
    { DONE : SetUse FMO 残りのコードを完成させる }
end;



// TNkDIBCanvas の作成
// Canvas ってたったこれだけのコードでできてしまいます。簡単。
constructor TNkDIBCanvas.Create(ADIB: TNkDIB);
var HalftoneModeSave: TNkHalftoneMode;
begin
  inherited Create;
  if (ADIB = Nil) or not ADIB.UseFMO then
    raise ENkDIBCanvasFailed.Create(
      'TNkDIBCanvas.Create: Cannot Create Canvas');
  DIB := ADIB;

  // 書き込みをするので共有をやめる。
  DIB.UniqueDIB;

  OldBitmap := 0; OldPalette := 0;
  MemDC := 0; hDIBSection := 0;
  pBits := Nil;

  // Memory DC の作成
  MemDC := CreateCompatibleDC(0);
  if MemDC = 0 then raise EOutOfResources.Create(
    'TNkDIBCanvas.Create: Cannot Create Memory DC');

  // パレットを実体化
  HalftoneModeSave := DIB.HalftoneMode;
  DIB.FHalftoneMode := nkHtNoHalftone;
  try
    OldPalette := SelectPalette(MemDC, DIB.Palette, True);
    RealizePalette(MemDC);
  finally
    DIB.FHalftoneMode := HalftoneModeSave;
  end;

  // DIB Section の作成
  hDIBSection := CreateDIBSection(MemDC, DIB.InternalDIB.DIBInfos.W3HeadInfo,
                                  DIB_RGB_COLORS, pBits,
                                  DIB.InternalDIB.DIBInfos.hFile, 0);
  if hDIBSection = 0 then raise EOutOfResources.Create(
    'TNkDIBCanvas.Create: Cannot Create Memory DC');

  // DIB Section を DC に選択
  OldBitmap := SelectObject(MemDC, hDIBSection);

  // Canvas に DC をセット
  Handle := MemDC;
end;

destructor TNkDIBCanvas.Destroy;
begin
  // DIB Section を DC から外す
  if OldBitmap <> 0 then SelectObject(MemDC, OldBitmap);

  // DIB Section を削除する
  if hDIBSection <> 0 then DeleteObject(hDIBSection);

  // DC を Canvas から切り離す。
  Handle := 0;

  // DC を削除する。
  if MemDC <> 0 then DeleteDC(MemDC);

  if DIB <> Nil then begin
    DIB.UpdatePaletteModified;
    DIB.Changed(DIB);
  end;
  inherited Destroy;
end;


Initialization
  // ハーフトーン用パレットの初期化。不要だが念のため。
  PaletteHalfTone := 0;
  PaletteBlackWhite := 0;
  // Clipborad Format CF_DIB を TNkDIB に対応づける。
  TPicture.RegisterClipBoardFormat(CF_DIB, TNkDIB);
  // 拡張子 dib のファイルと TNkDIB を対応づける。
  TPicture.RegisterFileFormat('dib', 'Device Independent Bitmap', TNkDIB);


finalization
  // ハーフトーン用パレットの破棄。不要だが念のため。
  if PaletteHalfTone <> 0 then DeleteObject(PaletteHalfTone);
  if PaletteBlackWhite <> 0 then DeleteObject(PaletteBlackWhite);
  // Delphi 3.0J 以降では、TPicture.RegisterClipBoardFormat や
  // TPicture.RegisterFileFormat で登録した TNkDIB の拡張子やクリップボード
  // フォーマットを パッケージが Unload されるときに Graphics ユニットから
  // 削除する必要が有る。Delphi 2.0J では削除するメソッドが無い
  TPicture.UnRegisterGraphicClass(TNkDIB);
end.

