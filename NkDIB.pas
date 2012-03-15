/////////////////////////////////////////////////////////////
//
// Unit NkDIB  -- DIB �p �O���t�B�b�N�N���X
//
// Coded By T.Nakamura
//
//
//  ����
//
//  Ver 0.11: Mar. 22 '97  ����   ����
//
//  Ver 0.12: Mar. 24 '97  ���Q�� �啝�ȃo�O�C���B
//                         BitCount Property �� Write ������ǉ��B
//  Ver 0.13: Mar. 25 '97  ���R�� ConvertTo8BitRGB �̃������[���[�N���C��
//  Ver 0.21: Mar. 29 '97  ���S��Palette Property �ւ̏������݂��T�|�[�g
//                         TNkDIBCanvas ��ǉ�
//                         1 bpp DIB ���T�|�[�g
//  Ver 0.22: Apr. 7  '97  TNkDIBCanvas �� TNkDIB �Ԃ� DIB �̋��L���l������
//                         ���Ȃ������C��
//  Ver 0.23: Apr. 27 '97  ��6�� ENkDIBOutOfResource ��O��p�~�B��ʓI��
//                         EOutOfResources �ɒu���������B
//  Ver 0.31: May. 2  '97  ���V�ŁB�݌v���� DIB �t�@�C��(*.dib) ��ǂݍ��ދ@�\
//                         ��ǉ��B�܂��ATNkDIBCanvas �� Destructor �̃o�O��
//                         �C���B
//  Ver 0.32: May.  4  '97  ���W�ŁBTNkGraphic �̐錾�� NkGraphic.pas �ɕ���
//
//  Ver 0.34: Jun. 29  '97  ��10�ŁBDelphi 3.0J �ɑΉ����邽�߁A�኱�C���B
//                          ClipboradFormat Property ��V�݁B
//  Ver 0.41: Aug. 25  '97  ��11�ŁBTNkCanvas ���������BPixels Property ������
//                          ScanLine Property ��V�݁B
//  Ver 0.42: Aug. 28  '97  ��12�ŁBPixels Property ������ɍ�����
//  Ver 0.44: Sep. 17  '97  ��14�ŁBTNkDIB.Draw �̃p���b�g�̃o�O���C���B
//  Ver 0.45: Sep. 18  '97  ��15�ŁBBitCount Property �� 1bpp �����e����
//                          �悤�ɏC�����܂����B
//  Ver 0.51: Oct. 12  '97  ��16�ŁB16bpp/32bpp ���T�|�[�g
//                          Delphi 3.0J �� Palette Modified Property ��
//                          �T�|�[�g(^^;
//  Ver 0.52: Oct. 13  '97  ��17�ŁB��16�ŉ����R��C�� �\����Ȃ� (^^;
//  Ver 0.53: Nov.  1  '97  ��18�ŁB C++Builder �s��Ώ�
//  Ver 0.61: Jan. 12  '98  �����
//      (1) PixelFormat Proeprty �ǉ��B������`���Ԃŕϊ����\�ɂȂ����B
//          �֘A���� ConvertMode Property(True Color ����̌��F���x�̎w��)��
//          �֘A����BgColor Property(1bpp �񈳏k�ւ̕ϊ��� �w�i�F���w��)
//          ��ǉ������B
//      (2) ���F������ OnProgress Event ���N����悤�ɂȂ����B
//      (3) Pixels Property ���S�񈳏k�`���ŗ��p�\�ɂȂ����B
//
//      ���ӁF(1) ��݊����L��BTrue Color �ɃJ���[�e�[�u�����t���Ă���ꍇ
//                0.53 �ł͂��̐F�Ɍ��F�������A0.61 �ł͎����ōœK���p���b�g��
//                ���B
//            (2) �Â��Ȃ��� ���\�b�h�L��B�ȉ��̃��\�b�h�́u���Łv�Ŕp�~����
//                �\��
//                �ECreateTrueColorPaletteHigh/CreateTrueColorPaletteLow
//                  -> CreateTrueColorPalette �� ConvertMode �ɏW�񂵂��B
//                �EConvertTo8BitRGB/ConvertToTrueColor
//                  -> PixelFormat Property �ɋ@�\���z�������B
//
//  Ver 0.62: Jan. 18  '98   LoadFromClipboardFormat �̃o�O��Ώ�
//  Ver 0.63: Jan. 31  '98   TNkDIB.AssignTo ���\�b�h�ŁADelphi 3.X �̏ꍇ
//                           ����悪 TBitmap �̏ꍇ�ATBitmap ��TNkDIB ��
//                           DIB �ɍł��߂� DIB �`���ɂȂ�悤�� TBitmap ��
//                           PixelFormat ��ݒ肵�Ă���R�s�[����悤��
//                           ���܂����B�������邱�ƂŁA�F�̕i���𗎂Ƃ�����
//                           �����r�b�g�}�b�v���R�s�[����܂��B
//  Ver 0.64: May. 3 '98
//      (1)�n�[�t�g�[����������ǉ�
//      (2)AssignTo �ő���悪 TBitmap �ŁATBitmap �� Width/Height ���O�łȂ�
//         �ꍇ�ɗ�O�����������Ώ�
//      (3)IDE �� �A�v���P�[�V�����I�����Ƀ������s���A�N�Z�X���N�������Ώ��B//         Delphi 3.X �ł� VCL ���p�b�P�[�W�Ƃ��ĕ����ɕʂ�Ă��邱�Ƃ���
//         NkDIB ���j�b�g�� Finalization �̏����� Graphics ���j�b�g�ɓo�^���ꂽ
//         NkDIB �̊g���q�A�N���b�v�{�[�h�t�H�[�}�b�g�̏���
//         TPicture.UnRegisterGraphicClass �Ŏ�菜���K�v���L��B
//         # Borland ���� ���������d�v�ȏ��͌݊������ɂ������菑���Ă���I�I//      (4)�R���p�C���w�߂��\�[�X�ɖ��ߍ���(^^;
//      (5)NkDIB.inc ��ǉ� TNkDIB �� Version �������ʂ��邽�߂̃V���{����
//         ������B�ڍׂ� NkDIB.inc ���Q�Ƃ̂��ƁB
// Ver 0.65: May. 5 '98  C++Builder 3.0J �ɑΉ�
// Ver 0.66: Sep. 27 '98 Delphi 4.0J �ɑΉ��B
// Ver 0.70: Nov. 3 '99
//      (1) Delphi 2/ C++Builder 1 �̃T�|�[�g�ł��؂�܂����B
//      (2) Assign ���\�b�h�� OnChange �C�x���g���������Ȃ��o�O���C��
//      (3) TNkDIB ���ύX�����Ƃ�(OnChange �C�x���g���N����Ƃ�)
//          Modified property �� True �ɂȂ�Ȃ��o�O���C��
//      (4) ConvertTo8BitRGB, ConvertToTrueColor, 
//          CreateTrueColorPaletteHigh, CreateTrueColorPaletteLow
//          Compression ��p�~
//      (5) XPelsPerMeter/YPelsPerMeter �v���p�e�B�̒ǉ�
//      (6) �r�b�g�t�B�[���h�`���� DIB ��ǂނƂ��A
//          RGB �l�� 24bpp �ɕϊ�����Ƃ��̃��W�b�N�����P�B
//          (0.66 �܂ł͎኱�Â߂ɕϊ�����Ă���)
//      (7) UseFMO �v���p�e�B�̐V��
//      (8) LoadFromStream �� �s�N�Z�����̓ǂݍ��݈ʒu�� bfOffBits ��
//          �]���悤�ɕύX
// Ver 0.71: Nov. 8 '99
//      (1) UseFMO �֌W�� �����o�O�C��(^^;
//      (2) LoadFromClipboardFormat �� ���������[�N��
//          �N���Ȃ��悤�ɏC���B
//      (3) LoadFromStream �� ��O�������� ���������[�N��
//          �N���Ȃ��悤�ɏC���B
// Ver. 0.72 1999.11.13
//      (1) NkDefaultUseFMO �֐���ǉ��B�}�j���A���������B
// Ver. 0.73 2001.7.7
//�@�@�@(1) Delphi 6�@���{��x�[�^�œ���m�F�B�}�j���A���C���B


// �R���p�C���w��
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


{$INCLUDE NkDIB.inc}  // Version ��`�̓ǂݍ���


unit NkDIB;

interface
uses Windows, SysUtils, Classes, Controls, Graphics, NkGraph;

// �r�b�g�}�b�v�w�b�_�̑傫���̍ő�l�B�J���[�e�[�u���̑傫���� 259 ��
// ���Ă���̂̓r�b�g�t�B�[���h�� 3 DWORD �����ꍇ�����邽�߁B
const NkBitmapInfoSize = SizeOf(TBitmapInfoHeader) + 259 * SizeOf(TRgbQuad);

type
  // ��O
  ENkDIBError               = class(Exception);
  ENkDIBInvalidDIB          = class(ENkDIBError);   // �s���� DIB
  ENkDIBInvalidDIBFile      = class(ENkDIBError);   // �s���� DIB �t�@�C���w�b�_
  ENkDIBInvalidDIBPara      = class(ENkDIBError);   // �s���p�����[�^
  ENkDIBBadDIBType          = class(ENkDIBError);   // DIB Type ���K���Ă��Ȃ�
  ENkDIBPaletteIndexRange   = class(ENkDIBError);   // Palette Index Range Error
  ENkDIBPixelPositionRange  = class(ENkDIBError);   // Pixel �ʒu Range Error
  ENkDIBInvalidPalette      = class(ENkDIBError);   // SetPalette �ŕs���p���b�g
  ENkDIBCompressionFailed   = class(ENkDIBError);   // RLE ���k���s
  ENkDIBCanvasFailed        = class(ENkDIBError);   // Canvas �쐬�s�\ 

  TNkInternalDIB = class;


  // TrueColor �̃r�b�g�}�b�v�f�[�^�A�N�Z�X�p�̃��R�[�h�^
  // Scanline Property �� TrueColor �̃f�[�^���A�N�Z�X����Ƃ��ɕ֗�
  TNkTriple = packed record
    B, G, R: Byte;
  end;
  TNkTripleArray = array[0..40000000] of TNkTriple;
  PNkTripleArray = ^TNkTripleArray;

  // Pixel Format Propety �̌^
  //  nkPf1Bit: 1bpp �񈳏k, nkPf4Bit: 4bpp �񈳏k,  nkPf4BitRLE: 4bpp RLE���k
  //  nkPf8Bit: 8bpp �񈳏k, nkPf8BitRLE: 8bpp: RLE ���k
  //  nkPf24Bit: True Color
  //  nkPfHalftone: 215�F�ւ̃n�[�t�g�[����
  //  nkPfHalftoneBW: �����ւ̃n�[�t�g�[����
  TNkPixelFormat = (nkPf1Bit, nkPf4Bit, nkPf4BitRLE, nkPf8Bit, nkPf8BitRLE,
                    nkPf24Bit, nkPfHalftone, nkPfHalftoneBW);

  // Convertmode property �̌^�B
  // nkCmNormal: TrueColor �� 16Bit���x�Ō��F����B
  // nkCmFine:   TrueColor �� 24Bit���x�Ō��F����B
  TNkConvertMode = (nkCmNormal, nkCmFine);


  // Halftone Mode �̌^
  // nkHtNoHalftone: �f�t�H���g�l�B�n�[�t�g�[���\�����s��Ȃ��B
  // nkHtHalftone:   215 �F�n�[�t�g�[���\�����s��
  // nkHtHalftoneBW: ����2�F�̃n�[�t�g�[���\�����s���B
  TNkHalftoneMode = (nkHtNoHalftone, nkHtHalftone, nkHtHalftoneBW);


//--------------------------------------------------------------------
// Note:
//
// TNKDIB �̓r�b�g�}�b�v�f�[�^�̑S�Ă� TNkInternalDIB �̒��ɓ���A����
// �I�u�W�F�N�g�Q�Ƃ�ێ�����BTNkInternalDIB �͕����� TNkDIB ���狤�L�����
// ���Ƃ�����B
//
//   +------+
//   |TNkDIB|-------+
//   +------+       |     +-------------------------+
//                  +---->|TNkInternalDIB           |
//   +------+       +---->|�r�b�g�}�b�v���^�f�[�^ |
//   |TNkDIB|-------+     |�Q�ƃJ�E���g             |
//   +------+             + ------------------------+
//
// TNkInternalDIB �̋��L�� TNkDIB.Assign ���\�b�h�ŃR�s�[����Ƃ���
// �s����B�܂� TNkDIB �̓R�s�[����邪 TNkInternalDIB �̓R�s�[���ꂸ
// TNkInternalDIB �̎Q�ƃJ�E���g��������B�t�� TNkDIB �� destroy ������
// �Q�ƃJ�E���g������A�O�ɂȂ�� TNkInternalDIB �� Destroy �����B
// �r�b�g�}�b�v���^�f�[�^���ύX�����ꍇ�� TNkDIB �� TNkInternalDIB ��
// �R�s�[���ċ��L���������A������� TNkInternalDIB ��ύX����B
// �����_�@�͈ȉ��̒ʂ�
// (1) Pixels Property �ւ̏������݁B(2) BitCount Property �̕ύX
// (3) PaletteSize/Colors/Palette Property �̕ύX�B(4) LodFromStream ���\�b�h
// (5) LoadFromClipboardFormat (6) PixelFormat Propety �̕ύX
// (7) Scanline Property �̎Q�� (8) CreateTrueColorPalette(High/Low) ���\�b�h
// (9) TNkDIBCanvas �̃R���X�g���N�g
//
// ������ UniqueDIB ���\�b�h���S�����Ă���B
//
// TNkDIB �͂قƂ�ǂ̏����� TNkInternalDIB �Ɉϑ�����B
//
// ���̕����̓������̐ߖ�ɂȂ邪�A�p���b�g�̕ω��� TNkDIB.PaletteModified
// property �ɓ`������A�t TNkDIB �� BGColor(�w�i�F)/ConvertMode(�ϊ����[�h)
// Property �� ProgressHandler �|�C���^�� TNkInternalDIB �ɓ`����̂�
// �ʓ|�ł���B�܂� OnChange �C�x���g�� TNkDIB ���S������Ȃ� ������
// �؂蕪���ɒ��ӂ��K�v�B


/////////////////////////////////////////////////////////////////////////
//
// DIB ��p �̃O���t�B�b�N�N���X
//
  TNkDIB = class(TNkGraphic)
  private
    //////////
    // �ϐ�

    InternalDIB: TNkInternalDIB;                // Internal DIB �� Obj. Ref.
    FConvertMode: TNkConvertMode;               // TrueColor -> 4/8 bpp ��
                                                // ���F����Ƃ��̕ϊ����[�h
    FBGColor: TColor;                           // �w�i�F 1bpp �֕ϊ�����Ƃ���
                                                // '1' �ɕϊ������F���w��
    FHalftoneMode: TNkHalftoneMode;             // �n�[�t�g�[�����[�h

    //////////
    // ���L�֌W
    procedure ReleaseInternalDIB;               // Internal DIB ��؂藣���B
    procedure UniqueDIB;                        // DIB ���L����Ă���ꍇ�A
                                                // �R�s�[����B

    //////////
    // Property �p�w���p���[�`���Q

    // PaletteSize Property
    function GetPaletteSize: Integer;           // �p���b�g�T�C�Y�̎擾
    procedure SetPaletteSize(value: Integer);   // �p���b�g�T�C�Y�̐ݒ�

    // BitCountProperty
    function GetBitCount: Integer;              // BitCount �̎擾
    procedure SetBitCount(Value: Integer);      // BitCount �̕ύX
                                                // �r�b�g�}�b�v�f�[�^��
                                                // �p���b�g�͏����������I�I

    // Colors Property
    function GetColors(Index: Integer): TColor;        // Palette Entry �̎擾
    procedure SetColors(Index: Integer; Value: TColor);// Palette Entry �̐ݒ�

    // PixelFormat Property
    function GetPixelFormat: TNkPixelFormat;         // PixelFormat �̎擾
    procedure SetPixelFormat(Value: TNkPixelFormat); // PixelFormat �̕ϊ�

    // Pixels Property
    function GetPixels(x, y: Integer): LongInt;         // Pixel �l�̎擾
    procedure SetPixels(x, y: Integer; Value: LongInt); // Pixel �l�̐ݒ�

    // ScanLine Property
    function GetScanLine(y: Integer): Pointer; // Scanline �|�C���^�̎擾
                                               // y �� Top-Down �Ŏw�肷��

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
    // ���̑�

    // PaletteModified �̍X�V
    procedure UpdatePaletteModified;

  protected

    //////////
    // Progress �Ǘ��p�ϐ��Q

    // �v���O���X�� �� ���v�Z����̂Ɏg�p
    NumberOfProgresses: Integer;    //���݂̃v���O���X��
    MaxNumberOfProgresses: Integer; //�ő�v���O���X��
    // ���݂̃v���O���X�̖��O OnProgress �C�x���g�Œʒm����镶��
    ProgressString: string;


    //////////
    // TNkGraphic �̕W�� Propety �̃w���p���[�`���Q

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
    // TNkGraphic �̕W�� Protected ���[�`���Q

    // Canvas �ւ̕`��
    procedure Draw(ACanvas: TCanvas; const R: TRect); override;

    // ClipboardFormat Property
    function GetClipboardFormat: UINT; override;


    //////////
    // �v���O���X�֌W

    // �v���O���X�ϐ��̏������B
    procedure InitializeProgressHandler(AMaxNumberOfProgresses: Integer;
                                        AProgressString: string);

    // �v���O���X�n���h�� OnProgress �Œʒm������e���쐬�� Progress ���Ă�
    procedure ProgressHandler(Sender: TObject);

    // �v���O���X�J�n Stage := psStarting, PercentDone = 0 �� OnProgress ��
    // �N�����B
    procedure StartProgress;

    // �v���O���X�I�� Stage := psEnding, PercentDone = 100 �� OnProgress ��
    // �N�����BTNkDIB �ł͂��Ǝ����� RedrawNow �� True �ɂȂ�B
    procedure EndProgress;

  public
    constructor Create; override;                         // �R���X�g���N�^
    destructor Destroy; override;                         // �f�X�g���N�^


    //////////
    // I/O

    // �X�g���[������ DIB�i�t�@�C���w�b�_�L��j��ǂ�
    procedure LoadFromStream(Stream: TStream); override;

    // �X�g���[���� DIB�i�t�@�C���w�b�_�L��j������
    procedure SaveToStream(Stream: TStream); override;

    // ClipBoard �Ƃ� I/O
    procedure LoadFromClipboardFormat(AFormat: Word;
                                      AData: THandle;
                                      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var Format: Word;
                                    var Data: THandle;
                                    var APalette: HPALETTE); override;


    //////////
    // ���
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;


    //////////
    // �ϊ�

    // True Color DIB �� �p���b�g���쐬
    procedure CreateTrueColorPalette;     // ���x�� ConvertMode �ɏ]����
                                          // �œK���J���[�e�[�u�����쐬

    //////////////////////
    // Propeties

    //////////
    // �W�� Property

    // Note: Palette Property �� TNkGraphic �Œ�`
    property Empty: Boolean read GetEmpty;
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;

    // DIB �̃p���b�g�̃T�C�Y
    property PaletteSize: Integer read GetPaletteSize write SetPaletteSize;

    // DIB �� Pixel ������̃r�b�g��
    property BitCount: Integer read GetBitCount write SetBitCount;

    // �w�i�F   nkPf1Bit �ւ̕ϊ��� ���ɂȂ�F
    property BGColor: TColor read FBGColor write FBGColor;

    // DIB �̃J���[�e�[�u���̊e�G���g���̐F
    property Colors[Index: Integer]: TColor read GetColors write SetColors;

    // True Color ����̌��F���@(���F�p���b�g�̍쐬���@)�̑I��
    property ConvertMode: TNkConvertMode read FConvertMode write FConvertMode;

    // DIB �̃s�N�Z���`��
    property PixelFormat: TNkPixelFormat read GetPixelFormat
                                         write SetPixelFormat;

    // DIB �̃s�N�Z���̒l x,y �� Top-Down �̍��W
    property Pixels[x, y: Integer]: LongInt read GetPixels write SetPixels;

    // DIB �̃X�L�������C���ւ̃|�C���^ y �� Top-Down �̏c���W
    property ScanLine[y: Integer]: Pointer read GetScanLine;

    // �n�[�t�g�[�����[�h
    property HalftoneMode: TNkHalftoneMode read FHalftoneMode
                                           write SetHalftoneMode;

   // �s�N�Z���̑傫��
   property XPelsPerMeter: LongInt read GetXPelsPerMeter
                                   write SetXPelsPerMeter;
   property YPelsPerMeter: LongInt read GetYPelsPerMeter
                                   write SetYPelsPerMeter;

   // File Mapping Object ���g�����w�肷��
   property UseFMO: Boolean read GetUseFMO write SetUseFMO;
  end;

///////////////////////////////////////////////////////////////////////
//
// TNkDIB �p Canvas   ---- TNkDIBCanvas
//

  TNkDIBCanvas = class(TCanvas)
  private
    MemDC: HDC;              // DIBSection ��I�����郁�����f�o�C�X�R���e�L�X�g
    hDIBSection: HBitmap;    // DIBSection TNkDIB ����쐬����B
    DIB: TNkDIB;             // TNkDIB �ւ̎Q��
    OldBitmap: HBITMAP;      // ������ DC �Ɍ��X�I������Ă���
                             // �r�b�g�}�b�v
    OldPalette: HPalette;    // ������ DC�Ɍ��X�I������Ă���
                             // �p���b�g
    pBits: Pointer;          // �r�b�g�}�b�v�f�[�^�ւ̃|�C���^�B
  public
    // DIB �̃L�����o�X�̍쐬
    constructor Create(ADIB: TNkDIB);
    // DIB �̃L�����o�X�̔j��
    destructor Destroy; override;
  end;


///////////////////////////////////////////////////////////////////////
//
// DIB �̏���ێ����郌�R�[�h
//
  TNkDIBInfos = record
    BitsSize: LongInt;                  // �s�N�Z������ �T�C�Y
                                        // biSizeImage �͂����Ă� 0 �Ȃ̂�
                                        // �v�Z�����l�������ɕێ�����B
    hFile: THandle;                     // �s�N�Z�����̃t�@�C���}�b�s���O
                                        // �I�u�W�F�N�g�̃n���h���B
    pBits: Pointer;                     // �s�N�Z�����ւ̃|�C���^
    case Integer of
      1:(W3Head: TBitmapInfoHeader;);   // Windows 3.X �`��
      2:(W3HeadInfo: TBitmapInfo;);
      3:(PMHead: TBitmapCoreheader;);   // PM 1.X �`��
      4:(PMHeadInfo: TBitmapCoreInfo;);
        // BitmapInfoHeader �� �J���[�e�[�u���i�ő�256��)�ƃr�b�g�t�B�[���h��
        // �ێ�����G���A���m�ۂ��邽�߂̃_�~�[
      5:(Dummy: array[0..NkBitmapInfoSize] of Byte;); 
  end;




