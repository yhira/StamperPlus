/////////////////////////////////////////////////////////////
//
// Unit NkGraphic  -- Improved TGraphic
//
// Coded By T.Nakamura
//
//
//  ����
//
//  Ver 0.32: May.  4 '97  ���W��   TNkDIB ���� TNkGraphic �̐錾�𕪗�
//  Ver 0.34: Jun. 29 '97  ���P�O�� Delphi 3.0J �Ή��B
//  Ver 0.43: Sep.  5 '97  ���P�R�� �N���b�v�{�[�h����̃f�[�^�擾���T�|�[�g�B
//  Ver 0.61: Jan. 12 '97  Progress ���\�b�h�^OnProgress �C�x���g��ǉ� 
//  Ver 0.64: May.  3 '98  �R���p�C���w�߁ADelphi Version Check ���ʎq��ǉ�
//  Ver 0.65: May. 5 '98  C++Builder 3.0J �ɑΉ�
//  Ver 0.66: Sep. 27 '98 Delphi 4.0J �ɑΉ��B
//  Ver 0.70: May 8 '99   Delphi 2, C++Builder 1 �T�|�[�g�ł��؂�


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

// �N���b�v�{�[�h����̃f�[�^�̎擾
procedure TNkGraphic.Assign(Source: TPersistent);
var Clip: TClipBoard;
    AData: THandle;
    APalette: HPALETTE;
begin
  // �\�[�X���N���b�v�{�[�h���H
  if Source is TClipBoard then begin
    Clip := Source as TClipBoard;
    Clip.Open;
    try
      // �N���b�v�{�[�h���� ClipboardFormat �^�̃f�[�^���擾
      AData := Clip.GetAsHandle(ClipboardFormat);
      // �N���b�v�{�[�h���� �p���b�g���擾
      APalette := Clip.GetAsHandle(CF_PALETTE);

      // �����ŁA�f�[�^���擾�ł������̃`�F�b�N�͂��Ȃ��B
      // AData��APalette �̃`�F�b�N�� LoadFromClipboardFormat ���s���B

      // �f�[�^����������
      LoadFromClipboardFormat(ClipboardFormat, AData, APalette);
    finally
      Clip.Close;
    end;
  end
  else
    inherited Assign(Source);
end;

end.
