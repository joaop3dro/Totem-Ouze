unit view.Carregamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia,
  FMX.Effects, FMX.Filter.Effects, FMX.ImgList, uGosBase, uGosEdit, FMX.Objects,
  FMX.Skia,FMX.Ani, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;
type
 TModoCarregamento = (Login,Boleto,Pagamento,Comprovante,Erro);
type
  TfrmCarramento = class(TForm)
    ALRectangle1: TRectangle;
    Layout3: TLayout;
    Layout2: TLayout;
    lblTitulo: TSkLabel;
    lblSubtitulo: TSkLabel;
    RoundRect1: TRoundRect;
    Arc1: TArc;
    IconCarregando: TSkSvg;
    FloatAnimation1: TFloatAnimation;
    IconImprimindo: TSkSvg;
    IconFinalizado: TSkSvg;
    IconDinheiro: TSkSvg;
    IconComprovante: TSkSvg;
    Layout5: TLayout;
    SkLabel5: TSkLabel;
    IconErro: TSkSvg;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTitulo : string;
    FSubtitulo : string;
    FModo: TModoCarregamento;
  public
    { Public declarations }
    procedure carregaTela(ATitulo, ASubtitulo: string; Amodo: TModoCarregamento);
    procedure FinalizaProcesso(Amodo: TModoCarregamento);
  end;

var
  frmCarramento: TfrmCarramento;

implementation

{$R *.fmx}

procedure TfrmCarramento.carregaTela(ATitulo, ASubtitulo: string; Amodo: TModoCarregamento);
begin
  FTitulo := ATitulo;
  FSubtitulo := ASubtitulo;
  FModo:= Amodo;
end;
procedure TfrmCarramento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmCarramento := nil;
end;

procedure TfrmCarramento.FormShow(Sender: TObject);
begin
  IconFinalizado.Visible := false;

  if FModo = TModoCarregamento.Login then
  begin
    IconCarregando.Visible := true;
    IconImprimindo.Visible := false;
  end;

  if FModo = TModoCarregamento.Boleto then
  begin
    IconCarregando.Visible := false;
    IconImprimindo.Visible := true;
  end;

  if FModo = TModoCarregamento.Pagamento then
  begin
    IconCarregando.Visible := false;
    IconDinheiro.Visible := true;
  end;

   if FModo = TModoCarregamento.Comprovante then
  begin
    IconCarregando.Visible := false;
    IconComprovante.Visible := true;
  end;

  Arc1.Visible := true;
  RoundRect1.Fill.Color := $FFFFFFFF;
  lblTitulo.Text := FTitulo;
  lblSubtitulo.Text := FSubtitulo;
  FloatAnimation1.Start;
end;

procedure TfrmCarramento.FinalizaProcesso(Amodo : TModoCarregamento);
begin
  if FModo = TModoCarregamento.Boleto then
  begin
    IconCarregando.Visible := false;
    IconImprimindo.Visible := false;
    IconFinalizado.Visible := true;
    Arc1.Visible := false;
    RoundRect1.Fill.Color := $FFE400E4;
    lblTitulo.Text := FTitulo;
    lblSubtitulo.Text := FSubtitulo;
  end;

  if FModo in [TModoCarregamento.Pagamento,TModoCarregamento.Comprovante] then
  begin
    IconCarregando.Visible := false;
    IconDinheiro.Visible := false;
    IconComprovante.Visible := false;
    IconFinalizado.Visible := true;
    Arc1.Visible := false;
    RoundRect1.Fill.Color := $FFE400E4;
    lblTitulo.Text := FTitulo;
    lblSubtitulo.Text := FSubtitulo;
  end;

  if FModo = TModoCarregamento.Erro then
  begin
    IconCarregando.Visible := false;
    IconImprimindo.Visible := false;
    IconFinalizado.Visible := false;
    IconErro.Visible := true;
    Arc1.Visible := false;
    RoundRect1.Fill.Color := $FFE400E4;
    lblTitulo.Text := FTitulo;
    lblSubtitulo.Text := FSubtitulo;
  end;

end;

end.
