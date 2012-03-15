unit FrCallAction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FrmMouseAction, FrmShortcutAndHotKey, ComItems,
  StdCtrls, Helper, Menus, XPStyleActnCtrls, ActnList, ActnMan;

type
  TFormCallAction = class(TForm)
    FrameShortcutAndHotKey: TFrameShortcutAndHotKey;
    FrameMouseAction: TFrameMouseAction;
    Bevel1: TBevel;
    OKBtn: TButton;
    Button2: TButton;
    ButtonDelDbShortcut: TButton;
    ButtonDelDbHot: TButton;
    ButtonDelDbMouse: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FrameShortcutAndHotKeyEditShortcutKeyChange(Sender: TObject);
    procedure FrameShortcutAndHotKeyEditHotKeyChange(Sender: TObject);
    procedure CheckEnabledMouse(Sender: TObject);
    procedure FrameMouseActionCheckBoxMouseEnabledClick(Sender: TObject);
    procedure FrameMouseActionCheckBoxMouseRtnPosAllClick(Sender: TObject);
    procedure ButtonDelDbShortcutClick(Sender: TObject);
    procedure ButtonDelDbHotClick(Sender: TObject);
    procedure ButtonDelDbMouseClick(Sender: TObject);
  private
    { Private 宣言 }
    slError: TStringList;
    function CheckInput: Boolean;
  public
    { Public 宣言 }
    CallTabItem:TCallTabItem;
    procedure ItemToForm(Item:TCallTabItem);         
    procedure FormToItem(Item:TCallTabItem);
  end;

var
  FormCallAction: TFormCallAction;

implementation

uses FrMain, FrOption;

{$R *.dfm}

{ TFormCallAction }

function TFormCallAction.CheckInput: Boolean;
var res: Boolean;
begin
  Result := True;
  slError.Clear;

  //ショートカット
  if {Assigned(EditingItem) and} ExistActionShortCut(FormStancher.ActionList,
      TextToShortCut(FrameShortcutAndHotKey.EditShortcutKey.Text)) then begin
    Result := False;
    slError.Add('入力されたショートカットキー( ' +
        FrameShortcutAndHotKey.EditShortcutKey.Text + ' )' +
        'は既にコマンドメニューに登録されています。' +
        'コマンドメニューのショートカットキーは変更できないので入力を変更してください。');
  end;
  res := KeyExsist(TShortcutKeyItem, CallTabItem.ShortCutkey.ID,
        FrameShortcutAndHotKey.EditShortcutKey.Text);
  ButtonDelDbShortcut.Enabled := res;
  if res then begin
    Result := False;
    slError.Add('入力されたショートカットキー( ' +
        FrameShortcutAndHotKey.EditShortcutKey.Text + ' )は既に登録されています。');
  end;

  res := KeyExsist(THotKeyItem, CallTabItem.Hotkey.ID,
        FrameShortcutAndHotKey.EditHotKey.Text);
  ButtonDelDbHot.Enabled := res;
  if res then begin
    Result := False;
    slError.Add('入力されたホットキー( ' +
        FrameShortcutAndHotKey.EditHotKey.Text + ' )は既に登録されています。');
  end;

  if FrameMouseAction.CheckBoxMouseEnabled.Checked then begin
    if FrameMouseAction.CheckBoxMouseEnabled.Checked and
      FrameMouseAction.EmptyMouseValue(FrameMouseAction.GroupBoxMouseRtnPoses) then begin
      Result := False;
      slError.Add(FrameMouseAction.GroupBoxMouseRtnPoses.Caption + 'のどれか一つを選択してください。');
    end;

    res := MouseItemExist(CallTabItem.Mouse.ID, True,
      TMouseAction(FrameMouseAction.RadioGroupMouseAction.ItemIndex),
      FrameMouseAction.GetMouseKeyFlags, FrameMouseAction.GetMouseRtnPoses);
    ButtonDelDbMouse.Enabled := res;
    if res then begin
      Result := False;
      slError.Add('" ' + FrameMouseAction.LabelMouseHint.Caption +
        ' "のアクションは既に登録されています。他のアクションを選択してください。');
    end;
  end;

  CloseHintWindow;
  if Result then begin
  end else begin
    ShowHintWindow(Self, slError.Text);
  end;
  OKBtn.Enabled := Result;
end;

procedure TFormCallAction.FormToItem(Item: TCallTabItem);
var sk, hk: TShortCut;
begin
  FrameShortcutAndHotKey.GetKeys(sk, hk);
  Item.ShortCutkey.Key := sk;
  Item.Hotkey.Key := hk;
  FrameMouseAction.GetMouses(Item.Mouse);
end;

procedure TFormCallAction.ItemToForm(Item: TCallTabItem);
begin
  FrameShortcutAndHotKey.SetKeys(Item.ShortCutkey.Key, Item.Hotkey.Key);
  FrameMouseAction.SetMouses(Item.Mouse);
