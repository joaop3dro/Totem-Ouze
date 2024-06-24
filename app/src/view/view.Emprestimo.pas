unit view.Emprestimo;

interface

uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia, System.JSON,
  System.Actions, FMX.ActnList, FMX.TabControl, FMX.Layouts, uGosObjects,
  FMX.Objects, FMX.Ani, uGosEdit, FMX.Skia, FMX.Effects,
  uGosBase, uGosStandard, System.NetEncoding, ACBrBoletoConversao,
  frame.parcelas, ACBrBoleto, ACBrBoletoFCFortesFr, FMX.Platform.Win, winSpool,
  System.Generics.Collections,  DBXJSON, ShellApi, Windows, Winapi.Messages,
  frame.Fatura,  uFancyDialog, ACBrBase, ACBrPosPrinter, ACBrDFe, ACBrCTe,
  ACBrDFeReport, ACBrCTeDACTEClass, ACBrCTeDACTeRLClass, System.DateUtils,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmEmprestimo = class(TForm)
    TabControl1: TTabControl;
    tabEmprestimo: TTabItem;
    tabSimulaEmprest: TTabItem;
    Rectangle15: TRectangle;
    Layout31: TLayout;
    Layout32: TLayout;
    Layout33: TLayout;
    lblTitutlo: TSkLabel;
    lblSubtitulo: TSkLabel;
    Layout34: TLayout;
    Layout35: TLayout;
    recSimula: TRectangle;
    SkSvg9: TSkSvg;
    SkLabel26: TSkLabel;
    recExtrato: TRectangle;
    SkSvg10: TSkSvg;
    SkLabel27: TSkLabel;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    Layout6: TLayout;
    SkSvg5: TSkSvg;
    Layout24: TLayout;
    Layout25: TLayout;
    Rectangle10: TRectangle;
    SkLabel24: TSkLabel;
    Rectangle11: TRectangle;
    SkLabel25: TSkLabel;
    Layout22: TLayout;
    Layout30: TLayout;
    edtValor: TGosEditView;
    tabSimulaParcelas: TTabItem;
    Rectangle2: TRectangle;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout7: TLayout;
    SkLabel3: TSkLabel;
    SkLabel4: TSkLabel;
    Layout8: TLayout;
    Layout9: TLayout;
    Rectangle5: TRectangle;
    SkLabel5: TSkLabel;
    Rectangle6: TRectangle;
    SkLabel6: TSkLabel;
    Rectangle23: TRectangle;
    SkLabel19: TSkLabel;
    Rectangle24: TRectangle;
    SkLabel20: TSkLabel;
    GosLine2: TGosLine;
    Layout17: TLayout;
    SkSvg6: TSkSvg;
    SkLabel21: TSkLabel;
    Rectangle17: TRectangle;
    Layout39: TLayout;
    Rectangle18: TRectangle;
    lblMesFatura: TSkLabel;
    GosLine5: TGosLine;
    Layout42: TLayout;
    SkLabel7: TSkLabel;
    Rectangle7: TRectangle;
    SkLabel8: TSkLabel;
    Rectangle16: TRectangle;
    SkLabel9: TSkLabel;
    VertScrollBox1: TVertScrollBox;
    Layout10: TLayout;
    Layout11: TLayout;
    SkSvg11: TSkSvg;
    SkLabel12: TSkLabel;
    ActionList1: TActionList;
    acttabEmprestimo: TChangeTabAction;
    actTabSimulaEmprest: TChangeTabAction;
    actTabSimulaParcelas: TChangeTabAction;
    tabExtratoEmprest: TTabItem;
    ALRectangle1: TRectangle;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    SkLabel10: TSkLabel;
    SkLabel11: TSkLabel;
    HorzScrollBox1: THorzScrollBox;
    actTabExtratoEmprest: TChangeTabAction;
    lylTecladoNumerico: TLayout;
    FloatAnimation2: TFloatAnimation;
    Layout15: TLayout;
    btn4: TGosButtonView;
    btn5: TGosButtonView;
    btn6: TGosButtonView;
    Layout16: TLayout;
    btn0: TGosButtonView;
    btnEnviar: TGosButtonView;
    btnCorrigir: TGosButtonView;
    Line1: TLine;
    Layout18: TLayout;
    btn7: TGosButtonView;
    btn8: TGosButtonView;
    btn9: TGosButtonView;
    Layout19: TLayout;
    btn3: TGosButtonView;
    btn2: TGosButtonView;
    btnSair: TGosButtonView;
    SkSvg7: TSkSvg;
    btnVoltar: TGosButtonView;
    SkSvg8: TSkSvg;
    btnSairS: TGosButtonView;
    SkSvg14: TSkSvg;
    btnVoltarS: TGosButtonView;
    SkSvg16: TSkSvg;
    recSairP: TGosButtonView;
    SkSvg2: TSkSvg;
    recVoltarP: TGosButtonView;
    SkSvg1: TSkSvg;
    recSairE: TGosButtonView;
    SkSvg3: TSkSvg;
    recVoltarE: TGosButtonView;
    SkSvg4: TSkSvg;
    lylScroll: TLayout;
    btn1: TGosButtonView;
    Layout20: TLayout;
    SkLabel13: TSkLabel;
    lylLoading: TLayout;
    Layout21: TLayout;
    lblTitulo: TSkLabel;
    SkLabel14: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    recLoading: TRectangle;
    tabContratos: TTabItem;
    actTabContratos: TChangeTabAction;
    Rectangle3: TRectangle;
    Layout23: TLayout;
    GosButtonView1: TGosButtonView;
    SkSvg12: TSkSvg;
    GosButtonView2: TGosButtonView;
    SkSvg13: TSkSvg;
    Layout26: TLayout;
    Layout27: TLayout;
    SkLabel15: TSkLabel;
    SkLabel16: TSkLabel;
    Layout28: TLayout;
    Rectangle4: TRectangle;
    lylContratos: TLayout;
    Layout36: TLayout;
    SkLabel40: TSkLabel;
    SkLabel28: TSkLabel;
    Layout50: TLayout;
    Rectangle9: TRectangle;
    SkLabel18: TSkLabel;
    Layout51: TLayout;
    Rectangle12: TRectangle;
    SkLabel29: TSkLabel;
    GosLine1: TGosLine;
    Layout29: TLayout;
    recMes: TRectangle;
    lblTItuloContratos: TSkLabel;
    ACBrBoleto1: TACBrBoleto;
    ACBrBoletoFCFortes1: TACBrBoletoFCFortes;
    Layout37: TLayout;
    lylElegivel: TLayout;
    Rectangle8: TRectangle;
    SkLabel22: TSkLabel;
    procedure btnEnviarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure Rectangle14Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure recSimulaClick(Sender: TObject);
    procedure Rectangle23Click(Sender: TObject);
    procedure recSairPClick(Sender: TObject);
    procedure btnSairSClick(Sender: TObject);
    procedure btnVoltarSClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure recVoltarEClick(Sender: TObject);
    procedure recSairEClick(Sender: TObject);
    procedure recExtratoClick(Sender: TObject);
    procedure recVoltarPClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    FCPF   : string;
    FMSG   : TFancyDialog;
    FListaFrame: TList<TframeParcelas>;
    FListaFrameFatura: TList<TframeFatura>;
    FListaParcelas: TList<TFrameItemListModel>;
    FFrmLstContratos: TFrameListModel;
    FFrmLstVert: TFrameListModel;
    FFrmLstHorz1: TFrameListModel;
    FACBrBoleto : TACBrBoleto;
    FACBrBoletoFCRL : TACBrBoletoFCFortes;
    function TeclaNumero(ATecla, AlblValor: string): string;
    procedure SairConta;
    procedure ListaFaturaEmprestimo(AjsonParcelasEP: TJSONObject);
    function ConsultaEmprestimo(ACPF: string): boolean;
    function ConsultaContrato(ACPF: string; out AJsonRetorno: TJSONObject): Boolean;
    procedure ListaContratos(AJsonContrato: TJSONObject);
    function ConsultaBoletoEmprestimo(ABody: TJSONObject;
      out AJsonRetorno: TJSONObject): Boolean;
    procedure GerarTitulo(Acontrato: string; AJsonBoleto: TJSONObject; AQtdeParcelas: integer);
    function calcula_barra(linha: string): string;
    { Private declarations }
  public
    { Public declarations }
    procedure ListaParcelasEmprestimo(AJson: TJSONArray);
    procedure carregaTela(ACpf: string);
    function ImprimirBoletoParcela(ABody: TJSONObject): boolean;
  end;

