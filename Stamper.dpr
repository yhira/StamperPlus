program Stamper;
{%File 'File1.txt'}
{%File 'Readme.txt'}
{%File 'BackupDir'}
//  FastMM4,
//  FastMove,
//  FastCode,

uses
  FastMM4,
  FastMove,
  FastCode,
  Windows,
  Messages,
  Forms,
  FrMain in 'FrMain.pas' {FormStancher},
  ComItems in 'ComItems.pas',
  ComDef in 'ComDef.pas',
  SQLiteTable3 in 'SQLiteTable3.pas',
  MessageDef in 'MessageDef.pas',
  FrOption in 'FrOption.pas' {FormOption},
  FrShowMsg in 'FrShowMsg.pas' {FormShowMsg},
  Helper in 'Helper.pas',
  UntOption in 'UntOption.pas',
  FrProperty in 'FrProperty.pas' {FormProperty},
  FrIcon in 'FrIcon.pas' {FormIcon},
  FrMsg in 'FrMsg.pas' {FormMsg},
  FrmColor in 'FrmColor.pas' {Frame1: TFrame},
  FrSelFile in 'FrSelFile.pas' {FormSelFile},
  IconUtils in 'IconUtils.pas',
  yhINet in 'yhINet.pas',
  Dbg in 'Dbg.pas',
  FrAddText in 'FrAddText.pas' {FormAddText},
  yhFiles in 'yhFiles.pas',
  yhOthers in 'yhOthers.pas',
  FrmInput in 'FrmInput.pas' {FrameInput: TFrame},
  FrmInput2 in 'FrmInput2.pas' {FrameInput2: TFrame},
  FrmShortcutAndHotKey in 'FrmShortcutAndHotKey.pas' {FrameShortcutAndHotKey: TFrame},
  FrmMouseAction in 'FrmMouseAction.pas' {FrameMouseAction: TFrame},
  FrCallAction in 'FrCallAction.pas' {FormCallAction},
  ComFunc in 'ComFunc.pas',
  FrMemo in 'FrMemo.pas' {FormMemo},
  cryptogram in 'cryptogram.pas',
  FrPassword in 'FrPassword.pas' {FormPassword},
  IconRes in 'IconRes.pas',
  FrMacro in 'FrMacro.pas' {FormMacro},
  FrPassEdit in 'FrPassEdit.pas' {FormPassEdit},
  About in 'About.pas' {FormAbout},
  BugReport in 'BugReport.pas' {FormBugReport},
  FrCallMethod in 'FrCallMethod.pas' {FormMousePosCallMethod},
  ModClip in 'ModClip.pas' {DataModule1: TDataModule},
  FrText in 'FrText.pas' {TextForm};

{$R *.res}

const STAMPER_MUTEX_NAME = 'Stamper_c1qr5q xrsppj2';
var
  hMutex, hWind, hOwner: HWND;
begin                 
  if AppTerminate then Exit; 
  hMutex := OpenMutex(MUTEX_ALL_ACCESS, False, STAMPER_MUTEX_NAME);
  if (hMutex <> 0)  then begin
    CloseHandle(hMutex);
    //先に起動しているこのプログラムのウィンドウハンドルとオーナーウィンドウのハンドルを取得
    hWind := FindWindow('TFormStancher', 'Stamper');
    hOwner := GetWindow(hWind, GW_OWNER);
    if (IsIconic(hOwner)) then begin
      //最小化されていたら元のサイズに戻す
      SendMessage(hOwner, WM_SYSCOMMAND, SC_RESTORE,-1);
    end else begin
      //前面に移動させる
      SetForegroundWindow(hWind);
    end;
    Exit;
  end;
  CreateMutex(nil, False, STAMPER_MUTEX_NAME);

  Application.Initialize;
  Application.Title := 'Stamper+';
  Application.CreateForm(TFormStancher, FormStancher);
  Application.Run;
  
  ReleaseMutex(hMutex);
end.
