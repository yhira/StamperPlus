unit yhFiles;

interface

uses
  Windows, SysUtils, Classes, Forms, Graphics, ShellAPI, SHLObj, ActiveX, ComObj, Registry,
  jconvertex, Math;

function Open(Handle: THandle; FileName: string; Param: string = '';
  IsShow: Boolean = True; IsWait: Boolean = False): Boolean;
//OS��Vista��
function IsVista: Boolean;
//OS��NT�n��
function IsNT: Boolean;
//�o�C�i���t�@�C����
function IsBinary(FileName: string): Boolean;
//�T�u�t�H���_�����邩
function IsSubDirExist(Dir: String): Boolean;
//Dir�ȉ��̃t�@�C����
function GetFileCount(Dir: String; SubDir: Boolean; ExtList: TStringList = nil): Cardinal;
//�X�^�[�g�A�b�v�̍쐬�E�폜
procedure SetStartup(IsCreate: Boolean);
//�V���[�g�J�b�g�̍쐬�E�폜
procedure CreateShortcut(pszDir, pszFile, pszAppName: PChar;
                       nLoca: Integer; fCreate: Boolean);
// �t�@�C���̍X�V���t�C�쐬���t, �A�N�Z�X���t���擾����
procedure GetFileDate(FileName: string; var CrDate, UpDate, AcDate: TDateTime);
// �t�@�C���̍X�V���t�C�쐬���t, �A�N�Z�X���t��ύX����
procedure SetFileDate(FileName: string; CrDate, UpDate, AcDate: TDateTime);
//�t�H���_���S�폜
procedure DeleteDir(Dir: string; IsDelRoot: Boolean = True);   
//���΃p�X�̒��o
function ExtractRelativePath(FullPath: string): string;
//�f�X�N�g�b�v�t�H���_�̎擾
function GetDesktopDir: string;
//Windows�t�H���_�̎擾
function GetWindowsDir: string;
//�V�X�e���t�H���_�̎擾
function GetSystemDir: string;
//�e���|�����p�X�̎擾
function GetTempPath: string;  
//�u%SYSTEMROOT%�v�u%SYSTEM%�v�u%TEMP%�v�����܂܂��p�X���t���p�X�ɂ���
function ExpandPath(Path: string): string;
//�g���q���Ȃ������t�@�C�������擾
function ExtractFileNameOnly(const FileName: string): string;
//�t�@�C���֑��������܂܂�Ă��邩�ǂ���
function IncludeErrorFileChar(const FileName: string): Boolean;
//�t�H���_�ɑ��݂��Ȃ��t�@�C�������擾
function NotExistFileName(const FileName: string): string;
//�t�H���_�ɑ��݂��Ȃ��t�H���_�����擾
function NotExistDirName(const FileName: string): string;
//�t�@�C���֑��������C�������t�@�C������Ԃ�
function NotErrorFileName(const FileName: string): string;
//�t�@�C���̃o�[�W�����̎擾
function GetFileVersion(const FileName: string): string;
//���i���̎擾
function GetProductName(const FileName: string): string;
//�������A�C�R���̎擾
function GetFileSmallIcon(FileName: string): TBitmap;
//OS�̎擾
function OSPlatformInfo: string;
// �󂫃������e��
function MemoryActiveInfo: string;
// �����������e��
function MemoryTotalInfo: string;
// �������g�p��
function MemoryRateOfUse: string;
//CPU�̎��
function GetCPUName: string;
//CPU������g�������߂�
function GetCPUFrequency: string;
//�𑜓x���擾���鏈��
function GetResolution: string;
//�傫�ȃt�@�C���T�C�Y
function GetFileSizeEx(FileName: string): string;
//Dir���̓���t�@�C���������͂��ׂẴt�@�C�������X�g�A�b�v
procedure FindAllFilesWithExt(dir,ext:string;SL:TStringList; IsSubDir: Boolean = True);
//Dir���̑S�t�H���_�����X�g�A�b�v
procedure FindAllDirInDir(dir:string;SL:TStringList; IsSubDir: Boolean = True);
//�Z�k�p�X����t���p�X��
function OmitToFull(s: string): string;
//�t���p�X����Z�k�p�X��
function FullToOmit(s: string): string;
//�T�u�f�B���N�g�����܂߂��f�B���N�g���̃R�s�[
function SHDeleteDir(hParent:HWND;Name:string):Boolean;
//�T�u�f�B���N�g�����܂߂��f�B���N�g���̍폜
function SHCopyDir(hParent:HWND;NameFrom,NameTo:string):Boolean;

