﻿unit view.ExtratoFatura;

interface

uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Skia,
  System.ImageList,
  System.Actions,
  System.Generics.Collections,
  System.NetEncoding,
  System.JSON,
  System.DateUtils,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Filter.Effects,
  FMX.Ani,
  FMX.Skia,
  FMX.Layouts,
  FMX.ActnList,
  FMX.TabControl,
  FMX.Objects,
  FMX.Effects,
  FMX.ImgList,
  uGosBase,
  uGosEdit,
  uGosObjects,
  uGosStandard,
  frame.extrato,
  frame.Fatura,
  uFancyDialog, CryptBase,  MiscObj, RSAObj, System.Net.HttpClientComponent, System.Net.HttpClient, System.Net.URLClient;

type
  TfrmExtratoFatura = class(TForm)
    ALRectangle1: TRectangle;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Layout4: TLayout;
    edtSenha: TGosEditView;
    Rectangle4: TRectangle;
    Glyph2: TGlyph;
    FillRGBEffect2: TFillRGBEffect;
    ImageList1: TImageList;
    TabControl1: TTabControl;
    tabLoginSenha: TTabItem;
    tabExtratoFatura: TTabItem;
    tabDetalheExtrato: TTabItem;
    ActionList1: TActionList;
    actTabLoginSenha: TChangeTabAction;
    actTabExtratoFatura: TChangeTabAction;
    actTabDetalheExtrato: TChangeTabAction;
    Rectangle2: TRectangle;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    SkLabel5: TSkLabel;
    SkLabel6: TSkLabel;
    Layout14: TLayout;
    Rectangle6: TRectangle;
    Layout15: TLayout;
    Layout16: TLayout;
    SkLabel8: TSkLabel;
    lblValor: TSkLabel;
    Rectangle7: TRectangle;
    lblmes: TSkLabel;
    Layout17: TLayout;
    SkLabel9: TSkLabel;
    lblDataVencimento: TSkLabel;
    GosLine1: TGosLine;
    Layout18: TLayout;
    SkLabel10: TSkLabel;
    lbldataPagamento: TSkLabel;
    Rectangle8: TRectangle;
    Layout19: TLayout;
    Layout20: TLayout;
    SkLabel11: TSkLabel;
    SkLabel12: TSkLabel;
    Rectangle9: TRectangle;
    SkLabel13: TSkLabel;
    Layout21: TLayout;
    SkLabel14: TSkLabel;
    SkLabel15: TSkLabel;
    GosLine2: TGosLine;
    Layout22: TLayout;
    SkLabel16: TSkLabel;
    SkLabel17: TSkLabel;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    Rectangle10: TRectangle;
    Layout23: TLayout;
    Layout24: TLayout;
    SkLabel18: TSkLabel;
    SkLabel19: TSkLabel;
    Rectangle11: TRectangle;
    SkLabel20: TSkLabel;
    Layout25: TLayout;
    SkLabel21: TSkLabel;
    SkLabel22: TSkLabel;
    GosLine3: TGosLine;
    Layout26: TLayout;
    SkLabel23: TSkLabel;
    SkLabel24: TSkLabel;
    Layout46: TLayout;
    SkSvg16: TSkSvg;
    Layout27: TLayout;
    SkSvg6: TSkSvg;
    Rectangle12: TRectangle;
    Layout28: TLayout;
    Layout29: TLayout;
    Layout30: TLayout;
    SkLabel25: TSkLabel;
    lblSubtitulo: TSkLabel;
    Layout33: TLayout;
    Rectangle17: TRectangle;
    Layout39: TLayout;
    Layout40: TLayout;
    lblTotal: TSkLabel;
    lblValorTotal: TSkLabel;
    Rectangle18: TRectangle;
    lblMesFatura: TSkLabel;
    GosLine5: TGosLine;
    Layout42: TLayout;
    SkLabel40: TSkLabel;
    Layout41: TLayout;
    SkLabel38: TSkLabel;
    lblVencimento: TSkLabel;
    SkLabel26: TSkLabel;
    SkLabel28: TSkLabel;
    SkLabel29: TSkLabel;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Layout12: TLayout;
    Layout13: TLayout;
    SkLabel7: TSkLabel;
    SkSvg5: TSkSvg;
    btnExtrato: TRectangle;
    Layout32: TLayout;
    SkSvg9: TSkSvg;
    SkLabel27: TSkLabel;
    btnPagar: TRectangle;
    Layout34: TLayout;
    SkSvg10: TSkSvg;
    SkLabel30: TSkLabel;
    lylTecladoNumerico: TLayout;
    FloatAnimation2: TFloatAnimation;
    Layout10: TLayout;
    btn4: TGosButtonView;
    btn5: TGosButtonView;
    btn6: TGosButtonView;
    Layout11: TLayout;
    btn0: TGosButtonView;
    btnEnviar: TGosButtonView;
    btnCorrigir: TGosButtonView;
    Line1: TLine;
    Layout8: TLayout;
    btn7: TGosButtonView;
    btn8: TGosButtonView;
    btn9: TGosButtonView;
    Layout9: TLayout;
    btn1: TGosButtonView;
    btn3: TGosButtonView;
    btn2: TGosButtonView;
    btnSair: TGosButtonView;
    SkSvg3: TSkSvg;
    btnVoltar: TGosButtonView;
    SkSvg4: TSkSvg;
    recSairExtr: TGosButtonView;
    SkSvg11: TSkSvg;
    recVoltarExtr: TGosButtonView;
    SkSvg12: TSkSvg;
    GosButtonView1: TGosButtonView;
    SkSvg1: TSkSvg;
    GosButtonView2: TGosButtonView;
    SkSvg2: TSkSvg;
    Layout47: TLayout;
    SkLabel3: TSkLabel;
    ScrollFatura: THorzScrollBox;
    RSA: TRSAEncSign;
    lylScroll: TLayout;
    lblInfo: TSkLabel;
    skloading: TSkAnimatedImage;
    lylLoading: TLayout;
    Layout31: TLayout;
    lblTituloLoading: TSkLabel;
    lblSubtituloLoading: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    recLoading: TRectangle;
    TabItem1: TTabItem;
    Rectangle1: TRectangle;
    Layout36: TLayout;
    GosButtonView5: TGosButtonView;
    SkSvg7: TSkSvg;
    GosButtonView6: TGosButtonView;
    SkSvg8: TSkSvg;
    Layout37: TLayout;
    Layout38: TLayout;
    SkLabel4: TSkLabel;
    SkLabel31: TSkLabel;
    Layout35: TLayout;
    Layout43: TLayout;
    Rectangle21: TRectangle;
    SkLabel34: TSkLabel;
    Rectangle22: TRectangle;
    SkLabel35: TSkLabel;
    Rectangle23: TRectangle;
    Image1: TImage;
    actTabPix: TChangeTabAction;
    lylDetalhe: TLayout;
    Layout44: TLayout;
    Layout48: TLayout;
    Layout49: TLayout;
    Layout50: TLayout;
    Layout51: TLayout;
    Layout52: TLayout;
    btnBoleto: TRectangle;
    Layout53: TLayout;
    SkSvg13: TSkSvg;
    SkLabel32: TSkLabel;
    procedure btn1Click(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Rectangle13Click(Sender: TObject);
//    procedure Layout32Click(Sender: TObject);
    procedure recSairExtrClick(Sender: TObject);
    procedure recVoltarExtrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Rectangle14Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure GosButtonView2Click(Sender: TObject);
    procedure GosButtonView1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Rectangle4Click(Sender: TObject);
    procedure btnCorrigirClick(Sender: TObject);
    procedure btnPagarClick(Sender: TObject);
    procedure btnExtratoClick(Sender: TObject);
    procedure GosButtonView6Click(Sender: TObject);
    procedure btnBoletoClick(Sender: TObject);
  private
    FID  : string;
    FCPF : string;
    FMSG : TFancyDialog;
    FIDCard : string;
    FFrmLstVert: TFrameListModel;
    FFrmLstItensFatura: TFrameListModel;
    FFrmLstHorz1: TFrameListModel;
    FListaFrame : TList<TframeExtrato>;
    FListaFrameF: TList<TframeFatura>;
    FQrCode    : TStream;
    FCabecalho : TStringList;
    FRodape   : TStringList;
    function ValidaSenha(out Amesseger:string): boolean;
    function ConsultaFatura(AIdAccount:string; out AJsonFatura: TJSONArray): Boolean;
    function MontaExtrato: Boolean;
    procedure SairConta;
    procedure ListaFatura(AjsonFaturas: TJSONArray);
{$IFDEF MSWINDOWS}
    procedure ItemClick(Sender: TObject);
{$ELSE}
    procedure ItemClick(Sender: TObject; const Point: TPointF);
{$ENDIF}
    { Private declarations }
  public
    FListaFaturas: TList<TFrameItemListModel>;
    function ConsultaExtratoFatura(AIdAccount,Adata:string; Out AjsonExtato: TJSONObject ): Boolean;
    procedure carregaTela(Aid,Acpf, AidCard:string);
    procedure ListaItensFatura(AJsonExtrato: TJSONObject; ACor: Cardinal; AMes,AVencimento,AValor: string);
    function ConsultaQRCode(ACPF, ADataVencimento, AIdProduto: string; out AResult: TStream): boolean;
    { Public declarations }
  end;

var
  frmExtratoFatura: TfrmExtratoFatura;

implementation

{$R *.fmx}

uses Notificacao, view.Principal, view.menu, uAguarde,
  uToken, uConnection, model.fatura, uFormataCampos, LogSQLite,
  controller.imagens,
  IdeaL.Lib.View.Utils,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1, view.SelecaoCartao, controller.log,
  view.PagarFatura, controller.impressao, ACBrUtil;

procedure TfrmExtratoFatura.btn1Click(Sender: TObject);
begin
  edtSenha.Text := edtSenha.Text + TGosButtonView(Sender).Text;
end;

procedure TfrmExtratoFatura.carregaTela(Aid,Acpf, AidCard: string);
begin
  FID := Aid;
  FCPF:= Acpf;
  FIDCard := AidCard;

  if (frmPrincipal.FSmPagarFaturaOpcaoExtrato) or (frmPrincipal.FMenuFatura) then
    btnPagar.Visible := true
  else
    btnPagar.Visible := false;

  if (frmPrincipal.FSMImprimirBoletoOpcaoExtrato) or (frmPrincipal.FMenuBoleto) then
    btnBoleto.Visible := true
  else
    btnBoleto.Visible := false;
end;

function TfrmExtratoFatura.MontaExtrato: Boolean;
var
  LImprimir: TImprimir;
  LDescricao: string;
  var LCountCabecalho: integer;
begin
  if frmPrincipal.FPortaImpressora = 'Nenhuma Impressora Detectada' then
  begin
    log('Impressora padrão não definida');
    exit;
  end;

  FCabecalho := TStringList.Create;
  LImprimir := TImprimir.Create;

  try
    try
      log('populando componente');
      FCabecalho.Clear;
      FCabecalho.Add('</zera>');
      FCabecalho.Add('</ce><e><n>'+'Extrato da Fatura'+'</n></e>');
      LCountCabecalho := Length(lblMesFatura.Text +' Vencimento: ' + lblVencimento.Text + ' Total ' + lblValorTotal.Text);

      FCabecalho.Add('</ae>'+(lblMesFatura.Text) +' Vencimento: ' + lblVencimento.Text +StringofChar(' ',53-LCountCabecalho)+'Total ' + lblValorTotal.Text);
      FCabecalho.Add('</zera>');

      FCabecalho.Add('<n>Data Compra  Local                         Valor</n>');
      FCabecalho.Add('</linha_simples>');

      dmfatura.memExtratoDetalhado.IndexFieldNames := 'DATA:D';
      dmfatura.memExtratoDetalhado.Open;
      dmfatura.memExtratoDetalhado.Refresh;
      dmfatura.memExtratoDetalhado.First;
      while not dmfatura.memExtratoDetalhado.Eof do
      begin
        LDescricao := dmfatura.memExtratoDetalhadoDESCRICAO.AsString +' '+ dmfatura.memExtratoDetalhadoPARCELAS.AsString;
        FCabecalho.Add('</ae>'+dmfatura.memExtratoDetalhadoDATA_COMPRA.AsString+ '     ' +
                      copy(LDescricao,1,27)+StringofChar(' ',27- Length(copy(LDescricao,1,27)))+ ' ' +
                      dmfatura.memExtratoDetalhadoVALOR.AsString+'</fn>');

        dmfatura.memExtratoDetalhado.Next;
      end;

      FCabecalho.Add('</linha_simples>');
      FCabecalho.Add('');
      FCabecalho.Add('</corte_total>');
      log('mandando imprimir extrato');
      LImprimir.Imprimir(FCabecalho);
      log('Imprimiu Cabeçalho extrato');

      result:= true;

    except on ex: exception do
      begin
        result := false;
        log('Erro: '+ ex.Message);
      end;

    end;

  finally
    FreeAndNil(FCabecalho);
    FreeAndNil(LImprimir);
//    dmfatura.memExtratoDetalhado.Close;
  end;
end;


procedure TfrmExtratoFatura.btnExtratoClick(Sender: TObject);
begin
{$REGION 'Extrato'}
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Imprimir Extrato';
  lblSubtituloLoading.Text := 'Aguarde enquanto o extrato é impresso';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if not MontaExtrato then
      begin
        TLoading.ToastMessage(frmExtratoFatura,'Erro ao Imprimir Extrato' ,4,TAlignLayout.MostRight);
        exit;
      end
      else
      begin
        TLoading.ToastMessage(frmExtratoFatura,'Extrato Impresso com sucesso' ,4,TAlignLayout.MostRight);
      end;

    finally
      TThread.Synchronize(nil,
      procedure
      begin
        recLoading.Visible := false;
        lylLoading.Visible := false;
      end);
    end;
  end).Start;

