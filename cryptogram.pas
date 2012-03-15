(**
*** 簡易暗号化，複合化ユニット
*** データやファイルそのものを暗号化，複合化する
***
*** ファイルを暗号化する場合には、ファイル先頭にマスクしたパスワードを
*** 保存し、複合化するときにパスワードの照合を行なう
***
*** 簡単な使い方
*** 　プログラムソースのUses節にcryptogramを加えて、
*** EncryptsFile(FileName, PassWord, False);で暗号化
*** DecryptsFile(FileName, PassWord, False);で復号化
*** します
***
*** 注意
*** 暗号化するファイルが既に暗号化されているかどうかはチェックして
*** いません。逆にこのことを利用して、パスワードを変えて複数回の
*** 暗号化を行なえば、解読が難しくなるかもしれません（そのかわり
*** 元に戻すのが大変ですが）。
***
*** Copyright(c) 2000/8/27 Ｍ＆Ｉ
*** mailto:masahiro.inoue@nifty.ne.jp
*** http://member.nifty.ne.jp/m-and-i/
***
**)

unit  cryptogram;

interface

uses Windows, Sysutils;

(*
  Header
    0 1 234567 89AB 12............43
    $17$00+'LOCKED'+XXXX+'パスワード32文字'
*)

const
  errPWNOMATCH = 1;
  errFILEIO    = 2;

procedure Encrypts(var Buff: PChar; Size: integer; PassWord: string);
procedure Decrypts(var Buff: PChar; Size: integer; PassWord: string);
function GetPassword(Buff: PChar; var FTime: integer): string;
function EncryptsFile(FileName, PassWord: string; OrgFile: Boolean): Boolean;
function DecryptsFile(FileName, PassWord: string; OrgFile: Boolean): integer;

implementation

const
  BuffSize = 1024;

(*
  暗号化
  Buff内のデータをPassWordでXORをかける
*)
procedure Encrypts(var Buff: PChar; Size: integer; PassWord: string);
var
  i, j, PLen, Blk, MLen: integer;
begin
  PLen   := Length(PassWord);
  if PLen = 0 then
    Exit;
  Blk    := Size div PLen;
  MLen   := Size mod PLen;
  for i := 0 to Blk - 1 do
  begin
    for j := 0 to Plen - 1 do
    begin
      Buff[i * PLen + j] := Char(Ord(Buff[i * PLen + j]) xor Ord(PassWord[j + 1]));
    end;
  end;
  if MLen > 0 then
    for i := 0 to MLen - 1 do
      Buff[Blk * PLen + i] := Char(Ord(Buff[Blk * PLen + i]) xor Ord(PassWord[i + 1]));
end;

(*
  復号化
  Buff内のデータをPassWordでXORをかける
  現在の単純な仕様ではExcryptsと全く同じ処理
*)
procedure Decrypts(var Buff: PChar; Size: integer; PassWord: string);
begin
  Encrypts(Buff, Size, PassWord);
end;

(*
  Buff内のデータからPassWordと元ファイルのタイムスタンプを取得
*)
function GetPassword(Buff: PChar; var FTime: integer): string;
var
  i: integer;
  Hd: string;
