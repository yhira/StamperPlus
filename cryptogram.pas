(**
*** �ȈՈÍ����C���������j�b�g
*** �f�[�^��t�@�C�����̂��̂��Í����C����������
***
*** �t�@�C�����Í�������ꍇ�ɂ́A�t�@�C���擪�Ƀ}�X�N�����p�X���[�h��
*** �ۑ����A����������Ƃ��Ƀp�X���[�h�̏ƍ����s�Ȃ�
***
*** �ȒP�Ȏg����
*** �@�v���O�����\�[�X��Uses�߂�cryptogram�������āA
*** EncryptsFile(FileName, PassWord, False);�ňÍ���
*** DecryptsFile(FileName, PassWord, False);�ŕ�����
*** ���܂�
***
*** ����
*** �Í�������t�@�C�������ɈÍ�������Ă��邩�ǂ����̓`�F�b�N����
*** ���܂���B�t�ɂ��̂��Ƃ𗘗p���āA�p�X���[�h��ς��ĕ������
*** �Í������s�Ȃ��΁A��ǂ�����Ȃ邩������܂���i���̂����
*** ���ɖ߂��̂���ςł����j�B
***
*** Copyright(c) 2000/8/27 �l���h
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
    $17$00+'LOCKED'+XXXX+'�p�X���[�h32����'
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
  �Í���
  Buff���̃f�[�^��PassWord��XOR��������
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
  ������
  Buff���̃f�[�^��PassWord��XOR��������
  ���݂̒P���Ȏd�l�ł�Excrypts�ƑS����������
*)
procedure Decrypts(var Buff: PChar; Size: integer; PassWord: string);
begin
  Encrypts(Buff, Size, PassWord);
end;

(*
  Buff���̃f�[�^����PassWord�ƌ��t�@�C���̃^�C���X�^���v���擾
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
  �p�X���[�h�ƌ��t�@�C���̃^�C���X�^���v����w�b�_�[���쐬����
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
  �t�@�C���̈Í���
  FileName�Ŏw�肵���t�@�C����PassWord�ňÍ�������
  OrgFile��TRUE���Z�b�g�����ꍇ�ɂ͌��t�@�C�����g���q��'.ORG'��
  �ς��Ďc��
  ���������������TRUE�����s�����FALSE��Ԃ�
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
  �t�@�C���̕�����
  FileName�Ŏw�肵���t�@�C����PassWord�ŕ���������
  OrgFile��TRUE���Z�b�g�����ꍇ�ɂ͌��t�@�C�����g���q��'.CRP'��
  �ς��Ďc��
  ���������������ꍇ�ɂ�0��Ԃ�
  �p�X���[�h���Ⴄ�ꍇ�ɂ�errPWNOMATCH���t�@�C������Ɏ��s�����ꍇ�ɂ�
  errFILEIO��Ԃ�
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