{$ENDREGION}
end;

procedure TfrmExtratoFatura.btnBoletoClick(Sender: TObject);
begin
  {$REGION 'Boleto'}
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Imprimir Boleto';
  lblSubtituloLoading.Text := 'Aguarde enquanto o boleto é impresso';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          TLoading.ToastMessage(frmExtratoFatura,'Erro ao buscar Token' ,5,TAlignLayout.MostRight);
          exit;
        end;
      end;

      frmMenu.GerarBoleto(frmMenu.FIdAccount, frmMenu.FjsonBoleto);

      if not frmMenu.MontaCupom then
      begin
        TLoading.ToastMessage(frmExtratoFatura,'Erro ao Imprimir Boleto' ,4,TAlignLayout.MostRight);
        exit;
      end
      else
      begin
        TLoading.ToastMessage(frmExtratoFatura,'Boleto Impresso com sucesso' ,4,TAlignLayout.MostRight);
      end;
    finally
      TThread.Synchronize(nil,
      procedure
      begin
        recLoading.Visible := false;
        lylLoading.Visible := false;
      end);
    end;
  end).Start;


  {$ENDREGION}
end;

procedure TfrmExtratoFatura.btnCorrigirClick(Sender: TObject);
begin
  edtSenha.Text := '';
end;

