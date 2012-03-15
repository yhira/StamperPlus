unit BugReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Clipbrd, ComCtrls, ShellAPI, yhFiles, ComDef;

type
  TFormBugReport = class(TForm)
    BugLabel: TLabel;
    BugMemo: TMemo;
    WebPageLabel: TLabel;
    CloseButton: TButton;
    CopyButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure WebPageLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WebPageLabelMouseLeave(Sender: TObject);
    procedure WebPageLabelClick(Sender: TObject);
  private
    { Private 宣言 }
//    function OSPlatformInfo: String;
//    function MemoryTotalInfo: String; // 物理メモリ容量
//    function MemoryActiveInfo: String;// 空きメモリ容量
//    function MemoryRateOfUse: String; // メモリ使用率
  public
    { Public 宣言 }
  end;

var
  FormBugReport: TFormBugReport;

implementation

{$R *.dfm}

procedure TFormBugReport.FormCreate(Sender: TObject);
var
  Partition, Title, Day, OSKind, MemTotal, MemActive, MemRateOfUse: String;
begin
  BugLabel.Caption := Application.Title + 'を使用して起きた不具合は、以下のテンプレートを' +
    '使用して報告して下さい。出来る限り対応します。';
  BugMemo.Clear;
//  WebPageLabel.Caption := '';

  Partition := '---------------------------------------------------';
  Day := FormatDateTime('yyyy/mm/dd',Now);
  Title := Application.Title + ' ' + GetFileVersion(Application.ExeName) + ' ' + 'バグレポート' + ' ' + Day;
  OSKind := OSPlatformInfo + '  ' + Win32CSDVersion;
  //OSBuild := IntToStr(OSver.dwBuildNumber);
  MemTotal := MemoryTotalInfo;
  MemActive := MemoryActiveInfo;
  MemRateOfUse := MemoryRateOfUse;

  BugMemo.Lines.Add(Partition);
  BugMemo.Lines.Add(Title);
  BugMemo.Lines.Add(Partition);
  BugMemo.Lines.Add('◇動作環境');
  BugMemo.Lines.Add('OS:'#9 + OSKind);
  BugMemo.Lines.Add('Memor:'#9 + MemTotal +
    ' ('+ MemActive + ' Free) ' + MemRateOfUse + '%');
  BugMemo.Lines.Add('SQLite:'#9 + 'Ver.' + SQLiteDB.Version);
  BugMemo.Lines.Add(Partition);
  BugMemo.Lines.Add('◇バグの状況');
  BugMemo.Lines.Add(#13);
  BugMemo.Lines.Add(Partition);
  BugMemo.Lines.Add('◇バグの発生手順');
  BugMemo.Lines.Add(#13);
  BugMemo.Lines.Add(Partition);  
//  BugMemo.Lines.Add('◇エラーログ');
//  BugMemo.Lines.Add(slLog.Text);
//  BugMemo.Lines.Add(Partition);

  BugMemo.SelStart := SendMessage(BugMemo.Handle, EM_LINEINDEX, 9, 0);

  Top := (Screen.Height - Height) div 2;
  Left := (Screen.Width - Width) div 2;
end;

procedure TFormBugReport.CopyButtonClick(Sender: TObject);
begin
  Clipboard.AsText := BugMemo.Text;
end;

procedure TFormBugReport.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBugReport.WebPageLabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := [fsUnderline];
  TLabel(Sender).Cursor := crHandPoint;
end;

procedure TFormBugReport.WebPageLabelMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  TLabel(Sender).Cursor := crDefault;
end;

procedure TFormBugReport.WebPageLabelClick(Sender: TObject);
begin
   with WebPageLabel do
   begin
      ShellExecute(Application.Handle,
                   PChar('open'), PChar(TLabel(Sender).Caption),
                   PChar(0), nil, SW_NORMAL);
   end;
end;

end.
