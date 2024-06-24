unit view.Principal;

interface

uses
  System.SysUtils,System.StrUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, ACBrPosPrinter, System.TypInfo,
  FMX.Layouts, FMX.Skia, System.JSON, System.DateUtils, ACBrUtil, uGosBase,  System.Net.HttpClientComponent,
  uGosStandard, System.Skia, uFancyDialog,REST.Response.Adapter, Datasnap.DBClient,System.Net.URLClient,
  System.Net.HttpClient,REST.Types, REST.Client,  System.NetEncoding, controller.tempo, System.IniFiles, System.Win.ScktComp
  {$IFDEF MSWINDOWS}
  ,windows, FMX.TabControl, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdSocksServer, IdContext, telnet, FMX.Controls.Presentation, FMX.StdCtrls
  {$ENDIF}
  ;

type
  TfrmPrincipal = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    SkLabel1: TSkLabel;
    Layout2: TLayout;
    SkLabel2: TSkLabel;
    lblVerificar: TSkLabel;
    lblConsultar: TSkLabel;
    lblConsultar2: TSkLabel;
    lblImprimir: TSkLabel;
    lblRealizar: TSkLabel;
    SkLabel3: TSkLabel;
    Layout3: TLayout;
    SkLabel4: TSkLabel;
    SkSvg1: TSkSvg;
    ALRectangle1: TRectangle;
    SkLabel5: TSkLabel;
    Layout4: TLayout;
    TmrVerifica: TTimer;
    tcScreenImage: TTabControl;
    tmrSlide: TTimer;
    Layout5: TLayout;
    TmrVerificaToken: TTimer;
    procedure ALRectangle1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TmrVerificaTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrSlideTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TmrVerificaTokenTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FJsonImagem: TJSONArray;
    function GetScreenImagem: TJSONArray;
    procedure ListaImagem;
    function Consultaimagem(URL: string): string;
    function GetVersaoArq: string;
    procedure AbrirIni;
    procedure VerificarImpressora;
    { Private declarations }
  public
    FPausa: Boolean;
    FTempo : TTempo;
    FTempo_INI: Integer;
    FMSG : TFancyDialog;
    FVersion: String;
    FMenuBoleto: Boolean;
    FMenuFatura: Boolean;
    FMenuExtrato: Boolean;
    FMenuSeguro: Boolean;
    FMenuLimite: Boolean;
    FMenuEmprestimo: Boolean;
    FMenuClubeSTZ: Boolean;
    FServerSocket: TTelNet;
    FSmEmprestimoSimular: Boolean;
    FSmEmprestimoExtrato: Boolean;
    FSmPagarFaturaOpcaoExtrato: Boolean;
    FSMImprimirBoletoOpcaoExtrato: Boolean;
    FPortaImpressora: String;
    FModeloImpressora: Integer;
    FMENSAGEM_EP: String;

    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses view.CPF, uToken, Loading, Notificacao, uConnection, view.menu,
  controller.imagens, uAguarde, LogSQLite, model.fatura,
  controller.impressao, FMX.BitmapHelper, controller.log, uFormat, uFunctions,
  view.SelecaoCartao, view.ClubeSTZ, view.Emprestimo, view.PagarFatura,
  view.Limite, view.ExtratoFatura, view.Seguros;

procedure TfrmPrincipal.ALRectangle1Click(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin

    TThread.Synchronize(nil,
    procedure
    begin
      if not Assigned(frmCPF) then
        Application.CreateForm(TfrmCPF, frmCPF);
    end);

    TThread.Synchronize(nil,
    procedure
    begin
      frmCPF.edtCPF.text := '';
      frmCPF.Show;
      TmrVerifica.Enabled := true;
    end);
  end).Start;
end;

procedure TfrmPrincipal.ListaImagem;
var
  LJson : TJSONValue;
  Ltab : TTabItem;
  Limagem : TRectangle;
  Lcount : Integer;
  LStream: TBytesStream;
