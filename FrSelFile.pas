unit FrSelFile;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Dialogs, Helper;

type
  TFormSelFile = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    EditFileName: TEdit;
    OpenDialog: TOpenDialog;
    SpeedButtonSel: TSpeedButton;
    LabelHint: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonSelClick(Sender: TObject);
    procedure EditFileNameChange(Sender: TObject);
  private
    { Private 宣言 }
    procedure Check;
  public
    { Public 宣言 }
  end;

var
  FormSelFile: TFormSelFile;

implementation

{$R *.dfm}

procedure TFormSelFile.Check;
begin
  OKBtn.Enabled := True;
  LabelHint.Caption := '';
  if EditFileName.Text = '' then begin
    OKBtn.Enabled := False;
    Exit;
  end;
  if not IsFileName(EditFileName.Text) then begin
    OKBtn.Enabled := False;
    LabelHint.Caption := 'ファイル名が不正です。';
    Exit;
  end;    
  if not FileExists(EditFileName.Text) then begin
    OKBtn.Enabled := False;
    LabelHint.Caption := '存在しないファイル名です。';
    Exit;
  end;
end;

procedure TFormSelFile.FormCreate(Sender: TObject);
begin
  EditFileName.Clear;
  LabelHint.Caption := '';
  Check;
end;

procedure TFormSelFile.SpeedButtonSelClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    EditFileName.Text := OpenDialog.FileName;
  end;
end;

procedure TFormSelFile.EditFileNameChange(Sender: TObject);
begin
  Check;
end;

end.
