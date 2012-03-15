unit FrOption;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Dialogs, yhFiles, Spin, yhOthers, FrmInput,
  FrmInput2, ComItems ,FrCallAction, FrPassEdit, ComDef, FolderDialog, ShellAPI,
  FrCallMethod, UntOption, UxTheme;

type
  TFormOption = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl: TPageControl;
    TabBasic: TTabSheet;
    TabDisp: TTabSheet;
    OKBtn: TButton;
    CancelBtn: TButton;
    TabSearch: TTabSheet;
    TabConf: TTabSheet;
    RadioGroupTabPosition: TRadioGroup;
    CheckHotTrack: TCheckBox;
    TreeMenu: TTreeView;
    TabDesign: TTabSheet;
    CheckAutoExpand: TCheckBox;
    FontDialog: TFontDialog;
    TabPath: TTabSheet;
    TabEdit: TTabSheet;
    CheckUseSound: TCheckBox;
    EditSoundFile: TEdit;
    ButtonSoundFile: TButton;
    Label1: TLabel;
    ColorBoxFormColor: TColorBox;
    CheckUseBrowser: TCheckBox;
    EditBrowserPath: TLabeledEdit;
    ButtonBrowserPath: TButton;
    EditEditorPath: TLabeledEdit;
    ButtonEditorPath: TButton;
    CheckListHintVisible: TCheckBox;
    CheckTreeHintVisible: TCheckBox;
    TabHistory: TTabSheet;
    GroupBox1: TGroupBox;
    RadioGroupTabStyle: TRadioGroup;
    OpenDialogSound: TOpenDialog;
    OpenDialogExe: TOpenDialog;
    ColorBoxTreeColor: TColorBox;
    ColorBoxListColor: TColorBox;
    ButtonTreeFont: TButton;
    ButtonListFont: TButton;
    SpinEditMaxClipHistory: TSpinEdit;
    CheckConfDelDir: TCheckBox;
    CheckConfDelItem: TCheckBox;
    CheckUseClipItemToTop: TCheckBox;
    TabCall: TTabSheet;
    PaintBoxDesktop: TPaintBox;
    RadioGroupDspPos: TRadioGroup;
    SpinEditTabSpaceCount: TSpinEdit;
    Label2: TLabel;
    LabelLineTop: TLabel;
    FrameInputLineTop: TFrameInput;
    LabelLineTopBottom: TLabel;
    FrameInputLineTopBottom: TFrameInput2;
    CheckBoxOneClickExcute: TCheckBox;
    ButtonCallLastUse: TButton;
    ButtonCallAllSearch: TButton;
    ButtonCallPaste: TButton;
    ButtonCallLaunch: TButton;
    ButtonCallBkmk: TButton;
    ButtonCallClip: TButton;
    SpinEditCallBackMargin: TSpinEdit;
    ColorBoxHintColor: TColorBox;
    gbPass: TGroupBox;
    CheckIsPassword: TCheckBox;
    ButtonPassword: TButton;
    CheckConfPasteXmlExport: TCheckBox;
    LabelHint: TLabel;
    CheckIsClipToDirName: TCheckBox;
    CheckIsClipToPasteName: TCheckBox;
    CheckIsClipToLauncherName: TCheckBox;
    CheckIsClipToBkmkName: TCheckBox;
    CheckIsClipToPasteTexs: TCheckBox;
    CheckSearchDispDir: TCheckBox;
    CheckConfDelDbShortcut: TCheckBox;
    CheckConfDelDbHot: TCheckBox;
    CheckConfDelDbMouse: TCheckBox;
    TabDateTime: TTabSheet;
    MemoDateTimeHint: TMemo;
    EditDateFmt: TLabeledEdit;
    EditTimeFmt: TLabeledEdit;
    EditDateTimeFmt: TLabeledEdit;
    EditListDateTimeFmt: TLabeledEdit;
    CheckIsStartup: TCheckBox;
    CheckDispLauncherExt: TCheckBox;
    TabBackup: TTabSheet;
    CheckAutoBacup: TCheckBox;
    RadioGroupBackupMode: TRadioGroup;
    EditBackupDir: TLabeledEdit;
    ButtonBackupDir: TButton;
    FolderDialog: TFolderDialog;
    ButtonBackupNow: TButton;
    ButtonOpenBackupDir: TButton;
    LabelBackup: TLabel;
    LabelLastBackupDate: TLabel;
    SpinEditLeaveBackupFiles: TSpinEdit;
    Label3: TLabel;
    RadioGroupCallMethod: TRadioGroup;
    ButtonCallMethod: TButton;
    Label4: TLabel;
    CheckDispItemAddInfo: TCheckBox;
    ColorBoxMemoColor: TColorBox;
    ButtonMemoFont: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TreeMenuChange(Sender: TObject; Node: TTreeNode);
    procedure TreeMenuCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure RadioGroupTabPositionClick(Sender: TObject);
    procedure ButtonSoundFileClick(Sender: TObject);
    procedure CheckUseSoundClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonBrowserPathClick(Sender: TObject);
    procedure ButtonEditorPathClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonTreeFontClick(Sender: TObject);
    procedure ButtonListFontClick(Sender: TObject);
    procedure PaintBoxDesktopPaint(Sender: TObject);
    procedure RadioGroupDspPosClick(Sender: TObject);
    procedure FrameInput1ListBoxClick(Sender: TObject);
    procedure FrameInputLineHeadButtonAddClick(Sender: TObject);
    procedure FrameInputLineHeadButtonChangeClick(Sender: TObject);
    procedure FrameInputLineHeadButtonDeleteClick(Sender: TObject);
    procedure FrameInputLineTopBottomStringGridClick(Sender: TObject);
    procedure FrameInputLineTopBottomButtonAddClick(Sender: TObject);
    procedure FrameInputLineTopBottomButtonChangeClick(Sender: TObject);
    procedure FrameInputLineTopBottomButtonDeleteClick(Sender: TObject);
    procedure ButtonCallLastUseClick(Sender: TObject);
    procedure ButtonCallAllSearchClick(Sender: TObject);
    procedure ButtonCallPasteClick(Sender: TObject);
    procedure ButtonCallLaunchClick(Sender: TObject);
    procedure ButtonCallBkmkClick(Sender: TObject);
    procedure ButtonCallClipClick(Sender: TObject);
    procedure CheckIsPasswordClick(Sender: TObject);
    procedure ButtonPasswordClick(Sender: TObject);
    procedure CheckIsPasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonBackupNowClick(Sender: TObject);
    procedure ButtonOpenBackupDirClick(Sender: TObject);
    procedure ButtonBackupDirClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure SpinEditLeaveBackupFilesChange(Sender: TObject);
    procedure RadioGroupCallMethodClick(Sender: TObject);
    procedure ButtonCallMethodClick(Sender: TObject);
    procedure ButtonMemoFontClick(Sender: TObject);
  private
    procedure DispLineTop;
    procedure DispLineTopBottom;
    procedure ShowModalCallAction(Item: TCallTabItem);
    procedure UpdateLastBackupDate;
    { Private 宣言 }
  public
    { Public 宣言 }
    TmpTreeFont,
    TmpListFont,
    TmpMemoFont: TFont;
    TmpCallLastItem,
    TmpCallAllSearchItem,
    TmpCallPasteItem,
    TmpCallLaunchItem,
    TmpCallBkmkItem,
    TmpCallClipItem: TCallTabItem;
    TmpPassWord: string;
    TmpMouseCslRtnPoses: TMouseCslRtnPoses;
    TmpMouseCslRtnWidth: Integer;   
    TmpMouseCslRtnTime: Integer;
    procedure ShowHint(Sender: TObject);