procedure TfrmExtratoFatura.btnEnviarClick(Sender: TObject);
var
  LJsonFatura: TJSONArray;
  LMessagem: string;
begin
  if length(edtSenha.Text) <> 4 then
  begin
    TLoading.ToastMessage(frmExtratoFatura,'Senha Invalida!',4,TAlignLayout.MostRight);
    exit;
  end;

  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Validando Informação';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      try
        Log('Verificando token para endpoint de extrato de fatura');
        if not FToken.IsEmpty  then
        begin
          if FToken.IsEmpty  then
          begin
            if not ConsultaToken(FURL+'/v1/authentication', FToken) then
            begin
              TLoading.ToastMessage(frmExtratoFatura,'Erro ao buscar Token' ,5,TAlignLayout.MostRight);
              Log('Erro ao verificar token');
              exit;
            end;
          end;
        end;

        {$REGION 'VALIDA SENHA EM DESENVOLVIMENTO'}
        Log('Realizando a validação da senha');
        if not ValidaSenha(LMessagem) then
        begin
          TLoading.ToastMessage(frmExtratoFatura,LMessagem,5,TAlignLayout.MostRight);
          exit;
        end
        {$ENDREGION}
        else
        begin
          {$REGION 'LISTANDO FATURAS'}
          lblSubtituloLoading.Text := 'Consultando Faturas!';
          if ConsultaFatura(FID,LJsonFatura) then
          begin
            ListaFatura(LJsonFatura);
            Log('Finalizando lista faturas');
            TabControl1.ActiveTab := tabExtratoFatura;
            Log('Mostrando lista de faturas');
          end
          else
          begin
            Log('saindo da rotina pois a funcao de consulta retornou falso');
          end;
          {$ENDREGION}
        end;

        except on ex: exception do
        begin
          log('exception Erro: '+ ex.Message);
          TLoading.Hide;
          edtSenha.Text := '';
          Log('parando loading no exception');
        end;
      end;

    finally
      TThread.Synchronize(nil,
      procedure
      begin
        edtSenha.Text := '';
        recLoading.Visible := false;
        lylLoading.Visible := false;
        Log('Finalizou tthread');
      end);
    end;
  end).Start;
