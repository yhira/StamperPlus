unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, yhFiles, ShellAPI, DateUtils, ComFunc;

type
  TFormAbout = class(TForm)
    Image1: TImage;
    VersionLabel: TLabel;
    URLLabel: TLabel;
    CopyRightLabel: TLabel;
    PaintBox: TPaintBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure URLLabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure URLLabelMouseLeave(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  FormAbout: TFormAbout;

implementation


{$R *.dfm}


procedure TFormAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormAbout.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  VersionLabel.Caption := 'Version ' + GetFileVersion(Application.ExeName);
  CopyRightLabel.Caption := 'Copyright (C) 2003-' + IntToStr(YearOf(now)) + ' by yhira';
  URLLabel.Caption := 'http://netakiri.net/';
end;

procedure TFormAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	Close;
end;

procedure TFormAbout.URLLabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  with URLLabel do begin
    Font.Style := [fsUnderline];
    Cursor := crHandPoint;
    Font.Color := clYellow;
  end;
end;

procedure TFormAbout.URLLabelMouseLeave(Sender: TObject);
begin
  with URLLabel do begin
    Font.Style := [];
    Cursor := crDefault;  
    Font.Color := clWhite;
  end;
end;

procedure TFormAbout.URLLabelClick(Sender: TObject);
begin
  with URLLabel do
  begin
    ShellExecute(Application.Handle,
                 PChar('open'), PChar(Caption),
                 PChar(0), nil, SW_NORMAL);
  end;
end;

procedure TFormAbout.PaintBoxPaint(Sender: TObject);
var lf: TLogFont;
begin
  with PaintBox.Canvas do begin
    GetObject(Font.Handle, SizeOf(TLogFont), @lf);
    lf.lfEscapement := 180;
    lf.lfHeight := 15;
    lf.lfWeight := 700;
    Font.Handle := CreateFontIndirect(lf);
    Brush.Style := bsClear;
    Font.Color := $004D4D4D;
//    TextOut(5, 40, 'Stamper');
//    lf.lfHeight := 13;
//    lf.lfWeight := 400;
//    Font.Handle := CreateFontIndirect(lf);
//    TextOut(8, 55, 'Ver.' + GetFileVersion(Application.ExeName));
//    TextOut(12, 67, '(C)2003-' + IntToStr(YearOf(now)) + ' by ' + APP_CREATOR);
//    TextOut(16, 79, WEBSITE_URL);
    TextOut(10, 45, 'Stamper+');
    lf.lfHeight := 13;
    lf.lfWeight := 400;
    Font.Handle := CreateFontIndirect(lf);
    TextOut(13, 60, 'Ver.' + GetFileVersion(Application.ExeName));
    TextOut(17, 73, '(C)2003-' + IntToStr(YearOf(now)) + ' by yhira');
  end;
end;

end.