var
  frmEmprestimo: TfrmEmprestimo;

implementation

{$R *.fmx}

uses Notificacao, view.Principal, view.menu, uAguarde, uToken, uConnection,
  view.SelecaoCartao,
  IdeaL.Lib.View.Utils,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1, LogSQLite.Config, controller.log,
  model.fatura, controller.imagens, uFunctions;


procedure TfrmEmprestimo.carregaTela(ACpf: string);
begin
  FCPF := ACpf;

  if not ConsultaEmprestimo(ACPF) then
    lylElegivel.visible := false
  else
    lylElegivel.visible := true;

  if frmPrincipal.FSmEmprestimoSimular then
    recSimula.Visible := true
  else
  begin
    recSimula.Visible := false;
    recExtrato.Align := TAlignLayout.Center;
  end;

  if frmPrincipal.FSmEmprestimoExtrato then
    recExtrato.Visible := true
  else
  begin
    recExtrato.Visible := false;
    recSimula.Align := TAlignLayout.Center;
  end;
end;

procedure TfrmEmprestimo.btn1Click(Sender: TObject);
begin
  edtValor.Text := TeclaNumero(TGosButtonView(Sender).Text,edtValor.Text);
end;

procedure TfrmEmprestimo.btnEnviarClick(Sender: TObject);
var
  LvalorSolicitado,LvalorTotal: double;