//    TmpIsPassWord: Boolean;
  end;

var
  FormOption: TFormOption;

implementation

{$R *.dfm}

uses FrMain, Grids;

procedure TFormOption.FormCreate(Sender: TObject);
var i: Integer; Tab: TTabSheet;
begin
  for i := 0 to PageControl.PageCount-1 do begin
    Tab := PageControl.Pages[i];
    TreeMenu.Items.Add(nil, Tab.Caption);
    Tab.TabVisible := False;
  end;
  PageControl.ActivePage := TabBasic;     
//  PageControl.ActivePage := TabCall;
  TreeMenu.Items[PageControl.ActivePageIndex].Selected := True;
  TmpTreeFont := TFont.Create;
  TmpListFont := TFont.Create;
  TmpMemoFont := TFont.Create;
  TmpCallLastItem := TCallTabItem.Cleate;
  TmpCallAllSearchItem := TCallTabItem.Cleate;
  TmpCallPasteItem := TCallTabItem.Cleate;
  TmpCallLaunchItem := TCallTabItem.Cleate;
  TmpCallBkmkItem := TCallTabItem.Cleate;
  TmpCallClipItem := TCallTabItem.Cleate;

  LabelLineTop.Caption := ''; 
  LabelLineTopBottom.Caption := '';   
  LabelHint.Caption := '';
  LabelBackup.Caption :=
    'レストアは、バックアップフォルダからファイルを選び｢' +
    ExtractFileName(DbFile) + '」にリネームし、カレントフォルダの｢' +
    ExtractFileName(DbFile) + '」に上書きしてください。'#13#10#13#10 +
    'パスワードを設定している場合は、同じパスワードを起動時指定しないとレストアできません。';
  UpdateLastBackupDate;
  RadioGroupCallMethod.Hint :=
    'マウスクリック：画面の任意の場所をクリックして呼び出す方式。'#13#10 +
    'マウスカーソル位置：画面の四隅にカーソルを指定時間置くと呼び出す方式。（Stamper2の呼び出し方式）';
