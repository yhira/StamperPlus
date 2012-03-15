{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
unit IconEx;

interface

uses
  Windows, SysUtils, Classes, Graphics;

type
  EIconExError = class(Exception);

  TIconEx = class(TGraphic)
  private
    FImage: TMemoryStream;      // �A�C�R���t�@�C���C���[�W
    FHandle: HICON;             // �A�C�R���n���h��
    FWidth: Integer;            // ���A����
    FHeight: Integer;
    procedure HandleNeeded;     // �n���h�������
    procedure ImageNeeded;      // �A�C�R���t�@�C���C���[�W�����
    function GetHandle: THandle;// �n���h�����擾����
    // �A�C�R���n���h�����Z�b�g����
    procedure SetHandle(const Value: THandle);
  protected
    // �����K�{�̕W���C���^�[�t�F�[�X
    function GetWidth: Integer; override;
    function GetHeight: Integer; override;
    procedure SetWidth(Value: Integer); override;
    procedure SetHeight(Value: Integer); override;
    function GetEmpty: Boolean; override;
    function GetTransParent: Boolean; override;
    procedure SetTransparent(Value: Boolean); override;
  public
    // �����K�{�̕W���C���^�[�t�F�[�X
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

    // �A�C�R���n���h��
    property Handle: THandle read GetHandle write SetHandle;
  end;

var
  IConExClipboardFormatID: Integer; // �A�C�R���t�@�C���C���[�W��
                                    // �N���b�v�{�[�h�`��ID

procedure Register;

implementation

uses Clipbrd;

procedure Register;
begin end;


type
  // �A�C�R���t�@�C���C���[�W�̐錾
  PIconFileHeader = ^TIconFileHeader;
  TIconFileHeader = packed record
    Reserved: Word;
    wType: Word;  // ��ʁB�A�C�R�����J�[�\�����������B
    Count: Word;  // �A�C�R���̐�
  end;

  // �A�C�R���f�B���N�g���̃��R�[�h(�A�C�R�����)�̐錾
  PIconInfo = ^TIconRec;
  TIconRec = packed record
    Width: Byte;       // ��
    Height: Byte;      // ����
    Colors: Word;      // �F��
    Reserved1: Word;
    Reserved2: Word;
    DIBSize: Longint;  // �A�C�R���C���[�W�̑傫���B
                       // 2��DIB�C���[�W���܂�
    DIBOffset: Longint;// �A�C�R���C���[�W�̃t�@�C����
                       // �擪����̈ʒu
  end;



{ TIconEx }

procedure TIconEx.Assign(Source: TPersistent);
var
  Clip: TClipBoard;
  AData: THandle;
begin
  if Source is TIconEx then // ������� TIconEx
  begin
    // ���A�����ƃA�C�R���t�@�C���C���[�W���R�s�[����
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
  // ��������N���b�v�{�[�h
  else if Source is TClipBoard then begin
    Clip := Source as TClipBoard;
    Clip.Open;
    //�@�A�C�R���t�@�C���C���[�W���������
    try
      // �N���b�v�{�[�h���� ClipboardFormat �^�̃f�[�^���擾
      AData := Clip.GetAsHandle(IconExClipboardFormatID);

      // �����ŁA�f�[�^���擾�ł������̃`�F�b�N�͂��Ȃ��B
      // AData�̃`�F�b�N�� LoadFromClipboardFormat ���s���B

      // �f�[�^����������
      LoadFromClipboardFormat(IconExClipboardFormatID, AData, 0);
    finally
      Clip.Close;
    end;
  end
  else
    inherited;
end;

// �R���X�g���N�^�B�f�t�H���g�̑傫���� System Large Size
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
  if Empty then Exit; // ��Ȃ�`���Ȃ�

  DrawIconEx(ACanvas.Handle, Rect.Left, Rect.Top,
             Handle, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top,
             0, 0, DI_NORMAL);
end;

function TIconEx.GetEmpty: Boolean;
begin
  // �A�C�R���t�@�C���C���[�W����������
  if FImage.Size = 0 then
    Result := True
  else
    Result := False;
end;

function TIconEx.GetHandle: THandle;
begin
  HandleNeeded; // �A�C�R���n���h�������쐬�Ȃ���
  Result := FHandle;
end;

function TIconEx.GetHeight: Integer;
begin
  Result := FWidth;
end;

function TIconEx.GetTransParent: Boolean;
begin
  Result := True; // �A�C�R���͏�ɓ���(�h��c��������\���L��)
end;

function TIconEx.GetWidth: Integer;
begin
  Result := FHeight;
end;

// DDB �̃T�C�Y���g��k������
function ResizeDDB(Handle: HBITMAP; cx, cy: Integer): HBITMAP;
var
  Dest, Source: TBitmap;
  BitmapData: Windows.TBitmap;
begin
  Dest := TBitmap.Create;
  try
    // �R�s�[������
    GetObject(Handle, SizeOf(BitmapData), @BitmapData);
    if BitmapData.bmPlanes * BitmapData.bmBitsPixel = 1 then
      Dest.MonoChrome := True;
    Dest.Width := cx; Dest.Height := cy;
    Source := TBitmap.Create;
    try
      Source.Handle := Handle;
      try
        // �R�s�[
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

// �A�C�R���t�@�C���C���[�W����A�C�R���n���h�������
procedure TIconEx.HandleNeeded;
var
  Header: TIconFileHeader;       // �A�C�R���̃t�@�C���w�b�_
  IconDir: array of TIconRec;    // �A�C�R���f�B���N�g��
  IconImage: array of Byte;      // �A�C�R���� DIB���
  XORBitmap, ANDBitmap: HBITMAP; // �A�C�R����XOR�C���[�W
  pDIBHeader: PBitmapInfoHeader; // �A�C�R����AND�C���[�W
  nColors: Integer;              // �F��
  DC: HDC;                       // GetDC(0)�̃n���h��
  pBits: PChar;                  // �A�C�R���� DIB �̃s�N�Z��
                                 //  �f�[�^
  IconInfo: TIconInfo;           // CreateIocn �p Icon���

  DummyIndex:Integer;
  IconIndex: Integer;            // �I�����ꂽ�A�C�R���C���[�W��
                                 // �\���C���f�b�N�X
  BestColorCount: Integer;       // �A�C�R���C���[�W�I�𒆂�
                                 // �ł��ǂ��F��
  MaxColorCount: Int64;          // �A�C�R���C���[�W�I������
                                 // �A�C�R���̐F���̌��E�l
  ColorCount: Integer;           // �������̃A�C�R���C���[�W�̐F��
  i: Integer;
  temp: THandle;

// TRGBQUAD �̍�
const Black: TRGBQuad =
  (rgbBlue: 0; rgbGreen: 0; rgbRed: 0; rgbReserved: 0);

// TRGBQUAD �̔�
const White: TRGBQuad =
  (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0);

var MonoBitmap: TBitmap; // �}�X�N�r�b�g�}�b�v�����m�N�����p�B
begin
  DC := GetDC(0);
  try
    if FHandle <> 0 then Exit;
    if Empty then raise EIconExError.Create('TIconEx is Empty');

    FImage.Position := 0;
    // �t�@�C���w�b�_��ǂ�
    FImage.ReadBuffer(Header, SizeOf(Header));
    // �A�C�R���f�B���N�g����ǂ�
    SetLength(IconDir, Header.Count);
    FImage.ReadBuffer(IconDir[0], SizeOf(TIconRec) * Header.Count);

    // �r�f�I���[�h����F�̍ő�l���Z�o����
    MaxColorCount := Int64(1) shl (GetDeviceCaps(DC, PLANES) *
                                   GetDeviceCaps(DC, BITSPIXEL));
    // 256�F���z����F������ʂ��Ȃ�
    if MaxColorCount > 256 then
      MaxColorCount := 99999;

    // �Ƃ肠�����ŏ��̃A�C�R�������ɂ���
    IconIndex := 0;
    BestColorCount := IconDir[0].Colors;
    // 256�F�ȏ�̐F������ʂ��Ȃ�
    if BestColorCount >= 256 then BestColorCount := 99999;

    // �A�C�R���f�B���N�g���̒��̑S�ẴA�C�R���C���[�W��
    // ������悳�����Ȃ��̂�T���B
    for i := 1 to Header.Count-1 do
    begin
      // �A�C�R���C���[�W�̐F�����擾����
      // 256�F�ȏ�̐F������ʂ��Ȃ�
      ColorCount := IconDir[i].Colors;
      if (ColorCount = 0) or (ColorCount >= 256) then
        ColorCount := 99999;

      // ���ǂ��A�C�R���C���[�W�̏����F
      // �F���ő�F���ɋ߂�
      // �T�C�Y���c���Ƃ��w��T�C�Y�ɋ߂�
      // �T�C�Y���������Ȃ珬�����ق����ǂ�
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
        // ���ǂ����̂����������I
        IconIndex := i;
        BestColorCount := ColorCount;
      end;
    end;

    // �A�C�R���C���[�W��ǂݍ���
    FImage.Seek(IconDir[IconIndex].DIBOffset, soFromBeginning);
    SetLength(IconImage, IconDir[IconIndex].DIBSize);
    pDIBHeader := @IconImage[0];
    FImage.ReadBuffer(IconImage[0], IconDir[IconIndex].DIBSize);

    with pDIBHeader^ do
    begin
      // XOR�C���[�W���r�b�g�}�b�v������

      // ������XOR ��AND�C���[�W��2���ɂȂ��Ă���̂�2�Ŋ���
      biHeight := biHeight div 2;
      // �F�r�b�g���͌�Ŏg���̂ŃZ�[�u���Ă���
      // �F�����v�Z
      if biBitCount > 8 then nColors := 0
                        else nColors := 1 shl biBitCount;

      biSizeImage := 0;
      // �s�N�Z���f�[�^�̐擪�ʒu���v�Z����
      pBits := PCHAR(LongInt(pDIBHeader) +
                     SizeOf(TBitmapInfoHeader) +
                     SizeOf(TRGBQUAD) * nColors);

      // �r�b�g�}�b�v�w�b�_�ƃs�N�Z���f�[�^���� Xor �C���[�W�� DDB �ɕϊ�����B
      XORBitmap := CreateDIBitmap(DC, pDIBHeader^, CBM_INIT,
                                  pBits,
                                  PBitmapInfo(pDIBHeader)^,
                                  DIB_RGB_COLORS);

      if XorBitmap = 0 then
        raise EIconExError.Create('Cannot Create XorBitmap');
      try
        // AND �̃s�N�Z���f�[�^�� XOR �̃s�N�Z���f�[�^��
        // ���ɂ���̂ŁA���̈ʒu���v�Z����
        pBits := PChar(LongInt(pBits) +
                       biHeight * ((biBitCount * biWidth + 31) div 32) * 4);

        // AND�C���[�W�̓��m�N���Ȃ̂ŁADIB�����C������
        biBitCount := 1;     // ���m�N��
        // ���m�N���ɏC��
        biSizeImage := 0;
        biClrUsed := 2;      //  ���m�N��
        biClrImportant := 2;

        // ���m�N���p�ɃJ���[�e�[�u��������������
        PBitmapInfo(pDIBHeader).bmiColors[0] := Black;
        DummyIndex := 1;
        PBitmapInfo(pDIBHeader).bmiColors[DummyIndex] := White;

        // �r�b�g�}�b�v�w�b�_�ƃs�N�Z���f�[�^���� AND �C���[�W�� DDB �ɕϊ�����B
        ANDBitmap := CreateDIBitmap(DC, pDIBHeader^, CBM_INIT,
                                    pBits,
                                    PBitmapInfo(pDIBHeader)^,
                                    DIB_RGB_COLORS);

        if AndBitmap = 0 then
          raise EIconExError.Create('Cannot Create AndBitmap');
        try
          // Width, Height �ɂ��킹�� DDB �L�k����B
          XorBitmap := ResizeDDB(XorBitmap, FWidth, FHeight);
          AndBitmap := ResizeDDB(AndBitmap, FWidth, FHeight);

          MonoBitmap := TBitmap.Create;
          try

            // ���̒i�K�� AndBitmap �̓X�N���[���݊� DDB ����
            // Windows 95 �n��� Windows �� AndBitmap �����m�N���r�b�g�}�b�v
            // �Ɖ��肵�Ă���̂ŁA���m�N��������K�v������B�������Ȃ���
            // �������ȃA�C�R�����ł��Ă��܂��B
            // NT�n��ł͕s�v�ȏ��u�����݊����̂��߂ɕK�v
            MonoBitmap.Handle := AndBitmap;
            AndBitmap := 0;
            MonoBitmap.Monochrome := True;

            // CreateIcon �p�ɃA�C�R�������쐬����
            IconInfo.fIcon := True;
            IconInfo.xHotspot := 0;
            IconInfo.yHotspot := 0;
            IconInfo.hbmMask := MonoBitmap.Handle;
            IconInfo.hbmColor := XorBitmap;

            // �A�C�R�����쐬����
            temp := CreateIconIndirect(IconInfo);
            if temp = 0 then
              raise EIconExError.Create('Cannot Create Icon Handle');
            // �o���オ��(^^
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

// �A�C�R���n���h������A�C�R���t�@�C���C���[�W�����
procedure TIconEx.ImageNeeded;
var
  IconInfo: TIconInfo;          // �A�C�R�����
  Header: TIconFileHeader;      // �A�C�R���w�b�_
  IconRec: TIconRec;            // �A�C�R�����(�A�C�R���f�B���N�g���p)
  BitmapData: Windows.TBITMAP;  // DDB �̃f�[�^
  ColorScanlineLength: Integer; // XOR �C���[�W�� Scanline �̃T�C�Y
  MonoScanlineLength: Integer;  // AND �C���[�W�� Scanline �̃T�C�Y
  // �r�b�g�}�b�v���
  BitmapInfo: array[0..SizeOf(TBitmapInfoHeader) +
                       SizeOf(TRGBQUAD) * 259-1] of Byte;
  // �r�b�g�}�b�v�̃s�N�Z���f�[�^
  BitmapBits: array of Byte;
  pHeader: PBitmapInfoHeader;
  DC: HDC;
begin
  if FImage.Size > 0 then Exit;

  if FHandle = 0 then
    raise EInvalidOperation.Create('No Handle');

  // �܂��A�C�R���n���h������2�̃r�b�g�}�b�v(XOR, AND)��
  // �擾����
  GetIconInfo(FHandle, IconInfo);
  try
    try
      // �X�g���[���ɃA�C�R���w�b�_����������
      Header.Reserved := 0;
      Header.wType := 1;
      Header.Count := 1; // �C���[�W��1�I
      FImage.WriteBuffer(Header, SizeOf(Header));

      GetObject(IconInfo.hbmColor, SizeOf(BitmapData), @BitmapData);

      // �A�C�R���������� Width/Height�v���p�e�B���X�V����B
      FWidth := BitmapData.bmWidth;
      FHeight := BitmapData.bmHeight;

      // �A�C�R����������ăX�g���[���ɏ�������
      IconRec.Width := FWidth;
      IconRec.Height := FHeight;

      IconRec.Colors := 16; // �F����16�F�Œ�

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
        // XOR �C���[�W(DDB) �� DIB �ɕϊ����X�g���[���ɏ���
        pHeader := PBitmapInfoHeader(@BitmapInfo);
        pHeader.biSize := SizeOf(TBitmapInfoHeader);
        pHeader.biWidth := FWidth;
        pHeader.biHeight := FHeight;
        pHeader.biPlanes := 1;
        pHeader.biBitCount := 4; // 16�F�Œ�
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


        // AND �C���[�W(DDB) �� DIB �ɕϊ����X�g���[���ɏ���
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

// �A�C�R���t�@�C���C���[�W��ǂݍ���
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

// �N���b�v�{�[�h�f�[�^(�A�C�R���t�@�C���C���[�W)���Z�[�u����
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

//�A�C�R���t�@�C���C���[�W���X�g���[���ɏ����o��
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
      if FHandle <> 0 then // 0 ����������� TIcon�͋�ɂȂ�
        ImageNeeded;       // <> 0 �Ȃ�t�@�C���C���[�W���쐬�����
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

// �����̕ύX
procedure TIconEx.SetHeight(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if FHandle <> 0 then    //�n���h����j�����āA�V����
    begin                   //�n���h���̍쐬�𑣂�
      DestroyIcon(FHandle);
      FHandle := 0;
    end;
    Changed(Self);
  end;
end;

procedure TIconEx.SetTransparent(Value: Boolean);
begin
  // �������Ȃ��B
end;

// ���̕ύX
procedure TIconEx.SetWidth(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if FHandle <> 0 then      //�n���h����j�����āA�V����
    begin                     //�n���h���̍쐬�𑣂�
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
