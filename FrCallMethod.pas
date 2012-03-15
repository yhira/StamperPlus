unit FrCallMethod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, UntOption, UxTheme;

type
  TFormMousePosCallMethod = class(TForm)
    ButtonOK: TButton;
    ButtonCancel: TButton;
    CheckBoxLT: TCheckBox;
    CheckBoxRT: TCheckBox;
    CheckBoxLB: TCheckBox;
    CheckBoxRB: TCheckBox;
    PaintBoxCallMousePos: TPaintBox;
    StealthLabel: TLabel;
    SpinEditMouseCslRtnWidth: TSpinEdit;
    Pnl: TPanel;
    SpinEditMouseCslRtnTime: TSpinEdit;
    procedure PaintBoxCallMousePosPaint(Sender: TObject);
    procedure CheckBoxLTClick(Sender: TObject);
  private
    { Private 宣言 }
    function CheckSelOne: Boolean;
  public
    { Public 宣言 }
  end;

var
  FormMousePosCallMethod: TFormMousePosCallMethod;

implementation

{$R *.dfm}

procedure TFormMousePosCallMethod.PaintBoxCallMousePosPaint(Sender: TObject);
var
	rScreen, rWorkArea, r: TRect;
  RtnArea: Integer;
  a: Double;
  retW, retH: Real;
begin
  a := SpinEditMouseCslRtnWidth.Value;
  RtnArea := Trunc(a*0.5*(a/(a*(a/(10*(1+(a/40)))))));

  with PaintBoxCallMousePos.Canvas do begin
    rScreen := PaintBoxCallMousePos.ClientRect;
    retW := PaintBoxCallMousePos.Width / Screen.Width;
    retH := PaintBoxCallMousePos.Height / Screen.Height;

    r := Screen.WorkAreaRect;
    rWorkArea := Rect(Round(r.Left*retH), Round(r.Top*retH),
                      Round(r.Right*retW), Round(r.Bottom*retH));

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

    Brush.Color := clRed;
    Pen.Width := 2;
    Pen.Style := psSolid;
    Pen.Color := clWhite;
    r := PaintBoxCallMousePos.ClientRect;
		//左上
    if CheckBoxLT.Checked then begin
      Rectangle(r.Left,
      					r.Top,
                r.Left + RtnArea,
                r.Top + RtnArea);
    end;
    //右上
    if CheckBoxRT.Checked then begin
      Rectangle(r.Right -RtnArea,
                r.Top,
                r.Right,
                r.Top + RtnArea);
    end;
    //左下
    if CheckBoxLB.Checked then begin
      Rectangle(r.Left,
      					r.Bottom -RtnArea,
                r.Left + RtnArea,
                r.Bottom);
    end;
    //右下
    if CheckBoxRB.Checked then begin
      Rectangle(r.Right -RtnArea,
      					r.Bottom -RtnArea,
                r.Right,
                r.Bottom);
    end;
  end;
end;

procedure TFormMousePosCallMethod.CheckBoxLTClick(Sender: TObject);
begin
  PaintBoxCallMousePos.Invalidate;
  if not CheckSelOne then begin
    MessageDlg('マウス位置を一つは選択してください。', mtInformation, [mbOK], 0);
    if Sender is TCheckBox then TCheckBox(Sender).Checked := True;
  end;
end;

function TFormMousePosCallMethod.CheckSelOne: Boolean;
begin
  Result := CheckBoxLT.Checked or CheckBoxRT.Checked or
    CheckBoxLB.Checked or CheckBoxRB.Checked;
end;

end.
