unit FrmMouseAction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls, ComItems, Dbg;

type
  TFrameMouseAction = class(TFrame)
    GroupBoxMouse: TGroupBox;
    LabelMouseHint: TLabel;
    CheckBoxMouseEnabled: TCheckBox;
    GroupBoxMouseRtnPoses: TGroupBox;
    CheckBoxMouseRtnPosAll: TCheckBox;
    CheckBoxMouseRtnPosDeskTop: TCheckBox;
    CheckBoxMouseRtnPosTaskBar: TCheckBox;
    CheckBoxMouseRtnPosLT: TCheckBox;
    CheckBoxMouseRtnPosMT: TCheckBox;
    CheckBoxMouseRtnPosRT: TCheckBox;
    CheckBoxMouseRtnPosRM: TCheckBox;
    CheckBoxMouseRtnPosRB: TCheckBox;
    CheckBoxMouseRtnPosMB: TCheckBox;
    CheckBoxMouseRtnPosLB: TCheckBox;
    CheckBoxMouseRtnPosLM: TCheckBox;
    GroupBoxMouseKeys: TGroupBox;
    CheckBoxMouseKeyLClk: TCheckBox;
    CheckBoxMouseKeyRClk: TCheckBox;
    CheckBoxMouseKeyMClk: TCheckBox;
    CheckBoxMouseKeyCtrl: TCheckBox;
    CheckBoxMouseKeyShift: TCheckBox;
    RadioGroupMouseAction: TRadioGroup;
    CheckBoxMouseKeyAlt: TCheckBox;
    Label1: TLabel;
    ButtonAllDesktop: TButton;
    procedure CheckEnabledMouse(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure CheckBoxMouseRtnPosAllClick(Sender: TObject);
    procedure ButtonAllDesktopClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    procedure SetMouses(Mouse: TMouseItem);
    procedure GetMouses(Mouse: TMouseItem);
    function EmptyMouseValue(GB: TGroupBox): Boolean;
    function GetMouseKeys: TMouseKeys;
    function GetMouseRtnPoses: TMouseRtnPoses;   
    procedure MakeMouseHint;
    function GetMouseKeyFlags: Integer;      
    procedure EnabledMouseSettings;
    { Public 宣言 }   
  end;

implementation

{$R *.dfm}


function TFrameMouseAction.EmptyMouseValue(GB: TGroupBox): Boolean;
var i: Integer; c: TCheckBox;
begin
  Result := True;
  for i := 0 to GB.ControlCount-1 do begin
    c := TCheckBox(GB.Controls[i]);
    if c.Checked then begin
      Result := False;
    end;
  end;
end;

procedure TFrameMouseAction.MakeMouseHint;
var sAct, sKeys, sRtn{, sDsp}: string; i: Integer; cb: TCheckBox;
begin                         
  sAct := '[ ' + RadioGroupMouseAction.Items[RadioGroupMouseAction.ItemIndex] + ' ]';
  sKeys := '[ ';
  for i := 0 to GroupBoxMouseKeys.ControlCount-1 do begin
    cb := TCheckBox(GroupBoxMouseKeys.Controls[i]);
    if cb.Checked then sKeys := sKeys + cb.Caption + ', ';
  end;
  if Pos(',', sKeys) > 0 then
    sKeys := Copy(sKeys, 1, Length(sKeys)-2);
  sKeys := sKeys + ' ]' + 'を押しながら';
  if EmptyMouseValue(GroupBoxMouseKeys) then sKeys := '';
  sRtn := '[ ' + GroupBoxMouseRtnPoses.Caption + ' ]';
//  sDsp := '[' + RadioGroupMouseDspPos.Items[RadioGroupMouseDspPos.ItemIndex] + ']';
  LabelMouseHint.Caption := sRtn + 'を' + sKeys +
    sAct + 'するとアイテムを実行。';// + sDsp + 'に表示。';
end;

procedure TFrameMouseAction.CheckEnabledMouse(Sender: TObject);
begin
  EnabledMouseSettings;
end;

procedure TFrameMouseAction.EnabledMouseSettings;
  procedure SetCompos(Ctrl: TGroupBox;AEnabled: Boolean);
  var i: Integer; c: TControl;
  begin
    for i := 0 to Ctrl.ControlCount-1 do begin
      c := Ctrl.Controls[i];
      if c is TGroupBox then
        SetCompos(TGroupBox(c), AEnabled);
      if c <> CheckBoxMouseEnabled then c.Enabled := AEnabled;
    end;
  end;
var IsEnabled, IsEmptyMouseKeys, IsSelL, IsSelR, IsSelM: Boolean;
begin
  IsEnabled := CheckBoxMouseEnabled.Checked;
  SetCompos(GroupBoxMouse, IsEnabled);
  if IsEnabled then MakeMouseHint
  else LabelMouseHint.Caption := '';
  if not IsEnabled then Exit;
  IsSelL := False;IsSelR := False; IsSelM := False;
  IsEmptyMouseKeys := EmptyMouseValue(GroupBoxMouseKeys);
  if IsEmptyMouseKeys then begin
    CheckBoxMouseRtnPosAll.Enabled := not IsEmptyMouseKeys;
    CheckBoxMouseRtnPosAll.Checked := not IsEmptyMouseKeys;
  end;
  case RadioGroupMouseAction.ItemIndex of
    0..1: IsSelL := True;
    2..3: IsSelR := True;
    4..5: IsSelM := True;
  end;
  CheckBoxMouseKeyLClk.Enabled := not IsSelL;
  if IsSelL then
    CheckBoxMouseKeyLClk.Checked := False;
  CheckBoxMouseKeyRClk.Enabled := not IsSelR;
  if IsSelR then
    CheckBoxMouseKeyRClk.Checked := False;
  CheckBoxMouseKeyMClk.Enabled := not IsSelM;
  if IsSelM then
    CheckBoxMouseKeyMClk.Checked := False;
end;

function TFrameMouseAction.GetMouseKeyFlags: Integer;
var mi: TMouseItem;
begin
  mi := TMouseItem.Create;
  try
    mi.Keys := GetMouseKeys;
    Result := mi.KeyFlags;
  finally
    mi.Free;
  end;
end;

procedure TFrameMouseAction.GetMouses(Mouse: TMouseItem);
begin             
  Mouse.Action := TMouseAction(RadioGroupMouseAction.ItemIndex);
  Mouse.Keys := GetMouseKeys;
  Mouse.RtnPoses := GetMouseRtnPoses;     
  Mouse.Enabled := CheckBoxMouseEnabled.Checked;
end;

procedure TFrameMouseAction.SetMouses(Mouse: TMouseItem);
begin
  CheckBoxMouseEnabled.Checked := Mouse.Enabled;
  RadioGroupMouseAction.ItemIndex := Integer(Mouse.Action);
  CheckBoxMouseKeyLClk.Checked := mkLBtn in Mouse.Keys;
  CheckBoxMouseKeyRClk.Checked := mkRBtn in Mouse.Keys;
  CheckBoxMouseKeyMClk.Checked := mkMBtn in Mouse.Keys;
  CheckBoxMouseKeyCtrl.Checked := mkCtrl in Mouse.Keys;
  CheckBoxMouseKeyShift.Checked := mkShift in Mouse.Keys;   
  CheckBoxMouseKeyAlt.Checked := mkAlt in Mouse.Keys;
//  CheckBoxMouseRtnPosAll.Checked := mrpAll in Mouse.RtnPoses;
  CheckBoxMouseRtnPosDeskTop.Checked := mrpDeskTop in Mouse.RtnPoses;
  CheckBoxMouseRtnPosTaskBar.Checked := mrpTaskBar in Mouse.RtnPoses;
  CheckBoxMouseRtnPosLT.Checked := mrpLT in Mouse.RtnPoses;
  CheckBoxMouseRtnPosMT.Checked := mrpMT in Mouse.RtnPoses;
  CheckBoxMouseRtnPosRT.Checked := mrpRT in Mouse.RtnPoses;
  CheckBoxMouseRtnPosRM.Checked := mrpRM in Mouse.RtnPoses;
  CheckBoxMouseRtnPosRB.Checked := mrpRB in Mouse.RtnPoses;
  CheckBoxMouseRtnPosMB.Checked := mrpMB in Mouse.RtnPoses;
  CheckBoxMouseRtnPosLB.Checked := mrpLB in Mouse.RtnPoses;
  CheckBoxMouseRtnPosLM.Checked := mrpLM in Mouse.RtnPoses;
end;
 
function TFrameMouseAction.GetMouseKeys: TMouseKeys;
begin
  Result := [];
  if CheckBoxMouseKeyLClk.Checked then
    Result := Result + [mkLBtn];
  if CheckBoxMouseKeyRClk.Checked then
    Result := Result + [mkRBtn];
  if CheckBoxMouseKeyMClk.Checked then
    Result := Result + [mkMBtn];
  if CheckBoxMouseKeyCtrl.Checked then
    Result := Result + [mkCtrl];
  if CheckBoxMouseKeyShift.Checked then
    Result := Result + [mkShift];  
  if CheckBoxMouseKeyAlt.Checked then
    Result := Result + [mkAlt];
//  DOutI(integer(word(Result)));
end;

function TFrameMouseAction.GetMouseRtnPoses: TMouseRtnPoses;
begin
  Result := [];
//  if CheckBoxMouseRtnPosAll.Checked then
//    Result := Result + [mrpAll];
  if CheckBoxMouseRtnPosDeskTop.Checked then
    Result := Result + [mrpDeskTop];
  if CheckBoxMouseRtnPosTaskBar.Checked then
    Result := Result + [mrpTaskBar];
  if CheckBoxMouseRtnPosLT.Checked then
    Result := Result + [mrpLT];
  if CheckBoxMouseRtnPosMT.Checked then
    Result := Result + [mrpMT];
  if CheckBoxMouseRtnPosRT.Checked then
    Result := Result + [mrpRT];
  if CheckBoxMouseRtnPosRM.Checked then
    Result := Result + [mrpRM];
  if CheckBoxMouseRtnPosRB.Checked then
    Result := Result + [mrpRB];
  if CheckBoxMouseRtnPosMB.Checked then
    Result := Result + [mrpMB];
  if CheckBoxMouseRtnPosLB.Checked then
    Result := Result + [mrpLB];
  if CheckBoxMouseRtnPosLM.Checked then
    Result := Result + [mrpLM];
end;

procedure TFrameMouseAction.FrameResize(Sender: TObject);
begin
  LabelMouseHint.Caption := '';
  EnabledMouseSettings;
end;

procedure TFrameMouseAction.CheckBoxMouseRtnPosAllClick(Sender: TObject);  
var b: Boolean;
begin
  b := CheckBoxMouseRtnPosAll.Checked;
  CheckBoxMouseRtnPosDeskTop.Checked := b;
  CheckBoxMouseRtnPosTaskBar.Checked := b;
  CheckBoxMouseRtnPosLT.Checked := b;
  CheckBoxMouseRtnPosMT.Checked := b;
  CheckBoxMouseRtnPosRT.Checked := b;
  CheckBoxMouseRtnPosRM.Checked := b;
  CheckBoxMouseRtnPosRB.Checked := b;
  CheckBoxMouseRtnPosMB.Checked := b;
  CheckBoxMouseRtnPosLB.Checked := b;
  CheckBoxMouseRtnPosLM.Checked := b;
end;

procedure TFrameMouseAction.ButtonAllDesktopClick(Sender: TObject);
begin
  CheckBoxMouseRtnPosDeskTop.Checked := True;
  CheckBoxMouseRtnPosLT.Checked := True;    
  CheckBoxMouseRtnPosMT.Checked := True;
  CheckBoxMouseRtnPosRT.Checked := True;
  CheckBoxMouseRtnPosRM.Checked := True;
  CheckBoxMouseRtnPosRB.Checked := True;
  CheckBoxMouseRtnPosMB.Checked := True;
  CheckBoxMouseRtnPosLB.Checked := True;
  CheckBoxMouseRtnPosLM.Checked := True;
end;

end.