type
  TFileInfo = class(TObject)
  private
    FFileName:TFileName;
    FProductVersion:string;
    FCompanyName:string;
    FOriginalFileName:string;
    FFileDescription:string;
    FFileVersion:string;
    FInternalName:string;
    FProductName:string;
    FVSFixedFileInfo:TVSFixedFileInfo;
    FSmallIcon:TBitmap;
    FLargeIcon:TBitmap;
    procedure SetFileName(Value:TFileName);
    procedure GetVersionInfo;
    function GetFVSFixedFileInfo:TVSFixedFileInfo;
    procedure GetIcon;
  public
    constructor Create;
    destructor Destroy;override;
    property VSFixedFileInfo:TVSFixedFileInfo read GetFVSFixedFileInfo;
    property SmallIcon:TBitmap read FSmallIcon;
    property LargeIcon:TBitmap read FLargeIcon;
    property FileName:TFileName read FFileName write SetFileName;
    property ProductVersion:string read FProductVersion;
    property CompanyName:string read FCompanyName;
    property OriginalFileName:string read FOriginalFileName;
    property FileDescription:string read FFileDescription;
    property FileVersion:string read FFileVersion;
    property InternalName:string read FInternalName;
    property ProductName:string read FProductName;
  end;
//�g�p���@�́A�I�u�W�F�N�g�𐶐��������FileName�v���p�e�B�ɃZ�b�g���邱��
//�Ŋe�v���p�e�B��������擾���邱�Ƃ��o���܂��B
//
//var
//  FInfo:TFileInfo;
//begin
//  FInfo := TFileInfo.Create;
//  try
//    FInfo.FileName := Application.ExeName;
//    WriteLn('�t�@�C�����@�[�W������' + FileVersion +'�ł�');
//  finally
//    FInfo.Free;
//  end;
//end;


implementation

var
	ErrorFileChar: String = '\/:;*?"<>|';
	ErrorFileCharZen: String = '���^�F�G���H�h�����b';
  FileSL, DirSL: TStringList;
const  
  OMIT_DIR = '$(Dir)';
  OMIT_SYSTEM =     '$(System)';
  OMIT_SYSTEMROOT = '$(SystemRoot)';
  OMIT_WINDIR =     '$(WinDir)';
  OMIT_WIN_DIR = '%Dir%';
  OMIT_WIN_SYSTEM =     '%System%';
  OMIT_WIN_SYSTEMROOT = '%SystemRoot%';
  OMIT_WIN_WINDIR =     '%WinDir%';

function GetDesktopDir: string;
var pidl: PItemIDList;
    buf : array [0..MAX_PATH] of Char;
    m  : IMalloc;
const DesktopID = CSIDL_DESKTOPDIRECTORY;
begin
  OleCheck(CoGetMalloc(1, m));
  OleCheck(SHGetSpecialFolderLocation(0, DesktopID, pidl));
  try
    Assert(SHGetPathFromIDList(pidl, buf));
    Result := buf;
  finally
    m.Free(pidl);
  end;
end;

procedure FindAllDirInDir(dir:string;SL:TStringList; IsSubDir: Boolean);
var
  s: string;
  hFind: LongInt;
  fd: TWin32FindData;
  Ret: Boolean;
