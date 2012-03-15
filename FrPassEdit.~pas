unit FrPassEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComDef;

type
  TFormPassEdit = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    PassEdit: TEdit;
    RePassEdit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    Label5: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PassEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private 宣言 }
    IsInputOk: Boolean;
  public
    { Public 宣言 }
  end;

var
  FormPassEdit: TFormPassEdit;

implementation

{$R *.dfm}

uses FrOption;

procedure TFormPassEdit.OKButtonClick(Sender: TObject);
begin
  if (PassEdit.Text = '') or (RePassEdit.Text = '') then
  begin
    Application.MessageBox('パスワードが入力されていません。'
      + #13#10 + '療法のパスワードを入力して下さい。',
      PChar('パスワードの設定'), MB_ICONINFORMATION);
    PassEdit.SetFocus;
    Abort;
  end;
  if Length(PassEdit.Text) < 4 then begin
    Application.MessageBox('パスワードは4文字以上で入力してください。',
      PChar('パスワードの設定'), MB_ICONINFORMATION);
    PassEdit.SetFocus;
    Abort;
  end;      
  if Length(PassEdit.Text) > 16 then begin
    Application.MessageBox('パスワードは16文字以下で入力してください。',
      PChar('パスワードの設定'), MB_ICONINFORMATION);
    PassEdit.SetFocus;
    Abort;
  end;

  if PassEdit.Text = RePassEdit.Text then
  begin
//    MainForm.BasicSetup.PassWord := PassEdit.Text;
    FormOption.TmpPassWord := PassEdit.Text;
    FormOption.CheckIsPassword.Checked := True;
    IsInputOk := True;
    Close;
  end
  else
  begin
    Application.MessageBox('設定したパスワードが、確認用のものと一致しません。'
      + #13#10 + 'もう一度パスワードを設定して下さい。',
      PChar('パスワードの設定'), MB_ICONINFORMATION);
    FormOption.TmpPassWord := DEF_PASS;
    FormOption.CheckIsPassword.Checked := False;
    PassEdit.Clear;
    RePassEdit.Clear;
    PassEdit.SetFocus;
  end;

end;

procedure TFormPassEdit.FormShow(Sender: TObject);
begin
  PassEdit.SetFocus;
  PassEdit.SelectAll;
end;

procedure TFormPassEdit.PassEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: OKButton.Click;
  end;
end;

procedure TFormPassEdit.FormActivate(Sender: TObject);
var
  Q: TPoint;
begin
  //マウスポインタを任意の位置に移動
  Q := Point(OKButton.Width div 2, OKButton.Height div 2);
  Q := OKButton.ClientToScreen(Q);
  SetCursorPos(Q.X, Q.Y);
end;

procedure TFormPassEdit.FormCreate(Sender: TObject);
begin
  IsInputOk := False;
end;

procedure TFormPassEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not IsInputOk then FormOption.CheckIsPassword.Checked := False;
end;

procedure TFormPassEdit.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

end.
