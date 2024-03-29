unit yhOthers;

interface


uses
  Windows, SysUtils, Classes, Forms, StdCtrls, Controls, CommCtrl, Menus,
  Messages, bmRegExp, Registry;

{ 文字列 }
function IntToBool(Int: Integer): Boolean;
function BoolToInt(Bool: Boolean): Integer;
//正規表現にマッチするか
function IsRegMatch(reg, text: string; useFuzzy: Boolean = True;
  useSynony: Boolean = False): Boolean;     
//正規表現のメタ文字をエスケープする
function EscapeReg(reg: string): string;
//２バイト文字が含まれる文字列か
function IsIncludeMultiByte(s: string): Boolean;
//Byte分の文字列を返す、２バイト文字の前半が残ったら消す
function GetFixedWordLength(const Text: string; Byte: Cardinal; Dot: Boolean = False): string;
//数値を３桁ごとに区切る関数
function SplitDigit(S : String) : String ;
//暗号化
function Encryption(const s:String;decode:Boolean):string;

{ フォーム }      
procedure GetHotKeyFromShortCut(ShortCut: TShortCut; var fsModifiers, vk: UINT);
//ショートカットキーをフックしたか
function IsHookShortCut(Msg: TMsg; ShortCut: TShortCut): Boolean;
//ショートカットキー処理
procedure ShortCutEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
//ツールバーの固定表示にします。
procedure FixToolBars(Handle: HWND; IsFix: Boolean);
//rのエリア内にpが含まれるかどうか
function IncludeRect(r: TRect; p: TPoint): Boolean;
//フォームを常に手前に表示させる
procedure StayOnTop(Handle: HWND; IsTop: Boolean);
procedure InvalidateEx(Handle: HWND);
//コントロールの中心にマウスカーソルを合わせる
procedure SetMouseCursor(Ctrl: TControl);
//フォームを常に手前に表示させる
//  function StayOnTop(const hWnd: HWND): Boolean;
//アプリがデスクトップのワークエリア内にあるか。無かったらエリア内に移動
procedure OnWorkArea(Ctrl: TControl); overload;
procedure OnWorkArea(var Rect: TRect); overload;
//  procedure OnWorkArea(Form: TForm);
//ダブルクリック幅 ：ダブルクリックにおける 2回目のクリック位置の許容範囲の幅を取得
function GetDoubleClickWidth: Integer;
//ダブルクリック高さ　：ダブルクリックにおける ２回目のクリック位置の許容範囲の高さを取得
function GetDoubleClickHeight: Integer;

implementation

uses Types;

 
function EscapeReg(reg: string): string;
begin
  Result := reg;
  Result := StringReplace(Result, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '*', '\*', [rfReplaceAll]);
  Result := StringReplace(Result, '+', '\+', [rfReplaceAll]);
  Result := StringReplace(Result, '.', '\.', [rfReplaceAll]);
  Result := StringReplace(Result, '?', '\?', [rfReplaceAll]);
  Result := StringReplace(Result, '{', '\[', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '\}', [rfReplaceAll]);
  Result := StringReplace(Result, '(', '\(', [rfReplaceAll]);
  Result := StringReplace(Result, ')', '\)', [rfReplaceAll]);
  Result := StringReplace(Result, '[', '\[', [rfReplaceAll]);
  Result := StringReplace(Result, ']', '\]', [rfReplaceAll]);
  Result := StringReplace(Result, '^', '\^', [rfReplaceAll]);
  Result := StringReplace(Result, '$', '\$', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '\-', [rfReplaceAll]);
  Result := StringReplace(Result, '|', '\|', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '\/', [rfReplaceAll]);
end;

function GetDoubleClickWidth: Integer;
var reg: TRegistry; //Registry追加
begin
  Result := 4; //デフォルトの4を指定
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if not reg.OpenKey('Control Panel\Mouse', False) then Exit;
    Result := StrToIntDef(reg.ReadString('DoubleClickWidth'), 4);
  finally
    reg.Free;
  end;
