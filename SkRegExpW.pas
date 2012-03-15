(*

The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in
compliance with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS"
basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
License for the specific language governing rights and limitations
under the License.

The Original Code is SkRegExpW.pas(for SkRegExp Library).

The Initial Developer of the Original Code is Shuuichi Komiya.

  E-mail: shu@k.email.ne.jp
  URL:    http://www.asahi-net.or.jp/~qz1s-kmy/skregexp/

Portions created by Shuuichi Komiya are
Copyright (C) 2007 Shuuichi Komiya. All Rights Reserved.

*)

(*
更新履歴:
  0.9.2 2008/1/4    条件定義にUseJapaneseOptionを追加
  0.9.1 2007/12/31  最初のバージョン
*)

unit SkRegExpW;

interface

{日本語特有の処理を行う条件定義
以下の定義を無効にすると、全角半角の同一視、カタカナひらがなの同一視を行わない。}
{$DEFINE JapaneseExt}

{$IFDEF JapaneseExt}
  {この定義を無効にすると(?k)、と(?w)が正規表現パターン内で使えなくなるが、
  プロパティで指定することはできる。
  この方が便利なことがあるので追加した。}
  {$DEFINE UseJapaneseOption}
{$ENDIF}

uses
  SysUtils,
  Classes,
  Contnrs,
  {$IFDEF DEBUG}
  ComCtrls,
  {$ENDIF}
  {$IFDEF VER180}
  WideStrings,  //Delphi7にはなかったので。でもDelphi7での動作は未確認
  {$ENDIF}
  UnicodeProp;

