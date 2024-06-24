unit view.menu;

interface

{$DEFINE GERADOR_FORTES_REPORT}
{.$DEFINE GERADOR_FAST_REPORT}
uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,System.DateUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia,System.JSON,
  FMX.Layouts, FMX.Skia, FMX.Objects,  uFancyDialog, System.Net.URLClient,
  System.Generics.Collections, System.Net.HttpClientComponent, System.Net.HttpClient, IdHTTP,
  FMX.Effects, uGosBase, uGosStandard, ACBrUtil, ACBrBase, controller.log,
  FMX.Memo.Types, FMX.Controls.Presentation, ACBrBoletoConversao, Windows,
  FMX.ScrollBox, FMX.Memo, ACBrPosPrinter, ACBrBoleto, frame.menu
  {$IFDEF GERADOR_FORTES_REPORT},ACBrBoletoFCFortesFr, FMX.ListBox{$ENDIF}
  {$IFDEF GERADOR_FAST_REPORT},ACBrBoletoFCFR, frxClass{$ENDIF};

type
  TfrmMenu = class(TForm)
    ALRectangle1: TRectangle;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout2: TLayout;
    lblTitutlo: TSkLabel;
    lblSubtitulo: TSkLabel;
    Layout4: TLayout;
    btnSair: TGosButtonView;
    SkSvg3: TSkSvg;
    btnVoltar: TGosButtonView;
    SkSvg4: TSkSvg;
    Layout7: TLayout;
    SkLabel6: TSkLabel;
    Memo1: TMemo;
    skloading: TSkAnimatedImage;
    lbMenu: TListBox;
    ItemBoleto: TListBoxItem;
    ItemFatura: TListBoxItem;
    ItemExtrato: TListBoxItem;
    ItemLimite: TListBoxItem;
    ItemSeguro: TListBoxItem;
    ItemEmprestimo: TListBoxItem;
    recImprimirBoleto: TRectangle;
    SkSvg1: TSkSvg;
    SkLabel1: TSkLabel;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    recPagarFatura: TRectangle;
    SkSvg5: TSkSvg;
    SkLabel3: TSkLabel;
    Layout8: TLayout;
    SkSvg9: TSkSvg;
    recExtratoFatura: TRectangle;
    SkSvg2: TSkSvg;
    SkLabel2: TSkLabel;
    Layout9: TLayout;
    SkSvg10: TSkSvg;
    recEmprestimo: TRectangle;
    SkSvg7: TSkSvg;
    SkLabel5: TSkLabel;
    Layout10: TLayout;
    SkSvg11: TSkSvg;
    recLimite: TRectangle;
    SVGLimite: TSkSvg;
    SkLabel4: TSkLabel;
    Layout12: TLayout;
    SkSvg13: TSkSvg;
    recSeguro: TRectangle;
    SkSvg8: TSkSvg;
    SkLabel7: TSkLabel;
    Layout11: TLayout;
    SkSvg12: TSkSvg;
    lylLoading: TLayout;
    Layout13: TLayout;
    lblTituloLoading: TSkLabel;
    lblSubtituloLoading: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    recLoading: TRectangle;
    lbMenu2: TListBox;
    ACBrBoleto1: TACBrBoleto;
    procedure recImprimirBoletoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure recPagarFaturaClick(Sender: TObject);
    procedure recExtratoFaturaClick(Sender: TObject);
    procedure recLimiteClick(Sender: TObject);
    procedure recEmprestimoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure recSeguroClick(Sender: TObject);

  private
    FMSG       : TFancyDialog;
    FCabecalho : TStringList;
    FRodape   : TStringList;
    //FToken     : string;
    FCPF       : string;
    FNumCartao : string;
    FIDCartao  : string;
    FDeslogar  : Boolean;
    FListFrameMenu: TList<TframeMenu>;
    FFrmLstMenu: TFrameListModel;

  {$IFDEF GERADOR_FORTES_REPORT}FACBrBoletoFCRL   : TACBrBoletoFCFortes;{$ENDIF}
  {$IFDEF GERADOR_FAST_REPORT}FACBrBoletoFCFR   := TACBrBoletoFCFR;{$ENDIF}
    function ConsultaLimite(AIdAccount:string; out AjsonRetorno: TJSONObject) :Boolean;
    function CompletaString(texto, Caractere: string; Tamanho: Integer): string;
    function ConsultaClube(ACPF: String): TJSONObject;
    function ConsultaFatura(AIdAccount:string; out AJsonFatura: TJSONArray): Boolean;

    { Private declarations }
  public
    { Public declarations }
    FIDProduct : string;
    FACBrBoleto : TACBrBoleto;
    FjsonBoleto: TJSONObject;
    FIdAccount : string;
    FName: String;
    procedure Fatura(AIdAccount: String;AValorTotal: double; out LValorMinimo: Double);
    procedure carregaTela(AJson: TJSONObject);
    function GerarBoleto(AIdAccount: string; out AResult: TJSONObject): boolean;
    function MontaCupom: Boolean;
    procedure GerarTitulo(AJsonBoleto: TJSONObject; AValorMin: Double);
    {$IFDEF MSWINDOWS}
    procedure ItemMenuClick(Sender : TObject);
    {$ELSE}
    procedure ItemMenuClick(Sender: TObject; const Point: TPointF);
    {$ENDIF}
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.fmx}

