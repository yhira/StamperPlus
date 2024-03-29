unit UntOption;

interface

uses
  Windows, SysUtils, Classes, ComCtrls, Graphics, ExtIniFile, Forms, MMSystem,
  ComItems, Grids, Menus, Dialogs, ComDef, yhFiles;

type
  TBackupMode = (bmDay, bmWeek, bmMonth);  
  TCallMethod = (cmMouseClk, cmMouseCsrPos);
  TMouseCslRtnPos = (mpLeftTop, mpLeftBottom, mpRightTop, mpRightBottom);
  TMouseCslRtnPoses = set of TMouseCslRtnPos;

  TOption = class
  private
    FIniFile: TExtIniFile;
    FAutoExpand: Boolean;
    FUseBrowser: Boolean;
    FEditorPath: string;
    FBrowserPath: string;
    FTreeColor: TColor;
    FFormColor: TColor;
    FListColor: TColor;
    FTreeFont: TFont;
    FListFont: TFont;
    FTabPosition: TTabPosition;
    FUseSound: Boolean;
    FSoundFile: string;
    FHintColor: TColor;
    FMaxClipHistory: Integer;
    FListHintVisible: Boolean;
    FTreeHintVisible: Boolean;
    FHotTrack: Boolean;
    FUsePassword: Boolean;
    FTabStyle: TTabStyle;
    FConfDelItem: Boolean;
    FConfDelDir: Boolean;
    FUseClipItemToTop: Boolean;
    FDspPos: TDspPos;
    FTabSpaceCount: Integer;
    FLineTopList: TStringList;
    FLineTopBottomList: TStringList;
    FOneClickExcute: Boolean;
    FCallPasteItem: TCallTabItem;
    FCallAllSearchItem: TCallTabItem;
    FCallLastItem: TCallTabItem;
    FCallClipItem: TCallTabItem;
    FCallBkmkItem: TCallTabItem;
    FCallLaunchItem: TCallTabItem;
    FCallBackMargin: Integer;
    FConfPasteXmlExport: Boolean;
    FIsClipToBkmkName: Boolean;
    FIsClipToPasteName: Boolean;
    FIsClipToPasteTexs: Boolean;
    FIsClipToLauncherName: Boolean;
    FIsClipToDirName: Boolean;
    FSearchDispDir: Boolean;
    FConfDelDbMouse: Boolean;
    FConfDelDbHot: Boolean;
    FConfDelDbShortcut: Boolean;
    FDateTimeFmt: string;
    FDateFmt: string;
    FTimeFmt: string;
    FListDateTimeFmt: string;
    FIsStartup: Boolean;
    FDispLauncherExt: Boolean;
    FAutoBacup: Boolean;
    FBackupDir: string;
    FBackupMode: TBackupMode;
    FLastBackupDate: TDateTime;
    FLeaveBackupFiles: Integer;
    FCallMethod: TCallMethod;
    FMouseCslRtnWidth: Integer;
    FMouseCslRtnPoses: TMouseCslRtnPoses;
    FMouseCslRtnTime: Integer;
    FDispItemAddInfo: Boolean;
    FMemoColor: TColor;
    FMemoFont: TFont;
    procedure SetAutoExpand(const Value: Boolean);
    procedure SetBrowserPath(const Value: string);
    procedure SetEditorPath(const Value: string);
    procedure SetFormColor(const Value: TColor);
    procedure SetListColor(const Value: TColor);
    procedure SetListFont(const Value: TFont);
    procedure SetTabPosition(const Value: TTabPosition);
    procedure SetTreeColor(const Value: TColor);
    procedure SetTreeFont(const Value: TFont);
    procedure SetUseBrowser(const Value: Boolean);
    procedure SetUseSound(const Value: Boolean);
    procedure SetSoundFile(const Value: string);
    procedure SetHintColor(const Value: TColor);
    procedure SetMaxClipHistory(const Value: Integer);
    procedure SetListHintVisible(const Value: Boolean);
    procedure SetTreeHintVisible(const Value: Boolean);
    procedure SetHotTrack(const Value: Boolean);
    procedure SetUsePassword(const Value: Boolean);
    procedure SetTabStyle(const Value: TTabStyle);
    procedure SetConfDelDir(const Value: Boolean);
    procedure SetConfDelItem(const Value: Boolean);
    procedure SetUseClipItemToTop(const Value: Boolean);
    procedure SetDspPos(const Value: TDspPos);
    procedure SetTabSpaceCount(const Value: Integer);
    procedure SetLineTopList(const Value: TStringList);
    procedure SetLineTopBottomList(const Value: TStringList);
    procedure SetMainMenus;
    procedure InitLineTopBottomList;
    procedure InitLineTopList;
    procedure SetOneClickExcute(const Value: Boolean);
    procedure SetCallAllSearchItem(const Value: TCallTabItem);
    procedure SetCallBkmkItem(const Value: TCallTabItem);
    procedure SetCallClipItem(const Value: TCallTabItem);
    procedure SetCallLastItem(const Value: TCallTabItem);
    procedure SetCallLaunchItem(const Value: TCallTabItem);
    procedure SetCallPasteItem(const Value: TCallTabItem);
    procedure SetCallBackMargin(const Value: Integer);
    procedure SetConfPasteXmlExport(const Value: Boolean);
    procedure SetIsClipToBkmkName(const Value: Boolean);
    procedure SetIsClipToDirName(const Value: Boolean);
    procedure SetIsClipToLauncherName(const Value: Boolean);
    procedure SetIsClipToPasteName(const Value: Boolean);
    procedure SetIsClipToPasteTexs(const Value: Boolean);
    procedure SetSearchDispDir(const Value: Boolean);
    procedure SetConfDelDbHot(const Value: Boolean);
    procedure SetConfDelDbMouse(const Value: Boolean);
    procedure SetConfDelDbShortcut(const Value: Boolean);
    procedure SetDateFmt(const Value: string);
    procedure SetDateTimeFmt(const Value: string);
    procedure SetListDateTimeFmt(const Value: string);
    procedure SetTimeFmt(const Value: string);
    procedure SetIsStartup(const Value: Boolean);
    procedure SetDispLauncherExt(const Value: Boolean);
    procedure SetAutoBacup(const Value: Boolean);
    procedure SetBackupDir(const Value: string);
    procedure SetBackupMode(const Value: TBackupMode);
    procedure SetLastBackupDate(const Value: TDateTime);
    procedure SetLeaveBackupFiles(const Value: Integer);
    procedure SetCallMethod(const Value: TCallMethod);
    procedure SetMouseCslRtnPoses(const Value: TMouseCslRtnPoses);
    procedure SetMouseCslRtnWidth(const Value: Integer);
    procedure SetMouseCslRtnTime(const Value: Integer);
    procedure SetDispItemAddInfo(const Value: Boolean);
    procedure SetMemoColor(const Value: TColor);
    procedure SetMemoFont(const Value: TFont);
  protected

  public
    constructor Create;
    destructor Destroy; override;
    procedure ReadIni;
    procedure WriteIni;
    procedure PlaySound;
    procedure FormToOption;    
    procedure OptionToForm;
    property AutoExpand: Boolean read FAutoExpand write SetAutoExpand;
    property HotTrack: Boolean read FHotTrack write SetHotTrack;
    property TabPosition: TTabPosition read FTabPosition write SetTabPosition;
    property FormColor: TColor read FFormColor write SetFormColor;
    property TreeColor: TColor read FTreeColor write SetTreeColor;
    property ListColor: TColor read FListColor write SetListColor;
    property HintColor: TColor read FHintColor write SetHintColor; 
    property MemoColor: TColor read FMemoColor write SetMemoColor;
    property TreeFont: TFont read FTreeFont write SetTreeFont;
    property ListFont: TFont read FListFont write SetListFont;      
    property MemoFont: TFont read FMemoFont write SetMemoFont;
    property EditorPath: string read FEditorPath write SetEditorPath;
    property UseBrowser: Boolean read FUseBrowser write SetUseBrowser;
    property BrowserPath: string read FBrowserPath write SetBrowserPath;
    property UseSound: Boolean read FUseSound write SetUseSound;
    property SoundFile: string read FSoundFile write SetSoundFile;
    property MaxClipHistory: Integer read FMaxClipHistory write SetMaxClipHistory;
    property ListHintVisible: Boolean read FListHintVisible write SetListHintVisible;
    property TreeHintVisible: Boolean read FTreeHintVisible write SetTreeHintVisible;
    property UsePassword: Boolean read FUsePassword write SetUsePassword;
    property TabStyle: TTabStyle read FTabStyle write SetTabStyle;
    property UseClipItemToTop: Boolean read FUseClipItemToTop write SetUseClipItemToTop;
    property DspPos: TDspPos read FDspPos write SetDspPos;
    property TabSpaceCount: Integer read FTabSpaceCount write SetTabSpaceCount;
    property LineTopList: TStringList read FLineTopList write SetLineTopList;  
    property LineTopBottomList: TStringList read FLineTopBottomList write SetLineTopBottomList;
    property ConfDelDir: Boolean read FConfDelDir write SetConfDelDir;
    property ConfDelItem: Boolean read FConfDelItem write SetConfDelItem;
    property ConfPasteXmlExport: Boolean read FConfPasteXmlExport write SetConfPasteXmlExport;
    property ConfDelDbShortcut: Boolean read FConfDelDbShortcut write SetConfDelDbShortcut;
    property ConfDelDbHot: Boolean read FConfDelDbHot write SetConfDelDbHot;
    property ConfDelDbMouse: Boolean read FConfDelDbMouse write SetConfDelDbMouse;
    property OneClickExcute: Boolean read FOneClickExcute write SetOneClickExcute;
    property CallLastItem: TCallTabItem read FCallLastItem write SetCallLastItem;
    property CallAllSearchItem: TCallTabItem read FCallAllSearchItem write SetCallAllSearchItem;
    property CallPasteItem: TCallTabItem read FCallPasteItem write SetCallPasteItem;
    property CallLaunchItem: TCallTabItem read FCallLaunchItem write SetCallLaunchItem;
    property CallBkmkItem: TCallTabItem read FCallBkmkItem write SetCallBkmkItem;
    property CallClipItem: TCallTabItem read FCallClipItem write SetCallClipItem;
    property CallBackMargin: Integer read FCallBackMargin write SetCallBackMargin;
    property IsClipToDirName: Boolean read FIsClipToDirName write SetIsClipToDirName;
    property IsClipToPasteName: Boolean read FIsClipToPasteName write SetIsClipToPasteName;
    property IsClipToLauncherName: Boolean read FIsClipToLauncherName write SetIsClipToLauncherName;
    property IsClipToBkmkName: Boolean read FIsClipToBkmkName write SetIsClipToBkmkName;
    property IsClipToPasteText: Boolean read FIsClipToPasteTexs write SetIsClipToPasteTexs;
    property SearchDispDir: Boolean read FSearchDispDir write SetSearchDispDir;
    property DateFmt: string read FDateFmt write SetDateFmt;
    property TimeFmt: string read FTimeFmt write SetTimeFmt;
    property DateTimeFmt: string read FDateTimeFmt write SetDateTimeFmt;
    property ListDateTimeFmt: string read FListDateTimeFmt write SetListDateTimeFmt;
    property IsStartup: Boolean read FIsStartup write SetIsStartup;
    property DispLauncherExt: Boolean read FDispLauncherExt write SetDispLauncherExt;
    property AutoBacup: Boolean read FAutoBacup write SetAutoBacup;
    property BackupMode: TBackupMode read FBackupMode write SetBackupMode;
    property BackupDir: string read FBackupDir write SetBackupDir;
    property LastBackupDate: TDateTime read FLastBackupDate write SetLastBackupDate;
    property LeaveBackupFiles: Integer read FLeaveBackupFiles write SetLeaveBackupFiles;
    property CallMethod: TCallMethod read FCallMethod write SetCallMethod;
    property MouseCslRtnPoses: TMouseCslRtnPoses read FMouseCslRtnPoses write SetMouseCslRtnPoses;
    property MouseCslRtnWidth: Integer read FMouseCslRtnWidth write SetMouseCslRtnWidth;
    property MouseCslRtnTime: Integer read FMouseCslRtnTime write SetMouseCslRtnTime;
    property DispItemAddInfo: Boolean read FDispItemAddInfo write SetDispItemAddInfo;
  end;


