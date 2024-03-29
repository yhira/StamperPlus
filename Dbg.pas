unit Dbg;

interface

uses
  Windows, Messages, Forms, Graphics, SysUtils;

const
  DClear:Char = #1;
  DClose:Char = #2;
  DBeep:Char  = #3;

var
  hDebugWnd:HWND;
  hDebugMemo:HWND;

procedure DOut(const Value:string);   
procedure DOutI(const Value:Integer);  
procedure DOutH(const Value:Integer);
procedure DOutB(const Value:Boolean);  
procedure DOutP(const Value: TPoint);
procedure DOutClear; 
procedure DOutClose;

implementation

var
  Fnt:TFont;

function DebugWndProc(hWindow: HWND; Msg: UINT; WParam: WPARAM;
                      LParam: LPARAM): LRESULT; stdcall;
var
  r:TRect;
begin
  Result := 0;

  case Msg of

    WM_CREATE:begin
      hDebugMemo := CreateWindowEx(WS_EX_CLIENTEDGE,
                          'EDIT',
                          '',
                          $54210044 or ES_NOHIDESEL or ES_READONLY,
                          0,0,0,0,
                          hWindow,
                          1234,
                          hInstance,
                          nil);
      Fnt := TFont.Create;
      Fnt.Name := '�l�r �S�V�b�N';
      Fnt.Size := 14;
      SendMessage(hDebugMemo,WM_SETFONT,Fnt.Handle,1);
    end;

    WM_SIZE:begin
      GetClientRect(hWindow,r);
      SetWindowPos(hDebugMemo,0,0,0,r.Right,r.Bottom,SWP_NOMOVE or SWP_NOZORDER);
    end;

    WM_DESTROY:begin
      hDebugWnd := 0;
      Fnt.Free;
    end;

  else begin
    result := DefWindowProc( hWindow, Msg, wParam, lParam );
    exit;
    end;

  end; // case

end;

procedure CreateDebugWnd;
var
  wc: TWndClass;
begin
  wc.lpszClassName   := 'MyDebugWnd';
  wc.lpfnWndProc     := @DebugWndProc;
  wc.style           := CS_VREDRAW or CS_HREDRAW;
  wc.hInstance       := hInstance;
  wc.hIcon           := LoadIcon(0,IDI_APPLICATION);
  wc.hCursor         := LoadCursor(0,IDC_ARROW);
  wc.hbrBackground   := (COLOR_WINDOW+1);
  wc.lpszMenuName    := nil;
  wc.cbClsExtra      := 0;
  wc.cbWndExtra      := 0;

  RegisterClass(wc);

  hDebugWnd := CreateWindowEx(WS_EX_CONTROLPARENT or WS_EX_WINDOWEDGE,
                          'MyDebugWnd',
                          'DebugWnd',
                          WS_VISIBLE or WS_CLIPSIBLINGS or
                          WS_CLIPCHILDREN or WS_OVERLAPPEDWINDOW,
                          0,0,
                          300,200,
                          Application.Handle,
                          0,
                          hInstance,
                          nil);

   ShowWindow(hDebugWnd,CmdShow);
   UpDateWindow(hDebugWnd);
end;

procedure Confirm;
begin
  if hDebugWnd = 0 then CreateDebugWnd;
end;

procedure Clear;
var
  s:string;
begin
  s := '';
  SendMessage(hDebugMemo,WM_SETTEXT,0,LPARAM(PChar(s)));
end;

procedure AddALine(const Value:string);
var
  s:string;
begin
  s := value+#13#10;
  SendMessage(hDebugMemo,EM_REPLACESEL,0,LPARAM(PChar(s)));
end;

procedure DOut(const Value:string);
begin
  Confirm;
  case Byte(Value[1]) of
    1:Clear;
    2:DestroyWindow(hDebugWnd);
    3:MessageBeep($FFFFFFFF);
  else
    AddALine(Value);
  end;
end;

procedure DOutClear;
begin
  Clear;
end;

procedure DOutClose;
begin
  DestroyWindow(hDebugWnd);
end;

procedure DOutI(const Value:Integer);
begin
  DOut(IntToStr(Value));
end;

procedure DOutH(const Value:Integer);
begin
  DOut(IntToHex(Value, 8));
end;

procedure DOutB(const Value:Boolean);
begin
  DOut(BoolToStr(Value, True));
end;

procedure DOutP(const Value: TPoint);
begin
  DOut('X = ' + IntToStr(Value.X) + ', Y = ' + IntToStr(Value.Y));
end;

end.