//  CheckIsPassword.Checked := IsPassWord;
//  TreeMenu.FullExpand;
end;

procedure TFormOption.TreeMenuChange(Sender: TObject; Node: TTreeNode);
begin
  PageControl.ActivePageIndex := TreeMenu.Selected.AbsoluteIndex;
end;

procedure TFormOption.TreeMenuCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse := False;
end;

procedure TFormOption.RadioGroupTabPositionClick(Sender: TObject);
begin
  RadioGroupTabStyle.Enabled := (RadioGroupTabPosition.ItemIndex = Ord(tpTop));
  if not RadioGroupTabStyle.Enabled then RadioGroupTabStyle.ItemIndex := 0;
end;

procedure TFormOption.ButtonSoundFileClick(Sender: TObject);
begin
  OpenDialogSound.FileName := EditSoundFile.Text;
  if OpenDialogSound.Execute then
    EditSoundFile.Text := OpenDialogSound.FileName;
end;

procedure TFormOption.CheckUseSoundClick(Sender: TObject);
begin
  EditSoundFile.Enabled := CheckUseSound.Checked;
  ButtonSoundFile.Enabled := CheckUseSound.Checked;
end;

procedure TFormOption.FormShow(Sender: TObject);
begin
  CheckUseSoundClick(nil);
  RadioGroupTabPositionClick(nil);
  if FrameInputLineTop.ListBox.Items.Count <> 0 then
    FrameInputLineTop.ListBox.ItemIndex := 0;
  DispLineTop;
  DispLineTopBottom;
end;

procedure TFormOption.ButtonBrowserPathClick(Sender: TObject);
begin
  if OpenDialogExe.Execute then
    EditBrowserPath.Text := OpenDialogExe.FileName;
end;

procedure TFormOption.ButtonEditorPathClick(Sender: TObject);
begin
  if OpenDialogExe.Execute then
    EditEditorPath.Text := OpenDialogExe.FileName;
end;

procedure TFormOption.FormDestroy(Sender: TObject);
begin
  TmpTreeFont.Free;
  TmpListFont.Free;
  TmpMemoFont.Free;  
  TmpCallLastItem.Free;
  TmpCallAllSearchItem.Free;
  TmpCallPasteItem.Free;
  TmpCallLaunchItem.Free;
  TmpCallBkmkItem.Free;
  TmpCallClipItem.Free;
end;

procedure TFormOption.ButtonTreeFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(TmpTreeFont);
  if FontDialog.Execute then TmpTreeFont.Assign(FontDialog.Font);
end;

procedure TFormOption.ButtonListFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(TmpListFont);
  if FontDialog.Execute then TmpListFont.Assign(FontDialog.Font);
end;

procedure TFormOption.PaintBoxDesktopPaint(Sender: TObject);
  procedure DrowForm(rForm: TRect);
