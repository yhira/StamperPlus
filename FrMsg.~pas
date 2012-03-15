unit FrMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormMsg = class(TForm)
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private 宣言 }
  protected
    procedure CreateParams(var vParams: TCreateParams); override;
  public
    { Public 宣言 }
  end;

var
  FormMsg: TFormMsg;

implementation

{$R *.dfm}

procedure TFormMsg.CreateParams(var vParams: TCreateParams);
begin
  inherited;
  with vParams do begin
    // フォーカスを取らず、親が関係ないウィンドウになっても不都合が
    // 起きないような設定。
    // 詳しくは Win32 API Help or MSDN を参照。
    Style := Style or WS_DISABLED or WS_POPUP;
    ExStyle := ExStyle or{ WS_EX_TOPMOST or }WS_EX_NOPARENTNOTIFY;
//    Parent := TWinControl(Owner);
//    if (FActiveWnd <> 0) and (IsWindow(FActiveWnd)) then
//      WndParent := FActiveWnd; // ウィンドウの親をアクティブウィンドウにする
  end;
end;

procedure TFormMsg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
