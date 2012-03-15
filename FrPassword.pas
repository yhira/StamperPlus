unit FrPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormPassword = class(TForm)
    EditPassWord: TEdit;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure EditPassWordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  FormPassword: TFormPassword;

implementation

{$R *.dfm}

procedure TFormPassword.FormCreate(Sender: TObject);
begin
  EditPassWord.Clear;
end;

procedure TFormPassword.EditPassWordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then ButtonOK.Click;
end;

end.
