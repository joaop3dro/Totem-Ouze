{ ******************************************************* }
{ This component makes usage of Alcinoe library where }
{ can be found its license information on: }
{ https://github.com/MagicFoundation/Alcinoe/blob/master/license.txt }
{ }
{ Magic Foundation, All rights reserved }
{ }
{ ******************************************************* }
unit IdeaL.Lib.View.Fmx.FrameListModel;
interface
uses
  System.Math,
  System.SysUtils,
  System.Types,
  System.StrUtils,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.JSON,
  System.Generics.Collections,
  Fmx.Types,
  Fmx.Graphics,
  Fmx.Controls,
  Fmx.Forms,
  Fmx.Dialogs,
  Fmx.StdCtrls,
  Fmx.Layouts,
  Fmx.Objects,
  FMX.ListBox,
  Fmx.Controls.Presentation,
  FMX.Skia.Canvas,
{$IFDEF ComponentTipScrollBox}
  ALFmxLayouts,
  iPub.Fmx.HorzScrollBox.Base,
  iPub.Fmx.HorzScrollBox,
  iPub.Fmx.VertScrollBox.Base,
  iPub.Fmx.VertScrollBox,
{$ENDIF}
  IdeaL.Lib.View.Fmx.FrameItemListModel,
  IdeaL.Lib.View.Fmx.FrameItemCoberturaListModel;
type
  TFrameItemListModel = IdeaL.Lib.View.Fmx.FrameItemListModel.TFrameItemListModel;
type
  TFrameCoberturaListModel = IdeaL.Lib.View.Fmx.FrameItemCoberturaListModel.TFrameCoberturaListModel;
type
  TTela = (PagarFatura, ExtratoFatura, ParcelaEmprestimo);
  IScrollBoxLocal = interface
    ['{BAFE747B-FA28-4598-97BB-3B0F8B1EF314}']
    procedure SetIsGradientTransparency(const Value: Boolean);
    function GetIsGradientTransparency: Boolean;
    property IsGradientTransparency: Boolean read GetIsGradientTransparency write SetIsGradientTransparency;
  end;
  TScrollBoxLocal = class(TScrollBox, IScrollBoxLocal)
  private
    FIsGradientTransparency: Boolean;
    function GetIsGradientTransparency: Boolean;
    procedure SetIsGradientTransparency(const Value: Boolean);
    { private declarations }
  protected
    procedure PaintChildren; override;
    { protected declarations }
  public
    property IsGradientTransparency: Boolean read GetIsGradientTransparency write SetIsGradientTransparency;
    { public declarations }
  end;
{$IFDEF ComponentTipScrollBox}
  TipHorzScrollBoxLocal = class(TipHorzScrollBox, IScrollBoxLocal)
  private
    FIsGradientTransparency: Boolean;
    FIsEndOfListing: Boolean;
    FViewPort: Single;
    function GetIsGradientTransparency: Boolean;
    procedure SetIsGradientTransparency(const Value: Boolean);
    function MaxViewPort: Single;
    { private declarations }
  protected
    procedure PaintChildren; override;
    procedure ViewportPositionChange(
      const AOldViewportPosition,
      ANewViewportPosition: TPointF;
      const AContentSizeChanged: Boolean
      ); override;
    { protected declarations }
  public
    property IsGradientTransparency: Boolean read GetIsGradientTransparency write SetIsGradientTransparency;
    { public declarations }
  end;
  TipVertScrollBoxLocal = class(TipVertScrollBox, IScrollBoxLocal)
  private
    FIsGradientTransparency: Boolean;
    FIsEndOfListing: Boolean;
    FViewPort: Single;
    function GetIsGradientTransparency: Boolean;
    procedure SetIsGradientTransparency(const Value: Boolean);
    function MaxViewPort: Single;
    { private declarations }
  protected
    procedure PaintChildren; override;
    procedure ViewportPositionChange(
      const AOldViewportPosition,
      ANewViewportPosition: TPointF;
      const AContentSizeChanged: Boolean
      ); override;
    { protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property IsGradientTransparency: Boolean read GetIsGradientTransparency write SetIsGradientTransparency;
    { public declarations }
  end;
{$ENDIF}
  TCustomScrollBox =
{$IFDEF ComponentTipScrollBox}
    TALCustomScrollBox
{$ELSE}
    TScrollBox
{$ENDIF}
    ;
  TFrameListModel = class(TFrame)
    lytBackground: TLayout;
    lytEmptyResult: TLayout;
    lblEmptyResult: TLabel;
    pthEmptyResult: TPath;
    lytEmptyResultIcon: TLayout;
  private
    FObjList: TObjectList<TControl>;
    FClickItem: TNotifyEvent;
    FItemSelected: TControl;
    FFrameListOnDemand: TFrame;
    FOnDemandBoolean: TProc<Boolean>;
    FIsHideEmptyResultIcon: Boolean;
    FItemAlign: TAlignLayout;
    FScrlList: TCustomScrollBox;
    FMovimento : Boolean;
    FDemandCountShow: Integer;
    FIsGradientTransparency: Boolean;
    procedure ClickItem(Sender: TObject);
    procedure FScrlListViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure TapItem(Sender: TObject; const Point: TPointF);
    function GetChildrenCount: Integer;
    function GetContentHeight: Single;
    procedure SetItemSelected(const Value: TControl);
    procedure SetFrameListOnDemand(const Value: TFrame);
    procedure OnPaitingOnDemand(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure SetOnDemandBoolean(const Value: TProc<Boolean>);
    procedure SetItemAlign(const Value: TAlignLayout);
    procedure SetIsHideEmptyResultIcon(const Value: Boolean);
    procedure SetIsGradientTransparency(const Value: Boolean);
{$IFDEF MSWINDOWS}
    procedure ItemClick(Sender: TObject);
    procedure ItemCartaoClick(Sender: TObject);
    procedure ItemSeguroClick(Sender: TObject);
    procedure ItemEmprestimoClick(Sender: TObject);
    procedure ItemParcelaEmprestimoClick(Sender: TObject);
    procedure ItemMenuClick(Sender: TObject);
{$ELSE}
    procedure ItemClick(Sender: TObject; const Point: TPointF);
    procedure ItemCartaoClick(Sender: TObject; const Point: TPointF);
    procedure ItemSeguroClick(Sender: TObject; const Point: TPointF);
    procedure ItemEmprestimoClick(Sender: TObject; const Point: TPointF);
    procedure ItemParcelaEmprestimoClick(Sender: TObject; const Point: TPointF);
    procedure ItemMenuClick(Sender: TObject; const Point: TPointF);
{$ENDIF}
    { Private declarations }
  public
    Fmodo: TTela;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    property ChildrenCount: Integer read GetChildrenCount;
    property ContentHeight: Single read GetContentHeight;
    property OnClickItem: TNotifyEvent read FClickItem write FClickItem;
    property ObjList: TObjectList<TControl> read FObjList;
    property IsHideEmptyResultIcon: Boolean read FIsHideEmptyResultIcon write SetIsHideEmptyResultIcon;
    procedure ClearList(ATarget: TFmxObject; AClickItem: TNotifyEvent); overload;
    procedure ClearList(); overload;
    function AddItem(AClass: TComponentClass;AIDConta: Integer; AMes, Asituacao: string;ADTVencimento: Tdatetime;AValormin,AValor:double; ATela:TTela;AFaturaPaga:Boolean ): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; ACartao: String; AJsonInfo: TJSONObject; ANome, AnumCard: string): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AJson: TJSONArray; AValorSeguro: double) : TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AJsonSeguro: TJSONArray; AaTivos: Boolean): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AJsonExtrato: TJSONObject;Acor: Cardinal;AMes,AVencimento,AValor:string): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AJsonContratosEmprestimo: TJSONObject): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AnumeroOperacao, AdataLiquidaParcel: string;ANumeroParcela: integer; ADTVencimento: TDateTime;Ames,ASituacao: String; AValorMin,AValorTotal: double; ABoletoRegistrado: Boolean): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AJsonMenu: TJSONArray): TFrameItemListModel; overload;
    function AddItem(AClass: TComponentClass; AJsonExtrato: TJSONArray;Acor: Cardinal): TFrameItemListModel; overload;
    procedure FinishListing;
    property ItemSelected: TControl read FItemSelected write SetItemSelected;
    property ItemAlign: TAlignLayout read FItemAlign write SetItemAlign;
    property VtsList: TCustomScrollBox read FScrlList;
    property DemandCountShow: Integer read FDemandCountShow write FDemandCountShow;
    property FrameListOnDemand: TFrame read FFrameListOnDemand write SetFrameListOnDemand;
    property OnDemandBoolean: TProc<Boolean> read FOnDemandBoolean write SetOnDemandBoolean;
    /// <summary> Show a transparency gradient to give an idea of 'there is more items'
    /// </summary>
    property IsGradientTransparency: Boolean read FIsGradientTransparency write SetIsGradientTransparency;
    { Public declarations }
  end;