end;

function GetDoubleClickHeight: Integer; 
var reg: TRegistry; //Registry追加
begin      
  Result := 4; //デフォルトの4を指定
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if not reg.OpenKey('Control Panel\Mouse', False) then Exit;
    Result := StrToIntDef(reg.ReadString('DoubleClickHeight'), 4);
  finally
    reg.Free;
  end;
end;

function IsRegMatch(reg, text: string; useFuzzy, useSynony: Boolean): Boolean;
var awk: TAWKStr; rs,rl: Integer;
begin
//  Result := False;
  awk := TAWKStr.Create(nil);
  try
    awk.RegExp := reg;
    awk.UseFuzzyCharDic := useFuzzy;   
    awk.UseSynonymDic := useSynony;
    Result := awk.Match(text, rs, rl) <> 0;
  finally
    awk.Free;
  end;
end;

procedure GetHotKeyFromShortCut(ShortCut: TShortCut; var fsModifiers, vk: UINT);
var
//  IsCtrl : Boolean;
//  IsAlt  : Boolean;
//  IsShift: Boolean;
  IncCtrl, IncAlt, IncShift: Boolean;
  sc: TShortCut;
begin    
  IncCtrl  := (ShortCut and scCtrl) <> 0;
  IncAlt   := (ShortCut and scAlt) <> 0;
  IncShift := (ShortCut and scShift) <> 0;
  sc := ShortCut;
  fsModifiers := 0;
  if IncCtrl  then begin
    sc := sc - scCtrl;
    fsModifiers := fsModifiers or MOD_CONTROL;
  end;
  if IncAlt   then begin
    sc := sc - scAlt; 
    fsModifiers := fsModifiers or MOD_ALT;
  end;
  if IncShift then begin
    sc := sc - scShift;  
    fsModifiers := fsModifiers or MOD_SHIFT;
  end;
  vk := sc;
end;

function IsHookShortCut(Msg: TMsg; ShortCut: TShortCut): Boolean;
var
  IsCtrl : Boolean;
  IsAlt  : Boolean;
  IsShift: Boolean;
  IncCtrl, IncAlt, IncShift: Boolean;
  IsDown : Boolean;
//  IsDisp : Boolean;
  sc: TShortCut;
begin
  Result := False;
  if ShortCut = 0 then Exit;
  IsDown :=(msg.LParam and (1 shl 31))=0;
  if IsDown then begin
    IsCtrl :=(GetKeyState(VK_CONTROL) and (1 shl 15))<>0;
    IsAlt  :=(msg.LParam              and (1 shl 29))<>0;
    IsShift:=(GetKeyState(VK_SHIFT)   and (1 shl 15))<>0;
//    if IsShift then beep;
//    if IsCtrl then beep;
//    if IsAlt then beep;
    IncCtrl  := (ShortCut and scCtrl) <> 0;
    IncAlt   := (ShortCut and scAlt) <> 0;
    IncShift := (ShortCut and scShift) <> 0;
    sc := ShortCut;
    if IncCtrl  then sc := sc - scCtrl;
    if IncAlt   then sc := sc - scAlt;
    if IncShift then sc := sc - scShift;
    if (IsCtrl = IncCtrl) and (IsAlt = IncAlt) and (IsShift = IncShift) then begin
      if Msg.wParam = Integer(sc) then begin
        Result := True;;
      end;
    end;
  end;
end;

procedure ShortCutEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s, k: string;
begin
  if (Key >= 8) and (Key <= 255) then begin
    s := '';
    if ssShift in Shift then s := s + 'Shift+';
    if ssCtrl in Shift then s := s + 'Ctrl+';
    if ssAlt in Shift then s := s + 'Alt+'; 
    k := ShortCutToText(Key);