end;

procedure TfrmExtratoFatura.btnPagarClick(Sender: TObject);
var
  LValorDigitado, LValorMinimo : double;
begin
//  TLoading.Show(frmMenu,'Aguarde...');
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Gerando QRcode...';

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          TLoading.ToastMessage(frmExtratoFatura,'Erro ao buscar Token' ,5,TAlignLayout.MostRight);
          log('Erro token');
          exit;
        end;
      end;

      if not ConsultaQRCode(FCPF, FormatDateTime('yyyy-mm-dd', strtodate(lblVencimento.Text)) , frmMenu.FIDproduct, FQrCode) then
      begin
        TLoading.ToastMessage(frmExtratoFatura,'Erro ao gerar QRCode' ,5,TAlignLayout.MostRight);
        log('Erro ao gerar QRCode');
        exit;
      end
      else
      begin
        //SkLabel35.Text := 'FATURA DE '+copy(lblFatura.Text,length(lblFatura.text)-3,Length(lblFatura.text));
        //SkLabel34.Text := edtValor.Text;
        log('Montando qrcode');
        Image1.Bitmap.LoadFromStream(FQrCode);
        actTabPix.Execute;
      end;

    finally
      recLoading.Visible := false;
      lylLoading.Visible := false;
    end;
  end).Start;