///////////////////////////////////////////////////////////////////////
//
// DIB ��ێ�����N���X�BTNkDIB �̎��́BTNkDIB �͎Q�ƃJ�E���g������
// TNkInternalDIB �����L����B

  TNkInternalDIB = class(TObject)
  private
    RefCount: Integer;            // �Q�ƃJ�E���g TNkInternalDIB ��ێ�����
                                  // TNkDIB �̐�
    Width, Height: Integer;       // �r�b�g�}�b�v�̕��A�����B�������̂���
                                  // biWidth/biHeight �̃R�s�[��������
                                  // �ێ�����B�A�� Height := abs(biHeight);
    Palette: HPalette;            // �J���[�e�[�u�����������_���p���b�g
    DIBInfos: TNkDIBInfos;        // DIB �̖{�� �����ɑS�Ă̏�񂪂���B

    PaletteModified: Boolean;     // �p���b�g�̕ύX���L�������̋L�^�B

    UseFMO: Boolean;              // FMO �𗘗p���邩������

    // ���n��DIB ���쐬 �J���[�e�[�u���������������̂Œ��ӁI
    procedure CreateDIB(AWidth, AHeight, BitCount, NumColors: LongInt);

    // DIB ��j���B�r�b�g�}�b�v�f�[�^�ƃp���b�g��j������B
    procedure FreeDIB;

    // Stream ���� DIB(�t�@�C���w�b�_�t���j��ǂݍ���
    procedure LoadFromStream(stream: TStream);

    // Stream �� DIB(�t�@�C���w�b�_�t���j����������
    procedure SaveToStream(stream: TStream);

    // DIB �̃J���[�e�[�u������ Palette �̍쐬
    function MakePalette: HPalette;

    // Palette �̍X�V�i�j���j
    procedure UpdatePalette;

    // ClipBoard ����� DIB(CF_DIB �`���j ��ǂݍ���
    procedure LoadFromClipboardFormat(AData: THandle);

    // ClipBoard �� DIB(CF_DIB �`���j ����������
    procedure SaveToClipboardFormat(var Data: THandle);


    // PixelFormat ���擾����
    function GetPixelFormat: TNkPixelFormat;

    // PixelFormat ��ϊ�����
    procedure SetPixelFormat(Value: TNkPixelFormat;         // �V�`��
                             ConvertMode: TNkConvertMode;   // �ϊ����[�h
                             BGColor: TColor;               // �w�i�F
                             ProgressHandler: TNotifyEvent  // �v���O���X
                                                            // �n���h��
                             );


    // TrueColor DIB �p�� Palette ���쐬����
    procedure CreateTrueColorPalette(ConvertMode: TNkConvertMode; // �ϊ����[�h
                                    ProgressHandler: TNotifyEvent // �v���O���X
                                                                  // �n���h��
                                     );
  public
    constructor Create(AnUseFMO: Boolean);           // �R���X�g���N�^
    destructor  Destroy; override;// �f�X�g���N�^

  end;



function NkSetDefaultUseFMO(DefaultValue: Boolean): Boolean;

{$IFDEF DEBUG}
var
  DebugMA: LongInt; // Debug �p ������ �A���P�[�V������
{$ENDIF}


implementation


var PaletteHalfTone: HPalette;     // 215 �F �n�[�t�g�[���p�p���b�g
    PaletteBlackWhite: HPalette;   // 2�F �����n�[�t�g�[���p�p���b�g

const DefaultUseFMO: Boolean = True;

function NkSetDefaultUseFMO(DefaultValue: Boolean): Boolean;
begin
  Result := DefaultUseFMO;
  DefaultUseFMO := DefaultValue;
end;


type
  // �e��o�C�g�z��̐錾
  TByteArray64k = array[0..65535] of Byte;
  PByteArray64k = ^TByteArray64k;
  TByteArray64k3D = array[0..31, 0..63, 0..31] of Byte;
  PByteArray64k3D = ^TByteArray64k3D;
  TByteArray256 = array[0..255] of Byte;

  // WORD �z�� DWORD �z��A�N�Z�X�p�̌^�B16bpp/32bpp �p
  TWordArray = array[0..100000000] of WORD;
  TDWordArray = array[0..100000000] of DWORD;
  PWordArray = ^TWordArray;
  PDWordArray = ^TDWordArray;


//-------------------------------------------------------------------
// Note: Color Cube
//
// Color Cube �͓���̏����ɍ����s�N�Z���Q����ɂ܂Ƃ߂�����
// procedure GetReducedColorsLow �ł� RGB ��Ԃ� 32x64x32 �̏��F��Ԃɕ����A
// ���ꂼ��ɑ�����s�N�Z���̐��ƐF�̕��ς��i�[���Ďg���B���̏ꍇ�A
// Index �� RGB ��ԓ��ʒu��\���B
//
// 8bpp ���� 4bpp �ɕϊ�����ꍇ�� Index �� 8bpp �̃J���[�e�[�u����
// �C���f�b�N�X�l��\���An �͂��̃C���f�b�N�X�����s�N�Z���̐���\���A
// R, G, B �̓J���[�C���f�b�N�X�ɑΉ�����F��\���B
//
// �����̃s�N�Z�������̂悤�ɂ܂Ƃ߂邱�Ƃŏ������������ł��� (^^
// 
// ���ӁF TColorCube �̃����o n �͂Q�̈Ӗ�������B���F�Ɏg���O��
//        �s�N�Z������\�����A���F���I��������� ���F�J���[��
//        �C���f�b�N�X�l�����邱�Ƃ�����B�ڍׂ�
//        CutCubes�AGetReducedColorsLow�AGetReducedColorsFrom256 ��
//        �Q�Ƃ��ꂽ���B


  // Color Cube Array �̒�`
  TColorCube = packed record
    R, G, B: LongInt;  // Color Cube �ɑ�����s�N�Z���̐F�̕��ϒl
    n: LongInt;        // Color Cube �ɑ�����s�N�Z���̐�
                       // �܂��̓J���[�C���f�b�N�X�B
    Index: LongInt;    // Color Cube �̃C���f�b�N�X�l
  end;
  
  TColorCubeArray64k = array[0.. 32 * 64 * 32 -1] of TColorCube;
  TColorCubeArray64k3D = array[0..31, 0..63, 0..31] of TColorCube;
  PColorCubeArray64k = ^TColorCubeArray64k;
  PColorCubeArray64k3D = ^TColorCubeArray64k3D;

  // �J���[�e�[�u���A�N�Z�X�p�� �z��^
  TRGBQuadArray    = array[0..255] of TRGBQuad;
  PRGBQuadArray    = ^TRGBQuadArray;

  //-----------------------------------------------------------------
  // Note: �s�N�Z���Q�̕��������e�[�u���̒�`
  //
  //   +-- ����(NodeIndex = 0)
  //   |        Node
  //  +-+       +-+       +-+       +-+
  //  | |------>| |------>| |------>| |      +--- ���[(�F�C���f�b�N�X������)
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
  // �s�N�Z���Q�̕��������e�[�u�� �� �s�N�Z���Q�𕪊����Ă������Ƃ���
  // �����BTrueColor ���� 8bpp/4bpp �ւ̕ϊ��� RGB �l���獂���� Color Index 
  // �����߂�̂ɗ��p����B

  TDivideID = (cidRed,       // �Ԃŕ��� �q�m�[�h������B
               cidGreen,     // �΂ŕ��� �q�m�[�h������B
               cidBlue,      // �ŕ��� �q�m�[�h������B
               cidTerminal   // ���[�̃m�[�h �����ɐF�̌���l(Index)������B
               );
  TCutHistoryNode = record
    DivideID: TDivideID;        // �ǂ̐F�ŕ���������
    ThreshHold: Extended;       // �F�̕����l�i�����O�̐F�̕��ϒl)
    ColorIndex: Byte;           // �J���[�C���f�b�N�X ���[�̃m�[�h�̂ݗL��
    NextNodeIndexLow: Integer;  // ���̃q�X�g���[�m�[�h�C���f�b�N�X
                                // ThreshHold �ȉ��̕���
    NextNodeIndexHigh: Integer; // ���̃q�X�g���[�m�[�h�C���f�b�N�X
                                // ThreshHold �𒴂�����̕���
  end;

  // �q�X�g���[��ێ�����\����
  TCutHistory = record
    nNodes: Integer;                         // �m�[�h�̐�
    Nodes: array[0..511] of TCutHistoryNode; // �m�[�h
  end;


// �n�[�t�g�[���p 215 �F�̐F�l�B
// 6 x 7 x 5 = 210 �F + 5 �F
const RedColors:   array[0..5] of Byte = (  0,  51, 102, 153, 204, 255);
      GreenColors: array[0..6] of Byte = (  0,  43,  85, 128, 171, 214, 255);
      BlueColors:  array[0..4] of Byte = (  0,  64, 128, 192, 255);
      SomeRevervedColors: array[0..4] of TColor =
        (clMaroon, clOlive, clPurple, clSilver, clGray);
// �����n�[�t�g�[���p�̐F�l
      BWColors: array[0..1] of TRGBQuad =
        ((rgbBlue:0; rgbGreen:0; rgbRed:0; rgbReserved:0),
         (rgbBlue:255; rgbGreen:255; rgbRed:255; rgbReserved:0));



//-------------------------------------------------------------------
// Note: GetMemory/ ReleaseMemory �̖���
//
// GetMemory �͎w�肳�ꂽ�傫���� ������ ���� File Mapping Object ���擾���C
// hFile �ɂ� FMO �� �n���h���� pBits �ɂ͐擪�|�C���^��Ԃ��B
//

procedure GetMemory(Size: LongInt;
                    var hFile: THandle;
                    var pBits: Pointer;
                    UseFMO: Boolean);
begin
  if UseFMO then begin
    // �����̃t�@�C���}�b�s���O�I�u�W�F�N�g���쐬
    hFile := CreateFileMapping($FFFFFFFF, Nil, PAGE_READWRITE, 0, Size, Nil);
    if hFile = 0 then raise EOutOfResources.Create(
        'GetMemory: Cannot Make File Mapping Object');

    // �t�@�C���}�b�s���O�I�u�W�F�N�g���������Ƀ}�b�v
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

// FMO ��j������B
procedure ReleaseMemory(hFile: THandle; pBits: Pointer; UseFMO: Boolean);
var Ret: Boolean;
begin
  if UseFMO then begin
    // �t�@�C���}�b�s���O�I�u�W�F�N�g�̃������ւ̃}�b�v������
    ret := UnMapViewOfFile(pBits);
    Assert(Ret, 'ReleaseMemory: Failed To Unmap View of File map');
    // �t�@�C���}�b�s���O�I�u�W�F�N�g��j��
    ret := CloseHandle(hFile);
    Assert(Ret, 'ReleaseMemory: Failed To Close File Map');
  end
  else
    FreeMem(pBits);
end;



// �R���X�g���N�^
constructor TNkInternalDIB.Create(AnUseFMO: Boolean); // Internal DIB �̏�����
begin
  RefCount := 1;                // �Q�ƃJ�E���g������
  DIBInfos.pBits := Nil;        // �s�N�Z�����ւ̃|�C���^��������
  UseFMO := AnUseFMO;           // FMO ���g�����ݒ�
  CreateDIB(1, 1, 8, 256);        // Window 3.X 1x1 8Bit  RGB 256 Color;
end;

// �f�X�g���N�^
destructor TNkInternalDIB.Destroy; // Internal DIB �� destructor
begin FreeDIB; end;


// ���n�� DIB �̍쐬  DIBInfos ����ł��邱�Ƃ����肵�Ă���B
procedure TNkInternalDIB.CreateDIB(AWidth, AHeight, BitCount,
                                   NumColors: LongInt);
var BitsSize: LongInt;  // �r�b�g�}�b�v�f�[�^�̑傫��
    p: Pointer;         // �r�b�g�}�b�v�f�[�^�p�o�b�t�@(FMO)�ւ̃|�C���^
    h: hFile;           // �r�b�g�}�b�v�f�[�^�p�o�b�t�@(FMO)�̃n���h��
begin
  // �p�����[�^���`�F�b�N AHeight �͕�(Top-Down)������
  If (AWidth <= 0) or (AHeight = 0) or (NumColors < 0) or
     (NumColors > 256) or (not(BitCount in [1, 4, 8, 24])) then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkInternalDIB.CreateDIB: Invalid Parameters');

  // �s�N�Z���f�[�^�T�C�Y���v�Z
  BitsSize := ((BitCount * AWidth + 31) div 32) * 4 * abs(AHeight);

  // �s�N�Z���f�[�^�i�[�p FMO ���擾 DIBInfos �ɃZ�b�g
  GetMemory(BitsSize, h, p, UseFMO);

  FillChar(p^, BitsSize, 0);  // �S�Ẵs�N�Z���� �O
  DIBInfos.hFile    := h;
  DIBInfos.BitsSize := BitsSize;
  DIBInfos.pBits    := p;


  // �p���b�g�n���h�����������B�p���b�g�n���h���� TNkDIB.GetPalette
  // ���Ă΂ꂽ�Ƃ��ɏ��߂č����̂� 0 �ŏ��������Ă����B
  Palette := 0;

  // �����ƕ���ݒ�
  Width := AWidth; Height := Abs(AHeight);

  // BitmapInfoHeader �������� Windows 3.X �`��
  DIBInfos.W3Head.biSize          := SizeOf(TBitmapInfoHeader);
  DIBInfos.W3Head.biWidth         := Width;    // ��
  DIBInfos.W3Head.biHeight        := AHeight;  // �����B  <0 �Ȃ�� Top-Down
  DIBInfos.W3Head.biPlanes        := 1;        // �v���[������ɂP
  DIBInfos.W3Head.biBitCount      := BitCount; // �r�b�g�� 1, 4, 8, 24
  DIBInfos.W3Head.biCompression   := BI_RGB;   // �񈳏k�ɐݒ�
  DIBInfos.W3Head.biXPelsPerMeter := 3780;     // 96dpi
  DIBInfos.W3Head.biYPelsPerMeter := 3780;     // 96dpi
  DIBInfos.W3Head.biClrUsed       := NumColors; // �F��
  DIBInfos.W3Head.biClrImportant  := 0;

  //�J���[�e�[�u����S�č��ŏ�����
  FillChar(DIBInfos.W3HeadInfo.bmiColors[0], SizeOf(TRGBQuad)*256, 0);

  PaletteModified := True; // �p���b�g���ύX���ꂽ���Ƃ��L�^
                           // ��� TNkDIB ���E���ɗ���B
end;

// DIB �̔j��
procedure TNkInternalDIB.FreeDIB;
begin
  // DIB �̃s�N�Z�����̔j��
  if DIBInfos.pBits <> Nil then begin  // �O�̂��� DIB �����邩�`�F�b�N
    ReleaseMemory(DIBInfos.hFile, DIBInfos.pBits, UseFMO);
    DIBInfos.BitsSize := 0;
    DIBInfos.hFile    := 0;
    DIBInfos.pBits    := Nil;
  end;

  // �_���p���b�g�̔j��
  if Palette <> 0 then begin
    DeleteObject(Palette);
    Palette := 0;
  end;
end;


// Bit Count ����F�������߂�B16/24/32 bpp �� �O��Ԃ��B
// biClrUsed ��␳����̂Ɏg���B
// biClrUsed �� �O�̏ꍇ�Ɏg�����Ɓi�d�v�I�j
function GetNumColors(BitCount: Integer): Integer;
begin
  if BitCount in [1, 4, 8] then
    Result := 1 shl BitCount
  else
    Result := 0;
end;


// �|�C���^���I�t�Z�b�g�����炷
function AddOffset(p: Pointer; Offset: LongInt): Pointer;
begin Result := Pointer(LongInt(p) + Offset); end;


// TNkDIBInfos �̃J���[�e�[�u������p���b�g�����B
function GetPaletteFromDIBInfos(var DIBInfos: TNkDIBInfos): HPALETTE;
var pPal: PLOGPALETTE; // �_���p���b�g�쐬�̂��߂̃p�����[�^�u���b�N�ւ̃|�C���^
    PalSize: Integer;  // �_���p���b�g�̃p�����[�^�u���b�N�̑傫��
    nColors, i: Integer; // �F��
begin
  Result := 0;

  // �F�������߂�
  if DIBInfos.W3Head.biClrUsed = 0 then Exit;

  // TNkInternalDIB �ł� biClrUsed �� 1/4/8 bpp �ł� 0 �ɂ͂Ȃ�Ȃ��悤��
  // �␳���݂Ȃ̂ł���ł悢�B
  nColors := DIBInfos.W3Head.biClrUsed;

  // �p�����[�^�u���b�N�����
  PalSize := SizeOf(TLogPalette) + ((nColors - 1) * SizeOf(TPaletteEntry));
  GetMem(pPal, PalSize);
  try
    pPal^.palNumEntries := nColors;  // �F��
    pPal^.palVersion := $300;

    // �F���p�����[�^�u���b�N�̃G���g���ɐݒ�B
    for i := 0 to nColors - 1 do begin
      pPal^.palPalEntry[i].peRed   := DIBInfos.W3HeadInfo.bmiColors[i].rgbRed;
      pPal^.palPalEntry[i].peGreen := DIBInfos.W3HeadInfo.bmiColors[i].rgbGreen;
      pPal^.palPalEntry[i].peBlue  := DIBInfos.W3HeadInfo.bmiColors[i].rgbBlue;
      pPal^.palPalEntry[i].peFlags := 0;
    end;

    // ���I�I
    Result := CreatePalette(pPal^);

    if Result = 0 then raise EOutOfResources.Create(
      'GetPaletteFromDIBInfos: Cannot Make Palette');

  finally
    // �p�����[�^�u���b�N�̔j��
    FreeMem(pPal, PalSize);
  end;
end;


//-------------------------------------------------------------------
// Note:
//
// TNkInternalDIB �ł̓r�b�g�}�b�v����� Windows 3.X �`���ŕێ�����B
// ConvertBitmapHeaderPMToW3 �� �t�@�C���Ȃǂ��� PM �`���̃r�b�g�}�b�v
// �����͂��ꂽ�ꍇ�A�w�b�_�ƃJ���[�e�[�u���� Windows 3.X �`���ɕϊ�����
// �̂ɗ��p����B

// �r�b�g�}�b�v���� PM1.X �`������ Windows 3.X �`���ɕϊ�����
procedure ConvertBitmapHeaderPMToW3(var PmInfos: TNkDIBInfos);
var Infos: TNkDIBInfos;
    i: Integer;
begin
  // PmInfos(PM �`�� BitmapInfo) ���� BitmapInfoHeader �����
  Infos := PMInfos;
  Infos.W3Head.biSize          := SizeOf(TBitmapInfoheader);
  Infos.W3Head.biWidth         := PMInfos.PMHead.bcWidth;
  Infos.W3Head.biHeight        := PMInfos.PMHead.bcHeight;
  Infos.W3Head.biPlanes        := PMInfos.PMHead.bcPlanes;
  Infos.W3Head.biBitCount      := PMInfos.PMHead.bcBitCount;
  Infos.W3Head.biCompression   := BI_RGB; // PM �`���Ɉ��k�͖����I�I
  Infos.W3Head.biSizeImage     := 0;
  Infos.W3Head.biXPelsPerMeter := 3780;  // 96dpi
  Infos.W3Head.biYPelsPerMeter := 3780;  // 96dpi
  // �J���[�e�[�u������ PM �ł� bcBitCount �Ō��܂�B
  Infos.W3Head.biClrUsed       := GetNumColors(PMInfos.PMHead.bcBitCount);
  Infos.W3Head.biClrImportant  := 0;


  // PM �� W3 �ł� �J���[�e�[�u���̌`�����Ⴄ�̂ŕϊ�����
  for i := 0 to Infos.W3Head.biClrUsed - 1 do begin
    Infos.W3HeadInfo.bmiColors[i].rgbRed :=
          PMInfos.PMHeadInfo.bmciColors[i].rgbtRed;
    Infos.W3HeadInfo.bmiColors[i].rgbGreen :=
          PMInfos.PMHeadInfo.bmciColors[i].rgbtGreen;
    Infos.W3HeadInfo.bmiColors[i].rgbBlue :=
          PMInfos.PMHeadInfo.bmciColors[i].rgbtBlue;
    Infos.W3HeadInfo.bmiColors[i].rgbReserved := 0;
  end;


  PMInfos := Infos;  // �ϊ����ʂ���������
end;


// BI_BITFIELDS �`���̃r�b�g�}�b�v�� �}�X�N�̃V�t�g�ʂ��v�Z����
// >0 �͉E�V�t�g <0 �͍��V�t�g��\���B
//  �}�X�N�l�� 128 �` 255(MSB ON) �ɂȂ�悤����V�t�g�ʂ��v�Z����
//    (Mask �� �O ������Ɩ\������̂Œ��ӁI�I)

function GetMaskShift(Mask: DWORD): Integer;
begin
  Result := 0;

  // Mask �� $100 �ȏ�Ȃ� �E�V�t�g�ʂ����߂�
  while Mask >= 256 do begin
    Mask := Mask shr 1;
    Result := Result +1;
  end;

  // Mask �� $80 �����Ȃ� ���V�t�g�ʂ����߂�i�}�C�i�X�l�j
  while Mask < 128 do begin
    Mask := Mask shl 1;
    Result := Result -1;
  end;
end;


// Stream ���� DIB�i�t�@�C���w�b�_�t���j��ǂݍ���
procedure TNkInternalDIB.LoadFromStream(Stream: TStream);
var Infos: TNkDIBInfos;              // DIB���
    bfh: TBitmapFileheader;          // �r�b�g�}�b�v�t�@�C���w�b�_
    i, j, w: LongInt;
    SourceLineSize, DestLineSize: LongInt; // �X�L�������C���̑傫��
                                    // 16/32 bpp -> 24 bpp �ϊ��p
    RShift, GShift, BShift: LongInt;// �}�X�N�̃V�t�g��
    Masks: array[0..2] of DWORD;    // Masks[0]: Red Mask Masks[1]: Green Mask
                                    // Masks[2]: Blue Mask
    pConvertBuffer: Pointer;        // 16/32bpp -> 24bpp �ϊ��p�o�b�t�@�ւ�
                                    // �|�C���^
    pTriple: ^TNkTriple;            // 24 bpp �X�L�������C���A�N�Z�X�p�|�C���^
                                    // 16/32 bpp -> 24 bpp �ϊ��p
    MaxR, MaxG, MaxB: DWORD;        // BitFields �Ŏ��o���� R, G, B �l��
                                    // �␳�O�̍ő�l
