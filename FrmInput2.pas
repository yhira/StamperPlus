unit FrmInput2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids;

type
  TFrameInput2 = class(TFrame)
    EditHead: TEdit;
    ButtonAdd: TButton;
    ButtonChange: TButton;
    ButtonDelete: TButton;
    StringGrid: TStringGrid;
    EditBottom: TEdit;
    procedure EditHeadChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonChangeClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure EditHeadKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private �錾 }
    procedure CheckButton;
    procedure ClearEdits;
  public
    { Public �錾 }
  end;

implementation

{$R *.dfm}

procedure TFrameInput2.EditHeadChange(Sender: TObject);
begin
  CheckButton;
end;

procedure TFrameInput2.ButtonAddClick(Sender: TObject);
var r: Integer;
begin
//  ListBox.ItemIndex := ListBox.Items.Add(Edit.Text);
  if (StringGrid.RowCount = 1) and (StringGrid.Cells[0, 0] = '') then
    r := 0
  else begin
   StringGrid.RowCount := StringGrid.RowCount + 1;
   r := StringGrid.RowCount -1;
  end;
  StringGrid.Cells[0, r] := EditHead.Text;        
  StringGrid.Cells[1, r] := EditBottom.Text;
  StringGrid.Row := r;
  ClearEdits;
end;

procedure TFrameInput2.ButtonChangeClick(Sender: TObject);
begin
  StringGrid.Cells[0, StringGrid.Row] := EditHead.Text;
  StringGrid.Cells[1, StringGrid.Row] := EditBottom.Text;
  ClearEdits;
end;

procedure TFrameInput2.ButtonDeleteClick(Sender: TObject);
  //�s���폜
  procedure DelRows(theGrid:TStringGrid;DelFrom,DelTo:integer);
  var
     i,buf,delItemCount:integer;
  begin
     if DelFrom>DelTo then
     begin
        buf:=DelFrom;
        DelFrom:=DelTo;
        DelTo:=buf;
     end;
     with theGrid Do
     begin
        if DelFrom>RowCount-1 then Exit;
        if DelTo>rowcount-1 then DelTo:=rowcount-1;
        if DelFrom<fixedRows then DelFrom:=fixedRows;
        delItemCount:=DelTo-DelFrom+1;
        if (RowCount=FixedRows+1) or
           (RowCount-delItemCount<=FixedRows) then //����ȃP�[�X
        begin
           Rows[FixedRows].Clear;
           if DelFrom<=RowCount-1 then delItemCount:=delItemCount-1;
        end
        else
        begin
           For i:=DelTo+1 to RowCount-1 do
           begin
                Rows[i-delItemCount].assign(Rows[i]);
           end;
        end;
        RowCount:=RowCount-delItemCount;
     end;
  end;
begin
  DelRows(StringGrid, StringGrid.Row, StringGrid.Row);
  ClearEdits;
  CheckButton;
end;

procedure TFrameInput2.CheckButton;
var IsNotExsist, IsNotEmpty, IsSel: Boolean;
begin
  IsNotExsist := (StringGrid.Cols[0].IndexOf(EditHead.Text) = -1) or
                 (StringGrid.Cols[1].IndexOf(EditBottom.Text) = -1);
  IsNotEmpty := (EditHead.Text <> '') and (EditBottom.Text <> '');
  IsSel := StringGrid.Cells[0, StringGrid.Row] <> '';
  ButtonAdd.Enabled := IsNotExsist and IsNotEmpty;
  ButtonChange.Enabled := IsNotExsist and IsSel and IsNotEmpty;
  ButtonDelete.Enabled := IsSel;
end;

procedure TFrameInput2.FrameResize(Sender: TObject);
begin
  ButtonAdd.Enabled := False;
  ButtonChange.Enabled := False;
  ButtonDelete.Enabled := False;
end;

procedure TFrameInput2.EditHeadKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then ButtonAdd.Click;
end;

procedure TFrameInput2.ClearEdits;
begin
  EditHead.Text := '';
  EditBottom.Text := '';
end;

procedure TFrameInput2.StringGridClick(Sender: TObject);
begin
  EditHead.Text := StringGrid.Cells[0, StringGrid.Row];
  EditBottom.Text := StringGrid.Cells[1, StringGrid.Row];
  CheckButton;
end;

procedure TFrameInput2.StringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if StringGrid.Cells[0, StringGrid.Row] = '' then begin
    with StringGrid.Canvas do begin
      Brush.Color := StringGrid.Color;
      FillRect(Rect);
    end;
  end;
end;

end.