end;

function TfrmExtratoFatura.ConsultaQRCode(ACPF,ADataVencimento, AIdProduto: string; out AResult: TStream): boolean;
var
  LConnection : TConnection;
  LResult     : string;
  Limagem     : TBitmap;
  LRESTClient : TNetHTTPClient;
  LRESTRequest: TNetHTTPRequest;
  LHeader     : TNetHeaders;
  LRetorno: IHTTPResponse;
  LRequest : string;
begin
  LConnection:= TConnection.Create;

  LRESTClient:= TNetHTTPClient.Create(nil);
  LRESTRequest:= TNetHTTPRequest.Create(nil);
  try
    log('Inicio consulta qrcode');
    log('data: '+ADataVencimento);
    LRESTRequest.Client:= LRESTClient;

    SetLength(LHeader,1);
    LHeader[0].Name:= 'Authorization';
    LHeader[0].Value:= 'Bearer '+FToken;
    LRESTClient.ContentType := 'image/png';
    LRESTClient.AcceptEncoding := 'gzip, deflate, br';

    LRequest := FURL+'/v1/invoice/pix/qr-code?idProduct='+AIdProduto+'&dueDate='+ADataVencimento+'&cpf='+ACPF+'&size=400';
    log(LRequest);

    LRetorno := LRESTRequest.Get(FURL+'/v1/invoice/pix/qr-code?idProduct='+AIdProduto+'&dueDate='+ADataVencimento+'&cpf='+ACPF+'&size=400', nil , LHeader);
    AResult := LRetorno.ContentStream;
    log('Fim consulta qrcode');
    log('Statuscode: '+LRetorno.StatusCode.tostring);
    if LRetorno.StatusCode = 200 then
      result := true
    else
      result := false;
  finally
    FreeAndNil(LConnection);
  end;
end;

procedure TfrmExtratoFatura.btnSairClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmExtratoFatura.btnVoltarClick(Sender: TObject);
begin
  dmfatura.memFatura.Close;
  close;
end;

procedure TfrmExtratoFatura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmfatura.memFatura.Close;
  Action := TCloseAction.caFree;
  frmExtratoFatura := nil;
end;

procedure TfrmExtratoFatura.FormCreate(Sender: TObject);
begin
  FMSG := TFancyDialog.create(self);
  FListaFrame :=  TList<TframeExtrato>.create;
  FListaFrameF := TList<TframeFatura>.create;
  FListaFaturas := TList<TFrameItemListModel>.create;

  TabControl1.ActiveTab := tabLoginSenha;
  TabControl1.TabPosition:= TTabPosition.None;

  SkLabel3.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
end;

procedure TfrmExtratoFatura.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMSG);
  FreeAndNil(FListaFrameF);
  FreeAndNil(FListaFaturas);
  FreeAndNil(FListaFrame);
end;

procedure TfrmExtratoFatura.FormShow(Sender: TObject);
begin
  edtSenha.Text := '';
end;