begin
  Infos.pBits := Nil;

  try
    // �t�@�C���w�b�_�[��ǂ�
    Stream.ReadBuffer(bfh, SizeOf(bfh));

    // �t�@�C���^�C�v���`�F�b�N
    if bfh.bfType <> $4D42 then
      raise ENkDIBInvalidDIBFile.Create(
        'TNkInternalDIB.LoadFromFile: File type is invalid');

    // W3 �� PM ���𔻒f���邽�߃r�b�g�}�b�v�w�b�_�T�C�Y��ǂݍ���
    Stream.ReadBuffer(Infos.W3Head, SizeOf(DWORD));

    if Infos.W3Head.biSize = SizeOf(TBitmapInfoHeader) then begin
      // Windows 3.X �`��
      // BitmapInfoHeader �̎c���ǂݍ���
      Stream.ReadBuffer(AddOffset(@Infos.W3Head, SizeOf(DWORD))^,
                        SizeOf(TBitmapInfoHeader) - SizeOf(DWORD));

      // XPelsPerMeter/YPelsPerMeter �� 0 �Ȃ� 3780(96dpi) �ɕ␳����B
      if Infos.W3Head.biXPelsPerMeter = 0 then
        Infos.W3Head.biXPelsPerMeter := 3780;
      if Infos.W3Head.biYPelsPerMeter = 0 then
        Infos.W3Head.biYPelsPerMeter := 3780;

      // �F�r�b�g���`�F�b�N
      if not (Infos.W3Head.biBitCount in [1, 4, 8, 16, 24, 32]) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid BitCout');

      // �F�������߂�B
      if Infos.W3Head.biClrUsed = 0 then
        Infos.W3Head.biClrUsed := GetNumColors(Infos.W3Head.biBitCount);

      // �J���[�e�[�u����ǂݍ���
      //------------------------------
      // Note:
      // �J���[�e�[�u���͐擪�� 3 DWORD �� BitFields ���܂ނ��Ƃ�����B
      // ���̏ꍇ�̓J���[�e�[�u���̑傫���� (3 + biClrUsed) ��
      // �Ȃ�̂Œ��ӂ��K�v�ł���B
      // �܂� biClrUsed ���Q�T�V�ȏ�ɂȂ邱�Ƃ��L�蓾��̂Œ��ӁI�I

      if Infos.W3Head.biCompression <> BI_BITFIELDS then begin
      // BitFields ���܂ޏꍇ
        if Infos.W3Head.biClrUsed <= 256 then
          Stream.ReadBuffer(
            AddOffset(@Infos.W3Head, SizeOf(TBitmapInfoHeader))^,
                      Infos.W3Head.biClrUsed * SizeOf(TRgbQuad))
        else begin
          // �J���[�e�[�u�����Q�T�U���傫����ΐ擪256�����g���B
          // �����擪�̕����d�v�Ȃ͂��B
          Stream.ReadBuffer(
            AddOffset(@Infos.W3Head, SizeOf(TBitmapInfoHeader))^,
                      256 * SizeOf(TRgbQuad));
          // �X�L�b�v
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
          // �X�L�b�v
          Stream.Seek((Infos.W3Head.biClrUsed - 256)* SizeOf(TRgbQuad), 1);
        end
      end;

      // �s�N�Z�����̃������ʌv�Z(1, 2, 4, 8, 24 Bit �p)
      Infos.BitsSize := bfh.bfSize - bfh.bfOffBits;

      if Infos.W3head.biCompression <> BI_BITFIELDS then begin
        // �t�@�C���w�b�_�� bfOffBits ���߂��Ă��܂��Ă��邩�`�F�b�N
        if bfh.bfOffBits < (SizeOf(bfh) + Infos.W3Head.biSize +
           Infos.W3Head.biClrUsed * SizeOf(TRgbQuad)) then
          raise ENkDIBInvalidDIB.Create(
            'TNkInternalDIB.LoadFromFile: bfOffBits is too small');

        // bfOffBits �ɏ]���� �ǂݎ��ʒu��␳
        Stream.Seek(bfh.bfOffBits - sizeof(bfh) - Infos.W3Head.biSize -
                    Infos.W3Head.biClrUsed * SizeOf(TRgbQuad),
                    soFromCurrent);
      end
      else begin
        // �t�@�C���w�b�_�� bfOffBits ���߂��Ă��܂��Ă��邩�`�F�b�N
        if bfh.bfOffBits < (SizeOf(bfh) + Infos.W3Head.biSize +
           (Infos.W3Head.biClrUsed + 3) * SizeOf(TRgbQuad)) then
          raise ENkDIBInvalidDIB.Create(
            'TNkInternalDIB.LoadFromFile: bfOffBits is too small');

        // bfOffBits �ɏ]���� �ǂݎ��ʒu��␳
        Stream.Seek(bfh.bfOffBits - sizeof(bfh) - Infos.W3Head.biSize -
                    (Infos.W3Head.biClrUsed + 3) * SizeOf(TRgbQuad),
                    soFromCurrent);
      end;


      // �s�N�Z���������ʂ̌v�Z���I������̂� �J���[�e�[�u����
      // �F������������Ȃ�Q�T�U�ɒ����B
      if Infos.W3Head.biClrUsed > 256 then
        Infos.W3Head.biClrUsed := 256;

    end
    else if Infos.PMHead.bcSize = SizeOf(TBitmapCoreHeader) then begin
      // PM 1.X �`��
      // BitmapCoreHeader ��ǂݍ���
      Stream.ReadBuffer(AddOffset(@Infos.PMHead, SizeOf(DWORD))^,
                        SizeOf(TBitmapCoreHeader) - SizeOf(DWORD));

      // �F�r�b�g���`�F�b�N
      if not (Infos.PMHead.bcBitCount in [1, 4, 8, 24]) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid BitCount');

      // �J���[�e�[�u����ǂݍ��ށBPM �`���̏ꍇ�� BitField ��������
      // �J���[�e�[�u���̑傫���� bcBitCount �Ŏ����I�Ɍ��܂�B
      Stream.ReadBuffer(
        Pointer(LongInt(@Infos.PMHead)+SizeOf(TBitmapCoreHeader))^,
        GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple));

      // �s�N�Z�����̃������ʌv�Z
      Infos.BitsSize :=
        bfh.bfSize - SizeOf(bfh) - Infos.PMHead.bcSize -
        GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple);

      // �s�N�Z�����̃������ʌv�Z(1, 2, 4, 8, 24 Bit �p)
      Infos.BitsSize := bfh.bfSize - bfh.bfOffBits;

      // �t�@�C���w�b�_�� bfOffBits ���߂��Ă��܂��Ă��邩�`�F�b�N
      if bfh.bfOffBits < (SizeOf(bfh) + Infos.PMHead.bcSize +
         GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple)) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromFile: bfOffBits is too small');

      // bfOffBits �ɏ]���� �ǂݎ��ʒu��␳
      Stream.Seek(bfh.bfOffBits - sizeof(bfh) - Infos.PMHead.bcSize -
                  GetNumColors(Infos.PMHead.bcBitCount) * SizeOf(TRgbTriple),
                  soFromCurrent);





      // �r�b�g�}�b�v�w�b�_�ƃJ���[�e�[�u���� Windows 3.X �`���ɕϊ�
      ConvertBitmapHeaderPmToW3(Infos);
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkInternalDIB.LoadFromStream: Invalid Bitmap Header Size');

    // �����ƕ����`�F�b�N
    if (Infos.W3Head.biWidth <= 0) or (Infos.W3head.biHeight = 0) then
      raise ENkDIBInvalidDIB.Create(
        'TNkInternalDIB.LoadFromStream: Invalid Width or Height');

    if Infos.W3Head.biBitCount in [1, 4, 8, 24] then begin
      // �s�N�Z�����p���������m��
      GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);
      // �s�N�Z������ǂݍ���
      Stream.ReadBuffer(Infos.pBits^, Infos.BitsSize);
    end
    else if Infos.W3Head.biBitCount in [16, 32] then begin
      // 16/32bpp �̏ꍇ

      //-------------------------------------------------------------
      // Note: 16/32 bpp �̎�舵��
      //
      // TNkDIB �͓����I�ɂ� 16/32 bpp ���T�|�[�g���Ȃ��̂�
      // ���͎��� 24bpp �ɕϊ����邱�ƂőΏ����Ă���B
      // 16 bpp �� 24bpp �� BitField �Ń}�X�N���Ă������Ȃ���΂Ȃ�
      // �����`���Ƃ��Ă͈����ɂ����B(����ȏ�`���𑝂₵�����Ȃ� (^^;)

      // 16/32 bpp �̃X�L�������C���̒���
      if Infos.W3Head.biBitCount = 16 then
        SourceLineSize := ((Infos.W3Head.biWidth*2+3) div 4) * 4
      else
        SourceLineSize := ((Infos.W3Head.biWidth*4+3) div 4) * 4;

      // 24bpp �̃��C����
      DestLineSize   := ((Infos.W3Head.biWidth*3+3) div 4) * 4;

      // 16/32 bpp �� BitsSize ���v�Z�����̂� 24bpp �ōČv�Z
      Infos.BitsSize := DestLineSize * Infos.W3Head.biHeight;

      // 24bpp �� Pixel �p���������m��
      GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);

      // �r�b�g�}�X�N�𓾂�
      if Infos.W3Head.biCompression = BI_RGB then begin
        // BitFields �������ꍇ
        // 16bpp �p�f�t�H���g�}�X�N�p�^���̍쐬�B
        if Infos.W3Head.biBitCount = 16 then begin
          Masks[0] := $7C00; Masks[1] := $03E0; Masks[2] := $001F;
        end
        else begin
        // 32bpp �p�f�t�H���g�}�X�N�p�^���̍쐬�B
          Masks[0] := $FF0000; Masks[1] := $00FF00; Masks[2] := $0000FF;
        end;
      end
      else begin
        // BitFields ���� �}�X�N�� Masks �փR�s�[�B
        Move(Infos.W3HeadInfo.bmiColors[0], Masks[0], SizeOf(DWORD)*3);
      end;

      // �}�X�N�����킩�`�F�b�N�B�r�b�g�̎������d�Ȃ�̓`�F�b�N���Ă��Ȃ�(^^
      // 0 ���`�F�b�N���Ă���̂� GetMaskShift ���\�����Ȃ��悤�ɂ��邽��
      if (Masks[0] = 0) or (Masks[1] = 0) or (Masks[2] = 0) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid Masks');


      // �}�X�N��̃V�t�g�ʂ��v�Z
      RShift := GetMaskShift(Masks[0]);
      GShift := GetMaskShift(Masks[1]);
      BShift := GetMaskShift(Masks[2]);

      // �␳�O�� R, G, B �l�̍ő�l���v�Z
      if RShift >= 0 then MaxR := Masks[0] shr RShift
                     else MaxR := Masks[0] shl (-RShift);
      if GShift >= 0 then MaxG := Masks[1] shr GShift
                     else MaxG := Masks[1] shl (-GShift);
      if BShift >= 0 then MaxB := Masks[2] shr BShift
                     else MaxB := Masks[2] shl (-BShift);

      // 16/32bpp -> 24 bpp �̂��߂� 1�X�L�������C�����̕ϊ��o�b�t�@��p��
      GetMem(pConvertBuffer, SourceLineSize);

      // �������� �ǂݍ��݃X�^�[�g

      try
        for i := 0 to Infos.W3Head.biHeight -1 do begin

          // 1 Line �ǂݍ���
          Stream.ReadBuffer(pConvertBuffer^, SourceLineSize);

          // �ϊ�����v�Z
          pTriple := AddOffset(Infos.pBits, DestLineSize * i);

          // ��������O�N���A���Ă��� �X�L�������C���̃p�f�B���O
          // ���O�ȊO�ɂȂ�̂�h�����߁B
          FillChar(AddOffset(pTriple, DestLineSize -4)^, 4, 0);

          w := Infos.W3Head.biWidth -1;

          if Infos.W3Head.biBitCount = 16 then
            // 16bpp �̏ꍇ
            for j := 0 to w do begin

               // 1 pixel �ϊ�
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
            // 32 bpp �̏ꍇ
            for j := 0 to w do begin
               // 1 pixel �ϊ�
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


        // �S�s�N�Z���͕ϊ��ł����̂ō��x�� �r�b�g�}�b�v��������������

        with Infos.W3Head do begin
          // �J���[�e�[�u���̈ʒu��␳
          if biCompression = BI_BITFIELDS then
            for i := 0 to 255 do
              with Infos.W3HeadInfo do
                bmiColors[i] := bmiColors[i+3];

          // �w�b�_��␳ 24bpp �ɂ���
          biCompression := BI_RGB;
          biBitCount := 24;
          biSizeImage := 0;
        end;

      finally
        FreeMem(PConvertBuffer, SourceLineSize);  // �ϊ��p�o�b�t�@��j��
      end;
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkInternalDIB.LoadFromStream: Invalid biBitCount');

    // �d�グ
    FreeDIB;                          // �Â� DIB ���폜
    DIBInfos := Infos;                // �V���� DIB �w�b�_���J���[�e�[�u����ݒ�

    // ���ƍ�����ݒ�
    Width := DIBInfos.W3Head.biWidth;
    Height := abs(DIBInfos.W3Head.biHeight);

    UpdatePalette; // �V���� DIB �̃p���b�g�ɂ���B
  except
    // ���s�����ꍇ�A�m�ۂ��� FMO ���̂Ă�B
    if Infos.pBits <> Nil then ReleaseMemory(Infos.hFile, Infos.pBits, UseFMO);
    raise;  // �Đ�����Y�ꂸ�ɁI�I
  end;
end;

// DIB�i�t�@�C���w�b�_�t���j��Stream �ɏ����o���B����͊ȒP
procedure TNkInternalDIB.SaveToStream(Stream: TStream);
var bfh: TBitmapFileheader;
begin
  // �t�@�C���w�b�_�����
  FillChar(bfh, SizeOf(bfh), 0);

  // 'BM' ���t�@�C���^�C�v�ɐݒ�
  bfh.bfType    := $4D42;

  // �t�@�C���T�C�Y���v�Z���Đݒ�
  bfh.bfSize    := SizeOf(bfh) +                 // �t�@�C���w�b�_�̑傫��
                   SizeOf(TBitmapInfoHeader) +   // �r�b�g�}�b�v�w�b�_�̑傫��
                   DIBInfos.W3Head.biClrUsed *   // �J���[�e�[�u���̑傫��
                       SizeOf(TRgbQuad) +
                   DIBInfos.BitsSize;            // �r�b�g�}�b�v�f�[�^�̑傫��
                                                 // biSizeImage �͎g��Ȃ�����!
                                                 // 0 �̏ꍇ������B

  // �t�@�C���̐擪����s�N�Z�����܂ł̃T�C�Y���v�Z���Đݒ�
  bfh.bfOffBits := SizeOf(bfh) +                 // �t�@�C���w�b�_�̑傫��
                   SizeOf(TBitmapInfoHeader) +   // �r�b�g�}�b�v�w�b�_�̑傫��
                   DIBInfos.W3Head.biClrUsed *   // �J���[�e�[�u���̑傫��
                       SizeOf(TRgbQuad);

  // �t�@�C���w�b�_����������
  Stream.WriteBuffer(bfh, SizeOf(bfh));

  // �r�b�g�}�b�v�w�b�_���J���[�e�[�u������������
  Stream.WriteBuffer(DIBInfos.W3Head,
                     SizeOf(TBitmapInfoHeader) +
                     DIBInfos.W3Head.biClrUsed * SizeOf(TRgbQuad));
  // �s�N�Z��������������
  Stream.WriteBuffer(DIBInfos.pBits^, DIBInfos.BitsSize);
end;


// DIB �̃J���[�e�[�u������p���b�g�����B
function TNkInternalDIB.MakePalette: HPALETTE;
begin Result := GetPaletteFromDIBInfos(DIBInfos); end;


// �Â��p���b�g���폜�B
procedure TNkInternalDIB.UpdatePalette;
begin
  // �p���b�g�� �X�V�����Ƃ������Ƃ� UniqueDIB ���Ă΂�� ���L��
  // ��������Ă���͂��ł���B�����łȂ���΃o�O
  Assert(RefCount = 1, 'TNkInternalDIB.UpdatePalette: RefCount Must be 1');
  if Palette <> 0 then begin // ���p���b�g����H
    DeleteObject(Palette);
    Palette := 0;
  end;
  PaletteModified := True;
end;

// ClipBoard ���� DIB ���擾
// ���͂��Ƃ� �������ɂȂ邾���ŏ����͂قƂ�� LoadFromStream �Ɠ����Ȃ̂�
// �R�����g�͎蔲���ł� (^^
procedure TNkInternalDIB.LoadFromClipboardFormat(AData: THandle);
var p: Pointer;              // �N���b�v�{�[�h�f�[�^�ւ̃|�C���^
    pBih: PBitmapInfoHeader; // �w�b�_�ւ̃|�C���^(Windows 3.X)
    pBch: PBitmapCoreHeader; // �w�b�_�ւ̃|�C���^(PM 1.X)
    HeaderSize: LongInt;     // �r�b�g�}�b�v�w�b�_�{�J���[�e�[�u�� �̑傫��
    ColorTableSize: LongInt; // �J���[�e�[�u���̐F��
    Infos: TNkDIBInfos;      // DIB ���
    SourceLineSize, DestLineSize: LongInt;
    i, j, w: LongInt;
    RShift, GShift, BShift: LongInt;
    Masks: array[0..2] of DWORD; // Masks[0]: Red Mask Masks[1]: Green Mask
                                 // Masks[2]: Blue Mask
    pConvertBuffer: Pointer;           // 16/32bpp -> 24bpp �ϊ��p�|�C���^
    pTriple: ^TNkTriple;
    MaxR, MaxG, MaxB: DWORD;        // BitFields �Ŏ��o���� R, G, B �l��
                                    // �␳�O�̍ő�l
begin
  p := GlobalLock(AData);
  try
    Infos.pBits := Nil;
    try
      if PBitmapInfoHeader(p)^.biSize = SizeOf(TBitmapInfoheader) then begin
        // CF_DIB �̃f�[�^�� Windows 3.X �`��

        pBih := p;

        // �J���[�e�[�u���̐F�����v�Z
        ColorTableSize := pBih^.biClrUsed;
        if ColorTableSize = 0 then
          ColorTableSize := GetNumColors(pBih^.biBitCount);

        // DIB �w�b�_�[�i�J���[�e�[�u�����܂ށj�̍��v�T�C�Y���v�Z

        if pBih^.biCompression <> BI_BITFIELDS then
          HeaderSize := SizeOf(TBitmapInfoheader) +
                        ColorTableSize * SizeOf(TRGBQuad)
        else
          HeaderSize := SizeOf(TBitmapInfoheader) +
                        (ColorTableSize+3) * SizeOf(TRGBQuad);

        // DIB �w�b�_�[���R�s�[
        if HeaderSize > NkBitmapInfoSize then
          System.Move(p^, Infos.W3Head, NkBitmapInfoSize)
        else
          System.Move(p^, Infos.W3Head, HeaderSize);

        // XPelsPerMeter/YPelsPerMeter �� 0 �Ȃ� 3780(96dpi) �ɕ␳����B
        if Infos.W3Head.biXPelsPerMeter = 0 then
          Infos.W3Head.biXPelsPerMeter := 3780;
        if Infos.W3Head.biYPelsPerMeter = 0 then
          Infos.W3Head.biYPelsPerMeter := 3780;



        // �␳�����J���[�e�[�u���T�C�Y����������
        if ColorTableSize > 256 then ColorTableSize := 256;
        Infos.W3Head.biClrUsed := ColorTableSize;

        // �s�N�Z�����p���������v�Z
        Infos.BitsSize := GlobalSize(AData) - HeaderSize;
      end
      else if PBitmapInfoHeader(p)^.biSize =
              SizeOf(TBitmapCoreheader) then begin
        // CF_DIB �̃f�[�^�� PM 1.X �`��

        pBch := p;

        // �J���[�e�[�u���̐F�����v�Z
        ColorTableSize := GetNumColors(pBch^.bcBitCount);

        // DIB �w�b�_�[�i�J���[�e�[�u�����܂ށj�̍��v�T�C�Y���v�Z
        HeaderSize := SizeOf(TBitmapCoreheader) +
                      ColorTableSize * SizeOf(TRGBTriple);

        System.Move(p^, Infos.PMHead, HeaderSize);

        // �s�N�Z�����p�������ʂ��v�Z�B
        Infos.BitsSize := GlobalSize(AData) - HeaderSize;

        // �r�b�g�}�b�v�w�b�_�ƃJ���[�e�[�u���� Windows 3.X �`���ɕϊ�
        ConvertBitmapHeaderPmToW3(Infos);
      end
      else
        raise ENkDIBInvalidDIB.Create(
          'TNkDIB.LoadFromClipboardFormat: Invalid Clipboard Data');

      if (Infos.W3Head.biWidth = 0) or (Infos.W3head.biHeight = 0) then
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromStream: Invalid Width or Height');


      if Infos.W3Head.biBitCount in [1, 4, 8, 24] then begin
        // �s�N�Z�����p���������m��
        GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);
        // �s�N�Z������ǂݍ���
        System.Move(AddOffset(p, HeaderSize)^, Infos.pBits^, Infos.BitsSize);
      end
      else if Infos.W3Head.biBitCount in [16, 32] then begin   // 16/32bpp
        // 24bpp �ɕϊ����Ȃ���ǂ�
        
      //-------------------------------------------------------------
      // Note: 16/32 bpp �̎�舵��
      //
      // TNkDIB �͓����I�ɂ� 16/32 bpp ���T�|�[�g���Ȃ��̂�
      // ���͎��� 24bpp �ɕϊ����邱�ƂőΏ����Ă���B
      // 16 bpp �� 24bpp �� BitField �Ń}�X�N���Ă������Ȃ���΂Ȃ�
      // �����`���Ƃ��Ă͈����ɂ����B(����ȏ�`���𑝂₵�����Ȃ� (^^;)


        // 16/32 bpp �̃��C����
        if Infos.W3Head.biBitCount = 16 then
          SourceLineSize := ((Infos.W3Head.biWidth*2+3) div 4) * 4
        else
          SourceLineSize := ((Infos.W3Head.biWidth*4+3) div 4) * 4;

        // 24bpp �̃��C����
        DestLineSize   := ((Infos.W3Head.biWidth*3+3) div 4) * 4;

        // 24bpp �� Bits �T�C�Y�ɕ␳
        Infos.BitsSize := DestLineSize * Infos.W3Head.biHeight;

        // 24bpp �� Pixel �p���������m��
        GetMemory(Infos.BitsSize, Infos.hFile, Infos.pBits, UseFMO);

        if Infos.W3Head.biCompression = BI_RGB then begin
          // 16bpp �p�f�t�H���g�}�X�N�p�^���̍쐬�B
          if Infos.W3Head.biBitCount = 16 then begin
            Masks[0] := $7C00; Masks[1] := $03E0; Masks[2] := $001F;
          end
          else begin
          // 32bpp �p�f�t�H���g�}�X�N�p�^���̍쐬�B
            Masks[0] := $FF0000; Masks[1] := $00FF00; Masks[2] := $0000FF;
          end;
        end
        else begin
          // �}�X�N�p�^�����R�s�[�B
          Move(Infos.W3HeadInfo.bmiColors[0], Masks[0], SizeOf(DWORD)*3);
        end;

        if (Masks[0] = 0) or (Masks[1] = 0) or (Masks[2] = 0) then
          raise ENkDIBInvalidDIB.Create(
            'TNkInternalDIB.LoadFromStream: Invalid Masks');


        // �}�X�N��̃V�t�g�ʂ��v�Z
        RShift := GetMaskShift(Masks[0]);
        GShift := GetMaskShift(Masks[1]);
        BShift := GetMaskShift(Masks[2]);

        // �␳�O�� R, G, B �l�̍ő�l���v�Z
        if RShift >= 0 then MaxR := Masks[0] shr RShift
                       else MaxR := Masks[0] shl (-RShift);
        if GShift >= 0 then MaxG := Masks[1] shr GShift
                       else MaxG := Masks[1] shl (-GShift);
        if BShift >= 0 then MaxB := Masks[2] shr BShift
                       else MaxB := Masks[2] shl (-BShift);



        // ��������ǂݍ���
        for i := 0 to Infos.W3Head.biHeight -1 do begin
          // �ϊ����v�Z
          pConvertBuffer := AddOffset(p, HeaderSize + SourceLineSize * i);
          // �ϊ�����v�Z
          pTriple := AddOffset(Infos.pBits, DestLineSize * i);
          // ��������O�N���A���Ă��� �X�L�������C���̃p�f�B���O
          // ���O�ȊO�ɂȂ�̂�h�����߁B
          FillChar(AddOffset(pTriple, DestLineSize -4)^, 4, 0);

          w := Infos.W3Head.biWidth -1;

          if Infos.W3Head.biBitCount = 16 then
            // 16bpp �̏ꍇ
            for j := 0 to w do begin

               // 1 pixel �ϊ�
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
            // 32 bpp �̏ꍇ
            for j := 0 to w do begin
               // 1 pixel �ϊ�
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

        // 24 bpp �Ɍ`����␳

        with Infos.W3Head do begin
          // �J���[�e�[�u���̈ʒu��␳
          if biCompression = BI_BITFIELDS then
            for i := 0 to 255 do
              with Infos.W3HeadInfo do
                bmiColors[i] := bmiColors[i+3];
 
          // �w�b�_��␳
          biCompression := BI_RGB;
          biBitCount := 24;
          biSizeImage := 0;
        end;
      end
      else
        raise ENkDIBInvalidDIB.Create(
          'TNkInternalDIB.LoadFromClipboardFormat: Invalid biBitCount');



      // �d�グ

      // �Â� DIB ��j��
      FreeDIB;

      // DIB ����ݒ�
      DIBInfos := Infos;

      // ���^������ݒ�
      Width := DIBInfos.W3Head.biWidth;
      Height := abs(DIBInfos.W3Head.biHeight);

      // �Â��p���b�g���̂Ă�
      UpdatePalette;
    except
      if Infos.pBits <> Nil then ReleaseMemory(Infos.hFile, Infos.pBits, UseFMO);
      raise;
    end;
  finally
    GlobalUnlock(AData);
  end;
end;

// ����� SaveToStream �ƂقƂ�Ǔ����Ȃ̂ŃR�����g�͎蔲��
procedure TNkInternalDIB.SaveToClipboardFormat(var Data: THandle);
var h: THandle;              // �N���b�v�{�[�h�ɓn���������n���h��
    p: Pointer;              // �N���b�v�{�[�h�ɓn���������ւ̃|�C���^
    HeaderSize: LongInt;     // �r�b�g�}�b�v�w�b�_�ƃJ���[�e�[�u���̑傫��
begin
  // DIB �̃w�b�_�[�T�C�Y�i�J���[�e�[�u�����܂ށj���v�Z����
  HeaderSize := SizeOf(TBitmapInfoHeader) +
                DIBInfos.W3Head.biClrUsed * SizeOf(TRGBQuad);

  // �N���b�v�{�[�h�ɓn�����������m�ۂ���
  h := GlobalAlloc(GHND, HeaderSize + DIBInfos.BitsSize);
  if h = 0 then
    raise EOutOfMemory.Create(
      'TNkInternalDIB.SaveToClipboardFormat: Out Of Memory');
  p := GlobalLock(h);

  // �w�b�_�ƃJ���[�e�[�u������������
  System.Move(DIBInfos.W3Head, p^, HeaderSize);

  // �s�N�Z��������������
  System.Move(DIBInfos.pBits^, AddOffset(p, HeaderSize)^, DIBInfos.BitsSize);

  GlobalUnlock(h);
  Data := h;