//  var r: TRect;
  begin
    with PaintBoxDesktop.Canvas do begin
      Pen.Color := clBlue;
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      Rectangle(rForm);
      Brush.Color := clActiveCaption;
      Rectangle(Rect(rForm.Left, rForm.Top, rForm.Right, rForm.Top + 5))
    end;
  end;
var rScreen, rWorkArea, rForm, rForm1, rForm2, r: TRect; sDsk: string; DskX, DskY: Integer;
  retW, retH: Real; p: TPoint; //ap: array[0..6] of TPoint;
begin
  with PaintBoxDesktop.Canvas do begin
    rScreen := PaintBoxDesktop.ClientRect;
    retW := PaintBoxDesktop.Width / Screen.Width;
    retH := PaintBoxDesktop.Height / Screen.Height;
//    rScreen := Screen.DesktopRect;
    r := Screen.WorkAreaRect;
    rWorkArea := Rect(Round(r.Left*retH), Round(r.Top*retH),
                      Round(r.Right*retW), Round(r.Bottom*retH));
//    rTask := Rect(rScreen.Left - rWorkArea.Left,
//                  rScreen.Top - rWorkArea.Top,
//                  rScreen.Right - rWorkArea.Right,)
    Pen.Style := psSolid;
    Pen.Color := clWhite;
    Pen.Width := 1;
    if UseThemes then
      Brush.Color := clBlue
    else
      Brush.Color := clBtnFace;
    FillRect(rScreen);
    Brush.Color := clBackground;
    FillRect(rWorkArea);

    r := FormStancher.BoundsRect;
    rForm := Rect(Round(r.Left*retH), Round(r.Top*retH),
                      Round(r.Right*retW), Round(r.Bottom*retH));
    p := Point(rForm.Left + ((rForm.Right - rForm.Left) div 2),
               rForm.Top + ((rForm.Bottom - rForm.Top) div 2));

    case RadioGroupDspPos.ItemIndex of
      0: DrowForm(rForm);
      1: begin
        DrowForm(rForm);
        Pen.Color := clBlack;
        Brush.Color := clWhite;
        DrawIcon(Handle, p.X, p.Y, LoadCursor(0, IDC_ARROW));
//        ap[0] := p;
//        ap[1] := Point(p.X, p.Y + 10);
//        ap[2] := Point(p.X + 4, p.Y + 8);
//        ap[3] := Point(p.X + 8, p.Y + 14);
//        ap[4] := Point(p.X + 10, p.Y + 12);
//        ap[5] := Point(p.X + 6, p.Y + 7);
//        ap[6] := Point(p.X + 10, p.Y + 4);
//        Polygon(ap);
      end;
      2: begin
        rForm1 := Rect(rWorkArea.Left, rWorkArea.Top, rWorkArea.Right div 4, rWorkArea.Bottom);
        rForm2 := Rect(rWorkArea.Right*3 div 4, rWorkArea.Top, rWorkArea.Right, rWorkArea.Bottom);
        DrowForm(rForm1);
        DrowForm(rForm2);
      end;
      else begin
        rForm1 := Rect(rWorkArea.Left, rWorkArea.Top, rWorkArea.Right, rWorkArea.Bottom div 4);
        rForm2 := Rect(rWorkArea.Left, rWorkArea.Bottom*3 div 4, rWorkArea.Right, rWorkArea.Bottom);
        DrowForm(rForm1);
        DrowForm(rForm2);
      end;
    end;


    Brush.Style := bsClear;
    sDsk := 'デスクトップ画面';
    DskX := (PaintBoxDesktop.Width - TextWidth(sDsk)) div 2;
    DskY := (PaintBoxDesktop.Height - TextHeight(sDsk)) div 2;   
    Font.Color := clBlack;
    TextOut(DskX + 1, DskY + 1, sDsk);
    Font.Color := clWhite;
    TextOut(DskX, DskY, sDsk);

  end;
end;

procedure TFormOption.RadioGroupDspPosClick(Sender: TObject);
begin
  PaintBoxDesktop.Invalidate;
end;

procedure TFormOption.DispLineTop;
begin
  with FrameInputLineTop.ListBox do
    if ItemIndex <> -1 then
      LabelLineTop.Caption := Format(Items[ItemIndex] + '1行目の文字列', [1]) + #13#10 +
                             Format(Items[ItemIndex] + '2行目の文字列', [2]);

