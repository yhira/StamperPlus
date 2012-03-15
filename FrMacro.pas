unit FrMacro;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ToolWin, ComCtrls, HKeyMacro, ActnList,
  Helper;

type
  TFormMacro = class(TForm)
    ButtonOK: TButton;
    ButtonCancel: TButton;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ButtonRec: TButton;
    ButtonExe: TButton;
    ButtonClear: TButton;
    LabelRec: TLabel;
    MemoRec: TMemo;
    MemoData: TMemo;
    ActionList1: TActionList;
    ActRec: TAction;
    ActExe: TAction;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure MemoDataChange(Sender: TObject);
    procedure ActRecExecute(Sender: TObject);
    procedure ActExeExecute(Sender: TObject);
    procedure MemoRecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure CheckEnabled;
  public
    IsRec: Boolean;
  end;

var
  FormMacro: TFormMacro;

implementation

{$R *.DFM}

procedure TFormMacro.FormCreate(Sender: TObject);
begin
  LabelRec.Caption := '';
  ButtonExe.Enabled := False;
  ButtonClear.Enabled := False;
  ButtonOK.Enabled := False;
  MemoRec.SelStart := Length(MemoRec.Text);
  MemoData.Clear;
end;

procedure TFormMacro.ButtonClearClick(Sender: TObject);
begin
  // マクロデータクリア
  MemoData.Text := '';
  MemoRec.SetFocus;
end;

procedure TFormMacro.CheckEnabled;
var IsEmptyData: Boolean;
begin
  IsEmptyData := (MemoData.Text <> '') and (not IsRec);
  ButtonOK.Enabled := IsEmptyData;
  ButtonExe.Enabled := IsEmptyData;
  ButtonClear.Enabled := IsEmptyData;
end;

procedure TFormMacro.MemoDataChange(Sender: TObject);
begin
  CheckEnabled;
end;

procedure TFormMacro.ActRecExecute(Sender: TObject);
begin
  // マクロ記録開始・記録終了
  IsRec := not IsRec;
  if IsRec then begin
    ButtonRec.Caption := '停止';
    LabelRec.Caption := '記録中';
    LabelRec.Font.Color := clRed;
    MemoData.Clear;
    MemoRec.Clear;
  end else begin        
    ButtonRec.Caption := '記録';
    LabelRec.Caption := '待機中';
    LabelRec.Font.Color := clBlue;
  end;
  CheckEnabled;
  MemoRec.SetFocus;
end;

procedure TFormMacro.ActExeExecute(Sender: TObject);
begin
  // マクロ実行
  ExcuteKeyMacro(MemoRec.Handle, MemoData.Text);
end;

procedure TFormMacro.MemoRecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s, KeyStr: string;
begin
  if not IsRec then Exit;
  if Key = 229 then Exit;
  s := MemoData.Text;
  KeyStr := VKeyToKeyStr(Key);
//  KeyStr := IntToHex(KeyStrToVKey(KeyStr), 2);
  s := s + KeyStr + ',';
//  s := s + VKeyToKeyStr(Key) + ',';
//  s := s + IntToHex(Key, 2) + ',';
  MemoData.Text := s;
end;

end.