implementation

uses FrMain, FrOption, StdCtrls, ExtCtrls, Controls;

const SECTION = 'Option';

{ TOption }

constructor TOption.Create;
var AppPath: string;
begin
  AppPath := ExtractFilePath(Application.ExeName);
  FIniFile := TExtIniFile.Create(nil);
  FIniFile.DefaultFolder := dfUser;
  FIniFile.FileName := AppPath + 'config/option.ini';
  FIniFile.UpdateAtOnce := True;
  FLineTopList := TStringList.Create;
  FLineTopBottomList := TStringList.Create;
  FTreeFont := TFont.Create;
  FListFont := TFont.Create;    
  FMemoFont := TFont.Create;
  FTreeFont.Assign(FormStancher.TreePaste.Font);
  FListFont.Assign(FormStancher.ListViewPaste.Font);
  FMemoFont.Assign(FormStancher.MemoPasteText.Font);
  FAutoExpand := True;
  FHotTrack := True;
  FUseBrowser := False;
  FEditorPath := 'notepad.exe';
  FBrowserPath := '';
  FFormColor := clBtnFace;
  FTreeColor := clWindow;
  FListColor := clWindow;
  FHintColor := clCream;
  FMemoColor := clWindow;
  FTabPosition := tpBottom;
  FTabStyle := tsTabs;
  FUseSound := True;
  FSoundFile := AppPath + 'sound\click.wav';
  FMaxClipHistory := 100;
  FListHintVisible := True;
  FTreeHintVisible := True;
  FUsePassword := False;
  FUseClipItemToTop := True;
  FDspPos := dpMouseCursol;
  FTabSpaceCount := 2;
  FConfDelDir := True;
  FConfDelItem := True;
  FConfPasteXmlExport := True;
  FConfDelDbShortcut := True;
  FConfDelDbHot := True;
  FConfDelDbMouse := True;
  FOneClickExcute := False;
  FCallLastItem := TCallTabItem.Cleate;
  FCallAllSearchItem := TCallTabItem.Cleate;
  FCallPasteItem := TCallTabItem.Cleate;
  FCallLaunchItem := TCallTabItem.Cleate;
  FCallBkmkItem := TCallTabItem.Cleate;
  FCallClipItem := TCallTabItem.Cleate;
  FCallLastItem.ID := CI_LAST_ID;