uses uFormataCampos, view.CPF, view.SelecaoCartao,
  view.Principal, view.Limite,
  uConnection, uToken, Notificacao, view.PagarFatura, uAguarde, view.Emprestimo,
  view.ExtratoFatura, LogSQLite, controller.impressao, view.Seguros,
  model.fatura, uIconsSvg,
  IdeaL.Lib.View.Utils,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1, view.ClubeSTZ, uFunctions;

procedure TfrmMenu.carregaTela(AJson: TJSONObject);
var
  i: integer;
  LMenu : TJSONObject;
  LjaMenu : TJSONArray;

  LItem : TListBoxItem;
  LFil: TFrameItemListModel;
  LYPos: Single;
begin
  FIDCartao := Ajson.getValue<String>('IDCard');
  FIdAccount:= Ajson.getValue<String>('IDAccount');
  FCPF := Ajson.getValue<String>('CPF');
  FIDProduct := Ajson.getValue<String>('IDProduct');
  FName := Ajson.GetValue<String>('Nome');
  lblTitutlo.Text := 'Oi, '+ copy(Ajson.GetValue<String>('Nome'),1,pos(' ',Ajson.GetValue<String>('Nome'))-1)+'!';
  FNumCartao:= Ajson.getValue<String>('NumCard');


  LjaMenu := TJSONArray.Create;
  try
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',111);
    LMenu.AddPair('opcao', 'Imprimir Boleto');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuBoleto);
    LjaMenu.AddElement(LMenu);
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',112);
    LMenu.AddPair('opcao', 'Pagar Fatura');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuFatura );
    LjaMenu.AddElement(LMenu);
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',113);
    LMenu.AddPair('opcao', 'Extrato Fatura');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuExtrato);
    LjaMenu.AddElement(LMenu);
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',114);
    LMenu.AddPair('opcao', 'Limite');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuLimite);
    LjaMenu.AddElement(LMenu);
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',115);
    LMenu.AddPair('opcao', 'Seguros');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuSeguro);
    LjaMenu.AddElement(LMenu);
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',116);
    LMenu.AddPair('opcao', 'Empréstimo Pessoal');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuEmprestimo);
    LjaMenu.AddElement(LMenu);
    LMenu := TJSONObject.Create;
    LMenu.AddPair('id',117);
    LMenu.AddPair('opcao', 'Clube +STZ');
    LMenu.AddPair('habilitado', frmPrincipal.FMenuClubeSTZ);
    LjaMenu.AddElement(LMenu);

    TUtils.TextMessageColorOpacity := 'Black';
    if assigned(FFrmLstMenu) then
      FreeAndNil(FFrmLstMenu);

    FFrmLstMenu := TFrameListModel.Create(Self);
    FFrmLstMenu.BeginUpdate;
    FFrmLstMenu.Parent := Layout4;
    FFrmLstMenu.Align := TAlignLayout.Client;
    FFrmLstMenu.IsGradientTransparency := false;

    FFrmLstMenu.AddItem(TFilVert1,LjaMenu);

  finally
    FFrmLstMenu.EndUpdate;
  end;



end;


{$IFDEF MSWINDOWS}
procedure TfrmMenu.ItemMenuClick(Sender: TObject);
{$ELSE}
procedure TfrmMenu.ItemMenuClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
  LjsonFatura: TJSONArray;
  FjsonRetorno : TJSONObject;
