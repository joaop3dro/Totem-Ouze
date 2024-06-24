unit IdeaL.Lib.IDataSet;

interface

uses
  System.Classes,

  Data.DB;

type
  IDataSet = Interface(IInterface)
    ['{34D6ED78-CE09-4AC6-82EE-AF6A30AD0031}']
    procedure QryExecSql(const ASql: string);
    procedure ConnExecSql(const ASql: string);
    procedure ConnCommit();
    procedure ConnRollBack();
    procedure ConnStartTransaction();
    function GetListagem(const ASql: string): TDataSet;
    function GetDateTime: string;
    procedure ApplyUpdates(ADs: TDataSet);
  End;

implementation

end.
