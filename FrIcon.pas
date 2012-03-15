unit FrIcon;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, ImgList, ComItems, Grids, IconGrid,dialogs,
  ExtDlgs, ComDef, Helper;

type
  TFormIcon = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    ButtonAdd: TButton;
    ButtonSub: TButton;
    ButtonDel: TButton;
    IconGrid: TIconGrid;
    OpenPictureDialog: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure IconGridDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure ButtonSubClick(Sender: TObject);
    procedure IconGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ButtonDelClick(Sender: TObject);
  private
    FListIcons: TIconList;
    procedure SetListIcons(const Value: TIconList);
    function ExecuteOpenPictureDialog(IsAdd: Boolean): Boolean;

    { Private éŒ¾ }
  public
    { Public éŒ¾ }             
//    ImageListS, ImageListL: TImageList;
    ItemEditMode: TItemEditMode;
    ImageIndex: Integer;
    property ListIcons: TIconList read FListIcons write SetListIcons;
  end;

var
  FormIcon: TFormIcon;

implementation

{$R *.dfm}

uses FrMain;

procedure TFormIcon.FormCreate(Sender: TObject);
begin
  FListIcons := nil;
  ImageIndex := 0;
  ItemEditMode := iemDir;
//  OpenPictureDialog.InitialDir := ExtractFileDir(ParamStr(0));
end;

procedure TFormIcon.SetListIcons(const Value: TIconList);
//var i: Integer;
begin
  FListIcons := Value;
  if FListIcons = nil then Exit;
//  for i := 0 to FListIcons.Count-1 do begin
//    ImageList.AddIcon(TIconItem(FListIcons[i]).Icon);
//  end;
  IconGrid.Images := ListIcons.ImagesL;
end;

function TFormIcon.ExecuteOpenPictureDialog(IsAdd: Boolean): Boolean;
var ii: TIconItem; iic: TIconItemClass; i: Integer;
begin
  Result := OpenPictureDialog.Execute;
  if Result then begin
    case ItemEditMode of
      iemPaste: iic := TPasteIconItem;
      iemBkmk: iic := TBkmkIconItem;
      iemClip: iic := TClipIconItem;
    else iic := TDirIconItem; end;
    if IsAdd then ii := iic.Create(FListIcons)
    else ii := TIconItem(ListIcons[IconGrid.Index]);
    ii.Icon.LoadFromFile(OpenPictureDialog.FileName);
    BeginTransaction;
    try
      if IsAdd then begin
        ii.Insert;
        i := FListIcons.AddItem(ii);
      end else begin
        ii.Update;
        i := ii.Index;
        FListIcons.ReplaceItem(i, ii.Icon);
      end;                   
      IconGrid.Invalidate;
      IconGrid.Index := i;
      Commit;
    except
      Rollback;
    end;
  end;
end;

procedure TFormIcon.ButtonAddClick(Sender: TObject);
begin
  ExecuteOpenPictureDialog(True);
end;

procedure TFormIcon.ButtonSubClick(Sender: TObject);
begin
  ExecuteOpenPictureDialog(False);
end;

procedure TFormIcon.ButtonDelClick(Sender: TObject);
var i: Integer;
begin
  BeginTransaction;
  try
    i := IconGrid.Index;
    TIconItem(ListIcons[i]).Delete;
    ListIcons.DeleteItem(i);
    IconGrid.Invalidate;
    IconGrid.Index := i - 1;
    Commit;
    if ItemEditMode = iemDir then begin
      DirIcons.Clear;
//      pi(DirIcons.Count);
      SetIcons(TDirIconItem, DirIcons);
      FormStancher.LoadDirFromDB(FormStancher.ActiveTree);
    end else
      FormStancher.LoadItemFromDB;
    
  except
    Rollback;
  end;
end;

procedure TFormIcon.IconGridDblClick(Sender: TObject);
begin
  OKBtn.Click;
end;

procedure TFormIcon.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then OKBtn.Click;
end;

procedure TFormIcon.FormActivate(Sender: TObject);
begin
  IconGrid.Index := ImageIndex;
end;

procedure TFormIcon.IconGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var IsEnb: Boolean;
begin
  if gdSelected	 in State then begin
    case ItemEditMode of
      iemDir: IsEnb := IconGrid.Index >= 16;
    else IsEnb := IconGrid.Index >= 8;
    end;
    ButtonDel.Enabled := IsEnb;
  end;
end;

end.