begin
  if TframeMenu(sender).Tag = 111 then
  begin
    {$REGION 'Boleto'}
    recLoading.Visible := true;
    lylLoading.Visible := true;
    lblTituloLoading.Text := 'Imprimir Boleto';
    lblSubtituloLoading.Text := 'Aguarde enquanto o boleto é impresso...';
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        if FToken.IsEmpty  then
        begin
          if not ConsultaToken(FURL+'/v1/authentication', FToken) then
          begin
            TLoading.ToastMessage(frmMenu,'Erro ao Buscar Token' ,5,TAlignLayout.MostRight);
            exit;
          end;
        end;

        GerarBoleto(FIdAccount,FjsonBoleto);

        if not MontaCupom then
        begin
          TLoading.ToastMessage(frmMenu,'Erro ao Imprimir Boleto' ,4,TAlignLayout.MostRight);
          exit;
        end
        else
        begin
          TLoading.ToastMessage(frmMenu,'Boleto Impresso Com Sucesso' ,4,TAlignLayout.MostRight);
        end;
      finally
        TThread.Synchronize(nil,
        procedure
        begin
          recLoading.Visible := false;
          lylLoading.Visible := false;
        end)
      end;
    end).Start;


  {$ENDREGION}
  end
  else if TframeMenu(sender).Tag = 112 then
  begin
    {$REGION 'Pagar Fatura'}
    recLoading.Visible := true;
    lylLoading.Visible := true;
    lblTituloLoading.Text := 'Aguarde';
    lblSubtituloLoading.Text := 'Estamos consultando faturas!';
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmPagarFatura) then
            Application.CreateForm(TfrmPagarFatura, frmPagarFatura);
        end);

        log('Iniciou consulta fatura: '+datetimetostr(now));
        if FToken.IsEmpty  then
        begin
          if not ConsultaToken(FURL+'/v1/authentication', FToken) then
          begin
            TLoading.ToastMessage(frmMenu,'Erro ao buscar Token',5,TAlignLayout.MostRight);
            exit;
          end;
        end;

        if not ConsultaFatura(FIdAccount,LjsonFatura) then
         begin
          TLoading.ToastMessage(frmMenu,'Erro ao consultar faturas para esta conta]1',5,TAlignLayout.MostRight);
          exit;
        end;

        TThread.Synchronize(nil,
        procedure
        begin
          frmPagarFatura.Show;
        end);

        frmPagarFatura.carregaTela(LjsonFatura,FIdAccount, FIDProduct, FCPF);
        log('Finalizou lista fatura: '+datetimetostr(now));

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
  end
  else if TframeMenu(sender).Tag = 113 then
  begin
    {$REGION 'Extrato Fatura'}
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmExtratoFatura) then
            Application.CreateForm(TfrmExtratoFatura, frmExtratoFatura);
        end);

        TThread.Synchronize(nil,
        procedure
        begin
          frmExtratoFatura.actTabLoginSenha.Execute;
          frmExtratoFatura.Show;
        end);

        frmExtratoFatura.carregaTela(FIdAccount,FCPF,FIDCartao);
      finally
      end;
    end).Start;


  {$ENDREGION}
  end
  else if TframeMenu(sender).Tag = 114 then
  begin
    {$REGION 'Limite'}
    recLoading.Visible := true;
    lylLoading.Visible := true;
    lblTituloLoading.Text := 'Aguarde';
    lblSubtituloLoading.Text := 'Estamos consultando informação!';
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmLimite) then
            Application.CreateForm(TfrmLimite, frmLimite);
        end);

        if FToken.IsEmpty  then
        begin
          if not ConsultaToken(FURL+'/v1/authentication', FToken) then
          begin
            exit;
          end;
        end;

        if not ConsultaLimite(FIdAccount, FjsonRetorno) then
          exit;


        frmLimite.CarregaTela(FCPF, FjsonRetorno );

        TThread.Synchronize(nil,
        procedure
        begin
          frmLimite.Show;
        end);



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
  end
  else if TframeMenu(sender).Tag = 115 then
  begin
    {$REGION 'Seguros'}
    recLoading.Visible := true;
    lylLoading.Visible := true;
    lblTituloLoading.Text := 'Aguarde';
    lblSubtituloLoading.Text := 'Estamos processando as informações';
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmSeguros) then
            Application.CreateForm(TfrmSeguros, frmSeguros);
        end);
        if FToken.IsEmpty  then
        begin
          if not ConsultaToken(FURL+'/v1/authentication', FToken) then
          begin
            exit;
          end;
        end;

        TThread.Synchronize(nil,
        procedure
        begin
          frmSeguros.Show;
        end);

        frmSeguros.carregaTela(FCPF);
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
  end
  else if TframeMenu(sender).Tag = 116 then
  begin
    {$REGION 'Emprestimo Pessoal'}
    if ( not frmPrincipal.FSmEmprestimoSimular) and (not frmPrincipal.FSmEmprestimoExtrato) then
    begin
      TLoading.ToastMessage(frmMenu,'Opção Desativada, contatar ao administrador!',5,TAlignLayout.MostRight);
      exit;
    end;

    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmEmprestimo) then
            Application.CreateForm(TfrmEmprestimo, frmEmprestimo);
        end);

        frmEmprestimo.carregaTela(Fcpf);

        TThread.Synchronize(nil,
        procedure
        begin
          frmEmprestimo.Show;
        end);

      finally

      end;
    end).Start;

  {$ENDREGION}
  end
  else if TframeMenu(sender).Tag = 117 then
  begin
    {$REGION 'Clube +STZ'}
    recLoading.Visible := true;
    lylLoading.Visible := true;
    lblTituloLoading.Text := 'Cube +STZ';
    lblSubtituloLoading.Text := 'Aguarde, consultando informações...';
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
        procedure
        begin
          if not Assigned(frmClubeSTZ) then
            Application.CreateForm(TfrmClubeSTZ, frmClubeSTZ);
        end);

        frmClubeSTZ.CarregaTela(ConsultaClube(FCPF));

        TThread.Synchronize(nil,
        procedure
        begin
          frmClubeSTZ.Show;
        end);

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
end;