implementation
uses
{$IFDEF SKIA}
  Skia,
  FMX.Skia,
{$ENDIF}
  IdeaL.Lib.View.Utils,
  Fmx.Utils,
  System.UIConsts, view.PagarFatura, uFancyDialog, view.ExtratoFatura, uAguarde,
  uToken, Notificacao, controller.imagens, LogSQLite.Config, controller.log,
  view.SelecaoCartao, view.menu, view.Seguros, frame.cobertura, uIconsSvg,
  uCamelCase, frame.seguros, frame.parcelas, frame.extrato, uFormataCampos,
  frame.cartao, frame.ContratoEP, view.Emprestimo, model.fatura, frame.menu,
  view.ClubeSTZ, frame.ExtratoCashBack;
{$R *.fmx}
{ TFrameListModel }
procedure TFrameListModel.FScrlListViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
  var
  LTop, LScrollTot,LPosicaoLast,Lcount: single;
begin
  FMovimento := true;
end;
{$IFDEF MSWINDOWS}
procedure TFrameListModel.ItemMenuClick(Sender: TObject);
{$ELSE}
procedure TFrameListModel.ItemMenuClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
begin
  if FMovimento then
  begin
    FMovimento := false;
    exit;
  end;
  frmMenu.ItemMenuClick(sender);
end;
{$IFDEF MSWINDOWS}
procedure TFrameListModel.ItemCartaoClick(Sender: TObject);
{$ELSE}
procedure TFrameListModel.ItemCartaoClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
 LJsonInfo : TJSONObject;
begin
  if FMovimento then
  begin
    FMovimento := false;
    exit;
  end;

  TFrameItemListModel(Sender).recloading.Visible := true;
  TFrameItemListModel(Sender).loading.Visible := true;
  TFrameItemListModel(Sender).loading.Animation.Start;
  try
    LJsonInfo := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFrameItemListModel(Sender).Tagstring), 0) as TJSONObject;

    if (LJsonInfo.GetValue<String>('Status') <> 'NORMAL') then
    begin
      if (LJsonInfo.GetValue<String>('Status') <> 'LIBERADO') then
      begin
        if Pos('BLOQUE',UpperCase(LJsonInfo.GetValue<string>('Status')))<>0 then
        begin
          frmSelecaoCartao.FMSG.Show(TIconDialog.Warning, 'Atenção','Cartão bloqueado, favor dirigir-se ao espaço Ouze.','OK');
          Log('Cartão: '+LJsonInfo.getValue<String>('NumCard')+' bloqueado');
          exit;
        end
        else
        begin
          frmSelecaoCartao.FMSG.Show(TIconDialog.Warning, 'Atenção','Cartão com problema, favor dirigir-se ao espaço Ouze.!','OK');
          Log('Cartão: '+LJsonInfo.getValue<String>('NumCard')+' com problema');
          exit;
        end;
      end;
    end;

    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmMenu) then
            Application.CreateForm(TfrmMenu, frmMenu);
        end);
        frmMenu.carregaTela(LJsonInfo);
        TThread.Synchronize(nil,
        procedure
        begin
          frmMenu.Show;
        end);

      finally
        TThread.Synchronize(nil,
        procedure
        begin
          log('Login realizado no cartão: '+LJsonInfo.getValue<String>('NumCard'));
          TFrameItemListModel(Sender).loading.visible := false;
          TFrameItemListModel(Sender).recloading.Visible := false;
        end);
      end;
    end).Start;
  finally
    TFrameItemListModel(Sender).loading.Animation.stop;
    TFrameItemListModel(Sender).loading.Visible := false;
    TFrameItemListModel(Sender).recloading.Visible := false;
  end;
end;
{$IFDEF MSWINDOWS}
procedure TFrameListModel.ItemClick(Sender: TObject);
{$ELSE}
procedure TFrameListModel.ItemClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
  LValorFatura: double;
  LValorMinimo: double;
  LDataVencimento: string;
  LcorS: Cardinal;
  LjsonExtrato: TJSONObject;
begin
  if FMovimento then
  begin
    FMovimento := false;
    exit;
  end;

  if (FModo = TTela.PagarFatura) and (TFrameItemListModel(sender).lbltitulo.Text = 'Fatura Paga') then
    exit;

  if (FModo = TTela.PagarFatura) and (UpperCase(TFrameItemListModel(sender).SkLabel41.TagString) <> 'FECHADA') then
    exit;

  if (FModo = TTela.PagarFatura) then
  begin
    if  (UpperCase(TFrameItemListModel(sender).SkLabel41.TagString) = 'FECHADA') or
         (UpperCase(TFrameItemListModel(sender).SkLabel41.TagString) = 'FECHADO') then
    begin
      if frmPagarFatura.FQrCode then
      begin
        frmPagarFatura.actTabInfo.Execute;
        exit;
      end
      else
       exit;
    end;
  end;

  TFrameItemListModel(Sender).recloading.Visible := true;
  TFrameItemListModel(Sender).loading.Visible := true;
  TFrameItemListModel(Sender).loading.Animation.Start;
  if FModo = TTela.PagarFatura then
  begin
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
        log('verifica log');
        if not frmPagarFatura.ConsultaQRCode(frmPagarFatura.FCPF,TFrameItemListModel(sender).TagString,frmPagarFatura.FIDproduct) then
        begin
          TLoading.ToastMessage(frmPagarFatura,'Erro ao gerar QRCode' ,5,TAlignLayout.MostRight);
          log('Erro na rquisicao');
          exit;
        end
        else
        begin
          log('Modificiando tela do qrcode');
          frmPagarFatura.SkLabel35.Text := 'FATURA DE '+TFrameItemListModel(Sender).lblmes.Text;
          frmPagarFatura.SkLabel34.Text := TFrameItemListModel(Sender).lblValor.Text;
          TThread.Synchronize(nil,
          procedure
          begin
            frmPagarFatura.actTabPix.Execute;
          end);
          log('mudando a tab para a tela de qrcode');
        end;

      finally
        TFrameItemListModel(Sender).loading.Animation.stop;
        TFrameItemListModel(Sender).loading.Visible := false;
        TFrameItemListModel(Sender).recloading.Visible := false;

        log('Parando o loading');
      end;
    end).Start;
  end
  else if FModo = TTela.ExtratoFatura then
  begin
    Log('Buscando informações');
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        Log('Verificando o token para consulta extrato fatura');
        if FToken.IsEmpty  then
        begin
          if not ConsultaToken(FURL+'/v1/authentication', FToken) then
          begin
            Log('Erro ao consultar token (Extrato fatura)');
            exit;
          end;
        end;
        if not frmExtratoFatura.ConsultaExtratoFatura(TFrameItemListModel(sender).Tag.tostring,TFrameItemListModel(sender).TagString, LjsonExtrato) then
        begin
          Log('Erro ao consultar extrato, função retornou falso');
        end
        else
        begin
          frmExtratoFatura.ListaItensFatura( LjsonExtrato,
                           LcorS,TFrameItemListModel(sender).lblmes.text,
                           TFrameItemListModel(sender).lblDataVencimento.text,
                           TFrameItemListModel(sender).lblValor.text);
          log('Listando os itens da fatura');
          case AnsiIndexStr(UpperCase(TFrameItemListModel(sender).lbldataPagamento.TagString), ['ABERTA', 'FECHADA','PAGA'])   of
            0: begin
                 frmExtratoFatura.Rectangle15.Fill.Color := $FFE7EFEF;
                 frmExtratoFatura.Rectangle16.Fill.Color := $FFE7EFEF;
                 LcorS := StrToCardinal('$FF'+copy('#E7EFEF',2,length('#E7EFEF')));
               end;
            1: begin
                 frmExtratoFatura.Rectangle15.Fill.Color := $FFF9E5F7;
                 frmExtratoFatura.Rectangle16.Fill.Color := $FFF9E5F7;
                 LcorS := StrToCardinal('$FF'+copy('#F9E5F7',2,length('#F9E5F7')));
               end;
            2: begin
                 frmExtratoFatura.Rectangle15.Fill.Color := $FFE8F4E5;
                 frmExtratoFatura.Rectangle16.Fill.Color := $FFE8F4E5;
                 LcorS := StrToCardinal('$FF'+copy('#E8F4E5',2,length('#E8F4E5')));
               end;
          end;
          log('status da fatura');
          frmExtratoFatura.Rectangle18.Fill.Color := TFrameItemListModel(sender).recMes.fill.Color;
          frmExtratoFatura.Rectangle18.Fill.Color := TFrameItemListModel(sender).recMes.fill.Color;
          frmExtratoFatura.GosLine5.stroke.Color :=TFrameItemListModel(sender).recMes.fill.Color;
          frmExtratoFatura.SkSvg9.svg.overrideColor := TFrameItemListModel(sender).recMes.fill.Color;
          frmExtratoFatura.SkSvg10.svg.overrideColor := TFrameItemListModel(sender).recMes.fill.Color;
          frmExtratoFatura.SkSvg13.svg.overrideColor := TFrameItemListModel(sender).recMes.fill.Color;
          frmExtratoFatura.lblSubtitulo.Text := 'Fatura '+TFrameItemListModel(sender).lbldataPagamento.TagString;
          frmExtratoFatura.SkLabel7.Words[1].Text := FormatDateTime('dd/mm', LjsonExtrato.GetValue<TDateTime>('dueDate')+2);
          log('Montando Visual da lista de entrato');
          TThread.Synchronize(nil,
          procedure
          begin
            frmExtratoFatura.actTabDetalheExtrato.Execute;
          end);
          log('Exibindo a tela');
        end;
      finally
        TThread.Synchronize(nil,
        procedure
        begin
          TFrameItemListModel(Sender).loading.Animation.stop;
          TFrameItemListModel(Sender).loading.Visible := false;
          TFrameItemListModel(Sender).recloading.Visible := false;
          log('Fim tthread e loading');
        end);
      end;
    end).start;
  end
  else if FModo = TTela.ParcelaEmprestimo then
  begin
  end;
