unit ComDef;

interface

uses SQLiteTable3, SkRegExpW, Windows, Messages, ActnList, cryptogram, Classes,
  SQLite3;

var
  SQLiteDB: TSQLiteDatabase;
  RegExp: TSkRegExp; 
  slLog: TStringList;

const   
  WM_QUERY_EXCUTE = WM_USER + 1;
//  WM_MACRO_EXCUTE = WM_USER + 2;
  MK_ALT = $20;
                                      TBID_SYSTEM       = -1;
  TB_DIR_ITEMS     = 'dir_items';     TBID_DIR_ITEMS    = 1;
  TB_PASTE_ITEMS   = 'paste_items';   TBID_PASTE_ITEMS  = 2;
  TB_LAUNCH_ITEMS  = 'launch_items';  TBID_LAUNCH_ITEMS = 3;
  TB_BKMK_ITEMS    = 'bkmk_items';    TBID_BKMK_ITEMS   = 4;
  TB_CLIP_ITEMS    = 'clip_items';    TBID_CLIP_ITEMS   = 5;
  TB_TAGS          = 'tags';
  TB_SHORTCUT_KEYS = 'shortcut_keys';
  TB_HOT_KEYS      = 'hot_keys';
  TB_DIR_ICONS     = 'dir_icons';
  TB_LAUNCH_ICONS  = 'launch_icons';
  TB_CLIP_ICONS    = 'clip_icons';
  TB_BKMK_ICONS    = 'bkmk_icons';
  TB_PASTE_ICONS   = 'paste_icons';
  TB_TABLES        = 'tables';     
  TB_MOUSE_ITEMS        = 'mouse_items';
//  TB_      = '""';

  CN_ID              = 'id';
  CN_TABLE_ID        = 'table_id';
  CN_TAGS            = 'tags';
  CN_KEY             = 'key';
  CN_BLOB            = 'blob';
  CN_NAME            = 'name';
  CN_VALUE           = 'value';
  CN_CREATE_DATE     = 'create_date';
  CN_UPDATE_DATE     = 'update_date';
  CN_ACCESS_DATE     = 'access_date';
  CN_USE_COUNT       = 'use_count';
  CN_COMMENT         = 'comment';
  CN_ICON_ID         = 'icon_id';
  CN_PARENT_ID       = 'parent_id';
  CN_ORDER           = 'ord';
  CN_SHORTCUT_KEY_ID = 'shortcut_key_id';
  CN_HOT_KEY_ID      = 'hot_key_id';
  CN_IS_PASSWORD     = 'is_password';   
  CN_MOUSE_ID        = 'mouse_id';
//  CN_MOUSE_ACTION    = 'mouse_action';
//  CN_MOUSE_KEY_FLAGS = 'mouse_key_flags';
//  CN_MOUSE_PLACE     = 'mouse_place';
//  CN_MOUSE_DISP_POS  = 'mouse_disp_pos';
  CN_TEXT            = 'text';
  CN_PASTE_MODE      = 'paste_mode';
  CN_URL             = 'url';
  CN_FILE_NAME       = 'file_name';
  CN_PARAMS          = 'params';
  CN_DIR             = 'dir';
  CN_SHOW_CMD        = 'show_cmd';
  CN_VIEW_STYLE      = 'view_style';
  CN_SORT_MODE       = 'sort_mode';  
  CN_SORT_ORD_ASC    = 'sort_ord_asc';
  CN_ENABLED   = 'enabled';
  CN_ACTION    = 'action';
  CN_KEY_FLAGS = 'key_flags';
  CN_RTN_POSES = 'rtn_poses';
  CN_DSP_POS   = 'dsp_pos';
  CN_ICON_PATH = 'icon_path';       
  CN_ICON_INDEX = 'icon_index';
  CN_ADD_KEYS = 'add_keys';

  CLMC_NAME    = '名前';
  CLMC_CREATE  = '作成日';
  CLMC_UPDATE  = '更新日';
  CLMC_ACCESS  = '最終使用日';
  CLMC_USE     = '使用回数';
  CLMC_REP     = '使用頻度';
  CLMC_PARENT  = '親フォルダ';
  CLMC_COMMENT = 'コメント';
//  CN_ = '';
//  CN_ = '';
//  CN_ = '';
//type

  CI_LAST_ID = -1;
  CI_ALLSEARCH_ID = -2;
  CI_PASTE_ID = -3;
  CI_LAUNCH_ID = -4;
  CI_BKMK_ID = -5;
  CI_CLIP_ID = -6;

  DEF_PASS = 'd5f245088506e0927f58890b959df9b4'; 

  REG_URL = '(https?:\/\/[-_.!~*\''()a-zA-Z0-9;\/?:\@&=+\$,%#]+)';

  MSG_ADD_KEYS = 'ここにキーを入力してください';