//  FCallLastItem.ShortCutkey.Key := TextToShortCut('F1'); 
//  FCallLastItem.Hotkey.Key := TextToShortCut('Ctrl + F1');
//  FCallLastItem.Mouse.Enabled := True;
//  FCallLastItem.Mouse.Action := maLDblClk;
//  FCallLastItem.Mouse.RtnPoses := [mrpDeskTop];
  
  FCallAllSearchItem.ID := CI_ALLSEARCH_ID;
  FCallPasteItem.ID := CI_PASTE_ID;
  FCallLaunchItem.ID := CI_LAUNCH_ID;
  FCallBkmkItem.ID := CI_BKMK_ID;
  FCallClipItem.ID := CI_CLIP_ID;
  FCallBackMargin := 20;
  FIsClipToDirName := True;    
  FIsClipToPasteName := True;
  FIsClipToLauncherName := False;
  FIsClipToBkmkName := False;
  FIsClipToPasteTexs := True;
  FSearchDispDir := True;
  FDateFmt := 'yyyy/mm/dd';
  FTimeFmt := 'hh:nn:ss';
  FDateTimeFmt := 'yyyy/mm/dd hh:nn:ss';
  FListDateTimeFmt := FDateTimeFmt;
  FIsStartup := False;
  FDispLauncherExt := False;
  FAutoBacup := False;
  FBackupMode := bmWeek;
  FBackupDir := ExtractFilePath(ParamStr(0)) + 'backup';
  FLastBackupDate := 0;
  FLeaveBackupFiles := 3;
  FCallMethod := cmMouseClk;
  FMouseCslRtnPoses := [mpLeftTop, mpLeftBottom, mpRightTop, mpRightBottom];
  FMouseCslRtnWidth := 20;
  FMouseCslRtnTime := 500;
  FDispItemAddInfo := True;
end;

destructor TOption.Destroy;
begin
  FIniFile.Free;
  FLineTopList.Free;
  FLineTopBottomList.Free;
  FTreeFont.Free;
  FListFont.Free; 
  FMemoFont.Free;
  FCallLastItem.Free;
  FCallAllSearchItem.Free;
  FCallPasteItem.Free;
  FCallLaunchItem.Free;
  FCallBkmkItem.Free;
  FCallClipItem.Free;
  inherited;
end;

procedure TOption.InitLineTopList;
begin
  if LineTopList.Count = 0 then begin
    FLineTopList.Add('>');
    FLineTopList.Add('//');
    FLineTopList.Add('--');
    FLineTopList.Add('%.4d: ');
  end;
end;

procedure TOption.InitLineTopBottomList;
begin
  if (LineTopBottomList.Count = 0) {or (Trim(LineTopBottomList[0]) = ',')} then begin
    FLineTopBottomList.Add('(,)');
    FLineTopBottomList.Add('{,}');
    FLineTopBottomList.Add('[,]');
    FLineTopBottomList.Add('","');
    FLineTopBottomList.Add(''',''');
    FLineTopBottomList.Add('<!-- , -->');
  end;
end;

procedure TOption.ReadIni;

begin
  with FIniFile do begin
    //基本
    AutoExpand := ReadBool(SECTION, 'AutoExpand', AutoExpand);
    OneClickExcute := ReadBool(SECTION, 'OneClickExcute', OneClickExcute);
    UseSound := ReadBool(SECTION, 'UseSound', UseSound);
    SoundFile := ReadStr(SECTION, 'SoundFile', SoundFile);
    IsClipToDirName := ReadBool(SECTION, 'IsClipToDirName', IsClipToDirName);
    IsClipToPasteName := ReadBool(SECTION, 'IsClipToPasteName', IsClipToPasteName);
    IsClipToLauncherName := ReadBool(SECTION, 'IsClipToLauncherName', IsClipToLauncherName);
    IsClipToBkmkName := ReadBool(SECTION, 'IsClipToBkmkName', IsClipToBkmkName);
    IsClipToPasteText := ReadBool(SECTION, 'IsClipToPasteText', IsClipToPasteText);
    IsStartup := ReadBool(SECTION, 'IsStartup', IsStartup);
