unit controller.impressao;

interface

uses System.Classes,FMX.Types, FMX.Memo, System.StrUtils, ACBrPosPrinter,
System.SysUtils, ACBrUtil.Strings;

type
  TInformacoesImpressao = record
    RazaoSocial:string;
    Endereco:string;
    CNPJ:string;
    MensagemFinal:string;
  end;

  TImprimir = class
  private
    FACBrPosPrinter: TACBrPosPrinter;
    FImp:TStringList;
    FInformacoesImpressao: TInformacoesImpressao;
    FColunas: integer;
    procedure ConfigurarComponente;
    function PedirPermissoes: Boolean;
  public
    property InformacoesImpressao: TInformacoesImpressao read FInformacoesImpressao write FInformacoesImpressao;
    property Colunas: integer read FColunas write FColunas;

    procedure Imprimir(AStrinList: TStringList);
    function StatusImpressora: TACBrPosPrinterStatus;
    constructor Create;
    destructor Destoy;
  end;

implementation

uses view.Principal, Notificacao, controller.log, System.NetEncoding;

constructor TImprimir.Create;
begin
  FACBrPosPrinter:= TACBrPosPrinter.Create(nil);
  ConfigurarComponente;
end;

destructor TImprimir.Destoy;
begin
  FreeAndNil(FACBrPosPrinter);
end;

function TImprimir.PedirPermissoes: Boolean;
begin
  Result := FACBrPosPrinter.Device.PedirPermissoes;
end;

procedure TImprimir.ConfigurarComponente;
begin
  FACBrPosPrinter.Modelo := TACBrPosPrinterModelo(frmPrincipal.FModeloImpressora);
  if frmPrincipal.FPortaImpressora = 'Nenhuma Impressora Detectada' then
  begin
    log('Impressora padrão não definida');
  end
  else
    FACBrPosPrinter.Porta :='RAW:'+frmPrincipal.FPortaImpressora;
  FACBrPosPrinter.PaginaDeCodigo := TACBrPosPaginaCodigo.pc850;
  FACBrPosPrinter.ColunasFonteNormal := 53;
  FACBrPosPrinter.Device.Baud := 115200;

//  FACBrPosPrinter.CortaPapel := true;
  FACBrPosPrinter.EspacoEntreLinhas := 1;
  FACBrPosPrinter.LinhasEntreCupons := 5;
  FACBrPosPrinter.ConfigBarras.Altura:= 150;
//  FACBrPosPrinter.ConfigLogo.KeyCode1 := 1;
//  FACBrPosPrinter.ConfigLogo.KeyCode2 := 0;
  FACBrPosPrinter.ControlePorta := true;
//  FACBrPosPrinter.Device.SendBytesCount := 512;
//  FACBrPosPrinter.Device.SendBytesInterval:= 20;
  FACBrPosPrinter.ConfigurarRegiaoModoPagina(-60,0,0,112,dirEsquerdaParaDireita);
  FACBrPosPrinter.ConfigModoPagina.Esquerda := -50;
//  FACBrPosPrinter.LinhasBuffer := 5;
end;

procedure TImprimir.Imprimir(AStrinList: TStringList);
var
  LLinha:string;
  LStream: TBytesStream;
  LArqLocal : string;
begin
  if frmPrincipal.FPortaImpressora = 'Nenhuma Impressora Detectada' then
  begin
    log('Impressora na porta: '+frmPrincipal.FPortaImpressora);
  end
  else
    Log('Impressora na porta: '+frmPrincipal.FPortaImpressora);

  FACBrPosPrinter.Buffer.Text := AStrinList.Text;
  FACBrPosPrinter.ConfigBarras.Altura:= 100;
  FACBrPosPrinter.Imprimir;
  // verificando das informacoes do dispositivo
  //log(FACBrPosPrinter.device.LerInfoDispositivos);
  log(AStrinList.Text);
  log(FACBrPosPrinter.Porta);
  log('imprmiu');

//  LArqLocal := GetCurrentDir + '\extrato\'+datetostr(date).Replace('/','-')+'.pdf';
//  LStream:= TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(FACBrPosPrinter.Buffer.Text));
//  try
//    if Assigned(LStream) then
//    begin
//      LStream.Position := 0;
//      LStream.SaveToFile(LArqLocal);
//    end;
//
//  finally
//    FreeAndNil(LStream);
//  end;
end;

function TImprimir.StatusImpressora: TACBrPosPrinterStatus;
begin
  if Assigned(FACBrPosPrinter) then
  begin
    if not FACBrPosPrinter.Ativo then
      FACBrPosPrinter.Ativar;

    result := FACBrPosPrinter.LerStatusImpressora;

  end;
end;


end.