procedure TfrmExtratoFatura.GosButtonView1Click(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmExtratoFatura.GosButtonView2Click(Sender: TObject);
begin
  actTabExtratoFatura.execute;
end;


procedure TfrmExtratoFatura.GosButtonView6Click(Sender: TObject);
begin
  actTabDetalheExtrato.Execute;
end;

procedure TfrmExtratoFatura.Rectangle13Click(Sender: TObject);
begin
  actTabExtratoFatura.execute;
end;

procedure TfrmExtratoFatura.Rectangle14Click(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmExtratoFatura.Rectangle4Click(Sender: TObject);
begin
  if edtSenha.Password then
  begin
    edtSenha.Password := false;
    TGlyph(TLayout(Sender).Children[0]).ImageIndex := 1;
  end
  else
  begin
    edtSenha.Password := true;
    TGlyph(TLayout(Sender).Children[0]).ImageIndex := 0;
  end;
end;

procedure TfrmExtratoFatura.recVoltarExtrClick(Sender: TObject);
begin
//  FFrmLstVert.ClearList;
//  Close;
  dmfatura.memFatura.Close;
  TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.Synchronize(nil,
    procedure
    begin
      if not Assigned(frmMenu) then
        Application.CreateForm(TfrmMenu, frmMenu);
      frmMenu.show
    end);
  end).Start;
end;


procedure TfrmExtratoFatura.ListaFatura(AjsonFaturas: TJSONArray);
var
  LJoFatura: TJSONValue;
  LFil: TFrameItemListModel;
  LYPos: Single;
  LmesVenc: integer;
  Lmes: string;
begin

  {$REGION 'FATURA'}
  dmfatura.memFatura.Close;
  for LJoFatura in AjsonFaturas do
  begin
    dmfatura.memFatura.Open;
    dmfatura.memFatura.Append;
    dmfatura.memFaturaIDCONTA.AsInteger :=  LJoFatura.GetValue<integer>('idConta');
    dmfatura.memFaturaSITUACAOPROCESSAMENTO.AsString :=  LJoFatura.GetValue<string>('situacaoProcessamento');
    dmfatura.memFaturaPAGAMENTOEFETUADO.AsBoolean :=  LJoFatura.GetValue<boolean>('pagamentoEfetuado');
    dmfatura.memFaturaPAGAMENTOATRASO.AsBoolean :=  LJoFatura.GetValue<boolean>('pagamentoEmAtraso');
    dmfatura.memFaturaDATAVENCIMENTOFATURA.AsDateTime :=  IncMilliSecond(UnixDateDelta,LJoFatura.GetValue<Int64>('dataVencimentoFatura'));
    dmfatura.memFaturaDATAREALVENCIMENTOFATURA.AsDateTime :=  IncMilliSecond(UnixDateDelta,LJoFatura.GetValue<Int64>('dataRealVencimentoFatura'));
    dmfatura.memFaturaDATAFECHAMENTO.AsDateTime := IncMilliSecond(UnixDateDelta,LJoFatura.GetValue<Int64>('dataFechamento'));
    dmfatura.memFaturaMELHORDATACOMPRA.AsDateTime := IncMilliSecond(UnixDateDelta,LJoFatura.GetValue<Int64>('melhorDataCompra'));
    dmfatura.memFaturaVALORTOTAL.AsFloat :=  LJoFatura.GetValue<double>('valorTotal');
    dmfatura.memFaturaVALORPAGAMENTOMINIMO.AsFloat :=  LJoFatura.GetValue<double>('valorPagamentoMinimo');
    dmfatura.memFaturaVALORJUROSATRASO.AsFloat :=  LJoFatura.GetValue<double>('valorJurosAtraso');
    dmfatura.memFaturaVALORTOTALJUROSATUALIZADO.AsFloat:= LJoFatura.GetValue<double>('valorTotalJurosAtualizado');
    dmfatura.memFatura.Post;
  end;

  TUtils.TextMessageColorOpacity := 'Black';
  if  assigned(FFrmLstVert) then
    FreeAndNil(FFrmLstVert);

  try
    try
      FFrmLstVert := TFrameListModel.Create(Self);
      FFrmLstVert.BeginUpdate;
      FFrmLstVert.Parent := lylScroll;
      FFrmLstVert.Align := TAlignLayout.Client;
      FFrmLstVert.IsGradientTransparency := True;
      FFrmLstHorz1 := TFrameListModel.Create(Self);
      FFrmLstHorz1.Align := TAlignLayout.client;
      FFrmLstHorz1.Height := 400;
      FFrmLstVert.Width;
      FFrmLstHorz1.Margins.Right := 10;
      FFrmLstHorz1.Margins.Bottom := 20;
      FFrmLstHorz1.IsGradientTransparency := True;
      TFrameListModel(FFrmLstHorz1).ItemAlign := TAlignLayout.Left;
      LYPos := FFrmLstVert.ContentHeight;
      FFrmLstVert.VtsList.AddObject(FFrmLstHorz1);
      FFrmLstHorz1.Position.Y := LYPos;

      dmfatura.memFatura.IndexFieldNames := 'DATAVENCIMENTOFATURA:D';
      dmfatura.memFatura.Open;
      if dmfatura.memFatura.RecordCount = 1 then
      begin
        FFrmLstHorz1.Align := TAlignLayout.center;
        FFrmLstHorz1.Height := 400;
        FFrmLstHorz1.Width := 400;
      end;

      dmfatura.memFatura.Refresh;
      dmfatura.memFatura.First;
      Log('Iniciando Montagem dos frames');
      while not dmfatura.memFatura.Eof do
      begin
        LmesVenc  := StrToInt(FormatDateTime('MM',dmfatura.memFatura.fieldByName('DATAVENCIMENTOFATURA').AsDateTime));
        case LmesVenc of
          01: Lmes := 'JAN';
          02: Lmes := 'FEV';
          03: Lmes := 'MAR';
          04: Lmes := 'ABR';
          05: Lmes := 'MAI';
          06: Lmes := 'JUN';
          07: Lmes := 'JUL';
          08: Lmes := 'AGO';
          09: Lmes := 'SET';
          10: Lmes := 'OUT';
          11: Lmes := 'NOV';
          12: Lmes := 'DEZ';
        end;

        LFil := FFrmLstHorz1.AddItem(TFilHorz1,strtoint(FID),//dmfatura.memFatura.fieldByName('IDCONTA').AsInteger,
                                               Lmes,
                                               dmfatura.memFatura.fieldByName('SITUACAOPROCESSAMENTO').AsString,
                                               dmfatura.memFatura.fieldByName('DATAVENCIMENTOFATURA').AsDateTime,
                                               dmfatura.memFatura.fieldByName('VALORPAGAMENTOMINIMO').AsFloat,
                                               dmfatura.memFatura.fieldByName('VALORTOTAL').AsFloat,
                                               TTela.ExtratoFatura,
                                               dmfatura.memFaturaPAGAMENTOEFETUADO.AsBoolean);
         dmfatura.memFatura.Next;
      end;
     except on ex: exception do
        begin
          log('exception Erro: '+ ex.Message);
        end;

    end;
  finally
    FFrmLstVert.EndUpdate;
  end;
  {$ENDREGION}
end;

{$IFDEF MSWINDOWS}
procedure TfrmExtratoFatura.ItemClick(Sender: TObject);
{$ELSE}
procedure TfrmExtratoFatura.ItemClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
Var
  LcorS: Cardinal;
  LjsonExtrato: TJSONObject;
begin
//  TLoading.Show(frmExtratoFatura,'Aguarde');
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if not FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          TLoading.ToastMessage(frmExtratoFatura,'Erro ao buscar Token' ,5,TAlignLayout.MostRight);
          exit;
        end;
      end;

//      if ConsultaExtratoFatura(FID,TframeFatura(sender).TagString, LjsonExtrato) then
//         ListaItensFatura( LjsonExtrato,
//                          LcorS,TframeFatura(sender).lblmes.text,
//                          TframeFatura(sender).lblDataVencimento.text,
//                          TframeFatura(sender).lblValor.text)
//      else
//      begin
//        TLoading.ToastMessage(frmExtratoFatura,'Erro ao listar extrato da fatura' ,5,TAlignLayout.MostRight);
//        exit;
//      end;

      case AnsiIndexStr(UpperCase(TframeFatura(sender).lbldataPagamento.TagString), ['ABERTA', 'FECHADA','PAGA'])   of
        0: begin
             Rectangle15.Fill.Color := $FFE7EFEF;
             Rectangle16.Fill.Color := $FFE7EFEF;
             LcorS := StrToCardinal('$FF'+copy('#E7EFEF',2,length('#E7EFEF')));
           end;
        1: begin
             Rectangle15.Fill.Color := $FFF9E5F7;
             Rectangle16.Fill.Color := $FFF9E5F7;
             LcorS := StrToCardinal('$FF'+copy('#F9E5F7',2,length('#F9E5F7')));
           end;
        2: begin
             Rectangle15.Fill.Color := $FFE8F4E5;
             Rectangle16.Fill.Color := $FFE8F4E5;
             LcorS := StrToCardinal('$FF'+copy('#E8F4E5',2,length('#E8F4E5')));
           end;
      end;

      Rectangle18.Fill.Color := TframeFatura(sender).recMes.fill.Color;
      GosLine5.stroke.Color :=TframeFatura(sender).recMes.fill.Color;
      SkSvg9.svg.overrideColor := TframeFatura(sender).recMes.fill.Color;
      SkSvg10.svg.overrideColor := TframeFatura(sender).recMes.fill.Color;

    finally
//      TLoading.Hide;
    end;
  end).start;
  actTabDetalheExtrato.Execute;