end;


/////////////////////////////////////////////////////////////////////
// �F�Q��2�����Ă䂭���[�`��
// �S�s�N�Z���� R, G, B �̕��ϒl�ƕ��U�����߁A�ł����U�̑傫���F(R or G or B)
// �̕��ϒl��p���āA�F�Q��2������B����� Max Depth��J��Ԃ��΁A
// �s�N�Z���Q�͍ő� 2^MaxDepth �̌Q�ɕ�������B�e�Q�̕��ς̐F�����߁A
// �J���[�e�[�u�����쐬����B


//-------------------------------------------------------------------
// Note:
//
// CutPixels �͔͗C���� Pixel �Q�𕪊�����B�v�Z�͑S�� Pixel �P�ʂōs���̂�
// �ƂĂ��x��(^^; �������i���̗ǂ��������ʂ�������B
// CutPixels �� History �ɕ����������c���B����History ���g���� 
// RGB �l�ƕ�����̐F�Q�Ƃ̑Ή��������Ɍv�Z�ł���B

procedure CutPixels(Low,   // �F�Q�̍ŏ��̃s�N�Z�����w���C���f�b�N�X
                    High,  // �F�Q�̍Ō�̃s�N�Z���̎����w���C���f�b�N�X
                    Depth,                     // �����̐[��
                    MaxDepth: LongInt;         // �����̐[���̍ő�l
                   var Bits: TNkTripleArray;   // �s�N�Z���z��
                   var Colors: TRGBQuadArray;  // ���F�J���[�o�͗p��
                                               // �J���[�e�[�u��
                   var NumColors: LongInt;     // �o�͂��ꂽ���F�J���[�F�̐�
                   var History: TCutHistory;   // ���F����
                   HistoryNodeIndex: Integer;  // ��������������
                                               // �m�[�h�C���f�b�N�X
                   ProgressHandler: TNotifyEvent); // �v���O���X�n���h��
var
  i, j: LongInt;
  RAve, GAve, BAve: Extended;  // �ԁA�΁A�̕��ϒl
  RD, GD, BD: Extended;        // �ԁA�΁A�̕��U
  Index: Integer;
  temp: TNkTriple;
begin
  if Low = High then begin
    // Low = High �Ȃ̂ŐF�Q�̓s�N�Z������������Ă��Ȃ��B

    // �����̐[���� Max �Ȃ�v���O���X�n���h�����Ăт����B
    if Depth = MaxDepth then begin
      ProgressHandler(Nil);
      Exit;  // �I���I�I
    end;
    // �_�~�[�̕��� OnProgress �G�x���g���N�����̂ɕK�v�B
    CutPixels(Low, High, Depth+1, MaxDepth, Bits, Colors, NumColors,
              History, 0, ProgressHandler);
    CutPixels(Low, High, Depth+1, MaxDepth, Bits, Colors, NumColors,
              History, 0, ProgressHandler);
    Exit;
  end;
  // �F�Q�̐F�̕��ςƕ��U���v�Z����B
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

  // Depth = MaxDepth �܂�A2^MaxDepth�Q�ɕ������Ă���Ȃ�΁A�F�̕��ς�
  // �J���[�e�[�u���ɓo�^����B
  if Depth = MaxDepth then begin
    Colors[NumColors].rgbRed      := Round(RAve);
    Colors[NumColors].rgbGreen    := Round(GAve);
    Colors[NumColors].rgbBlue     := Round(BAve);
    Colors[NumColors].rgbReserved := 0;

    // ���������� History �ɓo�^����B
    with History.Nodes[HistoryNodeIndex] do begin
      DivideID := cidTerminal;   // ���[�̃m�[�h
      ThreshHold := 0;
      ColorIndex := NumColors;   // �J���[�C���f�b�N�X��o�^
      NextNodeIndexLow  := 0;    // ���ʃm�[�h�͖����B
      NextNodeIndexHigh := 0;
    end;

    // ���F�J���[����o�^���ꂽ
    Inc(NumColors);
    ProgressHandler(Nil);
    Exit;
  end;

  // �s�N�Z���Q�𕪊�����B

  // �ԁA�΁A�� �̂����A�ł����U�̑傫���F�ŕ�������B�A���A��r���鎞
  // �Ԃ�3�{�A�΂�4�{�A��2�{���Ă����r����B�΂�Ԃ̕����d�v�Ȃ��߁A
  // �΂�Ԃŕ������N���₷�������A�ǂ��i���̃J���[�e�[�u����������B

  i := Low; j := High;

  if (RD*3 >= GD*4) and (RD*3 >= BD*2) then begin
    // �ԂŃs�N�Z���Q�𕪊�����
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
    // �΂Ńs�N�Z���Q�𕪊�����
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
    // �Ńs�N�Z���Q�𕪊�����
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

  // �����r���Ȃ̂ŃJ���[�C���f�b�N�X�͖���
  History.Nodes[HistoryNodeIndex].ColorIndex := 0;

  // ��������2�̃s�N�Z���Q�ɑ΂��A�ċA�I�� Cut ���ĂԁB
  
  // History �m�[�h�w��� Call ������s���B
  Index := History.nNodes;
  Inc(History.nNodes);
  History.Nodes[HistoryNodeIndex].NextNodeIndexHigh := Index;

  // ���邢�����ɃJ�b�g����B���̕����J���[�e�[�u���̐擪��
  // ���邢�F���W�܂�B0.53 �������
  CutPixels(i, High, Depth+1, MaxDepth, Bits, Colors, NumColors,
            History, Index, ProgressHandler);

  Index := History.nNodes;
  Inc(History.nNodes);
  History.Nodes[HistoryNodeIndex].NextNodeIndexLow := Index;

  CutPixels(Low, i, Depth+1, MaxDepth, Bits, Colors, NumColors,
            History, Index, ProgressHandler);
end;

// Color Cube �Q��2�����Ă䂭���[�`��
// Color Cube �Q����S�s�N�Z���� R, G, B �̕��ϒl�ƕ��U�����߁A
// �ł����U�̑傫���F(R or G or B) �̕��ϒl��p���āA
// Color Cube�Q��2������B����� MaxDepth ��J��Ԃ��΁A
// Color Cube�Q�͍ő�2^MaxDepth�̌Q�ɕ�������B�e�Q�̕��ς̐F�����߁A
// �J���[�e�[�u�����쐬����B

//-------------------------------------------------------------------
// Note
//
// CutCubes �� Cube �̈Ӗ��͌��X �F�̏���Ԃ̈Ӗ��Ŏg���Ă������A���݂�
// �����̃s�N�Z�����܂Ƃ߂����̂Ƃ����Ӗ��ɕς����(^^
// Cube �ɂ̓s�N�Z���̌��A�F�̕��ϒl�������Ă���BTrue Color ����̌��F��
// �g���ꍇ�́A�F��Ԃ� �Ԃ͂R�Q�A�΂� 64�A�͂R�Q�ɕ������� 65536 �̐F��
// ����Ԃɕ������A�e����� �� Cube �Ƃ��Ă܂Ƃ� ���̃��[�`���ɓn���Ό��F
// �J���[��������B
// 8Bit RGB ����̌��F�Ŏg���ꍇ�́ACube �� 8Bit RGB �̊e�F�ɑΉ������A
// �e�F�̃s�N�Z�����𐔂��Ă��� ���̃��[�`���ɓn���΂悢�B
//

procedure CutCubes(Low,        // Color Cube �Q�̍ŏ��� Cube ���w���C���f�b�N�X
                   High,       // Color Cube �Q�̍Ō�̎��� Cube ���w��
                               //�C���f�b�N�X
                   Depth,             // �����̐[��
                   MaxDepth: LongInt; // �����̐[���̍ő�l
                   var Cubes: TColorCubeArray64k; // Color Cube �z��
                   var Colors: TRGBQuadArray;     // ���F�J���[�o�͗p��
                                                  // �J���[�e�[�u��
                   var NumColors: LongInt;        // �o�͂��ꂽ���F�J���[�F�̐�
                   ProgressHandler: TNotifyEvent);// �v���O���X�n���h��
var
  i, j, n, nPoints: LongInt;
  RAve, GAve, BAve: Extended; // �ԁA�΁A�̕��ϒl
  RD, GD, BD: Extended;       // �ԁA�΁A�̕��U
  temp: TColorCube;
begin
  if Low = High then begin
    // Low = High �Ȃ̂� Cube �Q�� Cube ����������Ă��Ȃ��B
  
    // �����̐[���� Max �Ȃ�v���O���X�n���h�����Ăт����B
    if Depth = MaxDepth then begin
      ProgressHandler(Nil);
      Exit;
    end;
    // �_�~�[�̕��� OnProgress �G�x���g���N�����̂ɕK�v�B
    CutCubes(Low, High, Depth+1, MaxDepth, Cubes, Colors, NumColors,
             ProgressHandler);
    CutCubes(Low, High, Depth+1, MaxDepth, Cubes, Colors, NumColors,
             ProgressHandler);
    Exit;
  end;

  // Cube �Q�̐F�̕��ςƕ��U���v�Z
  RAve := 0; GAve := 0; BAve := 0;
  RD := 0; GD := 0; BD := 0; nPoints := 0;
  for i := Low to High-1 do begin
    n := Cubes[i].n;
    Inc(nPoints, n);  // �s�N�Z���̑������J�E���g
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

  // Depth = MaxDepth �܂�A2^MaxDepth�Q�ɕ������Ă���Ȃ�΁A�F�̕��ς�
  // �J���[�e�[�u���ɓo�^����B
  if Depth = MaxDepth then begin
    Colors[NumColors].rgbRed      := Round(RAve);
    Colors[NumColors].rgbGreen    := Round(GAve);
    Colors[NumColors].rgbBlue     := Round(BAve);
    Colors[NumColors].rgbReserved := 0;
    for i := Low to High -1 do
      Cubes[i].n := NumColors;    // Color Cube �ɐF�̃C���f�b�N�X�l��
                                  // ������ n �̈Ӗ��� �s�N�Z��������
                                  // �J���[�C���f�b�N�X�ɕς��B���G��
                                  // �D�܂����Ȃ��� ������������������邽��
                                  // ���p���Ă���BIndex �� n ����ϊ��e�[�u��
                                  // ����邱�Ƃ��ł���B
    // ���F�J���[����o�^���ꂽ
    Inc(NumColors);
    ProgressHandler(Nil);
    Exit;
  end;

  // Color Cube �Q�𕪊�����B
  // �ԁA�΁A�� �̂����A�ł����U�̑傫���F�ŕ�������B�A���A��r���鎞
  // �Ԃ�3�{�A�΂�4�{�A��2�{���Ă����r����B�΂�Ԃ̕����d�v�Ȃ��߁A
  // �΂�Ԃŕ������N���₷�������A�ǂ��i���̃J���[�e�[�u����������B

  i := Low; j := High;

  if (RD*3 >= GD*4) and (RD*3 >= BD*2) then begin
    // �Ԃ� Color Cube �Q�𕪊�����
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
    // �΂� Color Cube �Q�𕪊�����
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
    // �� Color Cube �Q�𕪊�����
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

  // ���邢�����ɃJ�b�g����B���̕����J���[�e�[�u���̐擪��
  // ���邢�F���W�܂�B
  CutCubes(i, High, Depth+1, MaxDepth, Cubes, Colors, NumColors,
           ProgressHandler);
  CutCubes(Low, i, Depth+1, MaxDepth, Cubes, Colors, NumColors,
           ProgressHandler);
end;

/////////////////////////////////////////////////////////////////////
// DIB �̌`���ϊ����[�`���Q
//
// OldDIBInfos ���� DIB �̌`����ϊ����� NewDIBInfos �ɃZ�b�g����B
// OldDIBInfos ���� DIB �͕ω����Ȃ��B
//

//-------------------------------------------------------------------
// Note:
//
// DIB �̌`���ϊ����[�`���̓��\�b�h�ł͂Ȃ� �P�Ȃ�Procedure �Ƃ��Ď��������B
// ���R�� ���ׂĂ̌`���Ԃł̕ϊ����[�`���������̂���ςȂ��� TNkInternalDIB ��
// ������g�ݍ��킹�Ďg������ł���B�`���ϊ��̓r���ŗ�O���������ꍇ�C
// TNkDIB �̃|���V�[�ł̓��\�b�h���ĂԑO�̏�Ԃɖ߂����ƂɂȂ��Ă���̂ŁC
// �ϊ����͏����������C�ϊ������̂Ă�̂͌Ăԑ��̐ӔC�ɂȂ�B
//
// ���Ƃ��� 4BitRLE ���� 8BitRLE �ւ̕ϊ���
// 4BitRLE -> 4BitRGB �ւ̕ϊ��C4BitRGB -> 8BitRGB �ւ̕ϊ��C
// 8BitRGB -> 8BitRLE �ւ̕ϊ� ��3�i�K�𓥂ށB�������Ăяo���̂�
// TNkInternalDIB �� SetPixelFormat �ŁC3�̕ϊ������ׂĂ��܂��s����
// ���߂Č��� DIB ���̂ĕϊ����ʂ��Z�b�g����B
//
// �ϊ����[�`���͈ȉ��̎�ނ�����
//
//                                  �ϊ���
//               1BitRGB  4BitRGB  4BitRLE  8BitRGB  8BitRLE  TrueColor
//      �ϊ���
//     1BitRGB               ��                ��                ��
//     4BitRGB      ��                ��       ��                ��
//     4BitRLE               ��
//     8BitRGB      ��       ��                ��       ��       ��
//     8BitRLE                                 ��
//     TrueColor    ��       ��(*)             ��(*)
//
//     (*) �����^�C�v(16Bit���x) �ƒᑬ�^�C�v(24Bit���x) ��2��ނ�����B
//
// �v19��
//
// TNkDIB �͐F�������Ȃ��Ȃ�`���ϊ��ł͌��F���s���B���̎��� TrueColor �����
// ���F�̐F�̕i���� ConvertMode Property �Ō��܂�BConvertMode �� nkCmFine ��
// ���� ConvertTrueColorTo8BitRGBHigh �����g���邪�C������ Windows API
// (StretchDIBits ��)���悢�i���̌��F��������(^^
//
// 1 BitRGB �ւ̌��F�� Windows �̏K���ɏ]���Ĕw�i�F(BGColor Property)���g����
// �s���BBGColor �ƈ�v����F�� 1(��), ��v���Ȃ��F�� 0(��) �ɕϊ������B
// 1Bit RGB �ւ̕ϊ��ł� �J���[�e�[�u���͋����I�� 
// 0: $000000(��), 1: $FFFFFF(��) �ɂȂ�B
//


// 8Bit RLE -> 8Bit RGB  �ϊ�
procedure Convert8BitRLETo8BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 8Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  Count,                              // �s�N�Z����
  Color: BYTE;                        // �J���[�C���f�b�N�X(Encode)/
                                      // �s�N�Z����(Absolute)
  pSourceByte, pByte: ^BYTE;          // �ϊ����f�[�^�ւ̃|�C���^
begin
  pBits := Nil;

  // ��DIB �� 8BitRLE ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RLE8) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRLETo8BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // ���W�����Z�b�g
    x := 0; y := 0;

    // ���^�V DIB �̃s�N�Z�����ւ̃|�C���^��ݒ�
    pSourceByte := OldDIBInfos.pBits;
    pByte := pBits;

    while True do begin
      // 2 Byte �ǂ�
      Count := pSourceByte^; Inc(pSourceByte);
      Color := pSourceByte^; Inc(pSourceByte);

      if Count = 0 then begin // if RLE_ESCAPE
        case Color of
          1{End Of Bitmap}: Break;
          0{EndOf Line  }: begin
            // ���W�Əo�͐�|�C���^�����̃��C���ɐݒ�
            x := 0; Inc(y);
            pByte := AddOffset(pBits, LineLength * y);
            if y > Height then
              raise ENkDIBInvalidDIB.Create(
                'Convert8BitRLETo8BitRGB: Bad RLE Data 1');
          end;
          2{Delta}: begin
            // Delta �̓A�j���[�V�����p�Ȃ̂ŁA�r�b�g�}�b�v�t�@�C���ɂ�
            // �܂܂�Ȃ��͂������A�ꉞ����
            // �X�L�b�v�ʂ�ǂݍ��݁A���W�Əo�͐��␳
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
            // ��΃��[�h�A�Q�o�C�g�ڂ̐��������A�s�N�Z���l���R�s�[
            System.Move(pSourceByte^, pByte^, Color);

            // ���͌��|�C���^��WORD ���E�Ɉʒu����悤�ɍX�V����B
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
        // Count ���������AColor ���o��
        FillChar(pByte^, Count, Color);
        Inc(x, Count);
        Inc(pByte, Count);
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit �񈳏k
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;


//-------------------------------------------------------------------
// Note
//
// RLE ���k�ł́C���k��̃s�N�Z���f�[�^�ێ��p�̃o�b�t�@������ DIB ��
// �����傫���ɂƂ�B���k�f�[�^�����̃f�[�^���傫���ꍇ��
// ���s����悤�ɂȂ��Ă���B

// 8Bit RGB -> 8Bit RLE  �ϊ�
procedure Convert8BitRGBTo8BitRLE(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
type
  TRunMode = (rmNoData,   // Run �Ƀf�[�^������
              rmUnknown,  // Run ��1�o�C�g�����f�[�^���L���Ԃ��s��
              rmEncode,   // Encode �ŏo�͗\��
              rmAbsolute  // Absolute �ŏo�͗\��
              );
var
  x, y: Integer;                      // ���W
  LineLength,                         // 8Bit RGB �̃X�L�������C���̒���
  CompBufferSize,                     // ���k�p�o�b�t�@�̃T�C�Y
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pCompBuffer: ^Byte;                 // ���k�p�o�b�t�@
  pByte:       ^Byte;                 // ���k�o�b�t�@�ւ̏������ݗp�|�C���^�G
  pSourceByte: PByteArray64k;         // �ϊ����f�[�^�ւ̃|�C���^
  RunBuffer: array[0..255] of Byte;   // Run �o�b�t�@
  RunIndex: Integer;                  // Run �o�b�t�@�A�N�Z�X�p�C���f�b�N�X
  ColorIndex: Byte;                   // �s�N�Z���l
  RunMode: TRunMode;                  // Run �o�b�t�@�̏��



  function GetRest: LongInt; // ���k�p�o�b�t�@�̎c�ʂ𓾂�B
  begin
    result := CompBufferSize - (LongInt(pByte) - LongInt(pCompBuffer));
  end;

  procedure CompFail;
  begin
    raise ENkDIBCompressionFailed.Create(
            'Convert8BitRGBTo8BitRLE: Compression Failed');
  end;

  // Encode Mode ������ �s�N�Z����(Count > 0) �� �J���[�C���f�b�N�X(Color)
  procedure WriteEncode(Color, Count: Byte);
  begin
    // �������c�ʃ`�F�b�N 4 �� EndOfLine �� EndOfBitmap �̕�
    if GetRest < (4 + 2) then CompFail;
    pByte^ := Count; Inc(pByte);
    pByte^ := Color; Inc(pByte);
  end;

  // Absolute Mode ������ �s�N�Z�����ƃJ���[�C���f�b�N�X��
  procedure WriteAbsolute;
  begin
    Assert(RunIndex > 0,
      'Convert8BitRGBTo8BitRLE: WriteAbsolute Error');

    // �������c�ʃ`�F�b�N 4 �� EndOfLine �� EndOfBitmap �̕�
    if GetRest < ( 4 + 2 + (((RunIndex + 1) div 2) * 2) ) then CompFail;

    // Run �̒����� 2 �ȉ��̏ꍇ Absolute ���[�h�ł̓s�N�Z������ 3 �ȏ��
    // �Ȃ��Ă͂Ȃ�Ȃ����� 2�� Encode Mode �ŏ����B
    if RunIndex <= 2 then begin
      WriteEncode(RunBuffer[0], 1);
      if RunIndex = 2 then WriteEncode(RunBuffer[1], 1);
    end
    else begin
      // Run �̒������R�ȏ�̏ꍇ
      pByte^ := 0; Inc(pByte);
      pByte^ := RunIndex; Inc(pByte);
      System.Move(RunBuffer, pByte^, RunIndex);
      Inc(pByte, RunIndex);

      // �s�N�Z��������Ȃ� �P�s�N�Z�����p�f�B���O������(Run �͋������E)
      if (RunIndex mod 2) <> 0 then begin
        pByte^ := 0; Inc(pByte);
      end;
    end;
  end;

  // EOL ������
  procedure WriteEndOfLine;
  begin
    // �������c�ʃ`�F�b�N 2 �� EndOfBitmap �̕�
    if GetRest < (2 + 2) then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 0; Inc(pByte);
  end;

  // End Of Bitmap ������
  procedure WriteEndOfBitmap;
  begin
    if GetRest < 2 then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 1; Inc(pByte);
  end;

begin
  pBits := Nil;

  // ��DIB �� 8BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRGBTo8BitRLE: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // ���k�p�o�b�t�@�T�C�Y�� RGB �`���Ɠ����傫���Ƃ���B������z������
  // �ϊ����s�B
  CompBufferSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMem(pCompBuffer, CompBufferSize);

  try
    pByte := Pointer(pCompBuffer);  // �������ݗp�|�C���^��������

    for y := 0 to Height-1 do begin
      // ���k���̃X�L�������C���̐擪�����߂�B
      // ���k���ʂ͏�� Bottom-Up �`���łȂ���΂Ȃ�Ȃ����� biHeight �̕�����
      // �ǂޏ��Ԃ�ς���
      if OldDIBInfos.W3Head.biHeight > 0 then
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*y)
      else
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*(Height - 1 -y));

      RunMode := rmNodata;   // Run Mode ������
      for x := 0 to Width-1 do begin
        ColorIndex := pSourceByte^[x];
        case RunMode of
          rmNoData: begin
            RunBuffer[0] := ColorIndex;
            RunIndex := 1;
            RunMode := rmUnknown;
          end;
          rmUnknown:
            // �ŏ��̂Q�s�N�Z���̐F����v����Ȃ� Encode Mode �ɂ���B
            if RunBuffer[0] = ColorIndex then begin
              RunBuffer[1] := 2;  // Runbuffer[1] ���J�E���^�Ƃ��Ďg��
              RunMode := rmEncode;
            end
            else begin
            // �ŏ��̂Q�s�N�Z���̐F���Ⴄ�Ȃ� Absolute Mode �ɂ���B
              RunBuffer[RunIndex] := ColorIndex;
              Inc(RunIndex);
              RunMode := rmAbsolute;
            end;
          rmEncode:
            if (RunBuffer[1] < 255) and (RunBuffer[0] = ColorIndex) then
              Inc(RunBuffer[1])
            else begin
              // Encode Mode �̐؂�ڂ𔭌��I�I
              // (���F���r�؂�Ă��邩 255 �ɒB����
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
              // Absolute Mode �̐؂�ڂ𔭌��I�I
              // (���F������������ 255 �ɒB����
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
      // EOL �ɒB�����̂� RunBuffer �̒��g�������o���B
      case RunMode of
        rmUnknown:  WriteEnCode(RunBuffer[0], 1);
        rmEncode:   WriteEncode(RunBuffer[0], RunBuffer[1]);
        rmAbsolute: WriteAbsolute;
      end;
      WriteEndOfLine;
    end;
    WriteEndOfBitmap;

    // �o�͗p�o�b�t�@���m�ۂ���B
    BitsSize := LongInt(pByte) - LongInt(pCompBuffer); // ���k��̃T�C�Y
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      System.Move(pCompBuffer^, pBits^, BitsSize);

      // ������
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biHeight := Height;         // RLE �͂��� BottomUp
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit RLE
      NewDIBInfos.W3Head.biCompression := BI_RLE8;
      NewDIBInfos.W3Head.biSizeImage := BitsSize;
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);//���s �VDIB���̂Ă�B
      raise;
    end;
  finally
    FreeMem(pCompBuffer, CompBufferSize);
  end;
end;

//-------------------------------------------------------------------
// Note
//
// 4Bit RLE ���k�ł͏����蔲�������Ă���B4Bit RLE �ł͖{�� Enode/Abslute
// ���[�h�Ńs�N�Z�����Ɋ���w��ł���B����������ł͑�ςȂ̂� EOL �̒��O
// �ȊO�͋����Ɍ��肵���B�������邱�Ƃ� Encode Mode �̏����������Ɗy�ɂȂ�B
//
// ��F �{���� Encode Mode 07 45  ->   4 5 4 5 4 5 4 �ȂǂƂł��邪
//      TNkDIB �ł�        06 45  ->   4 5 4 5 4 5   �Ƃ������ɋ����s�N�Z����
//      ���肷��B�������邱�ƂłقƂ�ǃo�C�g�P�ʂ̏����� 4Bit RLE ���k��
//      �ł���B


