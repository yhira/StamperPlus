/////////////////////////////////////////////////////////////
//
// Unit NkGraphic  -- Improved TGraphic
//
// Coded By T.Nakamura
//
//
//  履歴
//
//  Ver 0.32: May.  4 '97  α８版   TNkDIB から TNkGraphic の宣言を分離
//  Ver 0.34: Jun. 29 '97  α１０版 Delphi 3.0J 対応。
//  Ver 0.43: Sep.  5 '97  α１３版 クリップボードからのデータ取得をサポート。
//  Ver 0.61: Jan. 12 '97  Progress メソッド／OnProgress イベントを追加 
//  Ver 0.64: May.  3 '98  コンパイラ指令、Delphi Version Check 識別子を追加
//  Ver 0.65: May. 5 '98  C++Builder 3.0J に対応
//  Ver 0.66: Sep. 27 '98 Delphi 4.0J に対応。
//  Ver 0.70: May 8 '99   Delphi 2, C++Builder 1 サポート打ち切り


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

unit NkGraph;

interface
uses Windows, Classes, Graphics;

type
  TNkGraphic = class(TGraphic)
  protected
    function GetClipboardFormat: UINT; virtual; abstract;
  public
    procedure Assign(Source: TPersistent); override;
    property ClipboardFormat: UINT read GetClipboardFormat;
  end;


implementation

uses ClipBrd;

// クリップボードからのデータの取得
procedure TNkGraphic.Assign(Source: TPersistent);
var Clip: TClipBoard;
    AData: THandle;
    APalette: HPALETTE;
begin
  // ソースがクリップボードか？
  if Source is TClipBoard then begin
    Clip := Source as TClipBoard;
    Clip.Open;
    try
      // クリップボードから ClipboardFormat 型のデータを取得
      AData := Clip.GetAsHandle(ClipboardFormat);
      // クリップボードから パレットを取得
      APalette := Clip.GetAsHandle(CF_PALETTE);

      // ここで、データが取得できたかのチェックはしない。
      // ADataとAPalette のチェックは LoadFromClipboardFormat が行う。

      // データを押し込む
      LoadFromClipboardFormat(ClipboardFormat, AData, APalette);
    finally
      Clip.Close;
    end;
  end
  else
    inherited Assign(Source);
end;

end.