procedure TfrmMenu.recPagarFaturaClick(Sender: TObject);
var
  LjsonFatura: TJSONArray;
begin
  {$REGION 'Pagar Fatura'}
//  TLoading.Show(frmMenu,'Aguarde, Carregando faturas...');
//  skloading.Visible := true;
//  skloading.Animation.Start;
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Estamos consultando faturas!';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmPagarFatura) then
          Application.CreateForm(TfrmPagarFatura, frmPagarFatura);
      end);

      log('Iniciou consulta fatura: '+datetimetostr(now));
      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          TLoading.ToastMessage(frmMenu,'Erro ao buscar Token',5,TAlignLayout.MostRight);
          exit;
        end;
      end;

      if not ConsultaFatura(FIdAccount,LjsonFatura) then
       begin
        TLoading.ToastMessage(frmMenu,'Erro ao consultar faturas para esta conta]1',5,TAlignLayout.MostRight);
        exit;
      end;

      TThread.Synchronize(nil,
      procedure
      begin
        frmPagarFatura.Show;
      end);

      frmPagarFatura.carregaTela(LjsonFatura,FIdAccount, FIDProduct, FCPF);
      log('Finalizou lista fatura: '+datetimetostr(now));

    finally
      TThread.Synchronize(nil,
      procedure
      begin
//        TAguarde.Hide;
//        skloading.Animation.stop;
//        skloading.Visible := false;
        recLoading.Visible := false;
        lylLoading.Visible := false;
      end);
    end;
  end).Start;
  {$ENDREGION}
end;

procedure TfrmMenu.recSeguroClick(Sender: TObject);
begin
  {$REGION 'Seguros'}

//  TLoading.ToastMessage(frmMenu,'Em fase de desenvolvimento',5,TAlignLayout.MostRight);
//  skloading.Visible := true;
//  skloading.Animation.start;
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Estamos processando as informações';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmSeguros) then
          Application.CreateForm(TfrmSeguros, frmSeguros);
      end);
      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          exit;
        end;
      end;

      TThread.Synchronize(nil,
      procedure
      begin
        frmSeguros.Show;
      end);

      frmSeguros.carregaTela(FCPF);
    finally
      TThread.Synchronize(nil,
      procedure
      begin
//        skloading.Animation.stop;
//        skloading.Visible := false;
        recLoading.Visible := false;
        lylLoading.Visible := false;
      end);
    end;
  end).Start;
  {$ENDREGION}
end;

procedure TfrmMenu.recEmprestimoClick(Sender: TObject);
begin
  {$REGION 'Emprestimo Pessoal'}
  if ( not frmPrincipal.FSmEmprestimoSimular) and (not frmPrincipal.FSmEmprestimoExtrato) then
  begin
    TLoading.ToastMessage(frmMenu,'Opção Desativada, contatar ao administrador!',5,TAlignLayout.MostRight);
    exit;
  end;

 TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmEmprestimo) then
          Application.CreateForm(TfrmEmprestimo, frmEmprestimo);
      end);

      frmEmprestimo.carregaTela(Fcpf);

      TThread.Synchronize(nil,
      procedure
      begin
        frmEmprestimo.Show;
      end);

    finally

    end;
  end).Start;

  {$ENDREGION}
end;

procedure TfrmMenu.recExtratoFaturaClick(Sender: TObject);
begin
  {$REGION 'Extrato Fatura'}
//  TLoading.Show(frmMenu,'Aguarde..');
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmExtratoFatura) then
          Application.CreateForm(TfrmExtratoFatura, frmExtratoFatura);
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        frmExtratoFatura.actTabLoginSenha.Execute;
        frmExtratoFatura.Show;
      end);

      frmExtratoFatura.carregaTela(FIdAccount,FCPF,FIDCartao);
    finally
