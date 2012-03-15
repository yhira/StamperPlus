{
�{�^���������ăI�[�v���_�C�A���O�Ń��\�[�XDLL��EXE�t�@�C����I�������
�J�����g�t�H���_�ɃO���[�v�A�C�R���S�Ă𒊏o���ۑ����܂��B

�A�C�R�����o�Ƃ�����ExtractIcon��ExtractIconEx�ł���
HICON��������Icon�C���X�^���X��Save�����16�F�̒P��A�C�R���ł����ۑ��ł��܂���B
���������������@���l�b�g�ŒT�����̂ł���Delphi�̗Ⴊ�����悤�Ȃ̂�
�쐬���Ă݂܂����B�X�}�[�g�ȕ��@�ł͂Ȃ���������܂��񂪂��������������B

�Q�l�T�C�g

���s�t�@�C������A�C�R�������o��
http://hp.vector.co.jp/authors/VA016117/rsrc2icon.html
ICO(CUR) �t�@�C���t�H�[�}�b�g
http://www14.ocn.ne.jp/~setsuki/ext/ico.htm
�A�C�R���t�@�C���t�H�[�}�b�g
http://www.river.sannet.ne.jp/yuui/fileformat/icon.html
}
unit IconRes;

interface

uses
  Windows, SysUtils, Classes, Graphics, Registry, yhFiles;


//�t�@�C���Ɋ֘A�t�����Ă��郊�\�[�X���𓾂�
function GetDefaultIconResInfo(const FileName: string;
    var ResFileName: string; var ResIndex: Integer): Boolean;
//�t�@�C�����̃A�C�R����ۑ�����
function SaveIcons(FileName: string; Index: Integer; Icon: TIcon): Boolean;
//�A�C�R���̗񋓂Ɏg����R�[���o�b�N�֐�
function EnumResNameProc(hModule: HWND; lpszType: LPCTSTR;
                lpszName: LPTSTR; lParam: Longint): Boolean; stdcall;

implementation

type
  //�A�C�R���t�@�C���̃w�b�_���
  PIconFileHeader = ^TIconFileHeader;
  TIconFileHeader = packed record
    Reserved: Word;
    wType: Word;  // ��ʁB�A�C�R�����J�[�\�����������B
    Count: Word;  // �A�C�R���̐�
  end;

  PIconFileInfo = ^TIconFileInfo;
  TIconFileInfo = packed record
    Width: Byte;       // ��
    Height: Byte;      // ����
    Colors: Word;      // �F��
    Reserved1: Word;
    Reserved2: Word;
    Size: DWORD;     // �A�C�R���C���[�W�̑傫���B
                     // 2��DIB�C���[�W���܂�
    Offset: DWORD;   // �A�C�R���C���[�W�̃t�@�C����
                     // �擪����̈ʒu
  end;

  //�A�C�R�����\�[�X�̃w�b�_���
  PIconResHeader = ^TIconResHeader;
  TIconResHeader = TIconFileHeader;

  PIconResInfo = ^TIconResInfo;
  TIconResInfo = packed record
    Width: Byte;       // ��
    Height: Byte;      // ����
    Colors: Word;      // �F��
    Reserved1: Word;
    Reserved2: Word;
    Size: DWORD;       // �A�C�R���C���[�W�̑傫���B
                       // 2��DIB�C���[�W���܂�
    ID: Word;          //�e�A�C�R���̃��\�[�X�h�c
  end;
  TIconResInfos  = array of TIconResInfo;
  TIconFileInfos = array of TIconFileInfo;

var
  g_Index: Integer;
  g_Icon: TIcon;
  hFile: HWND;

//�t�@�C���Ɋ֘A�t�����Ă��郊�\�[�X���𓾂�
function GetDefaultIconResInfo(const FileName: string;
    var ResFileName: string; var ResIndex: Integer): Boolean;
var ext, FileType, ClassType, IconResStr, rfn, ri: string; reg: TRegistry;
  commaPos: Integer;
begin
  ext := ExtractFileExt(FileName);
  //�����l�ݒ�
  //�A�C�R�����\�[�X�擾���s�̍ۂ�
  //���\�[�X�t�@�C��=%SystemRoot%\System32\shell32.dll
  //���\�[�X�C���f�b�N�X= 0 �ɂȂ�
  Result := False;
  ResFileName := IncludeTrailingPathDelimiter(GetSystemDir) + 'shell32.dll';
  ResIndex := 0;
  IconResStr := '';

  reg := TRegistry.Create(KEY_READ);
  try
    //�u�g���q�v�ɑ΂��Ċ֘A�t����ꂽ�A�C�R�����\�[�X������̎擾
    reg.RootKey := HKEY_CLASSES_ROOT;
    if not reg.OpenKey(ext, False) then Exit;
    //�t�@�C���^�C�v�̎擾
    FileType := reg.ReadString('');
    if FileType = '' then Exit;

    //HKEY_LOCAL_MACHINE\Software\Classes\�ȉ�����擾
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('Software\Classes\' + FileType + '\DefaultIcon', False) then
      IconResStr := reg.ReadString('');
    if IconResStr = '' then begin
      //HKEY_CLASSES_ROOT\�ȉ�����擾
      reg.RootKey := HKEY_CLASSES_ROOT;
      if reg.OpenKey(FileType + '\DefaultIcon', False) then
        IconResStr := reg.ReadString('');
    end;

    //���ŃA�C�R�����\�[�X������̎擾�Ɏ��s���Ă�
    //�u���ށv�ɑ΂��Ċ֘A�t��������ꍇ�擾
    reg.OpenKey(ext, False);
    if (IconResStr = '') and reg.ValueExists('PerceivedType') then begin
      //���ރ^�C�v�̎擾
      ClassType := reg.ReadString('PerceivedType');
      if ClassType = '' then Exit;

      //HKEY_LOCAL_MACHINE\Software\Classes\�ȉ�����擾
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey('Software\Classes\SystemFileAssociations\' + ClassType + '\DefaultIcon', False) then
        IconResStr := reg.ReadString('');
      if IconResStr = '' then begin
        ////HKEY_CLASSES_ROOT\�ȉ�����擾
        reg.RootKey := HKEY_CLASSES_ROOT;
        if reg.OpenKey('SystemFileAssociations\' + ClassType + '\DefaultIcon', False) then
          IconResStr := reg.ReadString('');
      end;
    end;
    if IconResStr = '' then Exit;  
    if IconResStr = '%1' then Exit;

    //�A�C�R�����\�[�X��������R���}�̑O��Ń��\�[�X�t�@�C����
    //���\�[�X�C���f�b�N�X�ԍ��i�}�C�i�X�l���ƃ��\�[�XID�j�ɕ���
    commaPos := Pos(',', IconResStr); //�R���}�ʒu
    if commaPos <> 0 then begin
      rfn := Trim(Copy(IconResStr, 1, commaPos-1));
      ri := Trim(Copy(IconResStr, commaPos+1, Length(IconResStr)));
    end else begin
      //�R���}���Ȃ��Ƃ��͂��̂܂�
      rfn := Trim(IconResStr);
      ri := '0';
    end;

    rfn := ExpandPath(rfn);
    ResFileName := rfn;             //���\�[�X�t�@�C����Ԃ�
    ResIndex := StrToIntDef(ri, 0); //���\�[�X���l��Ԃ�
    Result := False;
  finally
    reg.Free;
  end;
end;

//�w�肳�ꂽ�h�c�����A�C�R���̃f�[�^���R�s�[����
function StoreIconData(hFile: HWND; ID: Word; var pMem: PByte): DWORD;
var hIcon,hLoadIcon: HRSRC;
  pLoadIcon: PByte; Size: Cardinal;
begin
  Result := 0;
  //���\�[�X��T��
  hIcon := FindResource(hFile, MakeIntResource(ID), RT_ICON);
  if hIcon = 0 then Exit;
  //���\�[�X�̃��[�h
  hLoadIcon := LoadResource(hFile, hIcon);
  if hLoadIcon = 0 then Exit;
  //���\�[�X�̃��b�N
  pLoadIcon := LockResource(hLoadIcon);
  if pLoadIcon = nil then Exit;
  //���\�[�X�̑傫��
  Size := SizeofResource(hFile, hIcon);
  //���\�[�X�|�C���^��n��
  pMem := pLoadIcon;

  Result := Size;
end;

//�O���[�v�A�C�R���̊i�[�ɕK�v�ȃT�C�Y���擾����
function GetGroupIconSize(IconResInfos: TIconResInfos): Cardinal;
var i, Count: Integer; Size: Cardinal; //pMem: Pointer;
begin
  Count := Length(IconResInfos);
  //���ꂼ��̃A�C�R���̃T�C�Y�����v���đS�̂̑傫�������߂�
  Size := sizeof(TIconFileHeader) + sizeof(TIconFileInfo) * Count;
  for i := Low(IconResInfos) to High(IconResInfos) do
    Size := Size + IconResInfos[i].Size;
  Result := Size;
end;

//�A�C�R���̗񋓂Ɏg����R�[���o�b�N�֐�
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

  //�O���[�v�A�C�R�����\�[�X������
  hGIcon := FindResource(hFile, lpszName, RT_GROUP_ICON);
  if hGIcon = 0 then Exit;

  //���������\�[�X�����[�h
  hLoadGIcon := LoadResource(hFile, hGIcon);
  if hLoadGIcon = 0 then Exit;

  //���\�[�X�����b�N���āA�������A�h���X�𓾂�
  pRes := LockResource(hLoadGIcon);

  irh := PIconResHeader(pRes);
  IconCount := irh.Count;
  SetLength(IconResInfos, IconCount);  
  SetLength(IconFileInfos, IconCount);
  pResInfos := Pointer(Cardinal(irh) + sizeof(TIconResHeader));
  //IconResInfos�Ƀ��\�[�X�����R�s�[
  CopyMemory(IconResInfos, pResInfos, sizeof(TIconResInfo) * IconCount);

  //�A�C�R���S�̂̃T�C�Y���v�Z����
  AllSize := GetGroupIconSize(IconResInfos);

  pMem := GetMemory(AllSize); //�A�C�R���f�[�^�̂���A�h���X�v�Z�p�|�C���^
  if pMem = nil then Exit;
//  IcoName := ExtractFilePath(ParamStr(0)) + Format('icon%.3d.ico', [g_Index]);
  //�t�@�C���X�g���[���̍쐬
  ms := TMemoryStream.Create;
  ms.Position := 0;
  //�摜�f�[�^�|�C���^�̕ۑ����X�g
  LoadIconList := TList.Create;
  //�摜�f�[�^�T�C�Y�̕ۑ����X�g
  IconSizeList := TList.Create;
  try
    //�A�C�R���t�@�C���w�b�_�̍쐬
    ifh.Reserved := 0; //�\��
    ifh.Count := IconCount;
    ifh.wType := 1;  //�A�C�R��
    //�A�C�R���t�@�C���w�b�_����������
    ms.Write(ifh, sizeof(TIconFileHeader));

    pMemTmp := pMem;
    //�A�C�R���t�@�C���̃w�b�_�T�C�Y�̌v�Z
    HeadSize := sizeof(TIconFileHeader) + sizeof(TIconFileInfo) * IconCount;
    Inc(pMemTmp, HeadSize);
    //�A�C�R���w�b�_���̏�������
    for i := 0 to IconCount-1 do begin

      IconSize := StoreIconData(hFile, IconResInfos[i].ID, pLoadIcon);
      if IconSize = 0 then Exit;
      //�摜�f�[�^�|�C���^�����X�g�ɃX�g�b�N
      LoadIconList.Add(pLoadIcon);
      //�摜�f�[�^�T�C�Y�����X�g�ɃX�g�b�N
      IconSizeList.Add(Pointer(IconSize));

      //�w�b�_���̍X�V
      IconFileInfos[i].Width := IconResInfos[i].Width;
      IconFileInfos[i].Height := IconResInfos[i].Height;
      IconFileInfos[i].Colors := IconResInfos[i].Colors;
      IconFileInfos[i].Size := IconSize;
      //�A�C�R���f�[�^�̂���A�h���X
      IconFileInfos[i].Offset := Cardinal(pMemTmp) - Cardinal(pMem);

      ms.Write(IconFileInfos[i], SizeOf(TIconFileInfo));
      Inc(pMemTmp, IconSize);
    end;
    //�摜�̏�������
    for i := 0 to LoadIconList.Count-1 do begin
      //�摜�f�[�^�̏�������
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

//�t�@�C�����̃A�C�R����ۑ�����
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

    //�A�C�R����񋓂��ĕۑ�
    res := EnumResourceNames(hFile, RT_GROUP_ICON, @EnumResNameProc, Index);
    if not res then Exit;
  finally
    FreeLibrary(hFile);
  end;

//  Icon := g_Icon;

  Result := True;
end;

end.