// 4Bit RGB -> 4Bit RLE  �ϊ�
procedure Convert4BitRGBTo4BitRLE(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
type
  TRunMode = (rmNoData,   // Run �Ƀf�[�^������
              rmUnknown,  // Run ��1�o�C�g�����f�[�^���L���Ԃ��s��
              rmEncode,   // Encode �ŏo�͗\��
              rmAbsolute  // Absolute �ŏo�͗\��
              );
var
  x, y: Integer;                      // ���W
  LineLength,                         // 4Bit RGB �̃X�L�������C���̒���
  CompBufferSize,                     // ���k�悤�o�b�t�@�̃T�C�Y
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pCompBuffer: ^Byte;                 // ���k�p�o�b�t�@
  pByte:       ^Byte;                 // ���k�o�b�t�@�ւ̏������ݗp�|�C���^�G
  pSourceByte: PByteArray64k;         // �ϊ����f�[�^�ւ̃|�C���^
  RunBuffer: array[0..255] of Byte;   // Run �o�b�t�@
  RunIndex: Integer;                  // Run �o�b�t�@�A�N�Z�X�p�C���f�b�N�X
  ColorIndex: Byte;                   // �s�N�Z���l
  PixelCounter: Integer;              // �X�L�������C���ɏ������񂾃s�N�Z����
  RunMode: TRunMode;                  // Run �o�b�t�@�̏��


  function GetRest: LongInt; // ���k�p�o�b�t�@�̎c�ʂ𓾂�B
  begin
    result := CompBufferSize - (LongInt(pByte) - LongInt(pCompBuffer));
  end;

  procedure CompFail;
  begin
    raise ENkDIBCompressionFailed.Create(
            'Convert4BitRGBTo4BitRLE: Compression Failed');
  end;

  // Encode Mode ������ �s�N�Z����(Count*2 > 0) �� �J���[�C���f�b�N�X(Color)
  procedure WriteEncode(Color, Count: Byte);
  begin
    // �������c�ʃ`�F�b�N 4 �� EndOfLine �� EndOfBitmap �̕�
    if GetRest < (4 + 2) then CompFail;

    if (Width - PixelCounter) < (Count * 2) then begin
      // �X�L�������C���̒�������Ȃ�C���C������Encode ���������ނƂ�
      // (Width - PixelCounter) = (Count * 2) -1 �ɂȂ�͂��B
      // ���̏ꍇ�͎c�s�N�Z�������Z�b�g����B
      pByte^ := Width - PixelCounter; PixelCounter := Width; Inc(pByte);
    end
    else begin
      // �s�N�Z�����̓o�C�g����2�{
      pByte^ := Count*2; Inc(PixelCounter, Count*2); Inc(pByte);
    end;
    pByte^ := Color; Inc(pByte);
  end;

  // Absolute Mode ������ �s�N�Z����(RunIndex*2)�ƃJ���[�C���f�b�N�X��
  procedure WriteAbsolute;
  begin
    Assert(RunIndex > 0,
      'Convert4BitRGBTo4BitRLE: WriteAbsolute Error');

    // �������c�ʃ`�F�b�N 4 �� EndOfLine �� EndOfBitmap �̕�
    if GetRest < ( 4 + 2 + (((RunIndex + 1) div 2) * 2) ) then CompFail;

    if RunIndex <= 1 then begin 
      // Run �̒����� 2 �s�N�Z���ȉ��̏ꍇ Absolute ���[�h�ł̓s�N�Z������ 
      // 3 �ȏ�łȂ��Ă͂Ȃ�Ȃ����� 1�� Encode Mode �ŏ����B
      WriteEncode(RunBuffer[0], 1);
    end
    else begin
      // Run �̒������R�s�N�Z���ȏ�̏ꍇ
      pByte^ := 0; Inc(pByte);
      if (Width - PixelCounter) < (RunIndex * 2) then begin
        // �X�L�������C���̒�������Ȃ�C���C������ abslute ���������ނƂ�
        // (Width - PixelCounter) = (RunIndex * 2) -1 �ɂȂ�͂��B
        // ���̏ꍇ�͎c�s�N�Z�������Z�b�g����B
        pByte^ := Width - PixelCounter; PixelCounter := Width; Inc(pByte);
      end
      else begin
        // Abslute �̒��� RunIndex�i�o�C�g��)*2 ������
        pByte^ := RunIndex*2; Inc(PixelCounter, RunIndex*2); Inc(pByte);
      end;
      System.Move(RunBuffer, pByte^, RunIndex);
      Inc(pByte, RunIndex);

      // �o�C�g������Ȃ� �P�o�C�g���p�f�B���O������
      // (Run �͋������E)
      if (RunIndex mod 2) <> 0 then begin
        pByte^ := 0; Inc(pByte);
      end;
    end;
  end;

  // EOL ������
  procedure WriteEndOfLine;
  begin
    // �������c�ʃ`�F�b�N 2 ��  EndOfBitmap �̕�
    if GetRest < (2 + 2) then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 0; Inc(pByte);
  end;

  // End Of Bitmap ������
  procedure WriteEndOfBitmap;
  begin
    if GetRest < 2 then CompFail;
    pByte^ := 0; Inc(pByte);
    pByte^ := 1; Inc(pByte);
  end;

begin
  pBits := Nil;

  // ��DIB �� 4BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBTo4BitRLE: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 4 + 31) div 32) * 4;

  // ���k�p�o�b�t�@�T�C�Y�� RGB �`���Ɠ����傫���Ƃ���B������z������
  // �ϊ����s�B
  CompBufferSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMem(pCompBuffer, CompBufferSize);

  try
    pByte := Pointer(pCompBuffer);  // �������ݗp�|�C���^��������

    for y := 0 to Height-1 do begin
      // ���k���̃X�L�������C���̐擪�����߂�B
      // ���k���ʂ͏�� Bottom-Up �`���łȂ���΂Ȃ�Ȃ����� biHeight �̕�����
      // �ǂޏ��Ԃ�ς���
      if OldDIBInfos.W3Head.biHeight > 0 then
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*y)
      else
        pSourceByte := AddOffset(OldDIBInfos.pBits, LineLength*(Height - 1 -y));

      RunMode := rmNodata;  // Run Mode ������
      PixelCounter := 0;

      // Width ����Ȃ� Width + 1 (�o�C�g���E)�܂ŏ�������B
      for x := 0 to ((Width+1) div 2) -1 do begin
        ColorIndex := pSourceByte^[x];
        case RunMode of
          rmNoData: begin
            RunBuffer[0] := ColorIndex;
            RunIndex := 1;
            RunMode := rmUnknown;
          end;
          rmUnknown:
            // �ŏ��̂Q�o�C�g����v����Ȃ� Encode Mode �ɂ���B
            if RunBuffer[0] = ColorIndex then begin
              RunBuffer[1] := 2;  // Runbuffer[1] ���J�E���^�Ƃ��Ďg��
              RunMode := rmEncode;
            end
            else begin
            // �ŏ��̂Q�o�C�g���Ⴄ�Ȃ� Absolute Mode �ɂ���B
              RunBuffer[RunIndex] := ColorIndex;
              Inc(RunIndex);
              RunMode := rmAbsolute;
            end;
          rmEncode:
              // Encode Mode �̐؂�ڂ𔭌��I�I
              // ���o�C�g�l���r�؂�Ă��邩 254 Pixel�ɒB�����ꍇ
              // Note: �{���� 255 Pixel �������� Pixel �̂ݑΏۂɂ��邽��
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
              // Absolute Mode �̐؂�ڂ𔭌��I�I
              // (���o�C�g�l������������ 255 �ɒB����
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
      // EOL �ɒB�����̂� RunBuffer �̒��g�������o���B
      case RunMode of
        rmUnknown:  WriteEnCode(RunBuffer[0], 1);
        rmEncode:   WriteEncode(RunBuffer[0], RunBuffer[1]);
        rmAbsolute: WriteAbsolute;
      end;
      WriteEndOfLine;
    end;
    WriteEndOfBitmap;

    // �o�͗p�o�b�t�@���m�ۂ���B
    BitsSize := LongInt(pByte) - LongInt(pCompBuffer); // ���k��̃T�C�Y
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      System.Move(pCompBuffer^, pBits^, BitsSize);

      // ������
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biHeight := Height;         // RLE �͂��� BottomUp
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 4;            // 4 Bit RLE
      NewDIBInfos.W3Head.biCompression := BI_RLE4;
      NewDIBInfos.W3Head.biSizeImage := BitsSize;
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �VDIB���̂Ă�B
      raise;
    end;
  finally
    FreeMem(pCompBuffer, CompBufferSize);
  end;
end;


