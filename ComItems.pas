unit ComItems;

interface

uses ComDef, SQLiteTable3, Classes, Graphics, Windows, Messages, ComCtrls,
  Dialogs, Controls, Clipbrd, ShellApi, Forms, Dbg, yhOthers, yhFiles, SkRegExpW;

type
  TMouseAction = ({maNone, }maLClk, maLDblClk, maRClk, maRDblClk,
                  maMClk, maMDblClk, maWheel, maMove);
  TMouseKey = (mkLBtn, mkMBtn, mkRBtn, mkCtrl, mkShift, mkAlt);
  TMouseKeys = set of TMouseKey;
  TMouseRtnPos = (mrpTaskBar, mrpDeskTop, mrpLT, mrpMT,
                  mrpRT, mrpRM, mrpRB, mrpMB, mrpLB, mrpLM);
  TMouseRtnPoses = set of TMouseRtnPos;
  TDspPos = (dpNone, dpMouseCursol, dpLR, dpTB);
  TSortMode = (smUser, smName, smCr, smUp, smAc, smUse, smRep, smParent, smComment, smVal);
  TPasteMode = (pmPaste, pmCopy, pmCarret, pmKeyMacro, pmLaunch, pmBrowse, pmScript);
  TShowCmd = (scShow, scMin, scMax);
  TItemEditMode = (iemDir, iemPaste, iemLaunch, iemBkmk, iemClip);

  TItemClass = class of TBoneItem;
  TIconItemClass = class of TIconItem;
  TCommonItemClass = class of TCommonItem;

  TBoneItem = class
    procedure ChackBaseError;
  private
    FDB: TSQLiteDatabase;
    FTable: TSQLiteTable;
    FID: Int64;
    FTableName,
    FColumnsStr,
    FValusStr,
    FAssignmentsStr: string;
    function Quo(s: string): string;
    procedure SetTable(const Value: TSQLiteTable);
//    function GetRow: Int64;
  protected
    procedure CreateSQLParts; virtual;
    procedure CreateItem; virtual;
    procedure SetID(const Value: Int64); virtual;
  public
    class function GetTableName: string; virtual; abstract;
    class function RecordCount(Filter: string = ''): Integer;   
    class function Select(Filter: string = ''): TSQLiteTable;
    constructor Create;
    procedure Assign(Source: TBoneItem); virtual;
    procedure Insert; virtual;
    procedure Update; virtual;
    procedure Delete; virtual;
    procedure SetFields(ATable: TSQLiteTable); virtual;
    function Locate(AID: Int64): Boolean;
    property ID: Int64 read FID;
    property TableName: string read FTableName;
    property Table: TSQLiteTable read FTable write SetTable;
//    property Row: Cardinal read GetRow;
  end;
                             
  TNameItem = class;
  TCommonItem = class;

  TTableParentItem = class(TBoneItem)
  private
    FParentID: Int64;
    FTableID: Int64; 
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;     
  public
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    property TableID: Int64 read FTableID write FTableID;
    property ParentID: Int64 read FParentID write FParentID;
  end;

  TTagItem = class(TTableParentItem)
  private
//    FParentID: Int64;
//    FTableID: Int64;
    FTag: string;
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
  public
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
//    property TableID: Int64 read FTableID write FTableID;
//    property ParentID: Int64 read FParentID write FParentID;
    property Tag: string read FTag write FTag;
  end;

  TKeyItem = class(TTableParentItem)
  private
    FKey: TShortCut;
//    FTableID: Byte;
//    FParentID: Int64;
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
  public                
    procedure Clear;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    procedure Insert; override;
    procedure Update; override;
//    property TableID: Byte read FTableID write FTableID;
//    property ParentID: Int64 read FParentID write FParentID;
    property Key: TShortCut read FKey write FKey;
  end;

  TMouseItem = class(TTableParentItem)
  private
    FKeyFlags: Integer;
    FAction: TMouseAction;
    FKeys: TMouseKeys;
    FRtnPoses: TMouseRtnPoses;
    FEnabled: Boolean;
//    FDspPos: TMouseDspPos;
    procedure SetKeyFlags(const Value: Integer);
    procedure SetKeys(const Value: TMouseKeys);
    procedure Reset;
    procedure SetEnabled(const Value: Boolean);
  protected 
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
  public                   
    class function GetTableName: string; override; 
    procedure Clear;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Action: TMouseAction read FAction write FAction;
    property KeyFlags: Integer read FKeyFlags write SetKeyFlags;
    property Keys: TMouseKeys read FKeys write SetKeys;
    property RtnPoses: TMouseRtnPoses read FRtnPoses write FRtnPoses;
//    property DspPos: TMouseDspPos read FDspPos write FDspPos;   
    procedure Insert; override;
    procedure Update; override;
  end;


  TShortcutKeyItem = class(TKeyItem)
  protected
    procedure CreateItem; override;
  public
    class function GetTableName: string; override;
  end;

  THotKeyItem = class(TKeyItem)
  private
    FGlobalHotkeyId: ATOM;
    FHotkeyError: Boolean;
  protected
    procedure CreateItem; override;
  public
    property GlobalHotkeyId: Word read FGlobalHotkeyId;
    class function GetTableName: string; override;
    destructor Destroy; override;
    procedure SetFields(ATable: TSQLiteTable); override;
    property HotkeyError: Boolean read FHotkeyError;
    function SetHotkey: Boolean;
  end;

  TBlobItem = class(TBoneItem)
  private
    FBlob: TMemoryStream;
  protected
    procedure CreateItem; override;  
    procedure CreateSQLParts; override;
    property Blob: TMemoryStream read FBlob;
    procedure UpdateBlob;
  public
    destructor Destroy; override;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    procedure Insert; override;
    procedure Update; override;
  end;

  TIconItem = class(TBlobItem)
  private
    FList: TList;
    FIcon: TIcon;
//    FIndex: Integer;
    procedure SetIcon(const Value: TIcon);
    procedure SetBlob;
    function GetIndex: Integer;
  protected
    procedure CreateItem; override;
  public
    constructor Create(Owner: TList);
    destructor Destroy; override;    
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    procedure Insert; override;
    procedure Update; override;
    property Icon: TIcon read FIcon write SetIcon;
    property Index: Integer read GetIndex;
  end;

  TDirIconItem = class(TIconItem)
  protected
    procedure CreateItem; override;
  public
    class function GetTableName: string; override;
  end;

  TClipIconItem = class(TIconItem) 
  protected
    procedure CreateItem; override;
  public
    class function GetTableName: string; override;
  end;

  TPasteIconItem = class(TIconItem)
  protected
    procedure CreateItem; override;  
  public
    class function GetTableName: string; override;
  end;

  TBkmkIconItem = class(TIconItem)
  protected
    procedure CreateItem; override;   
  public
    class function GetTableName: string; override;
  end;

  TLaunchIconItem = class(TIconItem)
  protected
    procedure CreateItem; override;  
  public
    class function GetTableName: string; override;
  end;

  TNameItem = class(TBoneItem)
  private
    FName: string;
  protected
    procedure CreateSQLParts; override; 
    procedure CreateItem; override;
  public
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    property Name: string read FName write FName;
  end;

  TTableItem = class(TNameItem)
  protected
    procedure CreateItem; override;
  end;
                
  TNameValueItem = class(TBoneItem)
  private
    FValue: string;
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
  public
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    property Value: string read FValue write FValue;
  end;

  TCommonItem = class(TNameItem)
  private
    FIsPassword: Boolean;
    FUseCount: Cardinal;
    FParentID,
    FIconID,
    FShortcutKeyID,
    FHotKeyID: Int64;
    FOrder: Integer;
    FComment: string;
    FCreateDate: TDateTime;
    FUpdateDate: TDateTime;
    FAccessDate: TDateTime;
//    FMouseAction: TMouseAction;
//    FMousePlace: TMousePlace;
//    FMouseDispPos: TMouseDispPos;
//    FMouseKeyFlags: Integer;
    FTags: TStrings;
    FParent: TTreeNode;
    FMouseKeys: TMouseKeys;
    FIconTableName: string;
    FShortcutKey,
    FHotKey: TKeyItem;
    FIconItem: TIconItem;
    FMyTableID: Integer;
    FIconList: TList;
    FMouseID: Int64;
    FMouse: TMouseItem;
    function GetRepetition: Real;
    procedure InsertTags;
    procedure SetIsPassword(const Value: Boolean);
    procedure SetParent(const Value: TTreeNode);
    procedure SetTags(const Value: TStrings);
//    procedure SetMouseKeys(const Value: TMouseKeys);
//    procedure SetMouseKeyFlags(const Value: Integer);
    procedure SetHotKeyID(const Value: Int64);
    procedure SetShortcutKeyID(const Value: Int64);
    procedure SetItems;
    function FindIconItem(ID: Int64): TIconItem;
    procedure SetMouseID(const Value: Int64);
    procedure GetTags;
//    procedure SetMouseKeyFlags(const Value: Integer);
//    procedure SetMouseKeys(const Value: TMouseKeys);
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
    procedure SetIconItem(const Value: TIconItem); virtual;
    procedure SetIconID(const Value: Int64); virtual;
