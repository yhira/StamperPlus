unit FrMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, StdCtrls, ExtCtrls, ToolWin, ActnList, 
  ImgList, SQLReposition, Helper, ShortcutKeyEdit, ExtIniFile, ComDef, ComItems,
  SQLiteTable3, StnTreeView, AppEvnts, HogeListView, StnListView, CommCtrl,
  Contnrs, FrOption, UntOption, FrSelFile, yhINet, SkRegExpW, jconvertex,
  NkTextDropTarget, CBWatch, Clipbrd,  ActiveX, DropFilesUnit,
  ShellAPI, yhFiles, NkDropTarget, Dbg, yhOthers, FrAddText, Buttons,
  FrmInput, FrmInput2, Types, THTskTry, FrMacro, SqlRepository,
  xmldom, XMLIntf, msxmldom, XMLDoc, Progress, About, Variants, BugReport,
  cryptogram, UxTheme, ModClip, FrMemo, XPMan, DragDrop, DropSource,
  DragDropText, jconvert;

type
  TEditItem = (eiAllSearch, eiPaste, eiLaunch, eiBkmk, eiClip);

  TStringListEditFunc = function (sl: TStringList): string of object;

  TNodesArray = array of TTreeNode;

  TFormStancher = class(TForm)
    ToolBarQuery: TToolBar;
    EditQuery: TEdit;
    MainMenu: TMainMenu;
    ActionList: TActionList;
    PageControlMain: TPageControl;
    TabAllSearch: TTabSheet;
    TabPaste: TTabSheet;
    TabLaunch: TTabSheet;
    TabBkmk: TTabSheet;
    TabClip: TTabSheet;
    StatusBar: TStatusBar;
    PanelPasteL: TPanel;
    PanelLaunchL: TPanel;
    PanelBkmkL: TPanel;
    PanelClipL: TPanel;
    SplitterPaste: TSplitter;
    SplitterLaunch: TSplitter;
    SplitterBkmk: TSplitter;
    SplitterClip: TSplitter;
    PanelPasteR: TPanel;
    PanelR: TPanel;
    PanelBkmkR: TPanel;
    PanelClipR: TPanel;
    ToolBarPaste: TToolBar;
    ToolBarClip: TToolBar;
    ImageListSearchL: TImageList;
    ImageListSearchS: TImageList;
    ImageListPasteL: TImageList;
    ImageListPasteS: TImageList;
    ImageListLaunchL: TImageList;
    ImageListLaunchS: TImageList;
    ImageListBkmkL: TImageList;
    ImageListBkmkS: TImageList;
    ImageListClipL: TImageList;
    ImageListClipS: TImageList;
    ImageListManu: TImageList;
    ToolBarMenu: TToolBar;
    IniConfig: TExtIniFile;
    ActCreateDir: TAction;
    TreePaste: TStnTreeView;
    TreeLaunch: TStnTreeView;
    TreeBkmk: TStnTreeView;
    TreeClip: TStnTreeView;
    PopupPasteTree: TPopupMenu;
    PopupLaunchTree: TPopupMenu;
    PopupBkmkTree: TPopupMenu;
    ActEditDir: TAction;
    ActDeleteDir: TAction;
    F1: TMenuItem;
    D1: TMenuItem;
    N1: TMenuItem;
    mnuHelp: TMenuItem;
    D3: TMenuItem;
    N2: TMenuItem;
    D2: TMenuItem;
    N3: TMenuItem;
    P1: TMenuItem;
    D5: TMenuItem;
    N4: TMenuItem;
    D4: TMenuItem;
    N5: TMenuItem;
    P2: TMenuItem;
    P3: TMenuItem;
    N7: TMenuItem;
    D6: TMenuItem;
    N6: TMenuItem;
    D7: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    ListViewBkmk: TStnListView;
    ListViewLaunch: TStnListView;
    ListViewPaste: TStnListView;
    ListViewClip: TStnListView;
    ListViewAllSearch: TStnListView;
    D8: TMenuItem;
    D9: TMenuItem;
    P4: TMenuItem;
    ActCreateItem: TAction;
    PopupAllSearchList: TPopupMenu;
    PopupPasteList: TPopupMenu;
    PopupLaunchList: TPopupMenu;
    PopupBkmkList: TPopupMenu;
    PopupClipList: TPopupMenu;
    N8: TMenuItem;
    ActDeleteItem: TAction;
    ActEditItem: TAction;
    ActDspDirOnList: TAction;
    N9: TMenuItem;
    ActDeleteItem1: TMenuItem;
    N10: TMenuItem;
    ActEditItem1: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    D10: TMenuItem;
    P5: TMenuItem;
    N13: TMenuItem;
    D11: TMenuItem;
    P6: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    ActSortListUser: TAction;
    ActSortListName: TAction;
    ActSortListCr: TAction;
    ActSortListUp: TAction;
    ActSortListAc: TAction;
    ActSortListUse: TAction;
    ActSortListRep: TAction;
    ActSortListParent: TAction;
    ActSortListRevers: TAction;
    ActCopyDir: TAction;
    ActCutDir: TAction;
    ActCopyDir1: TMenuItem;
    ActCutDir1: TMenuItem;
    N16: TMenuItem;
    ActPaste: TAction;
    P7: TMenuItem;
    ActCopyItem: TAction;
    ActCutItem: TAction;
    N17: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P8: TMenuItem;
    ActOption: TAction;
    O1: TMenuItem;
    N18: TMenuItem;
    ToolButtonPP: TToolButton;
    ToolButtonPC: TToolButton;
    ToolButtonPCR: TToolButton;
    ToolButtonPKM: TToolButton;
    N19: TMenuItem;
    I1: TMenuItem;
    ActSortListUser1: TMenuItem;
    ActSortListName1: TMenuItem;
    ActSortListCr1: TMenuItem;
    ActSortListUp1: TMenuItem;
    ActSortListAc1: TMenuItem;
    ActSortListUse1: TMenuItem;
    ActSortListRep1: TMenuItem;
    N20: TMenuItem;
    ActSortListRevers1: TMenuItem;
    ActSortListComment: TAction;
    ActSortListParent1: TMenuItem;
    ActSortListComment1: TMenuItem;
    ActDispListIcon: TAction;
    ActDispListSmallIcon: TAction;
    ActDispListList: TAction;
    ActDispListReport: TAction;
    ActDispListIcon1: TMenuItem;
    ActDispListSmallIcon1: TMenuItem;
    ActDispListList1: TMenuItem;
    ActDispListReport1: TMenuItem;
    ActSortTreeUser: TAction;
    ActSortTreeName: TAction;
    ActSortTreeCr: TAction;
    ActSortTreeUp: TAction;
    ActSortTreeAc: TAction;
    ActSortTreeUse: TAction;
    ActSortTreeRep: TAction;
    ActSortTreeParent: TAction;
    ActSortTreeComment: TAction;
    ActSortTreeRevers: TAction;
    S1: TMenuItem;
    N21: TMenuItem;
    ActSortTreeUser1: TMenuItem;
    ActSortTreeName1: TMenuItem;
    ActSortTreeCr1: TMenuItem;
    ActSortTreeUp1: TMenuItem;
    ActSortTreeAc1: TMenuItem;
    ActSortTreeUse1: TMenuItem;
    ActSortTreeRep1: TMenuItem;
    ActSortTreeRevers1: TMenuItem;
    N22: TMenuItem;
    ClipboardWatcher: TClipboardWatcher;
    ToolButtonCP: TToolButton;
    ToolButtonCC: TToolButton;
    MemoClipText: TMemo;
    V1: TMenuItem;
    ActDispListIcon2: TMenuItem;
    ActDispListSmallIcon2: TMenuItem;
    ActDispListList2: TMenuItem;
    ActDispListReport2: TMenuItem;
    I2: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    ActClipToPaste: TAction;
    ActSortListName2: TMenuItem;
    ActSortListCr2: TMenuItem;
    ActSortListUp2: TMenuItem;
    ActSortListAc2: TMenuItem;
    ActSortListUse2: TMenuItem;
    ActSortListRep2: TMenuItem;
    N25: TMenuItem;
    ActSortListComment2: TMenuItem;
    DropFilesLaunch: TDropFiles;
    DropTextPaste: TNkTextDropTarget;
    DropTextBkmk: TNkTextDropTarget;
    SplitterClipText: TSplitter;
    PanelClipB: TPanel;
    ImageListPasteMode: TImageList;
    ActAddBookMarks: TAction;
    TimerGetForground: TTimer;
    B1: TMenuItem;
    N26: TMenuItem;
    ActColumnCrVisible: TAction;
    ActColumnUpVisible: TAction;
    ActColumnAcVisible: TAction;
    ActColumnUseVisible: TAction;
    ActColumnRepVisible: TAction;
    ActColumnParentVisible: TAction;
    ActColumnCommentVisible: TAction;
    ActTopMostWnd: TAction;
    ToolButton7: TToolButton;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    C2: TMenuItem;
    U1: TMenuItem;
    A1: TMenuItem;
    V2: TMenuItem;
    R1: TMenuItem;
    P9: TMenuItem;
    K1: TMenuItem;
    S2: TMenuItem;
    O2: TMenuItem;
    N30: TMenuItem;
    C3: TMenuItem;
    U2: TMenuItem;
    A2: TMenuItem;
    V3: TMenuItem;
    R2: TMenuItem;
    P10: TMenuItem;
    K2: TMenuItem;
    N31: TMenuItem;
    R3: TMenuItem;
    T2: TMenuItem;
    ActSortTreeName2: TMenuItem;
    ActSortTreeCr2: TMenuItem;
    ActSortTreeUse2: TMenuItem;
    ActSortTreeUser2: TMenuItem;
    ActSortTreeUp2: TMenuItem;
    ActSortTreeAc2: TMenuItem;
    ActSortTreeRep2: TMenuItem;
    N32: TMenuItem;
    ActSortTreeRevers2: TMenuItem;
    B2: TMenuItem;
    ActClipSortAsc: TAction;
    ActClipSortDesc: TAction;
    ActSendPaste: TAction;
    ActSendToClip: TAction;
    N33: TMenuItem;
    P11: TMenuItem;
    C4: TMenuItem;
    N34: TMenuItem;
    P12: TMenuItem;
    C5: TMenuItem;
    O3: TMenuItem;
    MenuItemEditText: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    MenuLineTops: TMenuItem;
    MenuLineTopBottoms: TMenuItem;
    ActTidyTrim: TAction;
    ActionListShorteCut: TActionList;
    ButtonQuery: TSpeedButton;
    ActQuery: TAction;
    ActTidyTrim1: TMenuItem;
    ActTidyTrimLeft: TAction;
    ActTidyTrimRight: TAction;
    ActTidyTrimLeft1: TMenuItem;
    ActTidyTrimRight1: TMenuItem;
    N38: TMenuItem;
    ActTidyDeleteEmptyLine: TAction;
    ActTidyDeleteEmptyLine1: TMenuItem;
    N39: TMenuItem;
    ActTidySortAsc: TAction;
    ActTidySortDesc: TAction;
    ActTidySortAsc1: TMenuItem;
    ActTidySortDesc1: TMenuItem;
    ActConvZenToHan: TAction;
    ActConvHanToZen: TAction;
    ActConvKanaToHira: TAction;
    ActConvHiraToKana: TAction;
    ActConvLowerToUpper: TAction;
    ActConvUpperToLower: TAction;
    ActConvTabToSpace: TAction;
    ActConvSpaceToTab: TAction;
    B3: TMenuItem;
    ActConvUpperToLower1: TMenuItem;
    N40: TMenuItem;
    ActConvHanToZen1: TMenuItem;
    ActConvZenToHan1: TMenuItem;
    N41: TMenuItem;
    ActConvHiraToKana1: TMenuItem;
    ActConvKanaToHira1: TMenuItem;
    N42: TMenuItem;
    ActConvTabToSpace1: TMenuItem;
    ActConvSpaceToTab1: TMenuItem;
    ActStealth: TAction;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    XPManifest1: TXPManifest;
    ActDisplay: TAction;
    TaskTrayIcon: TTHTaskTrayIcon;
    PopupTask: TPopupMenu;
    D12: TMenuItem;
    N37: TMenuItem;
    ActClose: TAction;
    N43: TMenuItem;
    Q1: TMenuItem;
    Q2: TMenuItem;
    N44: TMenuItem;
    P13: TMenuItem;
    ToolBarTag: TToolBar;
    LabelQuery: TLabel;
    N45: TMenuItem;
    ActVisibleMenuToolBar: TAction;
    ActVisibleTagToolBar: TAction;
    ActVisibleStatusBar: TAction;
    ActVisibleSearchToolBar: TAction;
    M1: TMenuItem;
    Q3: TMenuItem;
    T3: TMenuItem;
    N46: TMenuItem;
    S3: TMenuItem;
    XMLDoc: TXMLDocument;
    ActExportSel: TAction;
    ActExportAll: TAction;
    Progress: TProgress;
    XmlSaveDialog: TSaveDialog;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    ActExportSel1: TMenuItem;
    A3: TMenuItem;
    ActImportXml: TAction;
    XmlOpenDialog: TOpenDialog;
    ActImportXml1: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ImageListTask: TImageList;
    ActAbput: TAction;
    V4: TMenuItem;
    ActImportXmlOldVer: TAction;
    I3: TMenuItem;
    N50: TMenuItem;
    ActBugReport: TAction;
    N51: TMenuItem;
    F2: TMenuItem;
    ActPasteDate: TAction;
    ActPasteTime: TAction;
    ActPasteDateTime: TAction;
    ActIsDateTimeCopy: TAction;
    ActPasteDate1: TMenuItem;
    ActPasteTime1: TMenuItem;
    ActPasteDateTime1: TMenuItem;
    N52: TMenuItem;
    ActIsDateTimeClipMode1: TMenuItem;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ActOpenLaunchDir: TAction;
    ActOpenLaunchDir1: TMenuItem;
    ActOpenLaunchDir2: TMenuItem;
    ActTabMove: TAction;
    TimerAutoBackup: TTimer;
    PanelPasteB: TPanel;
    MemoPasteText: TMemo;
    SplitterPasteText: TSplitter;
    ActReloadDir: TAction;
    R4: TMenuItem;
    ToolButtonPL: TToolButton;
    ToolButtonPB: TToolButton;
    TextDropTargetQuery: TNkTextDropTarget;
    ActDispSearchTab: TAction;
    ActDispPasteTab: TAction;
    ActDispLaunchchTab: TAction;
    ActDispBkmkTab: TAction;
    ActDispClipTab: TAction;
    ActForcusTree: TAction;
    ActForcusList: TAction;
    ActForcusQuery: TAction;
    ActForcusMove: TAction;
    N53: TMenuItem;
    S4: TMenuItem;
    N54: TMenuItem;
    P14: TMenuItem;
    L1: TMenuItem;
    B4: TMenuItem;
    C6: TMenuItem;
    TimerShowMouseCslRtn: TTimer;
    TimerMouseCslRtn: TTimer;
    N55: TMenuItem;
    ActClipToPic: TAction;
    ActClipToFilePath: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    ActKeyoperationHelp: TAction;
    N59: TMenuItem;
    K3: TMenuItem;
    ActReloadList: TAction;
    R5: TMenuItem;
    DropTextSourceClip: TDropTextSource;
    DropTextSourcePaste: TDropTextSource;
    TimerTextDrop: TTimer;
    ActClipToFile: TAction;
    ToolButton4: TToolButton;
    ClipboardViewerTimer: TTimer;
    AutoExpandTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ActCreateDirExecute(Sender: TObject);
    procedure ActEditDirExecute(Sender: TObject);
    procedure PopupItem(Sender: TObject);
    procedure ActDeleteDirExecute(Sender: TObject);
    procedure TreePasteDeletion(Sender: TObject; Node: TTreeNode);
    procedure TreePasteAddition(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure PageControlMainChange(Sender: TObject);
    procedure TreeCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure TreePasteClick(Sender: TObject);
    procedure ActCreateItemExecute(Sender: TObject);
    procedure ListViewPasteData(Sender: TObject; Item: TListItem);
    procedure ActEditItemExecute(Sender: TObject);
    procedure ActDeleteItemExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TreePasteDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ActCopyDirExecute(Sender: TObject);
    procedure ActCutDirExecute(Sender: TObject);
    procedure ActPasteExecute(Sender: TObject);
    procedure TreePasteDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure ActCopyItemExecute(Sender: TObject);
    procedure ActCutItemExecute(Sender: TObject);
    procedure ListViewPasteDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListViewPasteDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure ActOptionExecute(Sender: TObject);
    procedure ListViewPasteSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ToolButtonPasteModeClick(Sender: TObject);
    procedure PageControlMainChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ActSortListUserExecute(Sender: TObject);
    procedure ActSortListReversExecute(Sender: TObject);
    procedure ActSortListNameExecute(Sender: TObject);
    procedure ActSortListCrExecute(Sender: TObject);
    procedure ActSortListUpExecute(Sender: TObject);
    procedure ActSortListAcExecute(Sender: TObject);
    procedure ActSortListUseExecute(Sender: TObject);
    procedure ActSortListRepExecute(Sender: TObject);
    procedure ActSortListParentExecute(Sender: TObject);
    procedure ActSortListCommentExecute(Sender: TObject);
    procedure ActSortListValExecute(Sender: TObject);
    procedure ActDispListIconExecute(Sender: TObject);
    procedure ActDispListSmallIconExecute(Sender: TObject);
    procedure ActDispListListExecute(Sender: TObject);
    procedure ActDispListReportExecute(Sender: TObject);
    procedure TreePasteChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreePasteChange(Sender: TObject; Node: TTreeNode);
    procedure ActSortTreeUserExecute(Sender: TObject);
    procedure ActSortTreeNameExecute(Sender: TObject);
    procedure ActSortTreeCrExecute(Sender: TObject);
    procedure ActSortTreeUpExecute(Sender: TObject);
    procedure ActSortTreeAcExecute(Sender: TObject);
    procedure ActSortTreeUseExecute(Sender: TObject);
    procedure ActSortTreeRepExecute(Sender: TObject);
    procedure ActSortTreeReversExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Addition(Sender: TObject; Node: TTreeNode);
    procedure ClipboardWatcherChange(Sender: TObject);  
    procedure ClipToolButtonClick(Sender: TObject);
    procedure DropFilesLaunchDrop(Sender: TObject; Files: TStrings);
    procedure DropTextPasteTextDrop(Text: String);
    procedure DropTextBkmkTextDrop(Text: String);
    procedure StatusBarResize(Sender: TObject);
    procedure TimerGetForgroundTimer(Sender: TObject);
    procedure ListViewLaunchCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListViewPasteDblClick(Sender: TObject);
    procedure ActClipToPasteExecute(Sender: TObject);
    procedure ActTopMostWndExecute(Sender: TObject);
    procedure ActColumnCrVisibleExecute(Sender: TObject);
    procedure ActColumnUpVisibleExecute(Sender: TObject);
    procedure ActColumnAcVisibleExecute(Sender: TObject);
    procedure ActColumnUseVisibleExecute(Sender: TObject);
    procedure ActColumnRepVisibleExecute(Sender: TObject);
    procedure ActColumnParentVisibleExecute(Sender: TObject);
    procedure ActColumnCommentVisibleExecute(Sender: TObject);
    procedure ListViewPasteColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure ListViewPasteInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: String);
    procedure ListViewPasteCustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TreePasteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ActAddBookMarksExecute(Sender: TObject);
    procedure TreeClipDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ActSendPasteExecute(Sender: TObject);
    procedure ActSendToClipExecute(Sender: TObject);
    procedure ToolBarQueryResize(Sender: TObject);
    procedure EditQueryKeyPress(Sender: TObject; var Key: Char);
    procedure ActQueryExecute(Sender: TObject);
    procedure ActTidyTrimExecute(Sender: TObject);
    procedure ActTidyTrimLeftExecute(Sender: TObject);
    procedure ActTidyTrimRightExecute(Sender: TObject);
    procedure ActTidyDeleteEmptyLineExecute(Sender: TObject);
    procedure ActTidySortAscExecute(Sender: TObject);
    procedure ActTidySortDescExecute(Sender: TObject);
    procedure ActConvUpperToLowerExecute(Sender: TObject);
    procedure ActConvLowerToUpperExecute(Sender: TObject);
    procedure ActConvZenToHanExecute(Sender: TObject);
    procedure ActConvHanToZenExecute(Sender: TObject);
    procedure ActConvKanaToHiraExecute(Sender: TObject);
    procedure ActConvHiraToKanaExecute(Sender: TObject);
    procedure ActConvTabToSpaceExecute(Sender: TObject);
    procedure ActConvSpaceToTabExecute(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure ActStealthExecute(Sender: TObject);
    procedure MenuAdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; State: TOwnerDrawState);
    procedure ToolBarPasteCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ListViewAllSearchDblClick(Sender: TObject);
    procedure ActDisplayExecute(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TaskTrayIconClick(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure ListViewLaunchSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure TreePasteExit(Sender: TObject);
    procedure TreePasteEnter(Sender: TObject);
    procedure ActVisibleSearchToolBarExecute(Sender: TObject);
    procedure ActVisibleStatusBarExecute(Sender: TObject);
    procedure ActVisibleTagToolBarExecute(Sender: TObject);
    procedure ActVisibleMenuToolBarExecute(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ActExportSelExecute(Sender: TObject);
    procedure ActExportAllExecute(Sender: TObject);
    procedure ActImportXmlExecute(Sender: TObject);
    procedure ActAbputExecute(Sender: TObject);
    procedure ActImportXmlOldVerExecute(Sender: TObject);
    procedure ActBugReportExecute(Sender: TObject);
    procedure ListViewAllSearchSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewPasteClick(Sender: TObject);
    procedure ActPasteDateExecute(Sender: TObject);
    procedure ActPasteTimeExecute(Sender: TObject);
    procedure ActPasteDateTimeExecute(Sender: TObject);
    procedure ActIsDateTimeCopyExecute(Sender: TObject);
    procedure ActOpenLaunchDirExecute(Sender: TObject);
    procedure ActTabMoveExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListViewClipMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TimerAutoBackupTimer(Sender: TObject);
    procedure ListViewPasteMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ActReloadDirExecute(Sender: TObject);
    procedure TextDropTargetQueryTextDrop(Text: String);
    procedure EditQueryDblClick(Sender: TObject);
    procedure ActForcusTreeExecute(Sender: TObject);
    procedure ActForcusListExecute(Sender: TObject);
    procedure ActForcusQueryExecute(Sender: TObject);
    procedure ActForcusMoveExecute(Sender: TObject);
    procedure PageControlMainDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure PageControlMainDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure ActDispSearchTabExecute(Sender: TObject);
    procedure ActDispPasteTabExecute(Sender: TObject);
    procedure ActDispLaunchchTabExecute(Sender: TObject);
    procedure ActDispBkmkTabExecute(Sender: TObject);
    procedure ActDispClipTabExecute(Sender: TObject);
    procedure PageControlMainMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerMouseCslRtnTimer(Sender: TObject);
    procedure TimerShowMouseCslRtnTimer(Sender: TObject);
    procedure ActClipToFilePathExecute(Sender: TObject);
    procedure ActClipToPicExecute(Sender: TObject);
    procedure TreePasteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreePasteKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewPasteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListViewAllSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActKeyoperationHelpExecute(Sender: TObject);
    procedure ActReloadListExecute(Sender: TObject);
    procedure ListViewPasteChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListViewClipChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure TabClipShow(Sender: TObject);
    procedure TabAllSearchShow(Sender: TObject);
    procedure DropTextSourceClipAfterDrop(Sender: TObject;
      DragResult: TDragResult; Optimized: Boolean);
    procedure TimerTextDropTimer(Sender: TObject);
    procedure ActClipToFileExecute(Sender: TObject);
    procedure ClipboardViewerTimerTimer(Sender: TObject);
    procedure TreePasteCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure AutoExpandTimerTimer(Sender: TObject);
  private
    { Private 宣言 }
    FEditItem: TEditItem;
    FActiveList: TStnListView;
    FActiveTree: TStnTreeView;
    FItemSortOrdAsc: Boolean;
    FDirSortOrdAsc: Boolean;
    FItemSortMode: TSortMode;
    FDirSortMode: TSortMode;
    FActiveTableID: Byte;
    FActiveTable: string;
    FViewStyle: TViewStyle;
    FPasteDirSortMode,
    FLaunchDirSortMode,
    FBkmkDirSortMode: TSortMode;
    FPasteDirSortOrdAsc,
    FLaunchDirSortOrdAsc,
    FBkmkDirSortOrdAsc: Boolean;
    FClipItemSortMode: TSortMode;
    FClipItemSortOrdAsc: Boolean;
    FSearchItemSortMode: TSortMode;
    FSearchItemSortOrdAsc: Boolean;
//    FActiveEditItem: string;
    FIsClipToPaste: Boolean;
    FTopMostWnd: Boolean;
    FColumnCrVisible: Boolean;
    FColumnAcVisible: Boolean;
    FColumnRepVisible: Boolean;
    FColumnCommentVisible: Boolean;
    FColumnParentVisible: Boolean;
    FColumnUseVisible: Boolean;
    FColumnUpVisible: Boolean;
    StopMakeListColumns: Boolean;
    LineTopStr, LineTopBottomStr: string;
    FStealth: Boolean;
    FOldBoundsRect: TRect;
    FVisibleMenuToolBar: Boolean;
    FVisibleTagToolBar: Boolean;
    FVisibleStatusBar: Boolean;
    FVisibleSearchToolBar: Boolean;
    FIsDateTimeCopy: Boolean;
    FDateTimePasteMode: TPasteMode;
    FOldClipClk, FOldClipDblClk: TNotifyEvent;
    FDispBkmkTab: Boolean;
    FDispClipTab: Boolean;
    FDispPasteTab: Boolean;
    FDispLaunchchTab: Boolean;
    FDispSearchTab: Boolean;
    DefPasteLVWndProc, DefClipLVWndProc: TWndMethod;
    FColumnCommentWidth: Integer;
    FColumnUpWidth: Integer;
    FColumnUseWidth: Integer;
    FColumnAcWidth: Integer;
    FColumnParentWidth: Integer;
    FColumnRepWidth: Integer;
    FColumnCrWidth: Integer;
    FColumnCaptionWidth: Integer;
    FColumnBelongWidth: Integer;
    FNotListSave: Boolean;
    procedure DisplayDetailOfItem(Item: TListItem; Memo: TMemo);
    procedure SetEditItem(const Value: TEditItem);
    procedure Initialize;
    procedure SetImageLists;
    procedure CheckActionEnabled;
    procedure DeleteDir;
    procedure SetListColumns(EditItem: TEditItem);
    function EditItemToTree(EditItem: TEditItem): TStnTreeView;
    function EditItemToList(EditItem: TEditItem): TStnListView;
    function EditItemToTableID(EditItem: TEditItem): Byte;
    function EditItemToTable(EditItem: TEditItem): string;
    function TreeToTableID(Tree: TStnTreeView): Byte;
    procedure MakeListColumns;
    procedure SetDirSortMode(const Value: TSortMode);
    procedure SetItemSortMode(const Value: TSortMode);
    procedure SetDirSortOrdAsc(const Value: Boolean);
    procedure SetItemSortOrdAsc(const Value: Boolean);
    procedure SetSelListItems;
    function CreateActiveItem(AParent: TTreeNode): TCommonItem;
    procedure MoveItems(lstItems: TObjectList; nTo: TTreeNode;
      IsCopy: Boolean; isClipItem: Boolean = False);
    procedure ClearPastModeBtn(TB: TToolBar);
    procedure SaveOnItemChange;
    function GetParentText(Node: TTreeNode): string;
    procedure SetViewStyle(const Value: TViewStyle);
    procedure SetTreeSortAction;
    function IndexOfClipText(AText: string): Integer;
    procedure AddLaunchItem(ANode: TTreeNode; AFile: string);
    procedure StatusMsg(Text: String);
    procedure StatusClear;
    procedure SaveClipboardList;
    procedure LoadClipboardList;
    procedure StatusText(Index: Integer; Text: String);
    procedure ShowHint(Sender: TObject);
    procedure SetIsClipToPaste(const Value: Boolean);
    procedure SetTopMostWnd(const Value: Boolean);
    procedure SetColumnAcVisible(const Value: Boolean);
    procedure SetColumnCommentVisible(const Value: Boolean);
    procedure SetColumnCrVisible(const Value: Boolean);
    procedure SetColumnParentVisible(const Value: Boolean);
    procedure SetColumnRepVisible(const Value: Boolean);
    procedure SetColumnUpVisible(const Value: Boolean);
    procedure SetColumnUseVisible(const Value: Boolean);
    procedure AppShowHintList(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure SetListViewColumImage(ListView: TListView);
    procedure AppShowHintTree(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure SendPaste(TextItem: TTextItem; PasteMode: TPasteMode; func: TStringListEditFunc);
    function OneLineEditTrim(sl: TStringList): string;
    function OneLineEditTrimLeft(sl: TStringList): string;
    function OneLineEditTrimRight(sl: TStringList): string;
    function DeleteEmptyLine(sl: TStringList): string;
    function SortAsc(sl: TStringList): string;
    function SortDesc(sl: TStringList): string;
    function HanToZenFunc(sl: TStringList): string;
    function HiraToKanaFunc(sl: TStringList): string;
    function KanaToHiraFunc(sl: TStringList): string;
    function LowerToUpperFunc(sl: TStringList): string;
    function SpaseToTabFunc(sl: TStringList): string;
    function TabToSpaceFunc(sl: TStringList): string;
    function UpperToLowerFunc(sl: TStringList): string;
    function ZenToHanFunc(sl: TStringList): string;
    function LineTopFunc(sl: TStringList): string;
    function LineTopBottomFunc(sl: TStringList): string;
    procedure SetStealth(const Value: Boolean);
    procedure SetOldBoundsRect(const Value: TRect);
    procedure HideStealth;
    procedure ShowStealth;
    procedure SetShowStealthMouseCursor;
    procedure SetShowStealthLR;
    procedure SetShowStealthTB;
    procedure HideListViewTooiTip(ListView: TListView);
    procedure HideTreeViewTooiTip(TreeView: TTreeView);
    function FindNode(Tree: TTreeView; ID: Int64): TTreeNode; 
    function FindItem(List: TListView; ID: Int64): TListItem;
    procedure SetPageControlMainActivePage(Tab: TTabSheet);
    procedure MakeTags(ci: TCommonItem);
    procedure ClearTags;
    procedure TagButtonClick(Sender: TObject);
    procedure SetVisibleMenuToolBar(const Value: Boolean);
    procedure SetVisibleStatusBar(const Value: Boolean);
    procedure SetVisibleTagToolBar(const Value: Boolean);
    procedure SetVisibleSearchToolBar(const Value: Boolean);
    procedure ExportXml(Nodes: TNodesArray; IsSubDir: Boolean);
    procedure SaveXmlFile(IsAll: Boolean);
    procedure ImportXml(TargetNode: TTreeNode);
    procedure ImportXmlOldVer(TargetNode: TTreeNode);
    procedure PasteDateTimeExecute(Fmt: string);
    procedure SetDateTimePasteMode(const Value: TPasteMode);
    procedure SetIsDateTimeCopy(const Value: Boolean);
    procedure IncUseCount(di: TDirItem);
    procedure SetDispBkmkTab(const Value: Boolean);
    procedure SetDispClipTab(const Value: Boolean);
    procedure SetDispLaunchchTab(const Value: Boolean);
    procedure SetDispPasteTab(const Value: Boolean);
    procedure SetDispSearchTab(const Value: Boolean);
    function IsMouseCslRtnPos: Boolean;
    procedure SaveItemAndTags;
    procedure SetColumnAcWidth(const Value: Integer);
    procedure SetColumnCommentWidth(const Value: Integer);
    procedure SetColumnCrWidth(const Value: Integer);
    procedure SetColumnParentWidth(const Value: Integer);
    procedure SetColumnRepWidth(const Value: Integer);
    procedure SetColumnUpWidth(const Value: Integer);
    procedure SetColumnUseWidth(const Value: Integer);
    procedure SetColumnBelongWidth(const Value: Integer);
    procedure SetColumnCaptionWidth(const Value: Integer);
    procedure ChangeListViewColumWidth;
  protected
    procedure WMQueryExcute(var Message: TMessage);
      message WM_QUERY_EXCUTE;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure PastLVWndProc(var Message: TMessage);    
    procedure ClipLVWndProc(var Message: TMessage);        
//    procedure FormWndProc(var Message: TMessage);
  public
    { Public 宣言 }
    TmpTopMost: Boolean;
    Option: TOption;
    IsCursolOnForm, IsBooting: Boolean;
    OptionTabIndex: Integer;
    NotReadDir: Boolean;
    TextDropFlag: Boolean;
    WatchingClip: Boolean; 
    ClipFinishTime: Cardinal;
    procedure WriteINI;
    procedure ReadINI;       
    procedure MenuLineTopItemClick(Sender: TObject);
    procedure MenuLineTopBottomItemClick(Sender: TObject);
    procedure LoadDirFromDB(Tree: TStnTreeView);
//    procedure LoadItemFromDB(EditItem: TEditItem);
    procedure LoadItemFromDB;
    function ShowModalDirProperty(IsNew: Boolean): Integer;
    function ShowModalItemProperty(IsNew: Boolean): Integer;
    procedure SortList(ListView: TStnListView; SortMode: TSortMode; SortOrdAsc: Boolean);
    procedure SortTree(Tree: TTreeView; SortMode: TSortMode; SortOrdAsc: Boolean); overload;
    procedure SortTree(SortMode: TSortMode; SortOrdAsc: Boolean); overload;
    procedure MoveNode(nFrom, nTo: TTreeNode; Mode: TNodeAttachMode);
    procedure CopyNode(nFrom, nTo: TTreeNode);
    procedure DeleteDirKey(id: Int64; IsShortcut: Boolean);
    procedure DeleteDirMouseAction(id: Int64);
    procedure Backup;
    property ActiveTree: TStnTreeView read FActiveTree;
    property ActiveList: TStnListView read FActiveList;
    property ActiveTableID: Byte read FActiveTableID;
    property ActiveTable: string read FActiveTable;
//    property ActiveEditItem: string read FActiveEditItem;
    property EditItem: TEditItem read FEditItem write SetEditItem;
    property DirSortMode: TSortMode read FDirSortMode write SetDirSortMode;
    property DirSortOrdAsc: Boolean read FDirSortOrdAsc write SetDirSortOrdAsc;
    property ItemSortMode: TSortMode read FItemSortMode write SetItemSortMode;
    property ItemSortOrdAsc: Boolean read FItemSortOrdAsc write SetItemSortOrdAsc;
    property ViewStyle: TViewStyle read FViewStyle write SetViewStyle;
    property IsClipToPaste: Boolean read FIsClipToPaste write SetIsClipToPaste;
    property TopMostWnd: Boolean read FTopMostWnd write SetTopMostWnd;
    property ColumnCrVisible: Boolean read FColumnCrVisible write SetColumnCrVisible;
    property ColumnUpVisible: Boolean read FColumnUpVisible write SetColumnUpVisible;
    property ColumnAcVisible: Boolean read FColumnAcVisible write SetColumnAcVisible;
    property ColumnUseVisible: Boolean read FColumnUseVisible write SetColumnUseVisible;
    property ColumnRepVisible: Boolean read FColumnRepVisible write SetColumnRepVisible;
    property ColumnParentVisible: Boolean read FColumnParentVisible write SetColumnParentVisible;
    property ColumnCommentVisible: Boolean read FColumnCommentVisible write SetColumnCommentVisible;
    property ColumnCaptionWidth: Integer read FColumnCaptionWidth write SetColumnCaptionWidth;
    property ColumnCrWidth: Integer read FColumnCrWidth write SetColumnCrWidth;
    property ColumnUpWidth: Integer read FColumnUpWidth write SetColumnUpWidth;
    property ColumnAcWidth: Integer read FColumnAcWidth write SetColumnAcWidth;
    property ColumnUseWidth: Integer read FColumnUseWidth write SetColumnUseWidth;
    property ColumnRepWidth: Integer read FColumnRepWidth write SetColumnRepWidth;
    property ColumnParentWidth: Integer read FColumnParentWidth write SetColumnParentWidth;
    property ColumnCommentWidth: Integer read FColumnCommentWidth write SetColumnCommentWidth; 
    property ColumnBelongWidth: Integer read FColumnBelongWidth write SetColumnBelongWidth;
    property Stealth: Boolean read FStealth write SetStealth;
    property OldBoundsRect: TRect read FOldBoundsRect write SetOldBoundsRect;
    property VisibleMenuToolBar: Boolean read FVisibleMenuToolBar write SetVisibleMenuToolBar;
    property VisibleSearchToolBar: Boolean read FVisibleSearchToolBar write SetVisibleSearchToolBar;
    property VisibleTagToolBar: Boolean read FVisibleTagToolBar write SetVisibleTagToolBar;
    property VisibleStatusBar: Boolean read FVisibleStatusBar write SetVisibleStatusBar;
    property DateTimePasteMode: TPasteMode read FDateTimePasteMode write SetDateTimePasteMode;
    property IsDateTimeCopy: Boolean read FIsDateTimeCopy write SetIsDateTimeCopy;
    property DispSearchTab: Boolean read FDispSearchTab write SetDispSearchTab;
    property DispPasteTab: Boolean read FDispPasteTab write SetDispPasteTab;
    property DispLaunchchTab: Boolean read FDispLaunchchTab write SetDispLaunchchTab;
    property DispBkmkTab: Boolean read FDispBkmkTab write SetDispBkmkTab;
    property DispClipTab: Boolean read FDispClipTab write SetDispClipTab;
  end;

  function EnumWindowsProc(h: HWND; Param: LPARAM): Bool; stdcall;

var
  FormStancher: TFormStancher;
//  {$MESSAGE 'クリップ画像'}
//  {$MESSAGE '暗号化'}
  {$MESSAGE 'Web検索'}
//  {$MESSAGE 'バックアップ'}
//  {$MESSAGE 'スタートアップ'}
//  {$MESSAGE '拡張子'}

implementation

uses FrProperty, DateUtils, Math;

{$R *.dfm}

var IsAlreadyClk{, IsTabDrag}: Boolean;
  hOldWid, HDefView: HWND;
  ClkStart: Cardinal;
  OldClkPos: TPoint;
  OldDragTabIndex: Integer;

function InstallMouseHook(Wnd: HWND): Boolean; stdcall; external 'MOUSEHOOK.DLL';
procedure UnInstallMouseHook; stdcall; external 'MOUSEHOOK.DLL';
function  GetMouseUniqueMessage: Cardinal;stdcall; external 'MOUSEHOOK.DLL';
function InstallKeyHook(Wnd: HWND): Boolean; stdcall; external 'KEYHOOK.DLL';
procedure UnInstallKeyHook; stdcall; external 'KEYHOOK.DLL';
function  GetKeyUniqueMessage: Cardinal;stdcall; external 'KEYHOOK.DLL';


procedure TFormStancher.FormCreate(Sender: TObject);
begin
  IsBooting := True;
  Initialize;
  HideListViewTooiTip(ListViewPaste);
  HideListViewTooiTip(ListViewLaunch);
  HideListViewTooiTip(ListViewBkmk);
  HideListViewTooiTip(ListViewClip);
  HideListViewTooiTip(ListViewAllSearch);
  HideTreeViewTooiTip(TreePaste);
  HideTreeViewTooiTip(TreeLaunch);
  HideTreeViewTooiTip(TreeBkmk);
  HideTreeViewTooiTip(TreeClip);
  TimerAutoBackupTimer(nil);
  IsBooting := False;
end;

procedure TFormStancher.FormDestroy(Sender: TObject);
var i: Integer; lv: TListView;
begin
  UnInstallMouseHook;
  UnInstallKeyHook;
  slLog.Free;
  Option.Free;
//  ListViewPaste.Clear;
//  ListViewLaunch.Clear;
  for i := Integer(eiPaste) to Integer(eiClip) do begin
    lv := EditItemToList(TEditItem(i));
//    lv.OnChange := nil;
    lv.Clear;
  end;
end;

procedure TFormStancher.Initialize;
  function ColumnExsists(table, Column: string): Boolean;
  var tb: TSQLiteTable; i: Integer; sl: TStringList;
  begin
    Result := False;
    sl := TStringList.Create;
    tb := SQLiteDB.GetTable('SELECT * FROM ' + table + ';');
    try
      for i := 0 to tb.ColCount-1 do begin
        sl.Add(tb.Columns[i]);
      end;
      Result := sl.IndexOf(Column) <> -1;
//      DOut(sl.Text);
    finally
      tb.Free;
      sl.Free;
    end;
  end;
var i: Integer;
const ABOVE_NORMAL_PRIORITY_CLASS = $00008000;
begin
  //存在しないカラムの追加
  if not ColumnExsists(TB_PASTE_ITEMS, CN_ADD_KEYS) then begin
    SQLiteDB.ExecSQL('ALTER TABLE "' + TB_PASTE_ITEMS +
      '" ADD COLUMN "' + CN_ADD_KEYS + '" TEXT DEFAULT '''''); 
  end;

  //プロセスの優先順位を変更
  SetPriorityClass(GetCurrentProcess, ABOVE_NORMAL_PRIORITY_CLASS);
  //スレッドの優先順位を変更
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL);

  //初期値設定
  Caption := Application.Title;
//  Application.HintHidePause := 10000;
  ShortCutList := ActionListShorteCut;
//  IsCursolOnForm := True;
  Pasting := False;
  FTopMostWnd := False;
  OptionTabIndex := 0;
  IniConfig.FileName := ConfigFileName;
  PageControlMain.TabPosition :=
    TTabPosition(IniConfig.ReadInt(Name,
                 'PageControlMain.TabPosition',
                 Integer(PageControlMain.TabPosition)));
  DropTextPaste.Window := nil;
  DropTextPaste.Window := ListViewPaste;
  DropFilesLaunch.TargetControl := nil;
  DropFilesLaunch.TargetControl := ListViewLaunch;
  DropTextBkmk.Window := nil;
  DropTextBkmk.Window := ListViewBkmk;
  
  Application.OnHint := ShowHint;
  SetImageLists;
  FVisibleMenuToolBar   := True;
  FVisibleSearchToolBar := True;
  FVisibleTagToolBar    := True;
  FVisibleStatusBar     := True;

  FIsDateTimeCopy := False;

  FColumnCrVisible      := True;
  FColumnUpVisible      := False;
  FColumnAcVisible      := False;
  FColumnUseVisible     := True;
  FColumnRepVisible     := True;
  FColumnParentVisible  := False;
  FColumnCommentVisible := False;

  FColumnCaptionWidth := 140;
  FColumnCrWidth      := 120;
  FColumnUpWidth      := 120;
  FColumnAcWidth      := 120;
  FColumnUseWidth     := 70;
  FColumnRepWidth     := 70;
  FColumnParentWidth  := 80;
  FColumnCommentWidth := 150;
  ColumnBelongWidth   := 100;

  FDispSearchTab   := True;
  FDispPasteTab    := True;
  FDispLaunchchTab := True;
  FDispBkmkTab     := True;
  FDispClipTab     := True;

  FStealth := False;

//  EditQuery.Clear;
//  MakeListColumns;
//  EditItem := eiClip;
  //フック
  InstallMouseHook(Application.Handle);
  InstallKeyHook(Application.Handle);
  //作成
  if not DirectoryExists(ConfigDir) then ForceDirectories(ConfigDir);
  if not DirectoryExists(TmpDir) then ForceDirectories(TmpDir);
  //オブジェクト作成
  slLog := TStringList.Create;
  Option := TOption.Create;

  //ツリー作成
  LoadDirFromDB(TreePaste);
  LoadDirFromDB(TreeLaunch);
  LoadDirFromDB(TreeBkmk);

  //クリップボードリストの読み込み
  LoadClipboardList;
  Pasting := True;
  ClipboardWatcher.Enabled := True;  
  Pasting := False;

  //設定読込 
  ReadINI;    
  Option.ReadIni;

  //ウィンドウプロシージャの入れ替え    
//  DefFormWndProc := WindowProc;
//  WindowProc := FormWndProc;
  DefPasteLVWndProc := ListViewPaste.WindowProc;
  ListViewPaste.WindowProc := PastLVWndProc;
  DefClipLVWndProc := ListViewClip.WindowProc;
  ListViewClip.WindowProc := ClipLVWndProc;

//  Stealth := IniConfig.ReadBool(Self.Name, 'Stealth', Stealth);

  if Option.OneClickExcute then begin
    FOldClipClk := ListViewPaste.OnDblClick;
    FOldClipDblClk := nil;
  end else begin                        
    FOldClipClk := ListViewPaste.OnClick;
    FOldClipDblClk := ListViewPaste.OnDblClick;
  end;

//  DoubleBuffered := True;
  for i := 0 to ControlCount-1 do begin
    if Controls[i] is TWinControl then
      TWinControl(Controls[i]).DoubleBuffered := True;
  end;
//  ListViewLaunch.DoubleBuffered := True;
//  TreeLaunch.DoubleBuffered := True;
//  PageControlMain.DoubleBuffered := True;
//  TabLaunch.DoubleBuffered := True;

  ClipFinishTime := GetTickCount;

  //チェック
  CheckActionEnabled;
end;

procedure TFormStancher.SetImageLists;
begin
  TreePaste.Images  := DirIcons.ImagesS;
  TreeLaunch.Images := DirIcons.ImagesS;
  TreeBkmk.Images   := DirIcons.ImagesS;
  TreeClip.Images   := DirIcons.ImagesS;
  ListViewClip.SmallImages := ImageListClipS;
  ListViewClip.LargeImages := ImageListClipL;
end;

procedure TFormStancher.CheckActionEnabled;
var IsTreeActive, IsListActive, IsTreeSelect, {IsEmptyList, }IsListSelect,
  IsSelectTextItem, IsPasteActive: Boolean;
begin
  { ツリー }
  if ActiveTree <> nil then begin;
    IsTreeActive := Assigned(ActiveTree);
    IsTreeSelect := IsTreeActive and (ActiveTree.Selected <> nil);
  end else begin
    IsTreeActive := False;
    IsTreeSelect := False
  end;
  ActCreateDir.Enabled := IsTreeActive;
  ActEditDir.Enabled := IsTreeSelect;
  ActDeleteDir.Enabled := IsTreeSelect;
  ActCopyDir.Enabled := IsTreeSelect;
  ActCutDir.Enabled := IsTreeSelect;

  //ツリーソート
  SetTreeSortAction;

  IsPasteActive := EditItem = eiPaste;
  { インポート }
  ActImportXml.Enabled := IsPasteActive;
  ActImportXmlOldVer.Enabled := IsPasteActive;
  { エクスポート }
  ActExportAll.Enabled := IsPasteActive;
  ActExportSel.Enabled := IsTreeSelect and IsPasteActive;

  if IsTreeActive then
    ActPaste.Enabled := ActiveTree.CanDropNode or ActiveTree.CanDropItems;

  { リスト }
  IsListActive := Assigned(ActiveList);
  if not IsListActive then Exit;
  IsListSelect := ActiveList.Selected <> nil;
//  IsEmptyList := ActiveList.Items.Count = 0;
  //貼り付け/コピー
  ActSendPaste.Enabled := IsListSelect;
  ActSendToClip.Enabled := IsListSelect;
  IsSelectTextItem := IsListSelect and (TObject(ActiveList.Selected.Data) is TTextItem);
  ActSendPaste.Visible := IsSelectTextItem;
  ActSendToClip.Visible := IsSelectTextItem;
  MenuItemEditText.Visible := IsSelectTextItem;
  //アイテム操作
  ActCreateItem.Enabled := IsTreeSelect;
  ActEditItem.Enabled := IsTreeSelect and IsListSelect;
  ActDeleteItem.Enabled := IsListSelect;
  ActCopyItem.Enabled := IsTreeSelect and IsListSelect;
  ActCutItem.Enabled := IsTreeSelect and IsListSelect;
  //リストソート
//  ActSortListUser.Enabled := IsTreeSelect;
//  ActSortListName.Enabled := IsTreeSelect;
//  ActSortListCr.Enabled := IsTreeSelect;
//  ActSortListUp.Enabled := IsTreeSelect;
//  ActSortListAc.Enabled := IsTreeSelect;
//  ActSortListUse.Enabled := IsTreeSelect;
//  ActSortListRep.Enabled := IsTreeSelect;
//  ActSortListParent.Enabled := IsTreeSelect;
//  ActSortListComment.Enabled := IsTreeSelect;
//  ActSortListRevers.Enabled := IsTreeSelect;
//  ActSortListVal.Visible := IsTreeSelect and (EditItem = eiAllSearch);
  //リスト表示
  ActDispListIcon.Enabled := IsTreeSelect;
  ActDispListSmallIcon.Enabled := IsTreeSelect;
  ActDispListList.Enabled := IsTreeSelect;
  ActDispListReport.Enabled := IsTreeSelect;
  if EditItem = eiClip then begin
    ActDispListIcon.Enabled := True;
    ActDispListSmallIcon.Enabled := True;
    ActDispListList.Enabled := True;
    ActDispListReport.Enabled := True;
  end;
//  ActReloadDir.Enabled := IsTreeSelect and (not IsEmptyList);
//  if (not IsTreeSelect) and (EditItem <> eiClip) then
//    for i := 0 to ActionList.ActionCount-1 do begin
//      act := TAction(ActionList.Actions[i]);
//      if (act.GroupIndex = 21) or (act.GroupIndex = 22) then
//        act.Checked := False;
//    end;
  //ランチャーメニュー
  ActOpenLaunchDir.Visible := PageControlMain.ActivePage = TabLaunch;
  ActOpenLaunchDir.Enabled := IsListSelect;
  //ブックマーク登録
  ActAddBookMarks.Visible := PageControlMain.ActivePage = TabBkmk;
  ActAddBookMarks.Enabled := IsTreeSelect;
end;

function TFormStancher.TreeToTableID(Tree: TStnTreeView): Byte;
begin
  if Tree = TreePaste then Result := TBID_PASTE_ITEMS
  else if Tree = TreeLaunch then Result := TBID_LAUNCH_ITEMS
  else if Tree = TreeBkmk then Result := TBID_BKMK_ITEMS
  else if Tree = TreeClip then Result := TBID_CLIP_ITEMS
  else Result := 0;
end;

function TFormStancher.EditItemToTableID(EditItem: TEditItem): Byte;
begin
  case EditItem of
    eiPaste: Result := TBID_PASTE_ITEMS;
    eiLaunch: Result := TBID_LAUNCH_ITEMS;
    eiBkmk: Result := TBID_BKMK_ITEMS;
    eiClip: Result := TBID_CLIP_ITEMS;
    else Result := 0;
  end;
end;

function TFormStancher.ShowModalDirProperty(IsNew: Boolean): Integer;
var n, Target: TTreeNode; di: TDirItem; Tree: TStnTreeView;
begin
  Result := mrCancel;
  Tree := ActiveTree;
  if not Assigned(Tree) then Exit;
  di := nil;
  Target := Tree.Selected;
//  ApplicationEvents.OnMessage := nil;
  FormProperty := TFormProperty.Create(Self);
  try
    if IsNew then begin
      FormProperty.Caption := '新規フォルダの作成';
      FormProperty.OKBtn.Caption := '作成';
      FormProperty.EditName.Text := '新しいフォルダ';
      if Option.IsClipToDirName then
        FormProperty.EditName.Text := GetAvailablenessLine(Clipboard.AsText);
      FormProperty.ImageIcon.Picture.Icon := TIconItem(DirIcons[0]).Icon;
    end else begin
      if Target = nil then Exit;
      di := TDirItem(Target.Data);
      FormProperty.Caption := di.Name + 'の編集';
      FormProperty.LoadFromItem(di);
    end;
    FormProperty.ItemEditMode := iemDir;
    FormProperty.ListIcons := DirIcons;
    FormProperty.SetTabVisible(FormProperty.TabDir);
    FormProperty.IsNew := IsNew;
    FormProperty.ReadIni(IniConfig);
    Result := FormProperty.ShowModal;
    if Result = mrOk then begin
      BeginTransaction;
//      try
        if IsNew then begin
          di := TDirItem.Create(Target);
          FormProperty.SaveToItem(di);
          di.TableID := ActiveTableID;
          di.ViewStyle := vsReport;
          di.Insert;
          n := Tree.Items.AddChildObject(Target, di.Name, Pointer(di));
          di.Node := n;
          n.Selected := True;
        end else begin
          FormProperty.SaveToItem(di);
          if FormProperty.CheckBoxIsAllLowerDir.Checked then
            di.UpdateAllLowerDir
          else di.Update;
          Target.Text := di.Name;
          Target.ImageIndex := di.IconItem.Index;
          Target.SelectedIndex := di.IconItem.Index;
        end;                              
        Commit;         
        SortList(ActiveList ,di.SortMode, di.SortOrdAsc);
        LoadItemFromDB;
        FormProperty.WriteIni(IniConfig);
//      except
//        Rollback;
//      end;
    end;
  finally
    FormProperty.Release;
//    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  end;
end;

function TFormStancher.ShowModalItemProperty(IsNew: Boolean): Integer;
var Icons: TIconList; Cls: TCommonItemClass; Tab: TTabSheet;
  sCaption, sText: string; iem: TItemEditMode;
  //<AddItem>
  function SetValues: Boolean;
  begin
    Result := False;
    case EditItem of   
//      eiPaste: begin
//        Icons := DirIcons; Cls := TDirItem; Tab := FormProperty.TabDir;
//        sCaption := '新規フォルダの作成';
//        sText := '新しいフォルダアイテム';
//        iem := iemDir;
//      end;
      eiPaste: begin
        Icons := PasteIcons; Cls := TPasteItem; Tab := FormProperty.TabPaste;
        sCaption := '新規ペーストアイテムの作成';
        sText := '';
        if Option.IsClipToPasteName then
          sText := GetAvailablenessLine(Clipboard.AsText);
        iem := iemPaste;
      end;
      eiLaunch: begin
        Icons := LaunchIcons; Cls := TLaunchItem; Tab := FormProperty.TabLaunch;
        sCaption := '新規ランチャーアイテムの作成';
        sText := '';
        if Option.IsClipToLauncherName then
          sText := GetAvailablenessLine(Clipboard.AsText);
        iem := iemLaunch;
        FormProperty.ImageIcon.OnClick := nil;
        FormProperty.ImageIcon.Cursor := crDefault;
      end;
      eiBkmk: begin
        Icons := BkmkIcons; Cls := TBkmkItem; Tab := FormProperty.TabBkmk;
        sCaption := '新規ブックマークの作成';
        sText := '';         
        if Option.IsClipToBkmkName then
          sText := GetAvailablenessLine(Clipboard.AsText);
        iem := iemBkmk;  
      end;
      eiClip: begin
        Icons := ClipIcons; Cls := TClipItem; Tab := FormProperty.TabClip;
        sCaption := '新規クリップボード履歴の作成';
        sText := '';
        iem := iemClip;
      end;
      else Exit;;
    end;
    Result := True;
  end;
var Target: TListItem; Parent: TTreeNode; ci: TCommonItem; tmpTopMostWnd: Boolean;
begin
  Result := mrCancel;
  if not Assigned(ActiveTree) then Exit;
  if not Assigned(ActiveList) then Exit;
  ci := nil;
  Parent := ActiveTree.Selected;
  Target := ActiveList.Selected;
//  ApplicationEvents.OnMessage := nil;
  FormProperty := TFormProperty.Create(Self);
  tmpTopMostWnd := TopMostWnd;
  try
    if not SetValues then Exit;
    if IsNew then begin
      FormProperty.Caption := sCaption;
      FormProperty.EditName.Text := sText;
      FormProperty.ImageIcon.Picture.Icon := TIconItem(Icons[0]).Icon;
      FormProperty.OKBtn.Caption := '作成';
      if (EditItem = eiPaste) and Option.IsClipToPasteText then
        FormProperty.MemoText.Text := Clipboard.AsText;
    end else begin
      if Target = nil then Exit;
      FormProperty.ImageIcon.OnClick := FormProperty.ImageIconClick;
      FormProperty.ImageIcon.Cursor := crHandPoint;
      ci := TCommonItem(Target.Data);
      FormProperty.Caption := ci.Name + 'の編集';
      FormProperty.LoadFromItem(ci);
    end;
    TopMostWnd := False;
//    yhOthers.StayOnTop(Handle, False);
    FormProperty.ItemEditMode := iem;
    FormProperty.ListIcons := Icons;
    FormProperty.SetTabVisible(Tab);
    FormProperty.IsNew := IsNew;
    FormProperty.ReadIni(IniConfig);
    Result := FormProperty.ShowModal;
    if Result = mrOk then begin
//      BeginTransaction;
      try
        if IsNew then begin
          ci := Cls.Create(Parent);
          FormProperty.SaveToItem(ci);
          ci.Insert;
          ActiveList.List.Add(ci);
          ActiveList.AddIcon(ci.IconItem.Icon);
//          ActiveList.SmallImages.AddIcon(ci.IconItem.Icon);
//          ActiveList.LargeImages.AddIcon(ci.IconItem.Icon);
          ActiveList.Update;
        end else begin
          FormProperty.SaveToItem(ci);
          ci.Update;
          Target.Caption := ci.Name;
          ActiveList.ReplaceIcon(ActiveList.ItemIndex, ci.IconItem.Icon);
//          ActiveList.SmallImages.ReplaceIcon(Target.ImageIndex, ci.IconItem.Icon);
//          ActiveList.LargeImages.ReplaceIcon(Target.ImageIndex, ci.IconItem.Icon);
//          Target.ImageIndex := ActiveList.Selected.Index;
//          LoadItemFromDB;
        end;
//        Commit;
        FormProperty.WriteIni(IniConfig);
//        yhOthers.StayOnTop(Handle, tmpTopMostWnd);
      except
//        Rollback;
      end;
    end;
  finally
    FormProperty.Release;
    FormProperty := nil;
    TopMostWnd := tmpTopMostWnd;
//    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  end;
end;

procedure TFormStancher.ActCreateDirExecute(Sender: TObject);
begin
  ShowModalDirProperty(True);
end;

procedure TFormStancher.ActEditDirExecute(Sender: TObject);
begin
  ShowModalDirProperty(False);
end;

procedure TFormStancher.PopupItem(Sender: TObject);
begin
  CheckActionEnabled;
end;

procedure TFormStancher.DeleteDir;
var n: TTreeNode; Tree: TStnTreeView;
begin    
  Tree := ActiveTree;
  if not Assigned(Tree) then Exit;
  n := Tree.Selected;
  if n = nil then Exit;
  BeginTransaction;
  try
    TPasteItem(n.Data).Delete;
    n.Delete;
    Commit;      
    ActiveList.Clear;
  except
    Rollback;
  end;
end;

procedure TFormStancher.ActDeleteDirExecute(Sender: TObject);
begin
  if Option.ConfDelDir then
    if ActiveTree = nil then Exit;
    if (MessageDlg('"' + ActiveTree.Selected.Text + '"を削除しますか？',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;
  Screen.Cursor := crHourGlass;
  try
    DeleteDir;
    ClearTags;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormStancher.TreePasteDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  if TObject(Node.Data) <> nil then TObject(Node.Data).Free;
end;

procedure TFormStancher.LoadDirFromDB(Tree: TStnTreeView);
  procedure MakeDir(Tree: TStnTreeView; AParent: TTreeNode);
  var tb: TSQLiteTable; sql: string; di: TDirItem; n: TTreeNode; var id: Integer;
  begin
    if AParent = nil then id := 0 else id := TDirItem(AParent.Data).ID;
    sql := 'SELECT * FROM ' + TB_DIR_ITEMS +
      ' WHERE ' + CN_TABLE_ID + ' = ' + IntToStr(TreeToTableID(Tree)) +
      ' AND ' + CN_PARENT_ID + ' = ' + IntToStr(id) + ' ;';
    tb := SQLiteDB.GetTable(sql);
    try
      with tb do begin
        MoveFirst;
        while not Eof do begin
          di := TDirItem.Create(AParent);
          di.SetFields(tb);
          n := Tree.Items.AddChildObject(AParent, di.Name, di);
          di.Node := n;
          MakeDir(Tree, n);
          Next;
        end;
      end;
    finally
      tb.Free;
    end;
  end;
begin
  Tree.Items.Clear;
  MakeDir(Tree, nil);
end;

procedure TFormStancher.TreePasteAddition(Sender: TObject;
  Node: TTreeNode);
var i: Integer;
begin
  if Node.Data = nil then Exit;
  i := TDirItem(Node.Data).IconItem.Index;
  Node.ImageIndex := i;
  Node.SelectedIndex := i;
end;


procedure TFormStancher.SetEditItem(const Value: TEditItem);
begin
  FEditItem := Value;
//  PageControlMain.ActivePageIndex := Integer(Value);
  FActiveTree := EditItemToTree(Value);
  FActiveList := EditItemToList(Value);
  FActiveTableID := EditItemToTableID(Value);   
  FActiveTable := EditItemToTable(Value);
  CheckActionEnabled;
end;

procedure TFormStancher.PageControlMainChange(Sender: TObject);
begin
  if PageControlMain.ActivePage = TabAllSearch then
    EditItem := eiAllSearch
  else if PageControlMain.ActivePage = TabPaste then
    EditItem := eiPaste
  else if PageControlMain.ActivePage = TabLaunch then
    EditItem := eiLaunch
  else if PageControlMain.ActivePage = TabBkmk then
    EditItem := eiBkmk
  else
    EditItem := eiClip;

  if Assigned(ActiveTree) and Assigned(ActiveTree.Selected) and (not NotReadDir) then
    LoadItemFromDB;

  IsClipToPaste := False;
  NotReadDir := False;
end;

function TFormStancher.EditItemToList(EditItem: TEditItem): TStnListView;
begin
  case EditItem of
    eiPaste:  Result := ListViewPaste;
    eiLaunch: Result := ListViewLaunch;
    eiBkmk:   Result := ListViewBkmk;
    eiClip:   Result := ListViewClip;
    else Result := ListViewAllSearch;
  end;
end;

function TFormStancher.EditItemToTree(EditItem: TEditItem): TStnTreeView;
begin
  case EditItem of
    eiPaste:  Result := TreePaste;
    eiLaunch: Result := TreeLaunch;
    eiBkmk:   Result := TreeBkmk;
//    eiClip:   Result := TreeClip;
    else Result := nil;
  end;
end;

function TFormStancher.EditItemToTable(EditItem: TEditItem): string;
begin
  case EditItem of
    eiPaste:  Result := TB_PASTE_ITEMS;
    eiLaunch: Result := TB_LAUNCH_ITEMS;
    eiBkmk:   Result := TB_BKMK_ITEMS;
    eiClip:   Result := TB_CLIP_ITEMS;
    else Result := '';
  end;
end;

procedure TFormStancher.SetListColumns(EditItem: TEditItem);
  function IndexOfListColumn(lv: TListView; s: string): Integer;
  var i: Integer;
  begin
    Result := -1;
    for i := 0 to lv.Columns.Count-1 do begin
      if s = lv.Columns[i].Caption then begin
        Result := i;
        Exit;
      end;
    end;
  end;
  procedure AddListViewColumn(lv: TListView; ACaption: string; AWidth: Integer;
    AAlignment: TAlignment = taLeftJustify);
  begin
  with lv.Columns.Add do begin
    if IndexOfListColumn(lv, ACaption) = -1 then
      Width := AWidth;//IniConfig.ReadInt(lv.Name, 'Column.Width[' + ACaption + ']', AWidth);
    Caption := ACaption;
//    Width := AWidth;
    Alignment := AAlignment;
  end;
  end;
var lv: TStnListView;
begin
  lv := EditItemToList(EditItem);
  lv.Items.BeginUpdate;
  lv.Columns.Clear;

  AddListViewColumn(lv, '名前', ColumnCaptionWidth);
  if ColumnCrVisible then AddListViewColumn(lv, '作成日', ColumnCrWidth);
  if ColumnUpVisible then AddListViewColumn(lv, '更新日', ColumnUpWidth);
  if ColumnAcVisible then AddListViewColumn(lv, '最終使用日', ColumnAcWidth);
  if ColumnUseVisible then AddListViewColumn(lv, '使用回数', ColumnUseWidth, taRightJustify);
  if ColumnRepVisible then AddListViewColumn(lv, '使用頻度', ColumnRepWidth, taRightJustify);
  if EditItem <> eiClip then
    if ColumnParentVisible then AddListViewColumn(lv, '親フォルダ', ColumnParentWidth);
  if ColumnCommentVisible then AddListViewColumn(lv, 'コメント', ColumnCommentWidth);
  if EditItem = eiAllSearch then
    AddListViewColumn(lv, '所属', ColumnBelongWidth);
  lv.Items.EndUpdate;
end;

procedure TFormStancher.MakeListColumns;
var i: Integer;
begin
  if StopMakeListColumns then Exit;
  for i := Integer(eiAllSearch) to Integer(eiClip) do
    SetListColumns(TEditItem(i));
end;

procedure TFormStancher.SetDirSortMode(const Value: TSortMode);
begin
  if FDirSortMode <> Value then FDirSortOrdAsc := True
  else FDirSortOrdAsc := not FDirSortOrdAsc;
  FDirSortMode := Value;
  SortTree(FDirSortMode, FDirSortOrdAsc);
end;

procedure TFormStancher.SetDirSortOrdAsc(const Value: Boolean);
begin
  FDirSortOrdAsc := Value;
  SortTree(FDirSortMode, FDirSortOrdAsc);
end;

procedure TFormStancher.SortTree(SortMode: TSortMode; SortOrdAsc: Boolean);
begin
  SortTree(ActiveTree, SortMode, SortOrdAsc);
end;

procedure TFormStancher.TreeCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
var di1, di2: TDirItem;
begin
  di1 := TDirItem(Node1.Data);
  di2 := TDirItem(Node2.Data);
  case DirSortMode of
    smName: Compare := CompareText(di1.Name, di2.Name);
    smCr:   Compare := CompareDateTime(di1.CreateDate, di2.CreateDate);
    smUp:   Compare := CompareDateTime(di1.UpdateDate, di2.UpdateDate);
    smAc:   Compare := CompareDateTime(di1.AccessDate, di2.AccessDate);
    smUse:  Compare := CompareValue(di1.UseCount, di2.UseCount);
    smRep:  Compare := CompareValue(di1.Repetition, di2.Repetition);
    smParent: Compare := CompareText(GetParentText(di1.Parent), GetParentText(di2.Parent));
    smComment: Compare := CompareText(di1.Comment, di2.Comment);
    else    Compare := CompareValue(di1.Order, di2.Order);
  end;
  if not DirSortOrdAsc then Compare := -Compare;
end;

function TFormStancher.GetParentText(Node: TTreeNode): string;
begin
  if Assigned(Node) then
    Result := Node.Text
  else
    Result := '';
end;

procedure TFormStancher.SetItemSortMode(const Value: TSortMode);
begin
  if FItemSortMode <> Value then FItemSortOrdAsc := True
  else FItemSortOrdAsc := not FItemSortOrdAsc;
  FItemSortMode := Value;
  SortList(ActiveList ,FItemSortMode, FItemSortOrdAsc);
//  SaveItemAndTags;
end;

procedure TFormStancher.SetItemSortOrdAsc(const Value: Boolean);
begin
  FItemSortOrdAsc := Value;
  SortList(ActiveList ,FItemSortMode, FItemSortOrdAsc);
end;

function ListSortCompare(Item1, Item2: Pointer): Integer;
var ci1, ci2: TCommonItem;
begin
  Result := 0;
  ci1 := TCommonItem(Item1);
  ci2 := TCommonItem(Item2);
  case FormStancher.ItemSortMode of
    smName: Result := CompareText(ci1.Name, ci2.Name);
    smCr:   Result := CompareDateTime(ci1.CreateDate, ci2.CreateDate);
    smUp:   Result := CompareDateTime(ci1.UpdateDate, ci2.UpdateDate);
    smAc:   Result := CompareDateTime(ci1.AccessDate, ci2.AccessDate);
    smUse:  Result := CompareValue(ci1.UseCount, ci2.UseCount);
    smRep:  Result := CompareValue(ci1.Repetition, ci2.Repetition);
    smParent: Result := CompareText(ci1.ParentName, ci2.ParentName);
    smComment: Result := CompareText(ci1.Comment, ci2.Comment);
    smVal: begin
      case FormStancher.EditItem of
        eiPaste, eiClip: CompareValue(Integer(TTextItem(ci1).Mode), Integer(TTextItem(ci2).Mode));
        eiLaunch: CompareText(TLaunchItem(ci1).FileName, TLaunchItem(ci2).FileName);
        eiBkmk: CompareText(TBkmkItem(ci1).Url, TBkmkItem(ci2).Url);
        else Result := 0;
      end;
    end;
    else    Result := CompareValue(ci1.Order, ci2.Order);
  end;
  if FormStancher.Option.DispLauncherExt and (FormStancher.EditItem = eiLaunch) then
    Result := CompareText(ExtractFileName(TLaunchItem(ci1).FileName),
                          ExtractFileName(TLaunchItem(ci2).FileName));
  //フォルダが上に来る処理
  if (ci1 is TDirItem) and not(ci2 is TDirItem) then Result := LessThanValue;
  if not(ci1 is TDirItem) and (ci2 is TDirItem) then Result := GreaterThanValue;
  if not FormStancher.ItemSortOrdAsc then Result := -Result;
end;

procedure TFormStancher.SortList(ListView: TStnListView; SortMode: TSortMode; SortOrdAsc: Boolean);
var i: Integer; bmp, mask: TBitmap;
begin
  FItemSortMode := SortMode;
  FItemSortOrdAsc := SortOrdAsc;
  Screen.Cursor := crHourGlass;
  try
    if ListView = ListViewClip then begin
      FClipItemSortMode := SortMode;
      FClipItemSortOrdAsc := SortOrdAsc;
    end else if ListView = ListViewAllSearch then begin
      FSearchItemSortMode := SortMode;
      FSearchItemSortOrdAsc := SortOrdAsc;
    end;
    with ListView do begin
      LargeImages.Clear;
      SmallImages.Clear;
      List.Sort(ListSortCompare);
      for i := 0 to List.Count-1 do begin
        try
          AddIcon(TCommonItem(List[i]).IconItem.Icon);
        except                
          SmallImages.AddIcon(TCommonItem(List[i]).IconItem.Icon);
          bmp := TBitmap.Create;
          bmp.Width := 32;
          bmp.Height := 32;     
          mask := TBitmap.Create;
          mask.Width := 32;
          mask.Height := 32;
          DrawIconEx(bmp.Canvas.Handle, 0, 0,
            TCommonItem(List[i]).IconItem.Icon.Handle,
            32, 32, 0, 0, DI_NORMAL);
          mask.Assign(bmp);
          mask.Mask(clWhite);
          LargeImages.Add(bmp, mask);
          bmp.Free;
          mask.Free;
        end;
      end;
      Update;
    end;
    ActSortListRevers.Checked := not FItemSortOrdAsc;
//    if NotReadDir then
//      beep;
    case FItemSortMode of
      smName: ActSortListName.Checked := True;
      smCr: ActSortListCr.Checked := True;
      smUp: ActSortListUp.Checked := True;
      smAc: ActSortListAc.Checked := True;
      smUse: ActSortListUse.Checked := True;
      smRep: ActSortListRep.Checked := True;
      smParent: ActSortListParent.Checked := True;
      smComment: ActSortListComment.Checked := True;
//      smVal: ActSortListVal.Checked := True;
      else ActSortListUser.Checked := True;
    end;
  finally
    Screen.Cursor := crDefault;
    SetListViewColumImage(ListView); 
    SaveOnItemChange;
  end;
end;

procedure TFormStancher.ClearTags;
var i: Integer;
begin
  for i := ToolBarTag.ButtonCount-1 downto 0 do
    ToolBarTag.Buttons[i].Free;
end;

procedure TFormStancher.MakeTags(ci: TCommonItem);
var {btn: TToolButton;}btn: TSpeedButton; sl: TStringList; i: Integer;
begin
  ClearTags;
  sl := TStringList.Create;
  try
    sl.CommaText := ci.Tags.CommaText;
    for i := sl.Count-1 downto 0 do begin
      if sl[i] = '' then Continue;  
//      btn := TToolButton.Create(Self);
      btn := TSpeedButton.Create(Self);
////      btn.ParentFont := True;
      btn.Caption := sl[i];
      btn.Parent := ToolBarTag;
      btn.Hint := '「' + sl[i] + '」タグを検索します。';
//      btn.Spacing := -1;
      if not UseThemes then
        btn.Transparent := False;
      btn.Flat := True;
      btn.ShowHint := True;
      btn.Width := ToolBarTag.Canvas.TextWidth(sl[i]) + 6;
      btn.OnClick := TagButtonClick;
    end;
  finally
    sl.Free;
  end;
end;

//procedure TFormStancher.LoadItemFromDB(EditItem: TEditItem);
procedure TFormStancher.LoadItemFromDB;
var tb: TSQLiteTable; n: TTreeNode; di: TDirItem; ci: TCommonItem; lv: TStnListView;
  sql: string; tv: TTreeView; id: Integer;
begin       
//  lv := EditItemToList(EditItem);
//  tv := EditItemToTree(EditItem);
  MakeListColumns;
  lv := ActiveList;
  tv := ActiveTree;
  if not Assigned(lv) then Exit;
  if not Assigned(tv) then Exit;
  ClearPastModeBtn(ToolBarPaste);
  CheckActionEnabled;
  lv.Clear;
  n := tv.Selected;
  if not Assigned(n) then Exit;
  di := TDirItem(n.Data);
  MakeTags(di);
  id := di.ID;
//  sql := 'SELECT * FROM ' + EditItemToTable(EditItem)  +
  sql := 'SELECT * FROM ' + ActiveTable  +
    ' WHERE ' + CN_PARENT_ID + ' = ' + IntToStr(id) + ';';
  tb := SQLiteDB.GetTable(sql);
//  tb := TDirItem.Select(CN_PARENT_ID + ' = ' + IntToStr(di.ID));
  try
    with tb do begin
      MoveFirst;
      while not Eof do begin
        case EditItem of
          eiLaunch: ci := TLaunchItem.Create(n);
          eiBkmk:   ci := TBkmkItem.Create(n);
          eiClip:   ci := TClipItem.Create(n);
          else      ci := TPasteItem.Create(n);
        end;
        ci.SetFields(tb);
        lv.List.Add(ci);
        try
//          lv.AddIcon(ci.IconItem.Icon);
        except
//          lv.AddIcon(TIconItem(DirIcons[0]).Icon);
        end;
        Next;
      end;
    end;
  finally
    tb.Free;
  end;
  ViewStyle := di.ViewStyle;
  SortList(ActiveList, di.SortMode, di.SortOrdAsc);
  //*************
//  di.IncUseCount;
end;

procedure TFormStancher.TreePasteClick(Sender: TObject);
var p: TPoint; t: TTreeView;
begin
  t := TTreeView(Sender);
  GetCursorPos(p);
  p := t.ScreenToClient(p);
  if t.GetNodeAt(p.X, p.Y) = nil then begin
    t.Selected := nil;
    t.ClearSelection;
  end;
end;

procedure TFormStancher.ActCreateItemExecute(Sender: TObject);
begin
  ShowModalItemProperty(True);
//  case EditItem of
//    eiLaunch: ShowModalItemProperty(True);
//    eiBkmk: ;
//    eiClip: ;
//  else ShowModalItemProperty(True);
//  end;
end;

procedure TFormStancher.ListViewPasteData(Sender: TObject;
  Item: TListItem);
  function SMtoS(AMode: TSortMode): string;
  begin
    case AMode of
      smName: Result := '名前';
      smCr:   Result := '作成日時';
      smUp:   Result := '更新日時';
      smAc:   Result := 'アクセス日時';
      smUse:  Result := '使用回数';
      smRep:  Result := '使用頻度';
      smVal:  Result := '値';
      else Result := 'ユーザー定義';
    end;
  end;                
  function PMtoS(AMode: TPasteMode): string;
  begin
    case AMode of
      pmPaste: Result := '貼り付け';
      pmCopy:  Result := 'コピー';
      pmCarret:Result := 'キャレット位置指定貼り付け';
      else Result := 'マクロ';
    end;
  end;       
  function DtoS(DateTime: TDateTime): string;
  begin
    Result := FormatDateTime(Option.ListDateTimeFmt, DateTime);
  end;
var it: TCommonItem;
begin     
  if Sender = nil then Exit;
  if Item = nil then Exit;
  it := TCommonItem(TStnListView(Sender).List[Item.Index]);
  if it = nil then Exit;
//  DOut('begin');
  Item.Data := it;
  Item.Caption := it.Name;
  if (Sender = ListViewLaunch) and Option.DispLauncherExt then
    Item.Caption := ExtractFileName(TLaunchItem(it).FileName);
  Item.ImageIndex := Item.Index;
  if ColumnCrVisible then Item.SubItems.Add(DtoS(it.CreateDate));
  if ColumnUpVisible then Item.SubItems.Add(DtoS(it.UpdateDate));
  if ColumnAcVisible then Item.SubItems.Add(DtoS(it.AccessDate));
  if ColumnUseVisible then Item.SubItems.Add(IntToStr(it.UseCount));
  if ColumnRepVisible then Item.SubItems.Add(it.RepetitionStr);
  if Sender <> ListViewClip then
    if ColumnParentVisible then
      Item.SubItems.Add(it.ParentName);
  if ColumnCommentVisible then Item.SubItems.Add(it.Comment); 
//  DOut('end');
  if Item.ListView = ListViewAllSearch then begin
    if it is TDirItem then begin
      case TDirItem(it).TableID of
//        0:;
//        else DOutI(TDirItem(it).TableID);
        TBID_PASTE_ITEMS: Item.SubItems.Add('貼り付け');
        TBID_LAUNCH_ITEMS: Item.SubItems.Add('ランチャー');
        TBID_BKMK_ITEMS: Item.SubItems.Add('ブックマーク');
      end;
    end else begin
      if it is TPasteItem then Item.SubItems.Add('貼り付け');
      if it is TLaunchItem then Item.SubItems.Add('ランチャー');
      if it is TBkmkItem then Item.SubItems.Add('ブックマーク');
      if it is TClipItem then Item.SubItems.Add('クリップボード');
    end;
  end;

//  case EditItem of
//    eiPaste:  Item.SubItems.Add(PMtoS(TPasteItem(it).Mode));
//    eiLaunch: Item.SubItems.Add(TLaunchItem(it).FileName);
//    eiBkmk:   Item.SubItems.Add(TBkmkItem(it).Url);
//    eiClip:   Item.SubItems.Add(PMtoS(TClipItem(it).Mode));
//  end;
end;

procedure TFormStancher.ActEditItemExecute(Sender: TObject);
begin
  ShowModalItemProperty(False);
end;

procedure TFormStancher.ActDeleteItemExecute(Sender: TObject);
var itm: TListItem; ci: TCommonItem; i: Integer; s: string;
begin      
  if Option.ConfDelItem then
    if ActiveList = nil then Exit;
    if ActiveList.SelCount = 0 then
      Exit
    else if ActiveList.SelCount = 1 then
      s := '"' + ActiveList.Selected.Caption + '"'
    else
      s := '選択アイテム';
    if (MessageDlg(s + 'を削除しますか？',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;
  BeginTransaction;
  try
      with ActiveList do begin
      for i := Items.Count-1 downto 0 do begin
        itm := Items[i];
        if itm.Selected then begin
          ci := TCommonItem(itm.Data);
          ci.Delete;
          ci.Free;
          List.Delete(i);
          ActiveList.DeleteIcon(i);
        end;
      end;
      Update;
      Commit;
      ClearTags;
      MemoClipText.Clear;
    end;
  finally
  end;
end;

procedure TFormStancher.ReadINI;
  procedure SelDir(Tree: TTreeView; idx: Integer);
  begin
    if idx < 0 then begin
      Tree.Selected := nil;
      Exit;
    end;
    if ((Tree.Items.Count-1) < idx) then
      Tree.Selected := nil
    else Tree.Items[idx].Selected := True;
  end;
  function DefWidth(ACaption: string): Integer;
  begin
    if ACaption = '作成日' then Result := 120
    else if ACaption = '更新日' then Result := 120
    else if ACaption = '最終使用日' then Result := 120
    else if ACaption = '使用回数' then Result := 60
    else if ACaption = '使用頻度' then Result := 60
    else if ACaption = '親フォルダ' then Result := 80
    else if ACaption = 'コメント' then Result := 150
    else Result := 140;
  end;
  procedure ReadListColumnOrder(ListView: TListView); 
  var i: Integer;
//    Column: TListColumn;
    NumColumns: Integer;
    ColumnOrders: array of Integer;
  begin
    NumColumns := ListView.Columns.Count;
    SetLength(ColumnOrders, NumColumns);
    ListView_GetColumnOrderArray(ListView.Handle, NumColumns, Pointer(ColumnOrders));
    for i := Low(ColumnOrders) to High(ColumnOrders) do begin
      ColumnOrders[i] := IniConfig.ReadInt(ListView.Name, 'Column.Orders[' + IntToStr(i) + ']', ColumnOrders[i]);
//      Column := ListView.Columns[ColumnOrders[i]];
    end;
    ListView_SetColumnOrderArray(ListView.Handle, NumColumns, Pointer(ColumnOrders));
  end;
//var lv: TListView;
begin
  with IniConfig do begin
    //位置・サイズ
    ReadFormEx(Self.Name, Self.Name, Self);
    OldBoundsRect := BoundsRect;
    //選択タブ
    PageControlMain.ActivePageIndex := ReadInt(Self.Name, 'PageControlMain.ActivePageIndex', 1);
    PageControlMainChange(PageControlMain);
    //ツリーソート
    FPasteDirSortMode := TSortMode(ReadInt(Self.Name, 'PasteDirSortMode', 0));
    FPasteDirSortOrdAsc := ReadBool(Self.Name, 'PasteDirSortOrdAsc', True);
    SortTree(TreePaste, FPasteDirSortMode, FPasteDirSortOrdAsc);
    FLaunchDirSortMode := TSortMode(ReadInt(Self.Name, 'LaunchDirSortMode', 0));
    FLaunchDirSortOrdAsc := ReadBool(Self.Name, 'LaunchDirSortOrdAsc', True);
    SortTree(TreeLaunch, FLaunchDirSortMode, FLaunchDirSortOrdAsc);
    FBkmkDirSortMode := TSortMode(ReadInt(Self.Name, 'BkmkDirSortMode', 0));
    FBkmkDirSortOrdAsc := ReadBool(Self.Name, 'BkmkDirSortOrdAsc', True);
    SortTree(TreeBkmk, FBkmkDirSortMode, FBkmkDirSortOrdAsc);
    //リストソート
    FClipItemSortMode := TSortMode(ReadInt(Self.Name, 'ClipItemSortMode', 0));
    FClipItemSortOrdAsc := ReadBool(Self.Name, 'ClipItemSortOrdAsc', True);
    SortList(ListViewClip, FClipItemSortMode, FClipItemSortOrdAsc);
    FSearchItemSortMode := TSortMode(ReadInt(Self.Name, 'SearchItemSortMode', 1));
    FSearchItemSortOrdAsc := ReadBool(Self.Name, 'SearchItemSortOrdAsc', True);
    SortList(ListViewAllSearch, FSearchItemSortMode, FSearchItemSortOrdAsc);
    if PageControlMain.ActivePage = TabClip then begin
      FItemSortMode := FClipItemSortMode;
      FItemSortOrdAsc := FClipItemSortOrdAsc;
    end;
    if PageControlMain.ActivePage = TabAllSearch then begin
      FItemSortMode := FSearchItemSortMode;
      FItemSortOrdAsc := FSearchItemSortOrdAsc;
    end;
    //リスト表示スタイル
    ListViewClip.ViewStyle := TViewStyle(ReadInt(Self.Name, 'ListViewClip.ViewStyle', Integer(vsReport)));
    ListViewAllSearch.ViewStyle := TViewStyle(ReadInt(Self.Name, 'ListViewAllSearch.ViewStyle', Integer(vsReport)));
    if PageControlMain.ActivePage = TabClip then ViewStyle := ListViewClip.ViewStyle;
    if PageControlMain.ActivePage = TabAllSearch then ViewStyle := ListViewAllSearch.ViewStyle;
    //ツリー幅
    PanelPasteL.Width := ReadInt(Self.Name, 'PanelPasteL.Width', PanelPasteL.Width);
    PanelLaunchL.Width := ReadInt(Self.Name, 'PanelLaunchL.Width', PanelLaunchL.Width);
    PanelBkmkL.Width := ReadInt(Self.Name, 'PanelBkmkL.Width', PanelBkmkL.Width);
    PanelClipL.Width := ReadInt(Self.Name, 'PanelClipL.Width', PanelClipL.Width);
    //クリップテキスト表示領域の高さ             
    PanelPasteB.Height := ReadInt(Self.Name, 'PanelPasteB.Height', PanelPasteB.Height);
    PanelClipB.Height := ReadInt(Self.Name, 'PanelClipB.Height', PanelClipB.Height);
    //選択フォルダ
    SelDir(TreePaste, ReadInt(Self.Name, 'TreePaste.Selected.AbsoluteIndex', -1));
    SelDir(TreeLaunch, ReadInt(Self.Name, 'TreeLaunch.Selected.AbsoluteIndex', -1));
    SelDir(TreeBkmk, ReadInt(Self.Name, 'TreeBkmk.Selected.AbsoluteIndex', -1));

    //表示
    TopMostWnd := ReadBool(Self.Name, 'TopMostWnd', TopMostWnd);  
    Stealth := ReadBool(Self.Name, 'Stealth', Stealth);
    VisibleMenuToolBar   := ReadBool(Self.Name, 'VisibleMenuToolBar', VisibleMenuToolBar);
    VisibleSearchToolBar := ReadBool(Self.Name, 'VisibleSearchToolBar', VisibleSearchToolBar);
    VisibleTagToolBar    := ReadBool(Self.Name, 'VisibleTagToolBar', VisibleTagToolBar);
    VisibleStatusBar     := ReadBool(Self.Name, 'VisibleStatusBar', VisibleStatusBar);

    //日時挿入
    IsDateTimeCopy := ReadBool(Self.Name, 'IsDateTimeCopy', IsDateTimeCopy);

    StopMakeListColumns := True; //カラムの更新停止フラグ
    ColumnCrVisible      := ReadBool(Self.Name, 'ColumnCrVisible', ColumnCrVisible);
    ColumnUpVisible      := ReadBool(Self.Name, 'ColumnUpVisible', ColumnUpVisible);
    ColumnAcVisible      := ReadBool(Self.Name, 'ColumnAcVisible', ColumnAcVisible);
    ColumnUseVisible     := ReadBool(Self.Name, 'ColumnUseVisible', ColumnUseVisible);
    ColumnRepVisible     := ReadBool(Self.Name, 'ColumnRepVisible', ColumnRepVisible);
    ColumnParentVisible  := ReadBool(Self.Name, 'ColumnParentVisible', ColumnParentVisible);
    ColumnCommentVisible := ReadBool(Self.Name, 'ColumnCommentVisible', ColumnCommentVisible);

    ColumnCaptionWidth := ReadInt(Self.Name, 'ColumnCaptionWidth', ColumnCaptionWidth);
    ColumnCrWidth      := ReadInt(Self.Name, 'ColumnCrWidth', ColumnCrWidth);
    ColumnUpWidth      := ReadInt(Self.Name, 'ColumnUpWidth', ColumnUpWidth);
    ColumnAcWidth      := ReadInt(Self.Name, 'ColumnAcWidth', ColumnAcWidth);
    ColumnUseWidth     := ReadInt(Self.Name, 'ColumnUseWidth', ColumnUseWidth);
    ColumnRepWidth     := ReadInt(Self.Name, 'ColumnRepWidth', ColumnRepWidth);
    ColumnParentWidth  := ReadInt(Self.Name, 'ColumnParentWidth', ColumnParentWidth);
    ColumnCommentWidth := ReadInt(Self.Name, 'ColumnCommentWidth', ColumnCommentWidth);
    ColumnBelongWidth  := ReadInt(Self.Name, 'ColumnBelongWidth', ColumnBelongWidth);
    StopMakeListColumns := False;
    MakeListColumns; //カラムの更新

    //カラムの順番
    ReadListColumnOrder(ListViewAllSearch);
    ReadListColumnOrder(ListViewPaste);
    ReadListColumnOrder(ListViewLaunch);
    ReadListColumnOrder(ListViewBkmk);
    ReadListColumnOrder(ListViewClip);

    //タブ表示
    DispSearchTab   := ReadBool(Name, 'DispSearchTab', DispSearchTab);
    DispPasteTab    := ReadBool(Name, 'DispPasteTab', DispPasteTab);
    DispLaunchchTab := ReadBool(Name, 'DispLaunchchTab', DispLaunchchTab);
    DispBkmkTab     := ReadBool(Name, 'DispBkmkTab', DispBkmkTab);
    DispClipTab     := ReadBool(Name, 'DispClipTab', DispClipTab);

    //タブ順
    TabAllSearch.PageIndex := ReadInt(Name, TabAllSearch.Name, TabAllSearch.PageIndex);
    TabPaste.PageIndex  := ReadInt(Name, TabPaste.Name, TabPaste.PageIndex);
    TabLaunch.PageIndex := ReadInt(Name, TabLaunch.Name, TabLaunch.PageIndex);
    TabBkmk.PageIndex   := ReadInt(Name, TabBkmk.Name, TabBkmk.PageIndex);
    TabClip.PageIndex   := ReadInt(Name, TabClip.Name, TabClip.PageIndex);

    PageControlMain.ActivePageIndex := ReadInt(Name, 'ActivePageIndex', 0);
    PageControlMainChange(PageControlMain);
    
//    PageControlMain.ActivePage :=
//      TTabSheet(FindComponent(ReadStr(Name,
//        PageControlMain.ActivePage.Name,
//        PageControlMain.ActivePage.Name)));
    //タブインデックス
//    OptionTabIndex := ReadInt(Self.Name, 'OptionTabIndex', 0);

    //カラム幅
//    for i := Integer(0) to Integer(eiClip) do
//    for i := 0 to 4 do
//      lv := EditItemToList(TEditItem(i));
//      DOutI(i);
//      ReadListColumnOrder(lv);
////      for j := 0 to lv.Columns.Count-1 do begin
////        lv.Columns[j].Width := ReadInt('ListView[' + IntToStr(i) + '].Column.Width',
////          lv.Columns[j].Caption, DefWidth(lv.Columns[j].Caption));
////      end;
    end;
end;

procedure TFormStancher.WriteINI;
  function SelectedIndex(Node: TTreeNode): Integer;
  begin
    if Node = nil then Result := -1
    else Result := Node.AbsoluteIndex;
  end;
  procedure WriteListColumnOrder(ListView: TListView);
  var i: Integer;
//    Column: TListColumn;
    NumColumns: Integer;
    ColumnOrders: array of Integer;
  begin    
    NumColumns := ListView.Columns.Count;
    SetLength(ColumnOrders, NumColumns);
    ListView_GetColumnOrderArray(ListView.Handle, NumColumns, Pointer(ColumnOrders));
    for i := 0 to ListView.Columns.Count-1 do begin
//      Column := ListView.Columns[i];
      IniConfig.WriteInt(ListView.Name, 'Column.Orders[' + IntToStr(i) + ']', ColumnOrders[i]);
    end;
  end;
var i, j: Integer; lv: TListView;
begin
  with IniConfig do begin
    Hide;
    //位置・サイズ
    if Stealth then
      BoundsRect := OldBoundsRect;
    WriteForm(Self.Name, Self.Name, Self);
    WriteInt(Self.Name, 'OptionTabIndex', OptionTabIndex);
    //ツリーソート
    WriteInt(Self.Name, 'PasteDirSortMode', Integer(FPasteDirSortMode));
    WriteBool(Self.Name, 'PasteDirSortOrdAsc', FPasteDirSortOrdAsc);
    WriteInt(Self.Name, 'LaunchDirSortMode', Integer(FLaunchDirSortMode));
    WriteBool(Self.Name, 'LaunchDirSortOrdAsc', FLaunchDirSortOrdAsc);
    WriteInt(Self.Name, 'BkmkDirSortMode', Integer(FBkmkDirSortMode));
    WriteBool(Self.Name, 'BkmkDirSortOrdAsc', FBkmkDirSortOrdAsc);
    //リストソート
    WriteInt(Self.Name, 'ClipItemSortMode', Integer(FClipItemSortMode));
    WriteBool(Self.Name, 'ClipItemSortOrdAsc', FClipItemSortOrdAsc);
    WriteInt(Self.Name, 'SearchItemSortMode', Integer(FSearchItemSortMode));
    WriteBool(Self.Name, 'SearchItemSortOrdAsc', FSearchItemSortOrdAsc);
    //リスト表示スタイル
    WriteInt(Self.Name, 'ListViewClip.ViewStyle', Integer(ListViewClip.ViewStyle));
    WriteInt(Self.Name, 'ListViewAllSearch.ViewStyle', Integer(ListViewAllSearch.ViewStyle));
    //ツリー幅
    //ツリー幅
    WriteInt(Self.Name, 'PanelPasteL.Width', PanelPasteL.Width);
    WriteInt(Self.Name, 'PanelLaunchL.Width', PanelLaunchL.Width);
    WriteInt(Self.Name, 'PanelBkmkL.Width', PanelBkmkL.Width);
    WriteInt(Self.Name, 'PanelClipL.Width', PanelClipL.Width);
    //クリップテキスト表示メモの高さ
    WriteInt(Self.Name, 'PanelPasteB.Height', PanelPasteB.Height);
    WriteInt(Self.Name, 'PanelClipB.Height', PanelClipB.Height);
    //選択フォルダ
    WriteInt(Self.Name, 'TreePaste.Selected.AbsoluteIndex', SelectedIndex(TreePaste.Selected));
    WriteInt(Self.Name, 'TreeLaunch.Selected.AbsoluteIndex', SelectedIndex(TreeLaunch.Selected));
    WriteInt(Self.Name, 'TreeBkmk.Selected.AbsoluteIndex', SelectedIndex(TreeBkmk.Selected));

    //選択タブ
    WriteInt(Self.Name, 'PageControlMain.ActivePageIndex', PageControlMain.ActivePageIndex);

    //表示
    WriteBool(Self.Name, 'TopMostWnd', TopMostWnd);
    WriteBool(Self.Name, 'Stealth', Stealth);
    WriteBool(Self.Name, 'VisibleMenuToolBar', VisibleMenuToolBar);
    WriteBool(Self.Name, 'VisibleSearchToolBar', VisibleSearchToolBar);
    WriteBool(Self.Name, 'VisibleTagToolBar', VisibleTagToolBar);
    WriteBool(Self.Name, 'VisibleStatusBar', VisibleStatusBar);

    //日時挿入
    WriteBool(Self.Name, 'IsDateTimeCopy', IsDateTimeCopy);

    WriteBool(Self.Name, 'ColumnCrVisible', ColumnCrVisible);
    WriteBool(Self.Name, 'ColumnUpVisible', ColumnUpVisible);
    WriteBool(Self.Name, 'ColumnAcVisible', ColumnAcVisible);
    WriteBool(Self.Name, 'ColumnUseVisible', ColumnUseVisible);
    WriteBool(Self.Name, 'ColumnRepVisible', ColumnRepVisible);
    WriteBool(Self.Name, 'ColumnParentVisible', ColumnParentVisible);
    WriteBool(Self.Name, 'ColumnCommentVisible', ColumnCommentVisible);

    WriteInt(Self.Name, 'ColumnCaptionWidth', ColumnCaptionWidth);
    WriteInt(Self.Name, 'ColumnCrWidth', ColumnCrWidth);
    WriteInt(Self.Name, 'ColumnUpWidth', ColumnUpWidth);
    WriteInt(Self.Name, 'ColumnAcWidth', ColumnAcWidth);
    WriteInt(Self.Name, 'ColumnUseWidth', ColumnUseWidth);
    WriteInt(Self.Name, 'ColumnRepWidth', ColumnRepWidth);
    WriteInt(Self.Name, 'ColumnParentWidth', ColumnParentWidth);
    WriteInt(Self.Name, 'ColumnCommentWidth', ColumnCommentWidth); 
    WriteInt(Self.Name, 'ColumnBelongWidth', ColumnBelongWidth);

    //タブ表示
    WriteBool(Name, 'DispSearchTab', DispSearchTab);
    WriteBool(Name, 'DispPasteTab', DispPasteTab);
    WriteBool(Name, 'DispLaunchchTab', DispLaunchchTab);
    WriteBool(Name, 'DispBkmkTab', DispBkmkTab);
    WriteBool(Name, 'DispClipTab', DispClipTab);

    //タブ順
    WriteInt(Name, TabAllSearch.Name, TabAllSearch.PageIndex);
    WriteInt(Name, TabPaste.Name, TabPaste.PageIndex);
    WriteInt(Name, TabLaunch.Name, TabLaunch.PageIndex);
    WriteInt(Name, TabBkmk.Name, TabBkmk.PageIndex);
    WriteInt(Name, TabClip.Name, TabClip.PageIndex);

    WriteInt(Name, 'ActivePageIndex', PageControlMain.ActivePageIndex);

//    WriteStr(Name, PageControlMain.ActivePage.Name, PageControlMain.ActivePage.Name);

//    //カラム幅
//    for i := Integer(eiAllSearch) to Integer(eiClip) do begin
//      lv := EditItemToList(TEditItem(i));
//      WriteListColumnOrder(lv);
//      for j := 0 to lv.Columns.Count-1 do begin
//        WriteInt(lv.Name,
//          'Column.Width[' + lv.Columns[j].Caption + ']', lv.Columns[j].Width);
//      end;
//    end;

    Update;
//    lv := ListViewPaste;
//    for i := 0 to lv.Columns.Count-1 do begin
//      WriteInt('ListView.Column.Width',
//        lv.Columns[i].Caption, lv.Columns[i].Width);
//    end;
  end;
end;

procedure TFormStancher.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
  procedure SaveTreeOrder(Tree: TTreeView);
  var i: Integer; n: TTreeNode; di: TDirItem;
  begin
    BeginTransaction;
    try
      for i := 0 to Tree.Items.Count-1 do begin
        n := Tree.Items[i];
        di := TDirItem(n.Data);
        di.Order := n.AbsoluteIndex;
        di.Update;
      end;
      Commit;
    except
      Rollback;
    end;
  end;
begin
  Hide;
  IniConfig.WriteInt(Name,
                 'PageControlMain.TabPosition',
                 Integer(PageControlMain.TabPosition));
      
  SaveOnItemChange;

  SaveTreeOrder(TreePaste);
  SaveTreeOrder(TreeLaunch);
  SaveTreeOrder(TreeBkmk);

  ChangeListViewColumWidth;
  SaveClipboardList;

  Option.WriteIni;
  WriteINI;
end;

procedure TFormStancher.TreePasteDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
//  function IsParentNode(FromNode, ToNode: TTreeNode): Boolean;
//  begin
//    Result := False;
//    while ToNode <> nil do begin
//      if FromNode = ToNode then begin
//        Result := True;
//      end;
//      ToNode := ToNode.Parent;
//    end;
//  end;
var
//  nDrg, nTgt: TTreeNode;
//  rTgt, rTop, rBtm: TRect;
  Tree:  TTreeView;
  p: TPoint;
  cr: TRect;
  si: TScrollInfo;
  h: HWND;
//  rHeignt: Integer;
begin
  Tree := TTreeView(Sender);
  h := Tree.Handle;
  p := Point(X, Y);
  cr := Tree.ClientRect;
  si.cbSize := SizeOf(TScrollInfo);
  si.fMask := SIF_ALL;
//  DOut('x='+IntToStr(x)+', y='+IntToStr(y));
  if PtInRect(Rect(cr.Left, cr.Top, cr.Right, cr.Top+10), p) then begin
    GetScrollInfo(h, SB_VERT, si);
    if si.nPos = si.nMin then Exit;
    SendMessage(h, WM_VSCROLL, SB_LINEUP, 0);
  end else if PtInRect(Rect(cr.Left, cr.Bottom-10, cr.Right, cr.Bottom), p) then begin
    GetScrollInfo(h, SB_VERT, si);
//    DOut('nPos='+IntToStr(si.nPos+si.nPage)+', nMax='+IntToStr(si.nMax)+', nPage='+IntToStr(si.nPage));
    if (Int64(si.nPos)+si.nPage) > si.nMax then Exit;
    SendMessage(h, WM_VSCROLL, SB_LINEDOWN, 0);
  end else if PtInRect(Rect(cr.Left, cr.Top, cr.Left+10, cr.Bottom), p) then begin
    GetScrollInfo(h, SB_HORZ, si);
    if si.nPos = si.nMin then Exit;
    SendMessage(h, WM_HSCROLL, SB_LINELEFT, 0);
  end else if PtInRect(Rect(cr.Right-10, cr.Top, cr.Right, cr.Bottom), p) then begin
    GetScrollInfo(h, SB_HORZ, si);
    if (Int64(si.nPos)+si.nPage) > si.nMax then Exit;
    SendMessage(h, WM_HSCROLL, SB_LINERIGHT, 0);
  end else Exit;
  Tree.Invalidate;
  Sleep(100);

//  exit;
//  Tree := TTreeView(Sender);
//  nTgt := Tree.GetNodeAt(X, Y);
//  nDrg := Tree.Selected;
//  Accept := (Sender is TTreeView) and (nTgt <> nil) and (not IsParentNode(nDrg, nTgt));
//  Tree.Perform(TVM_SETINSERTMARK, 0, 0);
//  if Accept then begin
//    p.X := X;
//    p.Y := Y;
//    rTgt := nTgt.DisplayRect(False);
//    rHeignt := (rTgt.Bottom - rTgt.Top) div 4;
//    rTop := Rect(rTgt.Left, rTgt.Top, rTgt.Right, rTgt.Top + rHeignt);
//    rBtm := Rect(rTgt.Left, rTgt.Bottom - rHeignt, rTgt.Right, rTgt.Bottom);
//    if PtInRect(rTop, p) then begin
//      TreeView_SetInsertMark(Tree.Handle, Integer(nTgt.ItemId), False);
//      PostMessage(Tree.Handle, TVM_SELECTITEM, TVGN_DROPHILITE, 0);
//    end else if PtInRect(rBtm, p) then begin
//      TreeView_SetInsertMark(Tree.Handle, Integer(nTgt.ItemId), true);
//      PostMessage(Tree.Handle, TVM_SELECTITEM, TVGN_DROPHILITE, 0);
//    end else begin
//
//    end;
//  end;
end;

procedure TFormStancher.ActCopyDirExecute(Sender: TObject);
begin
  ActiveTree.CopyMode := cmCopy;
  ActiveTree.DragNode := ActiveTree.Selected;
end;

procedure TFormStancher.ActCutDirExecute(Sender: TObject);
begin
  ActiveTree.CopyMode := cmCut;
  ActiveTree.DragNode := ActiveTree.Selected;
end;

procedure TFormStancher.SetSelListItems;
var i: Integer; it: TListItem; ci: TCommonItem;
begin
  ActiveTree.ClearDragItems;
  for i := 0 to ActiveList.Items.Count-1 do begin
    it := ActiveList.Items[i];
    if ActiveTree.CopyMode = cmCopy then it.Cut := False;
    if it.Selected then begin
      if (ActiveTree.CopyMode = cmCut) and
         (ActiveTree.DropPosition <> dpData) then it.Cut := True;
      ci := CreateActiveItem(ActiveTree.Selected);
      ci.Assign(TCommonItem(it.Data));
//      p(TPasteItem(ci).Text);
      ActiveTree.DragItems.Add(ci);
    end;
  end;
  ActiveTree.DragNode := nil;
end;

procedure TFormStancher.ActCopyItemExecute(Sender: TObject);
begin
  ActiveTree.CopyMode := cmCopy;
  SetSelListItems;
end;

procedure TFormStancher.ActCutItemExecute(Sender: TObject);
begin
  ActiveTree.CopyMode := cmCut;
  SetSelListItems;
end;

procedure TFormStancher.MoveItems(lstItems: TObjectList; nTo: TTreeNode;
  IsCopy: Boolean; isClipItem: Boolean);
  procedure ChangePasteItem(ci: TCommonItem);
  begin
    ci.MyTableID := TBID_DIR_ITEMS;
    ci.IconItem.Assign(TIconItem(PasteIcons[0]));
  end;
var i: Integer; ci, nci: TCommonItem;
begin
  BeginTransaction;
  try
    for i := 0 to lstItems.Count-1 do begin
      ci := TCommonItem(lstItems[i]);
      if IsCopy then begin
        nci := CreateActiveItem(nil);
        try
          nci.Assign(ci);
          nci.ChengeParent(nTo);
          if isClipItem then ChangePasteItem(nci);
          nci.ClearAction;
          nci.Insert;
        finally
          nci.Free
        end;
      end else begin
        ci.ChengeParent(nTo);
        ci.Update;
      end;
    end;
    Commit;
    LoadItemFromDB;
    lstItems.Clear;
  except
    Rollback;
  end;
end;

procedure TFormStancher.ActPasteExecute(Sender: TObject);
begin
  if ActiveTree.EmptyDragNode then begin
    //リストビューアイテム操作
    if ActiveTree.CopyMode = cmCopy then
      MoveItems(ActiveTree.DragItems, ActiveTree.Selected, True)
    else
      MoveItems(ActiveTree.DragItems, ActiveTree.Selected, False);
  end else begin
    //ツリーノード操作
    if ActiveTree.CopyMode = cmCopy then
      CopyNode(ActiveTree.DragNode, ActiveTree.Selected)
    else
      MoveNode(ActiveTree.DragNode, ActiveTree.Selected, naAddChild);
  end;

  ActiveTree.DragNode := nil;
end;

procedure TFormStancher.CopyNode(nFrom, nTo: TTreeNode);
  procedure MakeDir(nFrom, nTo: TTreeNode);
  var diFrom, diNew: TDirItem; nNew, nChild: TTreeNode;
    tb: TSQLiteTable; sql: string; ci: TCommonItem;
  begin
    diFrom := TDirItem(nFrom.Data);
    diNew := TDirItem.Create(nil);
    diNew.Assign(diFrom);
    diNew.ChengeParent(nTo);
    diNew.ClearAction;
    diNew.Insert;
    nNew := ActiveTree.Items.AddChildObject(nTo, diNew.Name, diNew);
    diNew.Node := nNew;

    //フォルダ内アイテムの追加//////////////////////////////////////////////////////////
    sql := 'SELECT * FROM ' + ActiveTable  +
      ' WHERE ' + CN_PARENT_ID + ' = ' + IntToStr(diFrom.ID) + ';';
    tb := SQLiteDB.GetTable(sql);
    try
      with tb do begin
        MoveFirst;
        while not Eof do begin
          case EditItem of
            eiLaunch: ci := TLaunchItem.Create(nNew);
            eiBkmk:   ci := TBkmkItem.Create(nNew);
            eiClip:   ci := TClipItem.Create(nNew);
            else      ci := TPasteItem.Create(nNew);
          end;
          try
            ci.SetFields(tb);
            ci.ChengeParent(nNew);
            ci.ClearAction;
            ci.Insert;
          finally
            ci.Free;
          end;
          Next;
        end;
      end;
    finally
      tb.Free;
    end;
    //フォルダ内アイテムの追加////////////////////////////////////////////////////////////////

    nChild := nFrom.getFirstChild;
    while nChild <> nil do begin
      MakeDir(nChild, nNew);
      nChild := nChild.GetNextChild(nChild);
    end;
  end;
begin
  BeginTransaction;
  try
    MakeDir(nFrom, nTo);
    Commit;
  except
    Rollback;
  end;
end;

procedure TFormStancher.MoveNode(nFrom, nTo: TTreeNode;
  Mode: TNodeAttachMode);
var diFrom: TDirItem;
begin
  diFrom := TDirItem(nFrom.Data);
  BeginTransaction;
  try
    case Mode of
      naAddChild, naAddChildFirst:
           diFrom.ChengeParent(nTo);
      else diFrom.ChengeParent(nTo.Parent);
    end;
//    diFrom.Order := nFrom.AbsoluteIndex;
    diFrom.Update;
    nFrom.MoveTo(nTo, Mode);
    Commit;
  except
    Rollback;
  end;
end;

procedure TFormStancher.TreePasteDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  nDrg, nDrp: TTreeNode;
begin
  nDrp := ActiveTree.DropNode;
  nDrg := ActiveTree.Selected;
//    p(nDrp.Text);
  if (nDrg <> nil) then
  begin
    case ActiveTree.DropPosition of
      // [1] ターゲットの兄（上）に移動
      dpBefore: MoveNode(nDrg, nDrp, naInsert);
      // [2] ターゲットの弟（下）に移動
      dpAfter: if nDrp.getNextSibling <> nil then
          MoveNode(nDrg, nDrp.getNextSibling, naInsert)
        else
          MoveNode(nDrg, nDrp, naAdd);
      // [3] ターゲットの子に移動
      dpChild: MoveNode(nDrg, nDrp, naAddChild);
      else begin
        SetSelListItems;
        MoveItems(ActiveTree.DragItems, nDrp, False);
        ActiveTree.ClearDragItems;
//        ActiveList.EndDrag(True);
      end;
    end;
  end;
end;

procedure TFormStancher.Button1Click(Sender: TObject);
begin
ListViewClip.Update;
end;

function TFormStancher.CreateActiveItem(AParent: TTreeNode): TCommonItem;
begin
  case EditItem of
    eiLaunch: Result := TLaunchItem.Create(AParent);
    eiBkmk:   Result := TBkmkItem.Create(AParent);
    eiClip:   Result := TClipItem.Create(AParent);
    else      Result := TPasteItem.Create(AParent);
  end;
end;

procedure TFormStancher.ListViewPasteDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
//var li: TListItem;
begin
//  li := ActiveList.GetItemAt(X, Y);
  if Source is TListView then
    Accept := True
//    if li <> ActiveList.Selected then Accept := True else Accept := False
  else
    Accept := False;
end;

procedure TFormStancher.ListViewPasteDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var li, sli: TListItem; i, idx: Integer;
begin
  li := ActiveList.GetItemAt(X, Y);
  if li = nil then Exit;
  idx := li.Index;
  for i := 0 to ActiveList.Items.Count-1 do begin
    sli := ActiveList.Items[i];
    if sli.Selected then begin
      ActiveList.List.Move(sli.Index, idx);
      ActiveList.MoveIcon(sli.Index, idx);
      sli.Selected := False;
    end;                          
  end;

//  ActiveList.List.Move(ActiveList.Selected.Index, li.Index);
  ActiveList.Update;
end;

procedure TFormStancher.ActOptionExecute(Sender: TObject);
begin
//  ApplicationEvents.OnMessage := nil;
  FormOption := TFormOption.Create(Self);
  try
    Option.OptionToForm;
    Application.OnHint := FormOption.ShowHint;
    if FormOption.ShowModal = mrOk then begin
      Option.FormToOption;
      Option.WriteIni;
    end;
  finally
    FormOption.Release;
    FormOption := nil;
    Application.OnHint := ShowHint;
//    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  end;
end;

procedure TFormStancher.ClearPastModeBtn(TB: TToolBar);
var i: Integer;
begin
  for i := 0 to TB.ButtonCount-1 do
    TB.Buttons[i].Down := False;
end;

procedure TFormStancher.ListViewPasteSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var ti: TTextItem; tb: TToolBar; i: Integer;
begin
  if Sender = ListViewPaste then tb := ToolBarPaste
  else tb := ToolBarClip;

  if Selected then begin
    tb.Enabled := True;
    ti := TTextItem(Item.Data);
    for i := 0 to tb.ButtonCount-1 do tb.Buttons[i].Enabled := True;
    tb.Buttons[Integer(ti.Mode)].Down := True;
    MakeTags(ti);
    if tb = ToolBarClip then MemoClipText.Text := ti.Text;
  end else begin
    ClearPastModeBtn(tb);
    tb.Enabled := False;
    if tb = ToolBarClip then MemoClipText.Clear;
    ClearTags;
  end;
//  DOutB(tb.Enabled);
  CheckActionEnabled;
end;

procedure TFormStancher.ToolButtonPasteModeClick(Sender: TObject);
var tb: TToolButton; ti: TTextItem;
begin
  tb := TToolButton(Sender);
  if ListViewPaste.Selected = nil then
    tb.Down := False
  else begin
    ti := TTextItem(ListViewPaste.Selected.Data);
    ti.Mode := TPasteMode(tb.Index);
    ListViewPaste.ReplaceIcon(ListViewPaste.Selected.Index, ti.IconItem.Icon);
    BeginTransaction;
    try
      ti.Update;
      Commit;
    except
      Rollback;
    end;
  end;
end;

procedure TFormStancher.SaveOnItemChange;
var i, idx: Integer; ci: TCommonItem; di: TDirItem; li: TListItem; Node: TTreeNode;
begin
  if ActiveTree = nil then begin
    if FClipItemSortMode <> smUser then Exit;
    for i := 0 to ListViewClip.Items.Count-1 do begin
      ci := TCommonItem(ListViewClip.Items[i].Data);
      ci.Order := i;
    end;
    Exit;
  end;
  if EditItem = eiClip then Exit;
  Node := ActiveTree.Selected;
  if (Node = nil) or (ActiveList.Items.Count = 0) then Exit;
  di := TDirItem(Node.Data);
  BeginTransaction;
  try
    di.SortMode := ItemSortMode;
    di.SortOrdAsc := ItemSortOrdAsc;
    di.ViewStyle := ViewStyle;
    di.Update;
    if di.SortMode = smUser then begin
      for i := 0 to ActiveList.Items.Count-1 do begin
        li := ActiveList.Items[i];
        ci := TCommonItem(li.Data);
        if di.SortOrdAsc then idx := i
        else idx := ActiveList.Items.Count-1 - i;
        ci.Order := idx;
        ci.Update;
      end;
    end;
    Commit;
  except
    Rollback;
  end;
end;

procedure TFormStancher.PageControlMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  SaveOnItemChange; 

  ChangeListViewColumWidth; 
end;

procedure TFormStancher.ActSortListUserExecute(Sender: TObject);
begin
  ItemSortMode := smUser;
end;

procedure TFormStancher.ActSortListReversExecute(Sender: TObject);
begin
  ItemSortOrdAsc := not ItemSortOrdAsc;
end;

procedure TFormStancher.ActSortListNameExecute(Sender: TObject);
begin
  ItemSortMode := smName;
end;

procedure TFormStancher.ActSortListCrExecute(Sender: TObject);
begin
  ItemSortMode := smCr;
end;

procedure TFormStancher.ActSortListUpExecute(Sender: TObject);
begin
  ItemSortMode := smUp;
end;

procedure TFormStancher.ActSortListAcExecute(Sender: TObject);
begin
  ItemSortMode := smAc;
end;

procedure TFormStancher.ActSortListUseExecute(Sender: TObject);
begin
  ItemSortMode := smUse;
end;

procedure TFormStancher.ActSortListRepExecute(Sender: TObject);
begin
  ItemSortMode := smRep;
end;

procedure TFormStancher.ActSortListParentExecute(Sender: TObject);
begin
  ItemSortMode := smParent;
end;

procedure TFormStancher.ActSortListCommentExecute(Sender: TObject);
begin
  ItemSortMode := smComment;
end;

procedure TFormStancher.ActSortListValExecute(Sender: TObject);
begin
  ItemSortMode := smVal;
end;

procedure TFormStancher.SetViewStyle(const Value: TViewStyle);
//var n: TTreeNode;
begin
  FViewStyle := Value;
  ActiveList.ViewStyle := Value;
  case Value of
    vsSmallIcon: ActDispListSmallIcon.Checked := True;
    vsList: ActDispListList.Checked := True;
    vsReport: ActDispListReport.Checked := True;
    else ActDispListIcon.Checked := True;
  end;
  SaveOnItemChange;
//  if ActiveTree = nil then Exit;
//  n := ActiveTree.Selected;
//  if Assigned(n) then TDirItem(n.Data).Update;
end;

procedure TFormStancher.ActDispListIconExecute(Sender: TObject);
begin
  ViewStyle := vsIcon;
end;

procedure TFormStancher.ActDispListSmallIconExecute(Sender: TObject);
begin
  ViewStyle := vsSmallIcon;
end;

procedure TFormStancher.ActDispListListExecute(Sender: TObject);
begin
  ViewStyle := vsList;
end;

procedure TFormStancher.ActDispListReportExecute(Sender: TObject);
begin
  ViewStyle := vsReport;
end;

procedure TFormStancher.TreePasteChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  SaveItemAndTags;
  ChangeListViewColumWidth;
//  if SQLiteDB.IsTransactionOpen then Exit;
//  SaveOnItemChange;
//  ClearTags;
//  ToolBarPaste.Enabled := False;
end;

procedure TFormStancher.SaveItemAndTags;
begin
  if SQLiteDB.IsTransactionOpen then Exit;
  if FNotListSave = False then begin
    SaveOnItemChange;
  end;
  ClearTags;
  ToolBarPaste.Enabled := False;
end;

procedure TFormStancher.TreePasteChange(Sender: TObject; Node: TTreeNode);
begin             
  if SQLiteDB.IsTransactionOpen then Exit;
  if IsBooting then Exit;
  LoadItemFromDB;
//  beep;
  ToolBarPaste.Enabled := False;
end;

procedure TFormStancher.SortTree(Tree: TTreeView; SortMode: TSortMode;
  SortOrdAsc: Boolean);
begin
  FDirSortMode := SortMode;
  FDirSortOrdAsc := SortOrdAsc;
  if Tree = TreePaste then begin
    FPasteDirSortMode := SortMode;
    FPasteDirSortOrdAsc := SortOrdAsc;
  end else if Tree = TreeLaunch then begin
    FLaunchDirSortMode := SortMode;
    FLaunchDirSortOrdAsc := SortOrdAsc;
  end else begin
    FBkmkDirSortMode := SortMode;
    FBkmkDirSortOrdAsc := SortOrdAsc;
  end;
  SetTreeSortAction;
  Screen.Cursor := crHourGlass;
  try
    Tree.CustomSort(nil, 0);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormStancher.SetTreeSortAction;
var sm: TSortMode; soa: Boolean;
begin
  case EditItem of
    eiLaunch: begin
      sm := FLaunchDirSortMode;
      soa := FLaunchDirSortOrdAsc;
    end;
    eiBkmk: begin
      sm := FBkmkDirSortMode;
      soa := FBkmkDirSortOrdAsc;
    end;
    else begin
      sm := FPasteDirSortMode;
      soa := FPasteDirSortOrdAsc;
    end;
  end;
  case sm of
    smName: ActSortTreeName.Checked := True;
    smCr: ActSortTreeCr.Checked := True;
    smUp: ActSortTreeUp.Checked := True;
    smAc: ActSortTreeAc.Checked := True;
    smUse: ActSortTreeUse.Checked := True;
    smRep: ActSortTreeRep.Checked := True;
    else ActSortTreeUser.Checked := True;
  end;
  ActSortTreeRevers.Checked := not soa;
end;

procedure TFormStancher.ActSortTreeUserExecute(Sender: TObject);
begin
  DirSortMode := smUser;
end;

procedure TFormStancher.ActSortTreeNameExecute(Sender: TObject);
begin
  DirSortMode := smName;
end;

procedure TFormStancher.ActSortTreeCrExecute(Sender: TObject);
begin
  DirSortMode := smCr;
end;

procedure TFormStancher.ActSortTreeUpExecute(Sender: TObject);
begin
  DirSortMode := smUp;
end;

procedure TFormStancher.ActSortTreeAcExecute(Sender: TObject);
begin
  DirSortMode := smAc;
end;

procedure TFormStancher.ActSortTreeUseExecute(Sender: TObject);
begin
  DirSortMode := smUse;
end;

procedure TFormStancher.ActSortTreeRepExecute(Sender: TObject);
begin
  DirSortMode := smRep;
end;

procedure TFormStancher.ActSortTreeReversExecute(Sender: TObject);
begin
  DirSortOrdAsc := not DirSortOrdAsc;
end;

procedure TFormStancher.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i: Integer; lv: TListView;
begin
  for i := Integer(eiAllSearch) to Integer(eiClip) do begin
    lv := EditItemToList(TEditItem(i));
//    lv.OnChange := nil;
    lv.Clear;
  end;
end;

procedure TFormStancher.TreeView1Addition(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := Node.Index;
end;

procedure TFormStancher.ClipboardWatcherChange(Sender: TObject);
var ci: TClipItem; s: string; idx: Integer; b: Boolean;
begin         
//  if not WatchingClip then Exit;
  if ((GetTickCount - ClipFinishTime) < 200) then begin
    ClipFinishTime := GetTickCount;
    ClipboardWatcher.Enabled := False;
    Application.ProcessMessages;
    ClipboardWatcher.Enabled := True;
    Exit;
  end;
  Application.ProcessMessages;

  b := (EditQuery.Text = 'aaaaaaaaaa') or (EditQuery.Text = 'aaaaaaaaaaa');
  if EditQuery.Text = 'aaaaaaaaaa' then Option.PlaySound;
  if b then MemoClipText.Lines.Add('0');         
  Application.ProcessMessages;
  ActClipToPic.Enabled := Clipboard.HasFormat(CF_BITMAP);
  ActClipToFilePath.Enabled := Clipboard.HasFormat(CF_HDROP);
  if b then MemoClipText.Lines.Add('1');
  if Pasting then begin
    ClipFinishTime := GetTickCount;
    Exit;
  end;
  s := '';
  //beep;
  try
    s := Clipboard.AsText;
  except

  end;

  if b then MemoClipText.Lines.Add('2');
  if s = '' then Exit;
  if Clipboard.HasFormat(CF_TEXT) then begin
//    ListViewClip.SmallImages := ImageListClipS;
//    ListViewClip.LargeImages := ImageListClipL;
    idx := IndexOfClipText(s);
                    
    if b then MemoClipText.Lines.Add('3');
    if idx = 0 then Exit;
    Application.ProcessMessages;
    if idx = -1 then begin
      ci := TClipItem.Create(nil);
      ci.Name := GetAvailablenessLine(s);
      ci.Text := s;
      ci.IconItem := TIconItem(ClipIcons[0]);
      ListViewClip.List.Insert(0, ci);
      ListViewClip.InsertIcon(0,ci.IconItem.Icon);  
      ListViewClip.Update;
    end else begin
      ListViewClip.List.Move(idx, 0);
      ListViewClip.MoveIcon(idx, 0);
      ListViewClip.Update;
    end;
  end;   
  ClipFinishTime := GetTickCount;
end;

function TFormStancher.IndexOfClipText(AText: string): Integer;
var i: Integer; ci: TClipItem;
begin
  Result := -1;
  for i := 0 to ListViewClip.Items.Count-1 do begin
    ci := TClipItem(ListViewClip.Items[i].Data);
    if ci.Text = AText then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure TFormStancher.ClipToolButtonClick(Sender: TObject);
var tb: TToolButton; ti: TTextItem;
begin
  tb := TToolButton(Sender);
  if ListViewClip.Selected = nil then
    tb.Down := False
  else begin
    ti := TTextItem(ListViewClip.Selected.Data);
    ti.Mode := TPasteMode(tb.Index);
    ListViewClip.ReplaceIcon(ListViewClip.Selected.Index, ti.IconItem.Icon);
    tb.Down := True;
  end;   
end;

procedure TFormStancher.AddLaunchItem(ANode: TTreeNode; AFile: string);
var li: TLaunchItem; fn, pn, fd, cn, ext, tag: string; lfi :TLinkFileInfo;//Cls: TCommonItemClass;
  fi: TFileInfo;
begin
  fn := AFile;
  fi := TFileInfo.Create;
  fi.FileName := fn;
  if not FileExists(fn) then Exit;
  ext := LowerCase(ExtractFileExt(AFile));
//  Cls := TLaunchItem;
  li := TLaunchItem.Create(ANode);
  if ext = '.lnk' then begin
    lfi := GetInfofromLinkFile(fn);
    fn := lfi.Filename;
    li.Dir := lfi.WorkDir;
    li.Params := lfi.Arguments;
    case lfi.ShowCmd of
      SW_MINIMIZE, SW_SHOWMINIMIZED, SW_SHOWMINNOACTIVE: li.ShowCmd := scMin;
      SW_MAXIMIZE: li.ShowCmd := scMax;
      else li.ShowCmd := scShow;
    end;
  end;
  pn := fi.ProductName;
  fd := fi.FileDescription;
  cn := fi.CompanyName;
  tag := MakeLaunchTag(pn, cn);
  li.Name := ExtractFileNameOnly(fn);
  if Trim(pn) <> '' then li.Name := pn;
  if Trim(tag) <> '' then li.Tags.CommaText := tag;
  li.Comment := ExtractFileName(fn);
  if Trim(fd) <> '' then li.Comment := li.Comment + #13#10 + fd;
  li.FileName := fn;
  li.Dir := ExtractFileDir(fn);
  ExtractFileIcon(fn, li.IconItem.Icon);
//  li.IconItem.Insert;
  li.Insert;
  li.Free;
  fi.Free;
end;

procedure TFormStancher.DropFilesLaunchDrop(Sender: TObject; Files: TStrings);
var i: Integer;
begin
  if TreeLaunch.Selected = nil then begin
    MessageDlg('フォルダが選択されていません。', mtInformation, [mbOK], 0);
    Exit;
  end;
  BeginTransaction;
  for i := 0 to Files.Count-1 do
    AddLaunchItem(TreeLaunch.Selected, Files[i]);
  Commit;   
  LoadItemFromDB;
end;

procedure TFormStancher.DropTextPasteTextDrop(Text: String);
var pi: TPasteItem;
begin
  if TreePaste.Selected = nil then begin
    Msg('フォルダが選択されていません。');
    Exit;
  end;
  pi := TPasteItem.Create(TreePaste.Selected);
  pi.Name := GetAvailablenessLine(Text);
  pi.Text := Text;
  pi.IconItem := TIconItem(PasteIcons[0]);
  pi.Insert;
  pi.Free;
  LoadItemFromDB;
end;

//procedure TFormStancher.NkDropTarget2DragOver(var Res: HRESULT;
//  KeyState: TNkKeyState; pt: TPoint; var dwEffect: Integer);
//var p: TPoint;
//begin
//  p := PageControlMain.ScreenToClient(pt);
//  PageControlMain.ActivePageIndex := PageControlMain.IndexOfTabAt(p.X, p.Y);
//end;

procedure TFormStancher.DropTextBkmkTextDrop(Text: String);
  function IncludeUrl(sl: TStringList): Boolean;
  var i: Integer; s: string;
  begin
    Result := False;
    for i := 0 to sl.Count-1 do begin
      s := Trim(sl[i]);
      if IsUrl(s) then begin
        Result := True;
        Exit;
      end;
    end;
  end;
var sl: TStringList; bi: TBkmkItem; i: Integer; s: string; wsi: TWebSiteInfo;
begin       
  if TreeBkmk.Selected = nil then begin
    Msg('フォルダが選択されていません。');
    Exit;
  end;
  sl := TStringList.Create;
  Screen.Cursor := crHourGlass;
  try
    sl.Text := Text;
    if IncludeUrl(sl) then begin
      BeginTransaction;
      for i := 0 to sl.Count-1 do begin
        s := Trim(sl[i]);
        if IsUrl(s) and GetWebSiteInfo(s, wsi) then begin
          bi := TBkmkItem.Create(TreeBkmk.Selected);
          with wsi do begin
            bi.Name := Title;
            bi.Url := s;
            bi.Comment := Description;
            bi.Tags.CommaText := Keywords;
            GetWebSiteIcon(IconUrl, bi.IconItem.Icon);
            bi.Insert;
          end;
          bi.Free;
        end;
        StatusMsg('ブックマーク取り込み中、残り' + IntToStr(sl.Count  - i + 1) + '行');
      end;
      Commit;
      LoadItemFromDB;
    end;
  finally
    sl.Free;
    Screen.Cursor := crDefault;
    StatusClear;
  end;
end;

procedure TFormStancher.StatusMsg(Text: String);
begin
//  if not StatusBar.SimplePanel then StatusBar.SimplePanel := True;
  StatusBar.SimplePanel := False;
  StatusBar.Panels[0].Text := Text;
end;

procedure TFormStancher.StatusText(Index: Integer; Text: String);
begin
  if StatusBar.SimplePanel then StatusBar.SimplePanel := False;
  StatusBar.Panels[Index].Text := Text;
end;

procedure TFormStancher.StatusClear;
begin
  if StatusBar.SimplePanel then StatusBar.SimplePanel := False;
  StatusBar.SimpleText := '';
end;

procedure TFormStancher.SaveClipboardList;
var i, n: Integer; ci: TClipItem;
begin
  SQLiteDB.ExecSQL('DELETE FROM ' + TB_CLIP_ITEMS + ';');
  BeginTransaction;
  if ListViewClip.Items.Count > Option.MaxClipHistory then n := Option.MaxClipHistory
  else n := ListViewClip.Items.Count;
  for i := 0 to n -1 do begin
    ci := TClipItem(ListViewClip.Items[i].Data);
    ci.Insert;
  end;
  Commit;
end;

procedure TFormStancher.LoadClipboardList;
var tb: TSQLiteTable; ci: TClipItem;
begin
  ListViewClip.Clear;
  tb := SQLiteDB.GetTable('SELECT * FROM ' + TB_CLIP_ITEMS + ';');
  try
    with tb do begin
      MoveFirst;
      while not Eof do begin
        ci := TClipItem.Create(nil);
        ci.SetFields(tb);
        ListViewClip.List.Add(ci);
        ListViewClip.AddIcon(ci.IconItem.Icon);
        Next;
      end;
    end;
  finally
    tb.Free;
    ListViewClip.Update;
  end;
end;

procedure TFormStancher.StatusBarResize(Sender: TObject);
var i, w: Integer;
begin
  w := 0;
  for i := StatusBar.Panels.Count-1 downto 1 do begin
    w := w + StatusBar.Panels[i].Width;
  end;
  StatusBar.Panels[0].Width := StatusBar.ClientWidth - w;
end;

procedure TFormStancher.TimerGetForgroundTimer(Sender: TObject);
var h: THandle; GTI:TGUIThreadInfo; //o:TStnListView
begin                //exit;
  h := GetForegroundWindow;
  hTaskBar := FindWindow('Shell_TrayWnd', nil);//
//  hTaskBar := FindWindowEx(hTaskBar, 0, 'ReBarWindow32', nil);
//  hTaskBar := FindWindowEx(hTaskBar, 0, 'MSTaskSwWClass', nil);
//  hTaskBar := FindWindowEx(hTaskBar, 0, 'ToolbarWindow32', nil);
//  hTaskBar := FindWindow('Button', 'スタート');
//  hTaskBar := GetAncestor(hTaskBar, GA_ROOT);

  hDskTop := FindWindow('Progman', 'Program Manager');
  if (h <> Self.Handle) and (h <> hTaskBar) and (h <> hDskTop) then begin
    GTI.cbSize := sizeof(TGUIThreadInfo);
    GTI.flags := 0;
    GetGUIThreadInfo(Integer(nil), GTI);
    if (h = hForegroundWnd) and (GTI.hwndFocus = hFourcusCtrl) then Exit;
    hForegroundWnd := h;
    hFourcusCtrl := GTI.hwndFocus;
    GetWindowText(h, ForegroundWndCaption, MAX_PATH);
    StatusText(0, 'ターゲット：' + ForegroundWndCaption);
    StatusText(1, 'Wnd: ' + IntToStr(hForegroundWnd));
    StatusText(2, 'Ctrl: ' + IntToStr(hFourcusCtrl));
  end;
end;

procedure TFormStancher.ShowHint(Sender: TObject);
begin
  StatusMsg(Application.Hint);
end;

procedure TFormStancher.ListViewLaunchCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var li: TLaunchItem; r: TRect;
begin
  li := TLaunchItem(Item.Data);
  if FileExists(li.FileName) then Exit;
  r := Item.DisplayRect(drBounds);
  with ListViewLaunch.Canvas do begin
    Brush.Color := clError;
    FillRect(r);
  end;
end;

procedure TFormStancher.IncUseCount(di: TDirItem);
var n: TTreeNode; pdi: TDirItem;
begin
  di.IncUseCount;
  di.Update;
  if di.Parent = nil then Exit;
  n := di.Parent;
  while n <> nil do begin
    pdi := TDirItem(n.Data);
    pdi.IncUseCount;
    pdi.Update;
    n := n.Parent;
  end;
end;

procedure TFormStancher.ListViewPasteDblClick(Sender: TObject);
var ci: TCommonItem; p: TPoint; Item: TListItem; idx: Integer; di: TDirItem;
begin
  GetCursorPos(p);
  p := TListView(Sender).ScreenToClient(p);
  Item := TListView(Sender).GetItemAt(p.X, p.Y);
  if Item = nil then Exit;
  ci := TCommonItem(Item.Data);
  di := nil; 
  if not (ci is TClipItem) then
    di := TDirItem(ci.Parent.Data);
  if Option.OneClickExcute then MakeTags(ci);
  Option.PlaySound;
//  ClipboardWatcher.Enabled := False; 
  BeginTransaction;
  try
    if Sender = ListViewBkmk then begin
      if Option.UseBrowser then
        Open(Handle, Option.BrowserPath, TBkmkItem(ci).Url)
      else begin
//        IncUseCount(di);
//        ci.AccessDate := Now;
//        ci.Update;
        ci.Excute; 
//        ci.IncUseCount;
      end;

        di.IncUseCount;
    end else begin      
      if not (ci is TClipItem) then begin
//        IncUseCount(di);
//        ci.AccessDate := Now;
//        ci.Update;
      end;
      ci.Excute;
      di.IncUseCount;
//      ci.IncUseCount;001
    end;
    Application.ProcessMessages;
    Commit;
  except
    Rollback;
  end;     
  
//  ClipboardWatcher.Enabled := True;
  if Sender = ListViewClip then begin
    if not Option.UseClipItemToTop then Exit;
    idx := Item.Index;
    ListViewClip.List.Move(idx, 0);
    ListViewClip.MoveIcon(idx, 0);
    ListViewClip.Update;
  end;
end;

procedure TFormStancher.SetIsClipToPaste(const Value: Boolean);
begin
  FIsClipToPaste := Value;
  ActClipToPaste.Checked := Value;
  PanelClipL.Visible := Value;
  if Value then begin
    TreeClip.Items.Assign(TreePaste.Items);
    FOldClipClk := ListViewClip.OnClick;
    FOldClipDblClk := ListViewClip.OnDblClick;
    ListViewClip.OnClick := nil;
    ListViewClip.OnDblClick := nil;
  end else begin
    TreeClip.Items.Clear;
    ListViewClip.OnClick := ListViewPaste.OnClick;
    ListViewClip.OnDblClick := ListViewPaste.OnDblClick;
  end;
end;

procedure TFormStancher.ActClipToPasteExecute(Sender: TObject);
begin
  IsClipToPaste := not IsClipToPaste;
end;

procedure TFormStancher.SetTopMostWnd(const Value: Boolean);
begin
  FTopMostWnd := Value;
  yhOthers.StayOnTop(Handle, Value);
  ActTopMostWnd.Checked := Value;
end;

procedure TFormStancher.ActTopMostWndExecute(Sender: TObject);
begin
  TopMostWnd := not TopMostWnd;
end;

procedure TFormStancher.SetColumnAcVisible(const Value: Boolean);
begin
  FColumnAcVisible := Value;
  ActColumnAcVisible.Checked := Value; 
  MakeListColumns;
end;

procedure TFormStancher.SetColumnCommentVisible(const Value: Boolean);
begin
  FColumnCommentVisible := Value;
  ActColumnCommentVisible.Checked := Value; 
  MakeListColumns;
end;

procedure TFormStancher.SetColumnCrVisible(const Value: Boolean);
begin
  FColumnCrVisible := Value;
  ActColumnCrVisible.Checked := Value;
  MakeListColumns;
end;

procedure TFormStancher.SetColumnParentVisible(const Value: Boolean);
begin
  FColumnParentVisible := Value;
  ActColumnParentVisible.Checked := Value; 
  MakeListColumns;
end;

procedure TFormStancher.SetColumnRepVisible(const Value: Boolean);
begin
  FColumnRepVisible := Value;
  ActColumnRepVisible.Checked := Value;   
  MakeListColumns;
end;

procedure TFormStancher.SetColumnUpVisible(const Value: Boolean);
begin
  FColumnUpVisible := Value;
  ActColumnUpVisible.Checked := Value;  
  MakeListColumns;
end;

procedure TFormStancher.SetColumnUseVisible(const Value: Boolean);
begin
  FColumnUseVisible := Value;
  ActColumnUseVisible.Checked := Value;
  MakeListColumns;
end;

procedure TFormStancher.ActColumnCrVisibleExecute(Sender: TObject);
begin
  ColumnCrVisible := not ColumnCrVisible;
end;

procedure TFormStancher.ActColumnUpVisibleExecute(Sender: TObject);
begin
  ColumnUpVisible := not ColumnUpVisible;
end;

procedure TFormStancher.ActColumnAcVisibleExecute(Sender: TObject);
begin
  ColumnAcVisible := not ColumnAcVisible;
end;

procedure TFormStancher.ActColumnUseVisibleExecute(Sender: TObject);
begin
  ColumnUseVisible := not ColumnUseVisible;
end;

procedure TFormStancher.ActColumnRepVisibleExecute(Sender: TObject);
begin
  ColumnRepVisible := not ColumnRepVisible;
end;

procedure TFormStancher.ActColumnParentVisibleExecute(Sender: TObject);
begin
  ColumnParentVisible := not ColumnParentVisible;
end;

procedure TFormStancher.ActColumnCommentVisibleExecute(Sender: TObject);
begin
  ColumnCommentVisible := not ColumnCommentVisible;
end;

procedure TFormStancher.ListViewPasteColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if      Column.Caption = CLMC_NAME    then ActSortListName.Execute
  else if Column.Caption = CLMC_CREATE  then ActSortListCr.Execute
  else if Column.Caption = CLMC_UPDATE  then ActSortListUp.Execute
  else if Column.Caption = CLMC_ACCESS  then ActSortListAc.Execute
  else if Column.Caption = CLMC_USE     then ActSortListUse.Execute
  else if Column.Caption = CLMC_REP     then ActSortListRep.Execute
  else if Column.Caption = CLMC_PARENT  then ActSortListParent.Execute
  else if Column.Caption = CLMC_COMMENT then ActSortListComment.Execute;
//  else ActSortListUser.Execute;
end;
      
procedure TFormStancher.AppShowHintList(var HintStr: string; var CanShow: Boolean;
  var HintInfo: THintInfo);
var
//  sHint: widestring;
  ListItem: TListItem;
  ci: TCommonItem;
  p: TPoint;
  r: TRect; comment, name: string;
begin    //exit;   
  if ActiveList = nil then Exit;
	CanShow := True;
  GetCursorPos(p);
  HintInfo.HintPos := Point(p.X + 25, p.Y + 25);
  p := ActiveList.ScreenToClient(p);
	ListItem := ActiveList.GetItemAt(p.X, p.Y);
  if (ListItem = nil) then begin
    CanShow := False;
    Exit;
  end;
  ci := TCommonItem(ListItem.Data);
  r := ListItem.DisplayRect(drBounds);
  HintInfo.CursorRect := r;
  HintInfo.HideTimeout := MaxInt;
//  HintInfo.HintMaxWidth := Option.ListHintMaxWidth;
  HintInfo.HintColor := Option.HintColor;
             
//  case EditItem of
//    eiLaunch, eiBkmk: HintStr := ci.Comment;
//  else HintStr := GetFixedWordLength(TTextItem(ci).Text, 512);
//  end;
  if EditItem <> eiClip then name := ci.Name + #13#10 else name := '';
  if ci.Comment = '' then comment := ''
  else comment := ci.Comment + #13#10;
  HintStr :=
    name +
    comment +
    Format('%-14s', ['作成日:'])       + Format('%s', [DtoS(ci.CreateDate)]) + #13#10 +
    Format('%-14s', ['更新日:'])       + Format('%s', [DtoS(ci.UpdateDate)]) + #13#10 +
    Format('%-12s', ['最終使用日:'])   + Format('%s', [DtoS(ci.AccessDate)]) + #13#10 +
    Format('%-14s', ['使用回数:'])     + Format('%24d', [ci.UseCount]) + #13#10 +
    Format('%-14s', ['使用頻度:'])     + Format('%24f', [ci.Repetition])
  ;
end;

procedure TFormStancher.ListViewPasteInfoTip(Sender: TObject;
  Item: TListItem; var InfoTip: String);
begin
  if Option.ListHintVisible then Application.OnShowHint := AppShowHintList;
end;

procedure TFormStancher.SetListViewColumImage(ListView: TListView);
  function GetColumnIndex(ListView: TListView; ItemSortMode: TSortMode): Integer;
    function IndexOfColum(ListView: TListView; s: string): Integer;
    var i: Integer;
    begin
      Result := -1;
      for i := 0 to ListView.Columns.Count-1 do begin
        if ListView.Columns[i].Caption = s then begin
          Result := i;
          Exit;
        end;
      end;
    end;
  var sm: TSortMode;
  begin
    Result := -1;
    if ListView = ListViewClip then
      sm := FClipItemSortMode
    else if ListView = ListViewAllSearch then
      sm := FSearchItemSortMode
    else
      sm := ItemSortMode;

    case sm of
      smName: Result := IndexOfColum(ListView, CLMC_NAME);
      smCr:   Result := IndexOfColum(ListView, CLMC_CREATE);
      smUp:   Result := IndexOfColum(ListView, CLMC_UPDATE);
      smAc:   Result := IndexOfColum(ListView, CLMC_ACCESS);
      smUse:  Result := IndexOfColum(ListView, CLMC_USE);
      smRep:  Result := IndexOfColum(ListView, CLMC_REP);
      smParent:  Result := IndexOfColum(ListView, CLMC_PARENT);
      smComment: Result := IndexOfColum(ListView, CLMC_COMMENT);
    end;
  end;
var i, clmIdx: Integer;
//  lvc: TLVColumn;
  hColumn: THandle;
  hi: THDItem;
  soa: Boolean;
const HDF_SORTDOWN = $0200; HDF_SORTUP = $0400;
begin
  hColumn := SendMessage(ListView.Handle, LVM_GETHEADER, 0, 0);
//  SendMessage(hColumn, HDM_SETIMAGELIST, 0, ImageListListColumn.Handle);
  clmIdx := GetColumnIndex(ListView, ItemSortMode);
  for i := 0 to ListView.Columns.Count-1 do begin
    hi.Mask := HDI_FORMAT;
    SendMessage(hColumn, HDM_GETITEMA, i, LPARAM(@hi));
    hi.Mask   := HDI_FORMAT;
//    hi.fmt    := hi.fmt or HDF_IMAGE or HDF_BITMAP_ON_RIGHT;  // 取得しておいたフォーマットに HDF_IMAGE 追加
//    if i  <>  clmIdx then hi.fmt   := HDF_STRING;

    if (hi.fmt and HDF_SORTUP) > 0 then hi.fmt := hi.fmt - HDF_SORTUP;  
    if (hi.fmt and HDF_SORTDOWN) > 0 then hi.fmt := hi.fmt - HDF_SORTDOWN;
      if i = clmIdx then begin
      if ListView = ListViewClip then
        soa := FClipItemSortOrdAsc
      else if ListView = ListViewAllSearch then
        soa := FSearchItemSortOrdAsc
      else
        soa := ItemSortOrdAsc;
      if soa then hi.fmt := hi.fmt or HDF_SORTUP
      else hi.fmt := hi.fmt or HDF_SORTDOWN;
    end;
//    if ItemSortOrdAsc then imgId := 0
//    else                   imgId := 1;
//    hi.iImage := imgId; // ImageListのID
    SendMessage(hColumn, HDM_SETITEMA, i, LPARAM(@hi));
//    lvc.mask := LVCF_FMT;
//    SendMessage(ListView.Handle, LVM_GETCOLUMN, i, LPARAM(@lvc));
//    lvc.fmt := lvc.fmt or LVCFMT_BITMAP_ON_RIGHT;
//    SendMessage(ListView.Handle, LVM_SETCOLUMN, i, LPARAM(@lvc));
  end;
end;

procedure TFormStancher.ListViewPasteCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
var x, y, tw, th: Integer; s: string; lst: TListView;
begin         
  if not Option.DispItemAddInfo then Exit;
  if not (Sender is TListView) then Exit;
  if ActiveTree = nil then Exit;
  lst := TListView(Sender);
  if (ActiveTree.Selected = nil) or (lst.Items.Count <> 0) then Exit;
  s := '「右クリック→新規作成」 or ';
  if lst = ListViewLaunch then
    s := s + 'ファイルをD&Dで登録'
  else if lst = ListViewPaste then
    s := s + 'テキストをD&Dで登録'
  else if lst = ListViewBkmk then
    s := s + 'URLをD&Dで登録'
  else Exit;
  with lst.Canvas do begin
    tw := TextWidth(s);
    th := TextHeight(s);
    x := (ARect.Right - ARect.Left - tw) div 2;
    y := (ARect.Bottom - ARect.Top - th) div 2;
    Pen.Color := lst.Font.Color;
//    Brush.Style := bsSolid;
//    Rectangle(x - 3, y - 3, x + tw + 3, y + th + 3);
    Brush.Style := bsClear;
//    drawt
    TextOut(x, y, s);
  end;
end;

procedure TFormStancher.FormShow(Sender: TObject);
begin
  SetListViewColumImage(ActiveList);
end;

procedure TFormStancher.AppShowHintTree(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
var n: TTreeNode; p: TPoint; di: TDirItem; r: TRect; comment: string;
begin
  if ActiveTree = nil then Exit;
  GetCursorPos(p);
//  DOut('x='+IntToStr(p.X)+', '+'y='+IntToStr(p.Y));
  p := ActiveTree.ScreenToClient(p);

  n := ActiveTree.GetNodeAt(p.X, p.Y);
  if n = nil then Exit;
  CanShow := True;
  r := n.DisplayRect(False);
  HintInfo.CursorRect := r;
  HintInfo.HideTimeout := MaxInt;
  HintInfo.HintMaxWidth := (Screen.Width div 3) * 2;
  di := TDirItem(n.Data);
  if di.Comment = '' then comment := ''
  else comment := di.Comment + #13#10;
  HintStr := di.Name + #13#10 +
    comment +
    Format('%-14s', ['作成日:'])       + Format('%s', [DtoS(di.CreateDate)]) + #13#10 +
    Format('%-14s', ['更新日:'])       + Format('%s', [DtoS(di.UpdateDate)]) + #13#10 +
    Format('%-12s', ['最終使用日:'])   + Format('%s', [DtoS(di.AccessDate)]) + #13#10 +
    Format('%-14s', ['使用回数:'])     + Format('%24d', [di.UseCount]) + #13#10 +
    Format('%-14s', ['使用頻度:'])     + Format('%24f', [di.Repetition])
  ;
end;

procedure TFormStancher.TreePasteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Option.TreeHintVisible then
    Application.OnShowHint := AppShowHintTree;
end;

procedure TFormStancher.ActAddBookMarksExecute(Sender: TObject);
begin
  FormAddText := TFormAddText.Create(Self);
  try
    if FormAddText.ShowModal = mrOk then
      DropTextBkmkTextDrop(FormAddText.Text);
  finally
    FormAddText.Release;
  end;
end;

procedure TFormStancher.TreeClipDragDrop(Sender, Source: TObject; X,
  Y: Integer);
  procedure AddPasteItem(Node: TTreeNode; Item: TListItem);
  var ti: TTextItem; pi: TPasteItem;
  begin
    ti := TTextItem(Item.Data);
    pi := TPasteItem.Create(TreePaste.Items[Node.AbsoluteIndex]);
    pi.Assign(ti);
    pi.ChengeParent(Node);
//    pi.IconItem.ID := 0;
    pi.Insert;
    pi.Free;
  end;
var
  nDrp: TTreeNode; i: Integer; it: TListItem;
begin
  nDrp := TreeClip.GetNodeAt(X, Y);
  if (nDrp <> nil) then begin
    BeginTransaction;
    try
      try
        for i := 0 to ListViewClip.Items.Count-1 do begin
          it := ListViewClip.Items[i];
          if it.Selected then begin
            AddPasteItem(nDrp, it);
          end;
        end;
      except
        Rollback;
      end;
    finally
      Commit;
    end;
  end;
end;

procedure TFormStancher.ActSendPasteExecute(Sender: TObject);
var ti: TTextItem;
begin
  BeginTransaction;
  ti := TTextItem(ActiveList.Selected.Data);
  ti.IncUseCount;
  ti.Pasete;     
  if not (ti is TClipItem) then begin
    if Assigned(ti.Parent) then
      IncUseCount(TDirItem(ti.Parent.Data));
  end;
  Option.PlaySound;
  Commit;
end;

procedure TFormStancher.ActSendToClipExecute(Sender: TObject);
var ti: TTextItem;
begin
  ti := TTextItem(ActiveList.Selected.Data);
  ti.IncUseCount;
  ti.ToClip;    
  if not (ti is TClipItem) then begin
    if Assigned(ti.Parent) then
      IncUseCount(TDirItem(ti.Parent.Data));
  end;
  Option.PlaySound;
end;

procedure TFormStancher.ToolBarQueryResize(Sender: TObject);
begin
  ButtonQuery.Left := ToolBarQuery.ClientWidth - ButtonQuery.Width;
//  EditQuery.Left := 5;
  EditQuery.Width := ToolBarQuery.ClientWidth - ButtonQuery.Width- LabelQuery.Width;
end;

procedure TFormStancher.EditQueryKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    ActQuery.Execute;
    Key := #0;
  end;
end;

function TFormStancher.FindNode(Tree: TTreeView; ID: Int64): TTreeNode;
var i: Integer; di: TDirItem;
begin
  Result := nil;
  for i := 0 to Tree.Items.Count-1 do begin
    di := TDirItem(Tree.Items[i].Data);
    if di.ID = ID then begin
      Result := Tree.Items[i];
      Exit;
    end;
  end;
end;

function TFormStancher.FindItem(List: TListView; ID: Int64): TListItem;
var i: Integer; ci: TCommonItem;
begin
  Result := nil;
  for i := 0 to List.Items.Count-1 do begin
    ci := TCommonItem(List.Items[i].Data);
    if ci.ID = ID then begin
      Result := List.Items[i];
      Exit;
    end;
  end;
end;

procedure TFormStancher.ActQueryExecute(Sender: TObject);
  function Escape(s: string): string;
  begin
    s := StringReplace(s, '\', '\\', [rfReplaceAll]);
    s := StringReplace(s, '%', '\%', [rfReplaceAll]);
    s := StringReplace(s, '_', '\_', [rfReplaceAll]);
    Result := s;
  end;
  function GetDirQuerySQL(TableID: Integer; Keyword: string): string;
  begin
    Keyword := QuotedStr('%' + Escape(Keyword) + '%') + ' ESCAPE ''\''';
    Result := 'SELECT * FROM ' + TB_DIR_ITEMS + ' WHERE (' +
      CN_TABLE_ID + ' = ' + IntToStr(TableID) + ') AND ((' +
      CN_NAME + ' LIKE ' + Keyword + ') OR (' +
      CN_TAGS + ' LIKE ' + Keyword + ') OR (' +
      CN_COMMENT + ' LIKE ' + Keyword + '));';
//    DOut(Result);
  end;
  function GetItemQuery(TableID: Integer; Keyword: string): string;
  var TableName, ExQuery: string;
  begin
    Keyword := QuotedStr('%' + Escape(Keyword) + '%') + ' ESCAPE ''\''';
    case TableID of
      TBID_PASTE_ITEMS, TBID_CLIP_ITEMS: begin
        TableName := TB_PASTE_ITEMS;
        ExQuery := ' OR (' + CN_TEXT + ' LIKE ' + Keyword + ')';
      end;
      TBID_LAUNCH_ITEMS: begin
        TableName := TB_LAUNCH_ITEMS;
        ExQuery := ' OR (' + CN_FILE_NAME + ' LIKE ' + Keyword + ')' +
          ' OR (' + CN_PARAMS + ' LIKE ' + Keyword + ')' +
          ' OR (' + CN_DIR + ' LIKE ' + Keyword + ')';
      end;
      TBID_BKMK_ITEMS: begin
        TableName := TB_BKMK_ITEMS;
        ExQuery := ' OR (' + CN_URL + ' LIKE ' + Keyword + ')';
      end;
      else begin
        TableName := TB_DIR_ITEMS;
        ExQuery := '';
      end;
    end;
    Result := 'SELECT * FROM ' + TableName + ' WHERE (' +
      CN_NAME + ' LIKE ' + Keyword + ') OR (' +
      CN_TAGS + ' LIKE ' + Keyword + ') OR (' +
      CN_COMMENT + ' LIKE ' + Keyword + ')' + ExQuery + ';';
  end;
  procedure MakeDirItem(TableID: Integer; Keyword: string);
  var tb: TSQLiteTable; di: TDirItem;
  begin
    if not Option.SearchDispDir then Exit;
    tb := SQLiteDB.GetTable(GetDirQuerySQL(TableID, Keyword));
    try
      with tb do begin
        MoveFirst;
        while not Eof do begin
          di := TDirItem.Create(nil);
          di.SetFields(tb);
          ListViewAllSearch.List.Add(di);
          ListViewAllSearch.AddIcon(di.IconItem.Icon);
          Next;
        end;
      end;
    finally
      tb.Free;
    end;
  end;        
  procedure MakeItem(TableID: Integer; Keyword: string);
  var tb: TSQLiteTable; ci: TCommonItem; Cls: TCommonItemClass;
  begin
    tb := SQLiteDB.GetTable(GetItemQuery(TableID, Keyword));
    case TableID of
      TBID_PASTE_ITEMS: Cls := TPasteItem;
      TBID_LAUNCH_ITEMS: Cls := TLaunchItem;
      TBID_BKMK_ITEMS: Cls := TBkmkItem;
      else Cls := TClipItem;
    end;
    try
      with tb do begin
        MoveFirst;
        while not Eof do begin
          ci := Cls.Create(nil);
          ci.SetFields(tb);
          ListViewAllSearch.List.Add(ci);
          ListViewAllSearch.AddIcon(ci.IconItem.Icon);
          Next;
        end;
      end;
    finally
      tb.Free;
    end;
  end;
  procedure SearchPaste;
  begin
    MakeDirItem(TBID_PASTE_ITEMS, EditQuery.Text);
    MakeItem(TBID_PASTE_ITEMS, EditQuery.Text);
  end;
  procedure SearchLaunch;
  begin              
    MakeDirItem(TBID_LAUNCH_ITEMS, EditQuery.Text);
    MakeItem(TBID_LAUNCH_ITEMS, EditQuery.Text);
  end;
  procedure SearchBkmk;
  begin
    MakeDirItem(TBID_BKMK_ITEMS, EditQuery.Text);
    MakeItem(TBID_BKMK_ITEMS, EditQuery.Text);
  end;
  procedure SearchClip;
  var i: Integer; ci, tci: TClipItem; s: string;
  begin
    s := UpperCase(EditQuery.Text);
    for i := 0 to ListViewClip.Items.Count-1 do begin
      ci := TClipItem(ListViewClip.Items[i].Data);
      if (Pos(s, UpperCase(ci.Name)) > 0) or (Pos(s, UpperCase(ci.Tags.Text)) > 0) or
        (Pos(s, UpperCase(ci.Comment)) > 0) or (Pos(s, UpperCase(ci.Text)) > 0) then begin
        tci := TClipItem.Create(nil);
        tci.Assign(ci);
        ListViewAllSearch.List.Add(tci);
      end;
    end;
//    MakeItem(TBID_CLIP_ITEMS, EditQuery.Text);
  end;
  procedure SearchAll;
  begin
    SearchPaste;
    SearchLaunch;
    SearchBkmk;
    SearchClip;
  end;
begin
  if Trim(EditQuery.Text) = '' then begin
    Beep; Exit;
  end;
  SaveOnItemChange;
  ListViewAllSearch.Clear;
  case EditItem of
    eiPaste: SearchPaste;
    eiLaunch: SearchLaunch;
    eiBkmk: SearchBkmk;
    eiClip: SearchClip;
    else SearchAll;
  end;
//  SortList(ListViewAllSearch, FSearchItemSortMode, FSearchItemSortOrdAsc);
  ListViewAllSearch.Update;
  SetPageControlMainActivePage(TabAllSearch);
  ItemSortMode := smName;
end;

procedure TFormStancher.SendPaste(TextItem: TTextItem; PasteMode: TPasteMode; func: TStringListEditFunc);
var ci: TClipItem; sl: TStringList;
begin
  sl := TStringList.Create;        
  Pasting := True;
//  ClipboardWatcher.Enabled := False;
  try
    sl.Text := TextItem.Text;
    func(sl);
//    Clipboard.AsText := sl.Text;

    ci := TClipItem.Create(nil);
    try
      ci.Mode := PasteMode;
      ci.Text := sl.Text;
      ci.Pasete;
      Option.PlaySound;
      TextItem.IncUseCount;
      TextItem.Update;
    finally
      ci.Free;
    end;
  finally
    Pasting := False;
//    ClipboardWatcher.OnChange := nil;
//    ClipboardWatcher.Enabled := True;
//    ClipboardWatcher.OnChange := ClipboardWatcherChange;
    sl.Free;
  end;
end;

function TFormStancher.OneLineEditTrim(sl: TStringList): string;
var i: Integer;
begin
  for i := 0 to sl.Count-1 do
    sl[i] := Trim(sl[i]);
  Result := sl.Text;
end;

function TFormStancher.OneLineEditTrimLeft(sl: TStringList): string;
var i: Integer;
begin
  for i := 0 to sl.Count-1 do
    sl[i] := TrimLeft(sl[i]);
  Result := sl.Text;
end;
  
function TFormStancher.OneLineEditTrimRight(sl: TStringList): string;
var i: Integer;
begin
  for i := 0 to sl.Count-1 do
    sl[i] := TrimRight(sl[i]);
  Result := sl.Text;
end;

function TFormStancher.DeleteEmptyLine(sl: TStringList): string;
var i: Integer;
begin
  for i := sl.Count-1 downto 0 do
    if Trim(sl[i]) = '' then
      sl.Delete(i);
  Result := sl.Text;
end;

function TFormStancher.SortAsc(sl: TStringList): string;
begin
  sl.Sort;
  Result := sl.Text;
end;

function StringListSortCompare(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := -CompareStr(List[Index1], List[Index2]);
end;

function TFormStancher.SortDesc(sl: TStringList): string;
begin                         
  sl.CustomSort(StringListSortCompare);
  Result := sl.Text;
end;

function TFormStancher.UpperToLowerFunc(sl: TStringList): string;
begin                  
  sl.Text := AnsiLowerCase(sl.Text);
  Result := sl.Text;
end;

function TFormStancher.LowerToUpperFunc(sl: TStringList): string;
begin
  sl.Text := AnsiUpperCase(sl.Text);
  Result := sl.Text;
end;

function TFormStancher.HanToZenFunc(sl: TStringList): string;
begin
  sl.Text := HanToZen(sl.Text);
  Result := sl.Text;
end;

function TFormStancher.ZenToHanFunc(sl: TStringList): string;
begin
  sl.Text := ZenToHan(sl.Text);
  Result := sl.Text;
end;

function TFormStancher.HiraToKanaFunc(sl: TStringList): string;
begin
  sl.Text := HiraToKana(sl.Text);
  Result := sl.Text;
end;

function TFormStancher.KanaToHiraFunc(sl: TStringList): string;
begin
  sl.Text := KanaToHira(sl.Text);
  Result := sl.Text;
end;

function TFormStancher.TabToSpaceFunc(sl: TStringList): string;
begin
  sl.Text := StringReplace(sl.Text, #9, StringOfChar(' ', Option.TabSpaceCount), [rfReplaceAll]);
  Result := sl.Text;
end;

function TFormStancher.SpaseToTabFunc(sl: TStringList): string;
begin
  sl.Text := StringReplace(sl.Text, StringOfChar(' ', Option.TabSpaceCount), #9, [rfReplaceAll]);
  Result := sl.Text;
end;

function TFormStancher.LineTopFunc(sl: TStringList): string;
var i: Integer;
begin
  for i := 0 to sl.Count-1 do
    sl[i] := Format(LineTopStr, [i]) + sl[i];
  Result := sl.Text;
end;

function TFormStancher.LineTopBottomFunc(sl: TStringList): string;
var i: Integer; {tsl: TStringList; }ta: array[0..1] of string; cp: Integer;
begin
//  tsl := TStringList.Create;
//  tsl.CommaText := LineTopBottomStr;
  cp := Pos(',', LineTopBottomStr);
  ta[0] := Copy(LineTopBottomStr, 1, cp-1);
  ta[1] := Copy(LineTopBottomStr, cp + 1, Length(LineTopBottomStr));
  for i := 0 to sl.Count-1 do
    sl[i] := ta[0] + sl[i] + ta[1];
  Result := sl.Text;
//  abort;
//  tsl.Free;
end;

procedure TFormStancher.ActTidyTrimExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, OneLineEditTrim);
end;

procedure TFormStancher.ActTidyTrimLeftExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, OneLineEditTrimLeft);
end;

procedure TFormStancher.ActTidyTrimRightExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, OneLineEditTrimRight);
end;

procedure TFormStancher.ActTidyDeleteEmptyLineExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, DeleteEmptyLine);
end;

procedure TFormStancher.ActTidySortAscExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, SortAsc);
end;

procedure TFormStancher.ActTidySortDescExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, SortDesc);
end;

procedure TFormStancher.ActConvUpperToLowerExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, UpperToLowerFunc);
end;

procedure TFormStancher.ActConvLowerToUpperExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, LowerToUpperFunc);
end;

procedure TFormStancher.ActConvZenToHanExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, ZenToHanFunc);
end;

procedure TFormStancher.ActConvHanToZenExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, HanToZenFunc);
end;

procedure TFormStancher.ActConvKanaToHiraExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, KanaToHiraFunc);
end;

procedure TFormStancher.ActConvHiraToKanaExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, HiraToKanaFunc);
end;

procedure TFormStancher.ActConvTabToSpaceExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, TabToSpaceFunc);
end;

procedure TFormStancher.ActConvSpaceToTabExecute(Sender: TObject);
begin
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, SpaseToTabFunc);
end;

procedure TFormStancher.MenuLineTopItemClick(Sender: TObject);
begin
  if not (Sender is TMenuItem) then Exit;
  LineTopStr := StripHotkey(TMenuItem(Sender).Hint);
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, LineTopFunc);
end;

procedure TFormStancher.MenuLineTopBottomItemClick(Sender: TObject);
begin
  if not (Sender is TMenuItem) then Exit;
  LineTopBottomStr := StripHotkey(TMenuItem(Sender).Hint);
  SendPaste(TClipItem(ListViewClip.Selected.Data), pmPaste, LineTopBottomFunc);
end;

procedure TFormStancher.SetStealth(const Value: Boolean);
var ico: TIcon; s: string;
begin
  ico := TIcon.Create;
  FStealth := Value;
  Application.ShowMainForm := not Value;
  ActStealth.Checked := Value;
  if Value then HideStealth
  else if not Visible then ShowStealth;
  s := Application.Title + #13#10 +
       'Ver.' + GetFileVersion(Application.ExeName);
  if Value then begin
    ImageListTask.GetIcon(1, ico);
    TaskTrayIcon.Hint := s + #13#10 + 'ステルス中';
  end else begin
    ImageListTask.GetIcon(0, ico);
    TaskTrayIcon.Hint := s + #13#10 + '表示中';
  end;
    
  TaskTrayIcon.Icon := ico;
  if not Value then begin
    BoundsRect := OldBoundsRect;
    IsCursolOnForm := False;
  end else
    OldBoundsRect := BoundsRect;

  ico.Free;
end;

procedure TFormStancher.HideStealth;
var b: Boolean;
begin
//  if (Option.DspPos = dpNone) or (Option.DspPos = dpMouseCursol) then
//  if (not IsCursolOnForm) or (Stealth) then Exit;
//  DOutB(IsCursolOnForm);
  b := Visible;
  Hide;
  if b then begin
    SaveOnItemChange;   
  end;
  
//  BoundsRect := OldBoundsRect;
end;

procedure TFormStancher.SetShowStealthLR;
var p: TPoint; HalfWorkAreaWidth: Integer;
begin
  GetCursorPos(p);
  HalfWorkAreaWidth := Screen.WorkAreaWidth div 2;
//  if Width > HalfWorkAreaWidth then Width := HalfWorkAreaWidth;
  if p.X < HalfWorkAreaWidth then begin
    Left := 0;
  end else begin
    Left := Screen.WorkAreaWidth - Width;
  end;
  Top := Screen.WorkAreaTop;
  Height := Screen.WorkAreaHeight;
end;

procedure TFormStancher.SetShowStealthTB;
var p: TPoint; HalfWorkAreaHeight: Integer;
begin
  GetCursorPos(p);
  HalfWorkAreaHeight := Screen.WorkAreaHeight div 2;
//  if Height > HalfWorkAreaHeight then Height := HalfWorkAreaHeight;
  if p.Y < HalfWorkAreaHeight then begin
    Top := 0;
  end else begin
    Top := Screen.WorkAreaHeight - Height;
  end;
  Left := Screen.WorkAreaLeft;
  Width := Screen.WorkAreaWidth;
end;

procedure TFormStancher.SetShowStealthMouseCursor;
var p: TPoint;
begin
  if IsBooting then Exit;
  GetCursorPos(p);
  Left := p.X - 100;
  Top := p.Y - 100;
  OnWorkArea(Self);
end;

procedure TFormStancher.ShowStealth;
begin
//  Sleep(100);
//  OldBoundsRect := BoundsRect;
  //dpLR, dpTBの場合
  case Option.DspPos of
    dpMouseCursol: SetShowStealthMouseCursor;
    dpLR:          SetShowStealthLR;
    dpTB:          SetShowStealthTB;
  end;
  Show;
//  ActDisplay.Execute;
//  SetMouseCursor(Self);
  IsCursolOnForm := False;
//  SetForegroundWindow(Handle);

  yhOthers.StayOnTop(Handle, True);
  yhOthers.StayOnTop(Handle, TopMostWnd);
end;

procedure TFormStancher.SetOldBoundsRect(const Value: TRect);
begin
  FOldBoundsRect := Value;
end;

function EnumWindowsProc(h: HWND; Param: LPARAM): Bool; stdcall;
var ClassName: array[0..255] of Char;
begin
  GetWindowText(h, ClassName, 256);
  if ClassName = 'WorkerW' then begin
    HDefView := FindWindowEx(h,0,PChar('SHELLDLL_DefView'),nil);
    if HDefView = 0 then
      Result := True
    else
      Result := False;
  end else
    Result := True;
end;

procedure TFormStancher.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);          
  function IncludeMouse(ma: TMouseAction; KeyFlags: Integer; mrp: TMouseRtnPoses): Int64;
  var tb: TSQLiteTable; sql: string; //i: Integer;
  begin
    Result := 0;
    sql := 'SELECT * FROM ' + TB_MOUSE_ITEMS +
      ' WHERE ' + GetMouseItemExistSqlAfterWhere(0, True, ma, KeyFlags, mrp);
//    sql := 'SELECT * FROM ' + TB_MOUSE_ITEMS +
//      ' WHERE (' + CN_ENABLED + ' = ' + IntToStr(1) + ') AND' +
//      '       (' + CN_ACTION  + ' = ' + IntToStr(Integer(ma)) + ') AND' +
//      '       (' + CN_KEY_FLAGS  + ' = ' + IntToStr(KeyFlags) + ') AND' +
//      '       ((' + CN_RTN_POSES  + ' & ' + IntToStr(Word(mrp)) + ') <> 0);';
    tb := SQLiteDB.GetTable(sql);
//    DOut(sql);
    try
      with tb do begin
        MoveFirst;
        if not Eof then begin
          Result := FieldAsInteger(FieldIndex[CN_ID]);
//          i := FieldAsInteger(FieldIndex[CN_RTN_POSES]);
        end;
//        DOutI(Result);
//        DOutI(i);
//        DOutI(i and Word(mrp));
      end;
    finally
      tb.Free;
    end;
  end;
  function IncludeKey(TableName: string; Key: Integer): Int64;
  var tb: TSQLiteTable;
  begin
    Result := 0;
    tb := SQLiteDB.GetTable('SELECT * FROM ' + TableName +
      ' WHERE ' + CN_KEY + ' = ' + IntToStr(Key) + ';');
    try
      with tb do begin
        if not MoveFirst then Exit;
        Result := FieldAsInteger(FieldIndex[CN_ID]);
      end;
    finally
      tb.Free;
    end;
  end;                   
  procedure ExcuteTab(id: Int64);
  begin
    if not Visible then ShowStealth;
    if not Stealth then ActDisplay.Execute;
    case id of
      CI_ALLSEARCH_ID: SetPageControlMainActivePage(TabAllSearch);   
      CI_PASTE_ID:     SetPageControlMainActivePage(TabPaste);
      CI_LAUNCH_ID:    SetPageControlMainActivePage(TabLaunch);
      CI_BKMK_ID:      SetPageControlMainActivePage(TabBkmk);
      CI_CLIP_ID:      SetPageControlMainActivePage(TabClip);
      else ;
    end;
  end;
  procedure ExcuteAction(tpi: TTableParentItem);
    procedure ItemExcute(Cls: TCommonItemClass; tpi: TTableParentItem);
    var ci: TCommonItem;
    begin
      ci := Cls.Create(nil);
      try
        ci.Locate(tpi.ParentID);
        ci.Excute;
      finally
        ci.Free;
      end;
    end;
  var  di: TDirItem; //ci: TCommonItem; i: Integer;
  begin;
    case tpi.TableID of
      TBID_DIR_ITEMS: begin
        di := TDirItem.Create(nil);
        try
          di.Locate(tpi.ParentID);
          case di.TableID of
            TBID_PASTE_ITEMS: begin
              SetPageControlMainActivePage(TabPaste);
              TreePaste.Selected := FindNode(TreePaste, di.ID);
            end;
            TBID_LAUNCH_ITEMS: begin
              SetPageControlMainActivePage(TabLaunch);
              TreeLaunch.Selected := FindNode(TreeLaunch, di.ID);
            end;
            TBID_BKMK_ITEMS: begin
               SetPageControlMainActivePage(TabBkmk);
              TreeBkmk.Selected := FindNode(TreeBkmk, di.ID);
            end;
          end;
          if Stealth then
            ShowStealth
          else
            ActDisplay.Execute;
        finally
          di.Free;
        end;
      end;
      TBID_PASTE_ITEMS: ItemExcute(TPasteItem, tpi);
      TBID_LAUNCH_ITEMS: ItemExcute(TLaunchItem, tpi);
      TBID_BKMK_ITEMS: ItemExcute(TBkmkItem, tpi);
      else begin
        case tpi.ID of
          CI_ALLSEARCH_ID: SetPageControlMainActivePage(TabAllSearch);
          CI_PASTE_ID:     SetPageControlMainActivePage(TabPaste);
          CI_LAUNCH_ID:    SetPageControlMainActivePage(TabLaunch);
          CI_BKMK_ID:      SetPageControlMainActivePage(TabBkmk);
          CI_CLIP_ID:      SetPageControlMainActivePage(TabClip);
        end;
        if Stealth then
          ShowStealth
        else
          ActDisplay.Execute;
      end;
    end;
  end;
var PushedKey: TShortCut; IsDown, IsCtrl, IsAlt, IsShift, IsLBtn, IsRBtn, IsMBtn: Boolean;
  res: Int64; ki: TKeyItem; mi: TMouseItem;
  ma: TMouseAction; KeyFlags: Integer; h: HWND; mrp: TMouseRtnPoses; wr: TRect; w: Integer;
  ClassName: array[0..MAX_PATH-1] of Char;
  r: TRect; p: TPoint; HProgman,{HDefView,}HSysListView,map: HWND; PInfo: ^TLVHitTestInfo;
  info :TLVHitTestInfo;
begin
//  if not Stealth then Exit;
  //マウスフック
  if (Msg.message = GetMouseUniqueMessage) then begin
//    if Msg.wParam = WM_LBUTTONDBLCLK then DOutI(0);
      if IsCursolOnForm and ((Msg.pt.X < BoundsRect.Left   - Option.CallBackMargin)
                        or (Msg.pt.Y < BoundsRect.Top    - Option.CallBackMargin)
                        or (Msg.pt.X > BoundsRect.Right  + Option.CallBackMargin)
                        or (Msg.pt.Y > BoundsRect.Bottom + Option.CallBackMargin)) then begin
        IsCursolOnForm := False;
        HideStealth;
        Sleep(10);
//        beep
      end;
          
    if msg.wParam = WM_MOUSEMOVE then begin
      if PtInRect(BoundsRect, Msg.pt) then begin
//        if not IsCursolOnForm then beep;
        if Stealth then IsCursolOnForm := True;
      end;

    end;

    if Option.CallMethod = cmMouseCsrPos then begin
      TimerShowMouseCslRtn.Enabled := IsMouseCslRtnPos;
      Exit;
    end;

//    if Msg.wParam = WM_MOUSEWHEEL then Beep;
//    DOutI(msg.wParam);
//    if (msg.wParam <> WM_MOUSEMOVE) and (msg.wParam <> WM_NCMOUSEMOVE) then begin
//      beep;
//    end;
//    if Msg.wParam = WM_LBUTTONUP then begin
//      DOutI(GetDoubleClickWidth);
//      DOutI(GetDoubleClickHeight);
//    end;
    case Msg.wParam of
      WM_LBUTTONUP:     ma := maLClk;
      WM_LBUTTONDBLCLK: ma := maLDblClk;
      WM_RBUTTONUP:     ma := maRClk;
      WM_RBUTTONDBLCLK: ma := maRDblClk;
      WM_MBUTTONUP:     ma := maMClk;
      WM_MBUTTONDBLCLK: ma := maMDblClk;
      WM_MOUSEWHEEL:    ma := maWheel;
//      WM_MOUSEMOVE:     ma := maMove;
      else begin
        Exit;
      end;
    end;                    
    //フォーカスウィンドウ移動時のダブルクリック処理
    if GetForegroundWindow <> hOldWid then begin
      hOldWid := GetForegroundWindow;
      IsAlreadyClk := True;
      ClkStart := GetTickCount;
      OldClkPos := Msg.pt;
    end else begin
      if IsAlreadyClk and ((GetTickCount-ClkStart) < GetDoubleClickTime) and
            (Abs(OldClkPos.X-Msg.pt.X) < GetDoubleClickWidth) and
            (Abs(OldClkPos.Y-Msg.pt.Y) < GetDoubleClickHeight) then begin
        case ma of
          maLClk: ma := maLDblClk;
          maRClk: ma := maRDblClk;
          maMClk: ma := maMDblClk;
        end;
      end;
      hOldWid := GetForegroundWindow;
      IsAlreadyClk := False;
      OldClkPos := Msg.pt;
    end;
    
//    if ma = maLClk then beep;

//    if Msg.wParam = WM_LBUTTONDBLCLK then DOutI(2);
//      beep;
    IsLBtn := False; IsRBtn := False; IsMBtn := False;
    //キー状態
    IsCtrl :=(GetKeyState(VK_CONTROL) and (1 shl 15))<>0;
    IsAlt  :=(GetKeyState(VK_MENU)    and (1 shl 15))<>0;
    IsShift:=(GetKeyState(VK_SHIFT)   and (1 shl 15))<>0;
    //マウス状態
    if (Msg.wParam <> WM_LBUTTONUP) and (Msg.wParam <> WM_LBUTTONDBLCLK) then
      IsLBtn :=(GetAsyncKeyState(VK_LBUTTON) and (1 shl 15))<>0;
    if (Msg.wParam <> WM_RBUTTONUP) and (Msg.wParam <> WM_RBUTTONDBLCLK) then
      IsRBtn :=(GetAsyncKeyState(VK_RBUTTON) and (1 shl 15))<>0;
    if (Msg.wParam <> WM_MBUTTONUP) and (Msg.wParam <> WM_MBUTTONDBLCLK) then
      IsMBtn :=(GetAsyncKeyState(VK_MBUTTON) and (1 shl 15))<>0;
    KeyFlags := 0;
    if IsLBtn then KeyFlags := KeyFlags or MK_LBUTTON;
    if IsRBtn then KeyFlags := KeyFlags or MK_RBUTTON;
    if IsMBtn then KeyFlags := KeyFlags or MK_MBUTTON;
    if IsCtrl then KeyFlags := KeyFlags or MK_CONTROL;
    if IsShift then KeyFlags := KeyFlags or MK_SHIFT;   
    if IsAlt  then KeyFlags := KeyFlags or MK_ALT;

    //マウス位置
    mrp := [];
    h := GetAncestor(WindowFromPoint(Msg.pt), GA_ROOT);
    GetClassName(h, ClassName, MAX_PATH);
    if h = hTaskBar then begin
      mrp := [mrpTaskBar];
    end else if ((h = hDskTop) or (ClassName = 'WorkerW')) then begin
      w := 10;
      wr := Screen.WorkAreaRect;
      if (ClassName = 'WorkerW') then begin
        EnumWindows(@EnumWindowsProc, 0);
//        HProgman := FindWindow(PChar('WorkerW'),nil);
      end else begin
        HProgman := FindWindow(PChar('Progman'),PChar('Program Manager'));   
        HDefView := FindWindowEx(HProgman,0,PChar('SHELLDLL_DefView'),nil);
      end;
//      HDefView := FindWindowEx(HProgman,0,nil,nil);
      HSysListView := FindWindowEx(HDefView,0,PChar('SysListView32'),nil);

//      DOutI(HProgman);
//      DOutI(HDefView);
//      DOutI(HSysListView);

//      p.X := Msg.pt.X - wr.Left;
//      p.Y := Msg.pt.Y - wr.Top;
//      map := CreateFileMapping($FFFFFFFF,nil,PAGE_READWRITE, 0, SizeOf(TLVHitTestInfo), nil);
//      PInfo := MapViewOfFile(map, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TLVHitTestInfo));
//      PInfo^.pt := p;
//      DOutP(p);
//      PInfo^.flags := LVHT_ONITEM;
//      douti(ListView_GetItemCount(HSysListView));
//      GetWindowText(HProgman, ClassName, 256);
//      DOut(ClassName);
//      DOutI(ListView_GetHotItem(HSysListView));
      if ListView_GetHotItem(HSysListView) <> -1 then Exit;
//      DOutI(ListView_HitTest(HSysListView, PInfo^));
//      DOutB((PInfo^.flags and LVHT_ONITEM) <> 0);
//      UnmapViewOfFile(PInfo);
//      CloseHandle(map);
//      if ListView_HitTest(h, Info) = -1 then Beep;
      if PtInRect(Rect(wr.Left, wr.Top, wr.Left + w, wr.Top + w), Msg.pt) then
        mrp := [mrpLT]
      else if PtInRect(Rect(wr.Left + w, wr.Top, wr.Right - w, wr.Top + w), Msg.pt) then
        mrp := [mrpMT]
      else if PtInRect(Rect(wr.Right - w, wr.Top, wr.Right, wr.Top + w), Msg.pt) then
        mrp := [mrpRT]
      else if PtInRect(Rect(wr.Right - w, wr.Top + w, wr.Right, wr.Bottom - w), Msg.pt) then
        mrp := [mrpRM]
      else if PtInRect(Rect(wr.Right - w, wr.Bottom - w, wr.Right, wr.Bottom), Msg.pt) then
        mrp := [mrpRB]
      else if PtInRect(Rect(wr.Left + w, wr.Bottom - w, wr.Right - w, wr.Bottom), Msg.pt) then
        mrp := [mrpMB]
      else if PtInRect(Rect(wr.Left, wr.Bottom - w, wr.Left + w, wr.Bottom), Msg.pt) then
        mrp := [mrpLB]
      else if PtInRect(Rect(wr.Left, wr.Top + w, wr.Left + w, wr.Bottom - w), Msg.pt) then
        mrp := [mrpLM]
      else
        mrp := [mrpDeskTop];
    end;                         

    if mrp = [] then Exit;
//    if Msg.wParam = WM_LBUTTONDBLCLK then DOutI(3);
    res := IncludeMouse(ma, KeyFlags, mrp);
    mi := TMouseItem.Create;
    try
      if res = 0 then Exit;
      mi.Locate(res);
      ExcuteAction(mi);
//      beep;
      Exit;
    finally
      mi.Free; 
    end;

//    fwKeys := fwKeys or
    if (msg.wParam <> WM_MOUSEMOVE) and (msg.wParam <> WM_NCMOUSEMOVE) then begin
//      beep;
//      DOut('$' + IntToHex(KeyFlags, 8));
//      DOut('$' + IntToHex(Word(ma), 4));
//      DOutI(res);
//      DOutB(IsLBtn);
//      DOutB(IsRBtn);
//      DOutB(IsMBtn);
//      DOutB(IsCtrl);
//      DOutB(IsAlt);
//      DOutB(IsShift);
//      DOutI(h);
//      DOutI(hDskTop);
//      DOutI(hTaskBar);
//      DOutB(h = hDskTop);
//      DOutB(h = hTaskBar);
//      beep;
//      DOut('------------');
    end;
  end;

  //キーフック
  if (Msg.message = GetKeyUniqueMessage) then begin
    IsDown :=(msg.LParam and (1 shl 31))=0;
    if IsDown then begin            
      IsCtrl :=(GetKeyState(VK_CONTROL) and (1 shl 15))<>0;
      IsAlt  :=(GetKeyState(VK_MENU)    and (1 shl 15))<>0;
      IsShift:=(GetKeyState(VK_SHIFT)   and (1 shl 15))<>0;
//      IsCtrl :=(GetKeyState(VK_CONTROL) and (1 shl 15))<>0;
//      IsAlt  :=(msg.LParam              and (1 shl 29))<>0;
//      IsShift:=(GetKeyState(VK_SHIFT)   and (1 shl 15))<>0;
      PushedKey := Msg.wParam;

//      DOutI(Integer(PushedKey));
      if PushedKey = VK_ESCAPE then begin  
        if not Stealth then Exit;
        if not Visible then Exit;
        if GetForegroundWindow <> Self.Handle then Exit;
        HideStealth;
        Exit;
      end;
      if PushedKey = VK_SHIFT then Exit; //Msg.wParamがShiftのとき
      if PushedKey = VK_MENU then Exit;  //Msg.wParamがAltのとき
      if PushedKey = VK_CONTROL then Exit;  //Msg.wParamがCtrlのとき
      if IsCtrl  then PushedKey := PushedKey or scCtrl;
      if IsAlt   then PushedKey := PushedKey or scAlt;
      if IsShift then PushedKey := PushedKey or scShift;

//      DOutI(Integer(PushedKey));
//      DOutI(Integer(Msg.lParam));

//  DOutClear;        
//  DOuti(GetForegroundWindow);
//  DOutI(GetAncestor(GetForegroundWindow, GA_ROOT));
//  DOutI(Application.Handle);
//  DOuti(Handle);

//      if GetAncestor(GetForegroundWindow, GA_ROOT) = Application.Handle then begin
      if GetForegroundWindow = Handle then begin
        res := IncludeKey(TB_SHORTCUT_KEYS, PushedKey);
        if res > 0 then begin
//          DOutI(Integer(res));
          ki := TShortcutKeyItem.Create;
          ki.Locate(res);
          ExcuteAction(ki);
          ki.Free;
        end else if res < 0 then
          ExcuteTab(res);
      end else begin
//        if GetAncestor(GetForegroundWindow, GA_ROOT) = Handle then Exit;
        res := IncludeKey(TB_HOT_KEYS, PushedKey);
        
        if res > 0 then begin
          ki := THotKeyItem.Create;
          ki.Locate(res);
          ExcuteAction(ki);
          ki.Free;
        end else if res < 0 then
          ExcuteTab(res);
      end;
//      DOutClear;
//      DOutH(PushedKey);
//      DOutI(res);
    end;
  end;
end;

procedure TFormStancher.ActStealthExecute(Sender: TObject);
begin
  Stealth := not Stealth;
end;

procedure TFormStancher.MenuAdvancedDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
begin
  with ACanvas do begin
    //通常の描画
    if (odSelected in State) or (odHotLight	in State) then begin
      Brush.Color := clMenuHighlight;
      Font.Color := clWindow;
    end else
      Brush.Color := Option.FormColor;

    FillRect(ARect) ;
    TextRect(ARect,2 + ARect.Left,2+ ARect.Top,
            TMenuItem(Sender).Caption) ;
    //右部分の描画
    if Sender = mnuHelp then begin
      Brush.Color := Option.FormColor;
      ARect.Left:=ARect.Right;
      ARect.Right:=ClientRect.Right;
      FillRect(ARect) ;
    end;
  end;
end;

procedure TFormStancher.ToolBarPasteCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    Brush.Color := Option.FormColor;
    FillRect(ARect);
  end;
end;

//長すぎる ListView アイテムを補完するチップヘルプを出さなくする
procedure TFormStancher.HideListViewTooiTip(ListView: TListView);
begin
  //usesにCommCtrlを加えて
  SendMessage(ListView.Handle, LVM_SETTOOLTIPS, 0, 0);
//  ListView_SetToolTips(ListView.Handle, 0);
end;
//長すぎる TreeView アイテムを補完するチップヘルプを出さなくする
procedure TFormStancher.HideTreeViewTooiTip(TreeView: TTreeView);
begin                       
  //usesにCommCtrlを加えて
  SendMessage(TreeView.Handle, TVM_SETTOOLTIPS, 0, 0);
//  TreeView_SetToolTips(TreeView.Handle, 0);
end;

procedure TFormStancher.ListViewAllSearchDblClick(Sender: TObject);
  procedure SelectNode(Tree: TTreeView; ID: Int64);
  var n: TTreeNode;
  begin
    n := FindNode(Tree, ID);
    if n = nil then Abort;
//    TreePasteChange(Tree, n);
//    Sleep(1000);
//    SaveOnItemChange;
//    Sleep(1000);
    FNotListSave := True;
    Tree.Selected := n;
    FNotListSave := False;
//    LoadItemFromDB;
//    n.Selected := True;
//    n.MakeVisible;
  end;
  procedure SelectItem(List: TListView; ID: Int64);
  var it: TListItem;
  begin
    List.ClearSelection;
    it := FindItem(List, ID);
    if it = nil then Exit;
    it.Selected := True;
    it.MakeVisible(True);
  end;
var it: TListItem; di: TDirItem; ci: TCommonItem; 
begin
  it := ListViewAllSearch.Selected;
  if it = nil then Exit;
  if TObject(it.Data) is TDirItem then begin
    di := TDirItem(it.Data);
    case di.TableID of
      TBID_LAUNCH_ITEMS: begin
        SetPageControlMainActivePage(TabLaunch);
        SelectNode(TreeLaunch, di.ID);
      end;
      TBID_BKMK_ITEMS: begin
        SetPageControlMainActivePage(TabBkmk);
        SelectNode(TreeBkmk, di.ID);
      end;
      else begin
        SetPageControlMainActivePage(TabPaste);
        SelectNode(TreePaste, di.ID);
      end;
    end;
  end else begin
    di := nil;
    NotReadDir := True;
    ci := TCommonItem(it.Data);
    if ci is TLaunchItem then begin       
      SetPageControlMainActivePage(TabLaunch);
      SelectNode(TreeLaunch, ci.ParentID);
      di := TDirItem(TreeLaunch.Selected.Data);
      SelectItem(ListViewLaunch, ci.ID);    
    end else if ci is TBkmkItem then begin
      SetPageControlMainActivePage(TabBkmk);
      SelectNode(TreeBkmk, ci.ParentID);
      di := TDirItem(TreeBkmk.Selected.Data);
      SelectItem(ListViewBkmk, ci.ID);
    end else if ci is TClipItem then begin
      SetPageControlMainActivePage(TabClip);
      SelectItem(ListViewClip, ci.ID);
    end else begin
      SetPageControlMainActivePage(TabPaste);
      SelectNode(TreePaste, ci.ParentID);
      di := TDirItem(TreePaste.Selected.Data);
      SelectItem(ListViewPaste, ci.ID);
    end;
    SortList(ActiveList, di.SortMode, di.SortOrdAsc);
  end;
  
end;

procedure TFormStancher.SetPageControlMainActivePage(Tab: TTabSheet);
begin
  PageControlMain.ActivePage := Tab;
  PageControlMainChange(PageControlMain);
end;
procedure TFormStancher.ActDisplayExecute(Sender: TObject);
var
  h: HWND;
  ThreadID1, ThreadID2 : Cardinal;
  Buf: ^DWORD;
begin
  Buf := GetMemory(SizeOf(DWORD));
  //現在ユーザーが作業しているウィンドウを取得
  h := GetForegroundWindow;
  //フォアグラウンドウィンドウを作成したスレッドのIDを取得
  ThreadID1 := GetWindowThreadProcessId(h);
  //目的のウィンドウを作成したスレッドのIDを取得
  ThreadID2 := GetCurrentThreadId;
  //現在の入力状態を目的のスレッドにアタッチ
  AttachThreadInput(ThreadID1, ThreadID2, True);
  //現在の[フォアグラウンド ロック タイムアウト]の設定を取得
  SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, Buf, 0);
  //設定を 0ms に変更
  SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, nil, 0);

  //本命の処理
  if IsIconic(Application.Handle) then
    Application.Restore;  //最小化されているときは元に戻す
//  if Stealth then Stealth := False;
  SetForegroundWindow(Handle);
  //設定を元に戻して…
  SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, Buf, 0);
  //デタッチしておしまい
  AttachThreadInput(ThreadID2, ThreadID1, False);
  FreeMemory(Buf);
end;

procedure TFormStancher.FormPaint(Sender: TObject);
begin                        
  ShowWindow(Application.Handle,SW_HIDE); {タスクバー非表示}
  if PageControlMain.ActivePage = TabClip then
    SetListViewColumImage(ListViewClip);
end;

procedure TFormStancher.TaskTrayIconClick(Sender: TObject);
begin
  if FormProperty <> nil then Exit;
  if FormOption <> nil then Exit;
  if FormAbout <> nil then Exit;   
  if FormBugReport <> nil then Exit;
  ActDisplay.Execute;
  if Stealth then Stealth := False;
end;

procedure TFormStancher.ActCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormStancher.TagButtonClick(Sender: TObject);
begin
  if Sender = nil then Exit;
//  ApplicationEvents.OnMessage := nil;      
  EditQuery.Text := TSpeedButton(Sender).Caption;
//  PageControlMain.ActivePage := TabAllSearch;
//  PageControlMainChange(PageControlMain);
  PostMessage(Handle, WM_QUERY_EXCUTE, 0, 0);
//  Application.ProcessMessages;
//  ActQuery.Execute;
end;

procedure TFormStancher.ListViewLaunchSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var ci: TCommonItem;
begin
  if Selected then begin
    ci := TCommonItem(Item.Data);
    MakeTags(ci);
  end else begin
    ClearTags;
  end;
end;

procedure TFormStancher.TreePasteExit(Sender: TObject);
begin
  ClearTags;
end;

procedure TFormStancher.TreePasteEnter(Sender: TObject);
begin
  if Sender is TTreeView then Exit;
  MakeTags(TCommonItem(TTreeView(Sender).Selected.Data));
end;

procedure TFormStancher.WMQueryExcute(var Message: TMessage);
begin
  ActQuery.Execute;
end;

procedure TFormStancher.SetVisibleMenuToolBar(const Value: Boolean);
begin
  FVisibleMenuToolBar := Value;
  ActVisibleMenuToolBar.Checked := Value;
  ToolBarMenu.Visible := Value;
end;

procedure TFormStancher.SetVisibleStatusBar(const Value: Boolean);
begin
  FVisibleStatusBar := Value; 
  ActVisibleStatusBar.Checked := Value;  
  StatusBar.Visible := Value;
end;

procedure TFormStancher.SetVisibleTagToolBar(const Value: Boolean);
begin
  FVisibleTagToolBar := Value;  
  ActVisibleTagToolBar.Checked := Value; 
  ToolBarTag.Visible := Value;
end;

procedure TFormStancher.SetVisibleSearchToolBar(const Value: Boolean);
begin
  FVisibleSearchToolBar := Value;
  ActVisibleSearchToolBar.Checked := Value;
  ToolBarQuery.Visible := Value;
end;

procedure TFormStancher.ActVisibleSearchToolBarExecute(Sender: TObject);
begin
  VisibleSearchToolBar := not VisibleSearchToolBar;
end;

procedure TFormStancher.ActVisibleStatusBarExecute(Sender: TObject);
begin
  VisibleStatusBar := not VisibleStatusBar;
end;

procedure TFormStancher.ActVisibleTagToolBarExecute(Sender: TObject);
begin
  VisibleTagToolBar := not VisibleTagToolBar;
end;

procedure TFormStancher.ActVisibleMenuToolBarExecute(Sender: TObject);
begin
  VisibleMenuToolBar := not VisibleMenuToolBar;
end;

procedure TFormStancher.Button3Click(Sender: TObject);
begin
  SetListViewColumImage(ListViewClip);
end;

procedure TFormStancher.ExportXml(Nodes: TNodesArray; IsSubDir: Boolean);
  procedure SetBaseAttr(iNode: IXMLNode; Item: TCommonItem);
  begin
    iNode.Attributes['Name'] := Item.Name;
    iNode.Attributes['CreateDate'] := Item.CreateDate;
    iNode.Attributes['UpdateDate'] := Item.UpdateDate;  
    iNode.Attributes['AccessDate'] := Item.AccessDate;
//    iNode.Attributes['Comment'] := Item.Comment;
    iNode.Attributes['Comment'] := StringReplace(Item.Comment, #13#10, '&rtn;', [rfReplaceAll]);
    iNode.Attributes['Tags'] := Item.Tags.Text;
  end;
  procedure SetDirAttr(iNode: IXMLNode; Item: TDirItem);
  begin
    SetBaseAttr(iNode, Item);
    iNode.Attributes['ViewStyle'] := Item.ViewStyle;
    iNode.Attributes['SortMode'] := Item.SortMode;
    iNode.Attributes['SortOrdAsc'] := Item.SortOrdAsc;
  end;                                          
  procedure SetTextAttr(iNode: IXMLNode; Item: TTextItem);
  begin
    SetBaseAttr(iNode, Item);
    iNode.Attributes['Mode'] := Item.Mode;
  end;
  procedure MakeTexts(iNode: IXMLNode; di: TDirItem);
  var ti: TPasteItem; tiNode: IXMLNode; tb: TSQLiteTable;
  begin
    ti := TPasteItem.Create(nil);
    tb := TPasteItem.Select(CN_PARENT_ID + ' = ' + IntToStr(di.ID));
    try
      tb.MoveFirst;
      while not tb.EOF do begin
        ti.SetFields(tb);
        tiNode := iNode.AddChild('Text');
        SetTextAttr(tiNode, ti);     
//        tiNode.Text := ConvertReturnCode(ti.Text, CR_R);
        tiNode.Text := ti.Text;

        tb.Next;
      end;
    finally
      tb.Free;
      ti.Free;
    end;
  end;
  function MakeDir(Node: TTreeNode; iNode: IXMLNode): IXMLNode;
  var di: TDirItem; diNode: IXMLNode;
  begin
    di := TDirItem(Node.Data);
    diNode := iNode.AddChild('Dir');
    SetDirAttr(diNode, di);
    MakeTexts(diNode, di);
    Result := diNode;
  end;
  procedure MakeNodes(Node: TTreeNode; iNode: IXMLNode);
  var niNode: IXMLNode; chNode: TTreeNode; i: Integer;
  begin
    niNode := MakeDir(Node, iNode);
//    if not IsSubDir then Exit;
    for i := 0 to Node.Count-1 do begin
      chNode := Node.Item[i];
      MakeNodes(chNode, niNode);
    end;
//    Node := Node.getFirstChild;
//    while Node <> nil do begin
//      MakeNodes(Node, niNode);
////      MakeDir(Node, iNode);
//      Node := Node.GetNextChild(Node);
//    end;
  end;
var nCount, i: Integer; msg: string;
  iRoot: IXMLNode;
begin
  nCount := Length(Nodes);
  if nCount = 0 then Exit;
  msg := 'エクスポート中…';
  Progress.BeginProgress(msg);
  try
//    XMLDoc.DOMVendor := OpenXMLFactory;
    XMLDoc.Active := False;
    XMLDoc.XML.Text := '';
    XMLDoc.Active := True;
    // root
    XMLDoc.DocumentElement := XmlDoc.CreateNode('Paste');
    iRoot := XMLDoc.DocumentElement;
    for i := Low(Nodes) to High(Nodes) do begin
      Progress.Progress(msg, nCount, i);
      MakeNodes(Nodes[i], iRoot);
    end;
    XMLDoc.XML.SaveToFile(XmlSaveDialog.FileName);
    XMLDoc.Active := False;
  finally
    Progress.EndProgress;
  end;
end;

procedure TFormStancher.SaveXmlFile(IsAll: Boolean);
var
  IsSubDir: Boolean; i, n: Integer;
  Node: TTreeNode; Nodes: TNodesArray;
begin
  if Option.ConfPasteXmlExport then begin
    MessageDlg('XMLファイルは、大量のデータをエクスポートするには向いていません。' + #13#10 +
      'お使いのマシンのスペックにより異なりますが、一度に書き出せないほどの' +
      '大量のデータを扱う場合は、' +
      '"選択ペーストフォルダをエクスポート"でフォルダごとに' +
      '小分けにしてエクスポートしてください。', mtInformation, [mbOK], 0);
  end;
  Node := TreePaste.Selected;
  if IsAll then begin
    n := 0;
    for i := 0 to TreePaste.Items.Count-1 do begin
      Node := TreePaste.Items[i];
      if Node.Level = 0 then begin
        SetLength(Nodes, n + 1);
        Nodes[n] := Node;
        Inc(n);
      end;
    end;
    XmlSaveDialog.FileName := 'AllPasteItems.xml';
  end else begin
    if Node = nil then Exit;
    SetLength(Nodes, 1);
    Nodes[0] := Node;
    XmlSaveDialog.FileName := NotErrorFileName(Node.Text) + '.xml';
  end;

//  XmlSaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if XmlSaveDialog.Execute then begin
    IsSubDir := False;
    if (Node.getFirstChild <> nil) or IsAll then
      IsSubDir := MessageDlg('サブフォルダも含めますか？', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    ExportXml(Nodes, IsSubDir);
  end;
end;

procedure TFormStancher.ActExportSelExecute(Sender: TObject);
begin
  SaveXmlFile(False);
end;

procedure TFormStancher.ActExportAllExecute(Sender: TObject);
begin
  SaveXmlFile(True);
end;

procedure TFormStancher.ImportXml(TargetNode: TTreeNode);
var NodeList: TList;  nCount: Integer; msg: string;
  procedure SetBaseAttr(iNode: IXMLNode; Item: TCommonItem);
  begin
    Item.Name       := iNode.Attributes['Name'];
    Item.CreateDate := StrToDateTime(iNode.Attributes['CreateDate']);
    Item.UpdateDate := StrToDateTime(iNode.Attributes['UpdateDate']);
    Item.AccessDate := StrToDateTime(iNode.Attributes['AccessDate']);
//    Item.Comment    := iNode.Attributes['Comment'];
    Item.Comment    := StringReplace(iNode.Attributes['Comment'], '&rtn;', #13#10, [rfReplaceAll]);
    Item.Tags.Text  := iNode.Attributes['Tags'];
  end;
  procedure SetDirAttr(iNode: IXMLNode; Item: TDirItem);
  begin
    SetBaseAttr(iNode, Item);
    Item.ViewStyle := iNode.Attributes['ViewStyle'];
    Item.SortMode := iNode.Attributes['SortMode'];
    Item.SortOrdAsc := iNode.Attributes['SortOrdAsc'];
  end;    
  procedure SetTextAttr(iNode: IXMLNode; Item: TTextItem);
  begin
    SetBaseAttr(iNode, Item);
    Item.Mode := iNode.Attributes['Mode'];
  end;
  procedure MakeTexts(Node: TTreeNode; iNode: IXMLNode);
  var ti: TPasteItem; chiNode: IXMLNode; i: Integer;
  begin
    ti := TPasteItem.Create(Node);
    try
      for i := 0 to iNode.ChildNodes.Count-1 do begin
        chiNode := iNode.ChildNodes.Nodes[i];
        if chiNode.NodeName = 'Text' then begin
          SetTextAttr(chiNode, ti);
          ti.Text := ConvertReturnCode(chiNode.Text, CRLF_R);
//          ti.Text := StringReplace(chiNode.Text, #10, #13#10, [rfReplaceAll]);
//          ti.Text := chiNode.Text;
          ti.Insert;
        end;
      end;
    finally
      ti.Free;
    end;
  end;
  function MakeDir(Node: TTreeNode; iNode: IXMLNode): TTreeNode;
  var di: TDirItem;  //i: Integer;
  begin
  Result := Node;
    if iNode.NodeName = 'Paste' then Exit;
          
    di := TDirItem.Create(Node);
    SetDirAttr(iNode, di);
    Result := TreePaste.Items.AddChildObject(Node, di.Name, di);
    di.TableID := TBID_PASTE_ITEMS;
    di.Insert;              
    NodeList.Add(Result);
    MakeTexts(Result, iNode);
  end;
  procedure MakeNodes(Node: TTreeNode; iNode: IXMLNode);
  var i: Integer; chiNode: IXMLNode; newNode: TTreeNode;
  begin
    newNode := MakeDir(Node, iNode);
    for i := 0 to iNode.ChildNodes.Count-1 do begin
      if iNode.NodeName = 'Paste' then Progress.Progress(msg, nCount, i);
      chiNode := iNode.ChildNodes.Nodes[i];
      if chiNode.NodeName = 'Dir' then
        MakeNodes(newNode, chiNode);
    end;
  end;
var i: Integer; XmlNode: IXMLNode;
begin
  NodeList := TList.Create;
  TreePaste.Items.BeginUpdate;
  XMLDoc.LoadFromFile(XmlOpenDialog.FileName);
  try
    XmlNode := XMLDoc.DocumentElement;
    if XmlNode.NodeName <> 'Paste' then begin
      Beep;
      MessageDlg('Stamper+のエクスポートファイルではありません。', mtWarning, [mbOK], 0);
      Exit;
    end;   
    msg := 'インポート中…';
    Progress.BeginProgress(msg);
    nCount := XmlNode.ChildNodes.Count;
    BeginTransaction;
    try             
//      DOutB(TreePaste.Selected = nil);
      MakeNodes(TargetNode, XmlNode);
//      for i := 0 to XmlNode.ChildNodes.Count-1 do begin
        //Progress.Progress(msg, nCount, i);
//      end;
      Commit;
    except
      Rollback;
      //エラー時作成してしまったノードを削除する
      for i := NodeList.Count-1 downto 0 do
        TTreeNode(NodeList[i]).Delete;
    end;
  finally
    NodeList.Free;
    TreePaste.Items.EndUpdate;
    Progress.EndProgress;
  end;
end;

procedure TFormStancher.ActImportXmlExecute(Sender: TObject);
var n: TTreeNode;
begin
  n := TreePaste.Selected;
  if XmlOpenDialog.Execute then begin
    ImportXml(n);
  end;
end;

procedure TFormStancher.ActAbputExecute(Sender: TObject);
begin
  FormAbout := TFormAbout.Create(Self);
  try
    FormAbout.ShowModal;
  finally
    FormAbout.Free;
    FormAbout := nil;
  end;
end;

procedure TFormStancher.ImportXmlOldVer(TargetNode: TTreeNode);
var NodeList: TList;  nCount: Integer; msg: string;
  procedure SetBaseAttr(iNode: IXMLNode; Item: TCommonItem);
  begin
    Item.Name       := iNode.Attributes['Title'];
  end;
  procedure SetDirAttr(iNode: IXMLNode; Item: TDirItem);
  begin
    SetBaseAttr(iNode, Item);
  end;    
  procedure SetTextAttr(iNode: IXMLNode; Item: TTextItem);
  begin
    SetBaseAttr(iNode, Item);
    Item.Mode := pmPaste;
  end;
  procedure MakeTexts(Node: TTreeNode; iNode: IXMLNode);
  var ti: TPasteItem; chiNode: IXMLNode; i: Integer;
  begin
    ti := TPasteItem.Create(Node);
    try
      for i := 0 to iNode.ChildNodes.Count-1 do begin
        chiNode := iNode.ChildNodes.Nodes[i];
        if chiNode.NodeName = 'Text' then begin
          SetTextAttr(chiNode, ti);
          ti.Text := chiNode.Text;
          if Trim(ti.Text) = '' then ti.Text := ti.Name;
//          ti.IconItem := TIconItem(PasteIcons[0]);
          ti.Insert;
        end;
      end;
    finally
      ti.Free;
    end;
  end;
  function MakeDir(Node: TTreeNode; iNode: IXMLNode): TTreeNode;
  var di: TDirItem; //i: Integer;
  begin
    Result := Node;
    if iNode.Attributes['Attr'] <> Null then
      if (MessageDlg('ルートフォルダも含めますか？',
          mtConfirmation, [mbYes, mbNo], 0) = mrNo) then  Exit;

    di := TDirItem.Create(Node);
    SetDirAttr(iNode, di);
    Result := TreePaste.Items.AddChildObject(Node, di.Name, di);
    di.TableID := TBID_PASTE_ITEMS;
    di.Insert;
    NodeList.Add(Result);
    MakeTexts(Result, iNode);
  end;
  procedure MakeNodes(Node: TTreeNode; iNode: IXMLNode);
  var i: Integer; chiNode: IXMLNode; newNode: TTreeNode;
  begin
    newNode := MakeDir(Node, iNode);
    for i := 0 to iNode.ChildNodes.Count-1 do begin
      if iNode.Attributes['Attr'] <> Null then Progress.Progress(msg, nCount, i);
      chiNode := iNode.ChildNodes.Nodes[i];
      if (chiNode.NodeName = 'Dir') and (chiNode.Attributes['Attr'] = Null) then
        MakeNodes(newNode, chiNode);
    end;
  end;
var i: Integer; XmlNode: IXMLNode;
begin
  NodeList := TList.Create;
  TreePaste.Items.BeginUpdate;
  XMLDoc.LoadFromFile(XmlOpenDialog.FileName);

  try            XmlNode := XMLDoc.DocumentElement;
    if (XmlNode.Attributes['Attr'] = Null) then begin
      Beep;
      MessageDlg('Stamperのエクスポートファイルではありません。', mtWarning, [mbOK], 0);
      Exit;
    end;
    msg := 'インポート中…';
    Progress.BeginProgress(msg);
    nCount := XmlNode.ChildNodes.Count;
    BeginTransaction;
    try
//      DOutB(TreePaste.Selected = nil);
      MakeNodes(TargetNode, XmlNode);
      Commit;
    except
      Rollback;
      //エラー時作成してしまったノードを削除する
      for i := NodeList.Count-1 downto 0 do
        TTreeNode(NodeList[i]).Delete;
    end;
  finally
    NodeList.Free;
    TreePaste.Items.EndUpdate;
    Progress.EndProgress;
  end;
end;

procedure TFormStancher.ActImportXmlOldVerExecute(Sender: TObject);
var n: TTreeNode;
begin
  n := TreePaste.Selected;
  if XmlOpenDialog.Execute then begin
    ImportXmlOldVer(n);
  end;
end;

procedure TFormStancher.WMEnable(var Message: TWMEnable);
begin
  if Message.Enabled then begin
    TopMostWnd := TmpTopMost;
    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  end else begin
    TmpTopMost := TopMostWnd;
    ApplicationEvents.OnMessage := nil;
    TopMostWnd := False;
  end;
end;

procedure TFormStancher.ActBugReportExecute(Sender: TObject);
begin
  FormBugReport := TFormBugReport.Create(Self);
  try
    FormBugReport.ShowModal;
  finally
    FormBugReport.Free;
    FormBugReport := nil;
  end;
end;

procedure TFormStancher.DeleteDirKey(id: Int64; IsShortcut: Boolean);
var i, j: Integer; tv: TTreeView; ci: TCommonItem; ki: TKeyItem;
begin
  for i := Integer(eiPaste) to Integer(eiBkmk) do begin
    tv := EditItemToTree(TEditItem(i));
    if tv = nil then Break;
    for j := 0 to tv.Items.Count-1 do begin
      ci := TCommonItem(tv.Items[j].Data);
      if IsShortcut then begin
        if ci.ShortcutKey.ID = id then begin
          ki := ci.ShortcutKey;
          ki.Key := 0;
          Exit;
        end;
      end else begin
        if ci.HotKey.ID = id then begin
          ki := ci.HotKey;
          ki.Key := 0;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TFormStancher.DeleteDirMouseAction(id: Int64);
var i, j: Integer; tv: TTreeView; ci: TCommonItem; mi: TMouseItem;
begin
  for i := 0 to Integer(eiClip) do begin
    tv := EditItemToTree(TEditItem(i));
    for j := 0 to tv.Items.Count-1 do begin
      ci := TCommonItem(tv.Items[j].Data);
      if ci.Mouse.ID = id then begin
        mi := ci.Mouse;
        mi.Enabled := False;
        mi.Action := maLClk;   
        mi.KeyFlags := 0;
        mi.Keys := [];
        mi.RtnPoses := [];
        Exit;
      end;
    end;
  end;
end;

procedure TFormStancher.ListViewAllSearchSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    MakeTags(TCommonItem(Item.Data))
  else
    ClearTags;
end;

procedure TFormStancher.ListViewPasteClick(Sender: TObject);
var ci: TCommonItem; p: TPoint; Item: TListItem;
begin
  GetCursorPos(p);
  p := TListView(Sender).ScreenToClient(p);
  Item := TListView(Sender).GetItemAt(p.X, p.Y);
  if Item = nil then Exit;
  ci := TCommonItem(Item.Data);
  MakeTags(ci);
end;

procedure TFormStancher.PasteDateTimeExecute(Fmt: string);
var pi: TPasteItem;
begin
  pi := TPasteItem.Create(nil);
  try
    pi.Text := FormatDateTime(Fmt, Now);
    pi.Mode := DateTimePasteMode;
    pi.Excute;
    Option.PlaySound;
  finally
    pi.Free;
  end;
end;

procedure TFormStancher.ActPasteDateExecute(Sender: TObject);
begin
  PasteDateTimeExecute(Option.DateFmt);
end;

procedure TFormStancher.ActPasteTimeExecute(Sender: TObject);
begin
  PasteDateTimeExecute(Option.TimeFmt);
end;

procedure TFormStancher.ActPasteDateTimeExecute(Sender: TObject);
begin
  PasteDateTimeExecute(Option.DateTimeFmt);
end;

procedure TFormStancher.SetDateTimePasteMode(const Value: TPasteMode);
begin
  FDateTimePasteMode := Value;
end;

procedure TFormStancher.SetIsDateTimeCopy(const Value: Boolean);
begin
  FIsDateTimeCopy := Value;
  ActIsDateTimeCopy.Checked := Value;
  if Value then
    DateTimePasteMode := pmCopy
  else
    DateTimePasteMode := pmPaste;
end;

procedure TFormStancher.ActIsDateTimeCopyExecute(Sender: TObject);
begin
  IsDateTimeCopy := not IsDateTimeCopy;
end;

procedure TFormStancher.ActOpenLaunchDirExecute(Sender: TObject);
begin
  if ListViewLaunch.Items.Count = 0 then Exit;
  ShellExecute(Handle, 'OPEN',
    PChar(ExtractFileDir(TLaunchItem(ListViewLaunch.Selected.Data).FileName)),
    '', '', SW_SHOWNORMAL);
end;

procedure TFormStancher.ActTabMoveExecute(Sender: TObject);
  function DispTabCount: Integer;
  var i: Integer;
  begin
    Result := 0;
    for i := 0 to PageControlMain.PageCount-1 do begin
      if PageControlMain.Pages[i].TabVisible then
        Inc(Result);
    end;
  end;
var api, npi, i: Integer; tab: TTabSheet;
begin
  if DispTabCount <= 1 then Exit;
  api := PageControlMain.ActivePageIndex;
  npi := api + 1;
  if npi = PageControlMain.PageCount then npi := 0;
  for i := npi to PageControlMain.PageCount - 1 do begin
    tab := PageControlMain.Pages[i];
    if tab.TabVisible then begin 
      PageControlMain.ActivePage := tab;
//      ActiveTree.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFormStancher.Button2Click(Sender: TObject);
begin
  DOut(DropFilesLaunch.TargetControl.Name);
end;

procedure TFormStancher.ListViewClipMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var it: TListItem;
begin
  it := ListViewClip.GetItemAt(X, Y);
  DisplayDetailOfItem(it, MemoClipText);
end;

procedure TFormStancher.Backup;
var fn: string; sl: TStringList;
begin
  ChDir(ExtractFilePath(Application.ExeName));
  fn := IncludeTrailingPathDelimiter(Option.BackupDir) +
    FormatDateTime('yyyymmddhhnnss".db"', Now);
  if not DirectoryExists(Option.BackupDir) then
    ForceDirectories(Option.BackupDir);
  CopyFile(PChar(DbFile), PChar(fn), False);
  EncryptsFile(fn, PassWord, False);
  sl := TStringList.Create;
  try
    FindAllFilesWithExt(Option.BackupDir, 'db', sl, False);
    sl.Sort;
    while sl.Count <> 0 do begin
      if sl.Count <= Option.LeaveBackupFiles then Break;
      DeleteFile(sl[0]);
      sl.Delete(0);
    end;
//    ShowMessage(sl.Text);
  finally
    sl.Free;
  end;
  Option.LastBackupDate := Now;
end;

procedure TFormStancher.TimerAutoBackupTimer(Sender: TObject);
begin
  if Option.AutoBacup then begin
    case Option.BackupMode of
      bmDay: if IncDay(Option.LastBackupDate) < Now then Backup;
      bmWeek: if IncWeek(Option.LastBackupDate) < Now then Backup;
      bmMonth: if IncMonth(Option.LastBackupDate) < Now then Backup;
    end;
  end;
end;

procedure TFormStancher.ListViewPasteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var it: TListItem;
begin
  it := ListViewPaste.GetItemAt(X, Y);
  DisplayDetailOfItem(it, MemoPasteText);
end;

procedure TFormStancher.ActReloadDirExecute(Sender: TObject);
begin
  LoadDirFromDB(ActiveTree);
end;

procedure TFormStancher.TextDropTargetQueryTextDrop(Text: String);
begin
  EditQuery.Text := Text;
end;

procedure TFormStancher.EditQueryDblClick(Sender: TObject);
begin
  EditQuery.SelectAll;
end;

procedure TFormStancher.SetDispBkmkTab(const Value: Boolean);
begin
  FDispBkmkTab := Value; 
  ActDispBkmkTab.Checked := Value;
  TabBkmk.TabVisible := Value;
end;

procedure TFormStancher.SetDispClipTab(const Value: Boolean);
begin
  FDispClipTab := Value;
  ActDispClipTab.Checked := Value;
  TabClip.TabVisible := Value;
  ClipboardWatcher.Enabled := Value;
end;

procedure TFormStancher.SetDispLaunchchTab(const Value: Boolean);
begin
  FDispLaunchchTab := Value;
  ActDispLaunchchTab.Checked := Value;
  TabLaunch.TabVisible := Value;
end;

procedure TFormStancher.SetDispPasteTab(const Value: Boolean);
begin
  FDispPasteTab := Value; 
  ActDispPasteTab.Checked := Value;
  TabPaste.TabVisible := Value;
end;

procedure TFormStancher.SetDispSearchTab(const Value: Boolean);
begin
  FDispSearchTab := Value;  
  ActDispSearchTab.Checked := Value;
  TabAllSearch.TabVisible := Value;
end;

procedure TFormStancher.ActForcusTreeExecute(Sender: TObject);
begin
  if Assigned(ActiveTree) then ActiveTree.SetFocus;
end;

procedure TFormStancher.ActForcusListExecute(Sender: TObject);
begin
  if Assigned(ActiveList) then
    ActiveList.SetFocus;
end;

procedure TFormStancher.ActForcusQueryExecute(Sender: TObject);
begin
  if ToolBarQuery.Visible then EditQuery.SetFocus;
end;

procedure TFormStancher.ActForcusMoveExecute(Sender: TObject);
var ac: TControl;
begin
  case EditItem of
    eiAllSearch, eiClip: Exit;
  end;
  ac := ActiveControl;
  if ac is TTreeView then actForcusList.Execute
  else if ac is TListView then ActForcusTree.Execute;
end;

procedure TFormStancher.PageControlMainDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  i :integer;
  R :TRect;
begin
  if Sender is TPageControl then
  begin
    Accept :=true;
    //挿入される位置を線で描画(おまけです。必要ないなら削除可)
    with PageControlMain do begin
      for i :=0 to PageCount -1 do begin
        PerForm(TCM_GETITEMRECT, i,Integer(@R));

        if PtinRect(R, Point(X, Y)) {and (i <> TabIndex)} then
        begin
          if i <> OldDragTabIndex then
            Refresh;
          with (Sender as TPageControl).Canvas do begin
            Pen.Color :=clBlack;
            Pen.Width :=2;
            {挿入される位置に応じてタブの左右どちらに
             線を描画するか変える}
            if i <= TabIndex then
            begin
              MoveTo(R.Left +1, R.Top);
              LineTo(R.Left +1, R.Bottom);
            end else begin
              MoveTo(R.Right -1, R.Top);
              LineTo(R.Right -1, R.Bottom);
            end;
            OldDragTabIndex := i;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFormStancher.PageControlMainDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  i :integer; r :TRect;
begin
  with PageControlMain do begin
    for i :=0 to PageCount -1 do begin
      //最初のタブから順番にタブの矩形を取得
      PerForm(TCM_GETITEMRECT, i,Integer(@r));

      //現在のタブ上にマウスがあればアクティブページにセット
      if PtinRect(r, Point(X, Y)) then begin
        if i <> ActivePageIndex then

          Pages[ActivePageIndex].PageIndex := i;
          PageControlMain.EndDrag(False);
          
//          Exit;
      end;
    end;
  end;
  Refresh;
end;

procedure TFormStancher.ActDispSearchTabExecute(Sender: TObject);
begin
  DispSearchTab := not DispSearchTab;
end;

procedure TFormStancher.ActDispPasteTabExecute(Sender: TObject);
begin
  DispPasteTab := not DispPasteTab;
end;

procedure TFormStancher.ActDispLaunchchTabExecute(Sender: TObject);
begin
  DispLaunchchTab := not DispLaunchchTab;
end;

procedure TFormStancher.ActDispBkmkTabExecute(Sender: TObject);
begin
  DispBkmkTab := not DispBkmkTab;
end;

procedure TFormStancher.ActDispClipTabExecute(Sender: TObject);
begin
  DispClipTab := not DispClipTab;
end;

procedure TFormStancher.PageControlMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PageControlMain.BeginDrag(False, 20);
end;

function TFormStancher.IsMouseCslRtnPos: Boolean;
var
	P: TPoint; r: TRect; w: Integer;
begin
  Result := False;
  GetCursorPos(P);
  r := Screen.DesktopRect;
  w := Option.MouseCslRtnWidth;
  //左上
  if mpLeftTop in Option.MouseCslRtnPoses then
    if (P.X < r.Left + w) and (P.Y < r.Top + w) then begin
      Result := True;
      Exit;
    end;
  //左下
  if mpLeftBottom in Option.MouseCslRtnPoses then
    if (P.X < r.Left + w) and (P.Y > r.Bottom - w) then begin
      Result := True;
      Exit;
    end;
  //右上
  if mpRightTop in Option.MouseCslRtnPoses then
    if (P.X > r.Right - w) and (P.Y < r.Top + w) then begin
      Result := True;
      Exit;
    end;
  //右下
  if mpRightBottom in Option.MouseCslRtnPoses then
    if (P.X > r.Right - w) and (P.Y > r.Bottom - w) then begin
      Result := True;
      Exit;
    end;
end;

procedure TFormStancher.TimerMouseCslRtnTimer(Sender: TObject);
begin
  if (Option.CallMethod = cmMouseClk) and (not Stealth) and Visible then begin
    TimerShowMouseCslRtn.Enabled := False;
    Exit;
  end;

  TimerShowMouseCslRtn.Enabled := IsMouseCslRtnPos;
end;

procedure TFormStancher.TimerShowMouseCslRtnTimer(Sender: TObject);
begin
  try
    if not Stealth and Visible then Exit;
    ShowStealth;
  finally
    TimerShowMouseCslRtn.Enabled := False;
  end;
end;

procedure TFormStancher.ActClipToFilePathExecute(Sender: TObject);
begin
  DataModule1 := TDataModule1.Create(Self);
end;

procedure TFormStancher.ActClipToPicExecute(Sender: TObject);
begin
  DataModule1 := TDataModule1.Create(Self);
end;

procedure TFormStancher.TreePasteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var n: TTreeNode;
begin
  if not (Sender is TTreeView) then Exit;
  n := TTreeView(Sender).Selected;
  if n = nil then Exit;
  if (Key = VK_RETURN) or (Key = VK_SPACE) then
    n.Expanded := not n.Expanded; 
  if (Key = VK_DELETE) then
    ActDeleteDir.Execute;
end;

procedure TFormStancher.TreePasteKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TFormStancher.ListViewPasteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var ci: TCommonItem; it: TListItem;
begin
  if not (Sender is TListView) then Exit;
  it := TListView(Sender).Selected;
  if it = nil then Exit;
  ci := TCommonItem(it.Data);
  if Key = VK_RETURN then
    ci.Excute;
  if Key = VK_DELETE then
    ActDeleteItem.Execute;
end;

procedure TFormStancher.ListViewAllSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ListViewAllSearchDblClick(ListViewAllSearch)
end;

procedure TFormStancher.ActKeyoperationHelpExecute(Sender: TObject);
var msg: string;
begin
  FormMemo := TFormMemo.Create(Self);
  try
    FormMemo.Caption := 'キー操作ヘルプ';
    FormMemo.LabelMsg.Caption := 'キーポードで操作するためのショートカット';
    msg := ActTabMove.Caption + #9#9 + ShortCutToText(ActTabMove.ShortCut) + #13#10 +  
           ActForcusMove.Caption + #9#9 + ShortCutToText(ActForcusMove.ShortCut) + #13#10 +
           ActForcusQuery.Caption + #9 + ShortCutToText(ActForcusQuery.ShortCut) + #13#10 +
           ActForcusTree.Caption + #9#9 + ShortCutToText(ActForcusTree.ShortCut) + #13#10 +
           ActForcusList.Caption + #9#9 + ShortCutToText(ActForcusList.ShortCut) + #13#10 +
           'フォーカス間移動'#9#9'Tab'#13#10 +
           '決定'#9#9#9'Enter';
    FormMemo.Memo.Text := msg;
    FormMemo.OKBtn.Visible := False;
    FormMemo.CancelBtn.Caption := 'OK';
    FormMemo.Height := 200;
    FormMemo.BorderStyle := bsDialog;
    FormMemo.ShowModal;
  finally
    FormMemo.Release;
  end;
end;

procedure TFormStancher.ActReloadListExecute(Sender: TObject);
begin
  LoadItemFromDB;
end;

procedure TFormStancher.DisplayDetailOfItem(Item: TListItem; Memo: TMemo);
var ti: TTextItem;
begin
  if Item <> nil then begin
    ti := TPasteItem(Item.Data);
    Memo.Text := ti.Text;
  end else
    Memo.Clear;
end;

procedure TFormStancher.ListViewPasteChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  DisplayDetailOfItem(Item, MemoPasteText);
end;

procedure TFormStancher.ListViewClipChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  DisplayDetailOfItem(Item, MemoClipText);
end;

procedure TFormStancher.TabClipShow(Sender: TObject);
begin
  SetListViewColumImage(ListViewClip);
end;

procedure TFormStancher.TabAllSearchShow(Sender: TObject);
begin
  SetListViewColumImage(ListViewAllSearch);
end;

procedure TFormStancher.ClipLVWndProc(var Message: TMessage);
//var ci: TClipItem;
begin
  case Message.Msg of
//    CM_MOUSEENTER: begin
//
//    end;//
    CM_MOUSELEAVE: begin
//      ListViewClip.EndDrag(True);
//
//      if Assigned(ListViewClip.Selected) then begin
//        ci := TClipItem(ListViewClip.Selected.Data);
//        DropTextSourceClip.Text := ci.Text + #0#0;
//        DropTextSourceClip.ImageIndex := ListViewClip.Selected.ImageIndex;
//        DropTextSourceClip.Execute;
//      end;
    end;
    //他のメッセージは元のウィンドウプロシージャに渡す
    else DefClipLVWndProc(Message);
  end;
end;

procedure TFormStancher.PastLVWndProc(var Message: TMessage);
//var pi: TPasteItem;
begin
  case Message.Msg of
//    CM_MOUSEENTER: begin
//
//    end;//
    CM_MOUSELEAVE: begin
//      ListViewPaste.EndDrag(True);
//
//      if Assigned(ListViewPaste.Selected) then begin
//        pi := TPasteItem(ListViewPaste.Selected.Data);
//        DropTextSourcePaste.Text := pi.Text + #0#0;
//        DropTextSourcePaste.ImageIndex := ListViewPaste.Selected.ImageIndex;
//        DropTextSourcePaste.Execute;
//      end;
    end;
    //他のメッセージは元のウィンドウプロシージャに渡す
    else DefPasteLVWndProc(Message);
  end;
end;


procedure TFormStancher.DropTextSourceClipAfterDrop(Sender: TObject;
  DragResult: TDragResult; Optimized: Boolean);
begin
  TextDropFlag := False;
end;

procedure TFormStancher.TimerTextDropTimer(Sender: TObject);
var p: TPoint; ci: TClipItem; pi: TPasteItem;
begin
  if TextDropFlag then Exit;
  GetCursorPos(p);         
  if (not ListViewPaste.Dragging) and (not ListViewClip.Dragging) then Exit;
  if PtInRect(Rect(Left, Top, Left+Width, Top+Height), p) then Exit;
  TextDropFlag := True;
  case EditItem of
    eiPaste:begin
      ListViewPaste.EndDrag(True);

      if Assigned(ListViewPaste.Selected) then begin
        pi := TPasteItem(ListViewPaste.Selected.Data);
        DropTextSourcePaste.Text := pi.Text + #0#0;
        DropTextSourcePaste.ImageIndex := ListViewPaste.Selected.ImageIndex;
        DropTextSourcePaste.Execute;
      end;
    end;
    eiClip:begin
      ListViewClip.EndDrag(True);

      if Assigned(ListViewClip.Selected) then begin
        ci := TClipItem(ListViewClip.Selected.Data);
        DropTextSourceClip.Text := ci.Text + #0#0;
        DropTextSourceClip.ImageIndex := ListViewClip.Selected.ImageIndex;
        DropTextSourceClip.Execute;
      end;
    end;
  end;
end;

procedure TFormStancher.ActClipToFileExecute(Sender: TObject);
begin
  DataModule1 := TDataModule1.Create(Self);
end;

procedure TFormStancher.ClipboardViewerTimerTimer(Sender: TObject);
begin
  WatchingClip := False;

  ClipboardWatcher.Enabled := False;
  ClipboardWatcher.Enabled := True;

  WatchingClip := True;
end;

procedure TFormStancher.SetColumnAcWidth(const Value: Integer);
begin
  FColumnAcWidth := Value;
end;

procedure TFormStancher.SetColumnCommentWidth(const Value: Integer);
begin
  FColumnCommentWidth := Value;
end;

procedure TFormStancher.SetColumnCrWidth(const Value: Integer);
begin
  FColumnCrWidth := Value;
end;

procedure TFormStancher.SetColumnParentWidth(const Value: Integer);
begin
  FColumnParentWidth := Value;
end;

procedure TFormStancher.SetColumnRepWidth(const Value: Integer);
begin
  FColumnRepWidth := Value;
end;

procedure TFormStancher.SetColumnUpWidth(const Value: Integer);
begin
  FColumnUpWidth := Value;
end;

procedure TFormStancher.SetColumnUseWidth(const Value: Integer);
begin
  FColumnUseWidth := Value;
end;

procedure TFormStancher.SetColumnBelongWidth(const Value: Integer);
begin
  FColumnBelongWidth := Value;
end;

procedure TFormStancher.SetColumnCaptionWidth(const Value: Integer);
begin
  FColumnCaptionWidth := Value;
end;

procedure TFormStancher.ChangeListViewColumWidth;   
  function FindColum(s: string): TListColumn;
  var i: Integer;
  begin
    Result := nil;
    for i := 0 to ActiveList.Columns.Count-1 do begin
      if ActiveList.Column[i].Caption = s then
        Result := ActiveList.Column[i];
    end;
  end;
var 
  clm: TListColumn;
begin
  clm := FindColum('名前');
  if (clm <> nil) then ColumnCaptionWidth := clm.Width; 
  clm := FindColum('作成日');
  if (clm <> nil) and ColumnCrVisible then ColumnCrWidth := clm.Width;
  clm := FindColum( '更新日');
  if (clm <> nil) and ColumnUpVisible then ColumnUpWidth := clm.Width;
  clm := FindColum('最終使用日');
  if (clm <> nil) and ColumnAcVisible then ColumnAcWidth := clm.Width;
  clm := FindColum('使用回数');
  if (clm <> nil) and ColumnUseVisible then ColumnUseWidth := clm.Width;
  clm := FindColum('使用頻度');
  if (clm <> nil) and ColumnRepVisible then ColumnRepWidth := clm.Width;
  if EditItem <> eiClip then begin
    clm := FindColum('親フォルダ');
    if (clm <> nil) and ColumnParentVisible then ColumnParentWidth := clm.Width;
    clm := FindColum('コメント');
    if (clm <> nil) and ColumnCommentVisible then ColumnCommentWidth := clm.Width;
  end;
  if EditItem = eiAllSearch then begin
    clm := FindColum('所属');
    if (clm <> nil) then ColumnBelongWidth := clm.Width;
  end;
end;

procedure TFormStancher.TreePasteCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
begin
  TTreeView(Sender).OnClick := nil;  
  AutoExpandTimer.Enabled := True;
end;

procedure TFormStancher.AutoExpandTimerTimer(Sender: TObject);
begin
  TreePaste.OnClick := TreePasteClick;
  AutoExpandTimer.Enabled := False;
end;

end.


