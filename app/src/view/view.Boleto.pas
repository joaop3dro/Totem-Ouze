unit view.Boleto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia,
  Alcinoe.FMX.Objects, FMX.Skia, FMX.Effects, uGosBase, uGosStandard, System.DateUtils,
  FMX.Layouts, FMX.Objects, System.JSON, ACBrBase, ACBrBoleto, ACBrUtil, ACBrBoletoFCFortesFr;

type
  TfrmBoleto = class(TForm)
    Rectangle15: TRectangle;
    Layout31: TLayout;
    btnSair: TGosButtonView;
    SkSvg7: TSkSvg;
    ShadowEffect14: TShadowEffect;
    btnVoltar: TGosButtonView;
    ShadowEffect13: TShadowEffect;
    SkSvg8: TSkSvg;
    Layout32: TLayout;
    Layout33: TLayout;
    lblTitutlo: TSkLabel;
    ACBrBoleto1: TACBrBoleto;
    ACBrBoletoFCFortes: TACBrBoletoFCFortes;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure GerarTitulo(AJsonBoleto: TJSONObject);
  public
    { Public declarations }
    procedure carregaTela(AJsonBoleto: TJSONObject);
  end;

var
  frmBoleto: TfrmBoleto;

implementation

{$R *.fmx}

//uses model.boleto;

procedure TfrmBoleto.carregaTela(AJsonBoleto: TJSONObject);
begin
  GerarTitulo(AJsonBoleto);
end;

procedure TfrmBoleto.FormShow(Sender: TObject);
begin
//  dmBoleto.ACBrBoleto.Imprimir;
end;

procedure TfrmBoleto.GerarTitulo(AJsonBoleto: TJSONObject);
var
  LTitulo : TACBrTitulo;
  LIndex : Cardinal;
  LJson: TJSONValue;
begin
  LTitulo := ACBrBoleto1.CriarTituloNaLista;

  LTitulo.Vencimento        := IncMilliSecond(UnixDateDelta,AJsonBoleto.GetValue<Int64>('dataVencimento'));
//  LTitulo.DataDocumento     := IncMilliSecond(UnixDateDelta,AJsonBoleto.GetValue<Int64>('dataDocumento'));
//  LTitulo.NumeroDocumento   := AJsonBoleto.GetValue<string>('numeroDoDocumento');
//  LTitulo.EspecieDoc        := AJsonBoleto.GetValue<string>('especieDoDocumento');
  LTitulo.DataDocumento     := now;
  LTitulo.NumeroDocumento   := '001111111';
  LTitulo.EspecieDoc        :='DM';

//  LTitulo.Aceite := atSim;

  LTitulo.DataProcessamento := IncMilliSecond(UnixDateDelta,AJsonBoleto.GetValue<Int64>('dataProcessamento'));
  LTitulo.Carteira          := AJsonBoleto.GetValue<string>('carteira');
  LTitulo.NossoNumero       := AJsonBoleto.GetValue<string>('nossoNumero');
  LTitulo.ValorDocumento    := AJsonBoleto.GetValue<double>('valorBoleto');
  LTitulo.Sacado.NomeSacado := AJsonBoleto.GetValue<string>('nomePagador');
  LTitulo.Sacado.CNPJCPF    := AJsonBoleto.GetValue<string>('documentoPagador');
  LTitulo.Sacado.Logradouro := AJsonBoleto.GetValue<string>('logradouroPagador');
  LTitulo.Sacado.Numero     := copy(AJsonBoleto.GetValue<string>('logradouroPagador'),Pos(', ',AJsonBoleto.GetValue<string>('logradouroPagador'))+2,length(AJsonBoleto.GetValue<string>('logradouroPagador')));
  LTitulo.Sacado.Bairro     := AJsonBoleto.GetValue<string>('bairroPagador');
  LTitulo.Sacado.Cidade     := AJsonBoleto.GetValue<string>('cidadePagador');
  LTitulo.Sacado.UF         := AJsonBoleto.GetValue<string>('ufPagador');
  LTitulo.Sacado.CEP        := AJsonBoleto.GetValue<string>('cepPagador');
  LTitulo.ValorAbatimento   := AJsonBoleto.GetValue<double>('valorBoleto');

  for LJson in  AJsonBoleto.GetValue<TJSONArray>('locaisDePagamento') do
  begin
    LTitulo.LocalPagamento    := LJson.value;
    break;
  end;

  LTitulo.ValorMoraJuros    := 0;
  LTitulo.ValorDesconto     := 0;
  LTitulo.TipoDesconto      := tdNaoConcederDesconto;
  LTitulo.PercentualMulta   := 0;
  for LJson in  AJsonBoleto.GetValue<TJSONArray>('instrucoes') do
    begin
      LTitulo.Instrucao1     := trim(LJson.value);
      break;
    end;

  LTitulo.QtdePagamentoParcial   := 1;
//  LTitulo.TipoPagamento          := tpNao_Aceita_Valor_Divergente;
  LTitulo.PercentualMinPagamento := 0;
  LTitulo.PercentualMaxPagamento := 0;
  LTitulo.ValorMinPagamento      := 0;
  LTitulo.ValorMaxPagamento      := 0;
//  //QrCode.emv := '00020101021226870014br.gov.bcb.pix2565qrcodepix-h.bb.com.br/pix/v2/22657e83-ecac-4631-a767-65e16fc56bff5204000053039865802BR5925EMPRORT AMBIENTAL        6008BRASILIA62070503***6304BD3D';
//
// // dm.ACBrBoleto.AdicionarMensagensPadroes(LTitulo,Mensagem);

//  //LTitulo.ArquivoLogoEmp := logo;  // logo da empresa
  LTitulo.Verso := false;


  if not Assigned(ACBrBoleto1.ACBrBoletoFC) then
    raise Exception.Create('MOTOR_NAO_SELECIONADO');

  for LIndex := 0 to Pred(ACBrBoleto1.ListadeBoletos.Count) do
  begin
    ACBrBoleto1.ACBrBoletoFC.CalcularNomeArquivoPDFIndividual := True;
    ACBrBoleto1.ACBrBoletoFC.PdfSenha := IntToStr(LIndex+1);
    ACBrBoleto1.GerarPDF(LIndex);
  end;
end;
end.