end;

procedure TFormCallAction.FormCreate(Sender: TObject);
begin
  slError := TStringList.Create;
end;

procedure TFormCallAction.FormDestroy(Sender: TObject);
begin
  slError.Free;
  CloseHintWindow;
end;

procedure TFormCallAction.FrameShortcutAndHotKeyEditShortcutKeyChange(
  Sender: TObject);
begin
  if Visible then CheckInput;
end;

procedure TFormCallAction.FrameShortcutAndHotKeyEditHotKeyChange(
  Sender: TObject);
begin
  if Visible then CheckInput;
end;

procedure TFormCallAction.CheckEnabledMouse(Sender: TObject);
begin
  FrameMouseAction.EnabledMouseSettings;
  if Visible then CheckInput;
end;

procedure TFormCallAction.FrameMouseActionCheckBoxMouseEnabledClick(
  Sender: TObject);
begin
  FrameMouseAction.CheckEnabledMouse(Sender);

end;

procedure TFormCallAction.FrameMouseActionCheckBoxMouseRtnPosAllClick(
  Sender: TObject);
begin
  FrameMouseAction.CheckBoxMouseRtnPosAllClick(Sender);
end;

procedure TFormCallAction.ButtonDelDbShortcutClick(Sender: TObject);
var res: Int64;
begin           
  if FormStancher.Option.ConfDelDbShortcut and
    (MessageDlg('あらかじめ登録されている重複ショートカットキーを削除しますか？',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;
  res := DeleteKey(TShortcutKeyItem, CallTabItem.ShortCutkey.ID,
        FrameShortcutAndHotKey.EditShortcutKey.Text);
  FormStancher.DeleteDirKey(res, True);    
  with FormOption do begin
    if CallTabItem <> TmpCallLastItem then
      TmpCallLastItem.ShortCutkey.Clear;
    if CallTabItem <> TmpCallAllSearchItem then
      TmpCallAllSearchItem.ShortCutkey.Clear;
    if CallTabItem <> TmpCallPasteItem then
      TmpCallPasteItem.ShortCutkey.Clear;
    if CallTabItem <> TmpCallLaunchItem then
      TmpCallLaunchItem.ShortCutkey.Clear;
    if CallTabItem <> TmpCallBkmkItem then
      TmpCallBkmkItem.ShortCutkey.Clear;
  end;
  CheckInput;
end;

procedure TFormCallAction.ButtonDelDbHotClick(Sender: TObject);  
var res: Int64;
begin            
  if FormStancher.Option.ConfDelDbHot and
    (MessageDlg('あらかじめ登録されている重複ホットキーを削除しますか？',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;
  res := DeleteKey(THotKeyItem, CallTabItem.Hotkey.ID,
        FrameShortcutAndHotKey.EditHotKey.Text);
  FormStancher.DeleteDirKey(res, False); 
  FormStancher.DeleteDirMouseAction(res);
  with FormOption do begin
    if CallTabItem <> TmpCallLastItem then
      TmpCallLastItem.Hotkey.Clear;
    if CallTabItem <> TmpCallAllSearchItem then
      TmpCallAllSearchItem.Hotkey.Clear;
    if CallTabItem <> TmpCallPasteItem then
      TmpCallPasteItem.Hotkey.Clear;
    if CallTabItem <> TmpCallLaunchItem then
      TmpCallLaunchItem.Hotkey.Clear;
    if CallTabItem <> TmpCallBkmkItem then
      TmpCallBkmkItem.Hotkey.Clear;
  end;
  CheckInput;
end;

procedure TFormCallAction.ButtonDelDbMouseClick(Sender: TObject);

var res: Int64;
begin                   
  if FormStancher.Option.ConfDelDbMouse and
    (MessageDlg('あらかじめ登録されている重複マウスアクションを削除しますか？',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;
  res := DeleteMouseKey(CallTabItem.Mouse.ID, True,
      TMouseAction(FrameMouseAction.RadioGroupMouseAction.ItemIndex),
      FrameMouseAction.GetMouseKeyFlags, FrameMouseAction.GetMouseRtnPoses);
  FormStancher.DeleteDirMouseAction(res);
  with FormOption do begin
    if CallTabItem <> TmpCallLastItem then
      TmpCallLastItem.Mouse.Clear;    
    if CallTabItem <> TmpCallAllSearchItem then
      TmpCallAllSearchItem.Mouse.Clear;
    if CallTabItem <> TmpCallPasteItem then
      TmpCallPasteItem.Mouse.Clear;
    if CallTabItem <> TmpCallLaunchItem then
      TmpCallLaunchItem.Mouse.Clear;
    if CallTabItem <> TmpCallBkmkItem then
      TmpCallBkmkItem.Mouse.Clear;
  end;
  CheckInput;
end;

end.
