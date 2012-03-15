unit FrmInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls;

type
  TFrameInput = class(TFrame)
    ListBox: TListBox;
    Edit: TEdit;
    ButtonAdd: TButton;
    ButtonChange: TButton;
    ButtonDelete: TButton;
    procedure EditChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonChangeClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private �錾 }
    procedure CheckButton;
  public
    { Public �錾 }
  end;

implementation

{$R *.dfm}

procedure TFrameInput.EditChange(Sender: TObject);
begin
  CheckButton;
end;

procedure TFrameInput.ButtonAddClick(Sender: TObject);
begin
  ListBox.ItemIndex := ListBox.Items.Add(Edit.Text);
  Edit.Text := '';
//  ListBoxClick(Sender);
end;

procedure TFrameInput.ButtonChangeClick(Sender: TObject);
begin
  ListBox.Items[ListBox.ItemIndex] := Edit.Text;
  Edit.Text := '';
//  ListBoxClick(Sender);
end;

procedure TFrameInput.ButtonDeleteClick(Sender: TObject);
begin
  ListBox.Items.Delete(ListBox.ItemIndex);
  Edit.Text := '';
end;

procedure TFrameInput.CheckButton;
var IsNotExsist, IsNotEmpty, IsSel: Boolean;
begin
  IsNotExsist := ListBox.Items.IndexOf(Edit.Text) = -1;
  IsNotEmpty := Edit.Text <> '';
  IsSel := ListBox.ItemIndex <> -1;
  ButtonAdd.Enabled := IsNotExsist and IsNotEmpty;
  ButtonChange.Enabled := IsNotExsist and IsSel and IsNotEmpty;
  ButtonDelete.Enabled := IsSel;
end;

procedure TFrameInput.ListBoxClick(Sender: TObject);
begin
  if ListBox.ItemIndex = -1 then Exit;
  Edit.Text := ListBox.Items[ListBox.ItemIndex];
  CheckButton;
end;

procedure TFrameInput.FrameResize(Sender: TObject);
begin
  ButtonAdd.Enabled := False;
  ButtonChange.Enabled := False;
  ButtonDelete.Enabled := False;       
end;

procedure TFrameInput.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then ButtonAdd.Click;
end;

end.