unit FrDirEdit;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls, ShortcutKeyEdit;

type
  TFormProperty = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    PageControl: TPageControl;
    TabAll: TTabSheet;
    TabAction: TTabSheet;
    TabDir: TTabSheet;
    ImageIcon: TImage;
    Bevel1: TBevel;
    EditName: TEdit;
    MemoComment: TMemo;
    ButtonClearUseCount: TButton;
    Label7: TLabel;
    EditTag: TEdit;
    CheckBoxIsPassword: TCheckBox;
    ButtonEditTag: TButton;
    EditShortcutKey: TShortcutKeyEdit;
    ButtonClearShortcutKey: TButton;
    EditHotKey: TShortcutKeyEdit;
    ButtonClearHotKey: TButton;
    Bevel5: TBevel;
    TabPaste: TTabSheet;
    TabClip: TTabSheet;
    TabLaunch: TTabSheet;
    ComboViewStyle: TComboBox;
    ComboSortMode: TComboBox;
    MemoText: TMemo;
    ComboPasteMode: TComboBoxEx;
    LabelHint: TLabel;
    LabelCreateDate: TLabel;
    LabelUpdateDate: TLabel;
    LabelAccessDate: TLabel;
    LabelUseCount: TLabel;
    LabelRepetition: TLabel;
    Label1: TLabel;
    ButtonEditor: TButton;
    ButtonMacro: TButton;
    Label2: TLabel;
    ListView1: TListView;
    EditFileName: TEdit;
    ButtonFileName: TButton;
    EditParams: TEdit;
    EditDir: TEdit;
    ComboShowCmd: TComboBox;
    procedure PageControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetNameCompo(Tab: TTabSheet);
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  FormProperty: TFormProperty;

implementation

{$R *.dfm}

uses Helper;

procedure TFormProperty.PageControlChange(Sender: TObject);
begin
  SetNameCompo(PageControl.ActivePage);
end;

procedure TFormProperty.SetNameCompo(Tab: TTabSheet);
begin
  ImageIcon.Parent := Tab;
  EditName.Parent := Tab;
  EditName.TabOrder := 0;
  Bevel1.Parent := Tab;
end;

procedure TFormProperty.FormCreate(Sender: TObject);
begin
  ComboPasteMode.ItemIndex := 0;
  SetNameCompo(PageControl.ActivePage);
end;

end.