begin
//  LvalorSolicitado := 0;
//  LvalorTotal := 0;
//
//  LvalorSolicitado := strtofloat(edtValor.text.Replace('.',''));
//  LvalorTotal := strtofloat(SkLabel24.text.replace('R$ ','').Replace('.',''));
//  if LvalorSolicitado>LvalorTotal then
//  begin
//    TLoading.ToastMessage(frmEmprestimo,'Valor Acima do Disponível!',5,TAlignLayout.MostRight);
//    exit;
//  end;
//
//  if LvalorSolicitado=0 then
//  begin
//    TLoading.ToastMessage(frmEmprestimo,'Digite o valor desejado!',5,TAlignLayout.MostRight);
//    exit;
//  end;
//
//  SkLabel19.text := FormatFloat('R$ #,##0.00',LvalorSolicitado);
//  SkLabel5.text :=  SkLabel24.text;
//  ListaParcelasEmprestimo;
//  actTabSimulaParcelas.execute;

end;

procedure TfrmEmprestimo.btnSairClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmEmprestimo.btnSairSClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmEmprestimo.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEmprestimo.btnVoltarSClick(Sender: TObject);
begin
  edtValor.Text := '';
  acttabEmprestimo.Execute;
end;

procedure TfrmEmprestimo.Button1Click(Sender: TObject);
begin
 TLoading.ToastMessage(frmEmprestimo,'Teste notificacao',5,TAlignLayout.MostRight);
end;

procedure TfrmEmprestimo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmEmprestimo := nil;
end;

procedure TfrmEmprestimo.FormCreate(Sender: TObject);
begin
  FMSG := TFancyDialog.Create(Self);
  TabControl1.ActiveTab := tabEmprestimo;
  TabControl1.TabPosition:= TTabPosition.None;
//  FListaParcelas := TList<TFrameItemListModel>.create;
  FACBrBoleto := TACBrBoleto.Create(Self);
  FACBrBoletoFCRL   := TACBrBoletoFCFortes.Create(FACBrBoleto);
  SkLabel13.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
end;

procedure TfrmEmprestimo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMSG);
//  FreeAndNil(FListaParcelas);
  FreeAndNil(FACBrBoletoFCRL);
  FreeAndNil(FACBrBoleto);
end;

function TfrmEmprestimo.TeclaNumero(ATecla,AlblValor: string): string;
var
  LNumero: string;
begin
  LNumero := AlblValor;
  LNumero := LNumero.Replace('.', '');
  LNumero := LNumero.Replace(',', '');
  LNumero := LNumero + ATecla;

  result := FormatFloat('#,##0.00', LNumero.ToDouble / 100);
end;

procedure TfrmEmprestimo.ListaContratos(AJsonContrato: TJSONObject);
var
  LFil: TFrameItemListModel;
  LYPos: Single;
begin
  TUtils.TextMessageColorOpacity := 'Black';

  TUtils.TextMessageColorOpacity := 'Black';
  if assigned(FFrmLstContratos) then
    FreeAndNil(FFrmLstContratos);
  try
    FFrmLstContratos := TFrameListModel.Create(Self);
    FFrmLstContratos.BeginUpdate;
    FFrmLstContratos.Parent := lylContratos;
    FFrmLstContratos.Margins.Left := -10;
    FFrmLstContratos.Margins.Top := -10;
    FFrmLstContratos.Align := TAlignLayout.Client;
    FFrmLstContratos.IsGradientTransparency := false;

    FFrmLstContratos.AddItem(TFilVert1,AJsonContrato);
  finally
    FFrmLstContratos.EndUpdate;
  end;
