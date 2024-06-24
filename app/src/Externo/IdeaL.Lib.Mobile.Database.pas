unit IdeaL.Lib.Mobile.Database;

interface

uses
  System.SysUtils,

  Data.DB,

  FireDAC.Comp.Client,
  FireDAC.DApt;

type
  TMobileDatabase = class
  private
    { private declarations }
    class var FSql: string;

    class function GetDataSet(const AConnection: TFDCustomConnection;
      const ASql: string): TDataSet;
  protected
    { protected declarations }
  public
    { public declarations }
    class procedure ExecSql(const AConnection: TFDCustomConnection; const ASql: string);
    class procedure QryExecSql(const AConnection: TFDCustomConnection; const ASql: string);
    class function GetTables(const AConnection: TFDCustomConnection): TDataSet;
    class function GetTableInfo(const AConnection: TFDCustomConnection; const ATable: string): TDataSet;
    class function GetTriggers(const AConnection: TFDCustomConnection): TDataSet;
    class function GetForeignKey(const AConnection: TFDCustomConnection; const ATable: string): TDataSet;
    class procedure AddField(const AConnection: TFDCustomConnection; const ATable, AField, AType: String; const AOptions: string = '');
    class procedure CreateDatabase(const AFullPath: string);

    class procedure FkEnable(const AConnection: TFDCustomConnection);
    class procedure FkDisable(const AConnection: TFDCustomConnection);
  published
    { published declarations }
  end;

implementation

{ TMobileDatabase }

class procedure TMobileDatabase.AddField(const AConnection: TFDCustomConnection;
  const ATable, AField, AType, AOptions: String);
begin
  ExecSql(AConnection, 'alter table ' + ATable + ' add column ' + AField + ' ' + AType + ' ' + AOptions + ';');
end;

class procedure TMobileDatabase.CreateDatabase;
var
  LArq: TextFile;
begin
  if not(FileExists(AFullPath)) then
  begin
    try
      AssignFile(LArq, AFullPath);
      Rewrite(LArq);
    finally
      CloseFile(LArq);
    end;
  end;
end;

class procedure TMobileDatabase.ExecSql(const AConnection: TFDCustomConnection;
  const ASql: string);
begin
  // Commit, Rollback etc deve ser feito no codigo que chama
  AConnection.ExecSql(ASql);
end;

class procedure TMobileDatabase.FkDisable(
  const AConnection: TFDCustomConnection);
begin
  ExecSql(AConnection, 'PRAGMA foreign_keys = OFF');
end;

class procedure TMobileDatabase.FkEnable(
  const AConnection: TFDCustomConnection);
begin
  ExecSql(AConnection, 'PRAGMA foreign_keys = ON');
end;

class function TMobileDatabase.GetDataSet(const AConnection
  : TFDCustomConnection; const ASql: string): TDataSet;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  LQry.Connection := AConnection;
  LQry.SQL.Add(ASql);
  LQry.Open();
  LQry.Last;
  Result := LQry;
end;

class function TMobileDatabase.GetForeignKey(const AConnection
  : TFDCustomConnection; const ATable: string): TDataSet;
begin
  Result := nil;
  FSql := 'PRAGMA foreign_key_list("' + ATable + '")';
  Result := GetDataSet(AConnection, FSql);
end;

class function TMobileDatabase.GetTableInfo(const AConnection
  : TFDCustomConnection; const ATable: string): TDataSet;
begin
  Result := nil;
  FSql := 'PRAGMA table_info("' + ATable + '")';
  Result := GetDataSet(AConnection, FSql);
end;

class function TMobileDatabase.GetTables(const AConnection: TFDCustomConnection)
  : TDataSet;
begin
  Result := nil;
  FSql := 'select name from sqlite_master where type="table"';
  Result := GetDataSet(AConnection, FSql);
end;

class function TMobileDatabase.GetTriggers(const AConnection
  : TFDCustomConnection): TDataSet;
begin
  Result := nil;
  FSql := 'select * from sqlite_master where type = "trigger"';
  Result := GetDataSet(AConnection, FSql);
end;

class procedure TMobileDatabase.QryExecSql(
  const AConnection: TFDCustomConnection; const ASql: string);
var
  LQry: TFDQuery;
begin
  try
    LQry := TFDQuery.Create(nil);
    LQry.Connection := AConnection;
    LQry.ExecSQL(ASql);
  finally
    FreeAndNil(LQry);
  end;
end;

end.