end;
{$IFDEF MSWINDOWS}
procedure TFrameListModel.ItemSeguroClick(Sender: TObject);
{$ELSE}
procedure TFrameListModel.ItemSeguroClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
  LjsonSeguros: TJSONObject;
  LJsonCobertura: TJSONArray;
  Ldescricao: string;
begin
  if FMovimento then
  begin
    FMovimento := false;
    exit;
  end;
  frmSeguros.recLoading.Visible := true;
  frmSeguros.lylLoading.Visible := true;
  frmSeguros.lblTituloLoading.Text := 'Aguarde';
  frmSeguros.lblSubtituloLoading.Text := 'Estamos processando as informações';
  TThread.CreateAnonymousThread(
  procedure
  var
    LJson: TJSONValue;
  begin
    try
      if TRectangle(sender).Tag = 999 then
      begin
        if not assigned(frmSeguros.FFrmLstSeguros) then
          frmSeguros.ListaSegurosDisponivel(frmSeguros.FJsonDisponiveis);
        TThread.Synchronize(nil,
        procedure
        begin
          frmSeguros.actTabSeguros.Execute;
        end);
        frmSeguros.FTabAnterior := frmSeguros.tabSegurosContratados;
        frmSeguros.recLoading.Visible := false;
        frmSeguros.lylLoading.Visible := false;
      end
      else
      begin
        LjsonSeguros := TJSONObject.ParseJSONValue(TframeSeguros(sender).TagString) as TJSONObject;
        LJsonCobertura := LjsonSeguros.GetValue<TJSONArray>('coverages');
        log('Pegando a cobertura do seguro'+LJsonCobertura.ToString);
        frmSeguros.lblTitulo.Text :=  LjsonSeguros.GetValue<string>('name');
        Ldescricao := LjsonSeguros.GetValue<string>('description');
        Ldescricao := Ldescricao.Replace(';','; ');
        Ldescricao := Ldescricao.Replace(';  ','; ');
        frmSeguros.lblDescricao.Text := Ldescricao;
        if length(frmSeguros.lblDescricao.Text) > 320  then
          frmSeguros.lblDescricao.TextSettings.Font.Size := 14;
        if LjsonSeguros.GetValue<boolean>('allowsAccession') then
        begin
          frmSeguros.Rectangle8.Fill.Color := $FF069999;
          frmSeguros.GosLine5.Stroke.Color := $FF069999;
        end
        else
        begin
          frmSeguros.Rectangle8.Fill.Color := $FFE400E4;
          frmSeguros.GosLine5.Stroke.Color := $FFE400E4;
        end;
        log('Setando a imagem logo');
        case  LjsonSeguros.GetValue<integer>('id') of
          2 : frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\lar.png');
          6 : frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\saude.png');
          7 : frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\odonto.png');
          30: frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\bolsaprotegida.png');
          31: frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\acidentes.png');
          32: frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\desemprego.png');
          34: frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\autoemoto.png');
          37: frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\protecao mulher.png');
          38: frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\protecao pet.png');
          else
            frmSeguros.Image1.Bitmap.LoadFromFile('C:Seguros\generico.png');
        end;
        log('Montando a lista das coberturas do seguro');
        frmSeguros.ListaCobertura(LJsonCobertura,LjsonSeguros.GetValue<double>('salePrice') );
        log('Finalizou');
        frmSeguros.recLoading.Visible := false;
        frmSeguros.lylLoading.Visible := false;
        log('Parou o loading');
        TThread.Synchronize(nil,
        procedure
        begin
          frmSeguros.actTabSeguroDetalhe.Execute;
          log('Mudou a tab');
        end);
        if UPPERCASE(TframeSeguros(sender).lblContratado.Text) = 'CONTRATADO' then
          frmSeguros.FTabAnterior := frmSeguros.tabSegurosContratados
        else
          frmSeguros.FTabAnterior := frmSeguros.tabSegurosGeral;
      end;
    finally
    end;
  end).Start;
end;

{$IFDEF MSWINDOWS}
procedure TFrameListModel.ItemEmprestimoClick(Sender: TObject);
{$ELSE}
procedure TFrameListModel.ItemEmprestimoClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
  LJsonArray: TJSONArray;
begin
  if FMovimento then
  begin
    FMovimento := false;
    exit;
  end;

  frmEmprestimo.recLoading.Visible := true;
  frmEmprestimo.lylLoading.Visible := true;
  frmEmprestimo.lblTitulo.Text := 'Aguarde';
  frmEmprestimo.SkLabel14.Text := 'Estamos processando as informações';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      LJsonArray := TJSONArray.ParseJSONValue(TFrameItemListModel(sender).TagString) as TJSONArray;

      TThread.Synchronize(nil,
      procedure
      begin
        frmEmprestimo.ListaParcelasEmprestimo(LJsonArray);
        frmEmprestimo.actTabExtratoEmprest.Execute;
      end);
//      frmEmprestimo.TabControl1.ActiveTab := frmEmprestimo.tabExtratoEmprest;
    finally
      TThread.Synchronize(nil,
        procedure
        begin
          frmEmprestimo.SkAnimatedImage1.Animation.stop;
          frmEmprestimo.recLoading.Visible := false;
          frmEmprestimo.lylLoading.Visible := false;
          log('Fim tthread e loading');
        end);
    end;
  end).start;
end;

{$IFDEF MSWINDOWS}
procedure TFrameListModel.ItemParcelaEmprestimoClick(Sender: TObject);
{$ELSE}
procedure TFrameListModel.ItemParcelaEmprestimoClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}

begin
  if FMovimento then
  begin
    FMovimento := false;
    exit;
  end;

  if TFrameItemListModel(sender).Tag = 1 then
  begin
    TLoading.ToastMessage(frmEmprestimo,'Boleto Não Disponível!',5,TAlignLayout.MostRight);
    exit;
  end;

  frmEmprestimo.recLoading.Visible := true;
  frmEmprestimo.lylLoading.Visible := true;
  frmEmprestimo.lblTitulo.Text := 'Aguarde';
  frmEmprestimo.SkLabel14.Text := 'Gerando o boleto...';
  TThread.CreateAnonymousThread(
  procedure
  var
    LjsonInfo: TJSONObject;
  begin
    try
      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          Log('Erro ao consultar token (Extrato fatura)');
          exit;
        end;
      end;

      TThread.Synchronize(nil,
      procedure
      begin
        LjsonInfo  := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TFrameItemListModel(sender).TagString), 0) as TJSONObject;
        if frmEmprestimo.ImprimirBoletoParcela(LjsonInfo) then
          TLoading.ToastMessage(frmEmprestimo,'Boleto impresso com sucesso!',5,TAlignLayout.MostRight)
        else
          TLoading.ToastMessage(frmEmprestimo,'Erro ao consultar boleto da parcela',5,TAlignLayout.MostRight);
      end);
    finally
      TThread.Synchronize(nil,
        procedure
        begin
          frmEmprestimo.SkAnimatedImage1.Animation.stop;
          frmEmprestimo.recLoading.Visible := false;
          frmEmprestimo.lylLoading.Visible := false;
          log('Fim tthread e loading');
        end);
    end;
  end).start;



end;
procedure TFrameListModel.ClickItem(Sender: TObject);
begin
  if Assigned(FClickItem) then
    FClickItem(Sender);
end;
constructor TFrameListModel.Create(AOwner: TComponent);
begin
  inherited;
  Name := Self.ClassName + TUtils.GetGUIDAsComponentName;
  FClickItem := nil;
  FObjList := TObjectList<TControl>.Create;
  FItemSelected := nil;
  FFrameListOnDemand := nil;
  FOnDemandBoolean := nil;
  FScrlList := nil;
  ItemAlign := TAlignLayout.Top;
  lytEmptyResult.Visible := False;
  pthEmptyResult.Fill.Color := StringToAlphaColor(TUtils.TextMessageColorOpacity);
  lblEmptyResult.TextSettings.FontColor := StringToAlphaColor(TUtils.TextMessageColorOpacity);
  IsHideEmptyResultIcon := False;
  DemandCountShow := 50;
  IsGradientTransparency := True;
end;
destructor TFrameListModel.Destroy;
begin
  if (Assigned(FObjList)) then
  begin
    while FObjList.Count > 0 do
      FObjList.ExtractAt(0);
    FreeAndNil(FObjList);
  end;
  inherited;