//    UsePassword := ReadBool(SECTION, 'UsePassword', UsePassword);
//    Password := ReadStr(SECTION, 'Password', Password);
    //編集
    TabSpaceCount := ReadInt(SECTION, 'TabSpaceCount', TabSpaceCount);
    ReadList(SECTION, 'LineTopList', LineTopList);              InitLineTopList;
    ReadList(SECTION, 'LineTopBottomList', LineTopBottomList);  InitLineTopBottomList;

    //パス
    UseBrowser := ReadBool(SECTION, 'UseBrowser', UseBrowser);
    BrowserPath := ReadStr(SECTION, 'BrowserPath', BrowserPath);
    EditorPath := ReadStr(SECTION, 'EditorPath', EditorPath);
    //呼び出し
    DspPos := TDspPos(ReadInt(SECTION, 'DspPos', Ord(DspPos)));
    CallBackMargin := ReadInt(SECTION, 'CallBackMargin', CallBackMargin);
    CallMethod := TCallMethod(ReadInt(SECTION, 'CallMethod', Ord(CallMethod)));
    MouseCslRtnPoses := [];
    if ReadBool(SECTION, 'MouseCslRtnPoses.lt', True) then
      MouseCslRtnPoses := MouseCslRtnPoses + [mpLeftTop];
    if ReadBool(SECTION, 'MouseCslRtnPoses.lb', True) then
      MouseCslRtnPoses := MouseCslRtnPoses + [mpLeftBottom];
    if ReadBool(SECTION, 'MouseCslRtnPoses.rt', True) then
      MouseCslRtnPoses := MouseCslRtnPoses + [mpRightTop];
    if ReadBool(SECTION, 'MouseCslRtnPoses.rb', True) then
      MouseCslRtnPoses := MouseCslRtnPoses + [mpRightBottom];
    MouseCslRtnWidth := ReadInt(SECTION, 'MouseCslRtnWidth', MouseCslRtnWidth);
    MouseCslRtnTime :=  ReadInt(SECTION, 'MouseCslRtnTime', MouseCslRtnTime);
    //表示
    HotTrack := ReadBool(SECTION, 'HotTrack', HotTrack);
    TabPosition := TTabPosition(ReadInt(SECTION, 'TabPosition', Ord(TabPosition)));
    TabStyle := TTabStyle(ReadInt(SECTION, 'TabStyle', Ord(TabStyle)));
    ListHintVisible := ReadBool(SECTION, 'ListHintVisible', ListHintVisible);
    TreeHintVisible := ReadBool(SECTION, 'TreeHintVisible', TreeHintVisible);
    DispLauncherExt := ReadBool(SECTION, 'DispLauncherExt', DispLauncherExt);
    DispItemAddInfo := ReadBool(SECTION, 'DispItemAddInfo', DispItemAddInfo);
    //外観
    FormColor := ReadColor(SECTION, 'FormColor', FormColor);
    TreeColor := ReadColor(SECTION, 'TreeColor', TreeColor);
    ReadFont(SECTION, 'TreeFont', TreeFont);
    SetTreeFont(TreeFont);
    ListColor := ReadColor(SECTION, 'ListColor', ListColor);
    ReadFont(SECTION, 'ListFont', ListFont);
    SetListFont(ListFont);
    HintColor := ReadColor(SECTION, 'HintColor', HintColor);
    ReadFont(SECTION, 'MemoFont', MemoFont);
    SetMemoFont(MemoFont);
    MemoColor := ReadColor(SECTION, 'MemoColor', MemoColor);

    //クリップボード
    MaxClipHistory := ReadInt(SECTION, 'MaxClipHistory', MaxClipHistory);
    UseClipItemToTop := ReadBool(SECTION, 'UseClipItemToTop', UseClipItemToTop);
    //検索
    SearchDispDir := ReadBool(SECTION, 'SearchDispDir', SearchDispDir);
    //日時形式
    DateFmt := ReadStr(SECTION, 'DateFmt', DateFmt);
    TimeFmt := ReadStr(SECTION, 'TimeFmt', TimeFmt);
    DateTimeFmt := ReadStr(SECTION, 'DateTimeFmt', DateTimeFmt);
    ListDateTimeFmt := ReadStr(SECTION, 'ListDateTimeFmt', ListDateTimeFmt);
    //バックアップ
    AutoBacup := ReadBool(SECTION, 'AutoBacup', AutoBacup);
    BackupMode := TBackupMode(ReadInt(SECTION, 'BackupMode', Integer(BackupMode)));
    BackupDir := ReadStr(SECTION, 'BackupDir', BackupDir);
    LastBackupDate := ReadDateTime(SECTION, 'LastBackupDate', LastBackupDate);
    LeaveBackupFiles := ReadInt(SECTION, 'LeaveBackupFiles', LeaveBackupFiles);
    //確認・案内
    ConfDelDir := ReadBool(SECTION, 'ConfDelDir', ConfDelDir);
    ConfDelItem := ReadBool(SECTION, 'ConfDelItem', ConfDelItem);;
    ConfPasteXmlExport := ReadBool(SECTION, 'ConfPasteXmlExport', ConfPasteXmlExport);
    ConfDelDbShortcut := ReadBool(SECTION, 'ConfDelDbShortcut', ConfDelDbShortcut);
    ConfDelDbHot := ReadBool(SECTION, 'ConfDelDbHot', ConfDelDbHot);
    ConfDelDbMouse := ReadBool(SECTION, 'ConfDelDbMouse', ConfDelDbMouse);
  end;

  CallLastItem.LoadData;
  CallAllSearchItem.LoadData;
  CallPasteItem.LoadData;
  CallLaunchItem.LoadData;
  CallBkmkItem.LoadData;
  CallClipItem.LoadData;

  //メインメニューの再作成
  SetMainMenus;
end;

procedure TOption.WriteIni;
begin
  with FIniFile do begin
    //基本
    WriteBool(SECTION, 'AutoExpand', AutoExpand);
    WriteBool(SECTION, 'OneClickExcute', OneClickExcute);
    WriteBool(SECTION, 'UseSound', UseSound);
    WriteStr(SECTION, 'SoundFile', SoundFile);   
    WriteBool(SECTION, 'IsClipToDirName', IsClipToDirName);
    WriteBool(SECTION, 'IsClipToPasteName', IsClipToPasteName);
    WriteBool(SECTION, 'IsClipToLauncherName', IsClipToLauncherName);
    WriteBool(SECTION, 'IsClipToBkmkName', IsClipToBkmkName);
    WriteBool(SECTION, 'IsClipToPasteText', IsClipToPasteText);
    WriteBool(SECTION, 'IsStartup', IsStartup);
