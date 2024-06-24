unit view.ClubeSTZ;

interface

uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia,
  FMX.Ani, uGosEdit, FMX.Layouts, FMX.Objects, uGosObjects, FMX.Skia, uGosBase,
  uGosStandard, FMX.TabControl, System.Actions, FMX.ActnList, System.JSON, uFancyDialog;

type
  TfrmClubeSTZ = class(TForm)
    Layout47: TLayout;
    SkLabel24: TSkLabel;
    lylLoading: TLayout;
    Layout48: TLayout;
    lblTituloLoading: TSkLabel;
    lblSubtituloLoading: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    recLoading: TRectangle;
    TabControl1: TTabControl;
    tabResumo: TTabItem;
    ALRectangle1: TRectangle;
    Layout1: TLayout;
    btnSair: TGosButtonView;
    SkSvg3: TSkSvg;
    btnVoltar: TGosButtonView;
    SkSvg4: TSkSvg;
    Layout3: TLayout;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Layout4: TLayout;
    btnRegredir: TSkSvg;
    btnAvancar: TSkSvg;
    lylScroll: TLayout;
    tabExtratoAtual: TTabItem;
    Rectangle7: TRectangle;
    Layout19: TLayout;
    GosButtonView1: TGosButtonView;
    SkSvg17: TSkSvg;
    GosButtonView2: TGosButtonView;
    SkSvg18: TSkSvg;
    Layout20: TLayout;
    Layout21: TLayout;
    SkLabel21: TSkLabel;
    SkLabel22: TSkLabel;
    tabCadastro: TTabItem;
    Rectangle24: TRectangle;
    Layout41: TLayout;
    GosButtonView7: TGosButtonView;
    SkSvg11: TSkSvg;
    GosButtonView8: TGosButtonView;
    SkSvg12: TSkSvg;
    Layout42: TLayout;
    ActionList1: TActionList;
    actTabResumo: TChangeTabAction;
    actTabExtratoAtual: TChangeTabAction;
    actTabCadastro: TChangeTabAction;
    Layout5: TLayout;
    recSaldoAtual: TRectangle;
    Layout7: TLayout;
    Layout8: TLayout;
    SkLabel4: TSkLabel;
    lblValorAtivo: TSkLabel;
    Layout9: TLayout;
    SkSvg1: TSkSvg;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    SkLabel41: TSkLabel;
    recSaldoPendente: TRectangle;
    Layout6: TLayout;
    Layout10: TLayout;
    SkLabel3: TSkLabel;
    lblValorExpirar: TSkLabel;
    Layout11: TLayout;
    SkSvg2: TSkSvg;
    Layout12: TLayout;
    SkSvg5: TSkSvg;
    SkLabel6: TSkLabel;
    Layout13: TLayout;
    Layout49: TLayout;
    btnExtrato: TRectangle;
    Layout34: TLayout;
    SkSvg10: TSkSvg;
    SkLabel30: TSkLabel;
    Layout33: TLayout;
    Rectangle17: TRectangle;
    Layout16: TLayout;
    Layout39: TLayout;
    Layout40: TLayout;
    lblTotal: TSkLabel;
    lblValorTotal: TSkLabel;
    Rectangle18: TRectangle;
    lblDia: TSkLabel;
    Layout18: TLayout;
    SkLabel9: TSkLabel;
    SkLabel28: TSkLabel;
    Layout50: TLayout;
    Rectangle15: TRectangle;
    SkLabel26: TSkLabel;
    Layout51: TLayout;
    Rectangle16: TRectangle;
    SkLabel29: TSkLabel;
    GosLine5: TGosLine;
    lylDetalhe: TLayout;
    Layout14: TLayout;
    Layout15: TLayout;
    SkSvg6: TSkSvg;
    SkLabel7: TSkLabel;
    Layout17: TLayout;
    Layout22: TLayout;
    recQrcode: TRectangle;
    Layout23: TLayout;
    SkLabel8: TSkLabel;
    Layout26: TLayout;
    SkLabel11: TSkLabel;
    recInfo: TRectangle;
    Layout29: TLayout;
    SkSvg9: TSkSvg;
    Image1: TImage;
    SkLabel10: TSkLabel;
    Layout24: TLayout;
    SkSvg7: TSkSvg;
    SkLabel12: TSkLabel;
    Layout25: TLayout;
    SkSvg8: TSkSvg;
    SkLabel13: TSkLabel;
    lylInfo: TLayout;
    SkSvg13: TSkSvg;
    SkLabel14: TSkLabel;
    Layout27: TLayout;
    tabExtratoExpira: TTabItem;
    Rectangle1: TRectangle;
    Layout28: TLayout;
    GosButtonView3: TGosButtonView;
    SkSvg14: TSkSvg;
    GosButtonView4: TGosButtonView;
    SkSvg16: TSkSvg;
    Layout30: TLayout;
    Layout31: TLayout;
    SkLabel5: TSkLabel;
    SkLabel15: TSkLabel;
    Layout32: TLayout;
    Layout35: TLayout;
    btnExtratoEx: TRectangle;
    Layout36: TLayout;
    SkSvg19: TSkSvg;
    SkLabel16: TSkLabel;
    Layout37: TLayout;
    Rectangle3: TRectangle;
    Layout38: TLayout;
    Layout43: TLayout;
    Layout44: TLayout;
    SkLabel17: TSkLabel;
    SkLabel18: TSkLabel;
    Rectangle4: TRectangle;
    SkLabel19: TSkLabel;
    Layout46: TLayout;
    SkLabel20: TSkLabel;
    SkLabel23: TSkLabel;
    Layout52: TLayout;
    Rectangle5: TRectangle;
    SkLabel25: TSkLabel;
    Layout53: TLayout;
    Rectangle6: TRectangle;
    SkLabel27: TSkLabel;
    GosLine1: TGosLine;
    lylExpirar: TLayout;
    actTabExtratoExpira: TChangeTabAction;
    procedure FormCreate(Sender: TObject);
    procedure GosButtonView8Click(Sender: TObject);
    procedure GosButtonView7Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure GosButtonView1Click(Sender: TObject);
    procedure GosButtonView2Click(Sender: TObject);
    procedure recSaldoAtualClick(Sender: TObject);
    procedure recSaldoPendenteClick(Sender: TObject);
    procedure btnExtratoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FMSG:  TFancyDialog;
    FFrmLstVert: TFrameListModel;
    FFrmLstVert2: TFrameListModel;
    FJsonExtratoTransacao: TJSONArray;
    FJsonExtratoPendente: TJSONArray;
    function ConsultaExtrato(ACPF: String; out AJson: TJSONObject): boolean;
    procedure SairConta;
    procedure ExtratoCashBack(AJson: TJSONArray; Acor: Cardinal; AScroll: TLayout; AFrame: TFrameListModel);
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaTela(AJsonRetorno: TJSONObject);
        property Action;
  end;

