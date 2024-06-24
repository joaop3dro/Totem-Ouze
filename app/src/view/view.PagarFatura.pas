unit view.PagarFatura;

interface

uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  System.Skia, FMX.Layouts, FMX.Skia, FMX.Objects, uGosObjects, System.Actions,
  FMX.ActnList, uGosBase, uGosEdit, FMX.Effects, FMX.Ani,
  uFancyDialog, uGosStandard, System.JSON, frame.Fatura, System.Generics.Collections,DataSet.Serialize,
  System.DateUtils, System.Net.HttpClientComponent, System.Net.URLClient, System.Net.HttpClient,
  FMX.Gestures,REST.Response.Adapter, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Types, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, REST.Authenticator.OAuth;
  //uFancyDialog, uGosStandard, System.JSON, frame.Fatura, System.Generics.Collections;

type
  TfrmPagarFatura = class(TForm)
    TabControl1: TTabControl;
    tabFaturas: TTabItem;
    tabFaturas2: TTabItem;
    ALRectangle1: TRectangle;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Layout4: TLayout;
    SkLabel3: TSkLabel;
    Layout5: TLayout;
    SkSvg1: TSkSvg;
    Layout6: TLayout;
    Rectangle1: TRectangle;
    Layout7: TLayout;
    Layout8: TLayout;
    SkLabel4: TSkLabel;
    lblValor: TSkLabel;
    Rectangle2: TRectangle;
    lblmes: TSkLabel;
    Layout9: TLayout;
    SkLabel5: TSkLabel;
    lblDataVencimento: TSkLabel;
    GosLine1: TGosLine;
    Layout10: TLayout;
    SkLabel6: TSkLabel;
    lbldataPagamento: TSkLabel;
    Rectangle3: TRectangle;
    Layout11: TLayout;
    Layout12: TLayout;
    SkLabel7: TSkLabel;
    SkLabel8: TSkLabel;
    Rectangle4: TRectangle;
    SkLabel9: TSkLabel;
    Layout13: TLayout;
    SkLabel10: TSkLabel;
    SkLabel11: TSkLabel;
    GosLine2: TGosLine;
    Layout14: TLayout;
    SkLabel12: TSkLabel;
    SkLabel13: TSkLabel;
    Rectangle5: TRectangle;
    Layout15: TLayout;
    Layout16: TLayout;
    SkLabel14: TSkLabel;
    SkLabel15: TSkLabel;
    Rectangle6: TRectangle;
    SkLabel16: TSkLabel;
    Layout17: TLayout;
    SkLabel17: TSkLabel;
    SkLabel18: TSkLabel;
    GosLine3: TGosLine;
    Layout18: TLayout;
    SkLabel19: TSkLabel;
    SkLabel20: TSkLabel;
    Rectangle7: TRectangle;
    Layout19: TLayout;
    Layout20: TLayout;
    Layout21: TLayout;
    SkLabel21: TSkLabel;
    SkLabel22: TSkLabel;
    Layout24: TLayout;
    Layout25: TLayout;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    lblFaturaMin: TSkLabel;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    lblFatura: TSkLabel;
    Layout23: TLayout;
    SkLabel23: TSkLabel;
    SkSvg6: TSkSvg;
    Layout22: TLayout;
    Layout30: TLayout;
    edtValor: TGosEditView;
    tabFormaPag: TTabItem;
    Rectangle15: TRectangle;
    Layout31: TLayout;
    Layout32: TLayout;
    Layout33: TLayout;
    lblTitutlo: TSkLabel;
    lblSubtitulo: TSkLabel;
    Layout34: TLayout;
    Layout35: TLayout;
    recImprimirBoleto: TRectangle;
    SkSvg9: TSkSvg;
    SkLabel26: TSkLabel;
    ALRectangle3: TRectangle;
    SkSvg10: TSkSvg;
    SkLabel27: TSkLabel;
    tabPix: TTabItem;
    tabCartao: TTabItem;
    Rectangle18: TRectangle;
    Layout36: TLayout;
    Layout37: TLayout;
    Layout38: TLayout;
    SkLabel30: TSkLabel;
    SkLabel31: TSkLabel;
    Layout39: TLayout;
    Layout40: TLayout;
    Rectangle21: TRectangle;
    SkLabel34: TSkLabel;
    Rectangle22: TRectangle;
    SkLabel35: TSkLabel;
    Rectangle24: TRectangle;
    Layout41: TLayout;
    Layout42: TLayout;
    Layout43: TLayout;
    SkLabel36: TSkLabel;
    SkLabel37: TSkLabel;
    Layout44: TLayout;
    Rectangle27: TRectangle;
    SkLabel38: TSkLabel;
    Rectangle28: TRectangle;
    SkLabel39: TSkLabel;
    GosLine4: TGosLine;
    SkLabel40: TSkLabel;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    SkLabel41: TSkLabel;
    Layout46: TLayout;
    SkSvg16: TSkSvg;
    SkLabel42: TSkLabel;
    btnSair: TGosButtonView;
    SkSvg3: TSkSvg;
    btnVoltar: TGosButtonView;
    SkSvg4: TSkSvg;
    GosButtonView1: TGosButtonView;
    SkSvg17: TSkSvg;
    GosButtonView2: TGosButtonView;
    SkSvg18: TSkSvg;
    GosButtonView3: TGosButtonView;
    SkSvg2: TSkSvg;
    GosButtonView4: TGosButtonView;
    SkSvg5: TSkSvg;
    GosButtonView5: TGosButtonView;
    SkSvg7: TSkSvg;
    GosButtonView6: TGosButtonView;
    SkSvg8: TSkSvg;
    GosButtonView7: TGosButtonView;
    SkSvg11: TSkSvg;
    GosButtonView8: TGosButtonView;
    SkSvg12: TSkSvg;
    Layout47: TLayout;
    SkLabel24: TSkLabel;
    Layout49: TLayout;
    SkLabel32: TSkLabel;
    lylTecladoNumerico: TLayout;
    FloatAnimation2: TFloatAnimation;
    Layout26: TLayout;
    btn4: TGosButtonView;
    btn5: TGosButtonView;
    btn6: TGosButtonView;
    Layout27: TLayout;
    btnEnviar: TGosButtonView;
    btnCorrigir: TGosButtonView;
    Line1: TLine;
    Layout28: TLayout;
    btn8: TGosButtonView;
    btn9: TGosButtonView;
    btn7: TGosButtonView;
    Layout29: TLayout;
    btn1: TGosButtonView;
    btn3: TGosButtonView;
    btn2: TGosButtonView;
    ActionList1: TActionList;
    actTabFaturas: TChangeTabAction;
    actTabFaturas2: TChangeTabAction;
    actTabFormaPag: TChangeTabAction;
    actTabPix: TChangeTabAction;
    actTabCartao: TChangeTabAction;
    GestureManager1: TGestureManager;
    lylScroll: TLayout;
    btn0: TGosButtonView;
    lylLoading: TLayout;
    Layout48: TLayout;
    lblTituloLoading: TSkLabel;
    lblSubtituloLoading: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    recLoading: TRectangle;
    Layout50: TLayout;
    Layout51: TLayout;
    lblTotalFatura: TSkLabel;
    lblMinimoFatura: TSkLabel;
    Layout52: TLayout;
    Layout53: TLayout;
    Layout54: TLayout;
    Layout55: TLayout;
    SkSvg13: TSkSvg;
    SkLabel25: TSkLabel;
    Layout56: TLayout;
    SkSvg14: TSkSvg;
    SkLabel28: TSkLabel;
    Layout57: TLayout;
    SkSvg19: TSkSvg;
    SkLabel29: TSkLabel;
    btnConfirmaPix: TGosButtonView;
    Image2: TImage;
    Image1: TImage;
    tabInfo: TTabItem;
    Rectangle8: TRectangle;
    Layout59: TLayout;
    Layout60: TLayout;
    Layout61: TLayout;
    Rectangle9: TRectangle;
    SkSvg22: TSkSvg;
    Layout62: TLayout;
    SkLabel33: TSkLabel;
    Layout63: TLayout;
    Layout64: TLayout;
    Layout65: TLayout;
    btnVoltarInfo: TGosButtonView;
    Line2: TLine;
    btnConfirmainfo: TGosButtonView;
    skloading: TSkAnimatedImage;
    SkLabel43: TSkLabel;
    actTabInfo: TChangeTabAction;
    procedure btn0Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Rectangle14Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure recImprimirBoletoClick(Sender: TObject);
    procedure ALRectangle3Click(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
    procedure Rectangle16Click(Sender: TObject);
    procedure Rectangle19Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCorrigirClick(Sender: TObject);
    procedure btnConfirmaPixClick(Sender: TObject);
    procedure btnVoltarInfoClick(Sender: TObject);
    procedure btnConfirmainfoClick(Sender: TObject);
  private
    { Private declarations }
    FID        : string;
    FScrlList: TCustomScrollBox;
    FListaFrame: TList<TframeFatura>;
    FFrmLstVert: TFrameListModel;
    FFrmLstHorz1: TFrameListModel;
    FFrmLstHorz2: TFrameListModel;
    function TeclaNumero(ATecla,AlblValor: string): string;
    procedure RealizandoPagamento(ATitulo: String);
    procedure SairConta;
    procedure ListaFatura(AJsonRetorno: TJSONArray);
    function JsonToDataset(aDataset: TClientDataSet; aJSON: string): string;
{$IFDEF MSWINDOWS}
    procedure ItemClick(Sender: TObject);
{$ELSE}
    procedure ItemClick(Sender: TObject; const Point: TPointF);
{$ENDIF}
  public
    { Public declarations }
    FCPF       : String;
    FMSG       : TFancyDialog;
    FQrCode    : Boolean;
    FIDproduct : String;
    FDataVencimento: String;
    FListaFaturas: TList<TFrameItemListModel>;
    procedure carregaTela(AJsonRetorno:TJSONArray; AID, AIDProduct, ACPF: string);
    function ConsultaQRCode(ACPF, ADataVencimento, AIdProduto: string): boolean;
  end;

var
  frmPagarFatura: TfrmPagarFatura;

implementation

{$R *.fmx}

uses view.Principal, view.menu, view.SelecaoCartao, Notificacao,
  uToken, uConnection, model.fatura, {LogSQLite,} uAguarde,
  IdeaL.Lib.View.Utils,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1, LogSQLite.Config, controller.log;

function TfrmPagarFatura.JsonToDataset(aDataset : TClientDataSet; aJSON : string) : string;
var
  JObj  : TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

procedure TfrmPagarFatura.carregaTela(AJsonRetorno:TJSONArray; AID, AIDProduct, ACPF: string);
begin
  FCPF := ACPF;
  FIDproduct := AIDProduct;
  ListaFatura(AJsonRetorno);
end;

procedure TfrmPagarFatura.ListaFatura(AJsonRetorno: TJSONArray);
var
  LJoFatura: TJSONValue;
  LFrame   : TframeFatura;
  LmesVenc : integer;
  LFil: TFrameItemListModel;
  LYPos: Single;
  Lmes: string;
begin

   {$REGION 'FATURA'}

//   JsonToDataset(dmfatura.ClientDataSet1, AJsonRetorno.ToString);
   dmfatura.memFatura.Close;
   for LJoFatura in AJsonRetorno do
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

   FListaFaturas.Clear;

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

      if   (UpperCase(dmfatura.memFatura.fieldByName('SITUACAOPROCESSAMENTO').AsString) = 'FECHADA')
        or (UpperCase(dmfatura.memFatura.fieldByName('SITUACAOPROCESSAMENTO').AsString) = 'FECHADO') then
      begin
        if not ConsultaQRCode(frmPagarFatura.FCPF, FormatDateTime('yyyy-mm-dd', dmfatura.memFatura.fieldByName('DATAVENCIMENTOFATURA').AsDateTime),frmPagarFatura.FIDproduct) then
        begin
          log('Erro na rquisicao');
        end
        else
        begin
          SkLabel35.Text := 'FATURA DE '+Lmes;
          SkLabel34.Text := FormatFloat( 'R$ #,##0.00' , dmfatura.memFatura.fieldByName('VALORTOTAL').AsFloat);
        end;
      end;

      LFil := FFrmLstHorz1.AddItem(TFilHorz1,dmfatura.memFatura.fieldByName('IDCONTA').AsInteger,
                                             Lmes,
                                             dmfatura.memFatura.fieldByName('SITUACAOPROCESSAMENTO').AsString,
                                             dmfatura.memFatura.fieldByName('DATAVENCIMENTOFATURA').AsDateTime,
                                             dmfatura.memFatura.fieldByName('VALORPAGAMENTOMINIMO').AsFloat,
                                             dmfatura.memFatura.fieldByName('VALORTOTAL').AsFloat,
                                             TTela.PagarFatura,
                                             dmfatura.memFaturaPAGAMENTOEFETUADO.AsBoolean);
       dmfatura.memFatura.Next;
    end;
  finally
    FFrmLstVert.EndUpdate;
  end;
    
   {$ENDREGION}

end;




{$IFDEF MSWINDOWS}
procedure TfrmPagarFatura.ItemClick(Sender: TObject);
{$ELSE}
procedure TfrmPagarFatura.ItemClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
  LValorFatura: double;
  LValorMinimo: double;
begin
  FDataVencimento := TframeFatura(sender).TagString;
  LValorFatura := 0;
  LValorMinimo := 0;
  LValorFatura := strtofloat(copy(TframeFatura(Sender).lblValor.Text,pos('R$ ',TframeFatura(Sender).lblValor.Text)+3,length(TframeFatura(Sender).lblValor.Text)));
  LValorMinimo := strtofloat(copy(TframeFatura(Sender).lbldataPagamento.Text,pos('R$ ',TframeFatura(Sender).lbldataPagamento.Text)+3,length(TframeFatura(Sender).lbldataPagamento.Text)));

  if LValorFatura = 0  then
  begin
    FMSG.Show(TIconDialog.Warning,'Atenção', 'Sua Fatura esta zerada','OK');
    exit;
  end;

  lblFatura.text := 'TOTAL FATURA '+ TframeFatura(Sender).lblmes.Text;
  lblTotalFatura.text :=   FormatFloat( 'R$ #,##0.00' , LValorFatura);
  lblMinimoFatura.text :=  FormatFloat( 'R$ #,##0.00' , LValorMinimo);
  edtValor.Text := FormatFloat( 'R$ #,##0.00' , LValorFatura);
  actTabFaturas2.execute;

end;

procedure TfrmPagarFatura.btn0Click(Sender: TObject);
begin
  edtValor.Text := TeclaNumero(TGosButtonView(Sender).Text,edtValor.Text);
end;

procedure TfrmPagarFatura.btnConfirmainfoClick(Sender: TObject);
begin
  actTabPix.Execute;
end;

procedure TfrmPagarFatura.btnConfirmaPixClick(Sender: TObject);
begin
  actTabFaturas.Execute;
end;

procedure TfrmPagarFatura.btnCorrigirClick(Sender: TObject);
begin
  edtValor.Text := '0,00';
end;

function TfrmPagarFatura.TeclaNumero(ATecla,AlblValor: string): string;
var
  LNumero: string;
begin
  LNumero := AlblValor;
  LNumero := LNumero.Replace('.', '');
  LNumero := LNumero.Replace(',', '');
  LNumero := LNumero.Replace('R$ ', '');
  LNumero := LNumero + ATecla;

  result := FormatFloat('R$ #,##0.00', LNumero.ToDouble / 100);
end;

procedure TfrmPagarFatura.btnEnviarClick(Sender: TObject);
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
          TLoading.ToastMessage(frmPagarFatura,'Erro ao buscar Token' ,5,TAlignLayout.MostRight);
          exit;
        end;
      end;

      if not ConsultaQRCode(FCPF,FDataVencimento,FIDproduct) then
      begin
        TLoading.ToastMessage(frmPagarFatura,'Erro ao gerar QRCode' ,5,TAlignLayout.MostRight);
        exit;
      end
      else
      begin
        SkLabel35.Text := 'FATURA DE '+copy(lblFatura.Text,length(lblFatura.text)-3,Length(lblFatura.text));
        SkLabel34.Text := edtValor.Text;
//        Image1.Bitmap.LoadFromStream(FQrCode);
        actTabPix.Execute;
      end;

    finally
      recLoading.Visible := false;
      lylLoading.Visible := false;
    end;
  end).Start;