var
  ConfigPath, ConfigDir, ConfigFileName, TmpPath, TmpDir, DbFile, TableFile, PassWord: string;
  hForegroundWnd, hFourcusCtrl, hTaskBar, hDskTop: THandle; ForegroundWndCaption: array[0..MAX_PATH] of Char;
  Pasting, AppTerminate, IsPassWord: Boolean;
  ShortCutList: TActionList;
  
procedure Commit;  
procedure Rollback;
procedure BeginTransaction; 
function IsTransactionOpen: Boolean;  

implementation

uses SysUtils, Dialogs, FrPassword, Forms, Controls;

procedure Commit;
begin
  SQLiteDB.Commit;
end;

procedure Rollback;
begin
  SQLiteDB.Rollback;
end;

procedure BeginTransaction;
begin
//  if not SQLiteDB.IsTransactionOpen then
    SQLiteDB.BeginTransaction;
end;

function IsTransactionOpen: Boolean;
begin
  Result := SQLiteDB.IsTransactionOpen;
end;

function GetDbPassword(AFile: string): string;
var fs: TFileStream; Buff: array[0..99] of Char; time: Integer;
begin
  fs := TFileStream.Create(AFile, fmShareDenyNone);
  try
    fs.Position := 0;
    fs.Read(Buff, 100);
    Result := GetPassword(Buff, time);
  finally
    fs.Free;
  end;
end;

procedure EncryptsDbFile;
begin
  if GetDbPassword(DbFile) = '' then
    EncryptsFile(DbFile, PassWord, False);
end;

var IsDbFileExists: Boolean;
  sl: TStringList; db: TSQLiteDB; err: PChar;
//  fs: TFileStream; Buff: array[0..99] of Char; time: Integer;
initialization
begin
  while GetTickCount < 60000 do begin
    Sleep(1000);
  end;

  //値設定
  AppTerminate := False;
  IsPassWord := False;
  PassWord := DEF_PASS;
//  AppTerminate := True;
//  Exit;
  DbFile := ExtractFilePath(ParamStr(0)) + 'stamper.db';
  ConfigPath := ExtractFilePath(ParamStr(0)) + 'config\';
  ConfigDir := ExcludeTrailingPathDelimiter(ConfigPath);
  TmpPath := ExtractFilePath(ParamStr(0)) + 'Tmp\';
  TmpDir := ExcludeTrailingPathDelimiter(TmpPath);
  ConfigFileName := ConfigPath + 'config.ini';
  TableFile := ConfigPath + 'stamper.sql';
  IsDbFileExists := FileExists(DbFile);

  //複合化
  if IsDbFileExists then begin
    PassWord := GetDbPassword(DbFile);
//    fs := TFileStream.Create(DbFile, fmOpenRead);
//    try
//      fs.Position := 0;
//      fs.Read(Buff, 100);
//      PassWord := GetPassword(Buff, time);
//    finally
//      fs.Free;
//    end;
    if PassWord <> '' then begin
      if PassWord  <>  DEF_PASS then IsPassWord := True;
      //パスワード照合
      if IsPassWord then begin
        FormPassword := TFormPassword.Create(Application);
        try
          if FormPassword.ShowModal = mrOK then begin
            if PassWord <> FormPassword.EditPassWord.Text then begin
              Beep;
              MessageDlg('パスワードが違います。', mtWarning, [mbOK], 0);
              AppTerminate := True;
              Exit;
            end;
          end else begin
            AppTerminate := True;
            Exit;
          end;
        finally
          FormPassword.Release;
        end;
      end;
      ////////////////////////////////////////
      DecryptsFile(DbFile, PassWord, False);
      ////////////////////////////////////////
    end;
  end;
    
  //オブジェクト作成
  SQLiteDB := TSQLiteDatabase.Create(DbFile);
  //テーブル作成
  if not SQLiteDB.TableExists(TB_DIR_ITEMS) then begin
    if not FileExists(TableFile) then begin
      MessageDlg('テーブル定義ファイルが存在しません。', mtWarning, [mbOK], 0);
      AppTerminate := True;
      Exit;
    end;
    sl := TStringList.Create;
    SQLite3_Open(PChar(UTF8Encode(DbFile)), db);
    try
      sl.LoadFromFile(TableFile);
      SQLite3_Exec(db, PChar(sl.Text), nil, nil, err);
    finally
      sl.Free;
      SQLite3_Close(db);
    end;
    SQLiteDB.Free;
    SQLiteDB := TSQLiteDatabase.Create(DbFile);
  end;
  RegExp := TSkRegExp.Create;
end;

finalization
begin
//  if AppTerminate then Exit;
  if not AppTerminate then begin
//  tmp := GetDbPassword(DbFile);
    //オブジェクト破棄
    SQLiteDB.Free;
    RegExp.Free;
    //暗号化
    if not IsPassWord then PassWord := DEF_PASS;
    //////////////////////////////////////
    EncryptsDbFile;
    //////////////////////////////////////
  end;

end;

end.