end;
procedure TFrameListModel.EndUpdate;
begin
  inherited;
  TThread.ForceQueue(nil,
    procedure
    begin
      try
        if Assigned(FScrlList.Content) then
          FScrlList.Content.EndUpdate;
        FScrlList.EndUpdate;
        FScrlList.Visible := True;
        FScrlList.BringToFront;
        if not IsHideEmptyResultIcon then
        begin
//          lytEmptyResult.Visible := ChildrenCount = 0;
//          if lytEmptyResult.Visible then
//            lytEmptyResult.BringToFront;
        end;
        FScrlList.Height := FScrlList.Height + 1;
        FScrlList.OnViewportPositionChange := FScrlListViewportPositionChange;
        FMovimento := false;
      except
      end;
    end);
end;
procedure TFrameListModel.FinishListing;
begin
  if ((ChildrenCount Mod DemandCountShow) = 0) then
  begin
    FrameListOnDemand := ObjList[Pred(ObjList.Count)] as TFrame;
  end;
end;
function TFrameListModel.GetChildrenCount: Integer;
begin
  Result := 0;
  if Assigned(FObjList) then
    Result := FObjList.Count;
end;
function TFrameListModel.GetContentHeight: Single;
begin
  Result := 0;
  if (TUtils.IsAssigned(Self)) and (Assigned(FObjList)) then
  begin
    for var LItem in FObjList do
    begin
      if Assigned(LItem) then
        Result := Result + TFrameItemListModel(LItem).Height;
    end;
  end;
end;
procedure TFrameListModel.OnPaitingOnDemand(Sender: TObject; Canvas: TCanvas;
const ARect: TRectF);
begin
  if Assigned(FFrameListOnDemand) then
  begin // Se estiver assinado tem que remover o Painting
    FFrameListOnDemand.OnPainting := nil;
    FFrameListOnDemand := nil;
  end;
  if Assigned(FOnDemandBoolean) then
    FOnDemandBoolean(False);
end;
procedure TFrameListModel.SetIsGradientTransparency(const Value: Boolean);
begin
  FIsGradientTransparency := Value;
  var
  LName := FScrlList.ClassName;
  if (Assigned(FScrlList)) then
  begin
    (FScrlList as IScrollBoxLocal).IsGradientTransparency := Value;
  end;
end;
procedure TFrameListModel.SetFrameListOnDemand(const Value: TFrame);
begin
  if Assigned(FFrameListOnDemand) then
  begin // Se estiver assinado tem que remover o Painting
    FFrameListOnDemand.OnPainting := nil;
    FFrameListOnDemand := nil;
  end;
  FFrameListOnDemand := Value;
  FFrameListOnDemand.OnPainting := OnPaitingOnDemand;
end;
procedure TFrameListModel.SetIsHideEmptyResultIcon(const Value: Boolean);
begin
  FIsHideEmptyResultIcon := Value;
end;
procedure TFrameListModel.SetItemAlign(const Value: TAlignLayout);
begin
  if (TUtils.IsAssigned(FScrlList)) and
    (Assigned(FObjList)) and
    (FObjList.Count > 0)
  then
    raise Exception.Create('ItemAlign could not be changed, please clear the list first');
  TThread.Synchronize(nil,
    procedure
    begin
      if (TUtils.IsAssigned(FScrlList)) then
        FreeAndNil(FScrlList);
{$IFDEF ComponentTipScrollBox}
      var
      LName := EmptyStr;
      LName := TUtils.GetEnumName<TAlignLayout>(Value);
      if TUtils.Contains(LName.Trim.ToUpper, ['LEFT', 'RIGHT']) then
      begin
        FScrlList := TipHorzScrollBoxLocal.Create(Self);
        TipHorzScrollBoxLocal(FScrlList).BoundsAnimation := False;
      end
      else
      begin
        FScrlList := TipVertScrollBoxLocal.Create(Self);
        TipVertScrollBoxLocal(FScrlList).BoundsAnimation := False;
      end;
{$ELSE}
      FScrlList := TScrollBoxLocal.Create(Self);
      TScrollBoxLocal(FScrlList).AniCalculations.BoundsAnimation := False;
{$ENDIF}
      (FScrlList as IScrollBoxLocal).IsGradientTransparency := IsGradientTransparency;
      FScrlList.Parent := lytBackground;
      FScrlList.Align := TAlignLayout.Contents;
      FScrlList.TabStop := False;
      FScrlList.ShowScrollBars := False;
      FScrlList.SendToBack;
    end);
  FItemAlign := Value;
end;
procedure TFrameListModel.SetItemSelected(const Value: TControl);
begin
  FItemSelected := Value;
end;
procedure TFrameListModel.SetOnDemandBoolean(const Value: TProc<Boolean>);
begin
  FOnDemandBoolean := Value;
end;
//LISTA FATURAS
function TFrameListModel.AddItem(AClass: TComponentClass; AIDConta: Integer; AMes, Asituacao: string;
                                  ADTVencimento: Tdatetime;AValormin,AValor:double; ATela: TTela; AFaturaPaga:Boolean): TFrameItemListModel;
var
  LName: string;
  LCount: Integer;
begin
  LName := FormatDateTime('yyyymmddhhnnsszzz', Now) + '_' + (Random(1000000) + 1).ToString;
  LCount := 0;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Rectangle2.Visible := true;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible := false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := false;
    Result.Rectangle5.Visible := false;
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    Result.Width := Result.Width + 13;
    Result.lblmes.Text := AMes;
    Result.lblValor.Text := FormatFloat('R$ #,##0.00' , AValor);
    Result.lblDataVencimento.Text := FormatDateTime('dd/mm/yyyy', ADTVencimento);
    if AFaturaPaga then
    begin
      Result.lbltitulo.Text := 'Fatura Paga';
      Result.SkLabel2.Text := 'Pagamento Realizado';
      Result.lbldataPagamento.Text :=FormatDateTime('dd/mm', ADTVencimento);
      Result.Layout45.Visible := false;
      Result.SkSvg15.svg.overrideColor := $FF38C31B;
      Result.recMes.Fill.Color := $FF38C31B;
      Result.GosLine1.stroke.Color := $FF38C31B;
      Result.lbldataPagamento.TagString := 'Paga';
    end
    else
    begin
      if Asituacao = 'Aberta' then
      begin
        Result.lbltitulo.Text := 'Fatura '+Asituacao;
        Result.SkLabel2.Text := 'Pagamento Mínimo';
        Result.lbldataPagamento.Text :=FormatFloat( 'R$ #,##0.00' , AValormin);
        if ATela = TTela.PagarFatura then
        begin
          Result.SkLabel41.text := '';
          Result.Layout45.Visible := false;
        end
        else
        begin
          if ADTVencimento < now then
            Result.SkLabel41.text := 'Realizar Pagamento com PIX'
          else
            Result.SkLabel41.text := 'Antecipar Pagamento com PIX';
          Result.Layout45.Visible := true;
        end;
        Result.SkSvg15.svg.overrideColor := $FF069999;
        Result.recMes.Fill.Color := $FF069999;
        Result.GosLine1.stroke.Color := $FF069999;
        Result.lbldataPagamento.TagString := ASituacao;
      end
      else if  Asituacao = 'Fechada'  then
      begin
        Result.lbltitulo.Text := 'Fatura '+Asituacao;
        Result.SkLabel2.Text := 'Pagamento Mínimo';
        Result.lbldataPagamento.Text :=FormatFloat( 'R$ #,##0.00' , AValormin);
        if frmPagarFatura.FQrCode then
        begin
          Result.SkLabel41.text := 'Realizar Pagamento com PIX';
          Result.Layout45.Visible := true;
        end
        else
        begin
          Result.SkLabel41.text := '';
        Result.Layout45.Visible := false;
        end;
        Result.SkSvg15.svg.overrideColor := $FFE400E4;
        Result.recMes.Fill.Color := $FFE400E4;
        Result.GosLine1.stroke.Color := $FFE400E4;
        Result.lbldataPagamento.TagString := ASituacao;
      end;
    end;
    Result.HitTest := true;
    Result.Tag := AIDConta;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.TagString:=   FormatDateTime('yyyy-mm-dd', ADTVencimento);
    FModo := ATela;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    (FScrlList as IScrollBoxLocal).IsGradientTransparency := false;
    if ATela = TTela.PagarFatura then
    begin
      Result.SkLabel41.visible := True;
      Result.SkLabel41.TagString := Asituacao;
      frmPagarFatura.FListaFaturas.Add(Result);
    end;
    if ATela = TTela.ExtratoFatura then
    begin
      Result.SkLabel41.visible := False;
      frmExtratoFatura.FListaFaturas.Add(Result);
    end;
    Result.Position.Y := ContentHeight;
{$IFDEF MSWINDOWS}
      Result.OnClick := ItemClick;
{$ELSE}
      Result.OnTap := ItemClick;
{$ENDIF}
    Result.SendToBack;
  except
    Result.Free;
    raise;
  end;
end;

//LISTA CARTÕES
function TFrameListModel.AddItem(AClass: TComponentClass; ACartao: String; AJsonInfo: TJSONObject; ANome, AnumCard: string): TFrameItemListModel;
var
  LName: string;
  LCount: Integer;
  LFrame:TframeCartao;