end;

procedure TfrmPagarFatura.btnSairClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmPagarFatura.btnVoltarClick(Sender: TObject);
begin
  dmfatura.memFatura.Close;
  close;
end;

procedure TfrmPagarFatura.btnVoltarInfoClick(Sender: TObject);
begin
  actTabFaturas.Execute;
end;


procedure TfrmPagarFatura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmPagarFatura := nil;
end;

procedure TfrmPagarFatura.FormCreate(Sender: TObject);
begin
  FListaFrame := TList<TframeFatura>.create;
  FListaFaturas := TList<TFrameItemListModel>.create;
  FMsg := TFancyDialog.Create(self);
  TabControl1.ActiveTab := tabFaturas;
  TabControl1.TabPosition:= TTabPosition.None;
  Rectangle4.Fill.Color := $FFE400E4;
  GosLine2.Fill.Color := $FFE400E4;
  SkSvg15.Svg.OverrideColor := $FFE400E4;

  SkLabel24.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
end;

procedure TfrmPagarFatura.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListaFrame);
  FreeAndNil(FListaFaturas);
  FreeAndNil(FMsg);
end;

procedure TfrmPagarFatura.recImprimirBoletoClick(Sender: TObject);
begin
  actTabPix.Execute;
  sleep(3000);
  RealizandoPagamento('Via PIX');
