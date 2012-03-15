unit FrmShortcutAndHotKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ShortcutKeyEdit, Menus;

type
  TFrameShortcutAndHotKey = class(TFrame)
    EditShortcutKey: TShortcutKeyEdit;
    ButtonClearShortcutKey: TButton;
    EditHotKey: TShortcutKeyEdit;
    ButtonClearHotKey: TButton;
    LabelHotkey: TLabel;
    LabelShortcutkey: TLabel;
    procedure ButtonClearShortcutKeyClick(Sender: TObject);
    procedure ButtonClearHotKeyClick(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    procedure SetKeys(const Shortcut, Hot: TShortCut);  
    procedure GetKeys(var Shortcut, Hot: TShortCut);
  end;

implementation

{$R *.dfm}

procedure TFrameShortcutAndHotKey.ButtonClearShortcutKeyClick(
  Sender: TObject);
begin
  EditShortcutKey.Text := '';
  EditShortcutKey.SetFocus;
end;

procedure TFrameShortcutAndHotKey.ButtonClearHotKeyClick(Sender: TObject);
begin
  EditHotKey.Text := '';
  EditHotKey.SetFocus;
end;

procedure TFrameShortcutAndHotKey.GetKeys(var Shortcut, Hot: TShortCut);
begin                         
  Shortcut := TextToShortCut(EditShortcutKey.Text);
  Hot := TextToShortCut(EditHotKey.Text);
end;

procedure TFrameShortcutAndHotKey.SetKeys(const Shortcut, Hot: TShortCut);
begin
  EditShortcutKey.Text := ShortCutToText(Shortcut);
  EditHotKey.Text := ShortCutToText(Hot);
end;

end.