begin
  try
    if not ConsultaToken(FURL+'/v1/authentication', FToken) then
    begin
      exit;
    end;

    GetScreenImagem;
    Lcount := 0;
    log('Montando o tabcontrol com as imagens');
    for LJson in FJsonImagem do
    begin

      Ltab := TTabItem.create(self);
      Ltab.parent := tcScreenImage;
      Ltab.Tag := Lcount;
      Ltab.TagString := Ljson.GetValue<string>('time');
      Ltab.Hittest := false;

      Limagem := TRectangle.Create(Self);
      Limagem.Parent := Ltab;
      Limagem.Align := TAlignLayout.Client;
      Limagem.HitTest := true;
      Limagem.OnClick := ALRectangle1Click;
      Limagem.Fill.Kind := TBrushKind.Bitmap;
      Limagem.Fill.Bitmap.Bitmap := BitmapFromBase64(Consultaimagem(Ljson.GetValue<string>('imageUrl')));
      Limagem.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;

      Ltab.AddObject(Limagem);

      tcScreenImage.AddObject(Ltab);

      Lcount := Lcount+1;
    end;

    tcScreenImage.TabIndex := 0;

  except on ex: exception do
    begin
      log('Erro: '+ ex.Message);
    end;

  end;
end;

function TfrmPrincipal.Consultaimagem(URL: string): string;
var
  FRESTClient: TRESTClient;
  FRESTRequest: TRESTRequest;
  FRESTResponse: TRESTResponse;
  LArq: TArray<Byte>;
  Lbase64: string;
begin
  FRESTClient:= TRESTClient.Create(nil);
  FRESTRequest:= TRESTRequest.Create(nil);
  FRESTResponse:= TRESTResponse.Create(nil);
  FRESTClient.SecureProtocols:= [THTTPSecureProtocol.TLS12];
  try
    FRESTRequest.Client:= FRESTClient;
    FRESTRequest.Response:= FRESTResponse;

    FRESTClient.ContentType := 'image/png';
    FRESTClient.AcceptEncoding := 'gzip, deflate, br';

    FRESTClient.BaseURL := URL;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    LArq:= FRESTResponse.RawBytes;
    Lbase64 := TNetEncoding.Base64.EncodeBytesToString(LArq);

    result := Lbase64;
  finally
    FreeAndNil(FRESTClient);
    FreeAndNil(FRESTRequest);
    FreeAndNil(FRESTResponse);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FMSG := TFancyDialog.Create(self);
  FServerSocket := TTelNet.Create;

  FServerSocket.TelNet;

  FVersion := GetVersaoArq;
  SkLabel5.text := 'Sistema de Teste - Versão '+FVersion;
  FTempo := TTempo.Create;
  FPortaImpressora  := GetDefaultPrinterName;
  Log('Iniciando a procedure de leitura do ini');
  AbrirIni;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMSG);
  FreeAndNil(FTempo);
  FreeAndNil(FServerSocket);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and ( key = vk_f1 ) then
    Application.Terminate;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  ListaImagem;
end;

function TfrmPrincipal.GetScreenImagem: TJSONArray;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try
    try
      if LConnection.get(FURL+'/v1/screensaver/image',[],LResult, FToken) then
      begin
        FJsonImagem := TJSONArray.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONArray;
        log('Requisicao realizada');
      end;

    except on ex: exception do
    begin
      log('Erro: '+ ex.Message);
    end;

    end;
  finally
    FreeAndNil(LConnection);
  end;
end;

procedure TfrmPrincipal.TmrVerificaTimer(Sender: TObject);
begin
//  TThread.CreateAnonymousThread(
//  procedure
//  begin
//  end).Start;
  FTempo.VerificaInatividade(FTempo_INI);
end;


procedure TfrmPrincipal.TmrVerificaTokenTimer(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    ConsultaToken(FURL+'/v1/authentication', FToken);

    Log('token atualizado: '+FToken);
  end).Start;

  if (FPortaImpressora <> '') and (FPortaImpressora <> 'Nenhuma Impressora Detectada') then
    VerificarImpressora;
end;

procedure TfrmPrincipal.tmrSlideTimer(Sender: TObject);
begin
  if tcScreenImage.ActiveTab.Tag = tcScreenImage.TabCount-1 then
  begin
    tcScreenImage.TabIndex := 0;
    tmrSlide.Interval := strtoint(tcScreenImage.ActiveTab.TagString) * 1000;
  end
  else
  begin
    tcScreenImage.TabIndex := tcScreenImage.ActiveTab.Tag+1;
    tmrSlide.Interval := strtoint(tcScreenImage.ActiveTab.TagString) * 1000;
  end;
end;