begin
  s := IncludeTrailingPathDelimiter(dir) + '*.*';
  hFind := FindFirstFile(PChar(s),fd);

  Ret := true;
  while ( (hFind <> LongInt(INVALID_HANDLE_VALUE)) and Ret ) do begin
    if (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then begin 
      if not IsSubDir then Continue;
      SetString(s,fd.cFileName,1);
      if (s <> '.') and (s <> '..') then
        SL.Add(string(IncludeTrailingPathDelimiter(dir) + fd.cFileName));
    end;
    Ret := FindNextFile(hFind,fd);
  end;
  Windows.FindClose(hFind);
end;

procedure FindAllFilesWithExt(dir,ext:string;SL:TStringList; IsSubDir: Boolean);
var
  s: string;
  hFind: THandle;
  fd: TWin32FindData;
  Ret: Boolean;
begin
  s := IncludeTrailingPathDelimiter(dir) + '*.'+ext;
  hFind := FindFirstFile(PChar(s),fd);

  Ret := true;
  while ( (hFind <> INVALID_HANDLE_VALUE) and Ret ) do begin     
    if (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then begin
      if not IsSubDir then Continue;
      SetString(s,fd.cFileName,1);
      if (s <> '.') and (s <> '..') then
        FindAllFilesWithExt(IncludeTrailingPathDelimiter(dir) + fd.cFileName,
          ext, SL);
    end;
    if (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      SL.Add(string(IncludeTrailingPathDelimiter(dir) + fd.cFileName));
    Ret := FindNextFile(hFind,fd);
  end;
  Windows.FindClose(hFind);
end;

function GetFileSizeEx(FileName: string): string;
var hF: THandle; SizeLo, SizeHi, c: DWORD;
begin
  hF := CreateFile(PChar(FileName),0,
                   0,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  SizeLo := Windows.GetFileSize(hF, @SizeHi);
  if SizeHi = 0 then c := 0 else  c := SizeHi*Trunc(Power(2, 32));
  Result := IntToStr(c + SizeLo);
  CloseHandle(hF);
end;

procedure AddDelete(Dir: string);
var
  Rec: TSearchRec;
  Found: Integer;
  s: string;
begin
  Found := FindFirst(IncludeTrailingPathDelimiter(Dir) + '*.*', faAnyFile, Rec);
  try
    while (Found = 0) do begin
      if (Rec.Name <> '..') and (Rec.Name <> '.') then begin
        s := IncludeTrailingPathDelimiter(Dir) + Rec.Name;
        if (Rec.Attr and SysUtils.faDirectory > 0) then begin
          DirSL.Add(s);
          AddDelete(s);
        end;
        if (Rec.Attr and SysUtils.faDirectory) = 0 then begin
          FileSL.Add(s);
        end;
      end;
      Found := FindNext(Rec);
    end;
  finally
    FindClose(Rec);
  end;
end;

procedure DeleteDir(Dir: string; IsDelRoot: Boolean);
var i: Integer;
begin
  DirSL := TStringList.Create;
  FileSL := TStringList.Create;
  try
    AddDelete(Dir);
    for i := FileSL.Count-1 downto 0 do begin
      FileSetReadOnly(FileSL[i], False);           
      DeleteFile(FileSL[i]);
    end;
    for i := DirSL.Count-1 downto 0 do begin
      FileSetReadOnly(ExcludeTrailingPathDelimiter(DirSL[i]), False);
      RemoveDir(ExcludeTrailingPathDelimiter(DirSL[i]));
    end;
    if IsDelRoot then begin
      FileSetReadOnly(ExcludeTrailingPathDelimiter(Dir), False);
      RemoveDir(ExcludeTrailingPathDelimiter(Dir));
    end;
  finally
    DirSL.Free;
    FileSL.Free;
  end;
end;

function Open(Handle: THandle; FileName, Param: string; IsShow, IsWait: Boolean): Boolean;
var
  SEI: TShellExecuteInfoA;
begin
  Result := False;
  // �G���x�[�V����
  FillChar(sei, SizeOf(SEI), 0);

  SEI.cbSize := SizeOf(SEI);
  SEI.Wnd := Handle;
  SEI.fMask := SEE_MASK_FLAG_DDEWAIT or
               SEE_MASK_FLAG_NO_UI;
  if IsWait then
    SEI.fMask := SEI.fMask + SEE_MASK_NOCLOSEPROCESS;   // �ǉ�

  if isVista then
    SEI.lpVerb := 'runas'
  else
    SEI.lpVerb := 'open';

  SEI.lpFile := PChar(FileName);
  SEI.lpParameters := PChar(Param);
  if IsShow then
    SEI.nShow := SW_SHOW
  else
    SEI.nShow := SW_HIDE;

  try
    if not ShellExecuteEx(@SEI) then begin
      Exit;
    end;
    if IsWait then begin
      WaitForInputIdle(SEI.hProcess,INFINITE);
      while WaitForSingleObject(SEI.hProcess, 0) = WAIT_TIMEOUT do begin
        Application.ProcessMessages;
        Sleep(100);
      end;
    end;
    Result := True;
  finally
    CloseHandle(SEI.hProcess);
  end;
end;

function GetWindowsDir: string;
var
  WinDir: array[0..255] of Char;
begin    
  GetWindowsDirectory(@WinDir, SizeOf(WinDir));
  Result := WinDir;
end;

function GetSystemDir: string; 
var
  s : String;
begin
  SetLength(s, MAX_PATH);
  GetSystemDirectory(PChar(s), MAX_PATH + 1);
  SetLength(s, StrLen(PChar(s)));
  Result := s;
end;

function GetTempPath: string; 
var
  tmpPath: array[0..255] of Char;
//  rc: DWORD;
begin
  {rc := }Windows.GetTempPath(SizeOf(tmpPath), @tmpPath);
  Result := tmpPath;
end;

function IsVista: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT)	and (Win32MajorVersion = 6);
end;

function IsNT: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT)	and (Win32MajorVersion >= 5);
end;

function GetFileSmallIcon(FileName: string): TBitmap;
var FI: TFileInfo;
begin
  FI := TFileInfo.Create;
  FI.FFileName := FileName;
  Result := FI.SmallIcon;
  FI.Free;
end;

function IsBinary(FileName: string): Boolean;
var MS: TMemoryStream;   
  p: PChar;
  s: string;
begin
  Result := False;
  if FileExists(FileName) then begin
    MS := TMemoryStream.Create;
    MS.LoadFromFile(FileName);
    p := AllocMem(Cardinal(MS.Size));
    try
      MS.Read(p^, MS.Size);
      system.SetString(s, p, MS.Size);
      Result := InCodeCheckEx(s) = BINARY;
    finally
      FreeMem(p);
      MS.Free;
    end;
  end;
end;


function IsSubDirExist(Dir: String): Boolean;
var
  Rec: TSearchRec;
  Found: Integer;
begin
  Result := False;
  Found := FindFirst(IncludeTrailingPathDelimiter(Dir) + '*.*', faDirectory, Rec);
  try
    while (Found = 0) do begin
      if (Rec.Name <> '..') and (Rec.Name <> '.') then begin
        if (Rec.Attr and SysUtils.faDirectory > 0) then begin
          Result := True;
          Exit;
        end;
      end;
      Found := FindNext(Rec);
    end;
  finally
    FindClose(Rec);
  end;
end;

function GetFileCount(Dir: String; SubDir: Boolean; ExtList: TStringList = nil): Cardinal;
var
  FileCount: Cardinal;
  function GetFileCountLocal(Dir: String; SubDir: Boolean; ExtList: TStringList = nil): Cardinal;
  var
    Rec: TSearchRec;
    Found: Integer;
  begin
    Found := FindFirst(IncludeTrailingPathDelimiter(Dir) + '*.*', faAnyFile, Rec);
    try
      while (Found = 0) do begin
        if (Rec.Name <> '..') and (Rec.Name <> '.') then begin
          if (Rec.Attr and SysUtils.faDirectory > 0) then begin
            if SubDir then
              GetFileCountLocal(IncludeTrailingPathDelimiter(Dir) + Rec.Name, SubDir, ExtList);
          end;
          Application.ProcessMessages;
          if (Rec.Attr and SysUtils.faDirectory) = 0 then begin
            if ExtList <> nil then begin
              if (ExtList.IndexOf(ExtractFileExt(Rec.Name)) <> -1) then begin
                Inc(FileCount);
              end;
            end else begin
              Inc(FileCount);
            end;
          end;
        end;
        Found := FindNext(Rec);
      end;
    finally
      FindClose(Rec);
    end;
    Result := FileCount;
  end;
begin
  FileCount := 0;
  Result := GetFileCountLocal(Dir, SubDir, ExtList);
end;

function GetCPUFrequency: string;
var
  TickTime: DWORD;
  MHigh, MLow, NHigh, NLow: DWORD;
  Time1, Time2, CHigh, CLow, Shr32, Clock: Comp;
begin
  Shr32 := 65535;
  Shr32 := Shr32 * 65535;
  TickTime := GetTickCount;
  while TickTime = GetTickCount do begin end;
  asm
    DB 0FH
    DB 031H
    MOV MHigh,edx
    MOV MLow, eax
  end;
  while GetTickCount < (TickTime + 1000) do begin end;
  asm
    DB 0FH
    DB 031H
    MOV NHigh,edx
    MOV NLow, eax
  end;
  CHigh := MHigh;
  CLow := MLow;
  Time1 := CHigh * Shr32 + CLow;

  CHigh := NHigh;
  CLow := NLow;
  Time2 := CHigh * Shr32 + CLow;

  Clock := (Time2 - Time1) / 1000000;
  Result := FloatToStr(Clock) + 'MHz';

end;

function GetCPUName: string;
const
  {Whoops!  These constants are used by the GetSystemInfo function,
   but they are not defined in the Delphi source code, so we must do it ourselves}
  PROCESSOR_INTEL_386 = 386;
  PROCESSOR_INTEL_486 = 486;
  PROCESSOR_INTEL_PENTIUM = 586;
  PROCESSOR_MIPS_R4000 = 4000;
  PROCESSOR_ALPHA_21064 = 21064;

  PROCESSOR_ARCHITECTURE_INTEL = 0;
  PROCESSOR_ARCHITECTURE_MIPS = 1;
  PROCESSOR_ARCHITECTURE_ALPHA = 2;
  PROCESSOR_ARCHITECTURE_PPC  = 3;
  PROCESSOR_ARCHITECTURE_UNKNOWN = $FFFF;
var
  MySysInfo: TSystemInfo;   // holds the system information
  sArch,
  sType: string;
begin
  {retrieve information about the system}
  GetSystemInfo(MySysInfo);

  {display the system's processor architecture}
  case MySysInfo.wProcessorArchitecture of
    PROCESSOR_ARCHITECTURE_INTEL: begin
      {dislay the processor architecture}
      sArch := 'Intel Processor Architecture';

      {display the processor type}
      case MySysInfo.dwProcessorType of
        PROCESSOR_INTEL_386:     sType := ' 80386';
        PROCESSOR_INTEL_486:     sType := ' 80486';
        PROCESSOR_INTEL_PENTIUM: sType := ' Pentium';
        else sType := '';
      end;
    end;
    PROCESSOR_ARCHITECTURE_MIPS:
      sArch := 'MIPS Processor Architecture';
    PROCESSOR_ARCHITECTURE_ALPHA:
      sArch := 'DEC ALPHA Processor Architecture';
    PROCESSOR_ARCHITECTURE_PPC:
      sArch := 'PPC Processor Architecture';
    PROCESSOR_ARCHITECTURE_UNKNOWN:
      sArch := 'Unknown Processor Architecture';
  end;
  Result := sArch + sType;
end;

function GetResolution: string;
var
  DskhWnd,
  nhDc,
  nWidth,
  nHeight ,
  Bit : Integer;
begin
  //�f�X�N�g�b�v�̃n���h�����擾
  DskhWnd := GetDesktopWindow;
  //�f�X�N�g�b�v�̃f�o�C�X�R���e�L�X�g�n���h�����擾
  nhDc := GetDC(DskhWnd);
  //��ʂ̉������擾
  nWidth := GetDeviceCaps(nhDc, HORZRES);
  //��ʂ̏c�����擾
  nHeight := GetDeviceCaps(nhDc, VERTRES);
  //�s�N�Z��������̃r�b�g�����擾
  Bit := GetDeviceCaps(nhDc, BITSPIXEL);

  Result := Format('%d�~%d (%d �r�b�g)', [nWidth, nHeight, Bit]);
end;

function ExtractFileNameOnly(const FileName: string): string;
var
	Ext: string;
  fName: string;
begin
  Ext := ExtractFileExt(FileName);
  fName := ExtractFileName(FileName);
  Result := Copy(fName, 1, Length(fName) - Length(Ext));
end;

function NotErrorFileName(const FileName: string): string;  
var
	i: Integer;
  s: string;
begin
  s := FileName;
  s := StringReplace(s, #9, ' ', [rfReplaceAll]);
  for i := 1 to Length(ErrorFileChar) do begin
    s := StringReplace(s, ErrorFileChar[i], Copy(ErrorFileCharZen, ((i-1)*2+1), 2), [rfReplaceAll]);
  end;
  Result := s;
end;

function IncludeErrorFileChar(const FileName: string): Boolean;
var
	i: Integer;
begin
  Result := False;
  if AnsiPos(#9, FileName) <> 0 then begin
    Result := True;
    Exit;
  end;
  for i := 1 to Length(ErrorFileChar) do begin
    if AnsiPos(ErrorFileChar[i], FileName) <> 0 then begin
      Result := True;
      Break;
    end;
  end;
end;

function NotExistFileName(const FileName: string): string;
var
	Dir, Name, Ext, nName: string;
  i: Integer;
begin
  if ExtractFileName(FileName) = FileName then
  	Dir := ExtractFilePath(Application.ExeName)
  else
  	Dir := ExtractFilePath(FileName);
  Name := ExtractFileNameOnly(FileName);
  Ext := ExtractFileExt(FileName);

  if FileExists(FileName)then begin
    i := 2;
    nName := Name;
    while FileExists(Dir + nName + Ext)do begin
      nName := Name + '(' + IntToStr(i) + ')';
      Result := nName + Ext;
      Inc(i);
    end;
  end else begin
    Result := Name + Ext;
	end;
end;
   
function NotExistDirName(const FileName: string): string;
var
	Dir, Name, nName, s: string;
  i: Integer;
begin
  s := ExcludeTrailingPathDelimiter(FileName);
//  if Copy(FileName, Length(FileName), 1) = '\' then
//    s := Copy(FileName, 1, Length(FileName)-1);
  Dir := ExtractFilePath(s);
  Name := ExtractFileNameOnly(s);

  if DirectoryExists(s) then begin
    i := 2;
    nName := Name;
    while DirectoryExists(Dir + nName) do begin
      nName := Name + '(' + IntToStr(i) + ')';
      Result := nName;
      Inc(i);
    end;
  end else begin
    Result := Name;
	end;
end;

function GetFileVersion(const FileName: string): string;
var
  FileInfo: TFileInfo;
begin
  if FileName = '' then Exit;
  FileInfo := TFileInfo.Create;
  try
    FileInfo.FileName := FileName;
    Result := FileInfo.FileVersion;
  finally
    FileInfo.Free;
  end;
end;

function GetProductName(const FileName: string): string;
var
  FileInfo: TFileInfo;
begin
  if FileName = '' then Exit;
  FileInfo := TFileInfo.Create;
  try
    FileInfo.FileName := FileName;
    Result := FileInfo.ProductName;
  finally
    FileInfo.Free;
  end;
end;


//OS�̎擾
function OSPlatformInfo: String;
var
  OSver : TOSVERSIONINFO;
begin
  OSver.dwOSVersionInfoSize  :=  SizeOf(OSver);
  GetVersionEx(OSver);
  case OSver.dwPlatformId of
    VER_PLATFORM_WIN32s: Result := 'Windows 3.1';  //VER_PLATFORM_WIN32s 		Win32s on Windows 3.1.
    VER_PLATFORM_WIN32_WINDOWS: //VER_PLATFORM_WIN32_WINDOWS 	Windows 95, Windows 98, or Windows Me.
    begin
      case OSver.dwMinorVersion of
        0{95}: Result := 'Windows 95';
        10{98}: Result := 'Windows 98';
        90{Me}: Result := 'Windows Me';
      end;
    end;
    VER_PLATFORM_WIN32_NT://VER_PLATFORM_WIN32_NT Windows NT 3.51, Windows NT 4.0, Windows 2000, Windows XP, or Windows .NET Server.
    begin
      case OSver.dwMajorVersion of
        3{3.51}: Result := 'Windows NT 3.51';
        4{4.0}: Result := 'Windows NT 4.0';
        5{2000, XP, .NET Server, 2003}:
        begin
          case OSver.dwMinorVersion of
            0{2000}: Result := 'Windows 2000';
            1{XP or .NET Server}: Result := 'Windows XP';
            2{2003}: Result := 'Windows 2003';
          end;
        end;
        6{Vista}: Result := 'Windows Vista';
      end;

    end;
  else Result := 'Windows??';
  end;
end;

// �󂫃������e��
function MemoryActiveInfo: String;
var
  MemStatus : TMemoryStatus;
begin
  MemStatus.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MemStatus);

  Result := FormatFloat('#,##0KB',Round(MemStatus.dwAvailPhys/1024));
end;

// �����������e��
function MemoryTotalInfo: String;
var
  MemStatus : TMemoryStatus;
begin
  MemStatus.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MemStatus);

  Result := FormatFloat('#,##0KB',Round(MemStatus.dwTotalPhys/1024));
end;

// �������g�p��
function MemoryRateOfUse: String;
var
  MemStatus : TMemoryStatus;
begin
  MemStatus.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MemStatus);

  Result := IntToStr(MemStatus.dwMemoryLoad);
end;

//TFileInfo
constructor TFileInfo.Create;
begin
 inherited Create;
 FFileName:='';
 FProductVersion:= '';
 FCompanyName:= '';
 FOriginalFileName:= '';
 FFileDescription:= '';
 FFileVersion:= '';
 FInternalName:= '';
 FProductName:= '';
 FLargeIcon := TBitmap.Create;
 FSmallIcon := TBitmap.Create;
 FLargeIcon.Height := 32;
 FLargeIcon.Width := 32;
 FSmallIcon.Height := 16;
 FSmallIcon.Width := 16;
end;

destructor TFileInfo.Destroy;
begin
 FLargeIcon.Free;
 FSmallIcon.Free;
 inherited Destroy;
end;

procedure TFileInfo.GetVersionInfo;
var
 InfoSize:DWORD;
 //Wnd:HWND;
 SFI:string;
 Buf,Trans,Value:Pointer;
 VSF:PVSFixedFileInfo;
begin
 if FFileName = '' then Exit;
 FProductVersion:= '';
 FCompanyName:= '';
 FOriginalFileName:= '';
 FFileDescription:= '';
 FFileVersion:= '';
 FInternalName:= '';
 FProductName:= '';
 InfoSize := GetFileVersionInfoSize(PChar(FFileName),InfoSize);
 if InfoSize <> 0 then
 begin
  GetMem(Buf,InfoSize);
  try
   if GetFileVersionInfo(PChar(FFileName),0,InfoSize,Buf) then
   begin
    if VerQueryValue(Buf,'\',Pointer(VSF),InfoSize) then
    begin
     FVSFixedFileInfo := VSF^;
    end;
    if VerQueryValue(Buf,'\VarFileInfo\Translation',Trans,InfoSize) then
    begin
     SFI := Format('\StringFileInfo\%4.4x%4.4x\ProductVersion',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FProductVersion := PChar(Value);
     end else
     begin
      FProductVersion := 'UnKnown';
     end;
     SFI := Format('\StringFileInfo\%4.4x%4.4x\ProductName',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FProductName := PChar(Value);
     end else
     begin
      FProductName := 'UnKnown';
     end;
     SFI := Format('\StringFileInfo\%4.4x%4.4x\CompanyName',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FCompanyName := PChar(Value);
     end else
     begin
      FCompanyName := 'UnKnown';
     end;
     SFI := Format('\StringFileInfo\%4.4x%4.4x\OriginalFilename',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FOriginalFileName := PChar(Value);
     end else
     begin
      FOriginalFileName := 'UnKnown';
     end;
     SFI := Format('\StringFileInfo\%4.4x%4.4x\FileDescription',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FFileDescription := PChar(Value);
     end else
     begin
      FFileDescription := 'UnKnown';
     end;
     SFI := Format('\StringFileInfo\%4.4x%4.4x\FileVersion',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FFileVersion := PChar(Value);
     end else
     begin
      FFileVersion := 'UnKnown';
     end;
     SFI := Format('\StringFileInfo\%4.4x%4.4x\InternalName',
            [LOWORD(DWORD(Trans^)),HIWORD(DWORD(Trans^))]);
     if VerQueryValue(Buf,PChar(SFI),Value,InfoSize) then
     begin
      FInternalName := PChar(Value);
     end else
     begin
      FInternalName := 'UnKnown';
     end;
    end;
   end;
  finally
   FreeMem(Buf);
  end;
 end;
end;

procedure TFileInfo.GetIcon;
var
 IconHandle:HICON;
 SHFileInfo:TSHFileInfo;
 Temp:TPicture;
begin
 IconHandle := 0;
 Temp := TPicture.Create;
 try
//SMALL
  Temp.Bitmap.Height := FSmallIcon.Height;
  Temp.Bitmap.Width := FSmallIcon.Width;
  FSmallIcon.Canvas.Draw(0,0,Temp.Graphic);
  SHGetFileInfo(PChar(FFileName),0,
                SHFileInfo,SizeOf(SHFileInfo),
                SHGFI_ICON or SHGFI_SMALLICON);
  IconHandle := SHFileInfo.hIcon;
  DrawIconEx(FSmallIcon.Canvas.Handle,0,0,
             IconHandle,16,16,0,0, DI_NORMAL);
//LARGE
  Temp.Bitmap.Height := FLargeIcon.Height;
  Temp.Bitmap.Width := FLargeIcon.Width;
  FLargeIcon.Canvas.Draw(0,0,Temp.Graphic);
  SHGetFileInfo(PChar(FFileName),0,
                SHFileInfo,SizeOf(SHFileInfo),
                SHGFI_ICON or SHGFI_LARGEICON);
  IconHandle := SHFileInfo.hIcon;
  DrawIconEx(FLargeIcon.Canvas.Handle,0,0,
             IconHandle,32,32,0,0,DI_NORMAL);
 finally
  DestroyIcon(IconHandle);
  Temp.Free;
 end;
end;

procedure TFileInfo.SetFileName(Value:TFileName);
begin
 if Value <> FFileName then
 begin
  FFileName := Value;
  GetVersionInfo;
  GetIcon;
 end;
end;

function TFileInfo.GetFVSFixedFileInfo;
begin
 if FFileName <> '' then
  Result := FVSFixedFileInfo;
end;

procedure CreateShortcut(pszDir, pszFile, pszAppName: PChar;
                         nLoca: Integer; fCreate: Boolean);
// �����̐���
// pszDir  = �ިڸ�ب��
// pszFile = EXȨ�ٖ�
// pszAppName = ���ع���ݖ�
// nLoca   = ���Ķ�Ă̍쐬�ꏊ  CSIDL_DESKTOPDIRECTORY : �޽�į��
//                              CSIDL_PROGRAMS         : �����ƭ�
//                              CSIDL_STARTUP          : ���ı���
//                              CSIDL_SENDTO           : ��÷���ƭ���
//                                                      �u����v
// fCreate True=�쐬 False=�폜

//=========== Delphi 3 ====================================
//  uses �� ShellAPI, SHLObj, ActiveX ��ǉ�

var
  sz : array[0..MAX_PATH] of Char;
  szPath : array[0..MAX_PATH] of Char;
  hr : HResult;
  psl: IShellLink;
  ppf: IPersistFile;
  psf: IShellFolder;
  pidl: PItemIDList;
  StrRet: TStrRet;
  wsz : PWChar;
begin
  CoInitialize(nil);
  hr := CoCreateInstance(CLSID_ShellLink,
                         nil,
                         CLSCTX_INPROC_SERVER,
                         IShellLink,  // for 3.0 ActiveX  
                         psl);
  if (Succeeded(hr)) then
  begin
    StrCopy(szPath, pszDir);
    psl.SetWorkingDirectory(szPath);
    StrCat(szPath, '\');
    StrCat(szPath, pszFile);
    psl.SetPath(szPath);
    psl.SetDescription(pszAppName);
// �ŏ����ŋN���̏ꍇ
// psl.SetShowCmd(SW_SHOWMINNOACTIVE);

    hr := psl.QueryInterface(IPersistFile, ppf); // for 3.0 ActiveX
    if (Succeeded(hr)) then
    begin
      SHGetDesktopFolder(psf);
      SHGetSpecialFolderLocation(GetDesktopWindow, nLoca, pidl);
      StrRet.uType := STRRET_CSTR;
      psf.GetDisplayNameOf(pidl, SHGDN_FORPARSING, StrRet);
      StrCopy(sz, StrRet.cStr);

      StrCat(sz, '\');
      StrCat(sz, pszAppName);
      StrCat(sz, '.lnk');
      if fCreate then
      begin
        GetMem(wsz, SizeOf(WideChar) * MAX_PATH + 1);
        MultiByteToWideChar(CP_ACP, 0, sz, -1, wsz, MAX_PATH);
        ppf.Save(wsz, True);
        FreeMem(wsz);
      end;
    end;
  end;
  CoUninitialize;
  if not fCreate then
    DeleteFile(sz);
end;

procedure SetStartup(IsCreate: Boolean);
const
  MyRegFile : string = 'Software\Microsoft\Windows\CurrentVersion\Explorer';
  MyFolders : string = 'Startup';
var
  MyObject : IUnknown;
  MySLink  : IShellLink; // ShlObj
  MyPFile  : IPersistFile; // ActiveX
  Directory : String;
  WFileName : WideString;
begin
  MyObject := CreateComObject(CLSID_ShellLink); // ComObj
  MySLink  := MyObject as IShellLink;
  MyPFile  := MyObject as IPersistFile;
  MySLink.SetPath(PChar(Application.ExeName));
  //
  with TRegIniFile.Create(MyRegFile) do // Registry
  try
    Directory := ReadString('Shell Folders',MyFolders,'') + '\';
    WFileName := Directory + Application.Title + '.Lnk';
    if IsCreate then begin
      if not FileExists(WFileName) then
        MyPFile.Save(PWChar(WFileName),False);
    end else begin
      if FileExists(WFileName) then
        DeleteFile(WFileName);
    end;
  finally
    Free;
  end;
end;

// TFileTime�^��TDateTime�^�ɕϊ�����
function FileTimeToDateTime( FileTime:TFileTime ):TDateTime;
var
  LocalFileTime: TFileTime;
  SystemTime:   TSystemTime;
begin
  result := 0;
  if (FileTime.dwLowDateTime = 0) and (FileTime.dwHighDateTime = 0) then
    Exit;
  FileTimeToLocalFileTime(FileTime,LocalFileTime);
  FileTimeToSystemTime(LocalFileTime,SystemTime);
  result := SystemTimeToDateTime(SystemTime);
end;

// TDateTime�^��TFileTime�^�ɕϊ�����
function DateTimeToFIleTime(FileTime:TDateTime):TFileTime;
var
  LocalFileTime, Ft: TFileTime;
  SystemTime:   TSystemTime;
begin
  result.dwLowDateTime  := 0;
  result.dwHighDateTime := 0;
  DateTimeToSystemTime(FileTime, SystemTime);
  SystemTimeToFileTime(SystemTime, LocalFileTime);
  LocalFileTimeToFileTime(LocalFileTime, Ft);
  result := Ft;
end;

// �t�@�C���̍X�V���t�C�쐬���t, �A�N�Z�X���t���擾����
procedure GetFileDate(FileName: string; var CrDate, UpDate, AcDate: TDateTime);
var
  Ut, Ct, At: TFileTime;
  Fs: TFileStream;
begin
  Fs := TFileStream.Create(FileName, fmOpenRead);
  try
    // �t�@�C�����t���擾����
    GetFileTime(Fs.Handle, @Ct, @At, @Ut);

    CrDate := FileTimeToDateTime(Ct);
    UpDate := FileTimeToDateTime(Ut);
    AcDate := FileTimeToDateTime(At);
  finally
    Fs.Free;
  end;
end;

// �t�@�C���̍X�V���t�C�쐬���t, �A�N�Z�X���t��ύX����
procedure SetFileDate(FileName: string; CrDate, UpDate, AcDate: TDateTime);
var
  Ut, Ct, At: TFileTime;
  Fs: TFileStream;
begin
  Fs := TFileStream.Create(FileName, fmOpenReadWrite);
  try
    Ct := DateTimeToFileTIme(CrDate);
    Ut := DateTimeToFileTime(UpDate);
    At := DateTimeToFileTime(AcDate);
    // �t�@�C�����t��ύX����
    // SetFileTime�̏ڍׂ�Win32API�̃w���v���Q��
    SetFileTime(Fs.Handle, @Ct, @At, @Ut);
  finally
    Fs.Free;
  end;
end;

//���΃p�X�̒��o
function ExtractRelativePath(FullPath: string): string;
begin
  Result := StringReplace(FullPath, ExtractFilePath(Application.ExeName), '', [rfReplaceAll]);
end;

//�u%SYSTEMROOT%�v�u%SYSTEM%�v�u%TEMP%�v�����܂܂��p�X���t���p�X�ɂ���
function ExpandPath(Path: string): string;
var Dst: array[0..MAX_PATH-1] of Char;
begin
  ExpandEnvironmentStrings(PChar(Path), Dst, MAX_PATH);
  Result := Dst;
end;
 
function FullToOmit(s: string): string;
var wd, sd: string;
begin
  wd := GetWindowsDir;
  sd := GetSystemDir;
  s := StringReplace(s, ExtractFileDir(s), OMIT_DIR, []);
  s := StringReplace(s, ExtractFileDir(s), OMIT_WIN_DIR, []);
  s := StringReplace(s, sd, OMIT_WIN_SYSTEM, []);
  s := StringReplace(s, sd, OMIT_SYSTEM, []);
  s := StringReplace(s, wd, OMIT_WIN_WINDIR, []);
  s := StringReplace(s, wd, OMIT_WINDIR, []);
  Result := s;
end;

function OmitToFull(s: string): string;
var wd, sd: string;
begin
  wd := GetWindowsDir;
  sd := GetSystemDir;
  s := StringReplace(s, OMIT_SYSTEM, sd, []);
  s := StringReplace(s, OMIT_WIN_SYSTEM, sd, []);
  s := StringReplace(s, OMIT_WINDIR, wd, []);
  s := StringReplace(s, OMIT_WIN_WINDIR, wd, []);
  s := StringReplace(s, OMIT_DIR, ExtractFileDir(s), []);
  s := StringReplace(s, OMIT_WIN_DIR, ExtractFileDir(s), []);
  Result := s;
end;

function SHCopyDir(hParent:HWND;NameFrom,NameTo:string):Boolean;
var
  SFO: TSHFileOpStruct;
begin
  NameFrom := NameFrom+#0#0;
  NameTo := NameTo+#0#0;
  with SFO do begin
    Wnd := hParent;
    wFunc := FO_COPY;
    pFrom := PChar(NameFrom);
    pTo := PChar(NameTo);
    fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMMKDIR;
    fAnyOperationsAborted := false;
    hNameMappings := nil;
  end;
  Result := not Boolean(SHFileOperation(SFO));
end;

function SHDeleteDir(hParent:HWND;Name:string):Boolean;
var
  SFO: TSHFileOpStruct;
begin
  Name := Name+#0#0;
  with SFO do begin
    Wnd := hParent;
    wFunc := FO_DELETE;
    pFrom := PChar(Name);
    pTo := nil;
    fFlags := FOF_ALLOWUNDO + FOF_NOCONFIRMATION;
    fAnyOperationsAborted := false;
    hNameMappings := nil;
  end;
  Result := not Boolean(SHFileOperation(SFO));
end;

end.