end;

procedure TfrmExtratoFatura.ListaItensFatura(AJsonExtrato: TJSONObject; Acor: Cardinal; AMes,AVencimento,AValor:string);
var
  LFrame: TframeExtrato;
  LJson: TJSONValue;
  LParcela: string;
  LListaExtrato: TJSONArray;
  j: integer;

  LjsonContratados: TJSONArray;
  LjsonDisponiveis: TJSONArray;
  LFil: TFrameItemListModel;
  LYPos: Single;
  Lcount : integer;
begin
  try
    Lcount := 0;
    TUtils.TextMessageColorOpacity := 'Black';
    if assigned(FFrmLstItensFatura) then
      FreeAndNil(FFrmLstItensFatura);
    FFrmLstItensFatura := TFrameListModel.Create(Self);
    FFrmLstItensFatura.BeginUpdate;
    FFrmLstItensFatura.Parent := lylDetalhe;
    FFrmLstItensFatura.Align := TAlignLayout.Client;
    FFrmLstItensFatura.IsGradientTransparency := false;

    FFrmLstItensFatura.AddItem(TFilVert1,AJsonExtrato,Acor,AMes,AVencimento,AValor);
  finally
    FFrmLstItensFatura.EndUpdate;
  end;


end;

procedure TfrmExtratoFatura.recSairExtrClick(Sender: TObject);
begin
  SairConta;