// 4Bit RGB -> 8Bit RGB  �ϊ�
procedure Convert4BitRGBTo8BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 8Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte, pByte: ^BYTE;          // �ϊ����X�L�������C���ւ̃|�C���^
begin
  pBits := Nil;

  // ��DIB �� 4BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBTo8BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // �� DIB �̃��C���̑傫�����v�Z
    SourceLineLength := ((Width * 4 + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�� 4Bit �Â��o���� 8Bit �Â�������
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

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit �񈳏k
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB���̂Ă�B
    raise;
  end;
end;

// 1Bit RGB -> 8Bit RGB  �ϊ�
procedure Convert1BitRGBTo8BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 8Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte, pByte: ^BYTE;          // �ϊ����X�L�������C���ւ̃|�C���^
  Bits8: Byte;                        // �r�b�g����p�ϐ��B
begin
  pBits := Nil;
  Bits8 := 0; // �R���p�C���̌x����ق点�邽��

  // ��DIB �� 1BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 1) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert1BitRGBTo8BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 8 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // �� DIB �̃��C���̑傫�����v�Z
    SourceLineLength := ((Width + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);
       // ���̃s�N�Z���l�� 1Bit �Â��o���� 8Bit �Â�������
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

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit �񈳏k
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;

// 1Bit RGB -> 4Bit RGB  �ϊ�
procedure Convert1BitRGBTo4BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 4Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte, pByte: ^BYTE;          // �ϊ����X�L�������C���ւ̃|�C���^
  Bits8: Byte;                        // �r�b�g����p�ϐ��B
begin
  pBits := Nil;
  Bits8 := 0; // �R���p�C���̌x����ق点�邽��

  // ��DIB �� 1BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 1) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert1BitRGBTo4BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 4 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // �� DIB �̃��C���̑傫�����v�Z
    SourceLineLength := ((Width + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);
       // ���̃s�N�Z���l�� 1Bit �Â��o���� 4Bit �Â�������
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

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit �񈳏k
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;


// 4Bit RLE -> 4Bit RGB  �ϊ�
procedure Convert4BitRLETo4BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  i: Integer;
  x, y: Integer;                      // ���W
  LineLength,                         // 4Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  Width2: Integer;                    // Width �������ɐ؂�グ������
  Count,                              // Encode Mode �̃s�N�Z���l
  Color: BYTE;                        // Encode Mode �� Color Index 
                                      // Absolute Mode �̃s�N�Z�����B
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte,                        // �ϊ����f�[�^�ւ̃|�C���^
  pByte,                              // �ϊ���f�[�^�ւ̃|�C���^
  pTemp: ^Byte;

begin
  pBits := Nil;

  // ��DIB �� 4BitRLE ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RLE4) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRLETo4BitRGB: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width * 4 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // ���W�����Z�b�g
    x := 0; y := 0;

    // ���^�V DIB �̃s�N�Z�����ւ̃|�C���^��ݒ�
    pSourceByte := OldDIBInfos.pBits;
    pByte := pBits;


    // 4Bit RLE �̏ꍇ�A ������s�N�Z���̏ꍇ�A1�s�N�Z���]���� Encode
    // �����P�[�X������B���̂��߁A���̃`�F�b�N�������s�N�Z������
    // �s���悤�ɂ���B
    // 
    // Note: �{���s���ȃr�b�g�}�b�v���� ���Ȃ�̐������݂���̂ł�������Ȃ��B
    //       Windows API �����������Ȃ��悤��(StretchDIBits �Ȃ�)
    Width2 := ((Width + 1) div 2) * 2;

    while True do begin
      //�Q�o�C�g�ǂ�
      Count := pSourceByte^; Inc(pSourceByte);
      Color := pSourceByte^; Inc(pSourceByte);

      if Count = 0 then begin // if RLE_ESCAPE
        case Color of
          1{End Of Bitmap}: Break;
          0{End Of Line  }: begin
            // ���W�Əo�͐�|�C���^�����̃��C���ɐݒ�
            x := 0; Inc(y);
            pByte := AddOffset(pBits, LineLength * y);
            if y > Height then
              raise ENkDIBInvalidDIB.Create(
                'Convert4BitRLETo4BitRGB: Bad RLE Data 5');
          end;
          2{Delta}: begin
            // Delta �̓A�j���[�V�����p�Ȃ̂ŁA�r�b�g�}�b�v�t�@�C���ɂ�
            // �܂܂�Ȃ��͂������A�ꉞ����
            // �X�L�b�v�ʂ�ǂݍ��݁A���W�Əo�͐��␳
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

            // ��΃��[�h�A�Q�o�C�g�ڂ̐��������A�s�N�Z���l���R�s�[
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
            // ���͌��|�C���^��WORD ���E�Ɉʒu����悤�ɍX�V����B
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

        // Count ���������AColor ���o��
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

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 4;            // 4Bit �񈳏k
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;

// 1Bit RGB �� TrueColor �ɕϊ��B
procedure Convert1BitRGBToTrueColor(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // TrueColor�X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte: ^Byte;                 // �ϊ����f�[�^�ւ̃|�C���^
  pTriple: ^TNkTriple;                // �ϊ���f�[�^�ւ̃|�C���^
  Bits8: Byte;                        // �r�b�g����p�ϐ��B
  ColorIndex: Byte;                   // �J���[�̃C���f�b�N�X
begin
  pBits := Nil;
  Bits8 := 0; // �R���p�C���̌x����ق点�邽��

  // ��DIB �� 1BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 1) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert1BitRGBToTrueColor: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 1Bit -> True Color  �ϊ�

    // �� DIB �̃��C���̑傫�����v�Z
    SourceLineLength := ((Width + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pTriple := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�� 1Bit �Â��o���� 24Bit �Â�������
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := pSourceByte^;
          Inc(pSourceByte);
        end;

        // 1Bit -> 24 Bit �ϊ�
        if (Bits8 and $80) <> 0 then ColorIndex := 1 else ColorIndex := 0;

        pTriple.R := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbRed;
        pTriple.G := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbGreen;
        pTriple.B := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbBlue;

         Bits8 := (Bits8 and $7f) shl 1;
        Inc(pTriple);
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 24;            // True Color
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;


// 4Bit RGB �� TrueColor �ɕϊ��B
procedure Convert4BitRGBToTrueColor(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // TrueColor �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte: ^Byte;                 // �ϊ����f�[�^�ւ̃|�C���^
  pTriple: ^TNkTriple;                // �ϊ���f�[�^�ւ̃|�C���^
  ColorIndex: Byte;                   // �J���[�̃C���f�b�N�X

begin
  pBits := Nil;

  // ��DIB �� 4BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBToTrueColor: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 4Bit -> True Color  �ϊ�

    // �� DIB �̃��C���̑傫�����v�Z
    SourceLineLength := ((Width*4 + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pTriple := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�� 4Bit �Â��o���� 24Bit �Â�������
      for x := 0 To Width -1 do begin
        if (x mod 2) = 0 then
          ColorIndex := (pSourceByte^ shr 4) and $0f
        else begin
          ColorIndex := pSourceByte^ and $0f;
          Inc(pSourceByte);
        end;

        // 4Bit -> 24 Bit �ϊ�
        pTriple.R := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbRed;
        pTriple.G := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbGreen;
        pTriple.B := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbBlue;

        Inc(pTriple);
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 24;            // True Color
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;

// 8Bit RGB �� TrueColor �ɕϊ��B
procedure Convert8BitRGBToTrueColor(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // TrueColor �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte: ^Byte;                 // �ϊ����f�[�^�ւ̃|�C���^
  pTriple: ^TNkTriple;                // �ϊ���f�[�^�ւ̃|�C���^
  ColorIndex: Byte;                   // �J���[�̃C���f�b�N�X

begin
  pBits := Nil;

  // ��DIB �� 8BitRGB ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRGBToTrueColor: ' +
          'Invalid Bitcount & Compression Combination');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    // 4Bit -> True Color  �ϊ�

    // �� DIB �̃��C���̑傫�����v�Z
    SourceLineLength := ((Width*8 + 31) div 32) * 4;

    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pTriple := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�� 8Bit �Â��o���� 24Bit �Â�������
      for x := 0 To Width -1 do begin
        ColorIndex := pSourceByte^;
        Inc(pSourceByte);

        // 8Bit -> 24 Bit �ϊ�
        pTriple.R := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbRed;
        pTriple.G := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbGreen;
        pTriple.B := OldDIBInfos.W3HeadInfo.bmiColors[ColorIndex].rgbBlue;

        Inc(pTriple);
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 24;            // True Color
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;



// True Color �� 16bit ���x�Ō��F���郋�[�`���B
// MaxDepth �ŐF�����w�肷��B 4: 16�F  8: 256 �F
// �F��Ԃ� �Ԃ͂R�Q�A�΂� 64�A�͂R�Q�ɕ������� 65536 �̐F��
// ����Ԃɕ������A�e����� �� Cube �Ƃ��Ă܂Ƃ� CutCubes �Ō��F����B

// TrueColor �r�b�g�}�b�v���� �œK�����ꂽ���F�J���[�𓾂�B�P�U�r�b�g���x
procedure GetReducedColorsLow(var DIBInfos:TNkDIBInfos;
                              var NumColors: LongInt;
                              var Colors: TRGBQuadArray;
                              var ColorTransTable: TByteArray64k3D;
                                  MaxDepth: Integer;
                                  ProgressHandler: TNotifyEvent);
var
  i, j,
  Width, Height,                    // �r�b�g�}�b�v�̑傫��
  SourceLineLength,                 // True Color �̃X�L�������C���̒���
  NumCubes: LongInt;                // ����Ԃ̐�
  pColorTransTable1: PByteArray64k; // �F�ϊ��e�[�u���ւ̃|�C���^
  pCubes1: PColorCubeArray64k;      // ����Ԕz��ւ̃|�C���^�i�P�����j
  pCubes2: PColorCubeArray64k3D;    // ����Ԕz��ւ̃|�C���^�i�R�����j
  pSourceTriple: PNkTripleArray;    // TrueColor �r�b�g�}�b�v�A�N�Z�X�p�|�C���^
  ri, gi, bi, n: LongInt;           // �s�N�Z�� �� RGB �l�� ��ʂ̕�����
                                    // �����o��������
                                    // ��: ���5�r�b�g  ��: ���6�r�b�g
                                    // ��: ���5�r�b�g
begin
  Width := DIBInfos.W3Head.biWidth;
  Height := abs(DIBInfos.W3Head.biHeight);
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  //�F�ϊ��e�[�u���̃��������m��
  pCubes1 := Nil;
  pColorTransTable1 := @ColorTransTable;
  try
    // True Color �r�b�g�}�b�v���� 2^MaxDepth �F�̍œK���J���[�𒊏o����B

    // �܂��ACubes�i�F�̏���Ԕz��) �����

    // Color Cube Array �� ���������m��
    GetMem(pCubes1,  SizeOf(TColorCubeArray64k));
    pCubes2 := PColorCubeArray64k3D(pCubes1);

    // Color Cube Array ��������
    FillChar(pCubes1^, SizeOf(TColorCubeArray64k), 0);
    for i := 0 to 65535 do
      pCubes1^[i].Index := i; // Color Cube �̌��̈ʒu��������悤��
                              // Index ��t����B�F�ϊ��e�[�u�������Ƃ��Ɏg��

    // Color Cube Array �Ƀs�N�Z������ώZ
    for i := 0 to Height-1 do begin

      // DIB �̃��C���̐擪�A�h���X���Z�o
      pSourceTriple := AddOffset(DIBInfos.pBits, SourceLineLength * i);

      // ���C���ɑ΂���
      for j := 0 to Width-1 do begin

        //Color Cube �̃C���f�b�N�X�l�����߂�
        ri := pSourceTriple^[j].R shr 3;
        gi := pSourceTriple^[j].G shr 2;
        bi := pSourceTriple^[j].B shr 3;

        // RGB �l�̃C���f�b�N�X�l�ɑ΂��鍷��������ώZ����B
        // �������邱�ƂŁA32Bit �ł��ώZ�ł���B
        Inc(pCubes2^[ri, gi, bi].R, pSourceTriple^[j].R and $07);
        Inc(pCubes2^[ri, gi, bi].G, pSourceTriple^[j].G and $03);
        Inc(pCubes2^[ri, gi, bi].B, pSourceTriple^[j].B and $07);
        Inc(pCubes2^[ri, gi, bi].n);
      end;
    end;

    // �e Color Cube �� RGB �l�̕��ϒl�𓾂�B
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

    // �J���[�e�[�u�������B

    // �s�N�Z����1�ȏ�����Ă��� Color Cube ������I��
    // �������邱�ƂŁA�F�̕΂肪�������ꍇ�A�v�Z�ʂ���������\���������B
    NumCubes := 0;

    for i := 0 to 32*64*32-1 do
      if pCubes1^[i].n <> 0 then begin
        pCubes1^[NumCubes] := pCubes1^[i];
        Inc(NumCubes);
      end;


    NumColors := 0; //���o�����F���������ݒ�
    // �F�𒊏o����
    CutCubes(0, NumCubes, 0, MaxDepth, pCubes1^, Colors, NumColors,
             ProgressHandler);

    // �F�ϊ��e�[�u�������BIndex �� n �ɕϊ������e�[�u����
    // ���΂悢�B
    FillChar(pColorTransTable1^, SizeOf(TByteArray64k), 0);
    for i := 0 to NumCubes-1 do
      pColorTransTable1^[pCubes1^[i].Index] := pCubes1^[i].n;

  finally
    // Color Cube Array ��j������B
    if pCubes1 <> Nil then FreeMem(pCubes1,  SizeOf(TColorCubeArray64k));
  end;
end;


// TrueColor �� 8BitRGB �ɕϊ��B16Bit ���x
procedure ConvertTrueColorTo8BitRGBLow(var OldDIBInfos: TNkDIBInfos;
                                       var NewDIBInfos: TNkDIBInfos;
                                       ProgressHandler: TNotifyEvent;
                                       UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 8Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Colors: TRGBQuadArray;              // ���o���ꂽ�J���[�e�[�u���B
  pColorTransTable: PByteArray64k3D;  // �F�ϊ��e�[�u���B
  ColorTriple: TNkTriple;             // �s�N�Z���l True Color -> 8 Bit �ϊ��p
  NumColors: LongInt;                 // ���o���ꂽ�F�̐�
begin
  pBits := Nil;

  // ��DIB �� TrueColor ���`�F�b�N
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo8BitRGBLow: ' +
          'Invalid Bitcount');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*8 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    GetMem(pColorTransTable, SizeOf(TByteArray64k));
    try

      // ���F�J���[�ƐF�ϊ��e�[�u���𓾂�B
      GetReducedColorsLow(OldDIBInfos, NumColors, Colors,
                          pColorTransTable^, 8, ProgressHandler);

      // �����A�ϊ��J�n�I�I

      for y := 0 to Height -1 do begin
        // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
        pByte := AddOffset(pBits, LineLength * y);
        pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

        // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
        // �F�̃C���f�b�N�X�l����������
        for x := 0 To Width -1 do begin

          // �s�N�Z���l�����o��
          ColorTriple := pSourceTriple^[x];

          // �ϊ����ď�������
          pByte^ := pColorTransTable^[ColorTriple.R shr 3,
                                      ColorTriple.G shr 2,
                                      ColorTriple.B shr 3];
          Inc(pByte);
        end;
      end;
    finally
      // �F�ϊ��e�[�u����j������
      if pColorTransTable <> Nil then
        FreeMem(pColorTransTable, Sizeof(TByteArray64k));
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    // ���F���ꂽ�V�����J���[�e�[�u�����Z�b�g����
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
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;

// TrueColor �� 4BitRGB �ɕϊ��B16Bit ���x
procedure ConvertTrueColorTo4BitRGBLow(var OldDIBInfos: TNkDIBInfos;
                                       var NewDIBInfos: TNkDIBInfos;
                                       ProgressHandler: TNotifyEvent;
                                       UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 4Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Colors: TRGBQuadArray;              // ���o���ꂽ�J���[�e�[�u���B
  pColorTransTable: PByteArray64k3D;  // �F�ϊ��e�[�u���B
  ColorTriple: TNkTriple;             // �s�N�Z���l True Color -> 8 Bit �ϊ��p
  NumColors: LongInt;                 // ���o���ꂽ�F�̐�
  ColorIndex: LongInt;                // �J���[�C���f�b�N�X
begin
  pBits := Nil;

  // ��DIB �� TrueColor ���`�F�b�N
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo4BitRGBLow: ' +
          'Invalid Bitcount');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*4 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    GetMem(pColorTransTable, SizeOf(TByteArray64k));
    try

      // ���F�J���[�ƐF�ϊ��e�[�u���𓾂�B
      GetReducedColorsLow(OldDIBInfos, NumColors, Colors,
                          pColorTransTable^, 4, ProgressHandler);

      // �����A�ϊ��J�n�I�I
      for y := 0 to Height -1 do begin
        // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
        pByte := AddOffset(pBits, LineLength * y);
        pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

        // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
        // �F�̃C���f�b�N�X�l����������
        for x := 0 To Width -1 do begin

          // �s�N�Z���l�����o��
          ColorTriple := pSourceTriple^[x];

          // �ϊ����ď�������
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
      // �F�ϊ��e�[�u����j������
      if pColorTransTable <> Nil then
        FreeMem(pColorTransTable, Sizeof(TByteArray64k));
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    // ���F���ꂽ�V�����J���[�e�[�u�����Z�b�g����
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
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;



//
// ���̃��[�`���� TrueColor ���猸�F�J���[�ƕ��������𓾂�B
// �����͂قƂ�� CutPixel ���s���̂ŁA GetReducedColorsHigh ���s���̂�
// �s�N�Z����1�����z��ɒ������Ƃ����ł���B
//

// TrueColor �r�b�g�}�b�v���� �œK�����ꂽ���F�J���[�𓾂�B24�r�b�g���x
procedure GetReducedColorsHigh(var DIBInfos:TNkDIBInfos;
                               var NumColors: LongInt;
                               var Colors: TRGBQuadArray;
                               var History: TCutHistory;
                                   MaxDepth: Integer;
                               ProgressHandler: TNotifyEvent);
var
  pBits: PNkTripleArray;             // �s�N�Z���̔z��ւ̃|�C���^
  LineWidth: LongInt;                // DIB ��1���C���̑傫��
  NumPixels, i: LongInt;             // ���s�N�Z����
  Width, Height: LongInt;            // �����C��
begin
  Width := DIBInfos.W3Head.biWidth;
  Height := abs(DIBInfos.W3Head.biHeight);

  History.nNodes := 1;

  NumColors := 0;              // �I�΂��F���O�ɏ����ݒ�
  NumPixels := Width * Height; // ���s�N�Z�����v�Z

  // DIB ��1���C���̑傫�����v�Z
  LineWidth := ((Width * 3 + 3) div 4) * 4;

  // �s�N�Z���f�[�^�����p�̃o�b�t�@���m��
  GetMem(pBits, Width * Height * 3 + 4);
  try
    // �s�N�Z�����l�߂ăo�b�t�@�ɃR�s�[�i���C���Ԃ̌��Ԃ��폜����j
    for i := 0 to Height-1 do
      System.Move(AddOffset(DIBInfos.pBits, LineWidth * i)^,
                  pBits^[Width * i], LineWidth);

    // �F�𒊏o
    CutPixels(0, NumPixels, 0, MaxDepth, pBits^, Colors, NumColors, History, 0,
              ProgressHandler);

  finally
    // ��Ɨp�o�b�t�@��j������B
    FreeMem(pBits, Width * Height * 3 + 4);
  end;
end;


//-------------------------------------------------------------------
// Note:
//
// �ȉ���2���[�`�� ConvertTrueColorTo8BitRGBHight ��
// ConvertTrueColorTo4BitRGBHight �� GetReducedColrosHigh ���g���Č��F��
// ���A�`���ϊ����s���B�����̃��[�`���ł͌��F���ꂽ�F�֐F�ϊ����s���Ƃ�
// 24Bit ���x�ŐF�ϊ����s�����ߐF�ϊ��e�[�u�����g���Ȃ��B��6�S���F���̐F�ϊ�
// �e�[�u���ȂǍ��͕̂s�\�����炾�B���̑���ɁA���F�̉ߒ����L�^����
// ���������ɁA�ő� MaxDepth��̔�r�� RGB�l�� Color Index �ɕϊ�����B
// ���������̏ڍׂ� CutPixels ���Q�Ƃ��ꂽ���B

// TrueColor �� 8BitRGB �ɕϊ��B24Bit ���x
procedure ConvertTrueColorTo8BitRGBHigh(var OldDIBInfos: TNkDIBInfos;
                                        var NewDIBInfos: TNkDIBInfos;
                                        ProgressHandler: TNotifyEvent;
                                        UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 8Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Colors: TRGBQuadArray;              // ���o���ꂽ�J���[�e�[�u���B
  ColorTriple: TNkTriple;             // �s�N�Z���l True Color -> 8 Bit �ϊ��p
  NumColors: LongInt;                 // ���o���ꂽ�F�̐�
  History: TCutHistory;               // ���F����
  HistoryIndex: Integer;              // �����C���f�b�N�X
begin
  pBits := Nil;

  // ��DIB �� TrueColor ���`�F�b�N
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo8BitRGBHigh: ' +
          'Invalid Bitcount');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*8 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    // ���F�J���[�i256�F�j�ƕ��������𓾂�B
    GetReducedColorsHigh(OldDIBInfos, NumColors, Colors,
                           History, 8, ProgressHandler);

    // �����A�ϊ��J�n�I�I
    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
      // �F�̃C���f�b�N�X�l����������
      for x := 0 To Width -1 do begin

        // �s�N�Z���l�����o��
        ColorTriple := pSourceTriple^[x];

        // RGB -> Color Index �ϊ�
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

        // �ϊ����ď�������
        pByte^ := History.Nodes[HistoryIndex].ColorIndex;
        Inc(pByte);
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    // ���F���ꂽ�V�����J���[�e�[�u�����Z�b�g����
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
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;

// TrueColor �� 4BitRGB �ɕϊ��B24Bit ���x
procedure ConvertTrueColorTo4BitRGBHigh(var OldDIBInfos: TNkDIBInfos;
                                        var NewDIBInfos: TNkDIBInfos;
                                        ProgressHandler: TNotifyEvent;
                                        UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 4Bit �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;      // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Colors: TRGBQuadArray;              // ���o���ꂽ�J���[�e�[�u���B
  ColorTriple: TNkTriple;             // �s�N�Z���l True Color -> 8 Bit �ϊ��p
  NumColors: LongInt;                 // ���o���ꂽ�F�̐�
  History: TCutHistory;               // ���F����
  HistoryIndex: Integer;              // ���F�����C���f�b�N�X
begin
  pBits := Nil;

  // ��DIB �� TrueColor ���`�F�b�N
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo4BitRGBHigh: ' +
          'Invalid Bitcount');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*4 + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    // ���F�J���[�i16�F�j�ƕ��������𓾂�B
    GetReducedColorsHigh(OldDIBInfos, NumColors, Colors,
                           History, 4, ProgressHandler);
    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
      // �F�̃C���f�b�N�X�l����������
      for x := 0 To Width -1 do begin

        // �s�N�Z���l�����o��
        ColorTriple := pSourceTriple^[x];

        // RGB -> Color Index �ϊ�
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

        // �ϊ����ď�������
        if (x mod 2) = 0 then
          pByte^ := (History.Nodes[HistoryIndex].ColorIndex shl 4) and $f0
        else begin
          pByte^ := pByte^ or (History.Nodes[HistoryIndex].ColorIndex and $0f);
          Inc(pByte);
        end;
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    // ���F���ꂽ�V�����J���[�e�[�u�����Z�b�g����
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
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;


//-------------------------------------------------------------------
// Note:
//
// 256 �F�r�b�g�}�b�v���� 16 �F�ւ̌��F�� CutCubes ���g��
// 256 �F�r�b�g�}�b�v�͐F��256�F�����Ȃ��̂ŁA�e�F�̃s�N�Z�����𐔂�
// �e�F����� Color Cube �ɂ܂Ƃ߂� CutCubes �ɓn���΂悢�B
// 

// 256�F �r�b�g�}�b�v���� �œK�����ꂽ16�F���F�J���[�𓾂�B
procedure GetReducedColorsFrom256(var DIBInfos:TNkDIBInfos;
                                  var NumColors: LongInt;
                                  var Colors: TRGBQuadArray;
                                  var ColorTransTable: TByteArray256;
                                  ProgressHandler: TNotifyEvent);
var
  i, j, 
  Width, Height,                // �r�b�g�}�b�v�̑傫��
  SourceLineLength,             // �X�L�������C���̒���
  NumCubes: LongInt;            // ���F���ꂽ�F�̐�
  pCubes: PColorCubeArray64k;   // Color Cube �ւ̃|�C���^
  pSourceByte: ^Byte;           // �r�b�g�}�b�v�f�[�^�ւ̃|�C���^
begin
  Width := DIBInfos.W3Head.biWidth;
  Height := abs(DIBInfos.W3Head.biHeight);
  SourceLineLength := ((Width*8 + 31) div 32) * 4;

  //�F�ϊ��e�[�u���̃��������m��
  pCubes := Nil;
  try
    // Color Cube Array �̃��������m��
    GetMem(pCubes,  SizeOf(TColorCube)*256);

    // Color Cube Array ��������
    FillChar(pCubes^, SizeOf(TColorCube)*256, 0);
    for i := 0 to 255 do begin
      pCubes^[i].Index := i; // Color Cube �̌��̈ʒu��������悤��
                             // Index ��t����B
      pCubes^[i].R := DIBInfos.W3HeadInfo.bmiColors[i].rgbRed;
      pCubes^[i].G := DIBInfos.W3HeadInfo.bmiColors[i].rgbGreen;
      pCubes^[i].B := DIBInfos.W3HeadInfo.bmiColors[i].rgbBlue;
    end;

    // Color Cube Array �Ƀs�N�Z������F�ʂɐώZ
    for i := 0 to Height-1 do begin

      // DIB �̃��C���̐擪�A�h���X���Z�o
      pSourceByte := AddOffset(DIBInfos.pBits, SourceLineLength * i);

      // ���C���ɑ΂���
      for j := 0 to Width-1 do begin
        Inc(pCubes^[pSourceByte^].n);
        Inc(pSourceByte);
      end;
    end;

    // �J���[�e�[�u�������B

    // �s�N�Z����1�ȏ�����Ă��� Color Cube ������I��
    NumCubes := 0;

    for i := 0 to 255 do
      if pCubes^[i].n <> 0 then begin
        pCubes^[NumCubes] := pCubes^[i];
        Inc(NumCubes);
      end;


    NumColors := 0; //���o�����F���������ݒ�
    // �F�𒊏o����
    CutCubes(0, NumCubes, 0, 4, pCubes^, Colors, NumColors, ProgressHandler);

    // �F�ϊ��e�[�u�������
    FillChar(ColorTransTable, SizeOf(TByteArray256), 0);
    for i := 0 to NumCubes-1 do
      ColorTransTable[pCubes^[i].Index] := pCubes^[i].n;

  finally
    // Color Cube Array ��j������B
    if pCubes <> Nil then FreeMem(pCubes,  SizeOf(TColorCube)*256);
  end;
end;


// 8BitRGB �� 4BitRGB �ɕϊ��B
procedure Convert8BitRGBTo4BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos;
                                  ProgressHandler: TNotifyEvent;
                                  UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 4Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte: ^Byte;                 // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Colors: TRGBQuadArray;              // ���o���ꂽ�J���[�e�[�u���B
  NumColors: LongInt;                 // ���o���ꂽ�F�̐�
  ColorTransTable: TByteArray256;     // �F�ϊ��e�[�u���B

begin
  pBits := Nil;

  // ��DIB �� TrueColor ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitRGBTo4BitRGB: ' +
          'Invalid Bitcount or Compression');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width*4 + 31) div 32) * 4;
  SourceLineLength := ((Width*8 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    // ���F�J���[�i16�F�j�ƐF�ϊ��e�[�u���𓾂�B
    GetReducedColorsFrom256(OldDIBInfos, NumColors, Colors, ColorTransTable,
                            ProgressHandler);

    // �����A�ϊ��J�n�I�I
    for y := 0 to Height -1 do begin
      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
      // �F�̃C���f�b�N�X�l����������
      for x := 0 To Width -1 do begin
         // �ϊ����ď�������
        if ( x mod 2 ) = 0 then
          pByte^ := (ColorTransTable[pSourceByte^] shl 4) and $f0
        else begin
          pByte^ := pByte^ or (ColorTransTable[pSourceByte^] and $0f);
          Inc(pByte);
        end;
        Inc(pSourceByte);
      end;
    end;

    // ������
    NewDIBInfos := OldDIBInfos;
    // ���F���ꂽ�V�����J���[�e�[�u�����Z�b�g����
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
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;
end;

// TrueColor �� 1Bit RGB �ɕϊ��B
procedure ConvertTrueColorTo1BitRGB(var OldDIBInfos: TNkDIBInfos;
                                    var NewDIBInfos: TNkDIBInfos;
                                    BGColor: TColor; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 1Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceTriple: PNkTripleArray;     // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  ColorTriple: TNkTriple;             // �s�N�Z���l True Color -> 1 Bit �ϊ��p
  Bits8: Byte;                        // �r�b�g����p
  R, G, B: Byte;                      // R, G, B �l
const Colors: array[0..1] of TRGBQuad =
  ((rgbBlue:   0; rgbGreen:   0; rgbRed:   0; rgbReserved: 0),
   (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0));
begin
  pBits := Nil;
  Bits8 := 0; // �R���p�C���̌x����ق点�邽��

  // ��DIB �� TrueColor ���`�F�b�N
  if OldDIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
          'ConvertTrueColorTo1BitRGB: ' +
          'Invalid Bitcount');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  R := GetRValue(BGColor);
  G := GetGValue(BGColor);
  B := GetBValue(BGColor);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width + 31) div 32) * 4;
  SourceLineLength := ((Width*24 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try
    for y := 0 to Height -1 do begin

      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceTriple := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
      // �F�̃C���f�b�N�X�l����������
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := $80; pByte^ := 0;
        end;

        // �s�N�Z���l�����o��
        ColorTriple := pSourceTriple^[x];
        if (ColorTriple.R = R) and (ColorTriple.G = G) and
           (ColorTriple.B = B) then
          pByte^ := pByte^ or Bits8;

        Bits8 := Bits8 shr 1;
        if (x mod 8) = 7 then Inc(pByte);
      end;
    end;


    // ������
    NewDIBInfos := OldDIBInfos;
    // �J���[�e�[�u�����Z�b�g����
    NewDIBInfos.W3Head.biClrUsed := 2;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0], SizeOf(Colors));
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 1;            // 1Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;

end;

// 8Bit RGB �� 1Bit RGB �ɕϊ��B
procedure Convert8BitRGBTo1BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos;
                                  BGColor: TColor; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 1Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte: PByteArray64k;         // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Bits8: Byte;                        // �r�b�g����p
  R, G, B: Byte;                      // R, G, B �l
  ColorQuad: TRGBQuad;                // �s�N�Z���l  -> 1 Bit �ϊ��p
const Colors: array[0..1] of TRGBQuad =
  ((rgbBlue:   0; rgbGreen:   0; rgbRed:   0; rgbReserved: 0),
   (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0));
begin
  pBits := Nil;
  Bits8 := 0; // �R���p�C���̌x����ق点�邽��

  // ��DIB �� TrueColor ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 8) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert8BitTo1BitRGB: ' +
          'Invalid Bitcount or Compression');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  R := GetRValue(BGColor);
  G := GetGValue(BGColor);
  B := GetBValue(BGColor);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width + 31) div 32) * 4;
  SourceLineLength := ((Width*8 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    for y := 0 to Height -1 do begin

      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
      // �F�̃C���f�b�N�X�l����������
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := $80; pByte^ := 0;
        end;

        // �s�N�Z���l�����o��
        ColorQuad := OldDIBInfos.W3HeadInfo.bmiColors[pSourceByte^[x]];
        if (ColorQuad.rgbRed = R) and (ColorQuad.rgbGreen = G) and
           (ColorQuad.rgbBlue = B) then
          pByte^ := pByte^ or Bits8;

        Bits8 := Bits8 shr 1;
        if (x mod 8) = 7 then Inc(pByte);
      end;
    end;


    // ������
    NewDIBInfos := OldDIBInfos;
    // �J���[�e�[�u�����Z�b�g����
    NewDIBInfos.W3Head.biClrUsed := 2;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0], SizeOf(Colors));
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 1;            // 1Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;

end;

// 4Bit RGB �� 1Bit RGB �ɕϊ��B
procedure Convert4BitRGBTo1BitRGB(var OldDIBInfos: TNkDIBInfos;
                                  var NewDIBInfos: TNkDIBInfos;
                                  BGColor: TColor; UseFMO: Boolean);
var
  x, y: Integer;                      // ���W
  LineLength,                         // 1Bit RGB �̃X�L�������C���̒���
  BitsSize,                           // �ϊ���̃r�b�g�}�b�v�f�[�^�̃T�C�Y
  Width, Height: Integer;             // �r�b�g�}�b�v�̑傫��
  SourceLineLength: Integer;          // �ϊ����̃X�L�������C���̒���
  hFile: THandle;                     // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
  pBits: Pointer;
  pSourceByte: PByteArray64k;         // �ϊ����f�[�^�ւ̃|�C���^
  pByte: ^Byte;                       // �ϊ���f�[�^�ւ̃|�C���^
  Bits8: Byte;                        // �r�b�g����p
  R, G, B: Byte;                      // R, G, B �l
  ColorQuad: TRGBQuad;                // �s�N�Z���l  -> 1 Bit �ϊ��p
  ColorIndex: Byte;                   // �F�̃C���f�b�N�X

const Colors: array[0..1] of TRGBQuad =
  ((rgbBlue:   0; rgbGreen:   0; rgbRed:   0; rgbReserved: 0),
   (rgbBlue: 255; rgbGreen: 255; rgbRed: 255; rgbReserved: 0));
begin
  pBits := Nil;
  Bits8 := 0; // �R���p�C���̌x����ق点�邽��

  // ��DIB �� TrueColor ���`�F�b�N
  if (OldDIBInfos.W3Head.biBitCount <> 4) or
     (OldDIBInfos.W3Head.biCompression <> BI_RGB) then
    raise ENkDIBBadDIBType.Create(
          'Convert4BitRGBTo1BitRGB: ' +
          'Invalid Bitcount');

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  R := GetRValue(BGColor);
  G := GetGValue(BGColor);
  B := GetBValue(BGColor);

  //�X�L�������C���̒������v�Z
  LineLength := ((Width + 31) div 32) * 4;
  SourceLineLength := ((Width*4 + 31) div 32) * 4;

  // Pixel �f�[�^�̑傫�����v�Z�B
  BitsSize   :=  LineLength * Height;

  // �s�N�Z�����p�������i�o�͐�j���m��
  GetMemory(BitsSize, hFile, pBits, UseFMO);
  try

    for y := 0 to Height -1 do begin

      // �V�^�� DIB �̃��C���̐擪�ւ̃|�C���^���쐬
      pByte := AddOffset(pBits, LineLength * y);
      pSourceByte := AddOffset(OldDIBInfos.pBits, SourceLineLength * y);

      // ���̃s�N�Z���l�����o�� �ϊ��e�[�u����������
      // �F�̃C���f�b�N�X�l����������
      for x := 0 To Width -1 do begin
        if (x mod 8) = 0 then begin
          Bits8 := $80; pByte^ := 0;
        end;

        // �s�N�Z���l�����o��
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


    // ������
    NewDIBInfos := OldDIBInfos;
    // �J���[�e�[�u�����Z�b�g����
    NewDIBInfos.W3Head.biClrUsed := 2;
    System.Move(Colors, NewDIBInfos.W3HeadInfo.bmiColors[0], SizeOf(Colors));
    NewDIBInfos.BitsSize := BitsSize;
    NewDIBInfos.hFile := hFile;
    NewDIBInfos.pBits := pBits;
    NewDIBInfos.W3Head.biBitCount := 1;            // 1Bit RGB
    NewDIBInfos.W3Head.biCompression := BI_RGB;
    NewDIBInfos.W3Head.biSizeImage := 0;
  except
    if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �V DIB ���̂Ă�B
    raise;
  end;

end;

// DIB ���n�[�t�g�[����
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

    pErrors: PErrorArray;            // �������̃X�L�������C���̐F�̌덷
    pPrevLineErrors: PErrorArray;    // ��O�̃X�L�������C���̐F�̌덷
    BitsSize: Integer;               // �ϊ���s�N�Z���f�[�^�̑傫��
    LineLength: Integer;             // �ϊ���X�L�������C���̒���
    SourceLineLength: Integer;       // �ϊ����X�L�������C���̒���
    hFile: THandle;                  // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
    pBits: Pointer;
    RIndex, GIndex, BIndex: Integer; // ���F��̊e�F�̃C���f�b�N�X�l
                                     // RedColors, GreenColors, BlueColors
                                     // �z��̃C���f�b�N�X�l����\�킷
    RValue, GValue, BValue: Integer; // �s�N�Z���� RGB �l
    RErr, GErr, BErr: Integer;       // �F�덷
    OldRErr, OldGErr, OldBErr: Integer; // ��O�̐F�덷
    ColorIndex: LongInt;             // �J���[�C���f�b�N�X(1, 4, 8 bpp DIB �p)
    pLine: PNkTripleArray;           // �s�N�Z���|�C���^ (24 bpp �p)
    pByte: ^Byte;                    // �s�N�Z���|�C���^(1,4,8 bpp �p)
    pDest: ^Byte;                    // �s�N�Z���|�C���^(�ϊ���)
    Mask: Byte;                      // �r�b�g�}�X�N(1 bpp �p)

    // ���F�e�[�u��  RGB �l�� RedColors, GreenColors, BlueColors �ɕϊ�����B
    RTrans, GTrans, BTrans: array[-256..512] of Byte;
const Bits8: BYTE = $80;             // Mask �̏����l
begin
  Assert(OldDIBInfos.W3Head.biCompression = BI_RGB,
           'ConvertToHalfTone: Invalid DIB Format');


  // ���F�e�[�u��������������B
  // ��
  FillChar(RTrans[-256], 256 + 26, 0);
  FillChar(RTrans[26], 51, 1);
  FillChar(RTrans[77], 51, 2);
  FillChar(RTrans[128], 51, 3);
  FillChar(RTrans[179], 52, 4);
  FillChar(RTrans[231], 25 + 257, 5);

  // ��
  FillChar(GTrans[-256], 256 + 22, 0);
  FillChar(GTrans[22], 42, 1);
  FillChar(GTrans[64], 43, 2);
  FillChar(GTrans[107], 43, 3);
  FillChar(GTrans[150], 43, 4);
  FillChar(GTrans[193], 41, 5);
  FillChar(GTrans[234], 22 + 257, 6);

  // ��
  FillChar(BTrans[-256], 256 + 32, 0);
  FillChar(BTrans[32], 64, 1);
  FillChar(BTrans[96], 64, 2);
  FillChar(BTrans[160], 64, 3);
  FillChar(BTrans[224], 32 + 257, 4);

  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  pErrors := Nil;
  pPrevLineErrors := Nil;
  pBits := Nil;

  RValue := 0; GValue := 0; BValue := 0; // �R���p�C����ق点�邽��

  try
    // �덷�g�U�p�̌덷�i�[�p�o�b�t�@��������
    GetMem(pErrors, SizeOf(TErrorElement) * (Width+2));
    GetMem(pPrevLineErrors, SizeOf(TErrorElement) * (Width+2));
    FillChar(pErrors^, SizeOf(TErrorElement) * (Width+2), 0);

    // �ϊ����A�ϊ���̃X�L�������C���̒������v�Z
    LineLength := ((Width * 8 + 31) div 32) * 4;

    SourceLinelength := ((Width * OldDIBInfos.W3head.biBitCount + 31)
                         div 32) * 4;

    // �ϊ���(8 bpp DIB) �̃s�N�Z���f�[�^�i�[�̈���m��
    BitsSize := Linelength * Height;
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      // �ϊ��J�n
      for y := 0 to Height-1 do begin    // �e�X�L�������C������
        // ���X�L�������C���̐F�덷�o�b�t�@��O�X�L�������C����
        // �F�덷�o�b�t�@�փR�s�[
        Move(pErrors^, pPrevLineErrors^, SizeOf(TErrorElement)*(Width+2));


        /////////////////////
        // Note:
        //
        // �덷�g�U�̓X�L�������C�����Ɍ덷�̓`�d�����t�]������
        // ��������Ɖ掿��������悤��(^^

        // �s�N�Z���̃X�L�����J�n�ʒu���Z�b�g
        // �����s -> ������A��s ->�E����

        if (y mod 2) = 0 then begin
          x := 0; pDest := AddOffset(pBits, LineLength * y);
        end
        else begin
          x := Width-1; pDest := AddOffset(pBits, LineLength * y + Width -1);
        end;

        // 1�s�N�Z���O�̐F�덷���N���A
        OldRErr := 0; OldGErr := 0; OldBErr := 0;

        // �s�N�Z���� RGB �l�����o��
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
              // 8Bit �񈳏k
              pByte := AddOffset(pBits, SourceLineLength * y + x);
              ColorIndex := pByte^;  // �J���[�e�[�u���̃C���f�b�N�X��Ԃ�
            end
            else if W3Head.biBitCount = 4 then begin
              pByte := AddOffset(pBits, SourceLineLength * y + x div 2);
              // �C���f�b�N�X�l��ǂ�
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
         // �F�덷�͈ȉ��̗l�Ɍv�Z���Ă���(������X�L��������ꍇ)
         //
         //
         //  +--------+--------+
         //  |  (1)   |  (2)   |
         //  | �덷x5 | �덷x12|
         //  |--------| -------|    <-- �O�̃X�L�������C��
         //  |   32   |    32  |
         //  +--------+--------+
         //  |  (3)   |        |
         //  | �덷x12|   ��   |
         //  |--------|�s�N�Z��|    <-- ���݂̃X�L�������C��
         //  |   32   |        |
         //  +--------+--------+
         //
         //  ���s�N�Z���̐F�̕␳�l = -(1) - (2) - (3)


         // ���s�N�Z���́u��v�̃s�N�Z���̐F�덷���덷�ɉ�����
         with pPrevLineErrors^[x] do begin
           RErr := RError*12;
           GErr := GError*12;
           BErr := BError*12;
         end;

         // ���s�N�Z���́u��O�v�̃s�N�Z���̐F�덷��������
         Inc(RErr, OldRErr*12);
         Inc(GErr, OldGErr*12);
         Inc(BErr, OldBErr*12);

         // ���s�N�Z���́u��O�v�̃s�N�Z���́u��v�̃s�N�Z���̐F�덷��������B
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

         // �덷��ł����������Ɍ��s�N�Z���� RGB �l��␳����
         Dec(RValue, RErr); Dec(GValue, GErr); Dec(BValue, BErr);


         // 210 �F�Ɍ��F����B
         RIndex := RTrans[RValue];
         GIndex := GTrans[GValue];
         BIndex := BTrans[BValue];

         with pErrors^[x] do begin
           RError := RedColors  [RIndex] - RValue;
           GError := GreenColors[GIndex] - GValue;
           BError := BlueColors [BIndex] - BValue;
           // ���s�N�Z���̐F�덷���Z�o����B
           OldRErr := RError; OldGErr := GError; OldBErr := BError;
         end;

         // ���F��̐F�i�C���f�b�N�X�j��ϊ���ɏ�������
         pDest^ := RIndex * 7 * 5 + GIndex * 5 + BIndex;

         // ���s�N�Z����1��ɐi�߂�
         if (y and 1) = 0 then begin Inc(x); Inc(pDest); end
         else                  begin Dec(x); Dec(pDest); end;
        end;
      end;

      // �d�グ
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biClrUsed := 215;
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 8;            // 8Bit RGB
      NewDIBInfos.W3Head.biCompression := BI_RGB;
      NewDIBInfos.W3Head.biSizeImage := 0;

      // �J���[�e�[�u���� �Œ� 215 �F����������
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
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �VDIB���̂Ă�B
      raise;
    end;

  finally
    // �덷�ێ��p�o�b�t�@�̉��
    if pErrors <> Nil then FreeMem(pErrors);

    if pPrevLineErrors <> Nil then FreeMem(pPrevLineErrors);
  end;
end;

// DIB ��2�l�Ƀn�[�t�g�[����
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

    pErrors: PErrorArray;            // �������̃X�L�������C���̐F�̌덷
    pPrevLineErrors: PErrorArray;    // ��O�̃X�L�������C���̐F�̌덷
    BitsSize: Integer;               // �ϊ���s�N�Z���f�[�^�̑傫��
    LineLength: Integer;             // �ϊ���X�L�������C���̒���
    SourceLineLength: Integer;       // �ϊ����X�L�������C���̒���
    hFile: THandle;                  // �ϊ���̃r�b�g�}�b�v�f�[�^�o�b�t�@
    pBits: Pointer;
                                     // �z��̃C���f�b�N�X�l����\�킷
    RValue, GValue, BValue: Integer; // �s�N�Z���� RGB �l
    RErr, GErr, BErr: Integer;       // �F�덷
    OldRErr, OldGErr, OldBErr: Integer; // ��O�̐F�덷
    ColorIndex: LongInt;             // �J���[�C���f�b�N�X(1, 4, 8 bpp DIB �p)
    pLine: PNkTripleArray;           // �s�N�Z���|�C���^ (24 bpp �p)
    pByte: ^Byte;                    // �s�N�Z���|�C���^(1,4,8 bpp �p)
    pDest: ^Byte;                    // �s�N�Z���|�C���^(�ϊ���)
    Mask: Byte;                      // �r�b�g�}�X�N(1 bpp �p)
    BWValue: Integer;                // �����l

const Bits8: BYTE = $80;             // Mask �̏����l

begin
  Assert(OldDIBInfos.W3Head.biCompression = BI_RGB,
           'ConvertToHalfToneBW: Invalid DIB Format');


  // �������̂��� Width �� Height ��ϐ��ɓ����B
  Width := OldDIBInfos.W3Head.biWidth;
  Height := abs(OldDIBInfos.W3Head.biHeight);

  pErrors := Nil;
  pPrevLineErrors := Nil;
  pBits := Nil;
  RValue := 0; GValue := 0; BValue := 0; // �R���p�C����ق点�邽��

  try
    // �덷�g�U�p�̌덷�i�[�p�o�b�t�@��������
    GetMem(pErrors, SizeOf(TErrorElement) * (Width+2));
    GetMem(pPrevLineErrors, SizeOf(TErrorElement) * (Width+2));
    FillChar(pErrors^, SizeOf(TErrorElement) * (Width+2), 0);

    // �ϊ����A�ϊ���̃X�L�������C���̒������v�Z
    LineLength := ((Width * 1 + 31) div 32) * 4;

    SourceLinelength := ((Width * OldDIBInfos.W3head.biBitCount + 31)
                         div 32) * 4;

    // �ϊ���(1 bpp DIB) �̃s�N�Z���f�[�^�i�[�̈���m��
    BitsSize := Linelength * Height;
    GetMemory(BitsSize, hFile, pBits, UseFMO);
    try
      // �ϊ��J�n
      for y := 0 to Height-1 do begin    // �e�X�L�������C������
        // ���X�L�������C���̐F�덷�o�b�t�@��O�X�L�������C����
        // �F�덷�o�b�t�@�փR�s�[
        Move(pErrors^, pPrevLineErrors^, SizeOf(TErrorElement)*(Width+2));


        /////////////////////
        // Note:
        //
        // �덷�g�U�̓X�L�������C�����Ɍ덷�̓`�d�����t�]������
        // ��������Ɖ掿��������悤��(^^

        // �s�N�Z���̃X�L�����J�n�ʒu���Z�b�g
        // �����s -> ������A��s ->�E����

        if (y mod 2) = 0 then begin
          x := 0; pDest := AddOffset(pBits, LineLength * y);
        end
        else begin
          x := Width-1;
          pDest := AddOffset(pBits, LineLength * y + (Width -1) div 8);
        end;

        // 1�s�N�Z���O�̐F�덷���N���A
        OldRErr := 0; OldGErr := 0; OldBErr := 0;

        // �s�N�Z���� RGB �l�����o��
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
              // 8Bit �񈳏k
              pByte := AddOffset(pBits, SourceLineLength * y + x);
              ColorIndex := pByte^;  // �J���[�e�[�u���̃C���f�b�N�X��Ԃ�
            end
            else if W3Head.biBitCount = 4 then begin
              pByte := AddOffset(pBits, SourceLineLength * y + x div 2);
              // �C���f�b�N�X�l��ǂ�
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
         // �F�덷�͈ȉ��̗l�Ɍv�Z���Ă���(������X�L��������ꍇ)
         //
         //
         //  +--------+--------+
         //  |  (1)   |  (2)   |
         //  | �덷x5 | �덷x12|
         //  |--------| -------|    <-- �O�̃X�L�������C��
         //  |   32   |    32  |
         //  +--------+--------+
         //  |  (3)   |        |
         //  | �덷x12|   ��   |
         //  |--------|�s�N�Z��|    <-- ���݂̃X�L�������C��
         //  |   32   |        |
         //  +--------+--------+
         //
         //  ���s�N�Z���̐F�̕␳�l = -(1) - (2) - (3)


         // ���s�N�Z���́u��v�̃s�N�Z���̐F�덷���덷�ɉ�����
         with pPrevLineErrors^[x] do begin
           RErr := RError*12;
           GErr := GError*12;
           BErr := BError*12;
         end;

         // ���s�N�Z���́u��O�v�̃s�N�Z���̐F�덷��������
         Inc(RErr, OldRErr*12);
         Inc(GErr, OldGErr*12);
         Inc(BErr, OldBErr*12);

         // ���s�N�Z���́u��O�v�̃s�N�Z���́u��v�̃s�N�Z���̐F�덷��������B
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

         // �덷��ł����������Ɍ��s�N�Z���� RGB �l��␳����
         Dec(RValue, RErr); Dec(GValue, GErr); Dec(BValue, BErr);


         // 2 �F�Ɍ��F����B
         if RValue + GValue + BValue >= 384 then BWValue := 1
                                            else BWValue := 0;
         with pErrors^[x] do begin
           // ���s�N�Z���̐F�덷���Z�o����B
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

         // ���F��̐F�i�C���f�b�N�X�j��ϊ���ɏ�������
         Mask := Bits8 shr (x mod 8);
         if BWValue = 1 then
           pDest^ := pDest^ or Mask
         else
           pDest^ := pdest^ and not Mask;

         // ���s�N�Z����1��ɐi�߂�
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

      // �d�グ
      NewDIBInfos := OldDIBInfos;
      NewDIBInfos.W3Head.biClrUsed := 2;
      NewDIBInfos.BitsSize := BitsSize;
      NewDIBInfos.hFile := hFile;
      NewDIBInfos.pBits := pBits;
      NewDIBInfos.W3Head.biBitCount := 1;            // 8Bit RGB
      NewDIBInfos.W3Head.biCompression := BI_RGB;
      NewDIBInfos.W3Head.biSizeImage := 0;

      // �J���[�e�[�u���� �Œ� 2 �F����������
      for i := 0 to 1 do
        NewDIBInfos.W3HeadInfo.bmiColors[i] := BWColors[i];
    except
      if pBits <> Nil then ReleaseMemory(hFile, pBits, UseFMO);// ���s �VDIB���̂Ă�B
      raise;
    end;

  finally
    // �덷�ێ��p�o�b�t�@�̉��
    if pErrors <> Nil then FreeMem(pErrors);
    if pPrevLineErrors <> Nil then FreeMem(pPrevLineErrors);
  end;
end;






// True Color �p Palette �쐬
procedure TNkInternalDIB.CreateTrueColorPalette(ConvertMode: TNkConvertMode;
                                                ProgressHandler: TNotifyEvent);
var
  NumColors: LongInt;                // �I�΂ꂽ�F�̐�
  Colors: TRGBQuadArray;             // �I�΂ꂽ�F �ő�256�F
  History: TCutHistory;              // �F��������
  pColorTransTable: ^TByteArray64k3D; // �_�~�[

begin
  // True Color �݂̂��Ώ�
  if DIBInfos.W3Head.biBitCount <> 24 then
    raise ENkDIBBadDIBType.Create(
      'TNkInternalDIB.CreateTrueColorPalette: Bad DIB Type');

  // ���F�J���[�e�[�u���𓾂�B
  case ConvertMode of
    nkCmFine: GetReducedColorsHigh(DIBInfos, NumColors, Colors, History, 8,
                                   ProgressHandler);
    nkCmNormal: begin
      GetMem(pColorTransTable,  SizeOf(TByteArray64k3D)); //�_�~�[
      try
        GetReducedColorsLow(DIBInfos, NumColors, Colors,
                            pColorTransTable^, 8, ProgressHandler);
      finally
        FreeMem(pColorTransTable,  SizeOf(TByteArray64k3D)); //�_�~�[
      end;
    end;
  end;

  DIBInfos.W3Head.biClrUsed := NumColors;
  System.Move(Colors, DIBInfos.W3HeadInfo.bmiColors[0],
                Sizeof(TRGBQuad) * NumColors);
  // ���p���b�g��p��
  UpdatePalette;
end;

// PixelFormat ���擾����B

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




// Pixel Format �̕ύX(DIB �̌`���ϊ�)
// ���̃��[�`���͑傫��������Ă��邱�Ƃ͂قƂ�ǎ���
// ��O���������Ƃ��Ɍ�߂肷��悤�ɂȂ��Ă��邱�Ƃɒ���
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


// �R���X�g���N�^
constructor TNkDIB.Create;
begin
  inherited Create;
  // Internal DIB �����
  InternalDIB := TNkInternalDIB.Create(DefaultUseFMO);
  UpdatePaletteModified;
  FConvertMode := nkCmNormal;      // �f�t�H���g�̕ϊ����[�h�̓m�[�}��
  FBGColor := clWhite;             // �f�t�H���g�̔w�i�F�͔�
  FHalftoneMode := nkHtNoHalftone; // �n�[�t�g�[�������B
end;

destructor TNkDIB.Destroy;
begin
  // Internal DIB �Ƃ̌��т���ؒf
  ReleaseInternalDIB;
  inherited Destroy;
end;

// DIB �Ƃ̌��т���ؒf
procedure TNkDIB.ReleaseInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNKDIB.ReleaseInternalDIB: InternalDIB should not be Nil');

  // �Q�ƃJ�E���g�f�N�������g
  Dec(InternalDIB.RefCount);
  // �Q�ƃJ�E���g�� �O �Ȃ� Internal DIB ���폜
  if InternalDIB.RefCount = 0 then InternalDIB.Free;

  InternalDIB := Nil;
end;


// �X�g���[������ DIB(�t�@�C���w�b�_�t��) ��ǂݍ���
procedure TNkDIB.LoadFromStream(Stream: TStream);
var temp: TNkInternalDIB;
begin
  // Internal DIB ��؂藣���A�V���� Internal DIB ���m��
  temp := TNkInternalDIB.Create(UseFMO);
  try
    temp.LoadFromStream(Stream);
  except
    temp.Free;
    raise;
  end;
  // �Â� Internal DIB ��؂藣��
  ReleaseInternalDIB;

  // �V���� Internal DIB ���Z�b�g����B
  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;

// �X�g���[���� DIB(�t�@�C���w�b�_�t��) �������o��
procedure TNkDIB.SaveToStream(Stream: TStream);
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SaveToStream: InternalDIB Should not be Nil');

  InternalDIB.SaveToStream(Stream);
end;

procedure TNkDIB.Draw(ACanvas: TCanvas; const R: TRect);
var SavedPalette: HPALETTE;      // ���p���b�g
    OldMode: Integer;            // ���X�g���b�`���[�h
    PaletteSelected: Boolean;    // �p���b�g���I������Ă��邩��\��
    HalftoneDIB: TNkDIB;         // �n�[�t�g�[�����p DIB
    HalftoneCanvas: TNkDIBCanvas;// �n�[�t�g�[�����p�L�����o�X
    HalftoneModeSave: TNkHalftoneMode;
begin
  SavedPalette := 0; // �R���p�C����ق点�邽��
  
  if InternalDIB <> Nil then begin
    case FHalftoneMode of
      nkHtNoHalftone: begin
        // DIB �̃p���b�g�� BG ���̉�
        PaletteSelected := False;
        if Palette <> 0 then begin
          SavedPalette := SelectPalette(ACanvas.Handle, Palette, True);
          RealizePalette(ACanvas.Handle);
          PaletteSelected := True;
        end;
        // �X�g���b�`���[�h�̓J���[ �I�� �J���[
        OldMode := SetStretchBltMode(ACanvas.Handle, COLORONCOLOR);
        // �`��
        StretchDIBits(ACanvas.Handle, R.Left, R.Top,
                      R.Right - R.Left, R.Bottom - R.Top,
                      0, 0, InternalDIB.Width, InternalDIB.Height,
                      InternalDIB.DIBInfos.pBits,
                      InternalDIB.DIBInfos.W3HeadInfo,
                      DIB_RGB_COLORS, ACanvas.CopyMode);
        // �X�g���b�`���[�h�����ɖ߂�
        SetStretchBltMode(ACanvas.Handle, OldMode);
        // �p���b�g�����ɖ߂�
        if PaletteSelected then
          SelectPalette(ACanvas.Handle, SavedPalette, True);
      end;
      nkHtHalftone, nkHtHalftoneBW: begin
        // �\���̈�ɖʐς������ꍇ�͉����`���Ȃ�
        if (R.Right = R.Left) or (R.Top = R.Bottom) then Exit;
        HalftoneDIB := TNkDIB.Create;
        try
          // DIB ���R�s�[���邽�� �ꎞ�I�Ƀn�[�t�g�[�����[�h������
          HalfToneModeSave := FHalfToneMode;
          FHalfToneMode := nkHtNoHalfTone;
          try
            // DIB ��\���̈�̑傫���ɂ��킹�Ċg��k�����ăR�s�[
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

          // �R�s�[���� DIB ���n�[�t�g�[��������
          case FHalftoneMode of
            nkHtHalftone:   HalftoneDIB.PixelFormat := nkPfHalftone;
            nkHtHalftoneBW: HalftoneDIB.PixelFormat := nkPfHalftoneBW;
          end;

          // �\������
          HalftoneDIB.Draw(ACanvas, R);
        finally
          HalftoneDIB.Free;
        end;
      end;
    end;
  end;
end;

// Assign �̎���
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
    // Internal DIB �𗣂��A�f�t�H���g�� DIB �����B
    temp := TNkInternalDIB.Create(UseFMO);
    ReleaseInternalDIB;
    InternalDIB := temp;
    UpdatePaletteModified;
    Modified := True;
  end
  else if Source is TNKDIB then begin
    if Self <> Source then begin
      ReleaseInternalDIB; // ������ Internal DIB �͐؂藣���B
      // Source �� Internal DIB �����L����B
      Inc((Source as TNkDIB).InternalDIB.RefCount);
      InternalDIB := (Source as TNkDIB).InternalDIB;

      // TNkDIB ������ Property �l�� �R�s�[
      FBGColor     := (Source as TNkDIB).FBGColor;
      FConvertMode := (Source as TNkDIB).FConvertMode;
      FHalftoneMode := (Source as TNkDIB).FHalftoneMode;

      // ���L�Ō�������V���� DIB ���o�����̂�����
      // PaletteModified �� True ���悢���낤�D�D�D
      PaletteModified := True;
      Modified := True;
    end
    else  // Source is Self
      Exit;
  end
  else if Source is TBitmap then begin
    // DDB �̃p�����[�^�𓾂�
    GetObject((Source as TBitmap).Handle, SizeOf(bm), @bm);

    // ��芸���� �f�t�H���g�� DIB �����
    temp := TnkInternalDIB.Create(UseFMO);
    try
      // DIB �� DDB �̃p�����[�^�����ɍ�蒼��
      temp.FreeDIB;
      BitCount := BM.bmBitsPixel * BM.bmPlanes;
      if BitCount in [16, 32] then BitCount := 24;
      temp.CreateDIB(bm.bmWidth, bm.bmHeight, BitCount, 0);

      // DDB �� DIB �փR�s�[����B
      h := GetDC(0);
      OldPal := SelectPalette(h, (Source as TBitmap).Palette, True);
      RealizePalette(h);
      GetDIBits(h, (Source as TBitmap).Handle, 0, temp.Height,
                temp.DIBInfos.pBits, temp.DIBInfos.W3HeadInfo, DIB_RGB_COLORS);
      if OldPal <> 0 then
        SelectPalette(h, OldPal, True);

      ReleaseDC(0, h);

      // �J���[�e�[�u���T�C�Y��␳����B
      if temp.DIBInfos.W3Head.biClrUsed = 0 then
        temp.DIBInfos.W3Head.biClrUsed :=
          GetNumColors(temp.DIBInfos.W3Head.biBitCount);

      // XPelsPerMeter/YPelsPerMeter ��␳����
      if temp.DIBInfos.W3head.biXPelsPerMeter = 0 then
         temp.DIBInfos.W3head.biXPelsPerMeter := 3780;
      if temp.DIBInfos.W3head.biYPelsPerMeter = 0 then
         temp.DIBInfos.W3head.biYPelsPerMeter := 3780;

      // �Â� DIB ��؂藣��
      ReleaseInternalDIB;

      // �V���� DIB �ɂ���
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

// AssignTo �̎���
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

    // �p���b�g���R�s�[���邽�߃n�[�t�g�[�����[�h������
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



// ClipBoard ���� DIB(CF_DIB) ���擾
procedure TNkDIB.LoadFromClipboardFormat(AFormat: Word;
                                         AData: THandle;
                                         APalette: HPALETTE);
var temp: TNkInternalDIB;
begin
  // �f�[�^�`���̃`�F�b�N
  if (AFormat <> CF_DIB) or (AData = 0) then
    raise EInvalidGraphic.Create(
      'TNkDIB.LoadFromClipboardFormat: Invalid Clipboard Format or No Data');

  // DIB ��؂藣���A�V���� DIB �����B
  temp := TNkInternalDIB.Create(UseFMO);
  try
    // DIB �� ClipBoard ����ǂݍ��ށB
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

// ClipBoard �� DIB(CF_DIB) ���Z�b�g����
procedure TNkDIB.SaveToClipboardFormat(var Format: Word;
                                       var Data: THandle;
                                       var APalette: HPALETTE);
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SaveToClipboardFormat: InternalDIB Should not be Nil');

  Format := CF_DIB;                        // �N���b�v�{�[�h�`�����Z�b�g
  APalette := 0;                           // �p���b�g����
  InternalDIB.SaveToClipBoardFormat(Data); // �N���b�v�{�[�h��
end;



function TNkDIB.GetEmpty: Boolean;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetEmpty: InternalDIB Should not be Nil');
  Result := False;  // ��̏�Ԃ͖����I�I
end;

// DIB �̍���
function TNkDIB.GetHeight: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetHeight: InternalDIB Should not be Nil');

  Result := InternalDIB.Height;
end;

// DIB �̕�
function TNkDIB.GetWidth: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetWidth: InternalDIB Should not be Nil');

  Result := InternalDIB.Width;
end;


//-------------------------------------------------------------------
// Note:
//
// TNkDIB �� Width/Height/BitCount Property �̕ύX�͐V���� DIB �����
// ����� DIB �͏�ɔ񈳏k�`���B���� BitCount property �̖����͏d�v��
// PixelFormat �͊����̉摜���u�ϊ��v����̂ɑ΂� BitCount �͖��n�� DIB ��
// ���̂� BitCount �̕ύX�̂ق����͂邩�ɑ����BTNkDIB ���g���n�߂�Ƃ���
// �K�� BitCount �ŐF�����w�肷�邱�ƁB�Ȃ��A���̎� �J���[�e�[�u����������
// �����̂Œ��ӁI�I


// ���̕ύX  �V���� DIB �����
procedure TNkDIB.SetWidth(Value: Integer);
var temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetWidth: InternalDIB Should not be Nil');

  if Value <= 0 then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkDIB.SetWidth: Invalid Width');

  if Value = InternalDIB.Width then Exit;

  // �V���� Internal DIB �����
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
  // �Â� Internal DIB ��؂藣��
  ReleaseInternalDIB;

  // �V���� Internal DIB ���Z�b�g����B
  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;


// �����̕ύX �V���� DIB �����
procedure TNkDIB.SetHeight(Value: Integer);
var temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetWidth: InternalDIB Should not be Nil');

  if Value = 0 then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkDIB.SetWidth: Invalid Height');

  // �V���� Internal DIB �����
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

  // �Â� Internal DIB ��؂藣��
  ReleaseInternalDIB;

  // �V���� Internal DIB ���Z�b�g����B
  InternalDIB := temp;
  UpdatePaletteModified;
  Modified := True;
end;


// BitCount �̕ύX  �V���� DIB �����
procedure TNkDIB.SetBitCount(Value: Integer);
var temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetBitCount: InternalDIB Should not be Nil');

  if not (Value in [1, 4, 8, 24]) then
    raise ENkDIBInvalidDIBPara.Create(
      'TNkDIB.SetBitCount: Invalid BitCount');

  if Value = InternalDIB.DIBInfos.W3Head.biBitCount then Exit;

  // �V���� Internal DIB �����
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

  // �Â� Internal DIB ��؂藣��
  ReleaseInternalDIB;
  InternalDIB := temp;
  // �V���� Internal DIB ���Z�b�g����B
  UpdatePaletteModified;
  Modified := True;
end;



// Palette Peroperty �̃w���p
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
      // �p�����[�^�u���b�N�����
      PalSize := SizeOf(TLogPalette) + ((215 - 1) * SizeOf(TPaletteEntry));
      GetMem(pPal, PalSize);
      try
        pPal^.palNumEntries := 215;  // �F��
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

        // ���I�I
        Result := CreatePalette(pPal^);

        if Result = 0 then raise EOutOfResources.Create(
          'TNkDIB.GetPalette: Cannot Make Palette(1)');

        PaletteHalftone := Result;

      finally
        // �p�����[�^�u���b�N�̔j��
        if pPal <> Nil then FreeMem(pPal, PalSize);
      end;
    end;
  end
  else if HalftoneMode = nkHtHalftoneBW then begin
    if PaletteBlackWhite <> 0 then
      Result := PaletteBlackWhite
    else begin
      // �p�����[�^�u���b�N�����
      PalSize := SizeOf(TLogPalette) + ((2 - 1) * SizeOf(TPaletteEntry));
      GetMem(pPal, PalSize);
      try
        pPal^.palNumEntries := 2;  // �F��
        pPal^.palVersion := $300;


      for i := 0 to 1 do
        with pPal.palPalEntry[i] do begin
          peRed       := BWColors[i].rgbRed;
          peGreen     := BWColors[i].rgbGreen;
          peBlue      := BWColors[i].rgbBlue;
          peFlags     := 0;
        end;

        // ���I�I
        Result := CreatePalette(pPal^);

        if Result = 0 then raise EOutOfResources.Create(
          'TNkDIB.GetPalette: Cannot Make Palette(1)');

        PaletteBlackWhite := Result;

      finally
        // �p�����[�^�u���b�N�̔j��
        if pPal <> Nil then FreeMem(pPal, PalSize);
      end;
    end;
  end
  else begin
    // Palette = 0 �� �F���� 0 �łȂ��Ȃ� �p���b�g�����
    if (InternalDIB.Palette = 0) then
      if InternalDIB.DIBInfos.W3Head.biClrUsed <> 0 then
        InternalDIB.Palette := InternalDIB.MakePalette;
       Result := InternalDIB.Palette;
  end;
end;


//-------------------------------------------------------------------
// Note
//
// �p���b�g�̓J���[�e�[�u���ɕϊ�����ݒ肳���B
// PaletteSize Property �� Colors Property ���ω�����B
// �p���b�g�n���h���� TNkDIB �̊Ǘ����ɓ���̂ŁA�p���b�g���Z�b�g��������
// �p���b�g�n���h����j�����Ă͂Ȃ�Ȃ��B

// �p���b�g��ݒ肷��
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


// PaletteSize Property �̃w���p
function TNkDIB.GetPaletteSize: Integer;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetPalette: InternalDIB Should not be Nil');

  // biClrUsed �� �O �ł��邱�Ƃ����邪�A InternalDIB ���ł�
  // �␳���ėL��̂Ŗ�薳��
  Result := InternalDIB.DIBInfos.W3Head.biClrUsed
end;

procedure TNkDIB.SetPaletteSize(value: Integer); // �p���b�g�T�C�Y�̐ݒ�
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetPaletteSize: InternalDIB Should not be Nil');

  // True Color �Ȃ�p���b�g�͖����Ă��悢
  if (InternalDIB.DIBInfos.W3Head.biBitCount = 24) and
     ((Value < 0) or (Value > 256)) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.SetPaletteSize: Palette Index is Out of Range 1');

  // 8/4 �r�b�g�Ȃ�A1�F�͖����ƍ���B
  if (InternalDIB.DIBInfos.W3Head.biBitCount <> 24) and
     ((Value < 1) or (Value > 256)) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.SetPaletteSize: Palette Index is Out of Range 2');

  if InternalDIB.DIBInfos.W3Head.biClrUsed <> Value then begin
    UniqueDIB;  // Internal DIB �̋��L���~�߂�
    InternalDIB.DIBInfos.W3Head.biClrUsed := Value;
    InternalDIB.DIBInfos.W3Head.biClrImportant := 0;  // �O�̂���
    InternalDIB.UpdatePalette;                        // ���p���b�g���̂Ă�
    UpdatePaletteModified;
    Modified := True;
  end;
end;

// ClipboardFormat Property �̃w���p    ��� CF_DIB ��Ԃ��B
function TNkDIB.GetClipboardFormat: UINT;
begin Result := CF_DIB; end;

// BitCount Peoprty �̃w���p
function TNkDIB.GetBitCount: Integer;    // BitCount �̎擾
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetBitCount: InternalDIB Should not be Nil');

  Result := InternalDIB.DIBInfos.W3Head.biBitCount;
end;

// Colors Property �̃w���p
// Colors Property �̎擾
function TNkDIB.GetColors(Index: Integer): TColor;
var Color: TRGBQuad;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetColors: InternalDIB Should not be Nil');

  if (Index < 0) or (Index > 255) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.GetColors: Palette Index is Out of Range');

  // �J���[�e�[�u���̃G���g���l���擾
  Color := InternalDIB.DIBInfos.W3HeadInfo.bmiColors[Index];
  // TRGBQuad �^���� TColor �^�ɕϊ�
  Result := RGB(Color.rgbRed, Color.rgbGreen, Color.rgbBlue);
end;

// Colors Property �̐ݒ�
procedure TNkDIB.SetColors(Index: Integer; Value: TColor);
var Color: TRGBQuad;
    RGB: LongInt;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetColors: InternalDIB Should not be Nil');

  if (Index < 0) or (Index > 255) then
    raise ENkDIBPaletteIndexRange.Create(
      'TNkDIB.GetColors: Palette Index is Out of Range');

  // �V�����p���b�g����邽�߁A���L���~�߂�
  UniqueDIB;

  // TColor �� TRGBQuad �ɕϊ�
  RGB := ColorToRGB(Value);
  Color.rgbRed   := GetRValue(RGB);
  Color.rgbGreen := GetGValue(RGB);
  Color.rgbBlue  := GetBValue(RGB);
  Color.rgbReserved := 0;

  InternalDIB.DIBInfos.W3HeadInfo.bmiColors[Index] := Color;
  {$RANGECHECKS ON}
  //�Â��p���b�g���폜
  InternalDIB.UpdatePalette;
  // �ύX��ʒm
  UpdatePaletteModified;
  Modified := True;
end;

// Pixels Property �̃w���p

//-------------------------------------------------------------------
// Note:
//
// Pixels Property �� LongInt �^���� 1/4/8 RGB �^�ł̓J���[�C���f�b�N�X�l��
// �Ȃ�BTrueColor �ł� RGB �l�ɂȂ�B

// Pixel �l�̎擾
function TNkDIB.GetPixels(x, y: Integer): LongInt;  // Pixel �l�̎擾
var pLine: PNkTripleArray;
    pByte: ^Byte;
    Mask: Byte;
const Bits8: BYTE = $80;
begin
  // ���k�t�H�[�}�b�g�ł̃s�N�Z���l�̎擾�͍���Ȃ̂ŃG���[�ɂ���
  // �܂��A���݂� ������Ȃ̂� 1/4Bit �񈳏k���T�|�[�g���Ȃ��B
  // 8 Bit �񈳏k�ɕϊ����Ă��珈�����邱��
  with InternalDIB.DIBInfos.W3Head do begin
    if (biCompression <> BI_RGB) then
      raise ENkDIBBadDIBType.Create('TNkDIB.GetPixels: Bad DIB Type');

    // �͈̓`�F�b�N
    if (x < 0) or ( x >= biWidth) or (y < 0) or (y >= abs(biHeight)) then
      raise ENkDIBPixelPositionRange.Create(
        'TNkDIB.GetPixels: Pixel Position is Out of Range');


    if biBitCount = 8 then begin
      // 8Bit �񈳏k

      // �s�N�Z���A�h���X���v�Z�i���㌴�_�I�I�j
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 3) div 4) * 4 * (biHeight - y - 1) + x)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 3) div 4) * 4 * y + x);
      Result := pByte^;  // �J���[�e�[�u���̃C���f�b�N�X��Ԃ�
    end
    else if biBitCount = 24 then begin
      // True Color

      // ���C���̐擪�A�h���X���v�Z�i���㌴�_�I�I�I�j
      if biHeight > 0 then
        pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth * 3 + 3) div 4) * 4 * (biHeight - y - 1))
    else
      pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                       ((biWidth * 3 + 3) div 4) * 4 * y);
      // TColor �^��Ԃ�
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
      // �C���f�b�N�X�l��ǂ�
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
      // �J���[�e�[�u���̃C���f�b�N�X�l����������
      Mask := Bits8 shr (x mod 8);
      if (pByte^ and Mask) <> 0 then Result := 1
      else Result := 0;
    end
    else
      raise ENkDIBInvalidDIB.Create(
        'TNkDIB.GetPixels: GetPixel supports only Uncompressed DIB');
  end;
