{ $RCSfile: IntegerList.pas,v $ $Revision: 1.7 $ $Date: 2004/03/01 17:59:22 $ $Author: vlads $ }
{                                                                                    }
{ ================================================================================== }
{                                                                                    }
{   This file is part of MP3BookHelper,  http://mp3bookhelper.sourceforge.net/       }
{   See readme.txt and license.txt for details.                                      }
{   (c) Copyright 2002 - Vlad Skarzhevskyy & co                                      }
{                                                                                    }
{   This program is free software; you can redistribute it and/or modify it under    }
{  the terms of the GNU General Public License as published by the Free Software     }
{  Foundation; either version 2 of the License, or (at your option) any later        }
{  version.                                                                          }
{                                                                                    }
{   This program is distributed in the hope that it will be useful, but WITHOUT ANY  }
{  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A   }
{  PARTICULAR PURPOSE.  See the GNU General Public License for more details.         }
{                                                                                    }
{  The GNU GPL can be found at:       http://www.gnu.org/copyleft/gpl.html           }
{                                                                                    }
{ ================================================================================== }

{
    This is fast Simple list of files indexed by IntegerListType
    Could be used as template just rename file and change DEFINE
    Unit tests in DuplicatesDBTest
}

{$INCLUDE versions.inc }

unit IntegerList;

interface

uses
    Classes, Types;

type
    { Main Type }
    IntegerListType = int64;

{$DEFINE KEEP_WideString}
{$DEFINE KEEP_Object}
{$UNDEF KEEP_Pointer}

    PIntegerItem = ^TIntegerItem;

    { TIntegerItem record }

    TIntegerItem = record
        FInteger: IntegerListType;
{$IFDEF KEEP_WideString}
        FString: WideString;
{$ENDIF}
{$IFDEF KEEP_Object}
        FObject: Pointer;
{$ENDIF}
{$IFDEF KEEP_Pointer}
        FPointer: Pointer;
{$ENDIF}
    end;

    PIntegerItemList = ^TIntegerItemList;
    TIntegerItemList = array[0..MaxListSize - 1] of TIntegerItem;

    { Forward class declarations }
    TIntegerList = class;
    TIntegerListSortCompare = function(List: TIntegerList; Index1, Index2: Integer): Integer;

    { TIntegerList class }
    TIntegerList = class(TPersistent)
    private
        FUpDateCount: Integer;
        FList: PIntegerItemList;
        FCount: Integer;
        FCapacity: Integer;
        FSorted: Boolean;
        FDuplicates: TDuplicates;
{$IFDEF KEEP_Object}
        FOwnsObjects: Boolean;
{$ENDIF}
        FOnChange: TNotifyEvent;
        FOnChanging: TNotifyEvent;

        procedure ExchangeItems(Index1, Index2: Integer);
        procedure Grow;
        procedure QuickSort(L, R: Integer; SCompare: TIntegerListSortCompare);
        procedure InsertItem(Index: Integer; const IItem: IntegerListType);
        procedure SetSorted(Value: Boolean);
        function  GetPObject(Index: Integer): Pointer;
        procedure PutPObject(Index: Integer; const Value: Pointer);
    protected
        procedure Error(const Msg: string; Data: Integer);
        procedure Changed; virtual;
        procedure Changing; virtual;
        function GetCapacity: Integer;
        function GetCount: Integer;
        procedure Put(Index: Integer; const IItem: IntegerListType);
        function Get(Index: Integer): IntegerListType;
        procedure PutItem(Index: Integer; const Item: TIntegerItem);
        function GetItem(Index: Integer): TIntegerItem;
        procedure PutIndexItem(IItem: IntegerListType; const Item: TIntegerItem);
        function GetIndexItem(IItem: IntegerListType): TIntegerItem;
{$IFDEF KEEP_WideString}
        procedure PutString(Index: Integer; AString: WideString);
        function GetString(Index: Integer): WideString;
{$ENDIF}
{$IFDEF KEEP_Object}
        procedure PutObject(Index: Integer; AObject: TObject);
        function GetObject(Index: Integer): TObject;
{$ENDIF}
        procedure SetCapacity(NewCapacity: Integer);
        procedure SetUpdateState(Updating: Boolean);
    public
        constructor Create;
        destructor Destroy; override;
        function Add(const IItem: IntegerListType): Integer;
{$IFDEF KEEP_WideString}
        function AddString(const IItem: IntegerListType; AString: WideString): Integer; virtual;
{$ENDIF}
{$IFDEF KEEP_Object}
        function AddObject(const IItem: IntegerListType; AObject: TObject): Integer; overload; virtual;
        function AddObject(const IItem: IntegerListType; AObject: Pointer): Integer; overload; virtual;
{$ENDIF}
        procedure Clear;
        procedure CopyFrom(src: TIntegerList);
        procedure Delete(Index: Integer);
        procedure Remove(Index: Integer);
        procedure Exchange(Index1, Index2: Integer);
        //procedure Move(src, dst: Integer);
        function Find(const IItem: IntegerListType; var Index: Integer): Boolean; virtual;
        function IndexOf(const IItem: IntegerListType): Integer;
        procedure Insert(Index: Integer; const IItem: IntegerListType);
        procedure Sort; virtual;
        procedure CustomSort(Compare: TIntegerListSortCompare); virtual;

        procedure LoadFromFile(const FileName: WideString); virtual;
        procedure LoadFromStream(Stream:TStream); virtual;
        procedure SaveToFile(const FileName: WideString); virtual;
        procedure SaveToStream(Stream: TStream);

        property Duplicates: TDuplicates read FDuplicates write FDuplicates;
        property Sorted: Boolean read FSorted write SetSorted;
        property OnChange: TNotifyEvent read FOnChange write FOnChange;
        property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;

        property Count: Integer read GetCount;
        property Integers[Index: Integer]: IntegerListType read Get write Put; default;
        property Items[Index: Integer]: TIntegerItem read GetItem write PutItem;
        property ItemsIndex[IItem: IntegerListType]: TIntegerItem read GetIndexItem write PutIndexItem;
    {$IFDEF KEEP_WideString}
        property Strings[Index: Integer]: WideString read GetString write PutString;
    {$ENDIF}
    {$IFDEF KEEP_Object}
        property Objects[Index: Integer]: TObject read GetObject write PutObject;
        property PObjects[Index: Integer]: Pointer read GetPObject write PutPObject;
        property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;

        procedure IsStack();
        function Push(AObject: TObject): integer;
        function Pop(destroy: boolean = false): TObject;
        function Peek(Index: integer = 0): TObject;
    {$ENDIF}
  end;

implementation

uses
    SysUtils,
    { Tnt Units }
    TntClasses;

{ TIntegerList }

constructor TIntegerList.Create;
begin
    inherited;
    FOnChange := nil;
    FOnChanging := nil;
    FList := nil;
    FCount := 0;
    SetCapacity(0);
    FUpdateCount := 0;
    FSorted := false;
    FDuplicates := dupAccept;
    {$IFDEF KEEP_Object}
    FOwnsObjects := false;
    {$ENDIF}
end;

destructor TIntegerList.Destroy;
begin
    FOnChange := nil;
    FOnChanging := nil;
    Clear;
    inherited Destroy;
end;

procedure TIntegerList.CopyFrom(src: TIntegerList);
var
    i: Integer;
begin
    Clear;
    Duplicates := src.Duplicates;
    Sorted := src.Sorted;
    for i := 0 to src.Count - 1 do
    begin
        Add(src[i]);
    end;
end;

procedure TIntegerList.Error(const Msg: string; Data: Integer);

    function ReturnAddr: Pointer;
    asm
          MOV     EAX,[EBP+4]
    end;

begin
    raise EStringListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;


const
    sDuplicateInt = 'Cannot add integer because if already exists';
    sListIndexError = 'List index Error';
    SSortedListError = 'Cannont insert to sorted list';

function TIntegerList.Add(const IItem: IntegerListType): Integer;
begin
    if not Sorted then
        Result := FCount
    else
        if Find(IItem, Result) then
        case Duplicates of
            dupIgnore: Exit;
            dupError: Error(SDuplicateInt, 0);
        end;
    InsertItem(Result, IItem);
end;

{$IFDEF KEEP_WideString}
function TIntegerList.AddString(const IItem: IntegerListType; AString: WideString): Integer;
begin
    Result := Add(IItem);
    PutString(Result, AString);
end;
{$ENDIF}

{$IFDEF KEEP_Object}
function TIntegerList.AddObject(const IItem: IntegerListType; AObject: TObject): Integer;
begin
    Result := Add(IItem);
    PutObject(Result, AObject);
end;

function TIntegerList.AddObject(const IItem: IntegerListType; AObject: Pointer): Integer;
begin
    Result := Add(IItem);
    PutPObject(Result, AObject);
end;

{$ENDIF}

procedure TIntegerList.Changed;
begin
    if (FUpdateCount = 0) and Assigned(FOnChange) then FOnChange(Self);
end;

procedure TIntegerList.Changing;
begin
    if (FUpdateCount = 0) and Assigned(FOnChanging) then FOnChanging(Self);
end;

procedure TIntegerList.Clear;
{$IFDEF KEEP_Object}
var
    Index: integer;
{$ENDIF}
begin
    if FCount <> 0 then
    begin
        Changing;
        {$IFDEF KEEP_Object}
        if OwnsObjects then
        begin
            for Index := 0 to GetCount - 1 do
                if (FList^[Index].FObject <> nil) then
                    TObject(FList^[Index].FObject).Free;
        end;
        {$ENDIF}
        FCount := 0;
        SetCapacity(0);
        Changed;
    end;
end;

procedure TIntegerList.Remove(Index: Integer);
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    Dec(FCount);
    if (Index < FCount) then
        System.Move(FList^[Index + 1], FList^[Index],
                   (FCount - Index) * SizeOf(TIntegerItem));
    Changed;
end;

procedure TIntegerList.Delete(Index: Integer);
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    {$IFDEF KEEP_Object}
     if OwnsObjects then
     begin
        TObject(FList^[Index].FObject).Free;
     end;
    {$ENDIF}
    Dec(FCount);
    if (Index < FCount) then
        System.Move(FList^[Index + 1], FList^[Index],
                   (FCount - Index) * SizeOf(TIntegerItem));
    Changed;
end;

{
procedure TIntegerList.Move(src, dst: Integer);
var
    Item: TIntegerItem;
begin
    if (src <> dst) then
    begin
        Item := GetItem(src);
        Remove(src);
        Insert(dst, Item);
    end;
end; }

procedure TIntegerList.Exchange(Index1, Index2: Integer);
begin
    if (Index1 < 0) or (Index1 >= FCount) then Error(SListIndexError, Index1);
    if (Index2 < 0) or (Index2 >= FCount) then Error(SListIndexError, Index2);
    Changing;
    ExchangeItems(Index1, Index2);
    Changed;
end;

procedure TIntegerList.ExchangeItems(Index1, Index2: Integer);
var
    Temp: IntegerListType;
    {$IFDEF KEEP_WideString}
    TempS: WideString;
    {$ENDIF}
    {$IFDEF KEEP_Object}
    TempO: TObject;
    {$ENDIF}
    {$IFDEF KEEP_Pointer}
    TempP: Pointer;
    {$ENDIF}
    Item1, Item2: PIntegerItem;
begin
    Item1 := @FList^[Index1];
    Item2 := @FList^[Index2];
    Temp := Integer(Item1^.FInteger);
    Item1^.FInteger := Item2^.FInteger;
    Item2^.FInteger := Temp;
    {$IFDEF KEEP_WideString}
    TempS := Item1^.FString;
    Item1^.FString := Item2^.FString;
    Item2^.FString := TempS;
    {$ENDIF}
    {$IFDEF KEEP_Object}
    TempO := Item1^.FObject;
    Item1^.FObject := Item2^.FObject;
    Item2^.FObject := TempO;
    {$ENDIF}
    {$IFDEF KEEP_Pointer}
    TempP := Item1^.FPointer;
    Item1^.FObject := Item2^.FPointer;
    Item2^.FPointer := TempP;
    {$ENDIF}
end;

function TIntegerList.Find(const IItem: IntegerListType; var Index: Integer): Boolean;
var
    L, H, I: Integer;
begin
    Result := False;
    L := 0;
    H := FCount - 1;
    while (L <= H) do
    begin
        I := (L + H) shr 1;
        if (Flist^[I].FInteger < IItem) then
            L := I + 1
        else
        begin
            H := I - 1;
            if (FList^[I].FInteger = IItem) then
            begin
                Result := True;
                if (Duplicates <> dupAccept) then L := I;
            end;
        end;
    end;
    Index := L;
end;

function TIntegerList.GetCapacity: Integer;
begin
    Result := FCapacity;
end;

function TIntegerList.GetCount: Integer;
begin
    Result := FCount;
end;

function TIntegerList.Get(Index: Integer): IntegerListType;
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Result := FList^[Index].FInteger;
end;

function TIntegerList.GetItem(Index: Integer): TIntegerItem;
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Result := FList^[Index];
end;

function TIntegerList.GetIndexItem(IItem: IntegerListType): TIntegerItem;
begin
    Result := GetItem(IndexOf(IItem));
end;

{$IFDEF KEEP_WideString}
function TIntegerList.GetString(Index: Integer): WideString;
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Result := FList^[Index].FString;
end;
{$ENDIF}

{$IFDEF KEEP_Object}
function TIntegerList.GetObject(Index: Integer): TObject;
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Result := FList^[Index].FObject;
end;

function TIntegerList.GetPObject(Index: Integer): Pointer;
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Result := FList^[Index].FObject;
end;

{$ENDIF}

procedure TIntegerList.Grow;
var
    Delta: Integer;
begin
    if (FCapacity > 64) then
        Delta := FCapacity div 4
    else
        if (FCapacity > 8) then
            Delta := 16
        else
            Delta := 4;
    SetCapacity(FCapacity + Delta);
end;

function TIntegerList.IndexOf(const IItem: IntegerListType): Integer;
begin
    if not Sorted then
    begin
        for Result := 0 to GetCount - 1 do
            if (Get(Result) = IItem) then Exit;
        Result := -1;
    end
    else if (not Find(IItem, Result)) then
        Result := -1;
end;

procedure TIntegerList.Insert(Index: Integer; const IItem: IntegerListType);
begin
    if Sorted then Error(SSortedListError, 0);
    if (Index < 0) or (Index > FCount) then Error(SListIndexError, Index);
    InsertItem(Index, IItem);
end;

procedure TIntegerList.InsertItem(Index: Integer; const IItem: IntegerListType);
var
    Item : PIntegerItem;
begin
    Changing;
    if (FCount = FCapacity) then Grow;
    if (Index < FCount) then
        System.Move(FList^[Index], FList^[Index + 1],
            (FCount - Index) * SizeOf(TIntegerItem));
    Item := @(FList^[Index]);
    Item.FInteger := IItem;
    {$IFDEF KEEP_WideString}
    Pointer(Item.FString) := nil;
    {$ENDIF}
    {$IFDEF KEEP_Object}
    Item.FObject := nil;
    {$ENDIF}
    Inc(FCount);
    Changed;
end;

procedure TIntegerList.Put(Index: Integer; const IItem: IntegerListType);
begin
    if Sorted then Error(SSortedListError, 0);
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    FList^[Index].FInteger := IItem;
    Changed;
end;

procedure TIntegerList.PutItem(Index: Integer; const Item: TIntegerItem);
begin
    if Sorted then Error(SSortedListError, 0);
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    FList^[Index] := Item;
    Changed;
end;

procedure TIntegerList.PutIndexItem(IItem: IntegerListType; const Item: TIntegerItem);
begin
    PutItem(IndexOf(IItem), Item);
end;

{$IFDEF KEEP_WideString}
procedure TIntegerList.PutString(Index: Integer; AString: WideString);
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    FList^[Index].FString := AString;
    Changed;
end;
{$ENDIF}

{$IFDEF KEEP_Object}
procedure TIntegerList.PutObject(Index: Integer; AObject: TObject);
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    FList^[Index].FObject := AObject;
    Changed;
end;

procedure TIntegerList.PutPObject(Index: Integer; const Value: Pointer);
begin
    if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
    Changing;
    FList^[Index].FObject := Value;
    Changed;
end;
{$ENDIF}

procedure TIntegerList.QuickSort(L, R: Integer; SCompare: TIntegerListSortCompare);
var
    I, J, P: Integer;
begin
    repeat
        I := L;
        J := R;
        P := (L + R) shr 1;
        repeat
            while SCompare(Self, I, P) < 0 do Inc(I);
            while SCompare(Self, J, P) > 0 do Dec(J);
            if (I <= J) then
            begin
                ExchangeItems(I, J);
                if (P = I) then
                    P := J
                else if P = J then
                    P := I;
                Inc(I);
                Dec(J);
            end;
        until (I > J);
        if (L < J) then QuickSort(L, J, SCompare);
        L := I;
    until (I >= R);
end;

procedure TIntegerList.SetCapacity(NewCapacity: Integer);
begin
    ReallocMem(FList, NewCapacity * SizeOf(TIntegerItem));
    FCapacity := NewCapacity;
end;

procedure TIntegerList.SetSorted(Value: Boolean);
begin
    if (FSorted <> Value) then
    begin
        if Value then Sort;
        FSorted := Value;
    end;
end;

procedure TIntegerList.SetUpdateState(Updating: Boolean);
begin
    if Updating then Changing else Changed;
end;

function IntegerListCompare(List: TIntegerList; Index1, Index2: Integer): Integer;
begin
    if (List.FList^[Index1].FInteger > List.FList^[Index2].FInteger) then
        Result := +1
    else if (List.FList^[Index1].FInteger < List.FList^[Index2].FInteger) then
        Result := -1
    else
        Result := 0;
end;

procedure TIntegerList.Sort;
begin
    CustomSort(IntegerListCompare);
end;

procedure TIntegerList.CustomSort(Compare: TIntegerListSortCompare);
begin
    if not Sorted and (FCount > 1) then
    begin
        Changing;
        QuickSort(0, FCount - 1, Compare);
        Changed;
    end;
end;

procedure TIntegerList.SaveToFile(const FileName: WideString);
var
    Stream: TStream;
begin
    Stream := TTntFileStream.Create(FileName, fmCreate);
    try
        SaveToStream(Stream);
    finally
        Stream.Free;
    end;
end;

procedure TIntegerList.SaveToStream(Stream: TStream);
var
    i: integer;
    N: integer;
    Val: IntegerListType;
begin
    N := count;
    Stream.WriteBuffer(N, sizeof(N));
    for i:= 0 to count-1 do
    begin
        val := Integers[i];
        stream.Writebuffer(val, sizeof(val));
    end;
end;

procedure TIntegerList.LoadFromFile(const FileName: WideString);
var
    Stream: TStream;
begin
    Stream := TTntFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
        LoadFromStream(Stream);
    finally
        Stream.Free;
    end;
end;

procedure TIntegerList.LoadFromStream(Stream: TStream);
var
    Size: Integer;
    i: Integer;
    N: IntegerListType;
begin
    {BeginUpdate;  }
    try
        Clear;
        Stream.readbuffer(size,sizeof(size));
        for i := 0 to size - 1 do
        begin
            Stream.Read(N, sizeof(N));
            Add(N);
        end;
    finally
        {EndUpdate;}
    end;
end;


procedure TIntegerList.IsStack;
begin
    OwnsObjects := true;
    Sorted := false;
    Duplicates := dupAccept;
end;

function TIntegerList.Push(AObject: TObject): integer;
begin
    Result := AddObject(0, AObject);
end;

function TIntegerList.Peek(Index: integer): TObject;
begin
    Result := Objects[Count - 1 - Index];
end;

function TIntegerList.Pop(destroy: boolean): TObject;
begin
    Result := Peek;
    if (destroy) then
        Delete(Count - 1)
    else
        Remove(Count - 1);
end;

end.