end;


procedure TfrmPagarFatura.ALRectangle3Click(Sender: TObject);
begin
  actTabCartao.Execute;
  sleep(3000);
  RealizandoPagamento('Com Cartão');
end;

procedure TfrmPagarFatura.Rectangle14Click(Sender: TObject);
begin
  edtValor.Text := '';
end;

procedure TfrmPagarFatura.Rectangle16Click(Sender: TObject);
begin
 actTabFaturas2.Execute;
end;

procedure TfrmPagarFatura.Rectangle19Click(Sender: TObject);
begin
//  actTabFaturas2.Execute;
//  actTabFaturas.Execute;
  TabControl1.ActiveTab := tabFaturas;
end;

procedure TfrmPagarFatura.Rectangle3Click(Sender: TObject);
begin
  actTabFaturas2.Execute;
end;

procedure TfrmPagarFatura.Rectangle8Click(Sender: TObject);
begin
  actTabFaturas.Execute;
end;

procedure TfrmPagarFatura.RealizandoPagamento(ATitulo:String);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        if not Assigned(frmCarramento) then
//          Application.CreateForm(TfrmCarramento, frmCarramento);
//      end);
//
//      frmCarramento.carregaTela('Pagamento '+Atitulo,'Confirmando pagamento',Pagamento);
//
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        frmCarramento.Show;
//      end);
//
//      sleep(6000); //consultando pagamento
//
//      frmCarramento.carregaTela('Pagamento '+Atitulo,'Pagamento realizado com sucesso!',Pagamento);
//      frmCarramento.FinalizaProcesso(Pagamento);
//      sleep(2000); // confirmando pagamento
//
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        frmCarramento.close;
//      end);
//
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        if not Assigned(frmCarramento) then
//          Application.CreateForm(TfrmCarramento, frmCarramento);
//      end);
//
//      frmCarramento.carregaTela('Pagamento '+Atitulo,'imprimindo comprovante de pagamento',Pagamento);
//
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        frmCarramento.Show;
//      end);
//
//      sleep(6000); // imprimindo comprovante
//      frmCarramento.carregaTela('Pagamento '+Atitulo,'Comprovante impresso com sucesso!',Pagamento);
//      frmCarramento.FinalizaProcesso(Pagamento);
//      sleep(3000); // comprovante impresso

    finally
      TThread.Synchronize(nil,
      procedure
      begin
//        frmCarramento.close;
        Rectangle4.Fill.Color := $FF38C31B;
        GosLine2.Stroke.Color := $FF38C31B;
        SkSvg15.Svg.OverrideColor := $FF38C31B;
        SkLabel41.Text :='Pagamento realizado';
        actTabFaturas.Execute;
      end);
    end;
  end).Start;