end;


// �s�N�Z���̕ύX
// ���ӁI�I �s�N�Z���̕ύX�� �����̊m�ۂ̂��� OnChange Event ���N�����Ȃ�
// �]���āA TNkImage �ɕύX��񂹂�ɂ� TNkImage �� Invalidate ���\�b�h��
// �Ăяo���K�v������
procedure TNkDIB.SetPixels(x, y: Integer; Value: LongInt); // Pixel �l�̐ݒ�
var pLine: PNkTripleArray;
    pByte: ^Byte;
    Mask: BYTE;
const Bits8: BYTE = $80;
begin
  // DIB �̓��e���ω����邽�߁A���L���~�߂�
  if InternalDIB.RefCount <> 1 then
    UniqueDIB;

  with InternalDIB.DIBInfos.W3Head do begin
    if (biCompression <> BI_RGB) then
      raise ENkDIBBadDIBType.Create('TNkDIB.SetPixels: Bad DIB Type');


    if (x < 0) or ( x >= biWidth) or (y < 0) or (y >= abs(biHeight)) then
      raise ENkDIBPixelPositionRange.Create(
        'TNkDIB.SetPixels: Pixel Position is Out of Range');


    if biBitCount = 8 then begin
      // 8Bit �񈳏k

      // �s�N�Z���A�h���X���v�Z�i���㌴�_�I�I�j
      if biHeight > 0 then
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth + 3) div 4) * 4 * (biHeight - y - 1) + x)
      else
        pByte := AddOffset(InternalDIB.DIBInfos.pBits,
                         ((biWidth + 3) div 4) * 4 * y + x);
      // �J���[�e�[�u���̃C���f�b�N�X�l����������
      pByte^ := Value;
    end
    else if biBitCount = 24 then begin
      // True Color

      // ���C���̐擪�A�h���X���v�Z�i���㌴�_�j
      if biHeight > 0 then
        pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth * 3 + 3) div 4) * 4 * (biHeight - y - 1))
      else
        pLine := AddOffset(InternalDIB.DIBInfos.pBits,
                           ((biWidth * 3 + 3) div 4) * 4 * y);

      // �s�N�Z�������������� (TColor -> TRGBTriple)
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
      // �J���[�e�[�u���̃C���f�b�N�X�l����������
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
      // �J���[�e�[�u���̃C���f�b�N�X�l����������
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

