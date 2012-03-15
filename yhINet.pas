unit yhINet;

interface   

uses
  Windows, Classes, Forms, SysUtils, WinInet, UrlMon;

function GetHtml(URL: string; var Html: string): Boolean; 
function DownloadFile(SourceFile, DestFile: string): Boolean; 
function DownloadFileEx(SourceFile, DestFile: string): Boolean;

implementation

//=============================================================================
//  �t�@�C�����_�E�����[�h����֐�
//  SourceFile�Ŏw�肷��t�@�C�����Ȃ����CDestFile���������̏ꍇ��False��Ԃ�
//  �܂��l�b�g���[�N�ڑ��s�̏ꍇ��False��Ԃ�
//  uses��UrlMon���K�v
//
//  SourceFile : �_�E�����[�h����t�@�C����URL
//               ���̃T���v���̏ꍇ�� http://...  .lzh �Ƃ���������
//               �摜���_�E�����[�h�������ꍇ�� http://...  .gif ��
//               �y�[�W�̃\�[�X�Ȃ�� http://....  .html ��
//  DestFile   : �ۑ���̃t���p�X��
//               �Ⴆ�� C:\MyFolder\XXXX.lzh ���@
//=============================================================================
function DownloadFile(SourceFile, DestFile: string): Boolean;
begin
    try
      Result:=UrlDownloadToFile(nil,PChar(SourceFile),PChar(DestFile),0,nil)=0;
    except
      Result:=False;
    end;
end;
//=============================================================================
//  �C���^�[�l�b�g��̃t�@�C�����f�B�X�N�Ƀ_�E�����[�h
//  WinInet���g�p�����(uses��WinInet���K�v)
//=============================================================================
function DownloadFileEx(SourceFile, DestFile: string): Boolean;
var
     FS          : TFileStream;
     hSession    : HINTERNET;
     hService    : HINTERNET;
     dwBytesRead : DWORD;
     lpBuffer    : array[0..1023] of Char;
begin
     Result:= True;
     hSession:=InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
     if Assigned(hSession) then begin
       hService := InternetOpenUrl(hSession,PChar(SourceFile),nil,0,0,0);
       if Assigned( hService ) then begin
         //�㏑���ۑ�(�Ȃ���ΐV�K�쐬)
         FS :=TFileStream.Create(DestFile,fmCreate);
         try
           dwBytesRead := 1024;
           while True do begin
             lpBuffer:=#0;
             if InternetReadFile(hService,@lpBuffer,1024,dwBytesRead) then begin
               //���ꂪ�Ȃ��Ɠ��쒆��Form�̈ړ��Ȃǂ��s�ƂȂ�
               //Sleep(0)��0�͓K��0�`10���x�ł����悤��
               Application.ProcessMessages;
               Sleep(0);
               if dwBytesRead=0 then break;
               FS.WriteBuffer(lpBuffer,dwBytesRead);
             end else begin
               Result:=False;
               Exit;;
             end;
           end;
         finally
           FreeAndNil(FS);
         end;
       end;
     end else begin
       Result:=False;
     end;
     InternetCloseHandle(hService);
end;

function GetHtml(URL: string; var Html: string): Boolean;
var
  hSession, hReqUrl :hInternet;
  Buffer :array [0..1023] of Char;
  ReadCount :Cardinal;
  HtmlStr :string;
begin
  Result := False;
  Html := '';
  //�ڑ��̊m��
  hSession :=InternetOpen(nil, INTERNET_OPEN_TYPE_PRECONFIG,
                          nil, nil, 0);
  try
  if Assigned(hSession) then
  begin
    //URL�̃n���h�����擾
    hReqUrl :=InternetOpenUrl(hSession,PChar(URL),
                              nil, 0,INTERNET_FLAG_RELOAD, 0);
    try
    if Assigned(hReqUrl) then
    begin
      while true do begin
       //URL�n���h��������Buffer�ɓǂݍ���(�t�@�C���Ō�܂ŌJ��Ԃ�)
       InternetReadFile(hReqUrl, @Buffer, Sizeof(Buffer), ReadCount);
       //�t�@�C���̍Ō�܂ł������甲����
       if ReadCount = 0 then Break;
       HtmlStr :=HtmlStr +string(Buffer);
      end;
      Html :=HtmlStr;
      Result := True;
    end;
    finally
      InternetCloseHandle(hReqUrl);
    end;
  end;
  finally
    InternetCloseHandle(hSession);
  end;
end;

end.