end;

procedure TFormOption.DispLineTopBottom;
begin
  with FrameInputLineTopBottom.StringGrid do
    if Cells[0, 0] <> '' then
      LabelLineTopBottom.Caption := Cells[0, Row] + '文字列' + Cells[1, Row];
end;

procedure TFormOption.FrameInput1ListBoxClick(Sender: TObject);
begin
  FrameInputLineTop.ListBoxClick(Sender);
  DispLineTop;
end;

procedure TFormOption.FrameInputLineHeadButtonAddClick(Sender: TObject);
begin
  FrameInputLineTop.ButtonAddClick(Sender);
  DispLineTop;
end;

procedure TFormOption.FrameInputLineHeadButtonChangeClick(Sender: TObject);
begin
  FrameInputLineTop.ButtonChangeClick(Sender);
  DispLineTop;
end;

procedure TFormOption.FrameInputLineHeadButtonDeleteClick(Sender: TObject);
begin
  FrameInputLineTop.ButtonDeleteClick(Sender);
  LabelLineTop.Caption := '';
end;

procedure TFormOption.FrameInputLineTopBottomStringGridClick(
  Sender: TObject);
begin
  FrameInputLineTopBottom.StringGridClick(Sender);
  DispLineTopBottom;
end;

procedure TFormOption.FrameInputLineTopBottomButtonAddClick(
  Sender: TObject);
begin
  FrameInputLineTopBottom.ButtonAddClick(Sender);
  DispLineTopBottom;
end;

procedure TFormOption.FrameInputLineTopBottomButtonChangeClick(
  Sender: TObject);
begin
  FrameInputLineTopBottom.ButtonChangeClick(Sender);
  DispLineTopBottom;
end;

procedure TFormOption.FrameInputLineTopBottomButtonDeleteClick(
  Sender: TObject);
begin
  FrameInputLineTopBottom.ButtonDeleteClick(Sender);
  LabelLineTopBottom.Caption := '';
end;

procedure TFormOption.ButtonCallLastUseClick(Sender: TObject);
begin
  ShowModalCallAction(TmpCallLastItem);
end;

procedure TFormOption.ShowModalCallAction(Item: TCallTabItem);
begin
  FormCallAction := TFormCallAction.Create(Self);
  try
    FormCallAction.CallTabItem := Item;
    FormCallAction.ItemToForm(Item);
    if FormCallAction.ShowModal = mrOk then begin
      FormCallAction.FormToItem(Item);
      Item.ShortCutkey.Update;   
      Item.Hotkey.Update;
      Item.Mouse.Update;
    end;
  finally
    FormCallAction.Release;
  end;
end;

procedure TFormOption.ButtonCallAllSearchClick(Sender: TObject);
begin
  ShowModalCallAction(TmpCallAllSearchItem);
end;

procedure TFormOption.ButtonCallPasteClick(Sender: TObject);
begin
  ShowModalCallAction(TmpCallPasteItem);
end;

procedure TFormOption.ButtonCallLaunchClick(Sender: TObject);
begin
  ShowModalCallAction(TmpCallLaunchItem);
end;

procedure TFormOption.ButtonCallBkmkClick(Sender: TObject);
begin
  ShowModalCallAction(TmpCallBkmkItem);
end;

procedure TFormOption.ButtonCallClipClick(Sender: TObject);
begin
  ShowModalCallAction(TmpCallClipItem);
end;

procedure TFormOption.CheckIsPasswordClick(Sender: TObject);
begin
  ButtonPassword.Enabled := CheckIsPassword.Checked;
//  if not CheckIsPassword.Checked then begin
//    PassWord := DEF_PASS;
//    isp
//  end;
end;

procedure TFormOption.ButtonPasswordClick(Sender: TObject);
begin
  FormPassEdit := TFormPassEdit.Create(Self); 
//  FormPassEdit.PassEdit.Text := TmpPassWord;
  try
    FormPassEdit.ShowModal;
  finally
    FormPassEdit.Release;
  end;
end;

procedure TFormOption.CheckIsPasswordMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if CheckIsPassword.Checked then begin
    ButtonPasswordClick(nil);
  end;