// ScanLine �|�C���^�̎擾
// ���ӁI�I ScanLine �|�C���^������s�N�Z���̕ύX�� OnChange Event ��
// �N�����Ȃ�
// �]���āA TNkImage �ɕύX��񂹂�ɂ� TNkImage �� Invalidate ���\�b�h��
// �Ăяo���K�v������

function TNkDIB.GetScanLine(y: Integer): Pointer; // Scanline �|�C���^�̎擾
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


// Pixel Format �̎擾
function TNkDIB.GetPixelFormat: TNkPixelFormat;
begin
//  Assert(InternalDIB <> Nil,
//    'TNkDIB.GetPixelFormat: InternalDIB Should not be Nil');

  Result := InternalDIB.GetPixelFormat;
end;

// Pixel Format �̕ϊ�
// �����ł̏����͂قƂ�� TNkInternalDIB �C�������ATNkDIB ���ł͈ȉ��̏�����
// �s���B
//  (1) PixelFormat ���ύX�����̂��`�F�b�N���A�ύX����Ȃ��̂Ȃ牽�����Ȃ��B
//  (2) UniqueDIB ���Ă�ŋ��L�������B
//  (3) OnProgress ���N�����K�v�����邩���f���A�K�v�Ȃ� �v���O���X�n���h����
//      ���������s�� StartProgres(OnProgress �� State = psStarting ���N����)��
//      �ĂԁB
//  (4) �ϊ�����(TNkInternalDIB �� SetPixelFormat ���Ă�)
//  (5) StartProgres ���Ă񂾏ꍇ�́u�K���vEndProgress ���Ăяo��
//      State = psEnding �� OnProgress �C�x���g���N�����B
//  (6) �p���b�g�̕ύX���E���o���AOnChange �C�x���g���N�����B
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


// �n�[�t�g�[�����[�h�̐ݒ�

procedure TNkDIB.SetHalftoneMode(Value: TNkHalftoneMode);
begin
  if FHalfToneMode = Value then Exit;

  FHalftoneMode := Value;
  PaletteModified := True;
  Modified := True;
end;


// XpelsPerMeter/YPelsPerMeter �̃w���p

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




// Delphi 3.0J �� PaletteModified Property �̍X�V����
// ���̏����͈ꌩ ���L����Ă��� InternalDIB.PaletteModified ��
// �X�V���Ă���̂Ŋ댯�Ɏv���邪�APalette �̍X�V���ɂ�
// RefCount = 1 �̂͂��Ȃ̂Ŗ�薳���B

procedure TNkDIB.UpdatePaletteModified;
begin
  Assert(InternalDIB.RefCount = 1, 'TNkDIB.UpdatePaletteModified RefCount Must be 1');
  if InternalDIB.PaletteModified = True then begin
    InternalDIB.PaletteModified := False;
    PaletteModified := True;
  end;
end;



// TNkDIB �Ԃ� Internal DIB �����L����Ă���ꍇ�́A�R�s�[���Đ؂藣���B
procedure TNkDIB.UniqueDIB;
var Temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.UniqueDIB: InternalDIB Should not be Nil');

  // Internal DIB �����L����Ă��Ȃ���Ή������Ȃ�
  if InternalDIB.RefCount = 1 then Exit;

  // Internal DIB �����
  Temp := TNkInternalDIB.Create(UseFMO);
  try
    // �f�t�H���g�ŏo���� 1 X 1 Pixel �� DIB ���̂Ă�
    temp.FreeDIB;


    // Internal DIB ���R�s�[
    temp.Height   := InternalDIB.Height;
    temp.Width    := InternalDIB.Width;
    temp.DIBInfos := InternalDIB.DIBInfos;
    temp.DIBInfos.pBits := Nil;
    temp.UseFMO   := InternalDIB.UseFMO;
    with temp.DIBInfos do
      GetMemory(BitsSize, hFile, pBits, temp.UseFMO);

    System.Move(InternalDIB.DIBInfos.pBits^, temp.DIBInfos.pBits^,
                temp.DIBInfos.BitsSize);
    // ���L����Ă��� Internal DIB ��؂藣��
    ReleaseInternalDIB;

    // �R�s�[���ꂽ DIB ���Ȃ�
    InternalDIB := temp;
    UpdatePaletteModified;
  except
    temp.Free;
    raise;
  end;
end;



// True Color DIB �ɃJ���[�e�[�u�����쐬����
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
// OnProgress �C�x���g�� TNkDIB.ProgressHandler ���Ăяo�����ƋN����悤��
// �����BTNkDIB ���ɃC�x���g�J�E���^������ ����� PercentDone ���v�Z����
// OnProgress �C�x���g���N�����B
// TNkDIB �ł� �v���O���X�̓r���ŕ`�悷�邱�Ƃ͂ł��Ȃ����� EndProgress ��
// OnProgress �C�x���g���N�����Ƃ��̂� RedrawNow �� True �ɂ��Ă���B
//


// �v���O���X�n���h���̏�����
// AMaxNumberOfProgress: �v���O���X�̍ő�񐔁BPercentDone ���v�Z����̂Ɏg���B
// AProgressString:      OnProgress �Œʒm����郁�b�Z�[�W

procedure TNkDIB.InitializeProgressHandler(AMaxNumberOfProgresses: Integer;
                                          AProgressString: string);
begin
  ProgressString := AProgressString;
  MaxNumberOfProgresses := AMaxNumberOfProgresses;
  NumberOfProgresses := 0;
end;

// �v���O���X�n���h�� OnProgress(Stage = psRunning)���N�����B
procedure TNkDIB.ProgressHandler(Sender: TObject);
begin
  Inc(NumberOfProgresses);
  if NumberOfProgresses <> MaxNumberOfProgresses then
    Progress(Self, psRunning, NumberOfProgresses * 100 div MaxNumberOfProgresses,
             False, Rect(0, 0, Width, Height), ProgressString);
end;

// OnProgress(PercentDone = 0%, Stage=psStarting) ���N�����B
procedure TNkDIB.StartProgress;
begin
  Progress(Self, psStarting, 0, False, Rect(0, 0, Width, Height), ProgressString);
end;

// OnProgress(PercentDone = 0%, Stage=psEnding) ���N�����B
procedure TNkDIB.EndProgress;
begin
  Progress(Self, psEnding, 100, True, Rect(0, 0, Width, Height), ProgressString);
end;

function TNkDIB.GetUseFMO: Boolean;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.GetUseFMO: InternalDIB Should not be Nil');

  Result := InternalDIB.UseFMO;
  { DONE : GetUseFMO �̃R�[�h������������ InternalDIB �� UseFMO ���K�v}
end;

procedure TNkDIB.SetUseFMO(const Value: Boolean);
var Temp: TNkInternalDIB;
begin
  Assert(InternalDIB <> Nil,
    'TNkDIB.SetUseFMO: InternalDIB Should not be Nil');

  // UseFMO ���ω����Ȃ��Ȃ牽�����Ȃ�
  if UseFMO = Value then Exit;

  // Internal DIB �����
  Temp := TNkInternalDIB.Create(Value);
  try
    // �f�t�H���g�ŏo���� 1 X 1 Pixel �� DIB ���̂Ă�
    temp.FreeDIB;

    // Internal DIB ���R�s�[
    temp.Height   := InternalDIB.Height;
    temp.Width    := InternalDIB.Width;
    temp.DIBInfos := InternalDIB.DIBInfos;
    temp.DIBInfos.pBits := Nil;
    with temp.DIBInfos do
      GetMemory(BitsSize, hFile, pBits, temp.UseFMO);

    System.Move(InternalDIB.DIBInfos.pBits^, temp.DIBInfos.pBits^,
                temp.DIBInfos.BitsSize);
    // ���L����Ă��� Internal DIB ��؂藣��
    ReleaseInternalDIB;

    // �R�s�[���ꂽ DIB ���Ȃ�
    InternalDIB := temp;
    UpdatePaletteModified;
  except
    temp.Free;
    raise;
  end;
    { DONE : SetUse FMO �c��̃R�[�h������������ }
end;



// TNkDIBCanvas �̍쐬
// Canvas ���Ă��������ꂾ���̃R�[�h�łł��Ă��܂��܂��B�ȒP�B
constructor TNkDIBCanvas.Create(ADIB: TNkDIB);
var HalftoneModeSave: TNkHalftoneMode;
begin
  inherited Create;
  if (ADIB = Nil) or not ADIB.UseFMO then
    raise ENkDIBCanvasFailed.Create(
      'TNkDIBCanvas.Create: Cannot Create Canvas');
  DIB := ADIB;

  // �������݂�����̂ŋ��L����߂�B
  DIB.UniqueDIB;

  OldBitmap := 0; OldPalette := 0;
  MemDC := 0; hDIBSection := 0;
  pBits := Nil;

  // Memory DC �̍쐬
  MemDC := CreateCompatibleDC(0);
  if MemDC = 0 then raise EOutOfResources.Create(
    'TNkDIBCanvas.Create: Cannot Create Memory DC');

  // �p���b�g�����̉�
  HalftoneModeSave := DIB.HalftoneMode;
  DIB.FHalftoneMode := nkHtNoHalftone;
  try
    OldPalette := SelectPalette(MemDC, DIB.Palette, True);
    RealizePalette(MemDC);
  finally
    DIB.FHalftoneMode := HalftoneModeSave;
  end;

  // DIB Section �̍쐬
  hDIBSection := CreateDIBSection(MemDC, DIB.InternalDIB.DIBInfos.W3HeadInfo,
                                  DIB_RGB_COLORS, pBits,
                                  DIB.InternalDIB.DIBInfos.hFile, 0);
  if hDIBSection = 0 then raise EOutOfResources.Create(
    'TNkDIBCanvas.Create: Cannot Create Memory DC');

  // DIB Section �� DC �ɑI��
  OldBitmap := SelectObject(MemDC, hDIBSection);

  // Canvas �� DC ���Z�b�g
  Handle := MemDC;
end;

destructor TNkDIBCanvas.Destroy;
begin
  // DIB Section �� DC ����O��
  if OldBitmap <> 0 then SelectObject(MemDC, OldBitmap);

  // DIB Section ���폜����
  if hDIBSection <> 0 then DeleteObject(hDIBSection);

  // DC �� Canvas ����؂藣���B
  Handle := 0;

  // DC ���폜����B
  if MemDC <> 0 then DeleteDC(MemDC);

  if DIB <> Nil then begin
    DIB.UpdatePaletteModified;
    DIB.Changed(DIB);
  end;
  inherited Destroy;
end;


Initialization
  // �n�[�t�g�[���p�p���b�g�̏������B�s�v�����O�̂��߁B
  PaletteHalfTone := 0;
  PaletteBlackWhite := 0;
  // Clipborad Format CF_DIB �� TNkDIB �ɑΉ��Â���B
  TPicture.RegisterClipBoardFormat(CF_DIB, TNkDIB);
  // �g���q dib �̃t�@�C���� TNkDIB ��Ή��Â���B
  TPicture.RegisterFileFormat('dib', 'Device Independent Bitmap', TNkDIB);


finalization
  // �n�[�t�g�[���p�p���b�g�̔j���B�s�v�����O�̂��߁B
  if PaletteHalfTone <> 0 then DeleteObject(PaletteHalfTone);
  if PaletteBlackWhite <> 0 then DeleteObject(PaletteBlackWhite);
  // Delphi 3.0J �ȍ~�ł́ATPicture.RegisterClipBoardFormat ��
  // TPicture.RegisterFileFormat �œo�^���� TNkDIB �̊g���q��N���b�v�{�[�h
  // �t�H�[�}�b�g�� �p�b�P�[�W�� Unload �����Ƃ��� Graphics ���j�b�g����
  // �폜����K�v���L��BDelphi 2.0J �ł͍폜���郁�\�b�h������
  TPicture.UnRegisterGraphicClass(TNkDIB);
end.