function TfrmPrincipal.GetVersaoArq: string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(
    ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0,
    VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue),
    VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(
      dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(
      dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(
      dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure TfrmPrincipal.AbrirIni;
var
  LArquivoINI: TIniFile;
  LArqIni: string;
begin
   LArqIni := ExtractFilePath(Application.Name) + 'config.ini';

  if not(FileExists(LArqIni)) then
  begin
    log(LArqIni + ' - Não encontrado');
    raise Exception.Create('Arquivo não localizado: ' + LArqIni);
  end;

  log(LArqIni + ' - encontrado');

  LArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    FTempo_INI  :=  strtoint(LArquivoINI.ReadString('PARAMETRO','TEMPO_INATIVIDADE', ''));
    FMenuBoleto := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_Boleto', ''));
    FMenuFatura := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_PagarFatura', ''));
    FMenuExtrato:= StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_ExtratoFatura', ''));
    FMenuSeguro := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_Limite', ''));
    FMenuLimite := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_Seguro', ''));
    FMenuEmprestimo := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_Emprestimo', ''));
    FMenuClubeSTZ := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','M_Clube', ''));
    FSmEmprestimoSimular := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','SM_Emprestimo_Simular', ''));
    FSmEmprestimoExtrato := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','SM_Emprestimo_Extrato', ''));
    FSmPagarFaturaOpcaoExtrato := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','SM_PagarFatura_OpcaoExtrato', ''));
    FSMImprimirBoletoOpcaoExtrato := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','SM_ImprimirBoleto_OpcaoExtrato', ''));
    FSMImprimirBoletoOpcaoExtrato := StrToBoolean(LArquivoINI.ReadString('PARAMETRO','SM_ImprimirBoleto_OpcaoExtrato', ''));
    FModeloImpressora := strtoint(LArquivoINI.ReadString('PARAMETRO','MODELO_IMPRESSORA', ''));
    FPortaImpressora  := GetDefaultPrinterName;
    FMENSAGEM_EP := LArquivoINI.ReadString('EMPRESTIMO','MENSAGEM', '');
  finally
    LArquivoINI.Free;
  end;
end;

procedure TfrmPrincipal.VerificarImpressora;
var
  LPosPrinter : TImprimir;
  Lstatus : TACBrPosPrinterStatus;
  i : TACBrPosTipoStatus;
  LStr: string;
begin
  LPosPrinter := TImprimir.Create;
  try
    Lstatus := LPosPrinter.StatusImpressora;

    if Lstatus = [] then
      Log('Status: Nenhum status retornado')
    else
    begin
      LStr := '';
      For i := Low(TACBrPosTipoStatus) to High(TACBrPosTipoStatus) do
      begin
        if i in Lstatus then
        begin
          if i = TACBrPosTipoStatus.stPoucoPapel then
          begin
            if Assigned(frmCPF) then
              if frmCPF.Visible then
                TLoading.ToastMessage(frmCPF,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmSelecaoCartao) then
              if frmSelecaoCartao.Visible then
                TLoading.ToastMessage(frmSelecaoCartao,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmExtratoFatura) then
              if frmExtratoFatura.Visible then
                TLoading.ToastMessage(frmExtratoFatura,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmEmprestimo) then
              if frmEmprestimo.Visible then
                TLoading.ToastMessage(frmEmprestimo,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmMenu) then
              if frmMenu.Visible then
                TLoading.ToastMessage(frmMenu,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmPagarFatura) then
              if frmPagarFatura.Visible then
                TLoading.ToastMessage(frmPagarFatura,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmClubeSTZ) then
              if frmClubeSTZ.Visible then
                TLoading.ToastMessage(frmClubeSTZ,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmLimite) then
              if frmLimite.Visible then
                TLoading.ToastMessage(frmLimite,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmSeguros) then
              if frmSeguros.Visible then
                TLoading.ToastMessage(frmSeguros,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            if Assigned(frmPrincipal) then
              if frmPrincipal.Visible then
                TLoading.ToastMessage(frmPrincipal,'Impressora está com pouco papel',5,TAlignLayout.MostRight);

            Log('Impressora está com pouco papel');
          end;
          LStr := LStr + GetEnumName(TypeInfo(TACBrPosTipoStatus), integer(i) )+ ', ';
        end;
      end;
      Log('Status Impressora: '+LStr);
    end;

  finally

  end;
end;

end.