//      TThread.Synchronize(nil,
//      procedure
//      begin
//        TLoading.Hide;
//      end);
    end;
  end).Start;


  {$ENDREGION}
end;

procedure TfrmMenu.recImprimirBoletoClick(Sender: TObject);
begin
  {$REGION 'Boleto'}
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Imprimir Boleto';
  lblSubtituloLoading.Text := 'Aguarde enquanto o boleto é impresso...';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          TLoading.ToastMessage(frmMenu,'Erro ao Buscar Token' ,5,TAlignLayout.MostRight);
          exit;
        end;
      end;

      GerarBoleto(FIdAccount,FjsonBoleto);

      if not MontaCupom then
      begin
        TLoading.ToastMessage(frmMenu,'Erro ao Imprimir Boleto' ,4,TAlignLayout.MostRight);
        exit;
      end
      else
      begin
        TLoading.ToastMessage(frmMenu,'Boleto Impresso com Sucesso' ,4,TAlignLayout.MostRight);
      end;
    finally
      TThread.Synchronize(nil,
      procedure
      begin
        recLoading.Visible := false;
        lylLoading.Visible := false;
      end)
    end;
  end).Start;


  {$ENDREGION}
end;

procedure TfrmMenu.recLimiteClick(Sender: TObject);
var
  FjsonRetorno : TJSONObject;
begin
  {$REGION 'Limite'}
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Estamos consultando informação!';
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmLimite) then
          Application.CreateForm(TfrmLimite, frmLimite);
      end);

      if FToken.IsEmpty  then
      begin
        if not ConsultaToken(FURL+'/v1/authentication', FToken) then
        begin
          exit;
        end;
      end;

      if not ConsultaLimite(FIdAccount, FjsonRetorno) then
        exit;

      TThread.Synchronize(nil,
      procedure
      begin
        frmLimite.Show;
      end);

      frmLimite.CarregaTela(FCPF, FjsonRetorno );

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

procedure TfrmMenu.btnSairClick(Sender: TObject);
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
        end);

        TThread.Synchronize(nil,
        procedure
        begin
          frmPrincipal.Show;
        end);

      finally
        TThread.Synchronize(nil,
        procedure
        begin
          frmSelecaoCartao.close;
          frmMenu.Close;
        end);
      end;
    end).Start;
  end,'NÃO',
  procedure
  begin
  end);
end;
procedure TfrmMenu.btnVoltarClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmSelecaoCartao) then
          Application.CreateForm(TfrmSelecaoCartao, frmSelecaoCartao);
      end);

      TThread.Synchronize(nil,
      procedure
      begin
        frmSelecaoCartao.Show;
      end);

    finally
      TThread.Synchronize(nil,
      procedure
      begin
        frmMenu.close;
      end);
    end;
  end).Start;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmMenu := nil;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  FMsg := TFancyDialog.Create(self);
  FListFrameMenu := TList<TframeMenu>.create;
  FDeslogar := false;
  FACBrBoleto := TACBrBoleto.Create(Self);

  {$IFDEF GERADOR_FORTES_REPORT}
    FACBrBoletoFCRL   := TACBrBoletoFCFortes.Create(FACBrBoleto);
  {$ENDIF}

  {$IFDEF GERADOR_FAST_REPORT}
    FACBrBoletoFCFR   := TACBrBoletoFCFR.Create(FACBrBoleto);
  {$ENDIF}

  SkLabel6.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
end;

procedure TfrmMenu.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMSG);
  FreeAndNil(FACBrBoletoFCRL);
//  FreeAndNil(FACBrBoletoFCFR);
  FreeAndNil(FACBrBoleto);
  FreeAndNil(FListFrameMenu);
end;



function TfrmMenu.ConsultaLimite(AIdAccount:string; out AjsonRetorno: TJSONObject): Boolean;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try

    if LConnection.Get(FURL+'/v2/account/'+AIdAccount+'/limits/details',[], LResult, FToken) then
    begin
      result := true;
      AjsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
    end
    else
    begin
      result := false;
      log('Erro ao consultar limite '+LResult);
    end;

  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmMenu.GerarBoleto(AIdAccount:string;Out AResult:TJSONObject): boolean;
var
  LConnection  : TConnection;
  LResult      : string;
  Ljson        : TJSONValue;
  LJsonExtrato : TJSONObject;
