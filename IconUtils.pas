unit IconUtils;

interface
uses NkDIB;

procedure SaveIcon(DIB:TNkDIB; FileName:String);

implementation
uses Classes, Windows, SysUtils;

type
  PIconDir=^TIconDir;
  TIconDir=packed record
   idReserved:Word;
   idType:Word;
   idCount:Word;
  end;

type
  PIconDirEntry=^TIconDirEntry;
  TIconDirEntry=packed record
    bWidth:Byte;
    bHeight:Byte;
    bColorCount:Byte;
    bReserved:Byte;
    wPlanes:Word;
    wBitCount:Word;
    dwByteInRes:DWord;
    dwImageOffset:DWord;
  end;

procedure SaveIcon(DIB:TNkDIB; FileName:String);
var FS: TFileStream;
    MS: TMemoryStream;
    ID: TIconDir;
    IDE: TIconDirEntry;
    pBIH: PBitmapInfoHeader;
    pAnd: Pointer;
    AndLength : Integer;
begin
  //圧縮を解く
  case DIB.PixelFormat of
    nkPf4BitRLE: DIB.PixelFormat := nkPf4Bit;
    nkPf8BitRLE: DIB.PixelFormat := nkPf8Bit;
  end;

  // TIconDir構造体 の設定
  with ID do begin
    idReserved:=0; idType:=1; idCount:=1;
  end;

  // TIconDirEntry構造体 の設定
  with IDE do begin
    bWidth:=DIB.Width; bHeight:=DIB.Height;

    case DIB.BitCount of
      1:  begin bColorCount:=2 ; DIB.PaletteSize := 2;   end;
      4:  begin bColorCount:=16; DIB.PaletteSize := 16;  end;
      8:  begin bColorCount:=0 ; DIB.PaletteSize := 256; end;
      24: begin bColorCount:=0 ; DIB.PaletteSize := 0;   end;
    end;

    bReserved := 0; wPlanes:=1; wBitCount:= DIB.BitCount;

    dwByteInRes:= SizeOf(TBitmapInfoHeader)
     +((DIB.Width * DIB.BitCount + 31) div 32) * 4 * DIB.Height
     +SizeOf(TRGBQuad)* DIB.PaletteSize
     +((DIB.Width + 31) div 32) * 4 * DIB.Height;

    dwImageOffset:=SizeOf(TIconDir)+SizeOf(TIconDirEntry);
  end;

  // アイコンの書出し
  FS:=TFileStream.Create(FileName, fmCreate);
  try
   FS.Write(ID, SizeOf(TIconDir));
   FS.Write(IDE, SizeOf(TIconDirEntry));

   MS := TMemoryStream.Create;
   try
     DIB.SaveToStream(MS);
     pBIH := PBitmapInfoHeader(LongInt(MS.Memory) + 14);
     pBih.biHeight := pBih.biHeight * 2;
     pBih.biClrUsed := 0;
     MS.Seek(SizeOf(TBitmapFileHeader), 0);
     FS.WriteBuffer(pBIH^, MS.Size - SizeOf(TBitmapFileHeader));
   finally
     MS.Free;
   end;

   AndLength := ((DIB.Width + 31) div 32) * 4 * DIB.Height;
   pAnd := AllocMem(AndLength);
   try
     FS.Write(pAnd^, AndLength);
   finally
     FreeMem(pAnd);
   end;

  finally
   FS.Free;
  end;
end;

end.

