unit untCfg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

procedure initCfg(newFile: Boolean);
function getCfg(mainFile: string; lib: string): TStringList;

implementation

const
   SPLIT = {$IFDEF WINDOWS}'\'{$ELSE}'/'{$ENDIF};

procedure writeCfgFile(path: String);
begin
  with TStringList.Create do begin
    Add('-B');
    Add('-MObjFPC');
    Add('-Scghi');
    Add('-vewnhibq');
    Add('-Cg');
    Add('-O1');
    SaveToFile(path);
    Free;
  end;
end;

procedure initCfg(newFile: Boolean);
var
  path: string;
begin
  path := GetCurrentDir + SPLIT + 'fpccmd.cfg';
  if (newFile) then begin
    if (FileExists(path)) then begin
      WriteLn('fpccmd.cfg already exists.');
      Exit;
    end;
    writeCfgFile(path);
  end else begin
    if (not FileExists(path)) then begin
      WriteLn('fpccmd.cfg not exists.');
      Exit;
    end;
    writeCfgFile(path);
  end;
end;

procedure getDirs(base: string; outList: TStringList);
var
  src: TSearchRec;
begin
  if (FindFirst(base + '*', faAnyFile, src) = 0) then begin
    repeat
      if (src.Name <> '.') and (src.Name <> '..') and (src.Name <> 'lib') and (src.Name <> 'out') and (src.Name <> 'build')  then begin
        if (DirectoryExists(base + src.Name)) then begin
          outList.Add(base + src.Name);
          getDirs(base + src.Name + SPLIT, outList);
        end;
      end;
    until FindNext(src) <> 0;
    FindClose(src);
  end;
end;

procedure relativeDirs(base: string; outList: TStringList);
var
  i: Integer;
begin
  for i := 0 to outList.Count - 1 do begin
    outList[i] := outList[i].Replace(base, '');
  end;
end;

function getCfg(mainFile: string; lib: string): TStringList;
var
  base: string;
  path: string;
  dirs: TStringList;
  s: string;
begin
  base := ExtractFilePath(mainFile);
  if (not base.EndsWith(SPLIT)) then begin
    base += SPLIT;
  end;
  if (base = SPLIT) then begin
    base := GetCurrentDir + SPLIT;
  end;
  SetCurrentDir(base);
  if (not DirectoryExists(base + lib)) then begin
    ForceDirectories(base + lib);
  end;
  path := base + 'fpccmd.cfg';
  Result := TStringList.Create;
  if (FileExists(path)) then begin
    Result.LoadFromFile(path);
  end;
  Result.Add('-Fi' + LIB);
  Result.Add('-FU' + LIB);
  Result.Add('-Fu.');
  Result.Add('-Fi.');
  dirs := TStringList.Create;
  getDirs(base, dirs);
  relativeDirs(base, dirs);
  for s in dirs do begin
    Result.Add('-Fi' + s);
    Result.Add('-Fu' + s);
  end;
  dirs.Free;
end;



end.