end;

procedure TfrmEmprestimo.ListaParcelasEmprestimo(AJson: TJSONArray);
var
  LFrame: TframeParcelas;
  LFil: TFrameItemListModel;
  LYPos: Single;
  LJson: TJSONValue;
  Lmes: string;
  LmesVenc: integer;
begin

  TUtils.TextMessageColorOpacity := 'Black';
  if assigned(FFrmLstVert) then
    FreeAndNil(FFrmLstVert);
  try
    FFrmLstVert := TFrameListModel.Create(Self);
    FFrmLstVert.BeginUpdate;
    FFrmLstVert.Parent := lylScroll;
    FFrmLstVert.Align := TAlignLayout.Client;
    FFrmLstVert.IsGradientTransparency := false;
    FFrmLstHorz1 := TFrameListModel.Create(Self);
    FFrmLstHorz1.Align := TAlignLayout.client;
    FFrmLstHorz1.Height := 400;
    FFrmLstHorz1.Margins.Right := 10;
    FFrmLstHorz1.IsGradientTransparency := false;
    TFrameListModel(FFrmLstHorz1).ItemAlign := TAlignLayout.Left;
    LYPos := FFrmLstVert.ContentHeight;
    FFrmLstVert.VtsList.AddObject(FFrmLstHorz1);
    FFrmLstHorz1.Position.Y := LYPos;

    dmfatura.memParcelas.close;
    for LJson in AJson do
    begin
      dmfatura.memParcelas.Open;
      dmfatura.memParcelas.Append;
      dmfatura.memParcelasnumeroOperacao.AsString :=  LJson.GetValue<string>('numeroOperacao');
      dmfatura.memParcelasnumeroParcela.AsInteger :=  LJson.GetValue<integer>('numeroParcela');
      dmfatura.memParcelasdataVencimentoParcela.AsDateTime :=  LJson.GetValue<TDateTime>('dataVencimentoParcela');
      dmfatura.memParcelasvalorPago.AsFloat :=  LJson.GetValue<Double>('valorPago');
      dmfatura.memParcelassaldoAtual.AsFloat :=  LJson.GetValue<Double>('saldoAtual');
//      if not LJson.GetValue<string>('dataLiquidacaoParcela').IsEmpty then
//        dmfatura.memParcelasdataLiquidacaoParcela.AsDateTime :=  LJson.GetValue<TDateTime>('dataLiquidacaoParcela');
      if LJson.GetValue<String>('dataLiquidacaoParcela') = '' then
        dmfatura.memParcelasdataLiquidacaoParcela.AsString :=  LJson.GetValue<String>('dataLiquidacaoParcela')
      else
        dmfatura.memParcelasdataLiquidacaoParcela.AsDateTime :=  LJson.GetValue<TDateTime>('dataLiquidacaoParcela');
      dmfatura.memParcelassituacao.AsString := LJson.GetValue<String>('situacao');
      dmfatura.memParcelasvalorParcela.AsFloat := LJson.GetValue<Double>('valorParcela');
      dmfatura.memParcelasvalorFinalEncargos.AsFloat :=  LJson.GetValue<double>('valorFinalEncargos');
      dmfatura.memParcelasboletoRegistrado.Asboolean :=  LJson.GetValue<boolean>('boletoRegistrado');
      dmfatura.memParcelas.Post;
    end;

    dmfatura.memParcelas.IndexFieldNames := 'dataVencimentoParcela:D';
    dmfatura.memParcelas.Open;
    if dmfatura.memParcelas.RecordCount = 1 then
    begin
      FFrmLstHorz1.Align := TAlignLayout.center;
      FFrmLstHorz1.Height := 400;
      FFrmLstHorz1.Width := 400;
    end;
    dmfatura.memParcelas.Refresh;
    dmfatura.memParcelas.First;
    while not dmfatura.memParcelas.Eof do
    begin
      LmesVenc  := StrToInt(FormatDateTime('MM',dmfatura.memParcelasdataVencimentoParcela.AsDateTime));
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
      FFrmLstHorz1.AddItem(TFilHorz1,
                           dmfatura.memParcelasnumeroOperacao.AsString,
                           dmfatura.memParcelasdataLiquidacaoParcela.AsString,
                           dmfatura.memParcelasnumeroParcela.AsInteger,
                           dmfatura.memParcelasdataVencimentoParcela.AsDateTime,
                           Lmes,
                           dmfatura.memParcelassituacao.AsString,
                           dmfatura.memParcelasvalorPago.AsFloat,
                           dmfatura.memParcelasvalorParcela.AsFloat,
                           dmfatura.memParcelasboletoRegistrado.Asboolean);
      dmfatura.memParcelas.Next;
    end;

  finally
    FFrmLstVert.EndUpdate;
  end;