//    property MouseKeyFlags: Integer read FMouseKeyFlags write SetMouseKeyFlags;
    property ShortcutKeyID: Int64 read FShortcutKeyID write SetShortcutKeyID;
    property HotKeyID: Int64 read FHotKeyID write SetHotKeyID;
    property IconTableName: string read FIconTableName;
    procedure SetID(const Value: Int64); override;
    property IconID: Int64 read FIconID write SetIconID;
    property MouseID: Int64 read FMouseID write SetMouseID;
  public
    constructor Create(AParent: TTreeNode); virtual;
    procedure ChengeParent(AParent: TTreeNode);
    destructor Destroy; override;
    procedure ClearAction;
    function ParentName: string;
    property MyTableID: Integer read FMyTableID write FMyTableID;
    property Parent: TTreeNode read FParent write SetParent;
    property CreateDate: TDateTime read FCreateDate write FCreateDate;
    property UpdateDate: TDateTime read FUpdateDate write FUpdateDate;
    property AccessDate: TDateTime read FAccessDate write FAccessDate;
    property UseCount: Cardinal read FUseCount write FUseCount;
    property Comment: string read FComment write FComment;
    property ParentID: Int64 read FParentID write FParentID;
    property IconItem: TIconItem read FIconItem write SetIconItem;
    property Order: Integer read FOrder write FOrder;
    property Tags: TStrings read FTags write SetTags;
    property Repetition: Real read GetRepetition;
    property IsPassword: Boolean read FIsPassword write SetIsPassword;
    property ShortcutKey: TKeyItem read FShortcutKey;
    property HotKey: TKeyItem read FHotKey;
    property Mouse: TMouseItem read FMouse;
//    property MouseAction: TMouseAction read FMouseAction write FMouseAction;
//    property MouseKeys: TMouseKeys read FMouseKeys write SetMouseKeys;
//    property MousePlace: TMousePlace read FMousePlace write FMousePlace;
//    property MouseDispPos: TMouseDispPos read FMouseDispPos write FMouseDispPos;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    function RepetitionStr: string;
    procedure Insert; override;
    procedure Update; override;
    procedure ClearUseCount;
    procedure IncUseCount;
    procedure Excute; virtual;
  end;

  TTextItem = class(TCommonItem)
  private
    FText: string;
    FMode: TPasteMode;
    procedure SendCarret;
    procedure SendClip;
    procedure SendKeyMacro;
    procedure OpenLines(s: string; IsUrl: Boolean);
    procedure SendLaunch;
    procedure SendBrowse;
  protected
    procedure SetMode(const Value: TPasteMode); virtual;
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
    procedure SendPaste; virtual;
  public
    property Text: string read FText write FText;
    property Mode: TPasteMode read FMode write SetMode;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    procedure Excute; override;
    procedure Pasete; virtual;
    procedure ToClip;
    procedure Insert; override;
  end;

  TPasteItem = class(TTextItem)
  private
    FAddKeys: string;
    procedure SetAddKeys(const Value: string);
  protected        
//    procedure SetMode(const Value: TPasteMode); override;
    procedure CreateItem; override;
    procedure CreateSQLParts; override;
    procedure SendPaste; override;
  public
    class function GetTableName: string; override;
    property AddKeys: string read FAddKeys write SetAddKeys; 
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
  end;

  TClipItem = class(TTextItem)
  protected
    procedure SetMode(const Value: TPasteMode); override;
    procedure CreateItem; override;
  public
    class function GetTableName: string; override;
  end;

  TIconHaveItem = class(TCommonItem)
  private
//    FIconIndex: Integer;
//    FIconPath: string;
  protected 
//    procedure CreateSQLParts; override;
    procedure SetIconItem(const Value: TIconItem); override;
    procedure SetIconID(const Value: Int64); override;
  public
//    procedure Assign(Source: TBoneItem); override;
//    procedure SetFields(ATable: TSQLiteTable); override;
//    property IconPath: string read FIconPath write FIconPath;
//    property IconIndex: Integer read FIconIndex write FIconIndex;
  end;


  TBkmkItem = class(TIconHaveItem)
  private
    FUrl: string;
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
  public
    destructor Destroy; override;
    class function GetTableName: string; override;
    property Url: string read FUrl write FUrl;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    procedure Excute; override;  
    procedure Insert; override;
  end;

  TLaunchItem = class(TIconHaveItem)
  private
    FParams: string;
    FDir: string;
    FFileName: string;
    FShowCmd: TShowCmd;
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
//    procedure SetIconID(const Value: Int64); override;
  public      
    destructor Destroy; override;
    class function GetTableName: string; override;
    property FileName: string read FFileName write FFileName;
    property Params: string read FParams write FParams;
    property Dir: string read FDir write FDir;
    property ShowCmd: TShowCmd read FShowCmd write FShowCmd;
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    procedure Excute; override;  
    procedure Insert; override;
  end;

  TDirItem = class(TCommonItem)
  private
    FTableID: Byte;
    FSortMode: TSortMode;
    FViewStyle: TViewStyle;
    FNode: TTreeNode;
    FSortOrdAsc: Boolean;
    procedure RecursionSQL(ParentID: Int64; SQL: string);
//    procedure SetTableID(const Value: Byte);
  protected
    procedure CreateSQLParts; override;
    procedure CreateItem; override;
  public
    procedure Assign(Source: TBoneItem); override;
    procedure SetFields(ATable: TSQLiteTable); override;
    class function GetTableName: string; override;
    procedure UpdateAllLowerDir;
    procedure Delete; override;
    property TableID: Byte read FTableID write FTableID;
    property ViewStyle: TViewStyle read FViewStyle write FViewStyle;
    property SortMode: TSortMode read FSortMode write FSortMode;   
    property SortOrdAsc: Boolean read FSortOrdAsc write FSortOrdAsc;
    property Node: TTreeNode read FNode write FNode; 
    procedure Insert; override;
  end;

  TCallTabItem = class(TObject)
  private
    FHotkey: THotKeyItem;
    FMouse: TMouseItem;
    FShortCutkey: TShortcutKeyItem;
    FID: Int64;
    procedure SetHotkey(const Value: THotKeyItem);
    procedure SetMouse(const Value: TMouseItem);
    procedure SetShortCutkey(const Value: TShortcutKeyItem);
    procedure SetID(const Value: Int64);
  public
    constructor Cleate;
    destructor Destroy; override;
    procedure LoadData;
    procedure SaveData;            
    procedure Assign(Source: TCallTabItem); 
    property ID: Int64 read FID write SetID;
    property ShortCutkey: TShortcutKeyItem read FShortCutkey write SetShortCutkey;
    property Hotkey: THotKeyItem read FHotkey write SetHotkey;
    property Mouse: TMouseItem read FMouse write SetMouse;
  end;


  TIconList = class(TList)
  private
    FBkColor: TColor;
    FImagesL: TImageList;
    FImagesS: TImageList;
    procedure SetBkColor(const Value: TColor);

  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReplaceItem(Index: Integer; Image: TIcon);
    procedure Clear; //override;
    function AddItem(Item: Pointer): Integer;
    procedure DeleteItem(Index: Integer);
    property ImagesS: TImageList read FImagesS write FImagesS;
    property ImagesL: TImageList read FImagesL write FImagesL;
    property BkColor: TColor read FBkColor write SetBkColor;
  published

  end;

  TCallAction = class
  private
    FHotKeyItem: THotKeyItem;
    FMouseItem: TMouseItem;
    FShortcutKeyItem: TShortcutKeyItem;
    procedure SetHotKeyItem(const Value: THotKeyItem);
    procedure SetMouseItem(const Value: TMouseItem);
    procedure SetShortcutKeyItem(const Value: TShortcutKeyItem);
  public
    constructor Create;
    destructor Destroy; override;
    property ShortcutKeyItem: TShortcutKeyItem read FShortcutKeyItem write SetShortcutKeyItem;
    property HotKeyItem: THotKeyItem read FHotKeyItem write SetHotKeyItem;
    property MouseItem: TMouseItem read FMouseItem write SetMouseItem;
  end;

  
  procedure SetIcons(Cls: TIconItemClass; AList: TIconList);

var
  DirIcons, PasteIcons, ClipIcons, BkmkIcons, LaunchIcons: TIconList;

implementation

uses SysUtils, Helper;

{ TBoneItem }

constructor TBoneItem.Create;
begin
  CreateItem;
end;

procedure TBoneItem.Delete;
begin
//  ChackBaseError;
  FDB.ExecSQL('DELETE FROM ' + TableName +
    ' WHERE ' + CN_ID + ' = ' +  Quo(IntToStr(FID)) + ';');
end;

procedure TBoneItem.Insert;
begin
//  ChackBaseError;
  CreateSQLParts;
//  p('INSERT INTO ' + TableName +
//    ' (' + FColumnsStr + ') VALUES (' + FValusStr + ')' + ';');
  FDB.ExecSQL('INSERT INTO ' + TableName +
    ' (' + FColumnsStr + ') VALUES (' + FValusStr + ')' + ';');
  SetID(FDB.GetLastInsertRowID);
end;

procedure TBoneItem.CreateSQLParts;
begin
  FColumnsStr := '';
  FValusStr := '';
  FAssignmentsStr := '';
end;

procedure TBoneItem.SetFields(ATable: TSQLiteTable);
begin
  FTable := ATable;
  with FTable do SetID(FieldAsInteger(FieldIndex[CN_ID]));
end;

procedure TBoneItem.SetTable(const Value: TSQLiteTable);
begin
  SetFields(Value);
end;