//    k := IntToStr(Key);
    TEdit(Sender).Text := s + k;
    Key := 0;
  end;
end;

procedure FixToolBars(Handle: HWND; IsFix: Boolean);
var
  bandInfo: TReBarBandInfo;
  barcnt, i: Integer;
begin
  ZeroMemory(@bandInfo, SizeOf(bandInfo));
  bandInfo.cbSize := SizeOf(bandInfo);
  bandInfo.fMask := RBBIM_ID or RBBIM_SIZE or RBBIM_STYLE;
  barcnt := SendMessage(Handle, RB_GETBANDCOUNT, 0, 0);
  for i := 0 to barcnt-1 do begin
    SendMessage(Handle, RB_GETBANDINFO, WPARAM(UINT(i))
        , LPARAM(@bandInfo));
    if IsFix then
      bandInfo.fStyle := bandInfo.fStyle or RBBS_NOGRIPPER
    else if (bandInfo.fStyle and RBBS_NOGRIPPER) > 0 then
      bandInfo.fStyle := bandInfo.fStyle xor RBBS_NOGRIPPER;
    SendMessage(Handle, RB_SETBANDINFO, WPARAM(UINT(i))
        , LPARAM(@bandInfo));
  end;
end;

function IncludeRect(r: TRect; p: TPoint): Boolean;
begin
  Result := (r.Left <= p.X) and (r.Right >= p.X) and (r.Top <= p.Y) and (r.Bottom >= p.Y);
end;

procedure StayOnTop(Handle: HWND; IsTop: Boolean);
var h: HWND;
begin
  if IsTop then
    h := HWND_TOPMOST
  else h := HWND_NOTOPMOST;
  SetWindowPos(Handle, h,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE{ or SWP_SHOWWINDOW});
//  //表示
//  SetWindowPos(Handle, HWND_TOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
//  //解除
//  SetWindowPos(Handle, HWND_NOTOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
end;

procedure InvalidateEx(Handle: HWND);
begin
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

procedure OnWorkArea(var Rect: TRect);
var
	WRect: TRect;
  w, h: Integer;
const
	DEF = 20;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WRect, 0);
  w := (Rect.Right - Rect.Left);
  h := (Rect.Bottom - Rect.Top);
  if w > (Screen.Width - DEF) then begin
    w := Screen.WorkAreaWidth - DEF * 2;
    Rect.Right := Rect.Left + w;
  end;
  if h > (Screen.Height - DEF) then begin
    h := Screen.WorkAreaHeight - DEF * 2;
    Rect.Bottom := Rect.Top + h;
  end;
  if Rect.Left > WRect.Right - w then begin
    Rect.Left := WRect.Right - w - DEF;
    Rect.Right := Rect.Left + w;
  end;
  if Rect.Left < WRect.Left then begin
    Rect.Left :=  WRect.Left + DEF;
    Rect.Right :=  Rect.Left + h;
  end;
  if Rect.Top < WRect.Top then begin
    Rect.Top := WRect.Top + DEF;
    Rect.Bottom := Rect.Top + h;
  end;
  if Rect.Top > WRect.Bottom - h then begin
    Rect.Top := WRect.Bottom - h - DEF;
    Rect.Bottom := Rect.Top + h;
  end;
end;

procedure OnWorkArea(Ctrl: TControl);
var
	WRect: TRect;
const
	DEF = 0;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WRect, 0);

  if Ctrl.Width > (Screen.WorkAreaWidth - DEF) then Ctrl.Width := Screen.WorkAreaWidth - DEF * 2;
  if Ctrl.Height > (Screen.WorkAreaHeight - DEF) then Ctrl.Height := Screen.WorkAreaHeight - DEF * 2;
  if Ctrl.Left > WRect.Right - Ctrl.Width then Ctrl.Left := WRect.Right - Ctrl.Width - DEF;
  if Ctrl.Left < WRect.Left then Ctrl.Left := WRect.Left + DEF;
  if Ctrl.Top < WRect.Top then Ctrl.Top := WRect.Top + DEF;
  if Ctrl.Top > WRect.Bottom - Ctrl.Height then Ctrl.Top := WRect.Bottom - Ctrl.Height - DEF;
