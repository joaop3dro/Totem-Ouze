unit controller.log;

interface

uses System.sysUtils, FMX.forms, System.Classes
 ,System.Zip, vcl.forms;

procedure Log(AStr:string);
procedure CompactaLog(AListArq: TStringList);
procedure DeletaArquivo(AListArq:TStringList);
procedure DeletaZIP(AValidade: Integer);

implementation

uses
  System.IniFiles;

procedure Log(AStr:string);
var
 LArqLog,LArqIni,LArqAntr:string;
 LFile:TStringList;
 LArquivo: TextFile;
 size: Longint;
 LGeraLog: String;
 LValidadeArq: integer;
 LIniFile: TIniFile;
 I: integer;
 LStringList: TStringList;
begin
  //Criar pasta de Log caso não exista
  if not DirectoryExists(GetCurrentDir+'\Log') then
    ForceDirectories(GetCurrentDir+'\Log');

  LArqIni := ExtractFilePath(Application.ExeName) + 'config.ini';

  if not(FileExists(LArqIni)) then
    raise Exception.Create('Arquivo não localizado: ' + LArqIni);

  LIniFile := TIniFile.Create(LArqIni);
  try
    LGeraLog := LIniFile.ReadString('CONTROLE_LOG', 'GERAR_LOG', '');
    LValidadeArq := strtoint(LIniFile.ReadString('CONTROLE_LOG', 'VALIDADE_DIAS', '90'));
  finally
    FreeAndNil(LIniFile);
  end;

  LArqLog := (ExtractFilePath(Application.ExeName)+'Log\' + 'OuzeLog-'+FormatDateTime('dd-mm-yyyy',date)+'.txt');

  AssignFile(LArquivo, LArqLog);
  if FileExists(LArqLog) then
    Append(LArquivo)
  else
  begin
    DeletaZIP(LValidadeArq);

    LStringList := TStringList.Create;
    try
      for I := 1 to 7 do
      begin
        LArqAntr := ExtractFilePath(Application.ExeName)+'Log\' + 'OuzeLog-'+FormatDateTime('dd-mm-yyyy',date-I)+'.txt';
        if FileExists(LArqAntr) then
        begin
          LStringList.Add(LArqAntr.Replace(ExtractFilePath(Application.ExeName)+'Log\',''));
        end;
      end;

      if (DayOfWeek(date) = 2) or (LStringList.Count >= 7) then
      begin
        if LStringList.Count > 0 then
        begin
          CompactaLog(LStringList);
          DeletaArquivo(LStringList);
        end;
      end;
    finally
      FreeAndNil(LStringList);
    end;
    ReWrite(LArquivo);
  end;

  try
    WriteLn(LArquivo,(''''+ FormatDateTime('dd/mm/yyyy', now) + ' - ' + FormatDateTime('hh:nn:ss',now) + '''' + AStr));
    size := FileSize(LArquivo);
  finally
    CloseFile(LArquivo);
  end;

end;

procedure CompactaLog(AListArq: TStringList);
var
  ZipFile: TZipFile;
  i: integer;
  Lperiodo:string;
begin
  ZipFile := TZipFile.Create;
  try
    Lperiodo := (AListArq[AListArq.Count-1].Replace('.txt','')+'-a-'+AListArq[0].Replace('OuzeLog-','').Replace('.txt','.zip'));

    ZipFile.Open(GetCurrentDir + '\log\'+Lperiodo, zmWrite);

    for i:=0 to AListArq.Count-1 do
    begin
      ZipFile.Add(GetCurrentDir + '\log\'+AListArq[i]);
    end;


  finally
    ZipFile.Free;
  end;
end;

procedure DeletaArquivo(AListArq:TStringList);
var
  SearchRec : TSearchRec;
  Data: string;
  i: integer;
begin
  try
    for i:=0 to AListArq.Count-1 do
    begin
      FindFirst(GetCurrentDir +'\log\'+AListArq[i], faAnyFile, SearchRec);

      if SearchRec.name <> '' then
        DeleteFile(GetCurrentDir +'\log\'+ SearchRec.name);

    end;
  finally
    FindClose(SearchRec);
  end;
end;

procedure DeletaZIP(AValidade: Integer);
var
  SearchRec : TSearchRec;
begin
  try
    if FindFirst(GetCurrentDir +'\log\'+'*.zip', faAnyFile, SearchRec) = 0 then
    begin
      repeat
        if Trunc(now - SearchRec.TimeStamp) >= AValidade then
          DeleteFile(GetCurrentDir +'\log\'+ SearchRec.name);
      until FindNext(SearchRec) <> 0;
    end;
  finally
    FindClose(SearchRec);
  end;
end;

end.
