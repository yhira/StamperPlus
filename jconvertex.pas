{**************************************************************************
 *
 * Unit Name: jconvert
 * Purpose  : 文字コード変換ライブラリとおまけ
 * Author   : EarthWave Soft(IKEDA Takahiro)
 *            E-Mail: ikeda@os.rim.or.jp
 *            WWW:    http://www.os.rim.or.jp/~ikeda/
 *            Copyright(C) 1998 EarthWave Soft(IKEDA Takahiro)
 * History  : Ver 1.0 98/08/25 初版
 *            Ver 1.1 98/09/17 Result 初期化忘れ対応 他
 *                               (Thanks kazukun@mars.dti.ne.jp)
 *            Ver 1.2 98/10/11 半角「ｰ」の全角変換ミスの修正
 *                             Hankana2Zenkana? 上記対応とアルゴリズム変更
 *                             1行のみのデータ時の改行コード判断判定ミス修正
 *            Ver 1.3 98/11/23 EncodeBase64R, DecodeBase64, DecodeHeaderString
 *                             新設。
 *            Ver 1.4 98/11/29 EncodeUU, DecodeUU, EncodeBinHex, DecodeBinHex
 *                             を新設（uuencode,BinHex）。
 *
 *  注意: ここで言う「jis」 は ISO-2022-JP に基づいた仕様による
 *        JIS への変換では半角カタカナは全角へ強制的に変換する
 *************************************************************************}

unit jconvertex;

interface

uses
  Windows, Sysutils, Classes;

const
  ASCII      = 0;
  BINARY     = 1;
  JIS83_IN   = 2;
  JIS78_IN   = 3;
  EUC_IN     = 4;
  SJIS_IN    = 5;
  EUCorSJIS_IN = 6;
  UNILE_IN   = 7; // Unicode Little Endian(Intel CPU)
  UNIBE_IN   = 8; // Unicode Big Endian
  UTF8_IN    = 9; // UTF8(TTF8NのBOM付き)
  UTF8N_IN   = 10;// UTF8N

  JIS_OUT   = 2;
  EUC_OUT     = 4;
  SJIS_OUT    = 5;
  UNILE_OUT  = 7;
  UNIBE_OUT  = 8;
  UTF8_OUT   = 9;
  UTF8N_OUT  = 10;



  CRLF_R = 1;
  CR_R = 2;
  LF_R = 3;

  {バイナリファイルを厳密にチェックするための最低チェックサイズ}
  STRICT_CHECK_LEN: Integer = 512; {任意に変更して下さい}

{漢字コード判定。戻り値は定数を参照}
function InCodeCheck( const s: string ): Integer;

{2 バイト文字の JIS -> SJIS変換}
function ToSjis( c1,c2: Byte ): string;

{2 バイト文字の SJIS -> JIS変換}
function ToJis( c1, c2: Byte ): string;

{euc半角カタカナを jis 全角カタカナへ（内部使用）}
{function Hankana2Zenkana( const s: string; var index: Integer ): string;}

{sjis半角カタカナを jis 全角カタカナへ（内部使用）}
{function Hankana2Zenkana2( const s: string; var index: Integer ): string;}

{jis -> euc コンバート}
function jis2euc( const s: string ): string;

{euc -> 新jis コンバート}
function euc2jis83( const s: string ): string;

{jis -> sjis コンバート}
function jis2sjis( const s: string ): string;

{euc -> sjis コンバート}
function euc2sjis( const s: string ): string;

{sjis -> 新jis コンバート}
function sjis2jis83( const s: string ): string;

{sjis -> euc コンバート}
function sjis2euc( const s: string ): string;

{改行コードチェック}
function ReturnCodeCheck( const s: string ): Integer;

{全自動コード変換}
function ConvertJCode( s: string; outcode: Integer ): string;

{厳密なコード変換。既に元コードが判明している場合等に使用}
{意味あるのかこれ？}
function StrictConvertJCode( s: string; incode, outcode: Integer ): string;

{改行コード変換}
function ConvertReturnCode( s: string; rcode: Integer ): string;

{厳密な改行コード変換。既に元コードが判明している場合等に使用}
{意味あるのかこれ？}
function StrictConvertReturnCode( s: string; rcode_in, rcode: Integer ): string;

{おまけ}

{Base64 形式にエンコードする}
function EncodeBase64( const input: string ): string;

function EncodeBase64R( const input: string; Rcode: string ): string;

{uuencode 形式にエンコードする}
function EncodeUU( const input: string; Rcode: string ): string;

{BinHex 4.0 形式にエンコードする}
function EncodeBinHex( const input: string; Rcode: string ): string;

{Base64 形式をデコードする}
function DecodeBase64( const input: string ): string;

{uuencode 形式をデコードする。uudecode}
function DecodeUU( const input: string ): string;

{BinHex 4.0 形式をデコードする}
function DecodeBinHex( const input: string ): string;

{E-Mail のヘッダなどに使う文字列(ISO-2022-JP を Base64化したもの)を生成}
function CreateHeaderString( const s: string): string;

{E-Mail のヘッダなどに使う文字列(ISO-2022-JP を Base64化したもの)をデコード}
function DecodeHeaderString( const s: string): string;

// 拡張文字コードチェック
function InCodeCheckEx(const s: string): integer;
// UNICODE(Little Endian)をSJISに変換する
function uniLETosjis(const s: PWideChar): string;
// UNICODE(Big Endian)をSJISに変換する
function uniBETosjis(const s: PWideChar): string;
// UTF8をSJISに変換する
function Utf8Tosjis(const s: String): string;
// UTF8NをSJISに変換する
function Utf8NTosjis(const s: String): string;

// SJISをUNICODE(LE)に変換する
procedure sjisToUniLE(var ms: TMemoryStream; const s: string);
// SJISをUNICODE(BE)に変換する
procedure sjisToUniBE(var ms: TMemoryStream; const s: string);
// SJISをUNICODE(UTF8)に変換する
function sjisToUtf8(const s: string): string;
// SJISをUNICODE(UTF8N)に変換する
function sjisToUtf8N(const s: string): string;
//半角から全角
function HanToZen(Str : String) : String;
//全角から半角
function ZenToHan(Str : String) : String;
//ひらがな->カタカナ
function HiraToKana(Str : String) : String;
//カタカナ->ひらがな
function KanaToHira(Str : String) : String;