//    WriteBool(SECTION, 'UsePassword', UsePassword);
//    WriteStr(SECTION, 'Password', Password);
    //編集
    WriteInt(SECTION, 'TabSpaceCount', TabSpaceCount);
    WriteList(SECTION, 'LineTopList', LineTopList);     
    WriteList(SECTION, 'LineTopBottomList', LineTopBottomList);
    //パス
    WriteBool(SECTION, 'UseBrowser', UseBrowser);
    WriteStr(SECTION, 'BrowserPath', BrowserPath);
    WriteStr(SECTION, 'EditorPath', EditorPath);    
    //呼び出し
    WriteInt(SECTION, 'DspPos', Ord(DspPos));
    WriteInt(SECTION, 'CallBackMargin', CallBackMargin);
    WriteInt(SECTION, 'CallMethod', Ord(CallMethod));
    WriteBool(SECTION, 'MouseCslRtnPoses.lt', mpLeftTop in MouseCslRtnPoses);
    WriteBool(SECTION, 'MouseCslRtnPoses.lb', mpLeftBottom in MouseCslRtnPoses);
    WriteBool(SECTION, 'MouseCslRtnPoses.rt', mpRightTop in MouseCslRtnPoses);
    WriteBool(SECTION, 'MouseCslRtnPoses.rb', mpRightBottom in MouseCslRtnPoses);
    WriteInt(SECTION, 'MouseCslRtnWidth', MouseCslRtnWidth);
    WriteInt(SECTION, 'MouseCslRtnTime', MouseCslRtnTime);
    //表示
    WriteBool(SECTION, 'HotTrack', HotTrack);
    WriteInt(SECTION, 'TabPosition', Ord(TabPosition));
    WriteInt(SECTION, 'TabStyle', Ord(TabStyle));
    WriteBool(SECTION, 'ListHintVisible', ListHintVisible);
    WriteBool(SECTION, 'TreeHintVisible', TreeHintVisible);
    WriteBool(SECTION, 'DispLauncherExt', DispLauncherExt);
    WriteBool(SECTION, 'DispItemAddInfo', DispItemAddInfo);
    //外観
    WriteColor(SECTION, 'FormColor', FormColor);
    WriteColor(SECTION, 'TreeColor', TreeColor);
    WriteFont(SECTION, 'TreeFont', TreeFont);
    WriteColor(SECTION, 'ListColor', ListColor);
    WriteFont(SECTION, 'ListFont', ListFont);  
    WriteColor(SECTION, 'MemoColor', MemoColor);
    WriteFont(SECTION, 'MemoFont', MemoFont);
    WriteColor(SECTION, 'HintColor', HintColor);
    //クリップボード
    WriteInt(SECTION, 'MaxClipHistory', MaxClipHistory);
    WriteBool(SECTION, 'UseClipItemToTop', UseClipItemToTop);
    //検索
    WriteBool(SECTION, 'SearchDispDir', SearchDispDir);
    //日時形式
    WriteStr(SECTION, 'DateFmt', DateFmt);
    WriteStr(SECTION, 'TimeFmt', TimeFmt);
    WriteStr(SECTION, 'DateTimeFmt', DateTimeFmt);
    WriteStr(SECTION, 'ListDateTimeFmt', ListDateTimeFmt);
    //バックアップ
    WriteBool(SECTION, 'AutoBacup', AutoBacup);
    WriteInt(SECTION, 'BackupMode', Integer(BackupMode));
    WriteStr(SECTION, 'BackupDir', BackupDir);
    WriteDateTime(SECTION, 'LastBackupDate', LastBackupDate);
    WriteInt(SECTION, 'LeaveBackupFiles', LeaveBackupFiles);
    //確認・案内
    WriteBool(SECTION, 'ConfDelDir', ConfDelDir);
    WriteBool(SECTION, 'ConfDelItem', ConfDelItem);
    WriteBool(SECTION, 'ConfPasteXmlExport', ConfPasteXmlExport);
    WriteBool(SECTION, 'ConfDelDbShortcut', ConfDelDbShortcut);
    WriteBool(SECTION, 'ConfDelDbHot', ConfDelDbHot);
    WriteBool(SECTION, 'ConfDelDbMouse', ConfDelDbMouse);

    Update;
  end;
  CallLastItem.SaveData;
  CallAllSearchItem.SaveData;
  CallPasteItem.SaveData;
  CallLaunchItem.SaveData;
  CallBkmkItem.SaveData;
  CallClipItem.SaveData;
end;

procedure TOption.FormToOption;
  procedure SetLineTopBottomList(sg: TStringGrid; sl: TStringList);
  var i: Integer;
  begin
    sl.Clear;
    for i := 0 to sg.RowCount-1 do begin
      if sg.Cells[0, 0] = '' then Continue;
      sl.Add(sg.Cells[0, i] + ',' + sg.Cells[1, i]);
//      sl.Add(sg.Rows[i].CommaText);
    end;
    InitLineTopBottomList;
  end;
begin
  with FormOption do begin   
    FormStancher.OptionTabIndex := PageControl.ActivePageIndex;
    //基本
    AutoExpand := CheckAutoExpand.Checked;
    OneClickExcute := CheckBoxOneClickExcute.Checked;
    UseSound := CheckUseSound.Checked;
    SoundFile := EditSoundFile.Text;
    IsClipToDirName := CheckIsClipToDirName.Checked;
    IsClipToPasteName := CheckIsClipToPasteName.Checked;
    IsClipToLauncherName := CheckIsClipToLauncherName.Checked;
    IsClipToBkmkName := CheckIsClipToBkmkName.Checked;
    IsClipToPasteText := CheckIsClipToPasteTexs.Checked;
    IsStartup := CheckIsStartup.Checked;
    //編集
    TabSpaceCount := SpinEditTabSpaceCount.Value;
    LineTopList.Assign(FrameInputLineTop.ListBox.Items);
    SetLineTopBottomList(FrameInputLineTopBottom.StringGrid, LineTopBottomList);
    //パス
    UseBrowser := CheckUseBrowser.Checked;
    BrowserPath := EditBrowserPath.Text;
    EditorPath := EditEditorPath.Text;
    //呼び出し
    DspPos := TDspPos(RadioGroupDspPos.ItemIndex);
    CallBackMargin := SpinEditCallBackMargin.Value;
    CallMethod := TCallMethod(RadioGroupCallMethod.ItemIndex);
    MouseCslRtnPoses := TmpMouseCslRtnPoses;
    MouseCslRtnWidth := TmpMouseCslRtnWidth;
    MouseCslRtnTime := TmpMouseCslRtnTime;
    //表示
    HotTrack := CheckHotTrack.Checked;
    TabPosition := TTabPosition(RadioGroupTabPosition.ItemIndex);
    if TabPosition <> tpTop then RadioGroupTabStyle.ItemIndex := Ord(tsTabs);
    TabStyle := TTabStyle(RadioGroupTabStyle.ItemIndex);
    ListHintVisible := CheckListHintVisible.Checked;
    TreeHintVisible := CheckTreeHintVisible.Checked;
    DispLauncherExt := CheckDispLauncherExt.Checked;
    DispItemAddInfo := CheckDispItemAddInfo.Checked;
    //外観
    FormColor := ColorBoxFormColor.Selected;
    TreeColor := ColorBoxTreeColor.Selected;
    TreeFont := TmpTreeFont;
    ListColor := ColorBoxListColor.Selected;
    ListFont := TmpListFont;
    MemoColor := ColorBoxMemoColor.Selected;
    MemoFont := TmpMemoFont;
    HintColor := ColorBoxHintColor.Selected;
    //クリップボード
    MaxClipHistory := SpinEditMaxClipHistory.Value;
    UseClipItemToTop := CheckUseClipItemToTop.Checked;
    //検索
    SearchDispDir := CheckSearchDispDir.Checked;
    //日時形式
    DateFmt := EditDateFmt.Text;   
    TimeFmt := EditTimeFmt.Text;
    DateTimeFmt := EditDateTimeFmt.Text;
    ListDateTimeFmt := EditListDateTimeFmt.Text;
    //確認・案内
    ConfDelDir := CheckConfDelDir.Checked;
    ConfDelItem := CheckConfDelItem.Checked;
    ConfPasteXmlExport := CheckConfPasteXmlExport.Checked;
    ConfDelDbShortcut := CheckConfDelDbShortcut.Checked;
    ConfDelDbHot := CheckConfDelDbHot.Checked;
    ConfDelDbMouse := CheckConfDelDbMouse.Checked;
    //呼び出しアクション
    CallLastItem.Assign(TmpCallLastItem);
    CallAllSearchItem.Assign(TmpCallAllSearchItem);
    CallPasteItem.Assign(TmpCallPasteItem);
    CallLaunchItem.Assign(TmpCallLaunchItem);
    CallBkmkItem.Assign(TmpCallBkmkItem);
    CallClipItem.Assign(TmpCallClipItem);
    //バックアップ
    AutoBacup := CheckAutoBacup.Checked;
    BackupMode := TBackupMode(RadioGroupBackupMode.ItemIndex);
    BackupDir := EditBackupDir.Text;
    LeaveBackupFiles := SpinEditLeaveBackupFiles.Value;
    //パスワード
    IsPassWord := CheckIsPassword.Checked;
    Password := TmpPassWord;
    if not IsPassWord then Password := DEF_PASS;
  end;
   
  //メインメニューの再作成
  SetMainMenus;