end;

procedure TfrmEmprestimo.ListaFaturaEmprestimo(AjsonParcelasEP: TJSONObject);
var
  LFrame: TframeFatura;
  LJson,LjsonP: TJSONValue;
  LJsonParcelas : TJSONArray;
  LdataString : string;
begin
   try
    TThread.Synchronize(nil,
    procedure
    begin
      HorzScrollBox1.BeginUpdate;
    end);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      if Assigned(FListaFrameFatura) then
      begin
        for var i := 0 to Pred(FListaFrameFatura.Count) do
          FListaFrameFatura.Items[i].Free;
        FListaFrameFatura.Free;
      end;
      FListaFrameFatura := TList<TframeFatura>.create;
    end);

    if AjsonParcelasEP = nil then
      FMSG.Show(TIconDialog.Warning, 'Atenção','Sem contrato ativo!','OK')
    else
    begin
        LJsonParcelas := AjsonParcelasEP.GetValue<TJSONArray>('parcelas');
        for LjsonP in LJsonParcelas do
        begin
          LdataString :=  copy(LjsonP.GetValue<string>('dataVencimentoParcela'),9,2)+'/'+
                          copy(LjsonP.GetValue<string>('dataVencimentoParcela'),6,2)+'/'+
                          copy(LjsonP.GetValue<string>('dataVencimentoParcela'),1,4);

          LFrame:= TframeFatura.Create(self);
          LFrame.align := TalignLayout.left;
          LFrame.Margins.Right := 40;
          LFrame.Name := 'Frame' + FListaFrameFatura.Count.ToString + FormatDateTime('ddmmyyyyhhmmsszzz', now);
          LFrame.margins.top:= 8;
          LFrame.margins.bottom:= 8;
          LFrame.margins.right:= 40;

          LFrame.lblValor.Text := FormatFloat( 'R$ #,##0.00', LjsonP.GetValue<double>('saldoAtual',0));
          LFrame.lblDataVencimento.Text := LdataString;
          LFrame.lblmes.Text := StringOfChar('0',length(LjsonP.GetValue<String>('numeroParcela')))+LjsonP.GetValue<String>('numeroParcela')+'/'+
                                StringOfChar('0',length(AjsonParcelasEP.GetValue<String>('quantidadeParcelas')))+AjsonParcelasEP.GetValue<String>('quantidadeParcelas');
          LFrame.lbldataPagamento.text := FormatFloat( 'R$ #,##0.00',LjsonP.GetValue<double>('valorPago'));
          Layout45.visible := false;

          if LjsonP.GetValue<String>('situacao') = 'ATRASADO' then
          begin
            LFrame.lbltitulo.text := 'Parcela ATRASADA';
//            LFrame.SkSvg15.svg.overrideColor := $FFE400E4;
            Lframe.recMes.fill.color := $FFE400E4;
            Lframe.GosLine1.stroke.color := $FFE400E4;
          end
          else if LjsonP.GetValue<String>('situacao') = 'PENDENTE' then
          begin
            LFrame.lbltitulo.text := 'Parcela A VENCER';
//            LFrame.SkSvg15.svg.overrideColor := $FF069999;
            Lframe.recMes.fill.color := $FF069999;
            Lframe.GosLine1.stroke.color := $FF069999;
          end
          else
          begin
//            LFrame.SkSvg15.svg.overrideColor := $FF38C31B;
            LFrame.lbltitulo.text := 'Parcela PAGA';
            Lframe.recMes.fill.color := $FF38C31B;
            Lframe.GosLine1.stroke.color := $FF38C31B;
          end;

          FListaFrameFatura.Add(LFrame);
          HorzScrollBox1.addObject(LFrame);
        end;

        if LJsonParcelas.count = 1 then
        begin
          HorzScrollBox1.width := 310;
          Layout14.width := HorzScrollBox1.width +64
        end
        else if LJsonParcelas.count = 2 then
        begin
          HorzScrollBox1.width := 620;
          Layout14.width := HorzScrollBox1.width +64
        end
        else
        begin
          HorzScrollBox1.width := 1200;
          Layout14.width := (HorzScrollBox1.width+40) +64
        end;
    end;
  finally
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      HorzScrollBox1.EndUpdate;
      actTabExtratoEmprest.Execute;
    end);
  end;