begin
  Result := '';
  FTime  := 0;
  Hd := Buff[2] + Buff[3] + Buff[4] + Buff[5] + Buff[6] + Buff[7];
  if (Buff[0] = #$17) and (Buff[1] = #$0) and (Hd = 'LOCKED') then
  begin
    for i := 12 to 43 do
    begin
      if Buff[i] = #$0 then
        Break;
      Result := Result + Char(Ord(Buff[i]) xor $DD);
    end;
    FTime := Ord(Buff[8]) + (Ord(Buff[9]) shl 8) + (Ord(Buff[10]) shl 16)
             + (Ord(Buff[11]) shl 24);
  end;
end;

(*
  パスワードと元ファイルのタイムスタンプからヘッダーを作成する
*)
procedure SetPassword(var Buff: PChar; PassWord: string; FTime: integer);
var
  i, PLen: integer;
begin
  Buff[0] := #$17;
  Buff[1] := #$0;
  Buff[2] := 'L';
  Buff[3] := 'O';
  Buff[4] := 'C';
  Buff[5] := 'K';
  Buff[6] := 'E';
  Buff[7] := 'D';
  Buff[8] := Char(FTime and $000F);
  Buff[9] := Char((FTime shr 8) and $000F);
  Buff[10]:= Char((FTime shr 16)and $000F);
  Buff[11]:= Char((FTime shr 24)and $000F);
  for i := 12 to 43 do
    Buff[i] := #0;
  PLen := Length(PassWord);
  if PLen > 32 then
    PLen := 32;
  for i := 0 to PLen - 1 do
    Buff[i + 12] := Char(Ord(PassWord[i + 1]) xor $DD);
end;

(*
  ファイルの暗号化
  FileNameで指定したファイルをPassWordで暗号化する
  OrgFileにTRUEをセットした場合には元ファイルを拡張子を'.ORG'に
  変えて残す
  処理が成功すればTRUEを失敗すればFALSEを返す
*)
function EncryptsFile(FileName, PassWord: string; OrgFile: Boolean): Boolean;
var
  SF, DF, i,
  FSize, Blk,
  MLen,
  FTime: integer;
  Buff: PChar;
  TmpName: string;
begin
  Result := False;
  if Length(PassWord) = 0 then
    Exit;
  {$I-}
  SF := FileOpen(PChar(FileName), fmOpenRead or fmShareDenyNone);
  if SF <= 0 then
    Exit;
  FTime := FileGetDate(SF);
  FSize := FileSeek(SF, 0, 2);
  FileSeek(SF, 0, 0);
  TmpName := ChangeFileExt(FileName, '.$$$');
  DF := FileCreate(PChar(TmpName));
  if DF <= 0 then
  begin
    FileClose(SF);
    Exit;
  end;
  Blk  := FSize div BuffSize;
  Buff := AllocMem(BuffSize);
  try
    SetPassWord(Buff, PassWord, FTime);
    FileWrite(DF, Buff^, 44);
    for i := 0 to Blk - 1 do
    begin
      FileRead(SF, Buff^, BuffSize);
      Encrypts(Buff, BuffSize, PassWord);
      FileWrite(DF, Buff^, BuffSize);
    end;
    MLen := FSize mod BuffSize;
    if MLen > 0 then
    begin
      FileRead(SF, Buff^, MLen);
      Encrypts(Buff, MLen, PassWord);
      FileWrite(DF, Buff^, MLen);
    end;
    FileClose(SF);
    FileClose(DF);
    if OrgFile then
    begin
      if RenameFile(FileName, ChangeFileExt(FileName, '.org')) then
        if RenameFile(TmpName, FileName) then
          Result := True;
    end else begin
      if DeleteFile(FileName) then
        if RenameFile(TmpName, FileName) then
          Result := True;
    end;
  finally
    FreeMem(Buff);
  end;
  {$I+}
end;

(*
  ファイルの復号化
  FileNameで指定したファイルをPassWordで復号化する
  OrgFileにTRUEをセットした場合には元ファイルを拡張子を'.CRP'に
  変えて残す
  処理が成功した場合には0を返す
  パスワードが違う場合にはerrPWNOMATCHをファイル操作に失敗した場合には
  errFILEIOを返す
*)
function DecryptsFile(FileName, PassWord: string; OrgFile: Boolean): integer;
var
  SF, DF, i,
  FSize, Blk,
  MLen,
  FTime: integer;
  Buff: PChar;
  TmpName, PW: string;
begin
  Result := errFILEIO;
  if Length(PassWord) = 0 then
    Exit;
  {$I-}
  SF := FileOpen(PChar(FileName), fmOpenRead or fmShareDenyNone);
  if SF <= 0 then
    Exit;
  FSize := FileSeek(SF, 0, 2);
  if FSize < 35 then
  begin
    FileClose(SF);
    Exit;
  end;
  FileSeek(SF, 0, 0);
  TmpName := ChangeFileExt(FileName, '.$$$');
  DF := FileCreate(PChar(TmpName));
  if DF <= 0 then
  begin
    FileClose(SF);
    Exit;
  end;
  FSize:= FSize - 44;
  Blk  := FSize div BuffSize;
  Buff := AllocMem(BuffSize);
  try
    FileRead(SF, Buff^, 44);
    PW := GetPassWord(Buff, FTime);
    if PassWord <> PW then
    begin
      FileClose(SF);
      FileClose(DF);
      Result := errPWNOMATCH;
      Exit;
    end;
    for i := 0 to Blk - 1 do
    begin
      FileRead(SF, Buff^, BuffSize);
      Decrypts(Buff, BuffSize, PassWord);
      FileWrite(DF, Buff^, BuffSize);
    end;
    MLen := FSize mod BuffSize;
    if MLen > 0 then
    begin
      FileRead(SF, Buff^, MLen);
      Decrypts(Buff, MLen, PassWord);
      FileWrite(DF, Buff^, MLen);
    end;
    if FTime <> 0 then
      FileSetDate(DF, FTime);
    FileClose(SF);
    FileClose(DF);
    if OrgFile then
    begin
      if RenameFile(FileName, ChangeFileExt(FileName, '.crp')) then
        if RenameFile(TmpName, FileName) then
          Result := 0;
    end else begin
      if DeleteFile(FileName) then
        if RenameFile(TmpName, FileName) then
          Result := 0;
    end;
  finally
    FreeMem(Buff);
  end;
  {$I+}
end;

end.