type
  {例外}
  ESkRegExp = class(Exception)
  public
    ErrorPos: Integer
  end;

  {$IFDEF VER180}
  TREStrings = TWideStrings;
  TREStringList = TWideStringList;
  {$ELSE}
  TREStrings = TStrings;
  TREStringList = TStringList;
  {$ENDIF}

  TREChar = Word;

  {正規表現オプション}
  TREOption = (roNone, roIgnoreCase, roMultiLine, roNamedGroupOnly,
    roSingleLine, roExtended, roIgnoreWidth, roIgnoreKana,
    roDefinedCharClassLegacy);
  TREOptions= set of TREOption;
  PREOptions = ^TREOptions;

  TREOperator = (opEmply, opConcat, opUnion, opPlus, opStar, opQuest,
    opBound, opLHead, opLTail, opGroup,
    opAheadMatch, opAheadNoMatch,
    opBehindMatch, opBehindNoMatch,
    opNoBackTrack);

  TREContextKind = (ctNormal, ctCharClass, ctNegativeCharClass);

  TREToken = (tkEnd, tkChar, tkUnion, tkReference, tkNameReference,
    tkGroupStart, tkAheadMatch, tkAheadNoMatch,
    tkBehindMatch, tkBehindNoMatch,
    tkNoBackTrack,
    tkLPar, tkRPar, tkStar, tkPlus, tkDot,
    tkLParWithOption,
    tkQuest, tkRangeChar,
    tkWordChar, tkNEWordChar,
    tkDigitChar, tkNEDigitChar,
    tkHexDigitChar, tkNEHexDigitChar,
    tkSpaceChar, tkNESpaceChar,
    tkBound, tkCharClassFirst , tkNegativeCharClassFirst, tkCharClassEnd,
    tkNewLine, tkTHead, tkTTail, tkTTailEnd,
    tkWordBoundary, tkNEWordBoundary, tkOption,
    tkPosixBracket, tkNEPosixBracket, tkCombiningSequence,
    tkProperty, tkNEProperty, tkGroupName);

  TRENFAKind = (nkNormal, nkChar, nkEmpty,
    nkLoop, nkGroupStart, nkGroupEnd,
    nkAheadMatch, nkAheadNoMatch,
    nkBehindMatch, nkBehindNoMatch,
    nkNoBackTrackBegin, nkNoBackTrackEnd,
    nkMatchEnd, nkEnd);

  TRELoopMatchKind = (lmNormal, lmMin, lmMax);

  TREMatchRec = record
    GroupName: WideString;
    Entry, Wayout: Integer;
    StartPBuf, StartP, EndP: PWideChar;
  end;
  PREMatchRec = ^TREMatchRec;

  TSkRegExp = class;

  TREMatchData = class(TList)
  private
    function GetEndP(Index: Integer): PWideChar;
    function GetStartP(Index: Integer): PWideChar;
    procedure SetEndP(Index: Integer; const Value: PWideChar);
    procedure SetStartP(Index: Integer; const Value: PWideChar);
    function GetGroupName(Index: Integer): WideString;
  public
    procedure Clear; override;
    procedure Add(const AGroupName: WideString; AEntry, AWayout: Integer);
    procedure Delete(Index: Integer);
    function IndexOfName(const AName: WideString): Integer;
    function GetEntry(Index: Integer): Integer;
    procedure Reset(AStr: PWideChar);
    property StartP[Index: Integer]: PWideChar read GetStartP write SetStartP;
    property EndP[Index: Integer]: PWideChar read GetEndP write SetEndP;
    property GroupName[Index: Integer]: WideString read GetGroupName;
  end;

  TRECode = class
  private
    FRegExp: TSkRegExp;
  public
    constructor Create(ARegExp: TSkRegExp);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; virtual;
    function IsInclude(ACode: TRECode): Boolean; virtual;
  {$IFDEF DEBUG}
    function GetStr: WideString; virtual;
  {$ENDIF}
  end;

  TRECharCode = class(TRECode)
  private
    FWChar: TREChar;
    FOptions: TREOptions;
    FConvert: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp;
      AWChar: TREChar; AOptions: TREOptions; AConvert: Boolean = False);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TRERangeCharCode = class(TRECode)
  private
    FStartWChar, FLastWChar: TREChar;
    FOptions: TREOptions;
  public
    constructor Create(ARegExp:TSkRegExp;
      AStartWChar, ALastWChar: TREChar; AOptions: TREOptions);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TREAnyCharCode = class(TRECode)
  private
    FOptions: TREOptions;
  public
    constructor Create(ARegExp: TSkRegExp; AOptions: TREOptions);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TREWordCharCode = class(TRECode)
  private
    FNegative: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp; ANegative: Boolean);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TREDigitCharCode = class(TRECode)
  private
    FNegative: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp; ANegative: Boolean);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
   function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TREHexDigitCharCode = class(TRECode)
  private
    FNegative: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp; ANegative: Boolean);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
   function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TRESpaceCharCode = class(TRECode)
  private
    FNegative: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp; ANegative: Boolean);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
  {$IFDEF DEBUG}
    function GetStr: WideString; override;
  {$ENDIF}
  end;

  TRECharClassCode = class(TRECode)
  private
    FNegative: Boolean;
    FCodeList: TObjectList;
  public
    constructor Create(ARegExp: TSkRegExp; ANegative: Boolean);
    destructor Destroy; override;
    function Add(AWChar: TREChar; AOptions: TREOptions): Integer; overload;
    function Add(AStartWChar, ALastWChar: TREChar; AOptions: TREOptions): Integer; overload;
    function Add(Value: TRECode): Integer; overload;
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    procedure Rebuild;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRECombiningSequence = class(TRECode)
  public
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRENewLineCode = class(TRECode)
  public
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TREBoundaryCode = class(TRECode)
  private
    FNegative: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp; ANegative: Boolean);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TREReferenceCode = class(TRECode)
  private
    FGroupIndex: Integer;
    FOptions: TREOptions;
  public
    constructor Create(ARegExp: TSkRegExp; AGroupIndex: Integer;
      AOptions: TREOptions); overload;
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRENameReferenceCode = class(TRECode)
  private
    FGroupName: WideString;
    FOptions: TREOptions;
  public
    constructor Create(ARegExp: TSkRegExp; AGroupName: WideString;
      AOptions: TREOptions);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRELineHeadCode = class(TRECode)
  private
    FOptions: TREOptions;
  public
    constructor Create(ARegExp: TSkRegExp; AOptions: TREOptions);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRELineTailCode = class(TRECode)
  private
    FOptions: TREOptions;
  public
    constructor Create(ARegExp: TSkRegExp; AOptions: TREOptions);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRETextHeadCode = class(TRECode)
  public
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRETextTailCode = class(TRECode)
  public
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TRETextEndCode = class(TRECode)
  public
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TREPropertyCode = class(TRECode)
  private
    FUniCodeProperty: TUnicodeProperty;
    FNegative: Boolean;
  public
    constructor Create(ARegExp: TSkRegExp; AUnicodeProperty: TUnicodeProperty;
      ANegative: Boolean);
    function Equals(AStr: PWideChar; var Len: Integer): Boolean; override;
    function IsInclude(ACode: TRECode): Boolean; override;
    {$IFDEF DEBUG}
    function GetStr: WideString; override;
    {$ENDIF}
  end;

  TREBinCode = class(TRECode)
  private
    FOp: TREOperator;
    FLeft: TRECode;
    FRight: TRECode;
    FGroupIndex, FMin, FMax: Integer;
    FMatchKind: TRELoopMatchKind;
    FNoBackTrack: Boolean;
    FGroupName: WideString;
    procedure SetGroupIndex(ATagNo: Integer);
    procedure SetMatchKind(const Value: TRELoopMatchKind);
    procedure SetNoBackTrack(const Value: Boolean);
    procedure SetGroupName(const Value: WideString);
  public
    constructor Create(ARegExp: TSkRegExp;
      AOp: TREOperator; ALeft, ARight: TRECode;
      AMin: Integer = 0; AMax: Integer = 0); overload;
    property Op: TREOperator read FOp;
    property Left: TRECode read FLeft;
    property Right: TRECode read FRight;
    property Min: Integer read FMin;
    property Max: Integer read FMax;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex;
    property GroupName: WideString read FGroupName write SetGroupName;
    property MatchKind: TRELoopMatchKind read FMatchKind write SetMatchKind;
    property NoBackTrack: Boolean read FNoBackTrack write SetNoBackTrack;
  end;

  TREParser = class
  private
    FRegExp: TSkRegExp;
    FOptionList: TList;
    FToken: TREToken;
    FGroupCount: Integer;
    FOptions: TREOptions;
    FP: PWideChar;
    FTopP: PWideChar;
    FWChar, FStartWChar, FLastWChar: TREChar;
    FMin, FMax: Integer;
    FContext: TREContextKind;
    FNewOptions: TREOptions;
    FUnicodeProperty: TUnicodeProperty;
    FConvert: Boolean;
    FNoBackTrack: Boolean;
    FGroupName: WideString;
  protected
    function NewBinCode(AOperator: TREOperator;
      ALeft, ARight: TRECode;
      AMin: Integer = 0;
      AMax: Integer = 0): TRECode;
    function NewCharClassCode(ANegative: Boolean): TRECode;
    procedure PushOptions;
    procedure PopOptions;
    procedure GetToken;
    function Term: TRECode;
    function Factor: TRECode;
    function Primay: TRECode;
    function RegExpr: TRECode;
    procedure ClearOptionList;
    procedure InternalClear;
    procedure CharNext(var P: PWideChar; const Len: Integer = 1);
    procedure CharPrev(var P: PWideChar; const Len: Integer = 1);
    procedure SkipWhiteSpace;
    function GetCompileErrorPos: Integer;
    procedure LexCharClass;
    procedure LexOption;
    function GetCtrlCode(var Len: Integer): TREChar;
    function GetDigit(var Len: Integer): Integer;
    function GetPropertyType(const AParam: WideString): TUnicodeProperty;
    function GetHexDigit(var Len: Integer): TREChar;
    procedure LexBrace;
    procedure LexProperty;
    procedure LexGroupName(Delimiter: TREChar);
    procedure LexNameReference;
    procedure LexEscChar;
  public
    constructor Create(ARegExp: TSkRegExp; const Expression: WideString);
    destructor Destroy; override;
    procedure Parse;
  end;

  TRENFACode = class
  private
    FKind: TRENFAKind;
    FCode: TRECode;
    FTransitTo: Integer;
    FNext: TRENFACode;
    FGroupIndex: Integer;
    FMin: Integer;
    FMax: Integer;
    FMatchKind: TRELoopMatchKind;
    FNoMatchTo: Integer;
    FGroupName: WideString;
    procedure SetCode(const Value: TRECode); 
    procedure SetNext(const Value: TRENFACode); 
    procedure SetTransitTo(const Value: Integer); 
    procedure SetKind(const Value: TRENFAKind); 
    procedure SetGroupIndex(const Value: Integer); 
    procedure SetMax(const Value: Integer); 
    procedure SetMin(const Value: Integer);
    procedure SetNoMatchTo(const Value: Integer); 
    procedure SetMatchKind(const Value: TRELoopMatchKind); 
    procedure SetGroupName(const Value: WideString);
  public
    property Code: TRECode read FCode write SetCode;
    property TransitTo: Integer read FTransitTo write SetTransitTo;
    property Next: TRENFACode read FNext write SetNext;
    property Kind: TRENFAKind read FKind write SetKind;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex;
    property GroupName: WideString read FGroupName write SetGroupName;
    property MatchKind: TRELoopMatchKind read FMatchKind write SetMatchKind;
    property NoMatchTo: Integer read FNoMatchTo write SetNoMatchTo;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    {$IFDEF DEBUG}
    function GetMatchTypeStr: WideString;
    {$ENDIF}
  end;

  TRENFA = class
  private
    FRegExp: TSkRegExp;
    FStateList: TList;
    FLeadCode,
    FTailCode: TObjectList;
    FBEntryState, FBExitState: Integer;
    FNoMatch: Boolean;
  protected
    function GetNumber: Integer; 
    procedure AddTransition(AKind: TRENFAKind;
      ATransFrom, ATransTo: Integer; ACode: TRECode);
    procedure GenerateStateList(ACode: TRECode;
      AEntry, AWayout: Integer);
    procedure ReplaceCode(var OldCode, NewCode: TRECode);
  public
    constructor Create(ARegExp: TSkRegExp);
    destructor Destroy; override;
    procedure Compile;
  end;

  TRECharTypeFunc = function(W: TREChar): Boolean of object;

  TSkRegExp = class
  private
    FCode: TRECode;
    FCodeList: TList;
    FBinCodeList: TList;
    FCompiled: Boolean;
    FTextTopP, FTextEndP: PWideChar;
    FEOL: WideString;
    FEOLHeadP,
    FEOLTailP: PWideChar;
    FEOLLen: Integer;
    FMatchData: TREMatchData;
    FInputString: WideString;
    FExpression: WideString;
    FCompileErrorPos: Integer;
    FOptions: TREOptions;
    //
    FStateList: TList;
    FEntryState, FExitState: Integer;
    FLeadCode,
    FTailCode: TObjectList;
    FTailStr: WideString;
    FIsPreMatch,
    FIsBehindNoMatch: Boolean;
    FNIsNewLine: Boolean;
    FNoBackTrack: Boolean;
    FRecursion: Boolean;
    FOnMatch: TNotifyEvent;
    {$IFDEF DEBUG}
    FStackCount: Integer;
    FStackMax: Integer;
    {$ENDIF}

    procedure SetExpression(const Value: WideString);
    procedure SetEOL(const Value: WideString);
    procedure SetInputString(const Value: WideString);
    function GetGroupCount: Integer;
    function GetVersion: WideString;
    function GetStyle: Integer;
    function GetOptions(const Index: Integer): Boolean;
    procedure SetOptions(const Index: Integer; const Value: Boolean);
    procedure SetNIsNewLine(const Value: Boolean);
    function GetMatchStr(Index: Integer): WideString;
    function GetMatchLen(Index: Integer): Integer;
    function GetMatchPos(Index: Integer): Integer;
    function GetNamedGroupStr(Name: WideString): WideString;
    function GetNamedGroupPos(Name: WideString): Integer;
    function GetNamedGroupLen(Name: WideString): Integer;
    function GetGroupNameFromIndex(Index: Integer): WideString;
    procedure SetOnMatch(const Value: TNotifyEvent);
    {$IFDEF JapaneseExt}
    procedure SetIgnoreZenHan(const Value: Boolean);
    function GetIgnoreZenHan: Boolean;
    {$ENDIF}
  protected
    IsWord: TRECharTypeFunc;
    IsDigit: TRECharTypeFunc;
    IsSpace: TRECharTypeFunc;
    IsHexDigit: TRECharTypeFunc;

    procedure ResetMatchData;
    procedure ClearCodeList;
    {FBinCodeListをクリアする。
    FBinCodeListはTREBinCodeのリスト。
    NFAを生成した後は不要なので、生成後呼び出してクリアする。}
    procedure ClearBinCodeList;
    {改行があった場合の位置補正用。
    AStrがFEOLと等しければTRUE。LenにはFEOLの長さが返る。
    等しくなければFALSEを返す。Lenの値はパラメータのまま。}
    function IsEOL(AStr: PWideChar; out Len: Integer): Boolean;
    procedure ClearStateList;
    procedure Error(const ErrorMes: WideString; AErrorPos: Integer);
    function CheckAheadMatchState(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
    function CheckBehindMatchState(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
    function CheckExitState(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
    function MatchCore(AStr: PWideChar): Boolean;
    function MatchLoop(NFACode: TRENFACode; var AStr: PWideChar): Boolean;
    function MatchPrim(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
    function NextState(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
    function PreMatch(var AStr: PWideChar): Boolean;

    procedure GenerateLeadCode;
    procedure GenerateTailCode;
    function IsAnkWord(W: TREChar): Boolean;
    function IsUnicodeWord(W: TREChar): Boolean;
    function IsAnkDigit(W: TREChar): Boolean;
    function IsUnicodeDigit(W: TREChar): Boolean;
    function IsAnkHexDigit(W: TREChar): Boolean;
    function IsUnicodeHexDigit(W: TREChar): Boolean;
    function IsAnkSpace(W: TREChar): Boolean;
    function IsUnicodeSpace(W: TREChar): Boolean;
    function IsLineSeparator(W: TREChar): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    {正規表現を構文解析し、NFAを生成する}
    procedure Compile;

    {最初のマッチを実行する}
    function Exec(const AInputStr: WideString): Boolean;
    {次のマッチを実行する}
    function ExecNext: Boolean;
    {AOffsetの位置からマッチを実行する}
    function ExecPos(AOffset: Integer = 1): Boolean;

    {以下はテスト不足のためドキュメントに記載していない}
    function Substitute(const ATemplate: WideString): WideString;
    function Replace(const AInputStr, AReplaceStr: WideString;
      IsReplaceAll: Boolean = True): WideString;
    procedure Split(const AInputStr: WideString; ADest: TREStrings);
    {ここまで}

    {$IFDEF DEBUG}
    procedure DumpParse(TreeView: TTreeView);
    procedure DumpNFA(ADest: TWideStrings);
    function DumpLeadCode: WideString;
    function DumpTailStr: WideString;
    {$ENDIF}

    {正規表現の文字列}
    property Expression: WideString read FExpression write SetExpression;
    {改行文字を設定。この設定はマッチ位置の補正用のみに使われる。
    マッチ時の改行文字の処理にはIsLineSeparatorを使う。}
    property EOL: WideString read FEOL write SetEOL;
    {グループの数を返す。グループは 0 から GroupCount まで。}
    property GroupCount: Integer read GetGroupCount;
    {検索対象の文字列}
    property InputString: WideString read FInputString write SetInputString;

    //正規表現オプション
    property IgnoreCase: Boolean index 0 read GetOptions write SetOptions;
    property MultiLine: Boolean index 1 read GetOptions write SetOptions;
    property NamedGroupOnly: Boolean index 2 read GetOptions write SetOptions;
    property SingleLine: Boolean index 3 read GetOptions write SetOptions;
    property Extended: Boolean index 4 read GetOptions write SetOptions;
    {$IFDEF JapaneseExt}
    property IgnoreWidth: Boolean index 5 read GetOptions write SetOptions;
    property IgnoreKana: Boolean index 6 read GetOptions write SetOptions;
    property DefinedCharClassLegacy: Boolean index 7 read GetOptions write SetOptions;
    property IgnoreZenHan: Boolean read GetIgnoreZenHan write SetIgnoreZenHan;
    {$ENDIF}

    property Match[Index: Integer]: WideString read GetMatchStr;
    property MatchPos[Index: Integer]: Integer read GetMatchPos;
    property MatchLen[Index: Integer]: Integer read GetMatchLen;

    property NamedGroup[Name: WideString]: WideString read GetNamedGroupStr;
    property NamedGroupPos[Name: WideString]: Integer read GetNamedGroupPos;
    property NamedGroupLen[Name: WideString]: Integer read GetNamedGroupLen;
    property GroupNameFromIndex[Index: Integer]: WideString read GetGroupNameFromIndex;

    property NIsNewLine: Boolean read FNIsNewLine write SetNIsNewLine;
    property Style: Integer read GetStyle;
    property Version: WideString read GetVersion;
    //Event
    property OnMatch: TNotifyEvent read FOnMatch write SetOnMatch;
    {$IFDEF DEBUG}
    property StackMax: Integer read FStackMax;
    {$ENDIF}
  end;

function ExecRegExp(const ARegExpStr, AInputStr: WideString;
  AOptions: TREOptions = []): Boolean;
function ReplaceRegExp(const ARegExpStr, AInputStr, AReplaceStr: WideString;
  IsReplaceAll: Boolean = True; AOptions: TREOptions = []): WideString;
procedure SplitRegExp(const ARegExpStr, AInputStr: WideString;
  APieces : TREStrings; AOptions: TREOptions = [] );

implementation

uses
  Windows,
  IniFiles;

resourcestring
  sSuccess = '成功';
  sSyntaxError = '構文エラー';
  sRightSmallParMissing = ')が必要です';
  sRightBigParMissing = ']が必要です';
  sEqualOrExclamationMissing = '=か!が必要です';
  sGroupNotFound = '対応するグループがありません';
  sHexDigitMissing = '16進数が必要です';
  sLoopCountOver = '繰り返し回数オーバー';
  sMaxIsSmallerThanMin = '最大値が最小値よりも小さい';
  sDigitMissing = '数値が必要です';
  sCharRangeWrong = 'キャラクタ範囲の指定が間違っています';
  sQuestPosInaccurate = '?の位置が不正';
  sLoopOfMatchAheadNotSpecified = '先読みの繰り返しは指定できません';
  sLoopOfLengthZeroCannotSpecified = '長さゼロの繰り返しはできません';
  sLeftSmallParMissing = '対応する(がありません';
  sRegExpNotCompleted = '正規表現が正しく終了していません';
  sOptionNotDefine = '未定義の修飾子です';
  sCommentNotCompleted = 'コメントが正しく終了していません';
  sOptionNotCompleted = '修飾子の指定が終了していません';
  sCharClassWorng       = '文字クラスに指定できない識別子です';
  sCharClassNotCompleted = '文字クラスが終了していません';

  sFatalError = '致命的エラー';
  sRegExpMissing = '正規表現が未指定';
  sLineHeadCannotLoop = '^は繰り返しできません';
  sLineEndCannotLoop = '$は繰り返しできません';
  sIndexRangeOver = 'インデックスが範囲を超えています';
  sExecFuncNotCall = 'Execが実行されていません';
  sEOLRangeOver = '改行文字に指定できるは2文字以内です';
  sPosixBracketNotCompleted = 'Posixブラケットの指定が間違っています';
  sPropertyNotDefine = '未定義のプロパティです';
  sRightCurlyBracketMissing = '}が必要です';
  sGroupNameNotDefine = 'グループ名%sは未定義です';
  sBehindMatchNotVariableLength = '戻り読み内で可変長文字列は使えません';
  sBehindMatchNotGroup = '戻り読み内でグループは使えません';
  sPropertyNameWrong = 'プロパティの指定が間違っています, GetCompileErrorPos);'#13;

const
  CONST_VERSION = '0.9.2';

  DefaultEOL: WideString = #$D#$A;

  {$IFDEF JapaneseExt}
  Dakuten     = $FF9E;
  Handakuten  = $FF9F;

  HanKanaToZenTable: array[$FF61..$FF9F, 0..2] of TREChar = (
    ($3002, $0, $0), ($300C, $0, $0), ($300D, $0, $0),
    ($3001, $0, $0), ($30FB, $0, $0), ($30F2, $0, $0),
    ($30A1, $0, $0), ($30A3, $0, $0), ($30A5, $0, $0),
    ($30A7, $0, $0), ($30A9, $0, $0), ($30E3, $0, $0),
    ($30E5, $0, $0), ($30E7, $0, $0), ($30C3, $0, $0),
    ($30FC, $0, $0), ($30A2, $0, $0), ($30A4, $0, $0),
    ($30A6, $30F4, $0), ($30A8, $0, $0), ($30AA, $0, $0),
    ($30AB, $30AC, $0), ($30AD, $30AE, $0), ($30AF, $30B0, $0),
    ($30B1, $30B2, $0), ($30B3, $30B4, $0), ($30B5, $30B6, $0),
    ($30B7, $30B8, $0), ($30B9, $30BA, $0), ($30BB, $30BC, $0),
    ($30BD, $30BE, $0), ($30BF, $30C0, $0), ($30C1, $30C2, $0),
    ($30C4, $30C5, $0), ($30C6, $30C7, $0), ($30C8, $30C9, $0),
    ($30CA, $0, $0), ($30CB, $0, $0), ($30CC, $0, $0),
    ($30CD, $0, $0), ($30CE, $0, $0), ($30CF, $30D0, $30D1),
    ($30D2, $30D3, $30D4), ($30D5, $30D6, $30D7), ($30D8, $30D9, $30DA),
    ($30DB, $30DC, $30DD), ($30DE, $0, $0), ($30DF, $0, $0),
    ($30E0, $0, $0), ($30E1, $0, $0), ($30E2, $0, $0),
    ($30E4, $0, $0), ($30E6, $0, $0), ($30E8, $0, $0),
    ($30E9, $0, $0), ($30EA, $0, $0), ($30EB, $0, $0),
    ($30EC, $0, $0), ($30ED, $0, $0), ($30EF, $0, $0),
    ($30F3, $0, $0), ($309B, $0, $0), ($309C, $0, $0)
  );

  HanAnkToZenTable: array[$0020..$007E] of TREChar = (
    $3000, $FF01, $FF02, $FF03, $FF04, $FF05, $FF06, $FF07, $FF08, $FF09,
    $FF0A, $FF0B, $FF0C, $FF0D, $FF0E, $FF0F, $FF10, $FF11, $FF12, $FF13,
    $FF14, $FF15, $FF16, $FF17, $FF18, $FF19, $FF1A, $FF1B, $FF1C, $FF1D,
    $FF1E, $FF1F, $FF20, $FF21, $FF22, $FF23, $FF24, $FF25, $FF26, $FF27,
    $FF28, $FF29, $FF2A, $FF2B, $FF2C, $FF2D, $FF2E, $FF2F, $FF30, $FF31,
    $FF32, $FF33, $FF34, $FF35, $FF36, $FF37, $FF38, $FF39, $FF3A, $FF3B,
    $005C, $FF3D, $FF3E, $FF3F, $FF40, $FF41, $FF42, $FF43, $FF44, $FF45,
    $FF46, $FF47, $FF48, $FF49, $FF4A, $FF4B, $FF4C, $FF4D, $FF4E, $FF4F,
    $FF50, $FF51, $FF52, $FF53, $FF54, $FF55, $FF56, $FF57, $FF58, $FF59,
    $FF5A, $FF5B, $FF5C, $FF5D, $FF5E
  );

  ZenHiraganaToKatakanaTable: array[$3041..$3094] of TREChar = (
    $30A1, $30A2, $30A3, $30A4, $30A5, $30A6, $30A7, $30A8, $30A9, $30AA,
    $30AB, $30AC, $30AD, $30AE, $30AF, $30B0, $30B1, $30B2, $30B3, $30B4,
    $30B5, $30B6, $30B7, $30B8, $30B9, $30BA, $30BB, $30BC, $30BD, $30BE,
    $30BF, $30C0, $30C1, $30C2, $30C3, $30C4, $30C5, $30C6, $30C7, $30C8,
    $30C9, $30CA, $30CB, $30CC, $30CD, $30CE, $30CF, $30D0, $30D1, $30D2,
    $30D3, $30D4, $30D5, $30D6, $30D7, $30D8, $30D9, $30DA, $30DB, $30DC,
    $30DD, $30DE, $30DF, $30E0, $30E1, $30E2, $30E3, $30E4, $30E5, $30E6,
    $30E7, $30E8, $30E9, $30EA, $30EB, $30EC, $30ED, $30EE, $30EF, $30F0,
    $30F1, $30F2, $30F3, $30F4
  );
  {$ENDIF}

  CONST_HEX_DIGIT_TWO   = 2;
  CONST_HEX_DIGIT_FOUR  = 4;

var
  PropertyNames: THashedStringList;

function ExecRegExp(const ARegExpStr, AInputStr: WideString;
  AOptions: TREOptions): Boolean;
var
  R: TSkRegExp;
begin
  R := TSkRegExp.Create;
  try
    R.FOptions := AOptions;
    R.Expression := ARegExpStr;
    Result := R.Exec(AInputStr);
  finally
    R.Free;
  end;
end;

function ReplaceRegExp(const ARegExpStr, AInputStr, AReplaceStr: WideString;
  IsReplaceAll: Boolean; AOptions: TREOptions): WideString;
var
  R: TSkRegExp;
begin
  R := TSkRegExp.Create;
  try
    R.FOptions := AOptions;
    R.Expression := ARegExpStr;
    Result := R.Replace(AInputStr, AReplaceStr, IsReplaceAll);
  finally
    R.Free;
  end;
end;

procedure SplitRegExp(const ARegExpStr, AInputStr: WideString;
  APieces : TREStrings; AOptions: TREOptions);
var
  R: TSkRegExp;
begin
  R := TSkRegExp.Create;
  try
    R.FOptions := AOptions;
    R.Expression := ARegExpStr;
    R.Split(AInputStr, APieces);
  finally
    R.Free;
  end;
end;

//==========サポートルーチン==========

{$IFDEF JapaneseExt}

{$IFDEF VER170}
function IsDaku(S: PWideChar): Boolean; inline;
{$ELSE}
function IsDaku(S: PWideChar): Boolean;
{$ENDIF}
begin
  Result := ((S + 1)^ = #$FF9E) and (HanKanaToZenTable[TREChar(S^), 1] <> 0);
end;

{$IFDEF VER170}
function IsHanDaku(S: PWideChar): Boolean; inline;
{$ELSE}
function IsHanDaku(S: PWideChar): Boolean;
{$ENDIF}
begin
  Result := ((S + 1)^ = #$FF9F) and (HanKanaToZenTable[TREChar(S^), 2] <> 0);
end;

{$IFDEF VER170}
function IsHanKana(S: TREChar): Boolean; inline;
{$ELSE}
function IsHanKana(S: TREChar): Boolean;
{$ENDIF}
begin
  Result := (S >= $FF61) and (S <= $FF9F);
end;

{$IFDEF VER170}
function IsZenHiragana(S: PWideChar): Boolean; inline;
{$ELSE}
function IsZenHiragana(S: PWideChar): Boolean;
{$ENDIF}
begin
  Result := (S^ >= #$3041) and (S^ <= #$3094);
end;

{$IFDEF VER170}
function IsHanAnk(S: TREChar): Boolean; inline;
{$ELSE}
function IsHanAnk(S: TREChar): Boolean;
{$ENDIF}
begin
  Result := (S >= $20) and (S <= $7E);
end;

{$ENDIF} //JapaneseExt Endif

function RESameStr(S1, S2: WideString): Boolean;
begin
  Result := WideSameStr(S1, S2);
end;

function GetREChar(AStr: PWideChar; var Len: Integer;
  Options: TREOptions): TREChar;
begin
  Result := 0;
  Len := 1;
  Result := TREChar(AStr^);

  {$IFDEF JapaneseExt}
  if roIgnoreWidth in Options then
  begin
    if IsHanAnk(Result) then
      Result := HanAnkToZenTable[Result]
    else if IsHanKana(Result) then
    begin
      if IsDaku(AStr) then
      begin
        Result := HanKanaToZenTable[Result, 1];
        Len := 2;
      end
      else if IsHanDaku(AStr) then
      begin
        Result := HanKanaToZenTable[Result, 2];
        Len := 2;
      end
      else
        Result := HanKanaToZenTable[Result, 0];
    end;
  end;

  if roIgnoreKana in Options then
  begin
    if ((Result >= $3041) and (Result <= $3094)) then
      Result := ZenHiraganaToKatakanaTable[Result]
    else if (Result  = $309D) then
      Result := $30FD
    else if Result = $309E then
      Result := $30FE
  end;
  {$ENDIF}

  if roIgnoreCase in Options then
  begin
    if Win32Platform = VER_PLATFORM_WIN32_NT then
      CharUpperBuffW(@Result, 1)
    else
      CharUpperBuffW(@Result, 1);
  end;
end;

{ TREMatchList }

procedure TREMatchData.Add(const AGroupName: WideString; AEntry, AWayout: Integer);
var
  P: PREMatchRec;
begin
  New(P);
  P.GroupName := AGroupName;
  P.Entry := AEntry;
  P.Wayout := AWayout;
  P.StartPBuf := nil;
  P.StartP := nil;
  P.EndP := nil;
  inherited Add(P);
end;

procedure TREMatchData.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Delete(I);
  inherited;
end;

procedure TREMatchData.Delete(Index: Integer);
var
  P: PREMatchRec;
begin
  P := Get(Index);
  Dispose(P);
  inherited;
end;

function TREMatchData.GetEndP(Index: Integer): PWideChar;
begin
  Result := PREMatchRec(Get(Index)).EndP;
end;

function TREMatchData.GetEntry(Index: Integer): Integer;
begin
  Result := PREMatchRec(Get(Index)).Entry;
end;

function TREMatchData.GetGroupName(Index: Integer): WideString;
begin
  Result := PREMatchRec(Get(Index)).GroupName;
end;

function TREMatchData.GetStartP(Index: Integer): PWideChar;
begin
  Result := PREMatchRec(Get(Index)).StartP
end;

function TREMatchData.IndexOfName(const AName: WideString): Integer;
var
  P: PREMatchRec;
begin
  for Result := 0 to Count - 1 do
  begin
    P := Get(Result);
    if (P.GroupName = AName) and (P.StartP <> nil) then
      Exit;
  end;
  Result := -1;
end;

procedure TREMatchData.Reset(AStr: PWideChar);
var
  I: Integer;
  P: PREMatchRec;
begin
  for I := Count - 1 downto 0 do
  begin
    P := Get(I);
    if P.EndP > AStr then
      P.StartP := nil;
  end;
end;

procedure TREMatchData.SetEndP(Index: Integer;
  const Value: PWideChar);
var
  P: PREMatchRec;
begin
  P := Get(Index);
  if P.StartPBuf <> nil then
    P.StartP := P.StartPBuf;
  P.EndP := Value;
end;

procedure TREMatchData.SetStartP(Index: Integer;
  const Value: PWideChar);
begin
  PREMatchRec(Get(Index)).StartPBuf := Value;
end;

{ TRECode }

{$WARNINGS OFF}
constructor TRECode.Create(ARegExp: TSkRegExp);
begin
  inherited Create;
  FRegExp := ARegExp;
end;

function TRECode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin

end;

{$IFDEF DEBUG}
function TRECode.GetStr: WideString;
begin

end;
{$ENDIF}

function TRECode.IsInclude(ACode: TRECode): Boolean;
begin

end;
{$WARNINGS ON}

{ TRECharCode }

constructor TRECharCode.Create(ARegExp: TSkRegExp; AWChar: TREChar;
  AOptions: TREOptions; AConvert: Boolean);
begin
  inherited Create(ARegExp);
  FWChar := AWChar;
  FOptions := AOptions;
  FConvert := AConvert;
end;

function TRECharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  W: TREChar;
begin
  W := GetREChar(AStr, Len, FOptions);
  Result := W = FWChar;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TRECharCode.GetStr: WideString;
var
  S: WideString;
begin
  if IsUnicodeProperty(FWChar, upCntrl) then
    Result := Format('文字($%x)', [FWChar])
  else
  begin
    S := WideChar(FWChar);
    Result := Format('文字 %s ($%x)', [S, FWChar]);
  end;
end;
{$ENDIF}

function TRECharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TRECharCode then
    Result := FWChar = (ACode as TRECharCode).FWChar
  else
    Result := False;
end;

{ TRERangeCharCode }

constructor TRERangeCharCode.Create(ARegExp: TSkRegExp; AStartWChar,
  ALastWChar: TREChar; AOptions: TREOptions);
begin
  inherited Create(ARegExp);
  FStartWChar := AStartWChar;
  FLastWChar := ALastWChar;
  FOptions := AOptions;
end;

function TRERangeCharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  W: TREChar;
begin
  W := GetREChar(AStr, Len, FOptions);
  Result := (W >= FStartWChar) and (W <= FLastWChar);
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TRERangeCharCode.GetStr: WideString;
var
  S1, S2: WideString;
begin
  if IsUnicodeProperty(FStartWChar, upCntrl) then
    S1 := Format('($%x)', [FStartWChar])
  else
  begin
    S1 := WideChar(FStartWChar);
    S1 := Format('%s ($%x)', [S1, FStartWChar]);
  end;

  if IsUnicodeProperty(FLastWChar, upCntrl) then
    S2 := Format('($%x)', [FLastWChar])
  else
  begin
    S2 := WideChar(FLastWChar);
    S2 := Format('%s ($%x)', [S2, FLastWChar]);
  end;

  Result := Format('%s ～ %s', [S1, S2]); 
end;
{$ENDIF}

function TRERangeCharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TRECharCode then
    Result := (FStartWChar >= (ACode as TRECharCode).FWChar) and
      (FLastWChar <= (ACode as TRECharCode).FWChar)
  else if ACode is TRERangeCharCode then
    Result := (FStartWChar >= (ACode as TRERangeCharCode).FStartWChar) and
      (FLastWChar <= (ACode as TRERangeCharCode).FLastWChar)
  else
    Result := False;
end;

{ TREAnyCharCode }

constructor TREAnyCharCode.Create(ARegExp: TSkRegExp; AOptions: TREOptions);
begin
  inherited Create(ARegExp);
  FOptions := AOptions;
end;

function TREAnyCharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  W: TREChar;
  L: Integer;
begin
  Result := False;
  Len := 0;
  if FRegExp.FTextEndP = AStr then
    Exit;

  if (roSingleLine in FOptions) then
  begin
    while FRegExp.IsLineSeparator(GetREChar(AStr, L, FOptions)) do
    begin
      Result := True;
      Inc(AStr, L);
      Inc(Len, L);
    end;

    if not Result then
      Result := AStr <> FRegExp.FTextEndP;
  end
  else
  begin
    W := GetREChar(AStr, Len, FOptions);
    Result := not FRegExp.IsLineSeparator(W);
  end;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TREAnyCharCode.GetStr: WideString;
begin
  Result := '任意の文字';
end;
{$ENDIF}

function TREAnyCharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TREAnyCharCode then
    Result := True
  else
    Result := False;
end;

{ TREWordCharCode }

constructor TREWordCharCode.Create(ARegExp: TSkRegExp; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FNegative := ANegative;
end;

function TREWordCharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Result := False;
  Len := 0;

  if AStr = FRegExp.FTextEndP then
    Exit;

  Result := FRegExp.IsWord(GetREChar(AStr, Len, []));

  if FNegative then
    Result := not Result;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TREWordCharCode.GetStr: WideString;
begin
  if not FNegative then
    Result := '単語文字'
  else
    Result := '非単語文字';
end;
{$ENDIF}

function TREWordCharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TREWordCharCode then
    Result := (ACode as TREWordCharCode).FNegative = FNegative
  else if ACode is TREDigitCharCode then
  begin
    if FNegative then
      Result := (ACode as TREDigitCharCode).FNegative
    else
      Result := not (ACode as TREDigitCharCode).FNegative;
  end
  else if ACode is TRECharCode then
  begin
    Result := FRegExp.IsWord((ACode as TRECharCode).FWChar);
    if FNegative then
      Result := not Result;
  end
  else if ACode is TRERangeCharCode then
  begin
    Result := FRegExp.IsWord((ACode as TRERangeCharCode).FStartWChar) and
      FRegExp.IsWord((ACode as TRERangeCharCode).FLastWChar);
    if FNegative then
      Result := not Result;
  end
  else
    Result := False;
end;

{ TREDigitCharCode }

constructor TREDigitCharCode.Create(ARegExp: TSkRegExp; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FNegative := ANegative;
end;

function TREDigitCharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Result := False;
  Len := 0;
  if AStr = FRegExp.FTextEndP then
    Exit;

  Result := FRegExp.IsDigit(GetREChar(AStr, Len, []));
  if FNegative then
    Result := not Result;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TREDigitCharCode.GetStr: WideString;
begin
  if not FNegative then
    Result := '数字文字'
  else
    Result := '非数字文字';
end;
{$ENDIF}

function TREDigitCharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TREDigitCharCode then
    Result := FNegative and (ACode as TREDigitCharCode).FNegative
  else if ACode is TRECharCode then
  begin
    Result := FRegExp.IsDigit((ACode as TRECharCode).FWChar);
    if FNegative then
      Result := not Result;
  end
  else if ACode is TRERangeCharCode then
  begin
    Result := FRegExp.IsDigit((ACode as TRERangeCharCode).FStartWChar) and
      FRegExp.IsDigit((ACode as TRERangeCharCode).FLastWChar);
    if FNegative then
      Result := not Result;
  end
  else
    Result := False;
end;

{ TREHexDigitCharCode }

constructor TREHexDigitCharCode.Create(ARegExp: TSkRegExp; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FNegative := ANegative;
end;

function TREHexDigitCharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Result := False;
  Len := 0;
  if AStr = FRegExp.FTextEndP then
    Exit;

  Result := FRegExp.IsHexDigit(GetREChar(AStr, Len, []));
  if FNegative then
    Result := not Result;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TREHexDigitCharCode.GetStr: WideString;
begin
  if not FNegative then
    Result := '16進数文字'
  else
    Result := '非16進数文字';
end;
{$ENDIF}

function TREHexDigitCharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TREHexDigitCharCode then
    Result := FNegative and (ACode as TREHexDigitCharCode).FNegative
  else if ACode is TRECharCode then
  begin
    Result := FRegExp.IsHexDigit((ACode as TRECharCode).FWChar);
    if FNegative then
      Result := not Result;
  end
  else if ACode is TRERangeCharCode then
  begin
    Result := FRegExp.IsDigit((ACode as TRERangeCharCode).FStartWChar) and
      FRegExp.IsHexDigit((ACode as TRERangeCharCode).FLastWChar);
    if FNegative then
      Result := not Result;
  end
  else if ACode is TREWordCharCode then
    Result := FNegative and (ACode as TREHexDigitCharCode).FNegative
  else
    Result := False;
end;

{ TRESpaceCharCode }

constructor TRESpaceCharCode.Create(ARegExp: TSkRegExp; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FNegative := ANegative;
end;

function TRESpaceCharCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Result := False;
  Len := 0;
  if AStr = FRegExp.FTextEndP then
    Exit;

  Result := FRegExp.IsSpace(GetREChar(AStr, Len, []));
  if FNegative then
    Result := not Result;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TRESpaceCharCode.GetStr: WideString;
begin
  if not FNegative then
    Result := '空白文字'
  else
    Result := '非空白文字';
end;
{$ENDIF}

function TRESpaceCharCode.IsInclude(ACode: TRECode): Boolean;
begin
  if ACode is TRESpaceCharCode then
    Result := FNegative = (ACode as TRESpaceCharCode).FNegative
  else if ACode is TRECharCode then
  begin
    Result := FRegExp.IsSpace((ACode as TRECharCode).FWChar);
    if FNegative then
      Result := not Result;
  end
  else if ACode is TRERangeCharCode then
    Result := FRegExp.IsSpace((ACode as TRERangeCharCode).FStartWChar) and
      FRegExp.IsSpace((ACode as TRERangeCharCode).FLastWChar)
  else
    Result := False;
end;

{ TRECharClassCode }

function TRECharClassCode.Add(AStartWChar, ALastWChar: TREChar;
  AOptions: TREOptions): Integer;
begin
  if (roIgnoreCase in AOptions) then
  begin
    if (IsUnicodeProperty(AStartWChar, upUpper) and
      IsUnicodeProperty(ALastWChar, upUpper)) or
      (IsUnicodeProperty(AStartWChar, upLower) and
      IsUnicodeProperty(ALastWChar, upLower)) then
    begin
      CharUpperBuffW(@AStartWChar, 1);
      CharUpperBuffW(@ALastWChar, 1);
    end
    else
      Exclude(AOptions, roIgnoreCase);
  end;
  Result := FCodeList.Add(
    TRERangeCharCode.Create(FRegExp, AStartWChar, ALastWChar, AOptions));
end;

function TRECharClassCode.Add(AWChar: TREChar;
  AOptions: TREOptions): Integer;
begin
  Result := FCodeList.Add(TRECharCode.Create(FRegExp, AWChar, AOptions));
end;

function TRECharClassCode.Add(Value: TRECode): Integer;
begin
  Result := FCodeList.Add(Value);
end;

constructor TRECharClassCode.Create(ARegExp: TSkRegExp; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FCodeList := TObjectList.Create;
  FNegative := ANegative;
end;

destructor TRECharClassCode.Destroy;
begin
  FCodeList.Free;
  inherited;
end;

function TRECharClassCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  I, L: Integer;
begin
  Len := 0;
  if not FNegative then
  begin
    Result := False;
    for I := 0 to FCodeList.Count - 1 do
    begin
      if (FCodeList[I] as TRECode).Equals(AStr, Len) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end
  else
  begin
    for I := 0 to FCodeList.Count - 1 do
    begin
      if (FCodeList[I] as TRECode).Equals(AStr, L) then
      begin
        Result := False;
        Exit;
      end;
    end;

    if FRegExp.FTextEndP = AStr Then
    begin
      Result := False;
      Exit;
    end;

    GetREChar(AStr, Len, []);

    Result := True;
  end;
end;

{$IFDEF DEBUG}
function TRECharClassCode.GetStr: WideString;
var
  I: Integer;
begin
  Result := '範囲 ';
  for I := 0 to FCodeList.Count - 1 do
    if I > 0 then
      Result := Result + ', ' + (FCodeList[I] as TRECode).GetStr
    else
      Result := Result + (FCodeList[I] as TRECode).GetStr;
end;
{$ENDIF}

function TRECharClassCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := False;
end;

procedure TRECharClassCode.Rebuild;

  procedure RebuildSub(Index: Integer);
  var
    Source, Dest: TRECode;
    I: Integer;
  begin
    Source := FCodeList[Index] as TRECode;
    for I := FCodeList.Count - 1 downto 0 do
    begin
      if I <> Index then
      begin
        Dest := FCodeList[I] as TRECode;
//        if SameCode(Source, Dest) then
        if Source.IsInclude(Dest) then
          FCodeList.Delete(I);
      end;
    end;
  end;

var
  I: Integer;
begin
  I := 0;

  while I < FCodeList.Count do
  begin
    RebuildSub(I);
    Inc(I);
  end;
end;

{ TRECombiningSequence }

function TRECombiningSequence.Equals(AStr: PWideChar;
  var Len: Integer): Boolean;
var
  SubLen, L: Integer;
begin
  Result := False;
  Len := 0;
  SubLen := 0;

  if not IsUnicodeProperty(GetREChar(AStr, L, []), upM) then
  begin
    SubLen := L;
    repeat
      Inc(AStr, L);
      if IsUnicodeProperty(GetREChar(AStr, L, []), upM) then
      begin
        Inc(AStr, L);
        Inc(SubLen, L);
        Result := True;
      end
      else
        Break;
    until AStr >= FRegExp.FTextEndP;
  end;
  if Result then
    Len := SubLen;
end;

{$IFDEF DEBUG}
function TRECombiningSequence.GetStr: WideString;
begin
  Result := '継続文字';
end;
{$ENDIF}

function TRECombiningSequence.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRECombiningSequence;
end;

{ TRENewLineCode }

function TRENewLineCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Len := 0;
  Result := FRegExp.IsEOL(AStr, Len);
end;

{$IFDEF DEBUG}
function TRENewLineCode.GetStr: WideString;
begin
  Result := '改行';
end;
{$ENDIF}

function TRENewLineCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRENewLineCode;
end;

{ TREBoundaryCode }

constructor TREBoundaryCode.Create(ARegExp: TSkRegExp; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FNegative := ANegative;
end;

function TREBoundaryCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  PrevType, CurType: Boolean;
  L: Integer;
begin
  Len := 0;

  if not FNegative then
  begin
    if AStr = FRegExp.FTextTopP then
      PrevType := False
    else
    begin
      Dec(AStr);

      PrevType := FRegExp.IsWord(GetREChar(AStr, L, []));

      Inc(AStr);
    end;

    if AStr = FRegExp.FTextEndP then
      CurType := False
    else
      CurType := FRegExp.IsWord(GetREChar(AStr, L, []));

    Result := PrevType <> CurType;
  end
  else
  begin
    if AStr <> FRegExp.FTextTopP then
    begin
      Dec(AStr);

      PrevType := not FRegExp.IsWord(GetREChar(AStr, L, []));

      Inc(AStr);
    end
    else
      PrevType := True;

    if AStr <> FRegExp.FTextEndP then
      CurType := not FRegExp.IsWord(GetREChar(AStr, L, []))
    else
      CurType := True;

    Result := PrevType = CurType;
  end;
end;

{$IFDEF DEBUG}
function TREBoundaryCode.GetStr: WideString;
begin
  if not FNegative then
    Result := '単語境界'
  else
    Result := '非単語境界';
end;
{$ENDIF}

function TREBoundaryCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TREBoundaryCode;
end;

{ TREReferenceCode }

constructor TREReferenceCode.Create(ARegExp: TSkRegExp;
  AGroupIndex: Integer; AOptions: TREOptions);
begin
  inherited Create(ARegExp);
  FGroupIndex := AGroupIndex;
  FOptions := AOptions;
end;

function TREReferenceCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  S: WideString;
  ARefTagNo, Style, Start, L: Integer;
  SubStartP, SubEndP: PWideChar;
begin
  Result := False;
  Len := 0;

  ARefTagNo := FGroupIndex;

  if ARefTagNo > FRegExp.GroupCount then
    Exit;

  if FRegExp.FMatchData.StartP[ARefTagNo] = nil then
    Exit;

  SubStartP := FRegExp.FMatchData.StartP[ARefTagNo];
  SubEndP := FRegExp.FMatchData.EndP[ARefTagNo];
  if SubEndP > AStr then
  begin
    FRegExp.FMatchData.EndP[ARefTagNo] := AStr - 1;
    SubEndP := FRegExp.FMatchData.EndP[ARefTagNo];
  end;

  Start := SubStartP - FRegExp.FTextTopP;
  L := SubEndP - SubStartP;
  if L = 0 then
  begin
    Result := True;
    Exit;
  end;

  S := Copy(FRegExp.InputString, Start + 1, L);

  Style := 0;
  if roIgnoreCase in FOptions then
    Style := Style or NORM_IGNORECASE;
  if roIgnoreWidth in FOptions then
    Style := Style or NORM_IGNOREWIDTH;
  if roIgnoreKana in FOptions then
    Style := Style or NORM_IGNOREKANATYPE;

  Result := CompareStringW(LOCALE_USER_DEFAULT, Style,
    AStr, Length(S), PWideChar(S), Length(S)) - 2 = 0;

  if Result then
    Len := Length(S);
end;

{$IFDEF DEBUG}
function TREReferenceCode.GetStr: WideString;
begin
  Result := Format('グループ%d参照', [FGroupIndex]);
end;
{$ENDIF}

function TREReferenceCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TREReferenceCode;
  if Result then
    Result := (ACode as TREReferenceCode).FGroupIndex = FGroupIndex;
end;

{ TRENameReferenceCode }

constructor TRENameReferenceCode.Create(ARegExp: TSkRegExp;
  AGroupName: WideString; AOptions: TREOptions);
begin
  inherited Create(ARegExp);
  FGroupName := AGroupName;
  FOptions := AOptions;
end;

function TRENameReferenceCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  S: WideString;
  Index, Style, Start, L: Integer;
  SubStartP, SubEndP: PWideChar;
begin
  Len := 0;

  Index := FRegExp.FMatchData.IndexOfName(FGroupName);
  if Index = -1 then
    FRegExp.Error(Format(sGroupNameNotDefine, [FGroupName]), 0);

  SubStartP := FRegExp.FMatchData.StartP[Index];
  SubEndP := FRegExp.FMatchData.EndP[Index];
  if SubEndP > AStr then
  begin
    FRegExp.FMatchData.EndP[Index] := AStr - 1;
    SubEndP := FRegExp.FMatchData.EndP[Index];
  end;

  Start := SubStartP - FRegExp.FTextTopP;
  L := SubEndP - SubStartP;
  if L = 0 then
  begin
    Result := True;
    Exit;
  end;

  S := Copy(FRegExp.InputString, Start + 1, L);

  Style := 0;
  if roIgnoreCase in FOptions then
    Style := Style or NORM_IGNORECASE;
  if roIgnoreWidth in FOptions then
    Style := Style or NORM_IGNOREWIDTH;
  if roIgnoreKana in FOptions then
    Style := Style or NORM_IGNOREKANATYPE;

  Result := CompareStringW(LOCALE_USER_DEFAULT, Style,
    AStr, Length(S), PWideChar(S), Length(S)) - 2 = 0;

  if Result then
    Len := Length(S);
end;

{$IFDEF DEBUG}
function TRENameReferenceCode.GetStr: WideString;
begin
  Result := Format('グループ"%s"参照', [FGroupName]);
end;
{$ENDIF}

function TRENameReferenceCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRENameReferenceCode;
  if Result then
    Result := (ACode as TRENameReferenceCode).FGroupName = FGroupName;
end;

{ TRELineHeadCode }

constructor TRELineHeadCode.Create(ARegExp: TSkRegExp; AOptions: TREOptions);
begin
  inherited Create(ARegExp);
  FOptions := AOptions;
end;

function TRELineHeadCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  L: Integer;
begin
  Len := 0;

  if roMultiLine in FOptions then
  begin
    if (AStr = FRegExp.FTextTopP) then
      Result := True
    else
    begin
      Dec(AStr);
      Result := FRegExp.IsLineSeparator(GetREChar(AStr, L, []));
    end;
  end
  else
    Result := AStr = FRegExp.FTextTopP;
end;

{$IFDEF DEBUG}
function TRELineHeadCode.GetStr: WideString;
begin
  Result := '行頭'
end;
{$ENDIF}

function TRELineHeadCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRELineHeadCode;
end;

{ TRELineTailCode }

constructor TRELineTailCode.Create(ARegExp: TSkRegExp; AOptions: TREOptions);
begin
  inherited Create(ARegExp);
  FOptions := AOptions;
end;

function TRELineTailCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  L: Integer;
begin
  Len := 0;
  if roMultiLine in FOptions then
  begin
    if (AStr = FRegExp.FTextEndP) then
      Result := True
    else
      Result := FRegExp.IsLineSeparator(GetREChar(AStr, L, []));
  end
  else
    Result := AStr = FRegExp.FTextEndP;
end;

{$IFDEF DEBUG}
function TRELineTailCode.GetStr: WideString;
begin
  Result := '行末';
end;
{$ENDIF}

function TRELineTailCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRELineTailCode;
end;

{ TRETextHeadCode }

function TRETextHeadCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Len := 0;
  Result := FRegExp.FTextTopP = AStr;
end;

{$IFDEF DEBUG}
function TRETextHeadCode.GetStr: WideString;
begin
  Result := '先頭';
end;
{$ENDIF}

function TRETextHeadCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRETextHeadCode;
end;

{ TRETextTailCode }

function TRETextTailCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  L: Integer;
begin
  Len := 0;

  while FRegExp.IsLineSeparator(GetREChar(AStr, L, [])) do
    Inc(AStr, L);

  Result := FRegExp.FTextEndP = AStr;
end;

{$IFDEF DEBUG}
function TRETextTailCode.GetStr: WideString;
begin
  Result := '末尾';
end;
{$ENDIF}

function TRETextTailCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRETextTailCode;
end;

{ TRETextEndCode }

function TRETextEndCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
begin
  Len := 0;
  Result := FRegExp.FTextEndP = AStr;
end;

{$IFDEF DEBUG}
function TRETextEndCode.GetStr: WideString;
begin
  Result := '終端';
end;
{$ENDIF}

function TRETextEndCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := ACode is TRETextEndCode;
end;

{ TREPosixCode }

constructor TREPropertyCode.Create(ARegExp: TSkRegExp;
  AUnicodeProperty: TUnicodeProperty; ANegative: Boolean);
begin
  inherited Create(ARegExp);
  FUniCodeProperty:= AUnicodeProperty;
  FNegative := ANegative;
end;

function TREPropertyCode.Equals(AStr: PWideChar; var Len: Integer): Boolean;
var
  W: TREChar;
begin
  W := GetREChar(AStr, Len, []);
  Result := IsUnicodeProperty(W, FUniCodeProperty);
  if FNegative then
    Result := not Result;
  if not Result then
    Len := 0;
end;

{$IFDEF DEBUG}
function TREPropertyCode.GetStr: WideString;
begin
  if not FNegative then
    Result := 'Posixブラケット'
  else
    Result := '否定Posixブラケット'
end;
{$ENDIF}

function TREPropertyCode.IsInclude(ACode: TRECode): Boolean;
begin
  Result := (ACode is TREPropertyCode) and
    ((ACode as TREPropertyCode).FUniCodeProperty = FUniCodeProperty);
end;

{ TREBinCode }

constructor TREBinCode.Create(ARegExp: TSkRegExp; AOp: TREOperator; ALeft,
  ARight: TRECode; AMin, AMax: Integer);
begin
  inherited Create(ARegExp);
  FOp:= AOp;
  FLeft := ALeft;
  FRight := ARight;
  FMin := AMin;
  FMax := AMax;
  FMatchKind := lmNormal;
  FNoBackTrack := False;
end;

procedure TREBinCode.SetGroupName(const Value: WideString);
begin
  FGroupName := Value;
end;

procedure TREBinCode.SetMatchKind(const Value: TRELoopMatchKind);
begin
  FMatchKind := Value;
end;

procedure TREBinCode.SetNoBackTrack(const Value: Boolean);
begin
  FNoBackTrack := Value;
end;

procedure TREBinCode.SetGroupIndex(ATagNo: Integer);
begin
  FGroupIndex := ATagNo;
end;

{ TREParser }

procedure TREParser.CharNext(var P: PWideChar; const Len: Integer);
begin
  Inc(P, Len);
  if roExtended in FOptions then
    while (P^ <> #0) and ((P^ = ' ') or (P^ = #9) or (P^ = #10) or (P^ = #13)) do
      Inc(P);
end;

procedure TREParser.CharPrev(var P: PWideChar; const Len: Integer);
begin
  Dec(P, Len);
  if roExtended in FOptions then
    while (P^ <> #0) and ((P^ = ' ') or (P^ = #9) or (P^ = #10) or (P^ = #13)) do
      Dec(P);
end;

procedure TREParser.InternalClear;
begin
  FRegExp.ClearCodeList;
  FRegExp.ClearBinCodeList;
  FOptions := FRegExp.FOptions;
  ClearOptionList;
  FGroupCount := 0;
end;

procedure TREParser.ClearOptionList;
var
  I: Integer;
  P: PREOptions;
begin
  for I := 0 to FOptionList.Count - 1 do
    if FOptionList[I] <> nil then
    begin
      P := FOptionList[I];
      Dispose(P);
    end;
  FOptionList.Clear;
end;

constructor TREParser.Create(ARegExp: TSkRegExp; const Expression: WideString);
begin
  inherited Create;
  FOptionList := TList.Create;
  FRegExp := ARegExp;
  FOptions := FRegExp.FOptions;
  FP := PWideChar(Expression);
  FTopP := FP;
end;

destructor TREParser.Destroy;
begin
  ClearOptionList;
  FOptionList.Free;
  inherited;
end;

function TREParser.Factor: TRECode;

  procedure SetMinMatch(BinCode: TRECode);
  begin
    if not (BinCode is TREBinCode) then
      FRegExp.Error(sQuestPosInaccurate, GetCompileErrorPos);

    (BinCode as TREBinCode).MatchKind := lmMin;
  end;

  procedure SetMaxMatch(BinCode: TRECode);
  begin
    if not (BinCode is TREBinCode) then
      FRegExp.Error(sQuestPosInaccurate, GetCompileErrorPos);

    (BinCode as TREBinCode).MatchKind := lmMax;
  end;

  procedure CheckAheadMatch(ACode: TRECode);
  begin
    if ACode is TREBinCode then
    begin
      with ACode as TREBinCode do
      begin
        if (FOp = opAheadMatch) or (FOp = opAheadNoMatch) then
          FRegExp.Error(sLoopOfMatchAheadNotSpecified, GetCompileErrorPos);
      end;
    end;
  end;

  procedure CheckEmptyLoop(ACode: TRECode);
  begin
    if (ACode is TREBoundaryCode) or (ACode is TRETextHeadCode) or
        (ACode is TRETextTailCode) or (ACode is TRETextEndCode) then
      FRegExp.Error(sLoopOfLengthZeroCannotSpecified, GetCompileErrorPos);
  end;

begin
  Result := Primay;

  if FToken in [tkStar, tkPlus, tkQuest, tkBound] then
  begin
    CheckAheadMatch(Result);
    CheckEmptyLoop(Result);
    case FToken of
      tkStar:
        Result := NewBinCode(opStar, Result, nil);
      tkPlus:
        Result := NewBinCode(opPlus, Result, nil);
      tkQuest:
        Result := NewBinCode(opQuest, Result, nil);
      tkBound:
        Result := NewBinCode(opBound, Result, nil, FMin, FMax);
    end;
    if FNoBackTrack then
      SetMaxMatch(Result);

    GetToken;
    if FToken in [tkQuest, tkPlus] then
    begin
      if FToken = tkQuest then
      SetMinMatch(Result)
      else if FToken = tkPlus then
        SetMaxMatch(Result);
      GetToken;
    end;
  end;
end;

function TREParser.GetCompileErrorPos: Integer;
begin
  if FP <> nil then
    Result := FP - FTopP + 1
  else
    Result := 0;
end;

function TREParser.GetCtrlCode(var Len: Integer): TREChar;
var
  P: PWideChar;
begin
  Result := 0;
  CharNext(FP);
  P := FP;
  if (P^ >= #$0) and (P^ <= #$7F) then
  begin
    Result := TREChar(P^);
    if (Result >= TREChar('a')) and (Result <= TREChar('z')) then
      Dec(Result, $20);
    Result := Result xor $40;
  end
  else
    Len := 0;
end;

function TREParser.GetDigit(var Len: Integer): Integer;
var
  P: PWideChar;
begin
  P := FP;
  Result := 0;

  while (P^ >= '0') and (P^ <= '9') do
  begin
    Result := Result * 10 + (Integer(P^) - Integer('0'));
    CharNext(P);
  end;
  Len := P - FP;
end;

function TREParser.GetHexDigit(var Len: Integer): TREChar;
var
  P: PWideChar;
  I: Integer;
begin
  Result := 0;
  CharNext(FP);
  P := FP;

  if FRegExp.IsAnkHexDigit(TREChar(P^)) then
  begin
    for I := 1 to Len do
    begin
      if (P^ >= '0') and (P^ <= '9') then
        Result := (Result * 16) + (Integer(P^) - Integer('0'))
      else if (P^ >= 'A') and (P^ <= 'F') then
        Result := (Result * 16) + (Integer(P^) - Integer('7'))
      else if (P^ >= 'a') and (P^ <= 'f') then
        Result := (Result * 16) + (Integer(P^) - Integer('W'))
      else
        FRegExp.Error(sHexDigitMissing, GetCompileErrorPos);

      CharNext(P);
    end;
  end
  else
    Len := 0;
end;

{$WARNINGS OFF}
function TREParser.GetPropertyType(
  const AParam: WideString): TUnicodeProperty;
var
  I: Integer;
begin
  if PropertyNames.Find(AParam, I) then
    Result := TUnicodeProperty(PropertyNames.Objects[I])
  else
    FRegExp.Error(sPropertyNotDefine, GetCompileErrorPos);
end;
{$WARNINGS ON}

procedure TREParser.GetToken;
var
  L: Integer;
begin
  FConvert := False;
  FWChar := 0;
  FStartWChar := 0;
  FLastWChar := 0;
  FMin := 0;
  FMax := 0;
  FGroupName := '';

  L := 1;

  if roExtended in FOptions then
    SkipWhiteSpace;

  if FP^ = #0 then
  begin
    if FContext <> ctNormal then
      FRegExp.Error(sRightBigParMissing, GetCompileErrorPos);

    FToken := tkEnd;
    Exit;
  end;

  if FContext = ctCharClass then
  begin
    if FP^ = ']' then
    begin
      if (FP + 1)^ <> ']' then
      begin
        FToken := tkCharClassEnd;
        FContext := ctNormal;
        CharNext(FP, 1);
      end
      else
      begin
        FWChar := TREChar(']');
        FToken := tkChar;
        CharNext(FP, 1);
      end;
    end
    else
      LexCharClass;
  end
  else
  begin
    case FP^ of
      '|':
        FToken := tkUnion;
      '(':
      begin
        CharNext(FP);
        if FP^ = '?' then
        begin
          CharNext(FP);
          case FP^ of
            '-', 'i', 'm', 'n', 's', 'x', 'w', 'k':
              LexOption;
            '#':
            begin
              CharNext(FP);
              while FP^ <> #0 do
              begin
                if FP^ = ')' then
                begin
                  CharNext(FP);
                  GetToken;
                  Exit;
                end;
                CharNext(FP);
              end;
              //FRegExp.Error(sCommentNotCompleted, GetCompileErrorPos);
            end;
            '>':
              FToken := tkNoBackTrack;
            ':':
              FToken := tkLPar;
            '=':
              FToken := tkAheadMatch;
            '!':
              FToken := tkAheadNoMatch;
            '''':
            begin
              LexGroupName(TREChar(''''));
              Exit;
            end;
            '<':
            begin
              CharNext(FP);
              if FP^ = '=' then
                FToken := tkBehindMatch
              else if FP^ = '!' then
                FToken := tkBehindNoMatch
              else if FRegExp.IsAnkWord(TREChar(FP^)) then
              begin
                LexGroupName(TREChar('>'));
                Exit;
              end
              else
                FRegExp.Error(sEqualOrExclamationMissing, GetCompileErrorPos);
            end;
            else
            begin
              FWChar := TREChar('?');
              FToken := tkChar;
            end;
          end;
        end
        else
        begin
          CharPrev(FP);
          if not (roNamedGroupOnly in FOptions) then
            FToken := tkGroupStart
          else
            FToken := tkLPar;
        end;
      end;
      ')':
        FToken := tkRPar;
      '*':
        FTOken := tkStar;
      '+':
        FToken := tkPlus;
      '?':
        FToken := tkQuest;
      '.':
        FToken := tkDot;
      '\':
      begin
        LexEscChar;
        Exit;
      end;
      '[':
      begin
        CharNext(FP);
        if FP^ = '^' then
        begin
          FContext := ctCharClass;
          FToken := tkNegativeCharClassFirst;
        end
        else
        begin
          CharPrev(FP);
          FContext := ctCharClass;
          FToken := tkCharClassFirst;
        end;
      end;
      '{':
      begin
        LexBrace;
        Exit;
      end;
      '^':
      begin
        FWChar := TREChar('^');
        FConvert := True;
        FToken := tkChar;
      end;
      '$':
      begin
        FWChar := TREChar('$');
        FConvert := True;
        FToken := tkChar;
      end;
      else
      begin
        FWChar := GetREChar(FP, L, FOptions);
        FToken := tkChar;
      end;
    end;
    CharNext(FP, L);
  end;
end;

procedure TREParser.LexBrace;
var
  I, L: Integer;
begin
  CharNext(FP);  
  SkipWhiteSpace;
  if (FP^ >= '0') and (FP^ <= '9') then
  begin
    I := GetDigit(L);
    CharNext(FP, L);

    if I > $FFFF then
      FRegExp.Error(sLoopCountOver, GetCompileErrorPos);

    FMin := I;

    if FP^ = ',' then
    begin
      CharNext(FP);
      SkipWhiteSpace;
      if (FP^ >= '0') and (FP^ <= '9') then
      begin
        I := GetDigit(L);
        CharNext(FP, L);

        if I > $FFFF then
          FRegExp.Error(sLoopCountOver, GetCompileErrorPos);

        if I < FMin then
          FRegExp.Error(sMaxIsSmallerThanMin, GetCompileErrorPos);

        FMax := I;
      end
      else
        FMax := 0;
    end
    else
      FMax := FMin;
  end
  else
    FRegExp.Error(sDigitMissing, GetCompileErrorPos);

  if FP^ <> '}' then
    FRegExp.Error(sRightBigParMissing, GetCompileErrorPos);

  CharNext(FP, L);
  FToken := tkBound;
end;

procedure TREParser.LexCharClass;

  {$WARNINGS OFF}
  function GetPosixType(const S: WideString): TUnicodeProperty;
  begin
    if RESameStr(S, 'alnum') then
      Result := upAlnum
    else if RESameStr(S, 'alpha') then
      Result := upAlpha
    else if RESameStr(S, 'ascii') then
      Result := upAscii
    else if RESameStr(S, 'blank') then
      Result := upBlank
    else if RESameStr(S, 'cntrl') then
      Result := upCntrl
    else if RESameStr(S, 'digit') then
      Result := upDigit
    else if RESameStr(S, 'graph') then
      Result := upSpace
    else if RESameStr(S, 'lower') then
      Result := upLower
    else if RESameStr(S, 'print') then
      Result := upPrint
    else if RESameStr(S, 'punct') then
      Result := upPunct
    else if RESameStr(S, 'space') then
      Result := upSpace
    else if RESameStr(S, 'upper') then
      Result := upUpper
    else if RESameStr(S, 'xdigit') then
      Result := upXDigit
    else if RESameStr(S, 'word') then
      Result := upWord
    else
      FRegExp.Error(sPosixBracketNotCompleted, GetCompileErrorPos);
  end;
  {$WARNINGS ON}

var
  S: WideString;
  L: Integer;
  IsNegative: Boolean;
begin
  if FP^ = '\' then
  begin
    LexEscChar;
    L := 0;
  end
  else if FP^ = '[' then
  begin
    CharNext(FP);
    if FP^ = ':' then
    begin
      CharNext(FP);
      if FP^ = '^' then
      begin
        IsNegative := True;
        CharNext(FP);
      end
      else
        IsNegative := False;

      S := '';
      while (FP^ >= 'a') and (FP^ <= 'z') do
      begin
        S := S + FP^;
        CharNext(FP);
        if FP^ = #0 then
          FRegExp.Error(sRegExpNotCompleted, GetCompileErrorPos);
        if FP^ = ':' then
        begin
          CharNext(FP);
          if FP^ = ']' then
          begin
            CharNext(FP);
            FUnicodeProperty := GetPosixType(S);

            if IsNegative then
              FToken := tkNEPosixBracket
            else
              FToken := tkPosixBracket;
            Exit;
          end;
        end;
      end;
      FRegExp.Error(sPosixBracketNotCompleted, GetCompileErrorPos);
    end
    else
    begin
      Dec(FP);
      FWChar := GetREChar(FP, L, []);
      FToken := tkChar;
    end;
  end
  else
  begin
    FWChar := GetREChar(FP, L, []);
    FToken := tkChar;
  end;

  Inc(FP, L);

  if (FToken = tkChar) and (FP^ = '-') then
  begin
    Inc(FP);
    FStartWChar := FWChar;
    if FP^ <> ']' then
    begin
      if FP^ = '\' then
      begin
        LexEscChar;
        L := 0;
        if FToken <> tkChar then
          FRegExp.Error(sCharRangeWrong, GetCompileErrorPos);
      end
      else
        FWChar := GetREChar(FP, L, []);
      Inc(FP, L);
      if FStartWChar > FWChar then
        FRegExp.Error(sCharRangeWrong, GetCompileErrorPos);

      FLastWChar := FWChar;

      FToken := tkRangeChar;
    end
    else
    begin
      Dec(FP);
      FToken := tkChar;
      Exit;
    end;
  end;
end;

procedure TREParser.LexEscChar;
var
  L: Integer;
begin
  L := 1;
  Inc(FP);

  case FP^ of
    '1'..'9', 'A', 'B', 'X', 'Z', 'b', 'k', 'z':
    begin
      if FContext = ctNormal then
      begin
        case FP^ of
          '1'..'9':
          begin
            FMin := GetDigit(L);
            FToken := tkReference;
          end;
          'A':
            FToken := tkTHead;
          'B':
            FToken := tkNEWordBoundary;
          'X':
            FToken := tkCombiningSequence;
          'Z':
            FToken := tkTTail;
          'b':
            FToken := tkWordBoundary;
          'k':
          begin
            LexNameReference;
            Exit;
          end;
          'z':
            FToken := tkTTailEnd;
        end;
      end
      else
      begin
        FWChar := GetREChar(FP, L, FOptions);
        FToken := tkChar;
      end;
    end;
    'p':
    begin
      CharNext(FP);
      if FP^ = '{' then
      begin
        LexProperty;
        Exit;
      end
      else
      begin
        Dec(FP);
        FWChar := GetREChar(FP, L, FOptions);
      end;
    end;
    'D':
      FToken := tkNEDigitChar;
    'H':
      FToken := tkNEHexDigitChar;
    'S':
      FToken := tkNESpaceChar;
    'W':
      FToken := tkNEWordChar;
    'd':
      FToken := tkDigitChar;
    'h':
      FToken := tkHexDigitChar;
    's':
      FToken := tkSpaceChar;
    'w':
      FToken := tkWordChar;
    else
    begin
      case FP^ of
        'c':
          FWChar := GetCtrlCode(L);
        'x':
        begin
          L := CONST_HEX_DIGIT_TWO;
          FWChar := GetHexDigit(L);
        end;
        'u':
        begin
          L := CONST_HEX_DIGIT_FOUR;
          FWChar := GetHexDigit(L);
        end;
        't':
          FWChar := 9;
        'v':
          FWChar := $B;
        'n':
        begin
          if FRegExp.NIsNewLine then
          begin
            FToken := tkNewLine;
            CharNext(FP);
            Exit;
          end
          else
            FWChar := $A;
        end;
        'r':
          FWChar := $D;
        'f':
          FWChar := $C;
        'a':
          FWChar := 7;
        'e':
          FWChar := $1B;
        else
          FWChar := GetREChar(FP, L, FOptions);
      end;
      FToken := tkChar;
    end;
  end;
  CharNext(FP, L);
end;

procedure TREParser.LexGroupName(Delimiter: TREChar);
var
  P: PWideChar;
  S: WideString;
begin
  P := FP;
  S := '';
  while P^ <> #0 do
  begin
    if TREChar(P^) = Delimiter then
    begin
      FGroupName := S;
      FToken := tkGroupStart;
      CharNext(P);
      FP := P;
      Break;
    end
    else
    begin
      if FRegExp.IsAnkWord(TREChar(P^)) then
      begin
        S := S + P^;
        CharNext(P);
      end
      else
      begin
        FWChar := TREChar('<');
        FToken := tkChar;
        FP := P;
        CharNext(FP);
        Exit;
      end;
    end;
  end;
end;

{$WARNINGS OFF}
procedure TREParser.LexOption;
var
  IsInclude: Boolean;
  AOption: TREOption;
begin
  FNewOptions := FOptions;

  while FP^ <> #0 do
  begin
    if FP^ = '-' then
    begin
      IsInclude := False;
      CharNext(FP);
    end
    else
      IsInclude := True;

    case FP^ of
      'i':
        AOption := roIgnoreCase;
      'm':
        AOption := roMultiLine;
      'n':
        AOption := roNamedGroupOnly;
      's':
        AOption := roSingleLine;
      'x':
        AOption := roExtended;
      {$IFDEF UseJapaneseOption}
      'w':
        AOption := roIgnoreWidth;
      'k':
        AOption := roIgnoreKana;
      {$ENDIF}
      else
        FRegExp.Error(sOptionNotDefine, GetCompileErrorPos);
    end;

    if IsInclude then
      Include(FNewOptions, AOption)
    else
      Exclude(FNewOptions, AOption);

    CharNext(FP);

    if FP^ = ')' then
    begin
      FToken := tkOption;
      Exit;
    end
    else if FP^ = ':' then
    begin
      FToken := tkLParWithOption;
      Exit;
    end;
  end;
  FRegExp.Error(sOptionNotCompleted, GetCompileErrorPos);
end;

procedure TREParser.LexNameReference;
var
  S: WideString;
begin
  S := '';
  CharNext(FP);
  if FP^ = '<' then
  begin
    CharNext(FP);
    while FP^ <> #0 do
    begin
      if FP^ = '>' then
      begin
        FGroupName := S;
        FToken := tkNameReference;
        CharNext(FP);
        Exit;
      end;
      if FRegExp.IsAnkWord(TREChar(FP^)) then
        S := S + FP^
      else
        Break;
      CharNext(FP);
    end;
  end
end;

{$WARNINGS ON}

procedure TREParser.LexProperty;
var
  IsNegative: Boolean;
  Param: WideString;
begin
  CharNext(FP);
  if FP^ = '^' then
  begin
    IsNegative := True;
    CharNext(FP);
  end
  else
    IsNegative := False;

  Param := '';
  while FP^ <> #0 do
  begin
    if FRegExp.IsAnkWord(TREChar(FP^)) then
    begin
      Param := Param + FP^;
      CharNext(FP);
    end
    else if FP^ = '}' then
    begin
      FUnicodeProperty := GetPropertyType(Param);
      CharNext(FP);
      if IsNegative then
        FToken := tkNEProperty
      else
        FToken := tkProperty;
      Exit;
    end
    else
      FRegExp.Error(sPropertyNameWrong, GetCompileErrorPos);
  end;
  FRegExp.Error(sRightCurlyBracketMissing, GetCompileErrorPos);
end;

function TREParser.NewBinCode(AOperator: TREOperator; ALeft,
  ARight: TRECode; AMin, AMax: Integer): TRECode;
begin
  Result := TREBinCode.Create(FRegExp, AOperator, ALeft, ARight, AMin, AMax);
  FRegExp.FBinCodeList.Add(Result);
end;

function TREParser.NewCharClassCode(ANegative: Boolean): TRECode;
var
  CharClass: TRECharClassCode;
begin
  CharClass := TRECharClassCode.Create(FRegExp, ANegative);
  FRegExp.FCodeList.Add(CharClass);
  Result := CharClass;

  GetToken;
  case FToken of
    tkChar:
      CharClass.Add(FWChar, []);
    tkRangeChar:
      CharClass.Add(FStartWChar, FLastWChar, FOptions);
    tkWordChar:
      CharClass.Add(TREWordCharCode.Create(FRegExp, False));
    tkDigitChar:
      CharClass.Add(TREDigitCharCode.Create(FRegExp, False));
    tkSpaceChar:
      CharClass.Add(TRESpaceCharCode.Create(FRegExp, False));
    tkNEWordChar:
      CharClass.Add(TREWordCharCode.Create(FRegExp, True));
    tkNEDigitChar:
      CharClass.Add(TREDigitCharCode.Create(FRegExp, True));
    tkNESpaceChar:
      CharClass.Add(TRESpaceCharCode.Create(FRegExp, True));
    tkPosixBracket:
      CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, False));
    tkNEPosixBracket:
      CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, True));
    tkProperty:
      CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, False));
    tkNEProperty:
      CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, True));
    else
      FRegExp.Error(sCharClassWorng, GetCompileErrorPos);
  end;

  GetToken;
  while (FToken = tkRangeChar) or (FToken = tkChar) or
    (FToken = tkWordChar) or (FToken = tkNEWordChar) or
    (FToken = tkDigitChar) or (FToken = tkNEDigitChar) or
    (FToken = tkSpaceChar) or (FToken = tkNESpaceChar) or
    (FToken = tkPosixBracket) or (FToken = tkNEPosixBracket) or
    (FToken = tkProperty) or (FToken = tkNEProperty) do
  begin
    case FToken of
      tkChar:
        CharClass.Add(FWChar, []);
      tkRangeChar:
        CharClass.Add(FStartWChar, FLastWChar, []);
      tkWordChar:
        CharClass.Add(TREWordCharCode.Create(FRegExp, False));
      tkDigitChar:
        CharClass.Add(TREDigitCharCode.Create(FRegExp, False));
      tkSpaceChar:
        CharClass.Add(TRESpaceCharCode.Create(FRegExp, False));
      tkNEWordChar:
        CharClass.Add(TREWordCharCode.Create(FRegExp, True));
      tkNEDigitChar:
        CharClass.Add(TREDigitCharCode.Create(FRegExp, True));
      tkNESpaceChar:
        CharClass.Add(TRESpaceCharCode.Create(FRegExp, True));
      tkPosixBracket:
        CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, False));
      tkNEPosixBracket:
        CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, True));
      tkProperty:
        CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, False));
      tkNEProperty:
        CharClass.Add(TREPropertyCode.Create(FRegExp, FUnicodeProperty, True));
      else
        FRegExp.Error(sCharClassWorng, GetCompileErrorPos);
    end;
    GetToken;
  end;
  if FToken <> tkCharClassEnd then
    FRegExp.Error(sRightBigParMissing, GetCompileErrorPos);

  CharClass.Rebuild;
end;

procedure TREParser.Parse;
begin
  InternalClear;

  GetToken;
  FRegExp.FCode := RegExpr;
  if FToken <> tkEnd then
  begin
    if FToken = tkRPar then
      FRegExp.Error(sLeftSmallParMissing, GetCompileErrorPos)
    else
      FRegExp.Error(sRegExpNotCompleted, GetCompileErrorPos);
  end
end;

procedure TREParser.PopOptions;
var
  AOptions: PREOptions;
begin
  if FOptionList.Count = 0 then
    Exit;
  AOptions := PREOptions(FOptionList[FOptionList.Count - 1]);
  FOptions := AOptions^;
  FOptionList.Delete(FOptionList.Count - 1);
  Dispose(AOptions);
end;

function TREParser.Primay: TRECode;

  function CheckBehindMatchSub(ACode: TRECode; IsMatch: Boolean;
    var ErrCode: Integer): Boolean;
  var
    SubCode: TREBinCode;
  begin
    if (ACode is TREBinCode) then
    begin
      SubCode := (ACode as TREBinCode);
      if SubCode.FOp = opUnion then
      begin
        Result := False;
        ErrCode := 1;
      end
      else if not IsMatch and (SubCode.FOp = opGroup) then
      begin
        Result := False;
        ErrCode := 2;
      end
      else
      begin
        if (SubCode.Left <> nil) and
            not CheckBehindMatchSub(SubCode.Left, IsMatch, ErrCode) then
        begin
          Result := False;
          Exit;
        end;
        if (SubCode.Right <> nil) and
            not CheckBehindMatchSub(SubCode.Right, IsMatch, ErrCode) then
        begin
          Result := False;
          Exit;
        end;
        Result := True;
      end;
    end
    else
      Result := True;
  end;

  procedure CheckBehindMatch(ACode: TRECode; IsMatch: Boolean);
  var
    ErrCode: Integer;
    Ret: Boolean;
  begin
    ErrCode := 0;

    if (ACode is TREBinCode) then
    begin
      if (ACode as TREBinCode).FOp = opUnion then
        Ret := True
      else
        Ret := CheckBehindMatchSub(ACode, IsMatch, ErrCode);
    end
    else
      Ret := True;

    if not Ret then
      if ErrCode = 1 then
        FRegExp.Error(sBehindMatchNotVariableLength, GetCompileErrorPos)
      else
        FRegExp.Error(sBehindMatchNotGroup, GetCompileErrorPos);
  end;

var
  ATagNo: Integer;
  AGroupName: WideString;
  SubCode: TRECode;
begin
  Result := nil;

  case FToken of
    tkChar:
    begin
      Result := TRECharCode.Create(FRegExp, FWChar, FOptions, FConvert);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkDot:
    begin
      Result := TREAnyCharCode.Create(FRegExp, FOptions);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkWordChar:
    begin
      Result := TREWordCharCode.Create(FRegExp, False);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNEWordChar:
    begin
      Result := TREWordCharCode.Create(FRegExp, True);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkDigitChar:
    begin
      Result := TREDigitCharCode.Create(FRegExp, False);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNEDigitChar:
    begin
      Result := TREDigitCharCode.Create(FRegExp, True);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkHexDigitChar:
    begin
      Result := TREHexDigitCharCode.Create(FRegExp, False);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNEHexDigitChar:
    begin
      Result := TREHexDigitCharCode.Create(FRegExp, True);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkSpaceChar:
    begin
      Result := TRESpaceCharCode.Create(FRegExp, False);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNESpaceChar:
    begin
      Result := TRESpaceCharCode.Create(FRegExp, True);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkCharClassFirst:
    begin
      Result := NewCharClassCode(False);
      GetToken;
    end;
    tkNegativeCharClassFirst:
    begin
      Result := NewCharClassCode(True);
      GetToken;
    end;
    tkCombiningSequence:
    begin
      Result := TRECombiningSequence.Create(FRegExp);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNewLine:
    begin
      Result := TRENewLineCode.Create(FRegExp);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkTHead:
    begin
      Result := TRETextHeadCode.Create(FRegExp);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkTTail:
    begin
      Result := TRETextTailCode.Create(FRegExp);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkTTailEnd:
    begin
      Result := TRETextEndCode.Create(FRegExp);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkReference:
    begin
      Result := TREReferenceCode.Create(FRegExp, FMin, FOptions);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNameReference:
    begin
      Result := TRENameReferenceCode.Create(FRegExp, FGroupName, FOptions);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkWordBoundary:
    begin
      Result := TREBoundaryCode.Create(FRegExp, False);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNEWordBoundary:
    begin
      Result := TREBoundaryCode.Create(FRegExp, True);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkGroupStart:
    begin
      PushOptions;

      Inc(FGroupCount);
      ATagNo := FGroupCount;
      AGroupName := FGroupName;
      GetToken;
      Result := NewBinCode(opGroup, RegExpr, nil);
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      (Result as TREBinCode).GroupIndex := ATagNo;
      if AGroupName <> '' then
        (Result as TREBinCode).GroupName := AGroupName;
      PopOptions;
      GetToken;
    end;
    tkNoBackTrack:
    begin
      GetToken;
      Result := NewBinCode(opNoBackTrack, RegExpr, nil);
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      (Result as TREBinCode).NoBackTrack := True;
      GetToken;
    end;
    tkAheadMatch:
    begin
      GetToken;
      Result := NewBinCode(opAheadMatch, RegExpr, nil);
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      GetToken;
    end;
    tkAheadNoMatch:
    begin
      GetToken;
      Result := NewBinCode(opAheadNoMatch, RegExpr, nil);
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      GetToken;
    end;
    tkBehindMatch:
    begin
      GetToken;
      SubCode := RegExpr;
      Result := NewBinCode(opBehindMatch, SubCode, nil);
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      CheckBehindMatch(SubCode, True);
      GetToken;
    end;
    tkBehindNoMatch:
    begin
      GetToken;
      SubCode := RegExpr;
      Result := NewBinCode(opBehindNoMatch, SubCode, nil);
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      CheckBehindMatch(SubCode, False);
      GetToken;
    end;
    tkLPar:
    begin
      PushOptions;

      GetToken;
      Result := RegExpr;
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      PopOptions;
      GetToken;
    end;
    tkLParWithOption:
    begin
      PushOptions;
      FOptions := FNewOptions;

      GetToken;
      Result := RegExpr;
      if FToken <> tkRPar then
        FRegExp.Error(sRightSmallParMissing, GetCompileErrorPos);
      PopOptions;
      GetToken;
    end;
    tkOption:
    begin
      FOptions := FNewOptions;
      GetToken;
      Result := RegExpr;
    end;
    tkProperty:
    begin
      Result := TREPropertyCode.Create(FRegExp, FUnicodeProperty, False);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    tkNEProperty:
    begin
      Result := TREPropertyCode.Create(FRegExp, FUnicodeProperty, True);
      FRegExp.FCodeList.Add(Result);
      GetToken;
    end;
    else
      FRegExp.Error(sSyntaxError, GetCompileErrorPos);
  end;
end;

procedure TREParser.PushOptions;
var
  AOptions: PREOptions;
begin
  New(AOptions);
  AOptions^ := FOptions;
  FOptionList.Add(AOptions);
end;

function TREParser.RegExpr: TRECode;
begin
  Result := Term;
  while FToken = tkUnion do
  begin
    GetToken;
    Result := NewBinCode(opUnion, Result, Term);
  end;
end;

procedure TREParser.SkipWhiteSpace;
begin
  while (FP^ <> #0) and ((FP^ = ' ') or (FP^ = #9) or (FP^ = #10) or (FP^ = #13)) do
    Inc(FP);
end;

function TREParser.Term: TRECode;
begin
  if (FToken = tkUnion) or (FToken = tkRPar) or (FToken = tkEnd) then
    Result := NewBinCode(opEmply, nil, nil)
  else
  begin
    Result := Factor;
    while (FToken <> tkUnion) and (FToken <> tkRPar) and
        (FToken <> tkEnd) do
      Result := NewBinCode(opConcat, Result, Factor);
  end;
end;

{ TRENFACode }

{$IFDEF DEBUG}
function TRENFACode.GetMatchTypeStr: WideString;
begin
  case FMatchKind of
    lmNormal:
      Result := '貪欲';
    lmMin:
      Result := '最短';
    lmMax:
      Result := '強欲';
  end;
end;
{$ENDIF}

procedure TRENFACode.SetCode(const Value: TRECode);
begin
  FCode := Value;
end;

procedure TRENFACode.SetKind(const Value: TRENFAKind);
begin
  FKind := Value;
end;

procedure TRENFACode.SetMax(const Value: Integer);
begin
  FMax := Value;
end;

procedure TRENFACode.SetMin(const Value: Integer);
begin
  FMin := Value;
end;

procedure TRENFACode.SetMatchKind(const Value: TRELoopMatchKind);
begin
  FMatchKind := Value;
end;

procedure TRENFACode.SetNext(const Value: TRENFACode);
begin
  FNext := Value;
end;

procedure TRENFACode.SetNoMatchTo(const Value: Integer);
begin
  FNoMatchTo := Value;
end;

procedure TRENFACode.SetGroupName(const Value: WideString);
begin
  FGroupName := Value;
end;

procedure TRENFACode.SetGroupIndex(const Value: Integer);
begin
  FGroupIndex := Value;
end;

procedure TRENFACode.SetTransitTo(const Value: Integer);
begin
  FTransitTo := Value;
end;

{ TRENFA }

procedure TRENFA.AddTransition(AKind: TRENFAKind; ATransFrom,
  ATransTo: Integer; ACode: TRECode);
var
  NFACode: TRENFACode;
begin
  NFACode := TRENFACode.Create;
  with NFACode do
  begin
    Kind := AKind;
    Code := ACode;
    TransitTo := ATransTo;
    Next := TRENFACode(FStateList[ATransFrom]);
  end;
  FStateList[ATransFrom] := NFACode;
end;

procedure TRENFA.Compile;
begin
  FRegExp.ClearStateList;
  FRegExp.FMatchData.Clear;
  FRegExp.FMatchData.Add('', -1, -1);
  FLeadCode.Clear;
  FTailCode.Clear;
  FRegExp.FTailStr := '';
  FNoMatch := False;

  FRegExp.FEntryState := GetNumber;
  FBEntryState := FRegExp.FEntryState;
  FRegExp.FExitState := GetNumber;
  FBExitState := FRegExp.FExitState;

  AddTransition(nkEnd, FRegExp.FExitState, -1, nil);
  GenerateStateList(FRegExp.FCode, FRegExp.FEntryState, FRegExp.FExitState);
end;

constructor TRENFA.Create(ARegExp: TSkRegExp);
begin
  inherited Create;
  FRegExp := ARegExp;
  FStateList := ARegExp.FStateList;
  FLeadCode := ARegExp.FLeadCode;
  FTailCode := ARegExp.FTailCode;
end;

destructor TRENFA.Destroy;
begin
  inherited;
end;

procedure TRENFA.GenerateStateList(ACode: TRECode; AEntry,
  AWayout: Integer);

  procedure PushState(ANewEntry, ANewWayout: Integer);
  begin
    if AEntry = FRegExp.FEntryState then
      FBEntryState := ANewEntry
    else if AEntry = FBEntryState then
      FBEntryState := ANewEntry;
    if AWayout = FRegExp.FExitState then
      FBExitState := ANewWayout
    else if AWayout = FBExitState then
      FBExitState := ANewWayout;
  end;

  procedure PopState(ANewEntry, ANewWayout, AOldEntry, AOldWayout: Integer);
  begin
    if FBEntryState = ANewEntry then
      FBEntryState := AOldEntry;
    if FBExitState = AOldWayout then
      FBExitState := ANewEntry;
  end;

var
  State1, State2: Integer;
  SubCode: TRECode;
  NFACode: TRENFACode;
//  CharCode: TRECharCode;
//  W: WideChar;
begin
  if ACode is TREBinCode then
  begin
    with ACode as TREBinCode do
    begin
      case Op of
        opUnion:
        begin
          GenerateStateList(Right, AEntry, AWayout);
          GenerateStateList(Left, AEntry, AWayout);
        end;
        opConcat:
        begin
          State1 := GetNumber;
          { 状態 entry → (pTree^.Children.pLeft)遷移 → 状態 aState1}
          GenerateStateList(Left, AEntry, State1);
          { 状態 aState1 → (pTree^.Children.pRight)遷移 → 状態 way_out}
          GenerateStateList(Right, State1, AWayout);
        end;
        opBound, opPlus, opStar, opQuest:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          { 状態 entry → ε遷移 → 状態 aState1}
          AddTransition(nkLoop, AEntry, State1, nil);
          NFACode := FStateList[AEntry];
          case Op of
            opBound:
            begin
              NFACode.MatchKind := MatchKind;
              NFACode.Min := Min;
              NFACode.Max := Max;
              if NFACode.Min = 0 then
              begin
                if AEntry = FBEntryState then
                  FLeadCode.Add(nil);
                if AWayout = FBExitState then
                  FTailCode.Add(nil);
              end;
            end;
            opStar:
            begin
              NFACode.MatchKind := MatchKind;
              NFACode.Min := 0;
              NFACode.Max := 0;
              if AEntry = FBEntryState then
                FLeadCode.Add(nil);
              if AWayout = FBExitState then
                FTailCode.Add(nil);
            end;
            opQuest:
            begin
              NFACode.MatchKind := MatchKind;
              NFACode.Min := 0;
              NFACode.Max := 1;
              if AEntry = FBEntryState then
                FLeadCode.Add(nil);
              if AWayout = FBExitState then
                FTailCode.Add(nil);
            end;
            opPlus:
            begin
              NFACode.MatchKind := MatchKind;
              NFACode.Min := 1;
              NFACode.Max := 0;
            end;
          end;

          PushState(State1, State2);
          { 状態 aState1 → (pTree^.Children.pLeft)以下の遷移 → 状態 aState2}
          GenerateStateList(Left, State1, State2);
          PopState(State1, State2, AEntry, AWayout);

          { 状態 aState2 → ε遷移 → 状態 aState1}
          AddTransition(nkEmpty, State2, State1, nil);
          { 状態 aState1 → ε遷移 → 状態 way_out}
          AddTransition(nkEmpty, State1, AWayout, nil);
        end;
        opGroup:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          FRegExp.FMatchData.Add(GroupName, AEntry, State2);

          AddTransition(nkGroupStart, AEntry, State1, nil);
          NFACode := FStateList[AEntry];
          NFACode.GroupIndex := GroupIndex;
          NFACode.GroupName := GroupName;

          PushState(State1, State2);
          GenerateStateList(Left, State1, State2);
          PopState(State1, State2, AEntry, AWayout);

          AddTransition(nkGroupEnd, State2, AWayout, nil);
          NFACode := FStateList[State2];
          NFACode.GroupIndex := GroupIndex;
          NFACode.GroupName := GroupName;
        end;
        opNoBackTrack:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          AddTransition(nkNoBackTrackBegin, AEntry, State1, nil);

          PushState(State1, State2);
          GenerateStateList(Left, State1, State2);
          PopState(State1, State2, AEntry, AWayout);

          AddTransition(nkNoBackTrackEnd, State2, AWayout, nil);
        end;
        opAheadMatch:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          AddTransition(nkAheadMatch, AEntry, State1, nil);

          PushState(State1, State2);
          GenerateStateList(Left, State1, State2);
          PopState(State1, State2, AEntry, AWayout);

          AddTransition(nkMatchEnd, State2, AWayout, nil)
        end;
        opAheadNoMatch:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          AddTransition(nkAheadNoMatch, AEntry, State1, nil);
          NFACode := FStateList[AEntry];
          NFACode.NoMatchTo := AWayout;

          PushState(State1, State2);
          FNoMatch := True;
          GenerateStateList(Left, State1, State2);
          FNoMatch := False;
          PopState(State1, State2, AEntry, AWayout);

          AddTransition(nkMatchEnd, State2, AWayout, nil)
        end;
        opBehindMatch:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          AddTransition(nkBehindMatch, AEntry, State1, nil);
          FNoMatch := True;
          if AEntry = FBEntryState then
            FBEntryState := AWayout;
          GenerateStateList(Left, State1, State2);
//          PopState(State1, State2, AEntry, AWayout);
          FNoMatch := False;
          AddTransition(nkMatchEnd, State2, AWayout, nil)
        end;
        opBehindNoMatch:
        begin
          State1 := GetNumber;
          State2 := GetNumber;

          AddTransition(nkBehindNoMatch, AEntry, State1, nil);
          NFACode := FStateList[AEntry];
          NFACode.NoMatchTo := AWayout;

          PushState(State1, State2);
          FNoMatch := True;
          if AEntry = FBEntryState then
            FBEntryState := AWayout;
          GenerateStateList(Left, State1, State2);
          FNoMatch := False;
          PopState(State1, State2, AEntry, AWayout);
          AddTransition(nkMatchEnd, State2, AWayout, nil)
        end;
        opEmply:
        begin
          AddTransition(nkEmpty, AEntry, AWayout, nil);
          if (AEntry = FBEntryState) and not FNoMatch then
            FLeadCode.Add(nil);
          if (AWayout = FBExitState) and not FNoMatch then
            FTailCode.Add(nil);
        end;
      end;
    end;
  end
  else
  begin
//    if (ACode is TRECharCode) then
//    begin
//      CharCode := ACode as TRECharCode;
//      W := WideChar(CharCode.FWChar);
//    end;
    if (AEntry = FBEntryState) and (ACode is TRECharCode) and
        (ACode as TRECharCode).FConvert and
        ((ACode as TRECharCode).FWChar = TREChar('^')) then
    begin
      SubCode := TRELineHeadCode.Create(FRegExp, (ACode as TRECharCode).FOptions);
      ReplaceCode(ACode, SubCode);
      AddTransition(nkChar, AEntry, AWayout, SubCode);
      if not FNoMatch then
        FLeadCode.Add(SubCode);
    end
    else if (AWayout = FBExitState) and (ACode is TRECharCode) and
        (ACode as TRECharCode).FConvert and
        ((ACode as TRECharCode).FWChar = TREChar('$')) then
    begin
      SubCode := TRELineTailCode.Create(FRegExp, (ACode as TRECharCode).FOptions);
      ReplaceCode(ACode, SubCode);
      AddTransition(nkChar, AEntry, AWayout, SubCode);
//      if not FNoMatch then
//        FTailCode.Add(SubCode)
    end
    else
    begin
      if ACode is TRECharCode then
      begin
        AddTransition(nkChar, AEntry, AWayout, ACode);
        if (AWayout = FBExitState) and not FNoMatch then
          FTailCode.Add(ACode);
      end
      else
        AddTransition(nkNormal, AEntry, AWayout, ACode);

      if (AEntry = FBEntryState) and not FNoMatch then
        FLeadCode.Add(ACode);
    end;
  end;
end;

function TRENFA.GetNumber: Integer;
begin
  Result := FStateList.Add(nil);
end;

procedure TRENFA.ReplaceCode(var OldCode, NewCode: TRECode);

  procedure ReplaceCodeSub(var SourceCode: TRECode; var OldCode, NewCode: TRECode);
  var
    Code, SubCode: TREBinCode;
    I: Integer;
  begin
    if SourceCode is TREBinCode then
    begin
      Code := SourceCode as TREBinCode;
      if Assigned(Code.Left) then
        ReplaceCodeSub(Code.FLeft, OldCode, NewCode);
      if Assigned(Code.Right) then
        ReplaceCodeSub(Code.FRight, OldCode, NewCode);
    end
    else
    begin
      if SourceCode = OldCode then
      begin
        I := FRegExp.FCodeList.IndexOf(OldCode);
        if I = -1 then
          FRegExp.Error(sFatalError, 0);

        SubCode := FRegExp.FCodeList[I];
        SubCode.Free;
        FRegExp.FCodeList[I] := NewCode;

        SourceCode := NewCode;
        Exit;
      end;
    end;
  end;

{$IFNDEF DEBUG}
var
  TempCode: TRECode;
  Index: Integer;
{$ENDIF}
begin
  {$IFDEF DEBUG}
  ReplaceCodeSub(FRegExp.FCode, OldCode, NewCode);
  {$ELSE}
  Index := FRegExp.FCodeList.IndexOf(OldCode);
  if Index = -1 then
    FRegExp.Error('BUG: not found OldCode', 0);

  TempCode := FRegExp.FCodeList[Index];
  FRegExp.FCodeList[Index] := NewCode;
  TempCode.Free;
  {$ENDIF}
end;

{ TSkRegExp }

function TSkRegExp.CheckAheadMatchState(NFACode: TRENFACode;
  var AStr: PWideChar): TRENFACode;
var
  SaveP: PWideChar;
begin
  SaveP := AStr;

  Result := NextState(NFACode, AStr);
  while (Result <> nil) and not (Result.Kind in [nkEnd, nkMatchEnd]) do
    Result := NextState(Result, AStr);

  if (Result <> nil) and (Result.Kind = nkMatchEnd) then
  begin
    AStr := SaveP;
    Result := FStateList[Result.TransitTo];
  end
  else
    Result := nil;
end;

function TSkRegExp.CheckBehindMatchState(NFACode: TRENFACode;
  var AStr: PWideChar): TRENFACode;

  function GetMatchLength(NFACode: TRENFACode): Integer;
  begin
    Result := 0;
    while NFACode.Kind <> nkMatchEnd do
    begin
      if NFACode.Kind in [nkNormal, nkChar] then
        Inc(Result)
      else if (NFACode.Kind = nkLoop) and (NFACode.Min = NFACode.Max) then
        Inc(Result, NFACode.Min);

      NFACode := FStateList[NFACode.TransitTo];
    end;
  end;

  function GetNext(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
  begin
    while NFACode.Kind in [nkGroupStart, nkGroupEnd] do
      NFACode := MatchPrim(NFACode, AStr);

    Result := MatchPrim(NFACode, AStr);

    while (Result <> nil) and (Result.Kind in [nkGroupStart, nkGroupEnd]) do
      Result := MatchPrim(Result, AStr);
  end;

var
  SaveP: PWideChar;
  I, Len: Integer;
begin
  Result := nil;
  SaveP := AStr;
  while NFACode <> nil do
  begin
    Len := GetMatchLength(NFACode);
    if AStr - FTextTopP >= Len then
    begin
      Dec(AStr, Len);
      I := 0;
      Result := NFACode;
      if NFACode.Kind = nkEmpty then
      begin
        Result := MatchPrim(NFACode, AStr);
      end
      else
      begin
        repeat
          Result := GetNext(Result, AStr);
          if Result = nil then
            Break;
           Inc(I);
        until (I = Len);
      end;
      if (Result <> nil) and (Result.Kind = nkMatchEnd) then
        Break;
    end;
    AStr := SaveP;
    NFACode := NFACode.Next;
  end;
end;

function TSkRegExp.CheckExitState(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
var
  EntryCode: TRENFACode;
  SaveP : PWideChar;
begin
  while NFACode.Kind in [nkGroupStart, nkGroupEnd] do
    NFACode := NextState(NFACode, AStr);

  if (NFACode.Kind in [nkEnd, nkMatchEnd, nkNoBackTrackEnd]) or
      ((NFACode.Kind = nkLoop) and (NFACode.Min = 0)) then
  begin
    Result := NFACode;
    Exit;
  end;

  SaveP := AStr;
  if (NFACode.Kind = nkLoop) and (NFACode.Min > 0) then
  begin
    while NFACode <> nil do
    begin
      EntryCode := FStateList[NFACode.TransitTo];
      EntryCode := EntryCode.Next;
      if CheckExitState(EntryCode, AStr) <> nil then
      begin
        Result := NFACode;
        AStr := SaveP;
        Exit;
      end
      else
        NFACode := NFACode.Next;
    end;
    Result := nil;
    AStr := SaveP;
  end
  else
  begin
    SaveP := AStr;

    Result := NextState(NFACode, AStr);
    while (Result <> nil) and (Result.Kind <> nkEnd) and
        (Result.Kind in [nkChar, nkNormal, nkGroupStart, nkGroupEnd]) do
      Result := NextState(Result, AStr);

    if Result = nil then
      AStr := SaveP;
  end;
end;

procedure TSkRegExp.ClearBinCodeList;
var
  I: Integer;
begin
  for I := 0 to FBinCodeList.Count - 1 do
    if FBinCodeList[I] <> nil then
      TRECode(FBinCodeList[I]).Free;
  FBinCodeList.Clear;
end;

procedure TSkRegExp.ClearCodeList;
var
  I: Integer;
begin
  for I := 0 to FCodeList.Count - 1 do
    if FCodeList[I] <> nil then
      TRECode(FCodeList[I]).Free;
  FCodeList.Clear;
end;

procedure TSkRegExp.ResetMatchData;
var
  I: Integer;
  P: PREMatchRec;
begin
  for I := 0 to FMatchData.Count - 1 do
  begin
    P := FMatchData[I];
    P.StartPBuf := nil;
    P.StartP := nil;
    P.EndP := nil;
  end;
end;

procedure TSkRegExp.ClearStateList;
var
  I: Integer;
  Code, Next: TRENFACode;
begin
  if FStateList <> nil then
  begin
    for I := 0 to FStateList.Count - 1 do
    begin
      Code := FStateList[I];
      while Code <> nil do
      begin
        Next := Code.Next;
        Code.Free;
        Code := Next;
      end;
    end;
    FStateList.Clear;
  end;
end;

procedure TSkRegExp.Compile;
var
  Parser: TREParser;
  NFA: TRENFA;
begin
  FCompileErrorPos := 0;

  if not FCompiled then
  begin
    Parser := TREParser.Create(Self, FExpression);
    try
      Parser.Parse;
      NFA := TRENFA.Create(Self);
      try
        NFA.Compile;
        
        if roDefinedCharClassLegacy in FOptions then
        begin
          IsWord := IsAnkWord;
          IsDigit := IsAnkDigit;
          IsSpace := IsAnkSpace;
          IsHexDigit := IsAnkHexDigit;
        end
        else
        begin
          IsWord := IsUnicodeWord;
          IsDigit := IsUnicodeDigit;
          IsSpace := IsUnicodeSpace;
          IsHexDigit := IsUnicodeHexDigit;
        end;

        GenerateLeadCode;
        GenerateTailCode;
        FIsPreMatch := FLeadCode.Count > 0;
      finally
        NFA.Free;
      end;
    finally
      Parser.Free;
    end;
    {$IFNDEF DEBUG}
    ClearBinCodeList;
    {$ENDIF}
    FCompiled := True;
  end;
end;

constructor TSkRegExp.Create;
begin
  inherited;
  FMatchData := TREMatchData.Create;
  FCodeList := TList.Create;
  FBinCodeList := TList.Create;
  FStateList := TList.Create;
  FLeadCode := TObjectList.Create;
  FLeadCode.OwnsObjects := False;
  FTailCode := TObjectList.Create;
  FTailCode.OwnsObjects := False;
  FOptions := [];
  SetEOL(DefaultEOL);

  IsWord := IsUnicodeWord;
  IsDigit := IsUnicodeDigit;
  IsSpace := IsUnicodeSpace;
  IsHexDigit := IsUnicodeHexDigit;
end;

destructor TSkRegExp.Destroy;
begin
  ClearStateList;
  FTailCode.Free;
  FLeadCode.Free;
  FStateList.Free;
  ClearBinCodeList;
  ClearCodeList;
  FBinCodeList.Free;
  FCodeList.Free;
  FMatchData.Free;
  inherited;
end;

{$IFDEF DEBUG}
function TSkRegExp.DumpLeadCode: WideString;
var
  I: Integer;
  Code: TRECode;
begin
  Result := '';
  for I := 0 to FLeadCode.Count - 1 do
  begin
    Code := FLeadCode[I] as TRECode;
    Result := Result + Code.GetStr;
  end;
  if Result <> '' then
    Result := '先頭文字: ' + Result
  else
    Result := '先頭文字: なし';
end;

procedure TSkRegExp.DumpNFA(ADest: TWideStrings);
var
  I: Integer;
  Code: TRENFACode;
  Str: WideString;
begin
  ADest.Clear;
  ADest.BeginUpDate;
  for I := 0 to FStateList.Count - 1 do
  begin
    Code := FStateList[I];
    if I = FEntryState then
      Str := Format('開始 %2d : ', [I])
    else if I = FExitState then
      Str := Format('終了 %2d : ', [I])
    else
      Str := Format('状態 %2d : ', [I]);
    while Code <> nil do
    begin
      if Code.Kind = nkEmpty then
        Str := Str + Format('ε遷移で 状態 %2d へ :', [Code.TransitTo])
      else if Code.Kind = nkLoop then
        Str := Str + Format('繰り返し(%s:%d-%d)で 状態 %2d へ:',
          [Code.GetMatchTypeStr, Code.Min, Code.Max, Code.TransitTo])
      else if Code.Kind = nkLoop then
        Str := Str + Format('繰り返し開始で 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkAheadMatch then
        Str := Str + Format('先読み一致チェックで 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkAheadNoMatch then
        Str := Str + Format('先読み不一致チェックで 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkBehindMatch then
        Str := Str + Format('戻り読み一致チェックで 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkBehindNoMatch then
        Str := Str + Format('戻り読み不一致チェックで 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkMatchEnd then
        Str := Str + Format('一致終了で 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkGroupStart then
        Str := Str + Format('グループ[%d]開始で 状態 %2d へ:',
          [Code.GroupIndex, Code.TransitTo])
      else if Code.Kind = nkGroupEnd then
        Str := Str + Format('グループ[%d]終了で 状態 %2d へ:',
          [Code.GroupIndex, Code.TransitTo])
      else if Code.Kind = nkNoBackTrackBegin then
        Str := Str + Format('非バックトラック開始で 状態 %2d へ:', [Code.TransitTo])
      else if Code.Kind = nkNoBackTrackEnd then
        Str := Str + Format('非バックトラック終了で 状態 %2d へ:', [Code.TransitTo])
//      else if Code.Kind = nkRecursion then
//        Str := Str + Format('再帰[%d]で 状態 %2d へ:',
//          [Code.Min, Code.TransitTo])
      else
      begin
        if Code.Code <> nil then
          Str := Str + Format('%s で 状態 %2d へ :',
            [(Code.Code as TRECode).GetStr, Code.TransitTo]);
      end;

      Code := Code.Next;
    end;
    ADest.Add(Str);
  end;
  ADest.Add(DumpLeadCode);
  ADest.Add(DumpTailStr);
  ADest.EndUpDate;
end;

procedure TSkRegExp.DumpParse(TreeView: TTreeView);

  function Add(Node: TTreeNode; const S: string): TTreeNode;
  begin
    Result := TreeView.Items.AddChild(Node, Format('%s',[S]));
  end;

  procedure DumpParseSub(Code: TRECode; Node: TTreeNode);
  var
    ANode: TTreeNode;
  begin
    if Code is TREBinCode then
    begin
      with Code as TREBinCode do
      begin
        case Op of
          opUnion:
            ANode := Add(Node, '選択 "|"');
          opConcat:
            ANode := Add(Node, '連結');
          opEmply:
            ANode := Add(Node, '空');
          opPlus:
            ANode := Add(Node, '閉包 "+"');
          opStar:
            ANode := Add(Node, '閉包 "*"');
          opQuest:
            ANode := Add(Node, '閉包 "?"');
          opBound:
            ANode := Add(Node, '繰り返し');
          opLHead:
            ANode := Add(Node, '行頭');
          opLTail:
            ANode := Add(Node, '行末');
          opGroup:
            ANode := Add(Node, 'グループ');
          opAheadMatch:
            ANode := Add(Node, '先読み一致');
          opBehindMatch:
            ANode := Add(Node, '戻り読み一致');
          opAheadNoMatch:
            ANode := Add(Node, '先読み不一致');
          opBehindNoMatch:
            ANode := Add(Node, '戻り読み不一致');
          opNoBackTrack:
            ANode := Add(Node, '非バックトラック');
          else
            raise ESkRegExp.Create('bug: not define operator');
        end;
        if Left <> nil then
          DumpParseSub(Left, ANode);
        if Right <> nil then
          DumpParseSub(Right, ANode);
      end;
    end
    else
      TreeView.Items.AddChild(Node, (Code as TRECode).GetStr);
  end;

begin
  TreeView.Items.Clear;
  DumpParseSub(FCode, nil);
  TreeView.FullExpand;
end;

function TSkRegExp.DumpTailStr: WideString;
begin
  if FTailStr <> '' then
    Result := '終端文字: ' + FTailStr;
end;

{$ENDIF}

procedure TSkRegExp.Error(const ErrorMes: WideString; AErrorPos: Integer);
var
  e: ESkRegExp;
begin
  FCompileErrorPos := AErrorPos;
  if AErrorPos = 0 then
    e := ESkRegExp.Create(ErrorMes)
  else
    e := ESkRegExp.Create(ErrorMes + '(' + IntToStr(AErrorPos) + ')');
  e.ErrorPos := AErrorPos;
  raise e;
end;

function TSkRegExp.Exec(const AInputStr: WideString): Boolean;
var
  P: PWideChar;
begin
  if not FCompiled then
    Compile;
    
  SetInputString(AInputStr);

  P := FTextTopP;

  Result := MatchCore(P)
end;

function TSkRegExp.ExecNext: Boolean;
begin
  Result := False;

  if not FCompiled then
    Error(sExecFuncNotCall, 0);

  if MatchPos[0] = 0 then
    Exit;

  if MatchLen[0] = 0 then
    Result := ExecPos(MatchPos[0] + 1)
  else
    Result := ExecPos(MatchPos[0] + MatchLen[0]);
end;

function TSkRegExp.ExecPos(AOffset: Integer): Boolean;
var
  P: PWideChar;
  L: Integer;
begin
  Result := False;
  Dec(AOffset);

  if FInputString = '' then
    Exit;

  if not FCompiled then
    Compile;

  if AOffset <= Length(FInputString) then
  begin
    P := FTextTopP + AOffset;
    //Pが改行文字だった場合の調整
    if IsEOL(P, L) then
      Inc(P, L)
    else if (FEOLLen = 2) and (P^ = FEOLTailP^) then
      Inc(P)
    else if IsLineSeparator(TREChar(P^)) then
      Inc(P);
    Result := MatchCore(P);
  end;
end;

function TSkRegExp.GetIgnoreZenHan: Boolean;
begin
  Result := (roIgnoreWidth in FOptions) and
    (roIgnoreKana in FOptions);
end;

function TSkRegExp.GetMatchLen(Index: Integer): Integer;
begin
  if (Index < 0) or (Index > FMatchData.Count - 1) then
  begin
    Result := -1;
    Exit;
  end;

  if (FInputString <> '') and
      (FMatchData.StartP[Index] <> nil) and (FMatchData.EndP[Index] <> nil) then
    Result := FMatchData.EndP[Index] - FMatchData.StartP[Index]
  else
    Result := 0;
end;

function TSkRegExp.GetMatchPos(Index: Integer): Integer;
begin
  if (Index < 0) or (Index > FMatchData.Count - 1) then
  begin
    Result := -1;
    Exit;
  end;

  if (FInputString <> '') and
      (FMatchData.StartP[Index] <> nil) and (FMatchData.EndP[Index] <> nil) then
    Result := FMatchData.StartP[Index] - FTextTopP + 1
  else
    Result := 0;
end;

function TSkRegExp.GetMatchStr(Index: Integer): WideString;
begin
  if (Index < 0) or (Index > FMatchData.Count - 1) then
  begin
    Result := '';
    Exit;
  end;

  if (FInputString <> '') and
      (FMatchData.StartP[Index] <> nil) and (FMatchData.EndP[Index] <> nil) then
    Result := Copy(FInputString, MatchPos[Index], MatchLen[Index])
  else
    Result := '';
end;

function TSkRegExp.GetOptions(const Index: Integer): Boolean;
var
  LOption: TREOption;
begin
  case Index of
    0:
      LOption := roIgnoreCase;
    1:
      LOption := roMultiLine;
    2:
      LOption := roNamedGroupOnly;
    3:
      LOption := roSingleLine;
    4:
      LOption := roExtended;
    5:
      LOption := roIgnoreWidth;
    else
      LOption := roIgnoreKana;
  end;
  Result := LOption in FOptions;
end;

function TSkRegExp.GetGroupNameFromIndex(Index: Integer): WideString;
begin
  Result := FMatchData.GroupName[Index];
end;

function TSkRegExp.GetNamedGroupLen(Name: WideString): Integer;
var
  Index: Integer;
begin
  Index := FMatchData.IndexOfName(Name);
  if Index = -1 then
    Error(Format(sGroupNameNotDefine, [Name]), 0);
  Result := GetMatchLen(Index);
end;

function TSkRegExp.GetNamedGroupPos(Name: WideString): Integer;
var
  Index: Integer;
begin
  Index := FMatchData.IndexOfName(Name);
  if Index = -1 then
    Error(Format(sGroupNameNotDefine, [Name]), 0);
  Result := GetMatchPos(Index);
end;

function TSkRegExp.GetNamedGroupStr(Name: WideString): WideString;
var
  Index: Integer;
begin
  Index := FMatchData.IndexOfName(Name);
  if Index = -1 then
    Error(Format(sGroupNameNotDefine, [Name]), 0);
  Result := GetMatchStr(Index);
end;

function TSkRegExp.GetStyle: Integer;
begin
  Result := 0;
  if roIgnoreCase in FOptions then
    Result := Result or NORM_IGNORECASE;
  if roIgnoreWidth in FOptions then
    Result := Result or NORM_IGNOREWIDTH;
  if roIgnoreKana in FOptions then
    Result := Result or NORM_IGNOREKANATYPE;
end;

procedure TSkRegExp.GenerateLeadCode;
var
  IsNotLead: Boolean;

  procedure RebuildSub(Index: Integer);
  var
    Source, Dest: TRECode;
    I: Integer;
  begin
    Source := FLeadCode[Index] as TRECode;
    for I := FLeadCode.Count - 1 downto 0 do
    begin
      if I <> Index then
      begin
        Dest := FLeadCode[I] as TRECode;
        if Source.IsInclude(Dest) then
          FLeadCode.Delete(I);
      end;
    end;
  end;

var
  I: Integer;
  Code: TRECode;
begin
  IsNotLead := False;

  if FLeadCode.Count = 0 then
    Exit;

  if not IsNotLead then
  begin
    for I := 0 to FLeadCode.Count - 1 do
    begin
      Code := FLeadCode[I] as TRECode;
      if (Code = nil) or (Code is TREAnyCharCode) then
      begin
        IsNotLead := True;
        Break;
      end;
    end;
  end;

  if IsNotLead then
  begin
    FLeadCode.Clear;
  end
  else
  begin
    I := 0;

    while I < FLeadCode.Count do
    begin
      RebuildSub(I);
      Inc(I);
    end;
  end;
end;

procedure TSkRegExp.GenerateTailCode;
var
  I: Integer;
  B: Boolean;
begin
  B := False;
  for I := 0 to FTailCode.Count - 1 do
  begin
    if FTailCode[I] = nil then
    begin
      B := True;
      Break;
    end;
    if (roIgnoreCase in (FTailCode[I] as TRECharCode).FOptions) or
        (roIgnoreWidth in (FTailCode[I] as TRECharCode).FOptions) or
        (roIgnoreKana in (FTailCode[I] as TRECharCode).FOptions) then
    begin
      B := True;
      Break;
    end;
  end;
  if B then
    FTailCode.Clear;
end;

function TSkRegExp.GetGroupCount: Integer;
begin
  Result := FMatchData.Count - 1;
end;

function TSkRegExp.GetVersion: WideString;
begin
  Result := CONST_VERSION;
end;

function TSkRegExp.IsEOL(AStr: PWideChar; out Len: Integer): Boolean;
begin
  Result := False;
  Len := 0;
  if AStr^ = FEOLHeadP^ then
  begin
    if (FEOLLen = 2) and ((AStr + 1)^ = FEOLTailP^) then
      Len := 2
    else
      Len := 1;
    Result := True;
  end;
end;

function TSkRegExp.IsLineSeparator(W: TREChar): Boolean;
begin
  Result := (W = $A) or (W = $B) or (W = $C) or (W = $D) or (W = $85) or
    (W = $2020) or (W = $2029);
end;

function TSkRegExp.IsAnkDigit(W: TREChar): Boolean;
begin
  Result := (W >= TREChar('0')) and (W <= TREChar('9'));
end;

function TSkRegExp.IsAnkHexDigit(W: TREChar): Boolean;
begin
  Result := ((W >= TREChar('0')) and (W <= TREChar('9'))) or
    ((W >= TREChar('A')) and (W <= TREChar('F'))) or
    ((W >= TREChar('a')) and (W <= TREChar('f')));
end;

function TSkRegExp.IsAnkSpace(W: TREChar): Boolean;
begin
  Result := (W = $9) or (W = $A) or (W = $B) or (W = $C) or
    (W = $D) or (W = $20);
end;

function TSkRegExp.IsAnkWord(W: TREChar): Boolean;
begin
  Result := (W = TREChar('_')) or
    ((W >= TREChar('A')) and (W <= TREChar('Z'))) or
    ((W >= TREChar('a')) and (W <= TREChar('z'))) or
    ((W >= TREChar('0')) and (W <= TREChar('9')));
end;

function TSkRegExp.IsUnicodeDigit(W: TREChar): Boolean;
begin
  Result := IsUnicodeProperty(W, upDigit);
end;

function TSkRegExp.IsUnicodeHexDigit(W: TREChar): Boolean;
begin
  Result := IsUnicodeProperty(W, upXDigit);
end;

function TSkRegExp.IsUnicodeSpace(W: TREChar): Boolean;
begin
  Result := IsUnicodeProperty(W, upSpace);
end;

function TSkRegExp.IsUnicodeWord(W: TREChar): Boolean;
begin
  Result := IsUnicodeProperty(W, upWord);
end;

function TSkRegExp.MatchCore(AStr: PWideChar): Boolean;

  function FindTail: Boolean;
  var
    I: Integer;
    W: WideChar;
  begin
    Result := False;
    for I := 0 to FTailCode.Count - 1 do
    begin
      W := WideChar((FTailCode[I] as TRECharCode).FWChar);
      if Pos(W, FInputString) > 0 then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

var
  SaveP: PWideChar;
  NFACode: TRENFACode;
  IsCheck: Boolean;
begin
{$IFDEF DEBUG}
  FStackMax := 0;
{$ENDIF}
  Result := False;

//  if FTailCode.Count = 1 then
//    if not FindTail then
//      Exit;

  if AStr <> nil then
  begin
    while AStr <= FTextEndP do
    begin
      FIsBehindNoMatch := False;
      FNoBackTrack := False;
      FRecursion := False;
      {$IFDEF DEBUG}
      FStackCount := 0;
      {$ENDIF}

      ResetMatchData;

      if FIsPreMatch then
        IsCheck := PreMatch(AStr)
      else
        IsCheck := True;

      if IsCheck then
      begin
        SaveP := AStr;
        FMatchData.StartP[0] := AStr;
        NFACode := FStateList[FEntryState];

        NFACode := NextState(NFACode, AStr);
        while NFACode <> nil do
          NFACode := NextState(NFACode, AStr);

        if FMatchData.EndP[0] <> nil then
        begin
          Result := True;
          if Assigned(FOnMatch) then
            FOnMatch(Self);
          Exit;
        end
        else if not FIsBehindNoMatch then
          AStr := SaveP;
      end;
      Inc(AStr);
    end;
  end;
end;

function TSkRegExp.MatchLoop(NFACode: TRENFACode;
  var AStr: PWideChar): Boolean;
var
  SaveP: PWideChar;
  SubCode: TRENFACode;
begin
  if AStr = FTextEndP then
  begin
    Result := False;
    Exit;
  end;

  SubCode := NFACode.Next;
  SaveP := AStr;

  SubCode := NextState(SubCode, AStr);
  while (SubCode <> nil) and (SubCode <> NFACode) do
    SubCode := NextState(SubCode, AStr);

  if (SubCode = nil) or ((SubCode <> nil) and (SaveP = AStr)) then
  begin
    Result := False;
    AStr := SaveP;
  end
  else
    Result := True;
end;

function TSkRegExp.MatchPrim(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
var
  EntryCode, ExitCode: TRENFACode;
  AMatchKind: TRELoopMatchKind;
  SaveP, SubP: PWideChar;
  I, Len, AMin, AMax: Integer;
label
  lblEntry, lblExit;
begin
{$IFDEF DEBUG}
  Inc(FStackCount);
  if FStackCount > FStackMax then
    FStackMax := FStackCount;
  try
{$ENDIF}
  case NFACode.Kind of
    nkLoop:
    begin
      Result := nil;
      AMatchKind := NFACode.MatchKind;
      AMin := NFACode.Min;
      AMax := NFACode.Max;
      SaveP := AStr;

      //ループ本体の入り口
      EntryCode := FStateList[NFACode.TransitTo];
      //ループの出口
      ExitCode := FStateList[EntryCode.TransitTo];
//      //ループを継続する条件を登録
//      TermCode := EntryCode.Next;

      //Min一致
      if AMin > 0 then
      begin
        for I := 1 to AMin do
          if not MatchLoop(EntryCode, AStr) then
            Exit;

        //{n}ならばバックトラックの必要がないのでループの出口を返す
        if (AMin = AMax) then
        begin
          Result := ExitCode;
          Exit;
        end;

        if (AMatchKind = lmMin) then
        begin
          Result := CheckExitState(ExitCode, AStr);
          if Result <> nil then
            Exit;
        end;

        //最小値が指定されているときは、PrevPを現在位置に設定
        SaveP := AStr;
      end
      else
      begin
        //最小値が0ならばマッチ成功
        if AMatchKind = lmMin then
        begin
          Result := CheckExitState(ExitCode, AStr);
          if Result <> nil then
            Exit;
        end;
      end;

      I := AMin;

      repeat
        if (AMatchKind = lmMin) then
        begin
          Result := CheckExitState(ExitCode, AStr);
          if Result <> nil then
            Exit;
        end;

        if not MatchLoop(EntryCode, AStr) then
          Break;

        Inc(I);
      until (I = AMax);

      if (AMatchKind <> lmMax) and not FNoBackTrack then
      begin
        Result := CheckExitState(ExitCode, AStr);
        while (Result = nil) and (AStr > SaveP) do
        begin
          Dec(AStr);
          SubP := AStr;
          Result := CheckExitState(ExitCode, AStr);
          if Result = nil then
            AStr := SubP;
        end;

        if Result = nil then
          AStr := SaveP;
      end
      else
        Result := ExitCode;
    end;
    nkEnd:
    begin
      FMatchData.EndP[0] := AStr;
      Result := nil;
    end;
    nkGroupStart:
    begin
      FMatchData.StartP[NFACode.GroupIndex] := AStr;
      Result := FStateList[NFACode.TransitTo];
    end;
    nkGroupEnd:
    begin
      FMatchData.EndP[NFACode.GroupIndex] := AStr;
      Result := FStateList[NFACode.TransitTo];
    end;
    nkAheadMatch:
      Result := CheckAheadMatchState(FStateList[NFACode.TransitTo], AStr);
    nkAheadNoMatch:
    begin
      if CheckAheadMatchState(FStateList[NFACode.TransitTo], AStr) = nil then
        Result := FStateList[NFACode.NoMatchTo]
      else
        Result := nil;
    end;
    nkBehindMatch:
    begin
      Result := CheckBehindMatchState(FStateList[NFACode.TransitTo], AStr);
    end;
    nkBehindNoMatch:
    begin
      Result := CheckBehindMatchState(FStateList[NFACode.TransitTo], AStr);
      if Result = nil then
        Result := FStateList[NFACode.NoMatchTo]
      else
      begin
        FIsBehindNoMatch := True;
        Result := nil;
      end;
    end;
    nkMatchEnd, nkEmpty:
      Result := FStateList[NFACode.TransitTo];
    nkNoBackTrackBegin:
    begin
      FNoBackTrack := True;
      Result := FStateList[NFACode.TransitTo];
      while (Result <> nil) and not (Result.Kind in [nkEnd, nkNoBackTrackEnd]) do
        Result := NextState(Result, AStr);
    end;
    nkNoBackTrackEnd:
    begin
      FNoBackTrack := False;
      Result := FStateList[NFACode.TransitTo];
    end;
    else
    begin
      if NFACode.Code.Equals(AStr, Len) then
      begin
        Inc(AStr, Len);
        Result := FStateList[NFACode.TransitTo];
      end
      else
      begin
        Result := NFACode.Next;
      end;
    end;
  end;
{$IFDEF DEBUG}
  finally
    Dec(FStackCount);
  end;
{$ENDIF}
end;

function TSkRegExp.NextState(NFACode: TRENFACode; var AStr: PWideChar): TRENFACode;
var
  SaveP: PWideChar;
begin
  Result := nil;
  if (NFACode.Next = nil) then
    Result := MatchPrim(NFACode, AStr)
  else
  begin
    while NFACode <> nil do
    begin
      SaveP := AStr;
      Result := MatchPrim(NFACode, AStr);
      while (Result <> nil) and 
          not (Result.Kind in [nkEnd, nkEmpty, nkMatchEnd, nkNoBackTrackEnd]) do
        Result := MatchPrim(Result, AStr);

      if (Result = nil) and not FNoBackTrack then
      begin
        AStr := SaveP;
        FMatchData.Reset(AStr);
      end
      else
        Break;

      NFACode := NFACode.Next;
    end;
  end;
end;

function TSkRegExp.PreMatch(var AStr: PWideChar): Boolean;
var
  I, L: Integer;
  ACode: TRECode;
begin
  Result := False;
  if FLeadCode.Count = 0 then
    Exit;

  for I := 0 to FLeadCode.Count - 1 do
  begin
    ACode := FLeadCode[I] as TRECode;
    if ACode.Equals(AStr, L) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TSkRegExp.Replace(const AInputStr, AReplaceStr: WideString;
  IsReplaceAll: Boolean): WideString;
var
  Index: Integer;
  RepStr: string;
begin
  Result := '';
  Index := 1;

  if Exec(AInputStr) then
  begin
    repeat
      RepStr := Substitute(AReplaceStr);

      Result := Result +
        Copy(FInputString, Index, MatchPos[0] - Index) + RepStr;

      if MatchLen[0] = 0 then
        Index := MatchPos[0] + 1
      else
        Index := MatchPos[0] + MatchLen[0];

      if not IsReplaceAll then
        Break;
    until not ExecNext;
  end;
  Result := Result + Copy(FInputString, Index, MaxInt);
end;

procedure TSkRegExp.SetEOL(const Value: WideString);
begin
  if FEOL <> Value then
  begin
    FEOL := Value;
    FEOLLen := Length(FEOL);
    if FEOLLen > 2 then
      Error(sEOLRangeOver, 0);

    if FEOLLen = 2 then
    begin
      FEOLHeadP := @FEOL[1];
      FEOLTailP := @FEOL[2];
    end
    else
    begin
      FEOLHeadP := @FEOL[1];
      FEOLTailP := nil;
    end;
    FCompiled := False;
  end;
end;

procedure TSkRegExp.SetExpression(const Value: WideString);
begin
  if FExpression <> Value then
  begin
    FExpression := Value;
    FCompiled := False;
  end;
end;

procedure TSkRegExp.SetIgnoreZenHan(const Value: Boolean);
begin
  IgnoreWidth := Value;
  IgnoreKana := Value;
end;

procedure TSkRegExp.SetInputString(const Value: WideString);
begin
  FInputString := Value;
  FTextTopP := PWideChar(FInputString);
  FTextEndP := FTextTopP + Length(FInputString);
  ResetMatchData;
end;

procedure TSkRegExp.SetOnMatch(const Value: TNotifyEvent);
begin
  FOnMatch := Value;
end;

procedure TSkRegExp.SetOptions(const Index: Integer;
  const Value: Boolean);
var
  LOption: TREOption;
begin
  case Index of
    0:
      LOption := roIgnoreCase;
    1:
      LOption := roMultiLine;
    2:
      LOption := roNamedGroupOnly;
    3:
      LOption := roSingleLine;
    4:
      LOption := roExtended;
    5:
      LOption := roIgnoreWidth;
    6:
      LOption := roIgnoreKana;
    7:
      LOption := roDefinedCharClassLegacy;
    else
      LOption := roNone;
  end;

  if (LOption = roNone) or
      (Value and (LOption in FOptions)) or
      (not Value and not (LOption in FOptions)) then
    Exit;

  if Value then
    Include(FOptions, LOption)
  else
    Exclude(FOptions, LOption);

  FCompiled := False;
end;

procedure TSkRegExp.SetNIsNewLine(const Value: Boolean);
begin
  FNIsNewLine := Value;
end;

procedure TSkRegExp.Split(const AInputStr: WideString;
  ADest: TREStrings);
var
  Index: Integer;
begin
  ADest.Clear;
  Index := 1;

  if Exec(AInputStr) then
  begin
    repeat
      ADest.Add(Copy(FInputString, Index, MatchPos[0] - Index));

      if MatchLen[0] = 0 then
        Index := MatchPos[0] + 1
      else
        Index := MatchPos[0] + MatchLen[0];

    until not ExecNext;
  end;
end;

function TSkRegExp.Substitute(const ATemplate: WideString): WideString;
var
  P: PWideChar;
  K: Integer;
begin
  Result := '';
  if ATemplate = '' then
    Exit;

  if FMatchData.StartP[0] = nil then
    Exit;

  P := PWideChar(ATemplate);
  while P^ <> #0 do
  begin
    if P^ = '$' then
    begin
      Inc(P);
      K := 0;
      if IsDigit(TREChar(P^)) then
      begin
        K := (Integer(P^) - Integer('0'));
        Result := Result + Match[K];
      end
      else if P^ = '{' then
      begin
        Inc(P);
        if not IsDigit(TREChar(P^)) then
          Error(sDigitMissing, 0);

        repeat
          if not IsDigit(TREChar(P^)) then
            Error(sDigitMissing, 0);

          K := K * 10 + (Integer(P^) - Integer('0'));
          Inc(P);
        until P^ = '}';
        Result := Result + Match[K];
      end
      else if P^ = '&' then
        Result := Result + Match[0]
      else if P^ = '$' then
        Result := Result + '$'
      else
        Result := Result + P^;

      Inc(P);
    end
    else
    begin
      Result := Result + P^;
      Inc(P);
    end;
  end;
end;

initialization
begin
  PropertyNames := THashedStringList.Create;
  PropertyNames.Sorted := True;
  PropertyNames.CaseSensitive := True;

  PropertyNames.AddObject('Alnum', TObject(upAlnum));
  PropertyNames.AddObject('Alpha', TObject(upAlpha));
  PropertyNames.AddObject('ASCII', TObject(upAscii));
  PropertyNames.AddObject('Blank', TObject(upBlank));
  PropertyNames.AddObject('Cntrl', TObject(upCntrl));
  PropertyNames.AddObject('Digit', TObject(upDigit));
  PropertyNames.AddObject('Graph', TObject(upGraph));
  PropertyNames.AddObject('Lower', TObject(upLower));
  PropertyNames.AddObject('Print', TObject(upPrint));
  PropertyNames.AddObject('Upper', TObject(upUpper));
  PropertyNames.AddObject('Punct', TObject(upPunct));
  PropertyNames.AddObject('Space', TObject(upSpace));
  PropertyNames.AddObject('XDigit', TObject(upXDigit));
  PropertyNames.AddObject('Word', TObject(upWord));
  PropertyNames.AddObject('Any', TObject(upAny));
  PropertyNames.AddObject('Assigned', TObject(upAssigned));
  PropertyNames.AddObject('L', TObject(upL));
  PropertyNames.AddObject('M', TObject(upM));
  PropertyNames.AddObject('N', TObject(upN));
  PropertyNames.AddObject('P', TObject(upP));
  PropertyNames.AddObject('S', TObject(upS));
  PropertyNames.AddObject('Z', TObject(upZ));
  PropertyNames.AddObject('C', TObject(upC));
  PropertyNames.AddObject('Lu', TObject(upLu));
  PropertyNames.AddObject('Ll', TObject(upLl));
  PropertyNames.AddObject('Lt', TObject(upLt));
  PropertyNames.AddObject('Lm', TObject(upLm));
  PropertyNames.AddObject('Lo', TObject(upLo));
  PropertyNames.AddObject('Mn', TObject(upMn));
  PropertyNames.AddObject('Mc', TObject(upMc));
  PropertyNames.AddObject('Me', TObject(upMe));
  PropertyNames.AddObject('Nd', TObject(upNd));
  PropertyNames.AddObject('Nl', TObject(upNl));
  PropertyNames.AddObject('No', TObject(upNo));
  PropertyNames.AddObject('Pc', TObject(upPc));
  PropertyNames.AddObject('Pd', TObject(upPd));
  PropertyNames.AddObject('Ps', TObject(upPs));
  PropertyNames.AddObject('Pe', TObject(upPe));
  PropertyNames.AddObject('Pi', TObject(upPi));
  PropertyNames.AddObject('Pf', TObject(upPf));
  PropertyNames.AddObject('Po', TObject(upPo));
  PropertyNames.AddObject('Sm', TObject(upSm));
  PropertyNames.AddObject('Sc', TObject(upSc));
  PropertyNames.AddObject('Sk', TObject(upSk));
  PropertyNames.AddObject('So', TObject(upSo));
  PropertyNames.AddObject('Zs', TObject(upZs));
  PropertyNames.AddObject('Zl', TObject(upZl));
  PropertyNames.AddObject('Zp', TObject(upZp));
  PropertyNames.AddObject('Cc', TObject(upCc));
  PropertyNames.AddObject('Cf', TObject(upCf));
  PropertyNames.AddObject('Cs', TObject(upCs));
  PropertyNames.AddObject('Co', TObject(upCo));
  PropertyNames.AddObject('Cn', TObject(upCn));
  PropertyNames.AddObject('Common', TObject(upCommon));
  PropertyNames.AddObject('Latin', TObject(upLatin));
  PropertyNames.AddObject('Greek', TObject(upGreek));
  PropertyNames.AddObject('Cyrillic', TObject(upCyrillic));
  PropertyNames.AddObject('Armenian', TObject(upArmenian));
  PropertyNames.AddObject('Hebrew', TObject(upHebrew));
  PropertyNames.AddObject('Arabic', TObject(upArabic));
  PropertyNames.AddObject('Syriac', TObject(upSyriac));
  PropertyNames.AddObject('Thaana', TObject(upThaana));
  PropertyNames.AddObject('Devanagari', TObject(upDevanagari));
  PropertyNames.AddObject('Bengali', TObject(upBengali));
  PropertyNames.AddObject('Gurmukhi', TObject(upGurmukhi));
  PropertyNames.AddObject('Gujarati', TObject(upGujarati));
  PropertyNames.AddObject('Oriya', TObject(upOriya));
  PropertyNames.AddObject('Tamil', TObject(upTamil));
  PropertyNames.AddObject('Telugu', TObject(upTelugu));
  PropertyNames.AddObject('Kannada', TObject(upKannada));
  PropertyNames.AddObject('Malayalam', TObject(upMalayalam));
  PropertyNames.AddObject('Sinhala', TObject(upSinhala));
  PropertyNames.AddObject('Thai', TObject(upThai));
  PropertyNames.AddObject('Lao', TObject(upLao));
  PropertyNames.AddObject('Tibetan', TObject(upTibetan));
  PropertyNames.AddObject('Myanmar', TObject(upMyanmar));
  PropertyNames.AddObject('Georgian', TObject(upGeorgian));
  PropertyNames.AddObject('Hangul', TObject(upHangul));
  PropertyNames.AddObject('Ethiopic', TObject(upEthiopic));
  PropertyNames.AddObject('Cherokee', TObject(upCherokee));
  PropertyNames.AddObject('Canadian_Aboriginal', TObject(upCanadian_Aboriginal));
  PropertyNames.AddObject('Ogham', TObject(upOgham));
  PropertyNames.AddObject('Runic', TObject(upRunic));
  PropertyNames.AddObject('Khmer', TObject(upKhmer));
  PropertyNames.AddObject('Mongolian', TObject(upMongolian));
  PropertyNames.AddObject('Hiragana', TObject(upHiragana));
  PropertyNames.AddObject('Katakana', TObject(upKatakana));
  PropertyNames.AddObject('Bopomofo', TObject(upBopomofo));
  PropertyNames.AddObject('Han', TObject(upHan));
  PropertyNames.AddObject('Yi', TObject(upYi));
  PropertyNames.AddObject('Old_Italic', TObject(upOld_Italic));
  PropertyNames.AddObject('Gothic', TObject(upGothic));
  PropertyNames.AddObject('Deseret', TObject(upDeseret));
  PropertyNames.AddObject('Inherited', TObject(upInherited));
  PropertyNames.AddObject('Tagalog', TObject(upTagalog));
  PropertyNames.AddObject('Hanunoo', TObject(upHanunoo));
  PropertyNames.AddObject('Buhid', TObject(upBuhid));
  PropertyNames.AddObject('Tagbanwa', TObject(upTagbanwa));
  PropertyNames.AddObject('Limbu', TObject(upLimbu));
  PropertyNames.AddObject('Tai_Le', TObject(upTai_Le));
  PropertyNames.AddObject('Linear_B', TObject(upLinear_B));
  PropertyNames.AddObject('Ugaritic', TObject(upUgaritic));
  PropertyNames.AddObject('Shavian', TObject(upShavian));
  PropertyNames.AddObject('Osmanya', TObject(upOsmanya));
  PropertyNames.AddObject('Cypriot', TObject(upCypriot));
  PropertyNames.AddObject('Braille', TObject(upBraille));
  PropertyNames.AddObject('Buginese', TObject(upBuginese));
  PropertyNames.AddObject('Coptic', TObject(upCoptic));
  PropertyNames.AddObject('New_Tai_Lue', TObject(upNew_Tai_Lue));
  PropertyNames.AddObject('Glagolitic', TObject(upGlagolitic));
  PropertyNames.AddObject('Tifinagh', TObject(upTifinagh));
  PropertyNames.AddObject('Syloti_Nagri', TObject(upSyloti_Nagri));
  PropertyNames.AddObject('Old_Persian', TObject(upOld_Persian));
  PropertyNames.AddObject('Kharoshthi', TObject(upKharoshthi));
  PropertyNames.AddObject('Balinese', TObject(upBalinese));
  PropertyNames.AddObject('Cuneiform', TObject(upCuneiform));
  PropertyNames.AddObject('Phoenician', TObject(upPhoenician));
  PropertyNames.AddObject('Phags_Pa', TObject(upPhags_Pa));
  PropertyNames.AddObject('Nko', TObject(upNko));
  PropertyNames.AddObject('InBasicLatin', TObject(upInBasicLatin));
  PropertyNames.AddObject('InLatin1Supplement', TObject(upInLatin1Supplement));
  PropertyNames.AddObject('InLatinExtendedA', TObject(upInLatinExtendedA));
  PropertyNames.AddObject('InLatinExtendedB', TObject(upInLatinExtendedB));
  PropertyNames.AddObject('InIPAExtensions', TObject(upInIPAExtensions));
  PropertyNames.AddObject('InSpacingModifierLetters', TObject(upInSpacingModifierLetters));
  PropertyNames.AddObject('InCombiningDiacriticalMarks', TObject(upInCombiningDiacriticalMarks));
  PropertyNames.AddObject('InGreekandCoptic', TObject(upInGreekandCoptic));
  PropertyNames.AddObject('InCyrillic', TObject(upInCyrillic));
  PropertyNames.AddObject('InCyrillicSupplement', TObject(upInCyrillicSupplement));
  PropertyNames.AddObject('InArmenian', TObject(upInArmenian));
  PropertyNames.AddObject('InHebrew', TObject(upInHebrew));
  PropertyNames.AddObject('InArabic', TObject(upInArabic));
  PropertyNames.AddObject('InSyriac', TObject(upInSyriac));
  PropertyNames.AddObject('InArabicSupplement', TObject(upInArabicSupplement));
  PropertyNames.AddObject('InThaana', TObject(upInThaana));
  PropertyNames.AddObject('InNKo', TObject(upInNKo));
  PropertyNames.AddObject('InDevanagari', TObject(upInDevanagari));
  PropertyNames.AddObject('InBengali', TObject(upInBengali));
  PropertyNames.AddObject('InGurmukhi', TObject(upInGurmukhi));
  PropertyNames.AddObject('InGujarati', TObject(upInGujarati));
  PropertyNames.AddObject('InOriya', TObject(upInOriya));
  PropertyNames.AddObject('InTamil', TObject(upInTamil));
  PropertyNames.AddObject('InTelugu', TObject(upInTelugu));
  PropertyNames.AddObject('InKannada', TObject(upInKannada));
  PropertyNames.AddObject('InMalayalam', TObject(upInMalayalam));
  PropertyNames.AddObject('InSinhala', TObject(upInSinhala));
  PropertyNames.AddObject('InThai', TObject(upInThai));
  PropertyNames.AddObject('InLao', TObject(upInLao));
  PropertyNames.AddObject('InTibetan', TObject(upInTibetan));
  PropertyNames.AddObject('InMyanmar', TObject(upInMyanmar));
  PropertyNames.AddObject('InGeorgian', TObject(upInGeorgian));
  PropertyNames.AddObject('InHangulJamo', TObject(upInHangulJamo));
  PropertyNames.AddObject('InEthiopic', TObject(upInEthiopic));
  PropertyNames.AddObject('InEthiopicSupplement', TObject(upInEthiopicSupplement));
  PropertyNames.AddObject('InCherokee', TObject(upInCherokee));
  PropertyNames.AddObject('InUnifiedCanadianAboriginalSyllabics', TObject(upInUnifiedCanadianAboriginalSyllabics));
  PropertyNames.AddObject('InOgham', TObject(upInOgham));
  PropertyNames.AddObject('InRunic', TObject(upInRunic));
  PropertyNames.AddObject('InTagalog', TObject(upInTagalog));
  PropertyNames.AddObject('InHanunoo', TObject(upInHanunoo));
  PropertyNames.AddObject('InBuhid', TObject(upInBuhid));
  PropertyNames.AddObject('InTagbanwa', TObject(upInTagbanwa));
  PropertyNames.AddObject('InKhmer', TObject(upInKhmer));
  PropertyNames.AddObject('InMongolian', TObject(upInMongolian));
  PropertyNames.AddObject('InLimbu', TObject(upInLimbu));
  PropertyNames.AddObject('InTaiLe', TObject(upInTaiLe));
  PropertyNames.AddObject('InNewTaiLue', TObject(upInNewTaiLue));
  PropertyNames.AddObject('InKhmerSymbols', TObject(upInKhmerSymbols));
  PropertyNames.AddObject('InBuginese', TObject(upInBuginese));
  PropertyNames.AddObject('InBalinese', TObject(upInBalinese));
  PropertyNames.AddObject('InPhoneticExtensions', TObject(upInPhoneticExtensions));
  PropertyNames.AddObject('InPhoneticExtensionsSupplement', TObject(upInPhoneticExtensionsSupplement));
  PropertyNames.AddObject('InCombiningDiacriticalMarksSupplement', TObject(upInCombiningDiacriticalMarksSupplement));
  PropertyNames.AddObject('InLatinExtendedAdditional', TObject(upInLatinExtendedAdditional));
  PropertyNames.AddObject('InGreekExtended', TObject(upInGreekExtended));
  PropertyNames.AddObject('InGeneralPunctuation', TObject(upInGeneralPunctuation));
  PropertyNames.AddObject('InSuperscriptsandSubscripts', TObject(upInSuperscriptsandSubscripts));
  PropertyNames.AddObject('InCurrencySymbols', TObject(upInCurrencySymbols));
  PropertyNames.AddObject('InCombiningDiacriticalMarksforSymbols', TObject(upInCombiningDiacriticalMarksforSymbols));
  PropertyNames.AddObject('InLetterlikeSymbols', TObject(upInLetterlikeSymbols));
  PropertyNames.AddObject('InNumberForms', TObject(upInNumberForms));
  PropertyNames.AddObject('InArrows', TObject(upInArrows));
  PropertyNames.AddObject('InMathematicalOperators', TObject(upInMathematicalOperators));
  PropertyNames.AddObject('InMiscellaneousTechnical', TObject(upInMiscellaneousTechnical));
  PropertyNames.AddObject('InControlPictures', TObject(upInControlPictures));
  PropertyNames.AddObject('InOpticalCharacterRecognition', TObject(upInOpticalCharacterRecognition));
  PropertyNames.AddObject('InEnclosedAlphanumerics', TObject(upInEnclosedAlphanumerics));
  PropertyNames.AddObject('InBoxDrawing', TObject(upInBoxDrawing));
  PropertyNames.AddObject('InBlockElements', TObject(upInBlockElements));
  PropertyNames.AddObject('InGeometricShapes', TObject(upInGeometricShapes));
  PropertyNames.AddObject('InMiscellaneousSymbols', TObject(upInMiscellaneousSymbols));
  PropertyNames.AddObject('InDingbats', TObject(upInDingbats));
  PropertyNames.AddObject('InMiscellaneousMathematicalSymbolsA', TObject(upInMiscellaneousMathematicalSymbolsA));
  PropertyNames.AddObject('InSupplementalArrowsA', TObject(upInSupplementalArrowsA));
  PropertyNames.AddObject('InBraillePatterns', TObject(upInBraillePatterns));
  PropertyNames.AddObject('InSupplementalArrowsB', TObject(upInSupplementalArrowsB));
  PropertyNames.AddObject('InMiscellaneousMathematicalSymbolsB', TObject(upInMiscellaneousMathematicalSymbolsB));
  PropertyNames.AddObject('InSupplementalMathematicalOperators', TObject(upInSupplementalMathematicalOperators));
  PropertyNames.AddObject('InMiscellaneousSymbolsandArrows', TObject(upInMiscellaneousSymbolsandArrows));
  PropertyNames.AddObject('InGlagolitic', TObject(upInGlagolitic));
  PropertyNames.AddObject('InLatinExtendedC', TObject(upInLatinExtendedC));
  PropertyNames.AddObject('InCoptic', TObject(upInCoptic));
  PropertyNames.AddObject('InGeorgianSupplement', TObject(upInGeorgianSupplement));
  PropertyNames.AddObject('InTifinagh', TObject(upInTifinagh));
  PropertyNames.AddObject('InEthiopicExtended', TObject(upInEthiopicExtended));
  PropertyNames.AddObject('InSupplementalPunctuation', TObject(upInSupplementalPunctuation));
  PropertyNames.AddObject('InCJKRadicalsSupplement', TObject(upInCJKRadicalsSupplement));
  PropertyNames.AddObject('InKangxiRadicals', TObject(upInKangxiRadicals));
  PropertyNames.AddObject('InIdeographicDescriptionCharacters', TObject(upInIdeographicDescriptionCharacters));
  PropertyNames.AddObject('InCJKSymbolsandPunctuation', TObject(upInCJKSymbolsandPunctuation));
  PropertyNames.AddObject('InHiragana', TObject(upInHiragana));
  PropertyNames.AddObject('InKatakana', TObject(upInKatakana));
  PropertyNames.AddObject('InBopomofo', TObject(upInBopomofo));
  PropertyNames.AddObject('InHangulCompatibilityJamo', TObject(upInHangulCompatibilityJamo));
  PropertyNames.AddObject('InKanbun', TObject(upInKanbun));
  PropertyNames.AddObject('InBopomofoExtended', TObject(upInBopomofoExtended));
  PropertyNames.AddObject('InCJKStrokes', TObject(upInCJKStrokes));
  PropertyNames.AddObject('InKatakanaPhoneticExtensions', TObject(upInKatakanaPhoneticExtensions));
  PropertyNames.AddObject('InEnclosedCJKLettersandMonths', TObject(upInEnclosedCJKLettersandMonths));
  PropertyNames.AddObject('InCJKCompatibility', TObject(upInCJKCompatibility));
  PropertyNames.AddObject('InCJKUnifiedIdeographsExtensionA', TObject(upInCJKUnifiedIdeographsExtensionA));
  PropertyNames.AddObject('InYijingHexagramSymbols', TObject(upInYijingHexagramSymbols));
  PropertyNames.AddObject('InCJKUnifiedIdeographs', TObject(upInCJKUnifiedIdeographs));
  PropertyNames.AddObject('InYiSyllables', TObject(upInYiSyllables));
  PropertyNames.AddObject('InYiRadicals', TObject(upInYiRadicals));
  PropertyNames.AddObject('InModifierToneLetters', TObject(upInModifierToneLetters));
  PropertyNames.AddObject('InLatinExtendedD', TObject(upInLatinExtendedD));
  PropertyNames.AddObject('InSylotiNagri', TObject(upInSylotiNagri));
  PropertyNames.AddObject('InPhagspa', TObject(upInPhagspa));
  PropertyNames.AddObject('InHangulSyllables', TObject(upInHangulSyllables));
  PropertyNames.AddObject('InHighSurrogates', TObject(upInHighSurrogates));
  PropertyNames.AddObject('InHighPrivateUseSurrogates', TObject(upInHighPrivateUseSurrogates));
  PropertyNames.AddObject('InLowSurrogates', TObject(upInLowSurrogates));
  PropertyNames.AddObject('InPrivateUseArea', TObject(upInPrivateUseArea));
  PropertyNames.AddObject('InCJKCompatibilityIdeographs', TObject(upInCJKCompatibilityIdeographs));
  PropertyNames.AddObject('InAlphabeticPresentationForms', TObject(upInAlphabeticPresentationForms));
  PropertyNames.AddObject('InArabicPresentationFormsA', TObject(upInArabicPresentationFormsA));
  PropertyNames.AddObject('InVariationSelectors', TObject(upInVariationSelectors));
  PropertyNames.AddObject('InVerticalForms', TObject(upInVerticalForms));
  PropertyNames.AddObject('InCombiningHalfMarks', TObject(upInCombiningHalfMarks));
  PropertyNames.AddObject('InCJKCompatibilityForms', TObject(upInCJKCompatibilityForms));
  PropertyNames.AddObject('InSmallFormVariants', TObject(upInSmallFormVariants));
  PropertyNames.AddObject('InArabicPresentationFormsB', TObject(upInArabicPresentationFormsB));
  PropertyNames.AddObject('InHalfwidthandFullwidthForms', TObject(upInHalfwidthandFullwidthForms));
  PropertyNames.AddObject('InSpecials', TObject(upInSpecials));
  PropertyNames.AddObject('InLinearBSyllabary', TObject(upInLinearBSyllabary));
  PropertyNames.AddObject('InLinearBIdeograms', TObject(upInLinearBIdeograms));
  PropertyNames.AddObject('InAegeanNumbers', TObject(upInAegeanNumbers));
  PropertyNames.AddObject('InAncientGreekNumbers', TObject(upInAncientGreekNumbers));
  PropertyNames.AddObject('InOldItalic', TObject(upInOldItalic));
  PropertyNames.AddObject('InGothic', TObject(upInGothic));
  PropertyNames.AddObject('InUgaritic', TObject(upInUgaritic));
  PropertyNames.AddObject('InOldPersian', TObject(upInOldPersian));
  PropertyNames.AddObject('InDeseret', TObject(upInDeseret));
  PropertyNames.AddObject('InShavian', TObject(upInShavian));
  PropertyNames.AddObject('InOsmanya', TObject(upInOsmanya));
  PropertyNames.AddObject('InCypriotSyllabary', TObject(upInCypriotSyllabary));
  PropertyNames.AddObject('InPhoenician', TObject(upInPhoenician));
  PropertyNames.AddObject('InKharoshthi', TObject(upInKharoshthi));
  PropertyNames.AddObject('InCuneiform', TObject(upInCuneiform));
  PropertyNames.AddObject('InCuneiformNumbersandPunctuation', TObject(upInCuneiformNumbersandPunctuation));
  PropertyNames.AddObject('InByzantineMusicalSymbols', TObject(upInByzantineMusicalSymbols));
  PropertyNames.AddObject('InMusicalSymbols', TObject(upInMusicalSymbols));
  PropertyNames.AddObject('InAncientGreekMusicalNotation', TObject(upInAncientGreekMusicalNotation));
  PropertyNames.AddObject('InTaiXuanJingSymbols', TObject(upInTaiXuanJingSymbols));
  PropertyNames.AddObject('InCountingRodNumerals', TObject(upInCountingRodNumerals));
  PropertyNames.AddObject('InMathematicalAlphanumericSymbols', TObject(upInMathematicalAlphanumericSymbols));
  PropertyNames.AddObject('InCJKUnifiedIdeographsExtensionB', TObject(upInCJKUnifiedIdeographsExtensionB));
  PropertyNames.AddObject('InCJKCompatibilityIdeographsSupplement', TObject(upInCJKCompatibilityIdeographsSupplement));
  PropertyNames.AddObject('InTags', TObject(upInTags));
  PropertyNames.AddObject('InVariationSelectorsSupplement', TObject(upInVariationSelectorsSupplement));
  PropertyNames.AddObject('InSupplementaryPrivateUseAreaA', TObject(upInSupplementaryPrivateUseAreaA));
end;

finalization
  PropertyNames.Free;

end.