begin
  LConnection:= TConnection.Create;
  try

    if LConnection.Get(FURL+'/v1/account/'+AIdAccount+'/invoice-data',[], LResult, FToken) then
    begin
      AResult := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
       if AResult.GetValue<string>('numeroDoDocumento','') = '' then
         result := false
      else
         result := true;
    end
    else
    begin
      Result := false;
      log('Erro: '+LResult)
    end;

  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmMenu.ConsultaFatura(AIdAccount:string; out AJsonFatura: TJSONArray): Boolean;
var
  LConnection: TConnection;
  LResult: string;
begin
  LConnection:= TConnection.Create;
  try
    try
      if LConnection.Get(FURL+'/v1/account/'+AIdAccount+'/invoices',[], LResult, FToken) then
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
        log('Erro: '+ ex.Message);
      end;

    end;

  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmMenu.ConsultaClube(ACPF: String): TJSONObject;
var
  Lconnection: TConnection;
  LResult: string;
  LArray: TJSONArray;
  LJson: TJSONValue;
begin
  LConnection:= TConnection.Create;
  try
    try
      if LConnection.Get(FURL+'/v5/clubez-composite/customer/'+Acpf,[], LResult, FToken) then
      begin
        result := TJSONObject.ParseJSONValue(LResult) as TJSONObject;
      end
      else
      begin
        LArray:= TJSONArray.ParseJSONValue(LResult) as TJSONArray;
        for LJson in LArray do
        begin
          result := LJson.GetValue<TJSONObject>;
        end;
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

procedure TfrmMenu.GerarTitulo(AJsonBoleto: TJSONObject; AValorMin: Double);
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

  FACBrBoleto.Cedente.Nome := AJsonBoleto.GetValue<string>('nomeBeneficiario');
  FACBrBoleto.Cedente.CNPJCPF := AJsonBoleto.GetValue<string>('documentoBeneficiario');
  FACBrBoleto.Cedente.CodigoCedente := AJsonBoleto.GetValue<string>('codigoBeneficiario');
  FACBrBoleto.Cedente.Agencia := AJsonBoleto.GetValue<string>('agencia');
  FACBrBoleto.Cedente.AgenciaDigito := AJsonBoleto.GetValue<string>('digitoCodigoBeneficiario');
  FACBrBoleto.Cedente.Conta := AJsonBoleto.GetValue<string>('numeroConvenio');
  FACBrBoleto.Cedente.ContaDigito := AJsonBoleto.GetValue<string>('digitoCodigoBeneficiario');
  FACBrBoleto.Cedente.Convenio := AJsonBoleto.GetValue<string>('numeroConvenio');
  case strtoint(copy(AJsonBoleto.GetValue<string>('banco'),1,3)) of
     33,353,8 :FACBrBoleto.Banco.TipoCobranca := cobSantander;
     237      :FACBrBoleto.Banco.TipoCobranca := cobBradesco;
     001      :FACBrBoleto.Banco.TipoCobranca :=  cobBancoDoBrasil;