end;

procedure TfrmPagarFatura.SairConta;
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
          frmPagarFatura.close;
          frmMenu.close;
          frmSelecaoCartao.Close;
          dmfatura.memFatura.Close;
        end);
      end;
    end).Start;
  end,'NÃO',nil);
end;


function TfrmPagarFatura.ConsultaQRCode(ACPF,ADataVencimento, AIdProduto: string): boolean;
var
  LResult     : string;
  Limagem     : TBitmap;
  LRESTClient : TNetHTTPClient;
  LRESTRequest: TNetHTTPRequest;
  LHeader     : TNetHeaders;
  LFOAuth2Authenticator : TOAuth2Authenticator;
  LRetorno: IHTTPResponse;
  LRequest : string;
begin
  log('Inicio consutla qrcode');
  if FToken.IsEmpty  then
  begin
    if not ConsultaToken(FURL+'/v1/authentication', FToken) then
    begin
      exit;
    end;
  end;

  LRESTClient:= TNetHTTPClient.Create(nil);
  LRESTRequest:= TNetHTTPRequest.Create(nil);


  LRESTClient.SecureProtocols := [THTTPSecureProtocol.TLS11];

  try
    try
      LRESTRequest.Client:= LRESTClient;

      SetLength(LHeader,1);
      LHeader[0].Name:= 'Authorization';
      LHeader[0].Value:= 'Bearer '+FToken;
      LRESTClient.ContentType := 'image/png';
      LRESTClient.AcceptEncoding := 'gzip, deflate, br';

      log('requisicao consutla qrcode');
      LRequest := FURL+'/v1/invoice/pix/qr-code?idProduct='+AIdProduto+'&dueDate='+ADataVencimento+'&cpf='+ACPF+'&size=400';
      log('url request: '+LRequest);

      LRetorno := LRESTRequest.Get(LRequest, nil , LHeader);

      if LRetorno.StatusCode <> 200 then
      begin
        LRetorno.StatusText;
        Log('Requisição com erro, status 406');
        result := false;
        FQrCode := false;
        exit;
      end;

      Image1.Bitmap.LoadFromStream(LRetorno.ContentStream);
      log('status request: '+LRetorno.StatusCode.ToString);
      log('Fim consutla qrcode');

      Result := true;
      FQrCode := true;
    except
      on E:Exception do
      begin
        Result:= false;
        FQrCode := false;
        log('Erro: '+E.Message);
      end;
    end;
  finally
    FreeAndNil(LRESTClient);
    FreeAndNil(LRESTRequest);
  end;
end;
end.