begin
  LName := FormatDateTime('yyyymmddhhnnsszzz', Now) + '_' + (Random(1000000) + 1).ToString;
  LCount := 0;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := true;
    result.Rectangle12.Visible := false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := false;
    Result.Rectangle5.Visible := false;
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    LFrame:= TframeCartao.Create(self);
    LFrame.Align := TAlignLayout.Client;
    LFrame.Name := 'FrameCartao'+(Random(1000000) + 1).ToString+FormatDateTime('ddmmyyyyhhmmsszzz', now);
    case strtoint(ACartao) of
      157: LFrame.imgStz.Bitmap.LoadFromFile('C:img\cVISA.png');
      else
          LFrame.imgStz.Bitmap.LoadFromFile('C:img\cSTZ.png');
    end;
    Lframe.lblPortador.Text := UpperCase(ANome);
    LFrame.lblNumCartao.Text := copy(AnumCard,9,length(AnumCard));
    LFrame.Parent := Result.Rectangle1;
    LFrame.HitTest := false;
    Result.TagString:= AJsonInfo.ToString;
    Result.SkSvg15.TagString:= AJsonInfo.ToString;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.HitTest := true;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    Result.Position.Y := ContentHeight;
//    (FScrlList as IScrollBoxLocal).IsGradientTransparency := false;
{$IFDEF MSWINDOWS}
      Result.OnClick := ItemCartaoClick;
      Result.SkSvg15.OnClick := ItemCartaoClick;
{$ELSE}
      Result.OnTap := ItemCartaoClick;
      Result.SkSvg15.OnTap := ItemCartaoClick;
{$ENDIF}
    Result.SendToBack;
   except
    Result.Free;
    raise;
  end;
end;
// LISTA COBERTURAS DE SEGUROS
function TFrameListModel.AddItem(AClass: TComponentClass; AJson: TJSONArray; AValorSeguro: double): TFrameItemListModel;
var
  LName: string;
  LCount,LCountC, i: Integer;
  Ljson: TJSONValue;
  LListBoxItem: TListBoxItem;
  Lframe :TframeCobertura;
begin
  LCountC := 0;
  LName := FormatDateTime('yyyymmddhhnnsszzz', Now) + '_' + (Random(1000000) + 1).ToString;
  LCount := 0;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    if AJson.Count < 10 then
      Result.Height:= frmSeguros.Layout10.Height-30
    else
      Result.Height:= (198 * Round(AJson.Count/5))+90;
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= false;
    result.Rectangle3.Visible := true;
    result.Rectangle4.Visible := false;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.Rectangle5.Visible := false;
    result.SkLabel4.Words[1].Text:= FormatFloat( 'R$ #,##0.00' , AValorSeguro);
    for Ljson in AJson do
    begin
      for i:=0 to Result.lbCobertura.Items.Count -1 do
      begin
        Result.lbCobertura.ListItems[i].HitTest := false;
        if Result.lbCobertura.ListItems[i].Visible = false then
        begin
          LFrame:= TframeCobertura.Create(self);
          LFrame.Align := TAlignLayout.Client;
          LFrame.Name := 'Frame'+LCountC.ToString+FormatDateTime('ddmmyyyyhhmmsszzz', now);
          Lframe.SkLabel4.Text := CamelCase(Ljson.GetValue<string>('name'));
          Lframe.SkSvg6.Svg.Source := TIconSvg.SelecionaIcon(Ljson.GetValue<string>('name'));
          if Pos('24h', Ljson.GetValue<string>('name')) <= 0 then
              Lframe.SkSvg6.Svg.OverrideColor := $FFE400E4;
          if length(Lframe.SkLabel4.Text) > 20 then
             Lframe.SkLabel4.TextSettings.Font.Size := 13;
          Lframe.HitTest := false;
          Result.lbCobertura.ListItems[i].AddObject(Lframe);
          Result.lbCobertura.ListItems[i].Visible := true;
          inc(LCountC);
          break;
        end;
        if LCountC = AJson.Count then
          break;
      end;
    end;
    result.HitTest := false;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    FScrlList.ShowScrollBars := true;
//    (FScrlList as IScrollBoxLocal).IsGradientTransparency := false;
    Result.Position.Y := ContentHeight;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
//LISTA SEGUROS CONTRATADOS E DISPONIVEIS PARA CONTRATAR
function TFrameListModel.AddItem(AClass: TComponentClass; AJsonSeguro: TJSONArray; AaTivos: Boolean): TFrameItemListModel;
var
  LName,LnameItem: string;
  LCount,LCountC, i: Integer;
  Ljson: TJSONValue;
  LListBoxItem: TListBoxItem;
  Lframe :TframeSeguros;
  LItemBox : TListBoxItem;
begin
  LName := TFrameItemListModel.ClassName+(Random(1000000) + 1).ToString;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    if AaTivos then
      Result.Height:= (220 * Round(AJsonSeguro.Count/3))+220
    else
      Result.Height:= (220 * Round(AJsonSeguro.Count/3));
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= true;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := false;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.ListBox1.Visible := false;
    Result.ListBox2.Visible := true;
    Result.Rectangle5.Visible := false;
    if AJsonSeguro.Count = 0 then
    begin
      Result.Layout16.visible := true;
      Result.Height :=  Result.Height+50;
    end
    else
    begin
      Result.Layout16.visible := false;
      for Ljson in AJsonSeguro do
      begin
        LnameItem := TListBoxItem.classname+inttostr(Ljson.GetValue<integer>('id'));
        LItemBox := TListBoxItem.Create(self);
        LItemBox.Name := LnameItem;
        LItemBox.Height := 220;
        LItemBox.Parent := Result.ListBox2;
        LItemBox.Visible := true;
        LItemBox.Text := '';
        LItemBox.HitTest := false;
        LItemBox.IsSelected := false;
        LFrame:= TframeSeguros.Create(self);
        LFrame.Align := TAlignLayout.Client;
        LFrame.Parent := LItemBox;
        LFrame.Rectangle1.Visible := false;
        LFrame.Rectangle2.Visible := true;
        LFrame.Name := TFrame.ClassName+ inttostr(Ljson.GetValue<integer>('id'));
        Lframe.lblNameProduct.Text := Ljson.GetValue<string>('name');
        if AaTivos then
        begin
          Lframe.lblContratado.Text := 'CONTRATADO';
          Lframe.recativo.Fill.Color := $FF069999;
        end
        else
        begin
          Lframe.lblContratado.Text := 'VER MAIS';
          Lframe.recativo.Fill.Color := $FF069999;
        end;
        Lframe.svgIcon.svg.source := TIconSvg.IconSeguro(inttostr(Ljson.GetValue<integer>('id')));
        Lframe.svgIcon.Svg.OverrideColor := $FF000000;
        Lframe.HitTest := true;
        Lframe.TagString := Ljson.ToString;
        Lframe.Tag := Ljson.GetValue<integer>('id');
{$IFDEF MSWINDOWS}
        Lframe.OnClick := ItemSeguroClick;
{$ELSE}
        Lframe.Ontap := ItemSeguroClick;
{$ENDIF}
      end;
    end;
    if AaTivos then
    begin
      if AJsonSeguro.Count = 0 then
        for i := 0 to 1 do
        begin
          LnameItem := TListBoxItem.classname+i.tostring;
          LItemBox := TListBoxItem.Create(self);
          LItemBox.Name := LnameItem;
          LItemBox.Height := 220;
          LItemBox.Parent := Result.ListBox2;
          LItemBox.Visible := true;
          LItemBox.Text := '';
          LItemBox.HitTest := false;
          LItemBox.IsChecked := false;
          LItemBox.IsSelected := false
        end
      else
      begin
        LnameItem := TListBoxItem.classname+i.tostring;
        LItemBox := TListBoxItem.Create(self);
        LItemBox.Name := LnameItem;
        LItemBox.Height := 220;
        LItemBox.Parent := Result.ListBox2;
        LItemBox.Visible := true;
        LItemBox.Text := '';
        LItemBox.HitTest := false;
        LItemBox.IsSelected := false;
      end;
      LFrame:= TframeSeguros.Create(self);
      LFrame.Align := TAlignLayout.Client;
      LFrame.Parent := LItemBox;
      LFrame.Rectangle1.Visible := true;
      LFrame.Rectangle2.Visible := false;
      LFrame.Name := Lframe.ClassName+ '999';
      Lframe.HitTest := true;
      Lframe.Tag := 999;
{$IFDEF MSWINDOWS}
      Lframe.OnClick := ItemSeguroClick;
{$ELSE}
      Lframe.Ontap := ItemSeguroClick;
{$ENDIF}
    end;
    result.HitTest := false;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    Result.Position.Y := ContentHeight;
    (FScrlList as IScrollBoxLocal).IsGradientTransparency := false;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
// LISTA EXTRATO DA FATURA
function TFrameListModel.AddItem(AClass: TComponentClass; AJsonExtrato: TJSONObject;Acor: Cardinal;AMes,AVencimento,AValor:string): TFrameItemListModel;
var
  LName,LnameItem,LParcela: string;
  LCount,LCountC, i: Integer;
  Ljson: TJSONValue;
  Lframe :TframeExtrato;
  LListaExtrato: TJSONArray;