function TBoneItem.Quo(s: string): string;
begin
  Result := AnsiQuotedStr(s, '''');
end;

procedure TBoneItem.Update;
begin
//  ChackBaseError;
  CreateSQLParts;
  FDB.ExecSQL('UPDATE ' + TableName + ' SET ' + FAssignmentsStr +
  ' WHERE ' + CN_ID + ' = ' + Quo(IntToStr(FID)) + ';');
end;

procedure TBoneItem.Assign(Source: TBoneItem);
begin
  FID := Source.ID;
//  FTableName := Source.TableName;
end;

procedure TBoneItem.ChackBaseError;
begin
  if Self is TBoneItem then raise Exception.Create('基底アイテムでは実行できない手続きです。');
end;

procedure TBoneItem.CreateItem;
begin
  FDB := SQLiteDB;
  FID := 0;
end;

function TBoneItem.Locate(AID: Int64): Boolean;
var tb: TSQLiteTable;
begin
  Result := False;
  if Self.RecordCount(CN_ID + ' = ' + IntToStr(AID)) = 0 then Exit;
  tb := FDB.GetTable('SELECT * FROM ' + FTableName +
                     ' WHERE ' + CN_ID + ' = ' + IntToStr(AID));
  try
    if tb.RowCount = 0 then raise Exception.Create('指定ＩＤのデータは存在しません。');
    SetFields(tb);
    Result := True;
  finally
    tb.Free;
  end;
end;

procedure TBoneItem.SetID(const Value: Int64);
begin
  FID := Value;
end;

class function TBoneItem.RecordCount(Filter: string = ''): Integer;
var tb: TSQLiteTable; sWhere: string;
begin
//  Result := -1;
  sWhere := '';
  if Filter <> '' then sWhere := ' WHERE ' + Filter;
  tb := SQLiteDB.GetTable('SELECT COUNT(*) FROM ' + GetTableName + sWhere);
//DOut('SELECT COUNT(*) FROM ' + GetTableName + sWhere + ';');
  try
    Result := tb.CountResult;
  finally
    tb.Free;
  end;
end;

class function TBoneItem.Select(Filter: string): TSQLiteTable;
var sWhere: string;
begin                              
  sWhere := '';
  if Filter <> '' then sWhere := ' WHERE ' + Filter;
  Result := SQLiteDB.GetTable('SELECT * FROM ' + GetTableName  + sWhere + ';');
//  DOut('SELECT * FROM ' + GetTableName  + sWhere + ';');
end;

{ TTableParentItem }

procedure TTableParentItem.Assign(Source: TBoneItem);
var ti: TTableParentItem;
begin
  inherited;
  ti := TTableParentItem(TBoneItem);
  FTableID := ti.TableID;
  FParentID := ti.ParentID;
end;

procedure TTableParentItem.CreateItem;
begin
  inherited;
  FTableID := 0;
  FParentID := 0;
end;

procedure TTableParentItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + CN_TABLE_ID + ',' + CN_PARENT_ID;
  FValusStr := FValusStr + IntToStr(TableID) + ',' +
    IntToStr(ParentID);
  FAssignmentsStr := FAssignmentsStr +
    CN_TABLE_ID +  ' = ' + IntToStr(TableID) + ',' +
    CN_PARENT_ID + ' = ' + IntToStr(ParentID);
end;

procedure TTableParentItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    FTableID := FieldAsInteger(FieldIndex[CN_TABLE_ID]);
    FParentID := FieldAsInteger(FieldIndex[CN_PARENT_ID]);
  end;
end;

{ TTagItem }

procedure TTagItem.Assign(Source: TBoneItem);
var ti: TTagItem;
begin
  inherited;
  ti := TTagItem(TBoneItem);
  FTag := ti.Tag;
end;

procedure TTagItem.CreateSQLParts;
begin
  inherited;
//  FColumnsStr := FColumnsStr + ',' +  CN_TAG;
//  FValusStr := FValusStr + ',' +  Quo(Tag);
//  FAssignmentsStr := FAssignmentsStr + ',' + CN_TAG +       ' = ' + Quo(Tag);
end;

procedure TTagItem.CreateItem;
begin
  inherited;
  FTableName := TB_TAGS;
  FTag := '';
end;

procedure TTagItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
//    FTag := FieldByName[CN_TAG];
  end;
end;

{ TKeyItem }

procedure TKeyItem.Assign(Source: TBoneItem);
begin
  inherited;
  FKey := (Source as TKeyItem).Key;
end;

procedure TKeyItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_KEY;
  FValusStr := FValusStr + ',' + IntToStr(Key);
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_KEY +  ' = ' + IntToStr(FKey);
end;

procedure TKeyItem.CreateItem;
begin
  inherited;
  FKey := 0;
end;

procedure TKeyItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    FKey := FieldAsInteger(FieldIndex[CN_KEY]);
  end;
end;

//procedure TKeyItem.Insert;
//begin
//  inherited;
////  if FKey <> 0 then
////    inherited;
//end;
//
//procedure TKeyItem.Update;
//begin
//  inherited;
////  if FKey <> 0 then begin
////    if FID = 0 then Insert
////    else inherited;
////  end else Delete;
//end;

procedure TKeyItem.Insert;
begin
  if FTableID <> 5 then inherited; //クリップボードアイテムじゃないとき
//  if FID = 0 then raise Exception.Create('KeyItem.ID Error');
end;

procedure TKeyItem.Update;
begin
  if FTableID <> 5 then inherited; //クリップボードアイテムじゃないとき
//  if FID = 0 then raise Exception.Create('KeyItem.ID Error');
end;

procedure TKeyItem.Clear;
begin
  Key := 0;
end;

{ TMouseItem }

procedure TMouseItem.Assign(Source: TBoneItem);
var mi: TMouseItem;
begin
  inherited;
  mi := TMouseItem(Source);
  FEnabled  := mi.Enabled;
  FAction   := mi.Action;
  FKeyFlags := mi.KeyFlags;
  FKeys     := mi.Keys;
  FRtnPoses   := mi.RtnPoses;
//  FDspPos   := mi.DspPos;
end;

procedure TMouseItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
  Reset;
end;

procedure TMouseItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_ENABLED + ',' + CN_ACTION + ',' +
    CN_KEY_FLAGS + ',' + CN_RTN_POSES{ + ',' + CN_DSP_POS};
  FValusStr := FValusStr + ',' + IntToStr(Integer(FEnabled)) + ',' +IntToStr(Integer(FAction)) + ',' +
    IntToStr(FKeyFlags) + ',' + IntToStr(Word(FRtnPoses)){ + ',' + IntToStr(Integer(FDspPos))};
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_ENABLED +  ' = ' + IntToStr(Integer(FEnabled)) + ',' +
    CN_ACTION +  ' = ' + IntToStr(Integer(FAction)) + ',' +
    CN_KEY_FLAGS +  ' = ' + IntToStr(FKeyFlags) + ',' +
    CN_RTN_POSES +  ' = ' + IntToStr(Word(FRtnPoses)){ + ',' +
    CN_DSP_POS +  ' = ' + IntToStr(Integer(FDspPos))};
end;

class function TMouseItem.GetTableName: string;
begin
  Result := TB_MOUSE_ITEMS;
end;

procedure TMouseItem.Reset;
begin
  FEnabled := False;
  FAction := maLClk;
  FKeyFlags := 0;
  FRtnPoses := [];
//  FDspPos := mdpMouseCursol;
  FKeys := [];
end;

procedure TMouseItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    Action := TMouseAction(FieldAsInteger(FieldIndex[CN_ACTION]));
    KeyFlags := FieldAsInteger(FieldIndex[CN_KEY_FLAGS]);
    RtnPoses := TMouseRtnPoses(Word(FieldAsInteger(FieldIndex[CN_RTN_POSES])));
//    DspPos := TMouseDspPos(FieldAsInteger(FieldIndex[CN_DSP_POS]));
    Enabled := Boolean(FieldAsInteger(FieldIndex[CN_ENABLED]));
  end;
end;

procedure TMouseItem.SetKeyFlags(const Value: Integer);
begin
  FKeyFlags := Value;
  FKeys := [];
  if (FKeyFlags and MK_LBUTTON) > 0 then FKeys := FKeys + [mkLBtn];
  if (FKeyFlags and MK_MBUTTON) > 0 then FKeys := FKeys + [mkMBtn];
  if (FKeyFlags and MK_RBUTTON) > 0 then FKeys := FKeys + [mkRBtn];
  if (FKeyFlags and MK_CONTROL) > 0 then FKeys := FKeys + [mkCtrl];
  if (FKeyFlags and MK_SHIFT)   > 0 then FKeys := FKeys + [mkShift]; 
  if (FKeyFlags and MK_ALT)     > 0 then FKeys := FKeys + [mkAlt];
end;

procedure TMouseItem.SetKeys(const Value: TMouseKeys);
begin
  FKeys := Value;
  FKeyFlags := 0;
  if mkLBtn in FKeys then FKeyFlags := FKeyFlags or MK_LBUTTON;
  if mkMBtn in FKeys then FKeyFlags := FKeyFlags or MK_MBUTTON;
  if mkRBtn in FKeys then FKeyFlags := FKeyFlags or MK_RBUTTON;
  if mkCtrl in FKeys then FKeyFlags := FKeyFlags or MK_CONTROL;
  if mkShift in FKeys then FKeyFlags := FKeyFlags or MK_SHIFT;
  if mkAlt  in FKeys then FKeyFlags := FKeyFlags or MK_ALT;
end;

procedure TMouseItem.Insert;
begin
  if FTableID <> 5 then inherited; //クリップボードアイテムじゃないとき
//  if FID = 0 then raise Exception.Create('MouseItem.ID Error');
end;

procedure TMouseItem.Update;
begin
  if FTableID <> 5 then inherited; //クリップボードアイテムじゃないとき 
//  if FID = 0 then raise Exception.Create('MouseItem.ID Error');
end;

procedure TMouseItem.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  if not Value then begin
    FAction := maLClk;
    FKeyFlags := 0;
    FKeys := [];
    FRtnPoses := [];
  end;
end;

procedure TMouseItem.Clear;
begin
  Enabled := False;
  Action := maLClk;
  KeyFlags := 0;
  Keys := [];
  RtnPoses := [];
end;

{ TBlobItem }

procedure TBlobItem.Assign(Source: TBoneItem);
begin
  inherited;
  FBlob.LoadFromStream(TBlobItem(Source).Blob);
end;

destructor TBlobItem.Destroy;
begin
  FBlob.Free;
  inherited;
end;

procedure TBlobItem.CreateItem;
begin
  inherited;
  FBlob := TMemoryStream.Create;
end;

procedure TBlobItem.Insert;
begin
  inherited;
  UpdateBlob;
end;

procedure TBlobItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do
    FBlob.LoadFromStream(FieldAsBlob(FieldIndex[CN_BLOB]));
//    FBlob := FieldAsBlob(FieldIndex[CN_BLOB]);
  FBlob.Position := 0;
end;

procedure TBlobItem.Update;
begin
  inherited;
  UpdateBlob;
end;

procedure TBlobItem.UpdateBlob;
begin
  FDB.UpdateBlob('UPDATE ' + TableName + ' SET ' + CN_BLOB + ' = ?' +
    ' WHERE ' + CN_ID + ' = ' + IntToStr(FID), FBlob);
end;

procedure TBlobItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + CN_BLOB;
  FValusStr := FValusStr + 'NULL';
  FAssignmentsStr := FAssignmentsStr +
    CN_BLOB +  ' = NULL';
end;

{ TIconItem }

destructor TIconItem.Destroy;
begin
  FIcon.Free;
  inherited;
end;

procedure TIconItem.CreateItem;
begin
  inherited;
//  FIndex := 0;
  FIcon := TIcon.Create;
end;

procedure TIconItem.SetIcon(const Value: TIcon);
begin
  FIcon.Assign(Value);
end;

procedure TIconItem.Assign(Source: TBoneItem);
begin
  inherited;
  FIcon.Assign((Source as TIconItem).Icon);
//  FIndex := (Source as TIconItem).Index;
end;

procedure TIconItem.Insert;
begin
  SetBlob;
  inherited;
  FBlob.Clear; 
//  pi(FDB.GetLastInsertRowID);
end;

procedure TIconItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  FIcon.LoadFromStream(FBlob);
  FBlob.Clear;
end;

procedure TIconItem.Update;
begin
  SetBlob;
  inherited;
  FBlob.Clear;
end;

procedure TIconItem.SetBlob;
begin
//  FBlob.Position := 0;
  FIcon.SaveToStream(FBlob);
end;

constructor TIconItem.Create(Owner: TList);
begin
  CreateItem;
  FList := Owner;
end;

function TIconItem.GetIndex: Integer;
//var i: Integer;
begin
  Result := FList.IndexOf(Self);
//  for i := 0 to FList.Count-1 do begin
//    if FID = TIconItem(FList[i]).ID then begin
//      Result := i;
//      Exit;
//    end;
//  end;
end;

{ TShortcutKeyItem }

procedure TShortcutKeyItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
end;

class function TShortcutKeyItem.GetTableName: string;
begin
  Result := TB_SHORTCUT_KEYS;
end;

{ THotKeyItem }

procedure THotKeyItem.CreateItem;
begin
  inherited;        
  FHotkeyError := False;
  FTableName := GetTableName;
  FGlobalHotkeyId := GlobalAddAtom(PChar('Hotkey' + IntToStr(FID)));
end;

destructor THotKeyItem.Destroy;
begin
  UnregisterHotKey(Application.Handle, FGlobalHotkeyId);
  GlobalDeleteAtom(FGlobalHotkeyId);
  inherited;
end;

class function THotKeyItem.GetTableName: string;
begin
  Result := TB_HOT_KEYS;
end;

procedure THotKeyItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  SetHotkey;
end;

function THotKeyItem.SetHotkey: Boolean;
var res: Boolean; md, vk: Cardinal;
begin
  res := False;
  if FKey <> 0 then begin
    GetHotKeyFromShortCut(FKey, md, vk);
    res := RegisterHotKey(Application.Handle, FGlobalHotkeyId, md, vk);
  end else begin
    UnregisterHotKey(Application.Handle, FGlobalHotkeyId);
  end;
  FHotkeyError := not res;
  Result := res;
end;

{ TDirIconItem }

procedure TDirIconItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
end;

class function TDirIconItem.GetTableName: string;
begin
  Result := TB_DIR_ICONS;
end;

{ TClipIconItem }

procedure TClipIconItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
end;

class function TClipIconItem.GetTableName: string;
begin
  Result := TB_CLIP_ICONS;
end;

{ TPasteIconItem }

procedure TPasteIconItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
end;

class function TPasteIconItem.GetTableName: string;
begin
  Result := TB_PASTE_ICONS;
end;

{ TBkmkIconItem }

procedure TBkmkIconItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
end;

class function TBkmkIconItem.GetTableName: string;
begin
  Result := TB_BKMK_ICONS;
end;

{ TLaunchIconItem }

procedure TLaunchIconItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
end;

class function TLaunchIconItem.GetTableName: string;
begin
  Result := TB_LAUNCH_ICONS;
end;

{ TNameItem }

procedure TNameItem.Assign(Source: TBoneItem);
begin
  inherited;
  FName := (Source as TNameItem).Name;
end;

procedure TNameItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + CN_NAME;
  FValusStr := FValusStr + Quo(Name);
  FAssignmentsStr := FAssignmentsStr +
    CN_NAME + ' = ' + Quo(FName);
end;

procedure TNameItem.CreateItem;
begin
  inherited;
  FName := '';
end;

procedure TNameItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  FName := FTable.FieldByName[CN_NAME];
end;

{ TTableItem }

procedure TTableItem.CreateItem;
begin
  inherited;
  FTableName := TB_TABLES;
end;

{ TNameValueItem }

procedure TNameValueItem.Assign(Source: TBoneItem);
begin
  inherited;
  FValue := (Source as TNameValueItem).Value;
end;

procedure TNameValueItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_VALUE;
  FValusStr := FValusStr + ',' + Quo(Value);
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_VALUE + ' = ' + Quo(Value);
end;

procedure TNameValueItem.CreateItem;
begin
  inherited;
  FValue := '';
end;

procedure TNameValueItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  FValue := FTable.FieldByName[CN_VALUE];
end;

{ TCommonItem }

constructor TCommonItem.Create(AParent: TTreeNode);
begin
  //オブジェクトの作成はCreateItemで
  CreateItem;
  Parent := AParent;
end;

destructor TCommonItem.Destroy;
begin
  FTags.Free;
  FShortcutKey.Free;
  FHotKey.Free;
  FMouse.Free;
  inherited;
end;

procedure TCommonItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_CREATE_DATE + ',' +
  CN_UPDATE_DATE + ',' + CN_ACCESS_DATE + ',' + CN_USE_COUNT + ',' +
  CN_COMMENT + ',' + CN_TAGS + ',' + CN_ICON_ID + ',' + CN_PARENT_ID + ',' +
  CN_ORDER + ',' + CN_IS_PASSWORD + ',' + CN_SHORTCUT_KEY_ID + ',' +
  CN_HOT_KEY_ID + ',' +CN_MOUSE_ID;
  FValusStr := FValusStr + ',' + FloatToStr(FCreateDate) + ',' +
  FloatToStr(FUpdateDate) + ',' + FloatToStr(FAccessDate) + ',' +  IntToStr(FUseCount) + ',' +
  Quo(FComment) + ',' + Quo(FTags.CommaText) + ',' + IntToStr(FIconID) + ',' +  IntToStr(FParentID) + ',' +
  IntToStr(FOrder) + ',' + IntToStr(Integer(FIsPassword)) + ',' + IntToStr(FShortcutKeyID) + ',' +
  IntToStr(FHotKeyID) + ',' +IntToStr(FMouseID);
    FAssignmentsStr := FAssignmentsStr + ',' +
    CN_CREATE_DATE + ' = ' + FloatToStr(FCreateDate) + ',' +
    CN_UPDATE_DATE + ' = ' + FloatToStr(FUpdateDate) + ',' +
    CN_ACCESS_DATE + ' = ' + FloatToStr(FAccessDate) + ',' +
    CN_USE_COUNT   + ' = ' + IntToStr(FUseCount) + ',' +
    CN_COMMENT     + ' = ' + Quo(FComment) + ',' +
    CN_TAGS         + ' = ' + Quo(FTags.CommaText) + ',' +
    CN_ICON_ID     + ' = ' + IntToStr(FIconID) + ',' +
    CN_PARENT_ID   + ' = ' + IntToStr(FParentID) + ',' +
    CN_ORDER       + ' = ' + IntToStr(FOrder) + ',' +
    CN_SHORTCUT_KEY_ID + ' = ' + IntToStr(FShortcutKeyID) + ',' +
    CN_HOT_KEY_ID      + ' = ' + IntToStr(FHotKeyID) + ',' +
    CN_IS_PASSWORD     + ' = ' + IntToStr(Integer(FIsPassword)) + ',' +
    CN_MOUSE_ID    + ' = ' + IntToStr(FMouseID);
end;

function TCommonItem.GetRepetition: Real;
var d: Double;
begin
  Result := 0;
  d := Double(Now) - Double(CreateDate);
  if d < 0.01 then d := 0.01;
  if UseCount = 0 then Exit;
  Result := UseCount / d;
  if Result > 100 then Result := 100;
end;

procedure TCommonItem.CreateItem;
begin
  inherited;
  FCreateDate := Now;
  FUpdateDate := Now;
  FAccessDate := Now;
  FUseCount := 0;
  FComment := '';
  FIconID := 0;
  FParentID := 0;
  FOrder := MAXLONG;
  FShortcutKeyID := 0;
  FHotKeyID := 0;
  FIsPassword := False;
  FMouseID := 0;
//  FMouseAction := maNone;
//  FMousePlace := mpNone;
//  FMouseDispPos := mdpNone;
//  FMouseKeyFlags := 0;
  FMouseKeys := [];
  FTags := TStringList.Create;
  FShortcutKey := TShortcutKeyItem.Create;
  FShortcutKey.TableID := FMyTableID;
  FShortcutKey.ParentID := FID;
  FHotKey := THotKeyItem.Create;
  FHotKey.TableID := FMyTableID;
  FHotKey.ParentID := FID;
  FMouse := TMouseItem.Create;
  FMouse.TableID := FMyTableID;
  FMouse.ParentID := FID;
end;

procedure TCommonItem.Assign(Source: TBoneItem);
var ci: TCommonItem;
begin
  inherited;
  ci := TCommonItem(Source);
  FCreateDate := ci.CreateDate;
  FUpdateDate := ci.UpdateDate;
  FAccessDate := ci.AccessDate;     
  FUseCount := ci.UseCount;
  FComment := ci.Comment;
  IconID := ci.IconID;
  FIconItem := ci.IconItem;
  FParentID := ci.ParentID;
  FParent := (ci.Parent);
  FOrder := ci.Order;
  FShortcutKeyID := ci.ShortcutKeyID;
  FShortcutKey.Assign(ci.ShortcutKey);
  FHotKeyID := ci.HotKeyID;
  FHotKey.Assign(ci.HotKey);
  FIsPassword := ci.IsPassword;
  FMouseID := ci.MouseID;
  FMouse.Assign(ci.Mouse);
  FTags.Assign(ci.Tags);
//  FMyTableID := ci.MyTableID;
//  FIconTableName := ci.IconTableName;
end;

procedure TCommonItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    FCreateDate := FieldAsDouble(FieldIndex[CN_CREATE_DATE]);
    FUpdateDate := FieldAsDouble(FieldIndex[CN_UPDATE_DATE]);
    FAccessDate := FieldAsDouble(FieldIndex[CN_ACCESS_DATE]);
    FUseCount   := FieldAsInteger(FieldIndex[CN_USE_COUNT]);
    Comment    := FieldByName[CN_COMMENT];
    IconID     := FieldAsInteger(FieldIndex[CN_ICON_ID]);
    ParentID   := FieldAsInteger(FieldIndex[CN_PARENT_ID]);
    Order      := FieldAsInteger(FieldIndex[CN_ORDER]);
    ShortcutKeyID := FieldAsInteger(FieldIndex[CN_SHORTCUT_KEY_ID]);
    HotKeyID      := FieldAsInteger(FieldIndex[CN_HOT_KEY_ID]);
    IsPassword    := Boolean(FieldAsInteger(FieldIndex[CN_IS_PASSWORD]));
    MouseID       := FieldAsInteger(FieldIndex[CN_MOUSE_ID]);
    Tags.CommaText := FieldByName[CN_TAGS];
//    MouseAction   := TMouseAction(FieldAsInteger(FieldIndex[CN_MOUSE_ACTION]));
//    MousePlace    := TMousePlace(FieldAsInteger(FieldIndex[CN_MOUSE_PLACE]));
//    MouseDispPos  := TMouseDispPos(FieldAsInteger(FieldIndex[CN_MOUSE_DISP_POS]));
//    MouseKeyFlags := FieldAsInteger(FieldIndex[CN_MOUSE_KEY_FLAGS]);
//    GetTags;
  end;
end;

procedure TCommonItem.Insert;
begin
  SetItems;
  FShortcutKey.Insert;
  FHotKey.Insert;
  FMouse.Insert;
  FShortcutKeyID := FShortcutKey.ID;
  FHotKeyID := FHotKey.ID;
  FMouseID := FMouse.ID;
//  FIconID := FIconItem.ID;
//  FIconItem.Update;
  inherited;
  SetItems;
  FShortcutKey.Update;
  FHotKey.Update;
  FMouse.Update;
  InsertTags;
end;

procedure TCommonItem.Update;
begin         
//  FUpdateDate := Now;
//  FAccessDate := Now;
  SetItems;
  FShortcutKey.Update;
  FHotKey.Update;
  FMouse.Update;
  FIconItem.Update;
  InsertTags;
  inherited;
end;

procedure TCommonItem.SetIsPassword(const Value: Boolean);
begin
  FIsPassword := Value;// {$MESSAGE 'SetIsPassword'}
end;

procedure TCommonItem.SetParent(const Value: TTreeNode);
begin
  FParent := Value;
  if FParent = nil then FParentID := 0
  else FParentID := TBoneItem(FParent.Data).ID;
end;

procedure TCommonItem.SetTags(const Value: TStrings);
begin
  FTags.Assign(Value);
end;

//procedure TCommonItem.SetMouseKeys(const Value: TMouseKeys);
//begin
//  FMouseKeys := Value;
//  if mkLBtn in FMouseKeys then FMouseKeyFlags := FMouseKeyFlags or MK_LBUTTON;
//  if mkMBtn in FMouseKeys then FMouseKeyFlags := FMouseKeyFlags or MK_MBUTTON;
//  if mkRBtn in FMouseKeys then FMouseKeyFlags := FMouseKeyFlags or MK_RBUTTON;
//  if mkCtrl in FMouseKeys then FMouseKeyFlags := FMouseKeyFlags or MK_CONTROL;
//  if mkShift in FMouseKeys then FMouseKeyFlags := FMouseKeyFlags or MK_SHIFT;
//end;
//
//procedure TCommonItem.SetMouseKeyFlags(const Value: Integer);
//begin
//  FMouseKeyFlags := Value;
//  if (FMouseKeyFlags and MK_LBUTTON) > 0 then FMouseKeys := FMouseKeys + [mkLBtn];
//  if (FMouseKeyFlags and MK_MBUTTON) > 0 then FMouseKeys := FMouseKeys + [mkMBtn];
//  if (FMouseKeyFlags and MK_RBUTTON) > 0 then FMouseKeys := FMouseKeys + [mkRBtn];
//  if (FMouseKeyFlags and MK_CONTROL) > 0 then FMouseKeys := FMouseKeys + [mkCtrl];
//  if (FMouseKeyFlags and MK_SHIFT)   > 0 then FMouseKeys := FMouseKeys + [mkShift];
//end;

procedure TCommonItem.SetShortcutKeyID(const Value: Int64);
begin
  FShortcutKeyID := Value;
  if not FShortcutKey.Locate(FShortcutKeyID) then
    FShortcutKey.Key := 0;
end;

procedure TCommonItem.SetHotKeyID(const Value: Int64);
begin
  FHotKeyID := Value;
  if not FHotKey.Locate(FHotKeyID) then
    FHotKey.Key := 0;
end;

procedure TCommonItem.InsertTags;
//var i: Integer;
begin
//  {$MESSAGE 'tag'}
//  for i := FTags.Count-1 downto 0 do
//    if Trim(FTags[i]) = '' then FTags.Delete(i);
//  FDB.ExecSQL('DELETE FROM ' + TB_TAGS +
//    ' WHERE (' + CN_TABLE_ID + ' = ' + IntToStr(MyTableID) + ') AND ' +
//    '(' + CN_PARENT_ID + ' = ' + IntToStr(FID) + ')');
//  for i := 0 to FTags.Count-1 do begin
//    FDB.ExecSQL('INSERT INTO ' + TB_TAGS +
//      '(' + CN_TABLE_ID + ',' + CN_PARENT_ID + ',' + CN_TAG + ') ' +
//      'VALUES (' + IntToStr(MyTableID) + ',' + IntToStr(FID) + ',' + Quo(FTags[i]) + ')');
//  end;
end;

procedure TCommonItem.SetItems;
begin
  FShortcutKey.TableID := MyTableID;
  FHotKey.TableID := MyTableID;   
  FMouse.TableID := MyTableID;
  FShortcutKey.ParentID := ID;
  FHotKey.ParentID := ID;         
  FMouse.ParentID := ID;
end;

procedure TCommonItem.SetIconID(const Value: Int64);
begin
  FIconID := Value;
  IconItem := FindIconItem(FIconID);
end;

function TCommonItem.FindIconItem(ID: Int64): TIconItem;
var i: Integer;
begin
  Result := TIconItem(FIconList[0]);
  for i := 0 to FIconList.Count-1 do
    if TIconItem(FIconList[i]).ID = ID then begin
      Result := TIconItem(FIconList[i]);
      Exit;
    end;
end;

procedure TCommonItem.ClearUseCount;
begin
  FUseCount := 0;
end;

procedure TCommonItem.IncUseCount;
begin
  Inc(FUseCount);
  FAccessDate := Now;
end;

function TCommonItem.RepetitionStr: string;
begin
  Result := Format('%f', [Repetition]);
end;

procedure TCommonItem.SetID(const Value: Int64);
begin
  inherited;
  FShortcutKey.ParentID := Value;
  FHotKey.ParentID := Value;
end;

procedure TCommonItem.SetIconItem(const Value: TIconItem);
begin
  FIconItem := Value;
  FIconID := Value.ID;
end;

procedure TCommonItem.SetMouseID(const Value: Int64);
begin
  FMouseID := Value;
  if not FMouse.Locate(FHotKeyID) then begin
    FMouse.Action := maLClk;
    FMouse.KeyFlags := 0;
    FMouse.RtnPoses := [];
//    FMouse.DspPos := mdpNone;
  end;
end;

procedure TCommonItem.ChengeParent(AParent: TTreeNode);
begin
  Parent := AParent;
end;

procedure TCommonItem.ClearAction;
begin
  FShortcutKey.Key := 0;
  FHotKey.Key := 0;
  FMouse.Reset;
end;

procedure TCommonItem.Excute;
begin
  IncUseCount;
  if FID <> 0 then
    Update;
end;

procedure TCommonItem.GetTags;
var tb: TSQLiteTable;
begin
  FTags.Clear;
//  p('SELECT * FROM ' + TB_TAGS + ' WHERE ' +
//                        CN_TABLE_ID + ' = ' + IntToStr(FMyTableID) + ' AND ' +
//                        CN_PARENT_ID + ' = ' + IntToStr(FID) + ';');
  tb := SQLiteDB.GetTable('SELECT * FROM ' + TB_TAGS + ' WHERE ' +
                        CN_TABLE_ID + ' = ' + IntToStr(FMyTableID) + ' AND ' +
                        CN_PARENT_ID + ' = ' + IntToStr(FID) + ';');
  try
    with tb do begin
      MoveFirst;
      while not Eof do begin
//        FTags.Add(FieldByName[CN_TAG]);
        Next;
      end;
    end;
  finally
    tb.Free;
  end;
end;

function TCommonItem.ParentName: string;
var tb: TSQLiteTable; sql: string;
begin
  Result := '[root dir]';
  if Self is TDirItem then
    sql := CN_ID + ' = ' + IntToStr(ParentID)
  else
    sql := CN_TABLE_ID + ' = ' + IntToStr(MyTableID) + ' AND ' +
                        CN_ID + ' = ' + IntToStr(ParentID);
  tb := TDirItem.Select(sql);
  try
    if not tb.MoveFirst then Exit;
    Result := tb.FieldByName[CN_NAME];
  finally
    tb.Free;
  end;
end;

{ TTextItem }

procedure TTextItem.Assign(Source: TBoneItem);
begin
  inherited;
  FText := (Source as TTextItem).Text;
  FMode := (Source as TTextItem).Mode;
end;

procedure TTextItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    Text := FieldByName[CN_TEXT];
    Mode := TPasteMode(FieldAsInteger(FieldIndex[CN_PASTE_MODE]));
  end;
end;

procedure TTextItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_TEXT + ',' + CN_PASTE_MODE;
  FValusStr := FValusStr + ',' + Quo(FText) + ',' + IntToStr(Integer(FMode));
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_TEXT + ' = ' + Quo(FText) + ',' +
    CN_PASTE_MODE + ' = ' + IntToStr(Integer(FMode));
end;

procedure TTextItem.CreateItem;
begin
  inherited;
  FText := '';
  FMode := pmPaste;
end;

procedure TTextItem.Excute;
begin
  inherited;
  Pasting := True;
  try
    case FMode of
      pmCopy:     SendClip;
      pmCarret:   SendCarret;
      pmKeyMacro: SendKeyMacro;
      pmLaunch:   SendLaunch;
      pmBrowse:   SendBrowse;
      pmScript: ;
      else SendPaste;
    end;
    Sleep(100);
  finally
    Pasting := False;
  end;
end;

procedure TTextItem.OpenLines(s: string; IsUrl: Boolean);
var SL: TStringList;
  i: Integer; res: Boolean;
  ss, cmd, arg: string; r: TSkRegExp;
begin
  SL := TStringList.Create;
  r := TSkRegExp.Create;
  try
    r.IgnoreCase := True;
    r.MultiLine := True;
    SL.Text := Trim(s);
    for i := 0 to SL.Count-1 do begin
      ss := Trim(SL[i]);
      if ss <> '' then begin
        if IsUrl then begin
          r.Expression := REG_URL;
          if r.Exec(ss) then Open(Application.Handle, ss);
        end else begin
          
          r.Expression := '^[A-Za-z]:[\\\\/][^?\";:<>*|]*\..+';
          res := r.Exec(ss);
          cmd := r.Match[0];
          arg := StringReplace(ss, cmd, '', []);
          if FileExists(cmd) and res then
            if Trim(arg) = '' then
              ShellExecute(Application.Handle, 'open', PChar(cmd), nil,
                PChar(ExtractFileDir(cmd)), SW_SHOWNORMAL)
            else
              ShellExecute(Application.Handle, 'open', PChar(cmd), PChar(arg),
                PChar(ExtractFileDir(cmd)), SW_SHOWNORMAL);
        end;
      end;
    end;
  finally
    SL.Free;
    r.Free;
  end;
end;

procedure TTextItem.SendPaste;
begin
  SetForegroundWindow(hForegroundWnd);
  Sleep(50);
  SendClip;;
  keybd_event(VK_CONTROL,0,0,0);
  keybd_event(Ord('V'),0,0,0);
  keybd_event(Ord('V'),0,KEYEVENTF_KEYUP,0);
  keybd_event(VK_CONTROL,0,KEYEVENTF_KEYUP,0);
  Sleep(10);
end;
          
procedure TTextItem.SendClip;
begin
//  Clipboard.Open;
  try
    try
      Clipboard.SetTextBuf(PChar(FText));
    except

    end;
  finally
//    Clipboard.Close;
  end;
end;

procedure TTextItem.SendCarret;
var CaretPos, SelStart, SelEnd: Integer; TmpText: string;
begin
  CaretPos := Pos('|', FText);
  if CaretPos <> 0 then begin
    TmpText := FText;
    try
      SendMessage(hFourcusCtrl, EM_GETSEL, Integer(@SelStart), Integer(@SelEnd));
      FText := StringReplace(FText, '|', '', []);   
//      DOutI(SelStart);
//      DOutI(SelEnd);
      SendPaste;
      SelStart := SelStart + CaretPos - 1;
      SelEnd := SelStart;
      SendMessage(hFourcusCtrl, EM_SETSEL, SelStart, SelStart);
    finally
      FText := TmpText;
    end;
  end else begin
    SendPaste;
  end;
end;

procedure TTextItem.SendKeyMacro;
begin
  ExcuteKeyMacro(hFourcusCtrl, FText);
end;

procedure TTextItem.SendLaunch;
begin
  OpenLines(FText, False);
end;

procedure TTextItem.SendBrowse;
begin
  OpenLines(FText, True);
end;

procedure TTextItem.Pasete;
begin
  SendPaste;
end;

procedure TTextItem.ToClip;
begin
  SendClip;
end;

procedure TTextItem.Insert;
begin
  if IconItem = nil then raise Exception.Create('IconItemがnilです。');
  FIconItem.Update;
  FIconID := FIconItem.ID;
  inherited;
end;

procedure TTextItem.SetMode(const Value: TPasteMode);
begin
  FMode := Value;
  if IconID > 5 then Exit;
  IconID := Integer(Value);
end;

{ TPasteItem }

procedure TPasteItem.Assign(Source: TBoneItem);
begin
  inherited;
  if not (Source is TPasteItem) then begin
    FAddKeys := '';
    Exit;
  end;
  FAddKeys := (Source as TPasteItem).AddKeys;
end;

procedure TPasteItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
  FMyTableID := TBID_PASTE_ITEMS;
  FIconTableName := TB_PASTE_ICONS;
  FIconList := PasteIcons;
  FAddKeys := '';
end;

procedure TPasteItem.CreateSQLParts;
begin
  inherited; 
  FColumnsStr := FColumnsStr + ',' + CN_ADD_KEYS;
  FValusStr := FValusStr + ',' + Quo(FAddKeys);
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_ADD_KEYS + ' = ' + Quo(FAddKeys);
end;

class function TPasteItem.GetTableName: string;
begin
  Result := TB_PASTE_ITEMS;
end;

procedure TPasteItem.SendPaste;
begin
  inherited;
  if FAddKeys <> '' then begin
    ExcuteKeyMacro(hFourcusCtrl, FAddKeys);
  end;
end;

procedure TPasteItem.SetAddKeys(const Value: string);
begin
  FAddKeys := Value;
end;

procedure TPasteItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;  
  with FTable do begin
    AddKeys := FieldByName[CN_ADD_KEYS];
  end;
end;

{ TClipItem }

procedure TClipItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
  FMyTableID := TBID_CLIP_ITEMS;
  FIconTableName := TB_CLIP_ICONS; 
  FIconList := ClipIcons;
end;

class function TClipItem.GetTableName: string;
begin
  Result := TB_CLIP_ITEMS;
end;

procedure TClipItem.SetMode(const Value: TPasteMode);
begin
  inherited;
end;

{ TBkmkItem }

procedure TBkmkItem.Assign(Source: TBoneItem);
begin
  inherited;
  FUrl := (Source as TBkmkItem).Url;
end;

procedure TBkmkItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    Url := FieldByName[CN_URL];
  end;
end;

procedure TBkmkItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_URL;
  FValusStr := FValusStr + ',' + Quo(FUrl);
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_URL + ' = ' + Quo(FUrl);
end;

procedure TBkmkItem.CreateItem;
begin
  inherited;
  FTableName := GetTableName;
  FMyTableID := TBID_BKMK_ITEMS;
  FIconTableName := TB_BKMK_ICONS;
  FIconList := BkmkIcons;
  FUrl := '';
  FIconItem := TBkmkIconItem.Create(BkmkIcons);
end;

class function TBkmkItem.GetTableName: string;
begin
  Result := TB_BKMK_ITEMS;
end;

procedure TBkmkItem.Excute;
begin
  inherited;
  ShellExecute(Application.Handle, 'OPEN', PChar(Url), nil, nil, SW_NORMAL);
end;

destructor TBkmkItem.Destroy;
begin
  FIconItem.Free;
  inherited;
end;

procedure TBkmkItem.Insert;
begin    
  FIconItem.Insert; 
  FIconID := FIconItem.ID;
  inherited;
end;

{ TLaunchItem }

procedure TLaunchItem.Assign(Source: TBoneItem);
var li: TLaunchItem;
begin
  inherited;
  li := TLaunchItem(Source);
  FFileName := li.FileName;
  FParams := li.Params;
  FDir := li.Dir;
  FShowCmd := li.ShowCmd;
end;

procedure TLaunchItem.SetFields(ATable: TSQLiteTable);
begin       
  with ATable do begin
    FileName := FieldByName[CN_FILE_NAME];
    Params := FieldByName[CN_PARAMS];
    Dir := FieldByName[CN_DIR];
    ShowCmd := TShowCmd(FieldAsInteger(FieldIndex[CN_SHOW_CMD]));
  end;
  inherited;
end;

procedure TLaunchItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_FILE_NAME + ',' + CN_PARAMS + ',' +
    CN_DIR + ',' + CN_SHOW_CMD;
  FValusStr := FValusStr + ',' + Quo(FFileName) + ',' + Quo(FParams) + ',' +
    Quo(FDir) + ',' + IntToStr(Integer(FShowCmd));
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_FILE_NAME + ' = ' + Quo(FFileName) + ',' +
    CN_PARAMS + ' = ' + Quo(FParams) + ',' +
    CN_DIR + ' = ' + Quo(FDir) + ',' +
    CN_SHOW_CMD + ' = ' + IntToStr(Integer(FShowCmd));
end;

procedure TLaunchItem.CreateItem;
begin
  inherited;
  FFileName := '';
  FParams := '';
  FDir := '';
  FShowCmd := scShow;
  FTableName := GetTableName;
  FMyTableID := TBID_LAUNCH_ITEMS;
  FIconTableName := TB_LAUNCH_ICONS;
  FIconList := LaunchIcons;
  FIconItem := TLaunchIconItem.Create(LaunchIcons);
end;

class function TLaunchItem.GetTableName: string;
begin
  Result := TB_LAUNCH_ITEMS;
end;

procedure TLaunchItem.Excute;
var sc: Integer;
begin
  inherited;
  if (not FileExists(FFileName)) and    
     (not FileExists(ExtractFilePath(ParamStr(0)) + FFileName)) and
     (not FileExists(IncludeTrailingPathDelimiter(GetWindowsDir) + FFileName)) and
     (not FileExists(IncludeTrailingPathDelimiter(GetSystemDir) + FFileName)) then begin
    ShowMessage('ファイルが存在しません。');
    Exit;
  end;
  case FShowCmd of
    scMin: sc := SW_MINIMIZE;
    scMax: sc := SW_MAXIMIZE;
  else sc := SW_NORMAL;
  end;
  ShellExecute(Application.Handle, 'OPEN', PChar(FFileName), PChar(FParams), PChar(FDir), sc);
end;

//procedure TLaunchItem.SetIconID(const Value: Int64);
//  procedure GetIcon;
//  var h: HICON;
//  begin
//    if FileExists(FileName) then begin
//      h := ExtractIconEx(FileName);
//      if h <> 0 then
//        FIconItem.Icon.Handle := h
//      else
//        FIconItem.Icon := TIconItem(LaunchIcons[0]).Icon;
//    end else begin
//      FIconItem.Icon := TIconItem(LaunchIcons[1]).Icon;
//    end;
//  end;
//var h: HICON;
//begin
//  FIconID := Value;
//  if (FIconPath <> '') and (FileExists(FIconPath)) then begin
//      h := ExtractIconEx(FIconPath, FIconIndex);
//      if h <> 0 then
//        FIconItem.Icon.Handle := h
//      else
//        GetIcon;
//  end else begin
//    GetIcon;
//  end;
//end;

destructor TLaunchItem.Destroy;
begin
  FIconItem.Free;
  inherited;
end;

procedure TLaunchItem.Insert;
begin
  FIconItem.Insert; 
  FIconID := FIconItem.ID;
  inherited;
//  Update;
end;

{ TDirItem }

procedure TDirItem.Assign(Source: TBoneItem);
begin
  inherited;
  FTableID   := (Source as TDirItem).TableID;
  FViewStyle := (Source as TDirItem).ViewStyle;
  FSortMode  := (Source as TDirItem).SortMode;
  FSortOrdAsc:= (Source as TDirItem).SortOrdAsc;
end;

procedure TDirItem.SetFields(ATable: TSQLiteTable);
begin
  inherited;
  with FTable do begin
    TableID := FieldAsInteger(FieldIndex[CN_TABLE_ID]);
    ViewStyle := TViewStyle(FieldAsInteger(FieldIndex[CN_VIEW_STYLE]));
    SortMode := TSortMode(FieldAsInteger(FieldIndex[CN_SORT_MODE]));
    SortOrdAsc := Boolean(FieldAsInteger(FieldIndex[CN_SORT_ORD_ASC]));
  end;
end;

procedure TDirItem.CreateSQLParts;
begin
  inherited;
  FColumnsStr := FColumnsStr + ',' + CN_TABLE_ID + ',' + CN_VIEW_STYLE + ',' +
    CN_SORT_MODE + ',' + CN_SORT_ORD_ASC;
  FValusStr := FValusStr + ',' + IntToStr(FTableID) + ',' +
    IntToStr(Integer(FViewStyle)) + ',' + IntToStr(Integer(FSortMode)) + ',' +
    IntToStr(Integer(FSortOrdAsc));
  FAssignmentsStr := FAssignmentsStr + ',' +
    CN_TABLE_ID + ' = ' + IntToStr(FTableID) + ',' +
    CN_VIEW_STYLE + ' = ' + IntToStr(Integer(FViewStyle)) + ',' +
    CN_SORT_MODE + ' = ' + IntToStr(Integer(FSortMode)) + ',' +
    CN_SORT_ORD_ASC + ' = ' + IntToStr(Integer(FSortOrdAsc));
end;

procedure TDirItem.CreateItem;
begin
  inherited;
  FTableID := 0;
  FViewStyle := vsReport;
  FSortMode := smName;
  FSortOrdAsc := True;
  FTableName := GetTableName;
  FMyTableID := TBID_DIR_ITEMS;
  FIconTableName := TB_DIR_ICONS;   
  FIconList := DirIcons;    
  FIconItem := TIconItem(FIconList[0]);
end;

class function TDirItem.GetTableName: string;
begin
  Result := TB_DIR_ITEMS;
end;


procedure TDirItem.RecursionSQL(ParentID: Int64; SQL: string);
var tb: TSQLiteTable; i: Int64;
begin        
  tb := FDB.GetTable('SELECT ' + CN_ID + ' FROM ' +
    TB_DIR_ITEMS + ' WHERE ' + CN_PARENT_ID + ' = ' + IntToStr(ParentID));
  try
    with tb do begin
      MoveFirst;
      while not Eof do begin
        i := CountResult;
        RecursionSQL(i, SQL);
        Next;
      end;
    end;
    SQL := StringReplace(SQL, '#{ID}', IntToStr(ParentID), []);
    FDB.ExecSQL(SQL);
  finally
    tb.Free;
  end;
end;

procedure TDirItem.Delete;
begin
  inherited;
  RecursionSQL(FID,
    'DELETE FROM ' + TB_DIR_ITEMS +
    ' WHERE (' + CN_PARENT_ID + ' = #{ID}) AND ' +
           '(' + CN_TABLE_ID + ' = ' + IntToStr(FTableID) + ');');
end;

procedure TDirItem.UpdateAllLowerDir;
  procedure UpDir(AParent: TTreeNode);
  var n: TTreeNode; di: TDirItem;
  begin
    n := AParent.getFirstChild;
    while n <> nil do begin
      di := TDirItem(n.Data);
      di.IsPassword := FIsPassword;
      di.SortMode := FSortMode;
      di.SortOrdAsc := FSortOrdAsc;
      di.ViewStyle := FViewStyle;
      di.Update;

      UpDir(n);

      n := n.GetNextChild(n);
    end;
  end;
begin
  Update;
  UpDir(FNode);
//  RecursionSQL(FID,
//    'UPDATE ' + TB_DIR_ITEMS + ' SET ' +
//		CN_IS_PASSWORD + ' = ' + IntToStr(Integer(FIsPassword)) + ',' +
//		CN_VIEW_STYLE + ' = ' + IntToStr(Integer(FViewStyle)) + ',' +
//		CN_SORT_MODE + ' = ' + IntToStr(Integer(FSortMode)) + ',' +
//		CN_SORT_ORD_ASC + ' = ' + IntToStr(Integer(FSortOrdAsc)) +
//		' WHERE (' + CN_PARENT_ID + ' = #{ID}) AND ' +
//           '(' + CN_TABLE_ID + ' = ' + IntToStr(FTableID) + ');');
end;

procedure TDirItem.Insert;
begin
  if TableID = 0 then raise Exception.Create(
      'フォルダが収納するアイテムのテーブルをセットしてください。');
  FIconItem.Update;
  FIconID := FIconItem.ID;
  inherited;
end;

{ TIconList }

function TIconList.AddItem(Item: Pointer): Integer;
var ii: TIconItem;
begin
  Result := Add(Item);
  ii := TIconItem(Item);
//  ii.Insert;
  FImagesL.AddIcon(ii.Icon);
  FImagesS.AddIcon(ii.Icon);
//  ii.Icon.Free;
end;

procedure TIconList.Clear;
begin
  ClearList(Self);
  FImagesL.Clear;
  FImagesS.Clear;  
//  inherited;
end;

constructor TIconList.Create;
begin
  FImagesL := TImageList.Create(nil);
  FImagesS := TImageList.Create(nil);
  FImagesL.Width := 32;
  FImagesL.Height := 32;
  FImagesL.BkColor := clWindow;
  FImagesS.BkColor := clWindow;
end;

procedure TIconList.DeleteItem(Index: Integer);
var ii: TIconItem;
begin
  FImagesL.Delete(Index);
  FImagesS.Delete(Index);
  ii := TIconItem(Self[Index]);
//  ii.Delete;
  ii.Free;
  Delete(Index);
end;

destructor TIconList.Destroy;
begin
  FImagesL.Free;
  FImagesS.Free;
  inherited;
end;

procedure TIconList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  case Action of
    lnDeleted: begin
//      TObject(Ptr).Free;
//      FImagesL.Delete(ii.Index);
//      FImagesS.Delete(ii.Index);
    end;
  else begin

  end;
  end;
end;

procedure TIconList.ReplaceItem(Index: Integer; Image: TIcon);
var ii: TIconItem;
begin
  ii := TIconItem(Self[Index]);
  if ii.Icon <> Image then
    ii.Icon := Image;
//  ii.Update;
  ImagesS.ReplaceIcon(Index, Image);   
  ImagesL.ReplaceIcon(Index, Image);
end;

procedure TIconList.SetBkColor(const Value: TColor);
begin
  FBkColor := Value;
  FImagesL.BkColor := Value;
  FImagesS.BkColor := Value;
end;

procedure SetIcons(Cls: TIconItemClass; AList: TIconList);
var tb: TSQLiteTable; ii: TIconItem;
begin
  tb := SQLiteDB.GetTable('SELECT * FROM ' + Cls.GetTableName + ';');
  try
    tb.MoveFirst;
    while not tb.EOF do begin
      ii := Cls.Create(AList);
      ii.SetFields(tb);
      AList.AddItem(ii);
      if (Cls = TLaunchIconItem) or (Cls = TBkmkIconItem) then Break;
//      ii.Icon.Free;
      tb.Next;
    end;
  finally
    tb.Free;
  end;
end;

{ TIconHaveItem }

//procedure TIconHaveItem.Assign(Source: TBoneItem);
//begin
//  inherited;
//  FIconPath   := (Source as TIconHaveItem).IconPath;
//  FIconIndex := (Source as TIconHaveItem).IconIndex;
//end;

//
//procedure TIconHaveItem.CreateSQLParts;
//begin
//  inherited;
//  FColumnsStr := FColumnsStr + ',' + CN_ICON_PATH + ',' + CN_ICON_INDEX;
//  FValusStr := FValusStr + ',' + Quo(FIconPath) + ',' +
//    IntToStr(FIconIndex);
//  FAssignmentsStr := FAssignmentsStr + ',' +
//    CN_ICON_PATH + ' = ' + Quo(FIconPath) + ',' +
//    CN_ICON_INDEX + ' = ' + IntToStr(FIconIndex);
//end;

//
//procedure TIconHaveItem.SetFields(ATable: TSQLiteTable);
//begin
//  inherited;
//  with ATable do begin
//    IconPath := FieldByName[CN_ICON_PATH];
//    IconIndex := FieldAsInteger(FieldIndex[CN_ICON_INDEX]);
//  end;
//end;

procedure TIconHaveItem.SetIconID(const Value: Int64);
var cls: TItemClass; tb: TSQLiteTable;
begin
  FIconID := Value;
  if Self is TLaunchItem then cls := TLaunchIconItem
  else cls := TBkmkIconItem;
  tb := cls.Select(CN_ID + ' = ' + IntToStr(Value));
  try
    IconItem.SetFields(tb);
  finally
    tb.Free;
  end;
end;

procedure TIconHaveItem.SetIconItem(const Value: TIconItem);
begin
  FIconItem.Assign(Value);
  FIconID := Value.ID;
end;

{ TCallTabItem }

procedure TCallTabItem.Assign(Source: TCallTabItem);
begin
  FID := Source.ID;
  FShortCutkey.Assign(Source.ShortCutkey);
  FHotkey.Assign(Source.Hotkey);
  FMouse.Assign(Source.Mouse); 
  FShortCutkey.TableID := -1;
  FShortCutkey.ParentID := -1;
  FHotKey.TableID := -1;
  FHotKey.ParentID := -1;
  FMouse.TableID := -1;
  FMouse.ParentID := -1;
end;

constructor TCallTabItem.Cleate;
begin
  FShortCutkey := TShortcutKeyItem.Create;
  FShortCutkey.TableID := -1;
  FShortCutkey.ParentID := -1;
  FHotkey := THotKeyItem.Create;
  FHotKey.TableID := -1;
  FHotKey.ParentID := -1;
  FMouse := TMouseItem.Create;
  FMouse.TableID := -1;
  FMouse.ParentID := -1;
end;

destructor TCallTabItem.Destroy;
begin
  FShortCutkey.Free;
  FHotkey.Free;
  FMouse.Free;
  inherited;
end;

procedure TCallTabItem.LoadData;
begin
  FShortCutkey.Locate(FID);
  FHotkey.Locate(FID);
  FMouse.Locate(FID);
end;

procedure TCallTabItem.SaveData;
begin
  FShortCutkey.Update;
  FHotkey.Update;
  FMouse.Update;
end;

procedure TCallTabItem.SetHotkey(const Value: THotKeyItem);
begin
  FHotkey.Assign(Value);
end;

procedure TCallTabItem.SetID(const Value: Int64);
begin
  FID := Value;
  LoadData;   
  FShortCutkey.TableID := -1;
  FShortCutkey.ParentID := -1;
  FHotKey.TableID := -1;
  FHotKey.ParentID := -1;
  FMouse.TableID := -1;
  FMouse.ParentID := -1;
end;

procedure TCallTabItem.SetMouse(const Value: TMouseItem);
begin
  FMouse.Assign(Value);
end;

procedure TCallTabItem.SetShortCutkey(const Value: TShortcutKeyItem);
begin
  FShortCutkey.Assign(Value);
end;

{ TCallAction }

constructor TCallAction.Create;
begin
  FShortcutKeyItem := TShortcutKeyItem.Create;
  FShortcutKeyItem.TableID := -1;
  FShortcutKeyItem.ParentID := -1;
  FHotKeyItem := THotKeyItem.Create;
  FHotKeyItem.TableID := -1;
  FHotKeyItem.ParentID := -1;
  FMouseItem := TMouseItem.Create;
  FMouseItem.TableID := -1;
  FMouseItem.ParentID := -1;
end;

destructor TCallAction.Destroy;
begin
  FShortcutKeyItem.Free;    
  FHotKeyItem.Free;
  FMouseItem.Free;
  inherited;
end;

procedure TCallAction.SetHotKeyItem(const Value: THotKeyItem);
begin
  FHotKeyItem.Assign(Value);
end;

procedure TCallAction.SetMouseItem(const Value: TMouseItem);
begin
  FMouseItem.Assign(Value);
end;

procedure TCallAction.SetShortcutKeyItem(const Value: TShortcutKeyItem);
begin
  FShortcutKeyItem.Assign(Value);
end;

initialization
begin
  if AppTerminate then Exit;
  DirIcons := TIconList.Create;
  PasteIcons := TIconList.Create;
  ClipIcons := TIconList.Create;
  BkmkIcons := TIconList.Create;
  LaunchIcons := TIconList.Create;
  SetIcons(TDirIconItem, DirIcons);
  SetIcons(TPasteIconItem, PasteIcons);
  SetIcons(TClipIconItem, ClipIcons);
  SetIcons(TBkmkIconItem, BkmkIcons);
  SetIcons(TLaunchIconItem, LaunchIcons);
end;

finalization
begin                 
  if AppTerminate then Exit;
  ClearList(DirIcons);
  DirIcons.Free;
  ClearList(PasteIcons);
  PasteIcons.Free;
  ClearList(ClipIcons);
  ClipIcons.Free;
  ClearList(BkmkIcons);
  BkmkIcons.Free;
  ClearList(LaunchIcons);
  LaunchIcons.Free;
end;

end.