//     cobBancoDoBrasilAPI     : fBancoClass := TACBrBancoBrasil.create(Self);         {001}
//     cobBancoDoBrasilWS      : fBancoClass := TACBrBancoBrasil.create(Self);         {001}
//     cobBancoDoBrasilSICOOB  : fBancoClass := TACBrBancoBrasilSICOOB.Create(Self);   {001}
     003  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoDaAmazonia ;
     004  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoDoNordeste ;
     021  :FACBrBoleto.Banco.TipoCobranca :=  cobBanestes        ;
     041  :FACBrBoleto.Banco.TipoCobranca :=  cobBanrisul        ;
     070  :FACBrBoleto.Banco.TipoCobranca :=  cobBRB             ;
     091  :FACBrBoleto.Banco.TipoCobranca :=  cobUnicredRS       ;
     085  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoCECRED     ;
     097  :FACBrBoleto.Banco.TipoCobranca :=   cobCrediSIS       ;
     099  :FACBrBoleto.Banco.TipoCobranca :=  cobUniprime        ;
     104  :FACBrBoleto.Banco.TipoCobranca :=  cobCaixaEconomica  ;
  //     cobCaixaSicob           : fBancoClass := TACBrCaixaEconomicaSICOB.create(Self); {104}
     136  :FACBrBoleto.Banco.TipoCobranca :=  cobUnicredES       ;
     341  :FACBrBoleto.Banco.TipoCobranca :=  cobItau            ;
     389  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoMercantil  ;
     748  :FACBrBoleto.Banco.TipoCobranca :=  cobSicred          ;
     756  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoob         ;
     399  :FACBrBoleto.Banco.TipoCobranca :=  cobHSBC            ;
  //     cobBicBanco             : fBancoClass := TACBrBancoBic.create(Self);            {237}
  //     cobBradescoSICOOB       : fBancoClass := TAcbrBancoBradescoSICOOB.create(Self); {237}
     422  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoSafra      ;
  //     cobSafraBradesco        : fBancoClass := TACBrBancoSafraBradesco.Create(Self);  {422 + 237}
     047  :FACBrBoleto.Banco.TipoCobranca :=  cobBanese          ;
  //     cobBancoCresolSCRS      : fBancoClass := TACBrBancoCresolSCRS.create(Self);     {133 + 237}
     745  :FACBrBoleto.Banco.TipoCobranca :=  cobCitiBank        ;
     246  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoABCBrasil  ;
     084  :FACBrBoleto.Banco.TipoCobranca :=  cobUniprimeNortePR ;
  //     cobBancoPine            : fBancoClass := TACBrBancoPine.create(Self);
     643  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoPineBradesco;
     025  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoAlfa        ;
     133  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoCresol      ;
     274  :FACBrBoleto.Banco.TipoCobranca :=  cobMoneyPlus        ;
     336  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoC6          ;
     633  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoRendimento  ;
     077  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoInter       ;
     637  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoSofisaSantander ;
     218  :FACBrBoleto.Banco.TipoCobranca :=  cobBS2              ;
  //     cobPenseBankAPI          : fBancoClass := TACBrBancoPenseBank.Create(Self);
     208  :FACBrBoleto.Banco.TipoCobranca :=  cobBTGPactual          ;
     212  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoOriginal       ;
     655  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoVotorantim     ;
     174  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoPefisa         ;
     224  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoFibra          ;
  //   637  cobBancoSofisaItau      : fBancoClass := TACBrBancoSofisaItau.Create(Self);      {637}
     604  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoIndustrialBrasil;
     329  :FACBrBoleto.Banco.TipoCobranca :=  cobBancoQITechSCD       ;
  end;
  FACBrBoleto.Banco.CodigodeBarras:= AJsonBoleto.GetValue<string>('codigoDeBarras');
  FACBrBoleto.Banco.Linhadigitavel:= AJsonBoleto.GetValue<string>('linhaDigitavel');


  LTitulo := FACBrBoleto.CriarTituloNaLista;

  LTitulo.Vencimento        := IncMilliSecond(UnixDateDelta,AJsonBoleto.GetValue<Int64>('dataVencimento'));
  LTitulo.DataDocumento     := IncMilliSecond(UnixDateDelta,AJsonBoleto.GetValue<Int64>('dataDocumento'));
  LTitulo.NumeroDocumento   := AJsonBoleto.GetValue<string>('numeroDoDocumento');
  LTitulo.EspecieDoc        := AJsonBoleto.GetValue<string>('especieDoDocumento');
//  LTitulo.Aceite := atNao;
  LTitulo.DataProcessamento := IncMilliSecond(UnixDateDelta,AJsonBoleto.GetValue<Int64>('dataProcessamento'));
  LTitulo.Carteira          := AJsonBoleto.GetValue<string>('carteira');
  LTitulo.NossoNumero       := AJsonBoleto.GetValue<string>('nossoNumero');
  LTitulo.ValorDocumento    := AJsonBoleto.GetValue<double>('valorBoleto');
  LTitulo.Sacado.NomeSacado := AJsonBoleto.GetValue<string>('nomePagador');
  LTitulo.Sacado.CNPJCPF    := AJsonBoleto.GetValue<string>('documentoPagador');
  LTitulo.Sacado.Logradouro := AJsonBoleto.GetValue<string>('logradouroPagador');
//  LTitulo.Sacado.Numero     := copy(AJsonBoleto.GetValue<string>('logradouroPagador'),Pos(', ',AJsonBoleto.GetValue<string>('logradouroPagador'))+2,length(AJsonBoleto.GetValue<string>('logradouroPagador')));
  LTitulo.Sacado.Bairro     := AJsonBoleto.GetValue<string>('bairroPagador');
  LTitulo.Sacado.Cidade     := AJsonBoleto.GetValue<string>('cidadePagador');
  LTitulo.Sacado.UF         := AJsonBoleto.GetValue<string>('ufPagador');
  LTitulo.Sacado.CEP        := AJsonBoleto.GetValue<string>('cepPagador');
  LTitulo.ValorAbatimento   := AJsonBoleto.GetValue<double>('valorBoleto');