end;

procedure TOption.OptionToForm;
  procedure SetLineTopBottomGrid(sg: TStringGrid; sl: TStringList);
  var i: Integer; ta: array[0..1] of string; cp: Integer;
  begin
    sg.RowCount := sl.Count;
    for i := 0 to sl.Count-1 do begin
      cp := Pos(',', sl[i]);
      ta[0] := Copy(sl[i], 1, cp-1);
      ta[1] := Copy(sl[i], cp + 1, Length(sl[i]));
      sg.Cells[0, i] := ta[0];         
      sg.Cells[1, i] := ta[1];
    end;
  end;
begin
  with FormOption do begin
    PageControl.ActivePageIndex := FormStancher.OptionTabIndex;
    TreeMenu.Items[PageControl.ActivePageIndex].Selected := True;
    //基本
    CheckAutoExpand.Checked := AutoExpand;  
    CheckBoxOneClickExcute.Checked := OneClickExcute;
    CheckUseSound.Checked := UseSound;
    EditSoundFile.Text := SoundFile;  
    CheckIsClipToDirName.Checked := IsClipToDirName;
    CheckIsClipToPasteName.Checked := IsClipToPasteName;
    CheckIsClipToLauncherName.Checked := IsClipToLauncherName;
    CheckIsClipToBkmkName.Checked := IsClipToBkmkName;
    CheckIsClipToPasteTexs.Checked := IsClipToPasteText;  
    CheckIsStartup.Checked := IsStartup;
    //編集
    SpinEditTabSpaceCount.Value := TabSpaceCount;
    FrameInputLineTop.ListBox.Items.Assign(LineTopList);
    SetLineTopBottomGrid(FrameInputLineTopBottom.StringGrid, LineTopBottomList);
    //パス
    CheckUseBrowser.Checked := UseBrowser;
    EditBrowserPath.Text := BrowserPath;
    EditEditorPath.Text := EditorPath;    
    //呼び出し
    RadioGroupDspPos.ItemIndex := Ord(DspPos);   
    SpinEditCallBackMargin.Value := CallBackMargin; 
    RadioGroupCallMethod.ItemIndex := Ord(CallMethod); 
    TmpMouseCslRtnPoses := MouseCslRtnPoses;
    TmpMouseCslRtnWidth := MouseCslRtnWidth;  
    TmpMouseCslRtnTime := MouseCslRtnTime;
    //表示
    CheckHotTrack.Checked := HotTrack;
    RadioGroupTabPosition.ItemIndex := Ord(TabPosition);
    RadioGroupTabStyle.ItemIndex := Ord(TabStyle);
    CheckListHintVisible.Checked := ListHintVisible;
    CheckTreeHintVisible.Checked := TreeHintVisible; 
    CheckDispLauncherExt.Checked := DispLauncherExt; 
    CheckDispItemAddInfo.Checked := DispItemAddInfo;
    //外観
    ColorBoxFormColor.Selected := FormColor;
    ColorBoxTreeColor.Selected := TreeColor;
    TmpTreeFont.Assign(TreeFont);
    ColorBoxListColor.Selected := ListColor;
    TmpListFont.Assign(ListFont);
    ColorBoxMemoColor.Selected := MemoColor;
    TmpMemoFont.Assign(MemoFont);
    ColorBoxHintColor.Selected := HintColor;
    //クリップボード
    SpinEditMaxClipHistory.Value := MaxClipHistory; 
    CheckUseClipItemToTop.Checked := UseClipItemToTop;  
    //検索
    CheckSearchDispDir.Checked := SearchDispDir;   
    //日時形式
    EditDateFmt.Text := DateFmt;
    EditTimeFmt.Text := TimeFmt;
    EditDateTimeFmt.Text := DateTimeFmt;
    EditListDateTimeFmt.Text := ListDateTimeFmt;   
    //バックアップ
    CheckAutoBacup.Checked := AutoBacup;
    RadioGroupBackupMode.ItemIndex := Integer(BackupMode);
    EditBackupDir.Text := BackupDir;    
    SpinEditLeaveBackupFiles.Value := LeaveBackupFiles;
    //確認・案内
    CheckConfDelDir.Checked := ConfDelDir;
    CheckConfDelItem.Checked := ConfDelItem; 
    CheckConfPasteXmlExport.Checked := ConfPasteXmlExport;  
    CheckConfDelDbShortcut.Checked := ConfDelDbShortcut;
    CheckConfDelDbHot.Checked := ConfDelDbHot;
    CheckConfDelDbMouse.Checked := ConfDelDbMouse;
    //呼び出しアクション
    TmpCallLastItem.Assign(CallLastItem);
    TmpCallAllSearchItem.Assign(CallAllSearchItem);
    TmpCallPasteItem.Assign(CallPasteItem);
    TmpCallLaunchItem.Assign(CallLaunchItem);
    TmpCallBkmkItem.Assign(CallBkmkItem);
    TmpCallClipItem.Assign(CallClipItem); 
    //パスワード
    TmpPassWord := Password;
    CheckIsPassword.Checked := IsPassWord;
  end;

end;