end;

procedure TfrmEmprestimo.recExtratoClick(Sender: TObject);
var
  LJsonRetorno: TJSONObject;
begin
  recLoading.Visible := true;
  lylLoading.Visible := true;
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if not ConsultaToken(FURL+'/v1/authentication', FToken) then
      begin
        exit;
      end;

      if not ConsultaContrato(FCPF,LJsonRetorno) then
      begin
        if LJsonRetorno = nil then
          TLoading.ToastMessage(frmEmprestimo,'Sem contratos ativos!' ,5,TAlignLayout.MostRight)
        else
          TLoading.ToastMessage(frmEmprestimo,'Erro ao consultar emprestimos!' ,5,TAlignLayout.MostRight);
        exit;
      end;
      ListaContratos(LJsonRetorno);

      TThread.Synchronize(nil,
      procedure
      begin
        actTabContratos.Execute;
      end);

    finally
      TThread.Synchronize(nil,
      procedure
      begin

        Log('Finalizou tthread');
      end);
      recLoading.Visible := false;
        lylLoading.Visible := false;
    end;
  end).Start;
end;

procedure TfrmEmprestimo.recSairEClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmEmprestimo.recSairPClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmEmprestimo.recSimulaClick(Sender: TObject);
begin
//  TLoading.ToastMessage(frmEmprestimo,'Em fase de desenvolvimento',5,TAlignLayout.MostRight);

//  TAguarde.Start(self, 'Aguarde...', 'Consultando informações...', TModo.Aguarde);
//  TThread.CreateAnonymousThread(
//  procedure
//  begin
//    try
//      if not ConsultaToken('https://qa-totem.calcard.com.br/api/totem-app/v1/authentication', FToken) then
//      begin
//        TLoading.ToastMessage(frmEmprestimo,'Erro ao buscar Token',5,TAlignLayout.MostRight);
//        exit;
//      end;
//
//      if not ConsultaEmprestimo(FCPF) then
//      begin
//        FMSG.Show(TIconDialog.Warning, 'Atenção','Não há empréstimo disponível para você!','OK');
//        exit;
//      end
//      else
//      begin
//        actTabSimulaEmprest.Execute;
//      end;
//
//    finally
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        TAguarde.Hide;
//      end);
//    end;
//  end).start;
end;

procedure TfrmEmprestimo.Rectangle14Click(Sender: TObject);
begin
  edtValor.Text := '';
end;

procedure TfrmEmprestimo.Rectangle23Click(Sender: TObject);
begin
  edtValor.Text := '';
  actTabSimulaEmprest.Execute;
end;

procedure TfrmEmprestimo.recVoltarEClick(Sender: TObject);
begin
  acttabEmprestimo.Execute;
end;

procedure TfrmEmprestimo.recVoltarPClick(Sender: TObject);
begin
  actTabSimulaEmprest.Execute;
end;

procedure TfrmEmprestimo.SairConta;
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
          frmEmprestimo.close;
          frmMenu.close;
          frmSelecaoCartao.Close;
        end);
      end;
    end).Start;
  end,'NÃO');
end;

function TfrmEmprestimo.ConsultaEmprestimo(ACPF:string): boolean;
var
  LConnection: TConnection;
  LResult: string;
  LJson : TJSONObject;
begin
  try
    LConnection:= TConnection.Create;
    try
      LConnection.Get(FURL+'/v1/loan/eligibility?cpf='+ACPF,[], LResult, FToken);
      LJson := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
      result := LJson.GetValue<Boolean>('elegivel');
    finally
      FreeAndNil(LConnection);
    end;
  except
    on E:Exception do
    begin
      TLoading.ToastMessage(frmEmprestimo,'Erro ao consultar emprestimo ' +e.Message,5,TAlignLayout.MostRight);
    end;
  end;
end;

function TfrmEmprestimo.ConsultaContrato(ACPF:string; out AJsonRetorno: TJSONObject): Boolean;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try
//    ACPF := '92405673053';
    if LConnection.Get(FURL+'/v1/loan/contract/active/'+ACPF,[], LResult, FToken) then
    begin
      result := true;
      if LResult = '' then
        result := false
      else
        AJsonRetorno:=  TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
    end
    else
    begin
      result := false;
    end;

  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmEmprestimo.ConsultaBoletoEmprestimo(ABody:TJSONObject; out AJsonRetorno: TJSONObject): Boolean;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try
    // Consulta boleto base64