begin
  LListaExtrato:=  AJsonExtrato.GetValue<TJSONArray>('transactions');
  dmfatura.memExtratoDetalhado.Close;
  for LJson in LListaExtrato do
  begin
    dmfatura.memExtratoDetalhado.Open;
    dmfatura.memExtratoDetalhado.append;
    dmfatura.memExtratoDetalhadoDATA.AsDateTime := LJson.GetValue<TDateTime>('transactionDateTime');
    dmfatura.memExtratoDetalhadoDATA_COMPRA.AsString := FormatDateTime('dd/mm/yy', LJson.GetValue<TDateTime>('transactionDateTime'));
    if LJson.GetValue<Integer>('eventTypeId')= 4 then
    begin
      dmfatura.memExtratoDetalhadoDESCRICAO.AsString:= 'Pagamento de Fatura';//LJson.GetValue<String>('descriptionAbbreviated');
      dmfatura.memExtratoDetalhadoVALOR.AsString:= FormatFloat('- R$ #,##0.00',LJson.GetValue<double>('real'));
      LParcela := '';
    end
    else
    begin
      if (LJson.GetValue<Integer>('eventTypeId') = 99) and (LJson.GetValue<String>('eventDescription')='0')
       and (LJson.GetValue<String>('complement') = '') then
        dmfatura.memExtratoDetalhadoDESCRICAO.AsString:= LJson.GetValue<String>('descriptionAbbreviated')
      else if (LJson.GetValue<Integer>('eventTypeId') = 6) and (UpperCase(LJson.GetValue<String>('eventDescription'))='TARIFAS')then
        dmfatura.memExtratoDetalhadoDESCRICAO.AsString:= LJson.GetValue<String>('descriptionAbbreviated')
      else
        dmfatura.memExtratoDetalhadoDESCRICAO.AsString:= LJson.GetValue<String>('establishmentName');
      dmfatura.memExtratoDetalhadoVALOR.AsString := FormatFloat('  R$ #,##0.00',LJson.GetValue<double>('real'));
      if LJson.GetValue<String>('complement') = '' then
        LParcela := '01/01'
      else
      begin
        LParcela := trim(copy(LJson.GetValue<String>('complement'),pos('Parc.',LJson.GetValue<String>('complement'))+5,length(LJson.GetValue<String>('complement'))));
        LParcela :=FormataParcela(LParcela);
      end;
    end;
    dmfatura.memExtratoDetalhadoPARCELAS.AsString := LParcela;
    dmfatura.memExtratoDetalhado.post;
  end;
  LName := TFrameItemListModel.ClassName+(Random(1000000) + 1).ToString;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    Result.Height:= (42 * LListaExtrato.Count);     
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := true;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.ListBox1.Visible := false;
    Result.ListBox2.Visible := false;
    Result.Rectangle5.Visible := false;
    result.HitTest := false;
    if LListaExtrato.Count > 0 then
      frmExtratoFatura.lblInfo.Visible := false
    else
    begin
      frmExtratoFatura.lblInfo.Visible := true;
      frmExtratoFatura.btnBoleto.Visible := false;
      frmExtratoFatura.btnPagar.Visible := false;
      exit;
    end;
    frmExtratoFatura.lblMesFatura.text := AMes;
    frmExtratoFatura.lblvencimento.text := AVencimento;
    frmExtratoFatura.lblValorTotal.text := AValor;
    dmfatura.memExtratoDetalhado.IndexFieldNames := 'DATA:D';
//    dmfatura.cdsExtrato.IndexName := 'cdsExtratoIndex3';
    dmfatura.memExtratoDetalhado.Open;
    dmfatura.memExtratoDetalhado.Refresh;
    dmfatura.memExtratoDetalhado.First;
    while not dmfatura.memExtratoDetalhado.Eof do
    begin
      LFrame:= TframeExtrato.Create(self);
      LFrame.Parent := Result.Rectangle4;
      LFrame.align := TalignLayout.Top;
      LFrame.Name := 'FrameExtrato' + LFrame.ClassName +Random(1000000).ToString+ FormatDateTime('ddmmyyyyhhmmsszzz', now);
      LFrame.lblData.text :=   dmfatura.memExtratoDetalhadoDATA_COMPRA.AsString;
      LFrame.lblLocal.Text:= dmfatura.memExtratoDetalhadoDESCRICAO.AsString;
      LFrame.lblValor.Text := dmfatura.memExtratoDetalhadoVALOR.AsString;
      LFrame.lblParcelas.Text := dmfatura.memExtratoDetalhadoPARCELAS.AsString;
      LFrame.Rectangle2.Fill.Color := ACor;
      LFrame.Rectangle3.Fill.Color := ACor;
      dmfatura.memExtratoDetalhado.Next;
    end;

    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    Result.Position.Y := ContentHeight;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
//CONTRATOS DE EMPRESTIMO PESSOAL
function TFrameListModel.AddItem(AClass: TComponentClass; AJsonContratosEmprestimo: TJSONObject): TFrameItemListModel;
var
  LName,LnameItem,LParcela: string;
  LCount,LCountC, i: Integer;
  Ljson: TJSONValue;
  Lframe :TframeContratoEP;
  LListaParcelas: TJSONArray;
begin
  LListaParcelas:=  AJsonContratosEmprestimo.GetValue<TJSONArray>('parcelas');
  LName := TFrameItemListModel.ClassName+(Random(1000000) + 1).ToString;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
//    Result.Height:= (42 * LListaExtrato.Count);
    Result.Height:= 42;
    Result.Width := frmEmprestimo.lylContratos.Width;
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := true;
    Result.Rectangle5.Visible := false;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.ListBox1.Visible := false;
    Result.ListBox2.Visible := false;
    result.HitTest := false;
    Result.Rectangle4.HitTest := false;
    LFrame:= TframeContratoEP.Create(self);
    LFrame.Parent := Result.Rectangle4;
    LFrame.align := TalignLayout.Top;
    LFrame.Name := 'FrameContratoEPAtivo' + LFrame.ClassName +Random(1000000).ToString+ FormatDateTime('ddmmyyyyhhmmsszzz', now);
    LFrame.lblIDContrato.text := AJsonContratosEmprestimo.GetValue<string>('numero');
    LFrame.lblData.Text:= FormatDateTime('dd/mm/yy', AJsonContratosEmprestimo.GetValue<TDateTime>('dataBase'));
    LFrame.lblValor.Text := FormatFloat('R$ #,##0.00', AJsonContratosEmprestimo.GetValue<Double>('valorCredito'));
    LFrame.lblStatus.TextSettings.FontColor := TAlphaColors.White;
    if AJsonContratosEmprestimo.GetValue<string>('dataLiquidacao')='' then
    begin
      LFrame.Rectangle1.Fill.Color := $FFE400E4;
      Lframe.SkSvg15.Visible := True;
      LFrame.lblStatus.Text := 'ABERTO';
    end
    else
    begin
      LFrame.lblStatus.Text := 'LIQUIDADO';
      LFrame.Rectangle1.Fill.Color := $FF348CDD;
      Lframe.SkSvg15.Visible := false;
    end;
    LFrame.Rectangle2.Fill.Color := $FFF9E5F7;
    LFrame.Rectangle3.Fill.Color := $FFF9E5F7;
    LFrame.TagString := LListaParcelas.ToString;
    LFrame.HitTest := true;
{$IFDEF MSWINDOWS}
    Lframe.OnClick := ItemEmprestimoClick;
{$ELSE}
    Lframe.Ontap := ItemEmprestimoClick;
{$ENDIF}
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    FScrlList.ShowScrollBars := true;
    Result.Position.Y := ContentHeight;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
//PARCELAS DO EMPRESTIMO PESSOAL
function TFrameListModel.AddItem(AClass: TComponentClass;AnumeroOperacao, AdataLiquidaParcel: string;ANumeroParcela: integer;
  ADTVencimento: TDateTime;Ames,ASituacao: String; AValorMin,AValorTotal: double; ABoletoRegistrado: Boolean): TFrameItemListModel;
var
  LName: string;
  LCount,LCountC, i: Integer;
  Ljson: TJSONValue;
  LListBoxItem: TListBoxItem;
  Lframe :TframeCobertura;
  LJsonInfo: TJSONObject;
begin
  LName := FormatDateTime('yyyymmddhhnnsszzz', Now) + '_' + (Random(1000000) + 1).ToString;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    Result.Rectangle2.Visible := true;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := false;
    Result.Rectangle5.Visible := false;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    Result.lblmes.Text := AMes;
    Result.lblValor.Text := FormatFloat('R$ #,##0.00' , AValorTotal);
    Result.lblDataVencimento.Text := FormatDateTime('dd/mm/yyyy', ADTVencimento);
    if Asituacao = 'PAGO' then //(AValorMin <> 0) and (AdataLiquidaParcel <> '') then
    begin
      Result.lbltitulo.Text := 'Fatura Paga';
      Result.SkLabel2.Text := 'Pagamento Realizado';
      Result.lbldataPagamento.Text :=FormatDateTime('dd/mm', ADTVencimento);
      Result.Layout45.Visible := false;
      Result.SkSvg15.svg.overrideColor := $FF38C31B;
      Result.recMes.Fill.Color := $FF38C31B;
      Result.GosLine1.stroke.Color := $FF38C31B;
      Result.lbldataPagamento.TagString := 'Paga';
    end
    else
    begin
      if Asituacao = 'PENDENTE' then
      begin
        Result.lbltitulo.Text := 'Fatura Aberta';
        Result.SkLabel2.Text := 'Pagamento Mínimo';
        Result.lbldataPagamento.Text :=FormatFloat( 'R$ #,##0.00' , AValormin);
        Result.SkLabel41.text := 'Imprimir boleto';