procedure TOption.SetAutoExpand(const Value: Boolean);
begin
  FAutoExpand := Value;
  with FormStancher do begin
    TreePaste.AutoExpand := Value;
    TreeLaunch.AutoExpand := Value;
    TreeBkmk.AutoExpand := Value;
    TreeClip.AutoExpand := Value;
  end;
end;

procedure TOption.SetBrowserPath(const Value: string);
begin
  FBrowserPath := Value;
end;

procedure TOption.SetEditorPath(const Value: string);
begin
  FEditorPath := Value;
end;

procedure TOption.SetFormColor(const Value: TColor);
//var r: TRect;
begin
  FFormColor := Value;         
  with FormStancher do begin
//    Color := Value;
  end;
end;

procedure TOption.SetListColor(const Value: TColor);
begin
  FListColor := Value;  
  with FormStancher do begin
    ListViewAllSearch.Color := Value;
    ListViewPaste.Color := Value;  
    MemoPasteText.Color := Value;
    ListViewLaunch.Color := Value;
    ListViewBkmk.Color := Value;
    ListViewClip.Color := Value;
    MemoClipText.Color := Value;
    ListViewAllSearch.SmallImages.BkColor := Value;
    ListViewAllSearch.LargeImages.BkColor := Value;
    ListViewPaste.SmallImages.BkColor := Value;
    ListViewPaste.LargeImages.BkColor := Value;
    ListViewLaunch.SmallImages.BkColor := Value;
    ListViewLaunch.LargeImages.BkColor := Value;
    ListViewBkmk.SmallImages.BkColor := Value;
    ListViewBkmk.LargeImages.BkColor := Value;
    ListViewClip.SmallImages.BkColor := Value;
    ListViewClip.LargeImages.BkColor := Value;
  end;
end;

procedure TOption.SetListFont(const Value: TFont);
begin
  FListFont.Assign(Value);
  with FormStancher do begin
    ListViewAllSearch.Font.Assign(Value);
    ListViewPaste.Font.Assign(Value);
    ListViewLaunch.Font.Assign(Value);
    ListViewBkmk.Font.Assign(Value);
    ListViewClip.Font.Assign(Value);
//    MemoClipText.Font.Assign(Value);
//    MemoPasteText.Font.Assign(Value);
  end;
end;

procedure TOption.SetTabPosition(const Value: TTabPosition);
begin
  FTabPosition := Value;
  with FormStancher do begin
    if (TabStyle <> tsTabs) and (Value <> tpTop) then TabStyle := tsTabs;
//    PageControlMain.TabPosition := FTabPosition;
  end;
end;

procedure TOption.SetTreeColor(const Value: TColor);
begin
  FTreeColor := Value;  
  with FormStancher do begin
    TreePaste.Color := Value;
    TreeLaunch.Color := Value;
    TreeBkmk.Color := Value;
    TreeClip.Color := Value;
    TreePaste.Images.BkColor := Value;
    TreeLaunch.Images.BkColor := Value;
    TreeBkmk.Images.BkColor := Value;
    TreeClip.Images.BkColor := Value;
  end;
end;

procedure TOption.SetTreeFont(const Value: TFont);
begin
  FTreeFont.Assign(Value);
  with FormStancher do begin
    TreePaste.Font.Assign(Value);
    TreeLaunch.Font.Assign(Value);
    TreeBkmk.Font.Assign(Value);
    TreeClip.Font.Assign(Value);
  end;
end;

procedure TOption.SetUseBrowser(const Value: Boolean);
begin
  FUseBrowser := Value;
end;

procedure TOption.SetUseSound(const Value: Boolean);
begin
  FUseSound := Value;
end;

procedure TOption.SetSoundFile(const Value: string);
begin
  FSoundFile := Value;
end;

procedure TOption.SetHintColor(const Value: TColor);
begin
  FHintColor := Value;
  Application.HintColor := Value;
end;

procedure TOption.PlaySound;
begin
  ChDir(ExtractFilePath(Application.ExeName));
  if not UseSound or not FileExists(FSoundFile) then Exit;
  sndPlaySound(nil, SND_ASYNC);
  sndPlaySound(PChar(FSoundFile), SND_ASYNC);
end;

procedure TOption.SetMaxClipHistory(const Value: Integer);
begin
  FMaxClipHistory := Value;
end;

procedure TOption.SetListHintVisible(const Value: Boolean);
begin
  FListHintVisible := Value;
end;

procedure TOption.SetTreeHintVisible(const Value: Boolean);
begin
  FTreeHintVisible := Value;
end;

procedure TOption.SetHotTrack(const Value: Boolean);
begin
  FHotTrack := Value;
  with FormStancher do begin
     TreePaste.HotTrack := Value;
     TreeLaunch.HotTrack := Value;
     TreeBkmk.HotTrack := Value;
     TreeClip.HotTrack := Value;
     ListViewPaste.HotTrack := Value;
     ListViewLaunch.HotTrack := Value;
     ListViewBkmk.HotTrack := Value;
     ListViewClip.HotTrack := Value;
     ListViewAllSearch.HotTrack := Value;
  end;
end;

procedure TOption.SetUsePassword(const Value: Boolean);
begin
  FUsePassword := Value;
end;

procedure TOption.SetTabStyle(const Value: TTabStyle);
begin
  FTabStyle := Value;
  with FormStancher do begin      
    if (TabPosition <> tpTop) and (Value <> tsTabs) then TabPosition := tpTop;
    PageControlMain.Style := Value;
  end;
end;

procedure TOption.SetConfDelDir(const Value: Boolean);
begin
  FConfDelDir := Value;
end;

procedure TOption.SetConfDelItem(const Value: Boolean);
begin
  FConfDelItem := Value;
end;

procedure TOption.SetUseClipItemToTop(const Value: Boolean);
begin
  FUseClipItemToTop := Value;
end;

procedure TOption.SetDspPos(const Value: TDspPos);
begin
  FDspPos := Value;
end;

procedure TOption.SetTabSpaceCount(const Value: Integer);
begin
  FTabSpaceCount := Value;
end;

procedure TOption.SetLineTopList(const Value: TStringList);
begin
  FLineTopList.Assign(Value);
end;

procedure TOption.SetLineTopBottomList(const Value: TStringList);
begin
  FLineTopBottomList.Assign(Value);
end;