end;

procedure TFormOption.ShowHint(Sender: TObject);
begin
  LabelHint.Caption := Application.Hint;
end;

procedure TFormOption.ButtonBackupNowClick(Sender: TObject);
begin
  FormStancher.Backup;
  Beep;
  MessageDlg('バックアップ完了', mtInformation, [mbOK], 0);
  UpdateLastBackupDate;
end;

procedure TFormOption.ButtonOpenBackupDirClick(Sender: TObject);
begin
  if DirectoryExists(FormStancher.Option.BackupDir) then
    ShellExecute(Application.Handle, 'open', PChar(FormStancher.Option.BackupDir),
      nil, nil, SW_SHOWNORMAL)
  else
    if MessageDlg('バックアップ先フォルダが存在しません。' + #13#10 +
          '作成しますか？', mtInformation, [mbYes, mbNo], 0) = mrYes then
      ForceDirectories(FormStancher.Option.BackupDir);
end;

procedure TFormOption.ButtonBackupDirClick(Sender: TObject);
begin
  if FolderDialog.Execute then
    EditBackupDir.Text := FolderDialog.Directory;
end;

procedure TFormOption.PageControlChange(Sender: TObject);
begin
  TreeMenu.Items[PageControl.ActivePageIndex].Selected := True;
end;

procedure TFormOption.UpdateLastBackupDate;
begin
  LabelLastBackupDate.Caption :=
    '最終バックアップ：' +
    FormatDateTime('yyyy/mm/dd hh:nn:ss', FormStancher.Option.LastBackupDate);
  if FormStancher.Option.LastBackupDate = 0 then
    LabelLastBackupDate.Caption := '';
end;

procedure TFormOption.SpinEditLeaveBackupFilesChange(Sender: TObject);
begin
  if FormStancher.Option.LeaveBackupFiles <> SpinEditLeaveBackupFiles.Value then
    ButtonBackupNow.Enabled := False
  else
    ButtonBackupNow.Enabled := True;
end;

procedure TFormOption.RadioGroupCallMethodClick(Sender: TObject);
begin
  ButtonCallMethod.Enabled := RadioGroupCallMethod.ItemIndex = 1;
end;

procedure TFormOption.ButtonCallMethodClick(Sender: TObject);
begin
  FormMousePosCallMethod := TFormMousePosCallMethod.Create(Self);
  with FormMousePosCallMethod do begin

    if mpLeftTop in TmpMouseCslRtnPoses then
      CheckBoxLT.Checked := True;
    if mpLeftBottom in TmpMouseCslRtnPoses then
      CheckBoxLB.Checked := True;
    if mpRightTop in TmpMouseCslRtnPoses then
      CheckBoxRT.Checked := True;
    if mpRightBottom in TmpMouseCslRtnPoses then
      CheckBoxRB.Checked := True;
    SpinEditMouseCslRtnWidth.Value := TmpMouseCslRtnWidth;
    SpinEditMouseCslRtnTime.Value := TmpMouseCslRtnTime;

    try
      if FormMousePosCallMethod.ShowModal = mrOK then begin
        TmpMouseCslRtnPoses := [];
        if CheckBoxLT.Checked then
          TmpMouseCslRtnPoses := TmpMouseCslRtnPoses + [mpLeftTop];     
        if CheckBoxLB.Checked then
          TmpMouseCslRtnPoses := TmpMouseCslRtnPoses + [mpLeftBottom];
        if CheckBoxRT.Checked then
          TmpMouseCslRtnPoses := TmpMouseCslRtnPoses + [mpRightTop];
        if CheckBoxRB.Checked then
          TmpMouseCslRtnPoses := TmpMouseCslRtnPoses + [mpRightBottom];
        TmpMouseCslRtnWidth := SpinEditMouseCslRtnWidth.Value;  
        TmpMouseCslRtnTime := SpinEditMouseCslRtnTime.Value;
      end;
    finally
      FormMousePosCallMethod.Free;
    end;
  end;
end;

procedure TFormOption.ButtonMemoFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(TmpMemoFont);
  if FontDialog.Execute then TmpMemoFont.Assign(FontDialog.Font);
end;

end.