end;


procedure TfrmExtratoFatura.SairConta;
begin
   FMsg.Show(TIconDialog.Warning,'Atenção','Confirma fechar seu acesso?','SIM',
  procedure
  begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmPrincipal) then
            Application.CreateForm(TfrmPrincipal, frmPrincipal);
          frmPrincipal.Show;
        end);

      finally
        TThread.Synchronize(nil,
        procedure
        begin
          frmPrincipal.TmrVerifica.Enabled := false;
          frmExtratoFatura.close;
          frmMenu.close;
          frmSelecaoCartao.Close;
          dmfatura.memFatura.Close;
        end);
      end;
    end).Start;
  end,'NÃO');
end;

function TfrmExtratoFatura.ValidaSenha(out Amesseger:string): boolean;
var
  LConnection: TConnection;
  LResult: string;
  LJsonRetorno: TJSONObject;
  LJsonRetornoInvalido: TJSONArray;
  Ljson: TJSONValue;
  LsenhaBase64: string;
  Ldados: string;
  Ltimer : integer;
begin
  RSA.KeyLength := kl2048;
  RSA.encType := TRSAEncType.epkcs1_5;
  RSA.signType := TRSASignType.spkcs1_5;
  RSA.OutputFormat := base64;
  RSA.FromPublicKey(uToken.FPublicKey);
  LsenhaBase64:= RSA.Encrypt(edtSenha.Text);

  Ldados := '{"id":"'+FIDCard+'", "password":"'+LsenhaBase64+'"}';
//  Ldados := '{"id":"7809577", "password":"'+LsenhaBase64+'"}';

  LConnection:= TConnection.Create;
  try

    try
      if LConnection.post(FURL+'/v1/card/password/validate',[],Ldados, LResult,Ltimer, FToken) then
      begin
        result := true;
        LJsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
        Log('Senha Válida');
      end
      else
      begin
        result := false;
        LJsonRetornoInvalido := TJSONArray.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONArray;
        for Ljson in LJsonRetornoInvalido do
        begin
          Log(Ljson.GetValue<String>('message'));
          Amesseger :=Ljson.GetValue<String>('message');
          break;
        end;
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

function TfrmExtratoFatura.ConsultaFatura(AIdAccount:string; out AJsonFatura: TJSONArray): Boolean;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try
    try
//      AIdAccount:= '7809577';
      if LConnection.Get(FURL+'/v1/account/'+AIdAccount+'/invoices',[], LResult, utoken.FToken) then
      begin
        result := true;
        AJsonFatura := TJSONArray.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONArray;
      end
      else
      begin
        result := false;
        log('Erro: '+LResult)
      end;

    except on ex: exception do
      begin
        log('exception Erro: '+ ex.Message);
      end;

    end;

  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmExtratoFatura.ConsultaExtratoFatura(AIdAccount,Adata:string; Out AjsonExtato: TJSONObject ): Boolean;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try
    try

      if LConnection.Get(FURL+'/v1/account/'+Adata+'/invoice/'+AIdAccount+'/details',[], LResult, FToken) then
      begin
        result := true;
        AjsonExtato := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
        log('Extrato consultado');
      end
      else
      begin
        result := false;
        Log('Erro ao consultar extrato: '+LResult);
      end;

    except on ex: exception do
      begin
        log('exception Erro: '+ ex.Message);
      end;

    end;
  finally
    FreeAndNil(LConnection);
  end;
end;



end.