//  LTitulo.QrCode.emv := '';

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
      LTitulo.Mensagem.Text      := trim(LJson.value);
      break;
    end;

  LTitulo.QtdePagamentoParcial   := 1;
  LTitulo.TipoPagamento          := tpNao_Aceita_Valor_Divergente;
  LTitulo.PercentualMinPagamento := 0;
  LTitulo.PercentualMaxPagamento := 0;
  LTitulo.ValorMinPagamento      := AValorMin;
  LTitulo.ValorMaxPagamento      := 0;
  LTitulo.Verso := false;


  for LIndex := 0 to Pred(FACBrBoleto.ListadeBoletos.Count) do
  begin
    FACBrBoleto.ACBrBoletoFC.CalcularNomeArquivoPDFIndividual := True;
    FACBrBoletoFCRL.PdfSenha := IntToStr(LIndex+1);
    FACBrBoleto.ACBrBoletoFC.GerarPDF(LIndex);
  end;
end;

function TfrmMenu.CompletaString(texto, Caractere: string; Tamanho: Integer): string;
begin
//  Result := Copy(texto, 1, Tamanho) + Repl(Caractere, (Tamanho - Length(texto)));
end;

function TfrmMenu.MontaCupom: Boolean;
var
  LImprimir: TImprimir;
  LImprimirRodape: TImprimir;
  LValorMinimo: double;
begin
  LValorMinimo:=0 ;

  Fatura(FIdAccount,FjsonBoleto.GetValue<double>('valorBoleto'), LValorMinimo);

  GerarTitulo(FjsonBoleto,LValorMinimo);

  if FACBrBoleto.ListadeBoletos.Count = 0 then
  begin
    Result:= false;
    exit;
  end;

  if frmPrincipal.FPortaImpressora = 'Nenhuma Impressora Detectada' then
  begin
    log('Impressora padrão não definida');
    exit;
  end;

  FCabecalho := TStringList.Create;
  FRodape := TStringList.Create;
  LImprimir := TImprimir.Create;
  LImprimirRodape := TImprimir.Create;
  try
    try
      log('populando componente');

      FCabecalho.Add('</zera>');
      FCabecalho.Add('</ce><e><n>'+'Cartao Calcard VISA'+'</n></e>');
      FCabecalho.Add('Fatura para pagamento');
      FCabecalho.Add('</zera>');
      FCabecalho.Add(now.ToString);
      FCabecalho.Add(' ');
      FCabecalho.Add('</ae>Titular     : '+FjsonBoleto.GetValue<string>('nomePagador'));
      FCabecalho.Add('Cartao      : '+FNumCartao);
      FCabecalho.Add('Vencimento  : '+IncMilliSecond(UnixDateDelta,FjsonBoleto.GetValue<Int64>('dataVencimento')).ToString);
      FCabecalho.Add(' ');
      FCabecalho.Add('</zera>Valor total para pagamento  :  '+'</ad>R$'+FormatFloatBr(msk9x2,FjsonBoleto.GetValue<double>('valorBoleto')));
      FCabecalho.Add('</zera>Valor minimo para pagamento :  '+'</ad>R$'+FormatFloatBr(msk9x2,LValorMinimo));
      FCabecalho.Add('</zera></linha_simples>');

      log('mandando imprimir');
      LImprimir.Imprimir(FCabecalho);
      log('Imprimiu Cabeçalho');
      FACBrBoleto.Imprimir;

      log('Imprimiu Boleto');
      result:= true;

      DeletaBoletoSalvo(GetCurrentDir);
    except on ex: exception do
      begin
        result := false;
        log('Erro: '+ ex.Message);
      end;

    end;
  finally
    FreeAndNil(FCabecalho);
    FreeAndNil(FRodape);
    FreeAndNil(LImprimir);
    FreeAndNil(LImprimirRodape);
  end;
end;


procedure TfrmMenu.Fatura(AIdAccount: String; AValorTotal: double; out LValorMinimo: Double);
var
 LJsonFatura: TJSONArray;
 LJoFatura: TJSONValue;
 LDataVencimento: string;
 LJsonExtrato : TJSONObject;
begin
  ConsultaFatura(AIdAccount, LJsonFatura);

  dmfatura.memFatura.Close;
   for LJoFatura in LJsonFatura do
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

  dmfatura.memFatura.IndexFieldNames := 'DATAVENCIMENTOFATURA';
  dmfatura.memFatura.Open;
  dmfatura.memFatura.Refresh;
  dmfatura.memFatura.First;
  while not dmfatura.memFatura.Eof do
  begin
    if dmfatura.memFaturaVALORTOTAL.AsFloat = AValorTotal then
    begin
      LValorMinimo := dmfatura.memFaturaVALORPAGAMENTOMINIMO.AsFloat;
      break;
    end;
    dmfatura.memFatura.Next;
  end;

end;



end.