end;

//procedure OnWorkArea(Form: TForm);
//var
//	WRect: TRect;
//const
//	DEF = 20;
//begin
//  SystemParametersInfo(SPI_GETWORKAREA, 0, @WRect, 0);
//                                                                                        
//  if Form.Width > (Screen.Width - DEF) then Form.Width := Screen.WorkAreaWidth - DEF * 2;
//  if Form.Height > (Screen.Height - DEF) then Form.Height := Screen.WorkAreaHeight - DEF * 2;
//  if Form.Left > WRect.Right - Form.Width then Form.Left := WRect.Right - Form.Width - DEF;
//  if Form.Left < WRect.Left then Form.Left := WRect.Left + DEF;
//  if Form.Top < WRect.Top then Form.Top := WRect.Top + DEF;
//  if Form.Top > WRect.Bottom - Form.Height then Form.Top := WRect.Bottom - Form.Height - DEF;
//end;

//function StayOnTop(const hWnd: HWND): Boolean;
//begin
//  Result := SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0,
//                             SWP_NOMOVE or SWP_NOSIZE);
//end;

function Encryption(const s:String;decode:Boolean):string;
var i,n,m,siz,r:Integer;
const k='極秘';
begin
  RandSeed:=(ord(k[3])*$10000+ord(k[1])*$100+ord(k[2]));
  Result:='';
  siz:=Length(s);
  r:=random($FFFF);
  if decode then siz:=siz div 2;
  for i:=1 to siz do begin
    if decode then n:= StrToInt('$'+copy(s,i*2-1,2))
    else n:= ord(s[i]);
    m:= ( n xor ord(k[1+(i mod Length(k))]) xor random(256)) xor (r and $FF);
    if decode then r:=(r*331 + m) else r:=(r*331 +n) ;
    if decode then Result:=Result+Char(m)
    else Result:=Result+IntToHex(m,2);
  end;
end;

function IntToBool(Int: Integer): Boolean;
begin
  Result := True;
  if Int = 0 then Result := False;
end;

function BoolToInt(Bool: Boolean): Integer;
begin
  if Bool then
    Result := -1
  else
    Result := 0;
end;

procedure SetMouseCursor(Ctrl: TControl);
var
	p: TPoint;
begin
  p := Point(Ctrl.Width div 2, Ctrl.Height div 2);
  p := Ctrl.ClientToScreen(p);
  SetCursorPos(p.X, p.Y);
end;

function IsIncludeMultiByte(s: string): Boolean;
var i: Integer;
  t: TMbcsByteType;
begin
  Result := False;
  for i := 1 to Length(s) do begin
    t := ByteType(s, i);
    if t <> mbSingleByte then begin
      Result := True;
      Exit;
    end;
  end;
end;

function GetFixedWordLength(const Text: string; Byte: Cardinal; Dot: Boolean): string;
var
  s: string;
  i: Cardinal;
begin
  s := Text;
  Result := s;
  i := Length(s);
  if i > Byte then begin
    s := copy(s, 1, Byte);
    if ByteType(s, Byte) = mbLeadByte then
      Delete(s, Byte, 1);
    if Dot then s := s + #13#10 + '...';
    Result := s;
  end;
end;

//数値を３桁ごとに区切る関数
function SplitDigit(S : String) : String ;
var I : Integer ;
begin
   Result := '' ;
   for I := 1 to (Length(s)-1) div 3 do
   begin
      Result := Result + ',' + Copy(s,Length(s)-2,3) ;
      Delete(s,Length(s)-2,3) ;
   end ;
  Result := s + Result ;
end ;

end.