procedure TOption.SetMainMenus;
var i: Integer; mi: TMenuItem;
begin
  with FormStancher do begin
    MenuLineTops.Clear;
    for i := 0 to LineTopList.Count-1 do begin
      mi := TMenuItem.Create(FormStancher);
      mi.Caption := Format(LineTopList[i], [0]);
      mi.Hint := LineTopList[i];
      mi.OnClick := MenuLineTopItemClick;
      MenuLineTops.Add(mi);
    end;

    MenuLineTopBottoms.Clear;   
    for i := 0 to LineTopBottomList.Count-1 do begin
      mi := TMenuItem.Create(FormStancher);
      mi.Caption := StringReplace(LineTopBottomList[i], ',', #9, []);
      mi.Hint := LineTopBottomList[i];
      mi.OnClick := MenuLineTopBottomItemClick;
      MenuLineTopBottoms.Add(mi);
    end;
  end;
end;

procedure TOption.SetOneClickExcute(const Value: Boolean);
begin
  FOneClickExcute := Value;
  with FormStancher do begin
    if Value then begin
      ListViewAllSearch.OnClick := ListViewAllSearchDblClick;
      ListViewPaste.OnClick := ListViewPasteDblClick;
      ListViewLaunch.OnClick := ListViewPasteDblClick;
      ListViewBkmk.OnClick := ListViewPasteDblClick;
      ListViewClip.OnClick := ListViewPasteDblClick;
      ListViewAllSearch.OnDblClick := nil;
      ListViewPaste.OnDblClick := nil;
      ListViewLaunch.OnDblClick := nil;
      ListViewBkmk.OnDblClick := nil;
      ListViewClip.OnDblClick := nil;
    end else begin
      ListViewAllSearch.OnClick := nil;
      ListViewPaste.OnClick := ListViewPasteClick;
      ListViewLaunch.OnClick := ListViewPasteClick;
      ListViewBkmk.OnClick := ListViewPasteClick;
      ListViewClip.OnClick := ListViewPasteClick;
      ListViewAllSearch.OnDblClick := ListViewAllSearchDblClick;
      ListViewPaste.OnDblClick := ListViewPasteDblClick;
      ListViewLaunch.OnDblClick := ListViewPasteDblClick;
      ListViewBkmk.OnDblClick := ListViewPasteDblClick;
      ListViewClip.OnDblClick := ListViewPasteDblClick;
    end;
  end;
end;

procedure TOption.SetCallAllSearchItem(const Value: TCallTabItem);
begin
  FCallAllSearchItem.Assign(Value);
end;

procedure TOption.SetCallBkmkItem(const Value: TCallTabItem);
begin
  FCallBkmkItem.Assign(Value);
end;

procedure TOption.SetCallClipItem(const Value: TCallTabItem);
begin
  FCallClipItem.Assign(Value);
end;

procedure TOption.SetCallLastItem(const Value: TCallTabItem);
begin
  FCallLastItem.Assign(Value);
end;

procedure TOption.SetCallLaunchItem(const Value: TCallTabItem);
begin
  FCallLaunchItem.Assign(Value);
end;

procedure TOption.SetCallPasteItem(const Value: TCallTabItem);
begin
  FCallPasteItem.Assign(Value);
end;

procedure TOption.SetCallBackMargin(const Value: Integer);
begin
  FCallBackMargin := Value;
end;

procedure TOption.SetConfPasteXmlExport(const Value: Boolean);
begin
  FConfPasteXmlExport := Value;
end;

procedure TOption.SetIsClipToBkmkName(const Value: Boolean);
begin
  FIsClipToBkmkName := Value;
end;

procedure TOption.SetIsClipToDirName(const Value: Boolean);
begin
  FIsClipToDirName := Value;
end;

procedure TOption.SetIsClipToLauncherName(const Value: Boolean);
begin
  FIsClipToLauncherName := Value;
end;

procedure TOption.SetIsClipToPasteName(const Value: Boolean);
begin
  FIsClipToPasteName := Value;
end;

procedure TOption.SetIsClipToPasteTexs(const Value: Boolean);
begin
  FIsClipToPasteTexs := Value;
end;

procedure TOption.SetSearchDispDir(const Value: Boolean);
begin
  FSearchDispDir := Value;
end;

procedure TOption.SetConfDelDbHot(const Value: Boolean);
begin
  FConfDelDbHot := Value;
end;

procedure TOption.SetConfDelDbMouse(const Value: Boolean);
begin
  FConfDelDbMouse := Value;
end;

procedure TOption.SetConfDelDbShortcut(const Value: Boolean);
begin
  FConfDelDbShortcut := Value;
end;

procedure TOption.SetDateFmt(const Value: string);
begin
  FDateFmt := Value;
end;

procedure TOption.SetDateTimeFmt(const Value: string);
begin
  FDateTimeFmt := Value;
end;

procedure TOption.SetListDateTimeFmt(const Value: string);
begin
  FListDateTimeFmt := Value;
end;

procedure TOption.SetTimeFmt(const Value: string);
begin
  FTimeFmt := Value;
end;

procedure TOption.SetIsStartup(const Value: Boolean);
begin
  FIsStartup := Value;
  SetStartup(Value);
end;

procedure TOption.SetDispLauncherExt(const Value: Boolean);
begin
  FDispLauncherExt := Value;
end;

procedure TOption.SetAutoBacup(const Value: Boolean);
begin
  FAutoBacup := Value;
end;

procedure TOption.SetBackupDir(const Value: string);
begin
  FBackupDir := Value;
end;

procedure TOption.SetBackupMode(const Value: TBackupMode);
begin
  FBackupMode := Value;
end;

procedure TOption.SetLastBackupDate(const Value: TDateTime);
begin
  FLastBackupDate := Value;
end;

procedure TOption.SetLeaveBackupFiles(const Value: Integer);
begin
  FLeaveBackupFiles := Value;
end;

procedure TOption.SetCallMethod(const Value: TCallMethod);
begin
  FCallMethod := Value;
  FormStancher.TimerMouseCslRtn.Enabled := Value = cmMouseCsrPos;
end;

procedure TOption.SetMouseCslRtnPoses(const Value: TMouseCslRtnPoses);
begin
  FMouseCslRtnPoses := Value;
end;

procedure TOption.SetMouseCslRtnWidth(const Value: Integer);
begin
  FMouseCslRtnWidth := Value;
end;

procedure TOption.SetMouseCslRtnTime(const Value: Integer);
begin
  FMouseCslRtnTime := Value;
  FormStancher.TimerShowMouseCslRtn.Interval := Value;;
end;

procedure TOption.SetDispItemAddInfo(const Value: Boolean);
begin
  FDispItemAddInfo := Value;
end;

procedure TOption.SetMemoColor(const Value: TColor);
begin
  FMemoColor := Value;
  FormStancher.MemoPasteText.Color := Value;    
  FormStancher.MemoClipText.Color := Value;
end;

procedure TOption.SetMemoFont(const Value: TFont);
begin
  FMemoFont.Assign(Value);
  with FormStancher do begin
    MemoClipText.Font.Assign(Value);
    MemoPasteText.Font.Assign(Value);
  end;
end;

end.
