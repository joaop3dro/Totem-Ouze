unit model.con;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, System.IniFiles,  System.JSON,
  FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, DataSet.Serialize;

type
  TDmCon = class(TDataModule)
    DbConexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryImagem: TFDQuery;
    qryInsertImagem: TFDQuery;
    qryImagemID: TIntegerField;
    qryImagemIMAGEM: TBlobField;
    qryInsertImagemID: TIntegerField;
    qryInsertImagemIMAGEM: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure abreIni;
  public
    { Public declarations }
    function Get: TJSONObject;
    function Post(ABody: TJSONObject): TJSONObject;
  end;

var
  DmCon: TDmCon;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDmCon.abreIni;
var
  ArquivoINI: TIniFile;
begin
  ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'conf.ini');
  try

    DbConexao.Params.Values['DriverID'] := 'MySQL';
    DbConexao.Params.Values['Server'] := ArquivoINI.ReadString('CONEXAO','SERVER', '');
    DbConexao.Params.Values['Database'] := ArquivoINI.ReadString('CONEXAO','DATABASE', '');
    DbConexao.Params.Values['User_Name'] := ArquivoINI.ReadString('CONEXAO','USERNAME', '');
    DbConexao.Params.Values['Password'] := ArquivoINI.ReadString('CONEXAO', 'PASSWORD', '');
    dbConexao.Params.Values['Port'] := ArquivoINI.ReadString('CONEXAO', 'PORT', '');

  finally
    ArquivoINI.Free;
  end;

end;


procedure TDmCon.DataModuleCreate(Sender: TObject);
begin
  abreIni;
  dbConexao.Connected := true;
end;

function TDmCon.Get: TJSONObject;
begin
  qryImagem.Open;
  Result := qryImagem.ToJSONObject;
  qryImagem.Close;
end;

function TDmCon.Post(ABody: TJSONObject): TJSONObject;
var
  LMaxCod,LmaxCodItem,LmaxCodPag: integer;
  LjaItens,LjaPag  : TJSONArray;
  Ljo:TJSONObject;
begin
    qryInsertImagem.Close;
    qryInsertImagem.Open;
    qryInsertImagem.Append;
    qryInsertImagemID.AsInteger := ABody.GetValue<integer>('id',0);
    qryInsertImagemIMAGEM.AsString := ABody.GetValue<string>('imagem','');
    qryInsertImagem.Post;

    Ljo := TJSONObject.Create;
    Ljo.AddPair('codimagem', ABody.GetValue<integer>('id',0));
    Ljo.AddPair('mensagem','Imagem armazenada com sucesso');
    Result := Ljo;
end;

end.