//    if LConnection.Get(FURL+'/v1/loan/bill',[],ABody, LResult, FToken) then
    // Consulta boleto linha digitavel
    if LConnection.Get(FURL+'/v1/loan/bill/digitableLine/'+FCPF,[], LResult, FToken) then
    begin
      result := true;
      if LResult = '' then
        result := false
      else
        AJsonRetorno:=  TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
    end
    else
    begin
      result := false;
    end;



  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmEmprestimo.ImprimirBoletoParcela(ABody: TJSONObject): boolean;
var
  LJsonRetorno: TJSONObject;
  LBase64: String;
  LPDF: TBytesStream;
  LStream: TBytesStream;
  LMeuStream : TStream;
  Handle: THandle;
  Ljson: TJSONValue;
  LJsonArr: TJSONArray;
  Ldir: String;
begin
  Ldir := GetCurrentDir;
  if ConsultaBoletoEmprestimo(ABody,LJsonRetorno) then
  begin
    LJsonArr := LJsonRetorno.GetValue<TJSONArray>('linhaDigitavelList');
    for Ljson in LJsonArr do
    begin
      if Abody.GetValue<integer>('numeroParcela') = LJson.GetValue<integer>('parcela') then
      begin
        GerarTitulo(LJsonRetorno.GetValue<String>('numeroContrato'), LJson.GetValue<TJSONObject> , dmfatura.memParcelas.RecordCount);
        break;
      end;
    end;

    if FACBrBoleto.ListadeBoletos.Count = 0 then
    begin
      Result:= false;
      exit;
    end;

    if frmPrincipal.FPortaImpressora = 'Nenhuma Impressora Detectada' then
    begin
      log('Impressora padrão não definida');
      result:= false;
      exit;
    end;

    result := true;
    FACBrBoleto.Imprimir;


    DeletaBoletoSalvo(Ldir);
{$REGION 'teste'}
//    LBase64 := LJsonRetorno.GetValue<string>('boleto');
//
//    LStream := TbytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(LBase64));
//    LStream.Position := 0;
//    LStream.SaveToFile(ExtractFilePath(Application.name)+'boletotest.pdf');

//    ACBrBoletoFCFR1.Report.LoadFromStream(LStream);
//    ACBrBoletoFCFR1.Imprimir;
//    ACBrBoletoFCFortes1.Imprimir(LStream);
//    ACBrBoleto1.Imprimir(LStream);
//    ShellExecute(Handle, 'print', PChar(ExtractFilePath(Application.name)+'boletotest.pdf'), nil, nil, SW_HIDE);
//    Sleep(3000);
//    PostMessage(FindWindow(nil, 'Adobe Reader'), WM_CLOSE, 0, 0);
{$endREGION}
  end
  else
  begin
    log('Erro ao consultar boleto da parcela');
    result := false;

  end;

end;

procedure TfrmEmprestimo.GerarTitulo(Acontrato: string; AJsonBoleto: TJSONObject; AQtdeParcelas: integer);
var
  LTitulo : TACBrTitulo;
  LIndex : Cardinal;
  LJson: TJSONValue;
  Banco : string;
  Banco1 : integer;
begin

  FACBrBoleto.ACBrBoletoFC := FACBrBoletoFCRL;
  FACBrBoletoFCRL.MostrarPreview := false;
  FACBrBoletoFCRL.MostrarSetup := false;
  FACBrBoletoFCRL.MostrarProgresso := false;
  FACBrBoletoFCRL.LayOut := lTermica80mm;
  FACBrBoletoFCRL.MargemSuperior :=-3;
  FACBrBoletoFCRL.MargemInferior := 0;
  FACBrBoletoFCRL.MargemEsquerda :=3;
  FACBrBoletoFCRL.MargemDireita  :=0;
  FACBrBoleto.ListadeBoletos.Clear;

  FACBrBoleto.Cedente.Nome := 'CALCRED SA';
  FACBrBoleto.Cedente.CNPJCPF := '37122487000195';
  FACBrBoleto.Cedente.CodigoCedente := '13001557';
  FACBrBoleto.Cedente.Agencia := '2186';
  FACBrBoleto.Cedente.AgenciaDigito := '3';
  FACBrBoleto.Cedente.Conta := '5343119';
  FACBrBoleto.Cedente.ContaDigito := '3';
  FACBrBoleto.Cedente.Convenio := '5343119';
  FACBrBoleto.Banco.TipoCobranca := cobSantander;

