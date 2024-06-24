unit telnet;

interface

uses System.Win.ScktComp, System.SysUtils, System.IniFiles, FMX.Forms;

type

  TTelNet = class
  private
    FServerSocket: TServerSocket;
    FPortaTelNet: integer;
    FCustomWinSocket: TCustomWinSocket;
    FMensagem: string;
    procedure AbrirIni;

  public
    property CustomWinSocket: TCustomWinSocket read FCustomWinSocket write FCustomWinSocket;
    property PortaTelNet: integer read FPortaTelNet write FPortaTelNet;
    property Mensagem: string read FMensagem write FMensagem;

    procedure TelNet;
    procedure ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    constructor Create;
    destructor Destoy;
  end;

implementation

{ TTelNet }

uses controller.log;

constructor TTelNet.Create;
begin
  FServerSocket:= TServerSocket.Create(nil);
  FCustomWinSocket:= TCustomWinSocket.Create(-1);
end;

destructor TTelNet.Destoy;
begin
  FreeAndNil(FServerSocket);
  FreeAndNil(FCustomWinSocket);
end;

procedure TTelNet.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  while True do
  begin
    sleep(1000);
    Mensagem := Socket.ReceiveText;
    FMensagem := Socket.ReceiveText;
    log(Socket.ReceiveText);
  end;
end;

procedure TTelNet.TelNet;
begin
  AbrirIni;
  FServerSocket.Port := FPortaTelNet;
  FServerSocket.Active := true;
  log('TelNet Ativado');
  //log(Mensagem);
  //log(FMensagem);
  //ServerSocket1ClientRead(self, CustomWinSocket);
end;

procedure TTelNet.AbrirIni;
var
  LArquivoINI: TIniFile;
  LArqIni: string;
begin
   LArqIni := ExtractFilePath(Application.name) + 'config.ini';

  if not(FileExists(LArqIni)) then
    raise Exception.Create('Arquivo n�o localizado: ' + LArqIni);

  LArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    FPortaTelNet := strtoint(LArquivoINI.ReadString('PARAMETRO','PORTA_TELNET', ''));
  finally
    LArquivoINI.Free;
  end;
end;

end.