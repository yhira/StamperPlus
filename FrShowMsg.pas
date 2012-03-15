unit FrShowMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormShowMsg = class(TForm)
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  FormShowMsg: TFormShowMsg;

implementation

{$R *.dfm}

procedure TFormShowMsg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  FormShowMsg := nil;
end;

end.