//   AJsonBoleto.GetValue<string>('linhaDigitavel');

  LTitulo := FACBrBoleto.CriarTituloNaLista;

  LTitulo.Vencimento        := AJsonBoleto.GetValue<TDateTime>('vencimento');
  LTitulo.DataDocumento     := AJsonBoleto.GetValue<TDateTime>('vencimento');
  LTitulo.NumeroDocumento   := Acontrato;
  LTitulo.EspecieDoc        := 'BCC';
  LTitulo.Aceite := atNao;
  LTitulo.DataProcessamento := now;
  LTitulo.Carteira          := '101';
    LTitulo.Parcela           := AJsonBoleto.GetValue<integer>('parcela');
  LTitulo.TotalParcelas      := dmfatura.memParcelas.RecordCount;
  LTitulo.NossoNumero       := '10000032813';
  LTitulo.ValorDocumento    := AJsonBoleto.GetValue<double>('valor');
  LTitulo.Sacado.NomeSacado := frmMenu.FName;
  LTitulo.Sacado.CNPJCPF    := FCPF;
  LTitulo.Sacado.Logradouro := '';
//  LTitulo.Sacado.Numero     := copy(AJsonBoleto.GetValue<string>('logradouroPagador'),Pos(', ',AJsonBoleto.GetValue<string>('logradouroPagador'))+2,length(AJsonBoleto.GetValue<string>('logradouroPagador')));
  LTitulo.Sacado.Bairro     := '';//AJsonBoleto.GetValue<string>('bairroPagador');
  LTitulo.Sacado.Cidade     := '';//AJsonBoleto.GetValue<string>('cidadePagador');
  LTitulo.Sacado.UF         := '';//AJsonBoleto.GetValue<string>('ufPagador');
  LTitulo.Sacado.CEP        := '';//AJsonBoleto.GetValue<string>('cepPagador');
  LTitulo.ValorAbatimento   := AJsonBoleto.GetValue<double>('valor');

//  for LJson in  AJsonBoleto.GetValue<TJSONArray>('locaisDePagamento') do
//  begin
//    LTitulo.LocalPagamento    := 'Pagar preferencialmente nas Studio Z.';
//    break;
//  end;
  LTitulo.LocalPagamento    := 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO';

  LTitulo.ValorMoraJuros    := 0;
  LTitulo.ValorDesconto     := 0;
  LTitulo.TipoDesconto      := tdNaoConcederDesconto;
  LTitulo.PercentualMulta   := 0;

  LTitulo.Mensagem.Text      := StringReplace(frmPrincipal.FMENSAGEM_EP, '/p', #13,[rfReplaceAll, rfIgnoreCase]);;
//  for LJson in  AJsonBoleto.GetValue<TJSONArray>('instrucoes') do
//    begin
//      LTitulo.Mensagem.Text      := trim(LJson.value);
//      break;
//    end;

  LTitulo.QtdePagamentoParcial   := 1;
  LTitulo.TipoPagamento          := tpNao_Aceita_Valor_Divergente;
  LTitulo.PercentualMinPagamento := 0;
  LTitulo.PercentualMaxPagamento := 0;
  LTitulo.ValorMinPagamento      := AJsonBoleto.GetValue<double>('valor');;
  LTitulo.ValorMaxPagamento      := 0;
  LTitulo.Verso := false;

  FACBrBoleto.Banco.Linhadigitavel:= AJsonBoleto.GetValue<string>('linhaDigitavel');
  FACBrBoleto.Banco.CodigodeBarras:= calcula_barra(AJsonBoleto.GetValue<string>('linhaDigitavel'));

  for LIndex := 0 to Pred(FACBrBoleto.ListadeBoletos.Count) do
  begin
    FACBrBoleto.ACBrBoletoFC.CalcularNomeArquivoPDFIndividual := True;
    FACBrBoletoFCRL.PdfSenha := IntToStr(LIndex+1);
    FACBrBoleto.ACBrBoletoFC.GerarPDF(LIndex);
  end;
end;


function TfrmEmprestimo.calcula_barra(linha: string): string;
var
  barra: string;
begin
  barra  := linha.replace(' ','').Replace('.','');

  barra  := copy(barra,0,4)
    +copy(barra,33,15)
    +copy(barra,5,5)
    +copy(barra,11,10)
    +copy(barra,22,10)
    ;
  result := barra;
end;


end.