var
  frmClubeSTZ: TfrmClubeSTZ;

implementation

{$R *.fmx}

uses uConnection, uToken, controller.log, view.Principal, view.menu,
  view.SelecaoCartao, Notificacao,
  IdeaL.Lib.View.Utils,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1, uFormataCampos, model.fatura;

procedure TfrmClubeSTZ.btnExtratoClick(Sender: TObject);
begin
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Atualizando listagem...';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if TRectangle(Sender).Name = 'btnExtrato' then
      begin
        if lylExpirar.tag = 1 then
        begin
          tabcontrol1.ActiveTab := tabExtratoExpira;
          exit;
        end;
        recSaldoPendenteClick(self);
      end;

      if TRectangle(Sender).Name = 'btnExtratoEx' then
      begin
        if lylDetalhe.tag = 1then
        begin
          tabcontrol1.ActiveTab := tabExtratoAtual;
          exit;
        end;
        recSaldoatualClick(self);
      end;
    finally
      TThread.Synchronize(nil,
        procedure
        begin
          recLoading.Visible := false;
          lylLoading.Visible := false;
        end);
    end;
  end).start;

end;

procedure TfrmClubeSTZ.btnSairClick(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmClubeSTZ.btnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmClubeSTZ.CarregaTela(AJsonRetorno: TJSONObject);
var
  LJrExtrato : TJSONObject;
begin
  lylDetalhe.tag := 0;
  lylExpirar.tag := 0;

  if (AJsonRetorno.GetValue('cpf') <> nil) and (AJsonRetorno.GetValue<boolean>('isActive'))   then
  begin
    ConsultaExtrato(AJsonRetorno.GetValue<string>('cpf'),LJrExtrato);

    if (LJrExtrato.GetValue('message') <> nil) then
    begin
      TLoading.ToastMessage(frmClubeSTZ,LJrExtrato.GetValue<string>('message'),5,TAlignLayout.MostRight);
      lblValorAtivo.Text := 'R$ 0,00';
      lblValorExpirar.Text := 'R$ 0,00';
      recSaldoAtual.hittest := false;
      recSaldoPendente.HitTest := false;

    end
    else
    begin
      lblValorAtivo.Text := FormatFloat('R$ #,##0.00',LJrExtrato.GetValue<double>('balanceValue',0));
      lblValorExpirar.Text := FormatFloat('R$ #,##0.00',LJrExtrato.GetValue<double>('toCompensateValue',0));

      recSaldoAtual.hittest := true;
      recSaldoPendente.HitTest := true;

      FJsonExtratoTransacao:= LJrExtrato.GetValue<TJSONArray>('transactions');
      FJsonExtratoPendente:= LJrExtrato.GetValue<TJSONArray>('pendingTransactions');
    end;
    TabControl1.ActiveTab := tabResumo;
  end
  else
    TabControl1.ActiveTab := tabCadastro;

end;

procedure TfrmClubeSTZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmClubeSTZ := nil;
end;

procedure TfrmClubeSTZ.FormCreate(Sender: TObject);
begin
  FMSG:=  TFancyDialog.Create(self);
  TabControl1.TabPosition := TTabPosition.None;
end;

procedure TfrmClubeSTZ.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMSG);
  dmFatura.memExtratoCashBack.close;