implementation

const
  CR = $0D;
  LF = $0A;

  ESC = $1B;
  SS2 = $8E;
  
  KI_G0 = #$1B + '$B';
  KO_G0 = #$1B + '(J';

  Code64: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  CodeUU: PChar = '`!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_';
  CodeBinHex: PChar = '!"#$%&''()*+,-012345689@ABCDEFGHIJKLMNPQRSTUVXYZ[`abcdefhijklmpqr';
  DecBinHex: array[0..81] of BYTE = (
    $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$FF,$FF,$0D,
    $0E,$0F,$10,$11,$12,$13,$FF,$14,$15,$FF,$FF,$FF,$FF,$FF,$FF,$16,
    $17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$FF,$25,
    $26,$27,$28,$29,$2A,$2B,$FF,$2C,$2D,$2E,$2F,$FF,$FF,$FF,$FF,$30,
    $31,$32,$33,$34,$35,$36,$FF,$37,$38,$39,$3A,$3B,$3C,$FF,$FF,$3D,
    $3E,$3F );
    
  { JIS X0201 1 バイト仮名 から JIS X0208 右側へ}
  HkanaToZkana_R: array[0..63] of Char = (
    #$00,#$23,#$56,#$57,#$22,#$26,#$72,#$21,#$23,#$25,#$27,#$29,#$63,#$65,#$67,#$43,
    #$3C,#$22,#$24,#$26,#$28,#$2A,#$2B,#$2D,#$2F,#$31,#$33,#$35,#$37,#$39,#$3B,#$3D,
    #$3F,#$41,#$44,#$46,#$48,#$4A,#$4B,#$4C,#$4D,#$4E,#$4F,#$52,#$55,#$58,#$5B,#$5E,
    #$5F,#$60,#$61,#$62,#$64,#$66,#$68,#$69,#$6A,#$6B,#$6C,#$6D,#$6F,#$73,#$2B,#$2C);

//半角から全角
function HanToZen(Str : String) : String;
var
  Buf:array of Char;
begin
  SetLength(Buf, Length(Str)*2+1);
  LCMapString(GetUserDefaultLCID, LCMAP_FULLWIDTH, PChar(Str), Length(Str)+1, PChar(Buf), Length(Buf));
  Result:=String(Buf);
end;

//全角から半角
function ZenToHan(Str : String) : String;
var
  Buf:array of Char;
begin
  SetLength(Buf, Length(Str)+1);
  LCMapString(GetUserDefaultLCID, LCMAP_HALFWIDTH, PChar(Str), Length(Str)+1, PChar(Buf), Length(Buf));
  Result:=String(Buf);
end;

//ひらがな->カタカナ
function HiraToKana(Str : String) : String;
var
  Buf:array of Char;
begin
  SetLength(Buf, Length(Str)+1);
  LCMapString(GetUserDefaultLCID, LCMAP_KATAKANA, PChar(Str), Length(Str)+1, PChar(Buf), Length(Buf));
  Result:=String(Buf);
end;

//カタカナ->ひらがな
function KanaToHira(Str : String) : String;
var
  Buf:array of Char;
begin
  SetLength(Buf, Length(Str)+1);
  LCMapString(GetUserDefaultLCID, LCMAP_HIRAGANA, PChar(Str), Length(Str)+1, PChar(Buf), Length(Buf));
  Result:=String(Buf);
end;

function InCodeCheck( const s: string ): Integer;
var
  index,c,jmode: Integer;
begin
  {バイナリチェック}
  index := 1;
  while (index <= STRICT_CHECK_LEN) and (index < Length(s)) do begin
    c := Ord( s[index] );
    if (c in [0..7]) or (c = $FF) then begin
      Result := BINARY;
      Exit;
    end;
    Inc(index);
  end;

  index := 1;
  jmode := ASCII;
  while ((jmode = ASCII) or (jmode = EUCorSJIS_IN)) and (index < Length(s)) do begin
    {最後の文字は調べない（ループ内で調べるときがある）}
    c := Ord( s[index] );
    if c = ESC  then begin
      Inc(index);
      c := Ord(s[index]);
      if c = Ord('$') then begin
        Inc(index);
        c := Ord(s[index]);
        if c = Ord( 'B' ) then
          jmode := JIS83_IN           {JIS X0208-1983}
        else if c = Ord( '@' ) then
          jmode := JIS78_IN;          {JIS X0208-1978 Old JIS}
      end;
    end
    else if (c in [0..7]) or (c = $FF) then begin
      jmode := BINARY;
    end
    else if c > $7f then begin
      if (c in [$81..$8D]) or (c in [$8F..$9F]) then
        jmode := SJIS_IN
      else if c = SS2 then begin      {SS2 は EUC で JIS X0201 仮名(1Byte)}
        Inc(index);                   {への移行を示す}
        c := Ord( s[index] );
        if (c in [$40..$7E]) or (c in [$80..$A0]) or (c in [$E0..$FC]) then
          jmode := SJIS_IN
        else if (c in [$A1..$DF]) then   {EUC JIS X0201 仮名 の可能性}
          jmode := EUCorSJIS_IN;
      end
      else if c in [$A1..$DF] then begin  {SJIS では半角かな領域}
        Inc(index);
        c := Ord( s[index] );
        if c in [$F0..$FE] then
          jmode := EUC_IN
        else if c in [$A1..$DF] then
          jmode := EUCorSJIS_IN
        else if c in [$E0..$EF] then begin
          jmode := EUCorSJIS_IN;
          while (c >= $40) and (index <= Length( s )) and (jmode = EUCorSJIS_IN) do begin
            if c >= $81 then begin
              if (c <= $8D) or ( c in [$8F..$9C]) then {EUC は A1..FF のはず}
                jmode := SJIS_IN
              else if c in [$FD..$FE] then  {SJIS では避けている領域}
                jmode := EUC_IN;
            end;
            Inc(index);
            c := ord( s[index] );
          end;
        end
        else if c <= $9F then
          jmode := SJIS_IN;
      end
      else if c in [$F0..$FE] then
        jmode := EUC_IN
      else if c in [$E0..$EF] then begin
        Inc(index);
        c := Ord( s[index] );
        if (c in [$40..$7E]) or (c in [$80..$A0]) then
          jmode := SJIS_IN
        else if c in [$FD..$FE] then
          jmode := EUC_IN
        else if c in [$A1..$FC] then
          jmode := EUCorSJIS_IN;
      end;
    end;
    Inc(index);
  end;
  Result := jmode;
end;


function ToSjis( c1,c2: Byte ): string; register;
var
  c1off,c2off: Integer;
begin
  if c1 < $5F then
    c1off := $70
  else
    c1off := $B0;
  if (c1 mod 2) <> 0 then begin
    if c2 > $5F then
      c2off := $20
    else
      c2off := $1F;
  end
  else
    c2off := $7E;
  Inc(c1);
  c1 := c1 shr 1;
  c1 := c1 + c1off;
  c2 := c2 + c2off;
  Result := Char(c1) + Char(c2);
end;


function ToJis( c1, c2: Byte ): string; register;
var
  c1off,c2off: Integer;
begin
  if c1 < 160 then
    c1off := 112
  else
    c1off := 176;
  c1 := c1 - c1off;
  c1 := c1 shl 1;

  if c2 < 159 then begin
    if c2 > 127 then begin
      c2off := 32;
    end
    else
      c2off := 31;
    Dec(c1);
  end
  else
    c2off := 126;

  c2 := c2 - c2off;
  Result := Char(c1) + Char(c2);
end;


function Hankana2Zenkana( const s: string; var index: Integer ): string;
var
  i,c: Integer;
  c2: Char;
begin
  Inc(index);
  c := Ord( s[index] );
  c := c and $7F;
  c2 := HkanaToZkana_R[c - $20];
  i := index+1;
  Result := '';
  
  case c of
    $21..$25,$30,$5E..$5F: begin {記号系}
      Result := #$21 + c2;
    end;
    $33:begin {「ヴ」対応}
      if (i <= Length(s)) and ( s[i] = Char(SS2) ) then begin
        if s[i+1] = #$DE then begin
          index := i+1;
          c2 := #$74;
        end;
      end;
    end;
    $36..$44:begin {濁点が次につく可能性のある文字}
      if (i <= Length(s)) and ( s[i] = Char(SS2) ) then begin
        if s[i+1] = #$DE then begin
          index := i+1;
          Inc(c2);
        end;
      end;
    end;
    $4A..$4E:begin {はひふへほ}
      if (i <= Length(s)) and ( s[i] = Char(SS2) ) then begin
        if s[i+1] = #$DE then begin
          index := i+1;
          Inc(c2);
        end
        else if s[i+1] = #$DF then begin  {半濁点}
          index := i+1;
          Inc(c2); Inc(c2);
        end;
      end;
    end;
  end;
  Inc(index);
  if Result = '' then Result := #$25 + c2;
end;


function Hankana2Zenkana2( const s: string; var index: Integer ): string;
var
  i,c: Integer;
  c2: Char;
begin
  c := Ord( s[index] );
  c := c and $7F;
  c2 := HkanaToZkana_R[c - $20];
  i := index+1;
  Result := '';

  case c of
    $21..$25,$30,$5E..$5F:begin {記号系}
      Result := #$21 + c2;
    end;
    $33:begin {「ヴ」対応}
      if (i <= Length(s)) and ( s[i] = #$DE ) then begin
        index := i;
        c2 := #$74;
      end;
    end;
    $36..$44:begin {濁点が次につく可能性のある文字}
      if (i <= Length(s)) and ( s[i] = #$DE ) then begin
        index := i;
        Inc(c2);
      end;
    end;
    $4A..$4E:begin {はひふへほ}
      if (i <= Length(s)) and ( (s[i] = #$DE) or (s[i] = #$DF) ) then begin
        if s[i] = #$DE then begin
          index := i;
          Inc(c2);
        end
        else if s[i] = #$DF then begin  {半濁点}
          index := i;
          Inc(c2); Inc(c2);
        end;
      end;
    end;
  end;
  Inc(index);
  if Result = '' then Result := #$25 + c2;
end;


{ JIS 1 Byte 仮名未対応}
function jis2euc( const s: string ): string;
var
  index,c: Integer;
  ki: Boolean;
begin
  index := 1;
  ki := False;
  Result := '';
  while index <= Length( s ) do begin
    c := Ord(s[index]);
    if c = ESC then begin
      Inc(index);
      c := Ord(s[index]);
      if (c = $24) then
        ki := True
      else if (c = $28) then
        ki := False;
      Inc(index);
      Inc(index);
      c := Ord(s[index]);
    end;

    if ki then begin
      if c in [$21..$7E] then
        Result := Result + Char( c or $80 )
      else
        Result := Result+Char(c and $ff);
    end
    else begin
      Result := Result+Char(c and $ff);
    end;
    Inc(index);
  end;
end;


function euc2jis83( const s: string): string;
var
  ki: Boolean;
  index,c: Integer;
  c1,c2: Char;
begin
  ki := False;
  index := 1;
  Result := '';
  while index <= Length(s) do begin
    c := Ord( s[index] );
    if (c = CR) or (c = LF) then begin
      if ki then begin
        Result := Result + KO_G0;
        ki := False;
      end;
      Result := Result + Char(c and $ff);
      Inc(index);
      Continue;
    end;
    if c > $7F then begin
      if not ki then begin
        Result := Result + KI_G0;
        ki := True;
      end;
      if c = SS2 then begin  {半角カタカナ}
        Result := Result + Hankana2Zenkana( s, index );
      end
      else begin
        c1 := Char(c and $7F);
        Inc(index);
        c := Ord(s[index] );
        c2 := Char(c and $7F);
        Result := Result + c1 + c2;
        Inc(index);
      end;
    end
    else begin
      if ki then begin
        Result := Result + KO_G0;
        ki := False;
      end;
      Result := Result + s[index];
      Inc(index);
    end;
  end;
end;


function jis2sjis( const s: string ): string;
var
  index,c: Integer;
  ki: Boolean;
  c1,c2: Byte;
begin
  index := 1;
  ki := False;
  Result := '';
  while index <= Length( s ) do begin
    c := Ord(s[index]);
    if c = ESC then begin
      Inc(index);
      c := Ord(s[index]);
      if (c = $24) then
        ki := True
      else if (c = $28) then
        ki := False;
      Inc(index);
      Inc(index);
      c := Ord(s[index])
    end;

    if ki then begin
      c1 := c;
      Inc(index);
      c2 := Ord(s[index]);
      Result := Result + ToSjis(c1,c2);
    end
    else begin
      Result := Result+Char(c and $ff);
    end;
    Inc(index);
  end;
end;


function euc2sjis( const s: string ): string;
var
  index,c: Integer;
  c1,c2: Byte;
begin
  index := 1;
  Result := '';
  while index <= Length(s) do begin
    c := Ord(s[index]);
    if (c > $80) and ( c < $FF ) then begin
      if c = SS2 then begin
        Inc(index);
        c := Ord(s[index]);
        Result := Result + Char(c and $FF);
      end
      else begin
        c1 := Ord(s[index]);
        c1 := c1 and $7F;
        Inc(index);
        c2 := Ord(s[index]);
        c2 := c2 and $7F;
        Result := Result + ToSjis(c1,c2);
      end;
    end
    else begin
      Result := Result+Char(c and $ff);
    end;
    Inc(index);
  end;
end;


function sjis2jis83( const s: string ): string;
var
  ki: Boolean;
  index,c: Integer;
  c1,c2: Byte;
begin
  ki := False;
  index := 1;
  Result := '';
  while index <= Length(s) do begin
    c := Ord( s[index] );
    if (c = CR) or (c = LF) then begin
      if ki then begin
        Result := Result + KO_G0;
        ki := False;
      end;
      Result := Result + Char(c and $ff);
      Inc(index);
      Continue;
    end;
    if c > $7F then begin
      if not ki then begin
        Result := Result + KI_G0;
        ki := True;
      end;
      if c in [$A1..$DF] then begin  {半角カタカナ}
        Result := Result + Hankana2Zenkana2( s,index)
      end
      else begin
        c1 := c and $FF;
        Inc(index);
        c2 := Ord(s[index] );
        Result := Result + ToJis( c1, c2 );
        Inc(index);
      end;
    end
    else begin
      if ki then begin
        Result := Result + KO_G0;
        ki := False;
      end;
      Result := Result + s[index];
      Inc(index);
    end;
  end;
end;


function sjis2euc( const s: string ): string;
var
  index,c: Integer;
  c1,c2: Byte;
  zen: string;
begin
  index := 1;
  Result := '';
  while index <= Length(s) do begin
    c := Ord( s[index] );
    if c > $7F then begin
      if c in [$A1..$DF] then begin  {半角カタカナ}
        Result := Result + Char(SS2) + Char(c and $FF);
      end
      else begin
        c1 := c;
        Inc(index);
        c2 := Ord(s[index]);
        zen := ToJis( c1, c2 );
        c1 := Byte(zen[1]) or $80;
        c2 := Byte(zen[2]) or $80;
        Result := Result + Char(c1) + Char(c2);
      end;
    end
    else begin
      Result := Result + s[index];
    end;
    Inc(index);
  end;
end;



function UniLETosjis(const s: PWideChar): string;
begin
  Result := WideCharToString(s);
end;

function UniBETosjis(const s: PWideChar): string;
var
  Pc: PChar;
  c: char;
  n: integer;
begin
  Pc := PChar(s);
  n := 0;
  while True do
  begin
//    if Assigned(Pc[n+1]) then Break;
    if (Pc[n] = #0) and (Pc[n+1] = #0) then
      Break;
    c := Pc[n];
    Pc[n] := Pc[n+1];
    Pc[n+1] := c;
    Inc(n, 2);
  end;
  Result := WideCharToString(PWideChar(Pc));
end;

procedure sjisToUniLE(var ms: TMemoryStream; const s: string);
var
  PWs: PWideChar;
  Len: integer;
begin
  if not Assigned(ms) then
    raise Exception.Create('無効なMemoryStream.');
  Len := Length(s) * 2;
  PWs := AllocMem(Len + 2);
  try
    StringToWideChar(s, PWs, Len);
    ms.Write(#$FF#$FE, 2);
    ms.Write(PWs^, Length(Pws) * 2);
  finally
    FreeMem(PWs);
  end;
end;

procedure sjisToUniBE(var ms: TMemoryStream; const s: string);
var
  PWs: PWideChar;
  Pc: PChar;
  len, n: integer;
  Tc: Char;
begin
  if not Assigned(ms) then
    raise Exception.Create('無効なMemoryStream.');
  Len := Length(s) * 2;
  PWs := AllocMem(Len + 2);
  try
    StringToWideChar(s, PWs, Len);
    Pc := PChar(PWs);
    n := 0;
    while n < len do
    begin
      Tc := (Pc+n)^;
      (Pc+n)^ := (Pc+n+1)^;
      (Pc+n+1)^ := Tc;
      Inc(n, 2);
    end;
    ms.Write(#$FE#$FF, 2);
    ms.Write(PWs^, Length(Pws) * 2);
  finally
    FreeMem(PWs);
  end;
end;

function Utf8NTosjis(const s: string): string;
var
  Len: integer;
  OutStr: PWideChar;
  SIn, SOut: string;
begin
  Result := '';
  // ゴミ防止
  SIn := S + #0#0;
  Len := MultiByteToWideChar(CP_UTF8, 0, PChar(SIn), Length(SIn), nil, 0);
  if Len = 0 then
    raise Exception.Create('UTF8の文字列変換に失敗しました.');
  // Lenで良いはずだが、なぜかエラーとなるため２倍
  OutStr := AllocMem(Len * 2);
  try
    MultiByteToWideChar(CP_UTF8, 0, PChar(SIn), Length(SIn), OutStr, Len);
    WideCharToStrVar(OutStr, SOut);
    Result := SOut;
  finally
    FreeMem(OutStr);
  end;
end;

function Utf8Tosjis(const s: string): string;
var
  s2: string;
begin
  s2 := s;
  Delete(s2, 1, 3);
  Result := Utf8NTosjis(s2);
end;

function SjisToUtf8N(const s: string): string;
var
  Len: integer;
  InStr: PWideChar;
  OutStr: PChar;
begin
  Result := '';
  Len := Length(s) * 2 + 2;
  InStr := AllocMem(Len);
  try
    StringToWideChar(s, InStr, Len);
    OutStr := AllocMem(Len);
    try
      WideCharToMultiByte(CP_UTF8, 0, InStr, -1, OutStr, Len, nil, nil);
//      WideCharToMultiByte(CP_UTF8, 0, InStr, Length(InStr) * 2, OutStr, Len, nil, nil);
      Result := OutStr;
    finally
      FreeMem(OutStr);
    end;
  finally
    FreeMem(InStr);
  end;
end;

function SjisToUtf8(const s: string): string;
begin
  Result := #$EF#$BB#$BF + SjisToUtf8N(s);
end;

function ConvertJCode( s: string; outcode: Integer ): string;
var
  incode: Integer;
  ms: TMemoryStream;
  sl: TStringList;
begin
  incode := InCodeCheckEx( s );
  if (incode <= BINARY ) or ( incode = outcode ) or (incode = EUCorSJIS_IN) then begin
    Result := s;
    Exit;
  end;
  ms := TMemoryStream.Create;
  sl := TStringList.Create;
  Result := '';
  try
    case outcode of
      JIS_OUT:begin
        case incode of
          JIS83_IN..JIS78_IN: Result := s;
          EUC_IN:   Result := euc2jis83( s );
          SJIS_IN:  Result := sjis2jis83( s );
        end;
      end;
      EUC_OUT:begin
        case incode of
          JIS83_IN..JIS78_IN: Result := jis2euc( s );
          SJIS_IN: Result := sjis2euc( s );
        end;
      end;
      SJIS_OUT:begin
        case incode of
          JIS83_IN..JIS78_IN: Result := jis2sjis( s );
          EUC_IN: Result := euc2sjis( s );
  //        UNILE_IN: Result := uniLETosjis( PWideChar(s) );
  //        UNIBE_IN: Result := uniBETosjis( PWideChar(s) );
          UTF8_IN:  Result := Utf8Tosjis( s );
          UTF8N_IN: Result := Utf8NTosjis( s );
        end;
      end;
  //    UNILE_OUT: begin
  //      sjisToUniLE(ms, s);
  //      sl.LoadFromStream(ms);
  //      Result := sl.Text;
  //    end;
  //    UNIBE_OUT: begin
  //      sjisToUniBE(ms, s);
  //      sl.LoadFromStream(ms);
  //      Result := sl.Text;
  //    end;
      UTF8_OUT: Result := sjisToUtf8( s );
      UTF8N_OUT:Result := sjisToUtf8N( s );
      else
        Result := s;
    end;
  finally
    sl.Free;
    ms.Free;
  end;  
end;


function StrictConvertJCode( s: string; incode,outcode: Integer ): string;
begin
  if (incode <= BINARY ) or ( incode = outcode ) or (incode = EUCorSJIS_IN) then begin
    Result := s;
    Exit;
  end;
  Result := '';
  case outcode of
    JIS_OUT:begin
      case incode of
        JIS83_IN..JIS78_IN: Result := s;
        EUC_IN:   Result := euc2jis83( s );
        SJIS_IN:  Result := sjis2jis83( s );
      end;
    end;
    EUC_OUT:begin
      case incode of
        JIS83_IN..JIS78_IN: Result := jis2euc( s );
        SJIS_IN: Result := sjis2euc( s );
      end;
    end;
    SJIS_OUT:begin
      case incode of
        JIS83_IN..JIS78_IN: Result := jis2sjis( s );
        EUC_IN: Result := euc2sjis( s );
      end;
    end;
    else
      Result := s;
  end;
end;


function ReturnCodeCheck( const s: string ): Integer;
var
  index: Integer;
  c:     char;
begin
  index := 1;
  c := #0;
  Result := 0;
  while (c <> #13) and (c <> #10) and (index <= Length(s)) do
  begin
    c := s[index];
    Inc(index);
  end;

  if c = #10 then
    Result := LF_R
  else if c = #13 then
  begin
    if Length(s) = index-1 then
      Result := CR_R
    else if s[index] = #10 then
      Result := CRLF_R
    else
      Result := CR_R;
  end;
end;


function ConvertReturnCode( s: string; rcode: Integer ): string;
var
  index, rcode_in: Integer;
  RCodeStr, RCodeStr_in: string;
begin
  rcode_in := ReturnCodeCheck( s );
  if (rcode_in = 0) or (rcode_in = rcode) then begin {改行無しテキスト or}
    Result := s;
    Exit;
  end
  else begin
    case rcode_in of
      CRLF_R: RCodeStr_in := #13#10;
      CR_R: RCodeStr_in := #13;
      LF_R: RCodeStr_in := #10;
    end;
    case rcode of
      CRLF_R: RCodeStr := #13#10;
      CR_R: RCodeStr := #13;
      LF_R: RCodeStr := #10;
    end;
  end;
  Result := '';
  index := 1;
  while index <= Length(s) do
  begin
    if s[index] = RCodeStr_in[1] then
    begin
      Delete(s, index, Length(RCodeStr_in));
      Insert(RCodeStr, s, index);
      index := index + Length(RCodeStr);
    end
    else
      Inc(index);
  end;
  Result := s;
end;


function StrictConvertReturnCode( s: string; rcode_in, rcode: Integer ): string;
var
  index: Integer;
  RCodeStr, RCodeStr_in: string;
begin
  if (rcode_in = 0) or (rcode_in = rcode) then begin {改行無しテキスト or}
    Result := s;
    Exit;
  end
  else begin
    case rcode_in of
      CRLF_R: RCodeStr_in := #13#10;
      CR_R: RCodeStr_in := #13;
      LF_R: RCodeStr_in := #10;
    end;
    case rcode of
      CRLF_R: RCodeStr := #13#10;
      CR_R: RCodeStr := #13;
      LF_R: RCodeStr := #10;
    end;
  end;
  Result := '';
  index := 1;
  while index <= Length(s) do
  begin
    if s[index] = RCodeStr_in[1] then
    begin
      Delete(s, index, Length(RCodeStr_in));
      Insert(RCodeStr, s, index);
      index := index + Length(RCodeStr);
    end
    else
      Inc(index);
  end;
  Result := s;
end;

{ここからはおまけ}


{Base64 エンコード。77文字以上の改行規則に未対応 :98/08/21}
{98/11/25: テーブル形式の変更に併せて修正。string -> PChar により Code64 }
{          が Zero origin に。}
function EncodeBase64( const input: string ): string;
var
  i,j,iLen: Integer;
  a,b,c: BYTE;
begin
  Result := '';
  
  //エンコード後の大きさを計算
  iLen := Length(input);
  i := iLen mod 3;
  if i <> 0 then i := 4;
  SetLength( Result, ( iLen div 3 ) * 4 + i);
  
  i:=1; j:=1;
  while i <= iLen -2 do begin
    a := BYTE(input[i]); b:= BYTE(input[i+1]); c := BYTE(input[i+2]);
    Result[j] := Code64[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := Code64[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := Code64[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    Result[j] := Code64[ (c and $3F) ]; Inc(j);
    i := i + 3;
  end;
  if (iLen mod 3) = 1 then begin
    a := BYTE(input[iLen]); b:=0;
    Result[j] := Code64[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := Code64[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := '='; Inc(j);
    Result[j] := '=';
  end
  else if (iLen mod 3) = 2 then begin
    a := BYTE(input[iLen -1]); b := BYTE(input[iLen]); c := 0;
    Result[j] := Code64[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := Code64[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := Code64[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    Result[j] := '=';
  end;
end;


{Base64 エンコード。77文字以上の改行規則に対応 :98/11/23}
{Rcode には任意の改行コードをセット。ex #$0D#0A}
{98/11/25: テーブル形式の変更に併せて修正。string -> PChar により Code64 }
{          が Zero origin に。}
function EncodeBase64R( const input: string; Rcode: string ): string;
var
  i,j,k,l,iLen: Integer;
  a,b,c: BYTE;
begin
  Result := '';
  
  //エンコード後の大きさを計算
  iLen := Length(input);
  i := iLen mod 3;
  if i <> 0 then i := 4;
  i := i + ((( iLen div 3 ) * 4) div 76) * Length(Rcode);
  SetLength( Result, ( iLen div 3 ) * 4 + i);

  i:=1; j:=1; k:=0;
  while i <= iLen -2 do begin
    a := BYTE(input[i]); b:= BYTE(input[i+1]); c := BYTE(input[i+2]);
    Result[j] := Code64[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := Code64[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := Code64[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    Result[j] := Code64[ (c and $3F) ]; Inc(j);
    i := i + 3;
    k := k + 4;
    if k = 76 then begin
      for l:=1 to Length(Rcode) do begin
        Result[j] := Rcode[l]; Inc(j);
      end;
      k := 0;
    end;
  end;
  if (iLen mod 3) = 1 then begin
    a := BYTE(input[iLen]); b:=0;
    Result[j] := Code64[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := Code64[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := '='; Inc(j);
    Result[j] := '=';
  end
  else if (iLen mod 3) = 2 then begin
    a := BYTE(input[iLen -1]); b := BYTE(input[iLen]); c := 0;
    Result[j] := Code64[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := Code64[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := Code64[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    Result[j] := '=';
  end;
end;


{uuencode: 98/11/25}
{Rcode には任意の改行コードをセット。ex #$0D#0A}
{先頭の begin 644 hogehoge.xxx と末尾の end は呼び出し側が処理後にどうにかする}
{ちなみに 644 は UNIX で言うところのファイルパーミッション }
function EncodeUU( const input: string; Rcode: string ): string;
var
  i,j,k,l,m,iLen: Integer;
  a,b,c: BYTE;
begin
  Result := '';

  //エンコード後の大きさを計算
  iLen := (Length(input) div 3) * 4;
  m := iLen div 60;
  i := Length(input) mod 3;
  if i <> 0 then iLen := iLen + 4;
  i := m * ( Length(RCode) + 1) + Length(Rcode) * 2 +1 +1;
  SetLength( Result, iLen + i);

  iLen := Length(input);
  i:=1; j:=1; k:=0;
  while i <= iLen -2 do begin
    a := BYTE(input[i]); b:= BYTE(input[i+1]); c := BYTE(input[i+2]);
    if (k = 0) and (m <> 0) then begin
      Result[j] := 'M'; Inc(j);
    end
    else if k=0 then begin
      Result[j] := Char(iLen - i +1 + $20); Inc(j);
    end;
    Result[j] := CodeUU[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := CodeUU[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := CodeUU[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    Result[j] := CodeUU[ (c and $3F) ]; Inc(j);
    i := i + 3;
    k := k + 4;

    if (k = 60) and (m <> 0) then begin
      for l:=1 to Length(Rcode) do begin
        Result[j] := Rcode[l]; Inc(j);
      end;
      Dec(m);
      k := 0;
    end;
  end;

  if (iLen mod 3) = 1 then begin
    a := BYTE(input[iLen]); b:=0;
    Result[j] := CodeUU[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := CodeUU[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := CodeUU[0]; Inc(j);
    Result[j] := CodeUU[0]; Inc(j);
  end
  else if (iLen mod 3) = 2 then begin
    a := BYTE(input[iLen -1]); b := BYTE(input[iLen]); c := 0;
    Result[j] := CodeUU[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := CodeUU[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := CodeUU[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    Result[j] := CodeUU[0]; Inc(j);
  end;

  k := 1;
  while k <= Length(Rcode) * 2 +1 do begin
    for l:=1 to Length(Rcode) do begin
      Result[j] := Rcode[l]; Inc(j);
    end;
    k := k + Length(Rcode);
    if k = Length(RCode) +1 then
      Result[j] := '`'; Inc(j); Inc(k);
  end;

end;


{BinHex 4.0(Hqx7?) エンコード :98/11/27}
{Rcode には任意の改行コードをセット。ex #$0D#0A}
{(This file must be converted with BinHex 4.0) という先頭の文字列は}
{呼び出し側がどうにかする}
function EncodeBinHex( const input: string; Rcode: string ): string;
var
  i,j,k,l,iLen: Integer;
  a,b,c: BYTE;
begin
  Result := '';

  //エンコード後の大きさを計算
  iLen := (Length(input) div 3) * 4;
  i := iLen mod 3;
  if i <> 0 then Inc(i);
  iLen := iLen + i +2;  // +2 始終端記号
  iLen := iLen + (iLen div 64) * Length(Rcode); // 始終端記号と改行コード分
  SetLength( Result, iLen );
  
  iLen := Length(input);
  i:=1; j:=2; k:=1;
  Result[1] := ':';
  while i <= iLen -2 do begin
    a := BYTE(input[i]); b:= BYTE(input[i+1]); c := BYTE(input[i+2]);

    Result[j] := CodeBinHex[ ((a and $FC) shr 2) ]; Inc(j);
    Result[j] := CodeBinHex[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    Result[j] := CodeBinHex[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
    k := k + 3;
    if k = 64 then begin
      for l:=1 to Length(Rcode) do begin
        Result[j] := Rcode[l]; Inc(j);
      end;
      k := 0;
    end;
    Result[j] := CodeBinHex[ (c and $3F) ]; Inc(j); Inc(k);
    i := i + 3;
  end;

  if (iLen mod 3) <> 0 then begin
    if (iLen mod 3) = 1 then begin
      a := BYTE(input[iLen]); b:=0;
      Result[j] := CodeBinHex[ ((a and $FC) shr 2) ]; Inc(j);
      Result[j] := CodeBinHex[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
    end
    else if (iLen mod 3) = 2 then begin
      a := BYTE(input[iLen -1]); b := BYTE(input[iLen]); c := 0;
      Result[j] := CodeBinHex[ ((a and $FC) shr 2) ]; Inc(j);
      Result[j] := CodeBinHex[ ( ((a and $03) shl 4) or ((b and $F0) shr 4) ) ]; Inc(j);
      Result[j] := CodeBinHex[ ( ((b and $0F) shl 2) or ((c and $C0) shr 6) ) ]; Inc(j);
      if k = 64 then begin
        for l:=1 to Length(Rcode) do begin
          Result[j] := Rcode[l]; Inc(j);
        end;
      end;
    end;
  end;
  Result[j] := ':';
end;


{Base64 デコード: 98/11/23}
function DecodeBase64( const input: string ): string;
var
  i,j,k,iLen: Integer;
  dbuf: array[0..3] of BYTE;
begin

  iLen := Length( input );
  Result := '';

  //デコード後の大きさを計算
  j := 0;
  for i:=1 to iLen do begin
    if (input[i] = #$0D) or (input[i] = #$0A) or (input[i] = '=') then
      Inc(j);
  end;
  iLen := iLen -j;
  i :=  iLen mod 4;
  if i <> 0 then Dec(i);
  iLen := (iLen div 4) * 3 +i;
  SetLength( Result, iLen); //高速化のため

  iLen := Length( input );
  i := 1;
  k := 1;
  while i <= iLen do begin
    if (input[i] = #$0D) or (input[i] = #$0A) then begin
      Inc(i);
      Continue;
    end;
    for j:=0 to 3 do begin
      case (input[i]) of
        'A'..'Z': dbuf[j] := BYTE(input[i]) - $41;
        'a'..'z': dbuf[j] := BYTE(input[i]) - $47;
        '0'..'9': dbuf[j] := BYTE(input[i]) + 4;
        '+'     : dbuf[j] := 62;
        '/'     : dbuf[j] := 63;
        '='     : dbuf[j] := $FF;
      end;
      Inc(i);
    end;
    
    if dbuf[2] = $FF then begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) );
    end
    else if dbuf[3] = $FF then begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) ); Inc(k);
      Result[k] := Char( (dbuf[1] shl 4) or (dbuf[2] shr 2) );
    end
    else begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) ); Inc(k);
      Result[k] := Char( (dbuf[1] shl 4) or (dbuf[2] shr 2) ); Inc(k);
      Result[k] := Char( (dbuf[2] shl 6) or dbuf[3] );
    end;
    Inc(k);
  end;
end;


{uudecode: 98/11/25}
{begin 644 hogehoge.xxx と末尾の endで挟まれた生の uuencode data を渡すこと}
{最後は改行で終わっていてもいなくてもいい}
function DecodeUU( const input: string ): string;
var
  i,j,k,iLen: Integer;
  dLen: Integer;
  dbuf: array[0..3] of BYTE;
begin

  iLen := Length( input );
  Result := '';

  //デコード後の大きさを計算
  j := 0; i := 1;
  while i <=iLen do begin
    if (input[i] = #$0D) or (input[i] = #$0A) then begin
      Inc(i);
      Continue;
    end;
    dLen := Ord(input[i]);
    if dLen = $4D then begin
      j := j + 45;
      i := i + 61;
    end 
    else begin
      j := j + dLen - $20;
      Break;
    end;
  end;
  SetLength( Result, j); //高速化のため
  
  i := 1;
  k := 1;
  dLen := 0;
  while i <= iLen do begin
    if (input[i] = #$0D) or (input[i] = #$0A) then begin
      Inc(i);
      dLen := 0;
      Continue;
    end;
    if dLen = 0 then begin
      dLen := Ord(input[i]) -$20; Inc(i);
      Continue;; // 終端 '`' の可能性がある為
    end;

    for j:=0 to 3 do begin
      if input[i] = '`' then
        dbuf[j] := 0
      else
        dbuf[j] := BYTE(input[i]) - $20;
      Inc(i);
    end;
    
    if dLen <= 1 then begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) );
    end
    else if dLen <=2  then begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) ); Inc(k);
      Result[k] := Char( (dbuf[1] shl 4) or (dbuf[2] shr 2) );
    end
    else begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) ); Inc(k);
      Result[k] := Char( (dbuf[1] shl 4) or (dbuf[2] shr 2) ); Inc(k);
      Result[k] := Char( (dbuf[2] shl 6) or dbuf[3] );
    end;
    Inc(k);
    dLen := dLen -3;
  end;

end;


{BinHex 4.0(Hqx7?) デコード :98/11/27}
{':'と':'で囲まれたデータを渡す}
function DecodeBinHex( const input: string ): string;
var
  i,j,k,iLen: Integer;
  dbuf: array[0..3] of BYTE;
begin
  iLen := Length( input );
  Result := '';

  //デコード後の大きさを計算
  j := 0;
  for i:=1 to iLen do begin
    if (input[i] = #$0D) or (input[i] = #$0A) then begin
      Inc(j);
    end;
  end;
  iLen := iLen -j -2;
  i := iLen mod 4;
  if i <> 0 then Dec(i);
  iLen := (iLen div 4) * 3 + i;
  SetLength( Result, iLen); //高速化のため
  
  iLen := Length( input );
  i := 2;
  k := 1;
  while i <= iLen do begin
    dbuf[0] := DecBinHex[ Ord(input[i]) -$21]; Inc(i);
    if dbuf[0] = $FF then Break;
    dbuf[1] := DecBinHex[ Ord(input[i]) -$21]; Inc(i);
    dbuf[2] := DecBinHex[ Ord(input[i]) -$21]; Inc(i);
    if (input[i] = #$0D) or (input[i] = #$0A) then begin // 改行の可能性
      Inc(i);
      if input[i] = #$0A then Inc(i);
    end;

    dbuf[3] := DecBinHex[ Ord(input[i]) -$21]; Inc(i);
    
    if dbuf[2] = $FF then begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) );
      Break;
    end
    else if dbuf[3] = $FF then begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) ); Inc(k);
      Result[k] := Char( (dbuf[1] shl 4) or (dbuf[2] shr 2) );
      Break;
    end
    else begin
      Result[k] := Char( (dbuf[0] shl 2) or (dbuf[1] shr 4) ); Inc(k);
      Result[k] := Char( (dbuf[1] shl 4) or (dbuf[2] shr 2) ); Inc(k);
      Result[k] := Char( (dbuf[2] shl 6) or dbuf[3] );
    end;
    Inc(k);
  end;
end;


{メールのサブジェクトとかに入れる文字列の作成。=?ISO-2022-JP?B?ってやつ}
{77文字以上のマルチライン化に未対応}
{入力文字列は SJIS 限定。IsDBCSLeadByteを使ってるから}
function CreateHeaderString( const s: string): string;
var
  HanBuf,ZenBuf: string;  // 半角文字バッファ、全角文字バッファ
  cnt: Integer;
  ZenFlg: Boolean;        // マルチバイト文字（全角）を処理していたかどうか
begin
  Result := '';
  cnt := 1;
  ZenFlg := False;
  while cnt <= Length(s) do begin
    if IsDBCSLeadByte( BYTE(s[cnt]) ) then begin
      if not ZenFlg then begin
        if HanBuf <> '' then begin
          Result := Result + HanBuf;
          HanBuf := '';
        end;
      end;
      ZenBuf := ZenBuf + s[cnt] + s[cnt+1];
      ZenFlg := True;
      Inc( cnt );
    end
    else begin
      if ZenFlg then begin
        if ZenBuf <> '' then begin
          Result := Result + '=?ISO-2022-JP?B?'
                    + EncodeBase64( sjis2jis83(ZenBuf) ) +'?=';
          ZenBuf := '';
        end;
      end;
      HanBuf := HanBuf + s[cnt];
      ZenFlg := False;
    end;
    Inc( cnt );
  end;
  if ZenFlg then begin
    Result := Result + '=?ISO-2022-JP?B?'
              + EncodeBase64( sjis2jis83(ZenBuf) ) +'?=';
    ZenBuf := '';
  end
  else if HanBuf <> '' then begin
    Result := Result + HanBuf;
  end;
end;


{MIME Header =?ISO-2022-JP?B? 形式のデコード。:98/11/23}
{マルチラインに未対応。一行ごとに渡せば OK だろう}
{  戻り値： ISO-2022-JP のはず }
function DecodeHeaderString( const s: string): string;
var
  i,j: Integer;
  buf,temp: string;

begin
  Result := s;
  buf := UpperCase( s );

  i := Pos('=?ISO-2022-JP?B?', buf);
  while i > 0 do begin
    System.Delete( buf, i, 16 );
    System.Delete( Result, i, 16 );
    j := Pos('?=', Result);
    if j > 0 then begin
      temp := Copy( Result, i, j-i);
      System.Delete( buf, i, j-i+2 );
      System.Delete( Result, i, j-i+2 );
      temp := DecodeBase64( temp );
      System.Insert( temp+KO_G0, Result, i );
      System.Insert( temp+KO_G0, buf, i );
    end;
    i := Pos('=?ISO-2022-JP?B?', buf);
  end;

end;

// 拡張文字コードチェック
// UNICODEとUTF8をチェックし、そのどれらでもなかった場合には
// jconvertのInCodeCheckを戻り値にする
function InCodeCheckEx(const s: string): integer;
var
  index, c, size: Integer;
  utfk: Boolean;
begin
  size := Length(s);
  { Size = 0 }
  if size = 0 then
  begin
    Result := BINARY;
    Exit;
  end;
  { Unicodeをチェックする }
  { 先頭のBOMしかチェックしていないので誤作動の可能性あり }
  if (size >= 2 ) then
  begin
    { UNICODE(Little Endian)チェック }
    if (s[1] = #$FF) and (s[2] = #$FE) then
    begin
      Result := UNILE_IN;
      Exit;
    end;
    { UNICODE(Big Endian)チェック }
    if (s[1] = #$FE) and (s[2] = #$FF) then
    begin
      Result := UNIBE_IN;
      Exit;
    end;
  end;
  { UTF-8をチェックする }
  if size > 3 then
  begin
    { UTF-8N(BOMあり)チェック }
    { 先頭のBOMしかチェックしていないので誤作動の可能性あり }
    if (s[1] = #$EF) and (s[2] = #$BB) and (s[3] = #$BF) then
    begin
      Result := UTF8_IN;
      Exit;
    end;
  end;
  {UTF-8(BOMなし)チェック}
  index := 1;
  utfk := False;
  while (index <= STRICT_CHECK_LEN) and (index < size - 4) do
  begin
    c := Ord(s[index]);
    if (c in [$C0..$DF]) or (c > $EF) then
    begin
      utfk := False;
      Break;
    end;
    if c in [0..$7F] then
    begin
      ;
    end else if c = $E0 then
    begin
      Inc(index);
      c := Ord(s[index]);
      if c in [$A0..$BF] then
      begin
        Inc(index);
        c := Ord(s[index]);
        if c in [$80..$BF] then
          utfk := True
        else begin
          utfk := False;
          Break;
        end;
      end else begin
        utfk := False;
        Break;
      end;
    end else if c in [$E1..$EF] then
    begin
      Inc(index);
      c := Ord(s[index]);
      if c in [$80..$BF] then
      begin
        Inc(index);
        c := Ord(s[index]);
        if c in [$80..$BF] then
          utfk := True
        else begin
          utfk := False;
          Break;
        end;
      end else begin
        utfk := False;
        Break;
      end;
    end else begin
      utfk := False;
      Break;
    end;
    Inc(index);
  end;
  { 漢字があったらUTF }
  if utfk then
    Result := UTF8N_IN
  { UnicdeでもUTF8でもなければJconvertでチェック }
  else
    Result := InCodeCheck(s);
end;

end.