//        if ADTVencimento < now then
//           Result.SkLabel41.text := 'Imprimir Boleto'
//          else
//           Result.SkLabel41.text := 'Antecipar Pagamento';
        Result.Layout45.Visible := true;
        Result.SkSvg15.svg.overrideColor := $FF069999;
        Result.recMes.Fill.Color := $FF069999;
        Result.GosLine1.stroke.Color := $FF069999;
        Result.lbldataPagamento.TagString := ASituacao;
      end
      else if  Asituacao = 'ATRASADO'  then
      begin
        Result.lbltitulo.Text := 'Fatura Fechada';
        Result.SkLabel2.Text := 'Pagamento Mínimo';
        Result.lbldataPagamento.Text :=FormatFloat( 'R$ #,##0.00' , AValormin);
        Result.SkLabel41.text := 'Imprimir Boleto';
        Result.Layout45.Visible := true;
        Result.SkSvg15.svg.overrideColor := $FFE400E4;
        Result.recMes.Fill.Color := $FFE400E4;
        Result.GosLine1.stroke.Color := $FFE400E4;
        Result.lbldataPagamento.TagString := ASituacao;
      end;

      LJsonInfo := TJSONObject.Create;
      LJsonInfo.AddPair('promotor','999999');
      LJsonInfo.AddPair('numeroOperacao',AnumeroOperacao);
      LJsonInfo.AddPair('numeroParcela',ANumeroParcela);
      Result.TagString := LJsonInfo.ToString;
      FreeAndNil(LJsonInfo);
      if ABoletoRegistrado then
      begin
        Result.Tag := 0;
        Result.Layout45.Visible := true;
      end
      else
      begin
        Result.Tag := 1;
        Result.Layout45.Visible := false;
      end;
{$IFDEF MSWINDOWS}
    Result.OnClick := ItemParcelaEmprestimoClick;
{$ELSE}
    Result.Ontap := ItemParcelaEmprestimoClick;
{$ENDIF}
    end;

    Result.HitTest := true;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    FScrlList.ShowScrollBars := false;
    Result.Position.Y := ContentHeight;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
//LISTA MENU
function TFrameListModel.AddItem(AClass: TComponentClass; AJsonMenu: TJSONArray ): TFrameItemListModel;
var
  LName,LnameItem: string;
  LCount: Integer;
  Lframe :TframeMenu;
  LItemBox: TListBoxItem;
  Ljson: TJSONValue;
begin
  LName := TFrameItemListModel.ClassName+(Random(1000000) + 1).ToString;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    Result.Margins.Top := -5;
    Result.Rectangle5.Visible := true;
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := false;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.ListBox1.Visible := false;
    Result.ListBox2.Visible := false;
    result.HitTest := false;
    Result.Rectangle5.HitTest := false;
    for Ljson in AJsonMenu do
    begin
      if Ljson.GetValue<Boolean>('habilitado') =true then
      begin
        LnameItem := TListBoxItem.classname+inttostr(Random(1000000) + 1);
        LItemBox := TListBoxItem.Create(self);
        LItemBox.Name := LnameItem;
        LItemBox.Height := 254;
        if Result.lbMenu.Items.Count < 3  then
           LItemBox.Parent := Result.lbMenu
        else
        begin
          if Result.lbMenu2.Items.Count < 3 then
            LItemBox.Parent := Result.lbMenu2
          else
            LItemBox.Parent := Result.lbMenu3;
        end;
        LItemBox.Visible := true;
        LItemBox.Text := '';
        LItemBox.HitTest := false;
        LItemBox.IsSelected := false;
        Lframe := TframeMenu.Create(self);
        LFrame.Align := TAlignLayout.Client;
        LFrame.Parent := LItemBox;
        Lframe.SVGSeguro.Svg.Source := TIconSvg.IconMenu(Ljson.GetValue<Integer>('id'));
        LFrame.lblTitulo.Text := Ljson.GetValue<String>('opcao');
        LFrame.Name := Lframe.ClassName+Ljson.GetValue<Integer>('id').ToString+FormatDateTime('yyyymmddhhss',now);
        Lframe.HitTest := true;
        Lframe.Tag := Ljson.GetValue<Integer>('id');
{$IFDEF MSWINDOWS}
        Lframe.OnClick := ItemMenuClick;
{$ELSE}
        Lframe.Ontap := ItemMenuClick;
{$ENDIF}
      end;
    end;
    if Result.lbMenu.Count > 0 then
    begin
      Result.lbMenu.Visible := true;
      Result.Height:= 254;
      Result.lbMenu.Columns := Result.lbMenu.Count;
      if Result.lbMenu.Columns = 2 then
      begin
        Result.lbMenu.Margins.Left := 129;
        Result.lbMenu.Margins.Right := 129;
      end
      else if Result.lbMenu.Columns = 1 then
      begin
        Result.lbMenu.Margins.Left := 251;
        Result.lbMenu.Margins.Right := 253;
      end
    end;
    if Result.lbMenu2.Count > 0 then
    begin
      Result.lbMenu2.Visible := true;
      Result.Height:= 512;
      Result.lbMenu2.Columns := Result.lbMenu2.Count;
      if Result.lbMenu2.Columns = 2 then
      begin
        Result.lbMenu2.Margins.Left := 129;
        Result.lbMenu2.Margins.Right := 129;
      end
      else if Result.lbMenu2.Columns = 1 then
      begin
        Result.lbMenu2.Margins.Left := 251;
        Result.lbMenu2.Margins.Right := 253;
      end
    end;
    if Result.lbMenu3.Count > 0 then
    begin
      Result.lbMenu3.Visible := true;
      Result.Height:= 762;
      FScrlList.ShowScrollBars := true;
    end;
    Result.Width;
    Result.lbMenu2.Width;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    Result.Position.Y := ContentHeight;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
//Extrato CashBack
function TFrameListModel.AddItem(AClass: TComponentClass; AJsonExtrato: TJSONArray;Acor: Cardinal ): TFrameItemListModel;
var
  LName,LnameItem: string;
  LCount: Integer;
  Lframe :TframeCashBack;
  LItemBox: TListBoxItem;
  Ljson: TJSONValue;
