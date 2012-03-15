unit FrAddText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormAddText = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure SetText(const Value: string);
    function GetText: string;
    { Private êÈåæ }
  public
    { Public êÈåæ }
    property Text: string read GetText write SetText;
  end;

var
  FormAddText: TFormAddText;

implementation

{$R *.dfm}

{ TFormAddText }

function TFormAddText.GetText: string;
begin
  Result := Memo1.Text;
end;

procedure TFormAddText.SetText(const Value: string);
begin
  Memo1.Text := Value;
end;

procedure TFormAddText.FormCreate(Sender: TObject);
begin
  Memo1.Clear;
//  Label1.Caption := ''
end;

end.