end;

procedure TfrmClubeSTZ.GosButtonView1Click(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmClubeSTZ.GosButtonView2Click(Sender: TObject);
begin
  actTabResumo.Execute;
end;

procedure TfrmClubeSTZ.GosButtonView7Click(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmClubeSTZ.GosButtonView8Click(Sender: TObject);
begin
  close;
end;

procedure TfrmClubeSTZ.recSaldoAtualClick(Sender: TObject);
var
  LJsonExtrato: TJSONArray;
  Acor: cardinal;
begin
  if FJsonExtratoTransacao.Count = 0 then
    TLoading.ToastMessage(frmClubeSTZ,'Sem Transações',5,TAlignLayout.MostRight)
  else
  begin
    if lylDetalhe.tag = 0 then
    begin
      sklabel22.text := 'Saldo atual';
      SkLabel30.Text := 'Eventos futuros';
      Rectangle18.Fill.Color := $FFE400E4;
      GosLine5.stroke.Color := $FFE400E4;
      Rectangle15.Fill.Color := $FFF9E5F7;
      Rectangle16.Fill.Color := $FFF9E5F7;
      lblValorTotal.Text := lblValorAtivo.Text;
      lylDetalhe.Tag := 1;
      ExtratoCashBack(FJsonExtratoTransacao, uFormataCampos.StrToCardinal('$FFF9E5F7'), lylDetalhe, FFrmLstVert);
    end;
    tabcontrol1.ActiveTab := tabExtratoAtual;
  end;
end;

procedure TfrmClubeSTZ.recSaldoPendenteClick(Sender: TObject);
begin
  if FJsonExtratoPendente.Count = 0 then
    TLoading.ToastMessage(frmClubeSTZ,'Sem Transações',5,TAlignLayout.MostRight)
  else
  begin
    if lylExpirar.tag = 0 then
    begin
      sklabel15.text := 'Eventos futuros';
      SkLabel16.Text := 'Saldo atual';
      Rectangle4.Fill.Color := $FF069999;
      GosLine1.stroke.Color := $FF069999;
      Rectangle5.Fill.Color := $FFebf7f7;
      Rectangle6.Fill.Color := $FFebf7f7;
      sklabel18.Text := lblValorExpirar.Text;
      lylExpirar.Tag := 1;
      ExtratoCashBack(FJsonExtratoPendente, uFormataCampos.StrToCardinal('$FFebf7f7'), lylExpirar, FFrmLstVert2);
    end;
    tabcontrol1.ActiveTab := tabExtratoExpira;
  end;
end;

function TfrmClubeSTZ.ConsultaExtrato(ACPF: String; out AJson: TJSONObject): boolean;
var
  Lconnection: TConnection;
  LResult: string;
  LArray: TJSONArray;
  LJson: TJSONValue;
begin
  LConnection:= TConnection.Create;
  try
    try
      if LConnection.Get(FURL+'/v5/clubez-composite/cashback/'+Acpf,[], LResult, FToken) then
      begin
        result := true;
        AJson := TJSONObject.ParseJSONValue(LResult) as TJSONObject;
      end
      else
      begin
        LArray:= TJSONArray.ParseJSONValue(LResult) as TJSONArray;
        for LJson in LArray do
        begin
          AJson := LJson.GetValue<TJSONObject>;
        end;
        result := false;
        log('Erro: '+LResult)
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

procedure TfrmClubeSTZ.SairConta;
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
          frmClubeSTZ.close;
          frmMenu.close;
          frmSelecaoCartao.Close;
        end);
      end;
    end).Start;
  end,'NÃO');
end;

procedure TfrmClubeSTZ.ExtratoCashBack(AJson: TJSONArray; Acor: Cardinal; AScroll: TLayout; AFrame: TFrameListModel);
begin
  TUtils.TextMessageColorOpacity := 'Black';
  if assigned(AFrame) then
  begin
    exit;// FreeAndNil(AFrame);
  end;

  try
    AFrame := TFrameListModel.Create(Self);
    AFrame.BeginUpdate;
    AFrame.Parent := AScroll;
    AFrame.Align := TAlignLayout.Client;
    AFrame.IsGradientTransparency := false;

    AFrame.AddItem(TFilVert1,AJson,Acor);

  finally
    AFrame.EndUpdate;
    AScroll.Visible := true;
  end;
end;

end.