begin
  dmfatura.memExtratoCashBack.close;
  for LJson in AJsonExtrato do
  begin
    dmfatura.memExtratoCashBack.Open;
    dmfatura.memExtratoCashBack.append;
    dmfatura.memExtratoCashBackDEESCRICAO.AsString := LJson.GetValue<string>('storeSale','');
    dmfatura.memExtratoCashBackDATA.AsDatetime := LJson.GetValue<TDateTime>('operationDate');
    dmfatura.memExtratoCashBackVALOR.AsFloat := LJson.GetValue<double>('value');
    dmfatura.memExtratoCashBackMOVIMENTO.AsString := LJson.GetValue<string>('operation','');
    dmfatura.memExtratoCashBack.Post;
  end;
  LName := TFrameItemListModel.ClassName+(Random(1000000) + 1).ToString;
  if Assigned(FScrlList.Content) then
    LCount := FScrlList.Content.ChildrenCount;
  Result := (AClass.Create(Self) as TFrameItemListModel);
  try
    Result.Name := Result.ClassName + LCount.ToString + '_' + LName;
    Result.Align := ItemAlign;
    Result.Height:= (42 * AJsonExtrato.Count);
    Result.Margins.Top := -0;
    Result.Margins.left := -0;
    Result.Margins.Right := -10;
    Result.Margins.Bottom := 0;
    Result.Rectangle5.Visible := false;
    Result.Rectangle2.Visible := false;
    result.Rectangle1.Visible := false;
    result.Rectangle12.Visible:= false;
    result.Rectangle3.Visible := false;
    result.Rectangle4.Visible := true;
    Result.loading.Visible := false;
    Result.recloading.Visible := false;
    Result.ListBox1.Visible := false;
    Result.ListBox2.Visible := false;
    result.HitTest := false;
    Result.Rectangle5.HitTest := false;
    result.Rectangle4.Fill.Color := TColors.Black;
    {if AJsonExtrato.Count > 0 then
      frmClubeSTZ.lblInfo.Visible := false
    else
    begin
      frmClubeSTZ.lblInfo.Visible := true;
      exit;
    end;}
    dmfatura.memExtratoCashBack.IndexFieldNames := 'DATA:D';
    dmfatura.memExtratoCashBack.Open;
    dmfatura.memExtratoCashBack.Refresh;
    dmfatura.memExtratoCashBack.First;
    while not dmfatura.memExtratoCashBack.Eof do
    begin
      LFrame:= TframeCashBack.Create(self);
      LFrame.Parent := Result.Rectangle4;
      LFrame.align := TalignLayout.Top;
      LFrame.Margins.Top := 0;
      LFrame.Margins.left:= 0;
      LFrame.Margins.right := 0;
      LFrame.Margins.bottom := 0;
      LFrame.Name := 'FrameExtrato' + LFrame.ClassName +Random(1000000).ToString+ FormatDateTime('ddmmyyyyhhmmsszzz', now);
      LFrame.lblData.text :=  FormatDateTime('dd/mm/yy', dmfatura.memExtratoCashBackDATA.AsDateTime);
      LFrame.lblMovimento.Text:= dmfatura.memExtratoCashBackMOVIMENTO.AsString;
      LFrame.lblDescricao.Text := dmfatura.memExtratoCashBackDEESCRICAO.AsString;
      if dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor utilizado' then
      begin
        LFrame.lblValor.TextSettings.FontColor := $FF8ab5eb;
        LFrame.lblValor.Text := FormatFloat('R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);
      end
      else if (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor expirado') or (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor descontado') then
      begin
        LFrame.lblValor.TextSettings.FontColor := $FFe0656c;
        LFrame.lblValor.Text := FormatFloat('-R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);
      end
      else if dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Crédito recebido' then
      begin
        LFrame.lblValor.TextSettings.FontColor := $FF71cf5d;
        LFrame.lblValor.Text := FormatFloat('+R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);
      end
      else if (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Crédito a receber')  then
      begin
        LFrame.lblValor.TextSettings.FontColor := $FF66d053;
        LFrame.lblValor.Text := FormatFloat('+R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);
      end
      else if (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor a compensar') or (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor a compensar')   then
      begin
        LFrame.lblValor.TextSettings.FontColor := $FFe0656c;
        LFrame.lblValor.Text := FormatFloat('-R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);
      end
      else if (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor a expirar') or (dmfatura.memExtratoCashBackMOVIMENTO.AsString = 'Valor descontado') then
      begin
        LFrame.lblValor.TextSettings.FontColor := $FFeeab43;
        LFrame.lblValor.Text := FormatFloat('-R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);
      end
      else
        LFrame.lblValor.Text := FormatFloat(' R$ #,##0.00', dmfatura.memExtratoCashBackVALOR.AsFloat);

      LFrame.Rectangle2.Fill.Color := ACor;
      LFrame.Rectangle3.Fill.Color := ACor;
      dmfatura.memExtratoCashBack.Next;
    end;
    FObjList.Add(Result);
    FScrlList.Content.AddObject(Result);
    FScrlList.ShowScrollBars:= true;
    FScrlList.Margins.Right := -5;
    Result.Position.Y := ContentHeight;
    Result.SendToBack;
  except
        Result.Free;
        raise;
  end;
end;
procedure TFrameListModel.BeginUpdate;
begin
  inherited;
  FObjList.Clear;
  FScrlList.Visible := False;
  FScrlList.BeginUpdate;
  if Assigned(FScrlList.Content) then
    FScrlList.Content.BeginUpdate;
  lytEmptyResult.Visible := False;
end;
procedure TFrameListModel.ClearList;
begin
  try
    BeginUpdate;
    FObjList.Clear;
  finally
    EndUpdate;
  end;
end;
procedure TFrameListModel.ClearList(ATarget: TFmxObject;
AClickItem: TNotifyEvent);
begin
  FClickItem := AClickItem;
  FObjList.Clear;
  if Assigned(ATarget) then
    lytBackground.Parent := ATarget;
end;
procedure TFrameListModel.TapItem(Sender: TObject; const Point: TPointF);
begin
  ClickItem(Sender);
end;
{$IFDEF ComponentTipScrollBox}

{ TipHorzScrollBoxLocal }
function TipHorzScrollBoxLocal.GetIsGradientTransparency: Boolean;
begin
  Result := FIsGradientTransparency;
end;
function TipHorzScrollBoxLocal.MaxViewPort: Single;
begin
  Result := Self.Content.Width;
end;
procedure TipHorzScrollBoxLocal.PaintChildren;
begin
{$IFDEF SKIA}
  if (Canvas is TSkCanvasCustom) and (IsGradientTransparency) and (not FIsEndOfListing) then
  begin
    var
      LCanvas: ISkCanvas := TSkCanvasCustom(Canvas).Canvas;
    var
    LShader := TSkShader.MakeGradientLinear(PointF(0, 0), PointF(Width, 0), [TAlphaColors.Black, TAlphaColors.Null], [0.9, 0.97]);
    var
      LPaint: ISkPaint := TSkPaint.Create;
    LPaint.ImageFilter := TSkImageFilter.MakeBlend(TSkBlendMode.SrcIn, TSkImageFilter.MakeShader(LShader, False));
    LCanvas.SaveLayer(LPaint);
    try
      inherited;
    finally
      LCanvas.Restore;
    end;
  end
  else
{$ENDIF}
    inherited;
end;
procedure TipHorzScrollBoxLocal.SetIsGradientTransparency(const Value: Boolean);
begin
  FIsGradientTransparency := Value;
end;
procedure TipHorzScrollBoxLocal.ViewportPositionChange(
  const AOldViewportPosition, ANewViewportPosition: TPointF;
  const AContentSizeChanged: Boolean);
begin
  inherited;
  FViewPort := Abs(Self.ViewportPosition.X);
  var
  LClientHeight := FViewPort + Self.Width;
  FIsEndOfListing :=
    (MaxViewPort < (LClientHeight * 1.01)) // means reached the end of
end;
{ TipVertScrollBoxLocal }
constructor TipVertScrollBoxLocal.Create(AOwner: TComponent);
begin
  inherited;
  FViewPort := 0;
end;
function TipVertScrollBoxLocal.GetIsGradientTransparency: Boolean;
begin
  Result := FIsGradientTransparency;
end;
function TipVertScrollBoxLocal.MaxViewPort: Single;
begin
  Result := Self.Content.Height;
  //Result := TRectF(CalcContentBounds * LocalRect).Top - Height;
end;
procedure TipVertScrollBoxLocal.PaintChildren;
begin
{$IFDEF SKIA}
  if (Canvas is TSkCanvasCustom) and (IsGradientTransparency) and (not FIsEndOfListing) then
  begin
    var
      LCanvas: ISkCanvas := TSkCanvasCustom(Canvas).Canvas;
    var
    LShader := TSkShader.MakeGradientLinear(PointF(0, 0), PointF(0, Height), [TAlphaColors.Black, TAlphaColors.Null], [0.9, 0.97]);
    // LShader := TSkShader.MakeGradientLinear(PointF(0, 0), PointF(0, Height), [TAlphaColors.Black, InterpolateColor(TAlphaColors.Black, TAlphaColors.Null, 1)], [0.9, 0.97]);
    var
      LPaint: ISkPaint := TSkPaint.Create;
    LPaint.ImageFilter := TSkImageFilter.MakeBlend(TSkBlendMode.SrcIn, TSkImageFilter.MakeShader(LShader, False));
    LCanvas.SaveLayer(LPaint);
    try
      inherited;
    finally
      LCanvas.Restore;
    end;
  end
  else
{$ENDIF}
    inherited;
end;
procedure TipVertScrollBoxLocal.SetIsGradientTransparency(const Value: Boolean);
begin
  FIsGradientTransparency := Value;
end;
procedure TipVertScrollBoxLocal.ViewportPositionChange(
  const AOldViewportPosition, ANewViewportPosition: TPointF;
const AContentSizeChanged: Boolean);
begin
  inherited;
  FViewPort := Abs(Self.ViewportPosition.Y);
  var
  LClientHeight := FViewPort + Self.Height;
  FIsEndOfListing :=
    (MaxViewPort < (LClientHeight * 1.01)) // means reached the end of
end;
{$ENDIF}
{ TScrollBoxLocal }
function TScrollBoxLocal.GetIsGradientTransparency: Boolean;
begin
  Result := FIsGradientTransparency;
end;
procedure TScrollBoxLocal.PaintChildren;
begin
{$IFDEF SKIA}
  // here it must check if Vert or Horz scroll...
  if (Canvas is TSkCanvasCustom) and (IsGradientTransparency) then
  begin
    var
      LCanvas: ISkCanvas := TSkCanvasCustom(Canvas).Canvas;
    var
    LShader := TSkShader.MakeGradientLinear(PointF(0, 0), PointF(0, Height), [TAlphaColors.Black, TAlphaColors.Null], [0.9, 0.97]);
    var
      LPaint: ISkPaint := TSkPaint.Create;
    LPaint.ImageFilter := TSkImageFilter.MakeBlend(TSkBlendMode.SrcIn, TSkImageFilter.MakeShader(LShader, False));
    LCanvas.SaveLayer(LPaint);
    try
      inherited;
    finally
      LCanvas.Restore;
    end;
  end
  else
{$ENDIF}
    inherited;
end;
procedure TScrollBoxLocal.SetIsGradientTransparency(const Value: Boolean);
begin
  FIsGradientTransparency := Value;
end;
end.
