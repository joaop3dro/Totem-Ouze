unit view.SelecaoCartao;

interface

uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils,System.StrUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.NetEncoding,System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, frame.cartao, FMX.Skia, System.JSON, DBXJSON,
  FMX.Layouts, FMX.Objects, uFancyDialog, FMX.Effects, uGosBase, uGosStandard,
  System.Skia, controller.tempo;

type
  TfrmSelecaoCartao = class(TForm)
    ALRectangle1: TRectangle;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    HorzScrollBox1: THorzScrollBox;
    btnSair: TGosButtonView;
    SkSvg2: TSkSvg;
    ShadowEffect14: TShadowEffect;
    btnVoltar: TGosButtonView;
    ShadowEffect13: TShadowEffect;
    SkSvg1: TSkSvg;
    Layout5: TLayout;
    SkLabel5: TSkLabel;
    lylScroll: TLayout;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure lylScrollPainting(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
  private
    { Private declarations }
    FJsonCartoes: TJSONArray;
    FListaFrame: TList<TframeCartao>;
    FFrmLstVert: TFrameListModel;
    FFrmLstHorz2: TFrameListModel;
    FTempo : TTempo;
{$IFDEF MSWINDOWS}
    procedure ItemClick(Sender: TObject);
{$ELSE}
    procedure ItemClick(Sender: TObject; const Point: TPointF);
{$ENDIF}
  public
    { Public declarations }
    FMSG: TFancyDialog;
    procedure ListaCartoes(AJsonRetorno: TJSONArray);
  end;

var
  frmSelecaoCartao: TfrmSelecaoCartao;


implementation
{$R *.fmx}

uses view.Principal, view.CPF, view.menu, uCamelCase, {LogSQLite,} uFormataCampos,
     IdeaL.Lib.View.Utils,
     IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
     IdeaL.Demo.ScrollBox.FrameItemList.Vert1, controller.log;

procedure TfrmSelecaoCartao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmSelecaoCartao := nil;
end;

procedure TfrmSelecaoCartao.FormCreate(Sender: TObject);
begin
  FListaFrame := TList<TframeCartao>.create;
  FMsg := TFancyDialog.Create(self);
  SkLabel5.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
  FTempo := TTempo.Create;
end;

procedure TfrmSelecaoCartao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListaFrame);
  FreeAndNil(FMSG);
  FreeAndNil(FTempo);
end;

procedure TfrmSelecaoCartao.btnVoltarClick(Sender: TObject);
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
          if not Assigned(frmCPF) then
            Application.CreateForm(TfrmCPF, frmCPF);
          frmCPF.Show;
        end);
      finally
        TThread.Synchronize(nil,
        procedure
        begin
          frmSelecaoCartao.close;
        end);
      end;
    end).Start;
  end,
  'NÃO');
end;

procedure TfrmSelecaoCartao.btnSairClick(Sender: TObject);
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
          frmSelecaoCartao.close;
        end);
      end;
    end).Start;
  end,'NÃO');

end;

procedure TfrmSelecaoCartao.ListaCartoes(AJsonRetorno: TJSONArray);
var
  LFil: TFrameItemListModel;
  LYPos: Single;
  LmesVenc: integer;
  Lmes: string;
  LCard: String;

  LJsonObjAccount,
  LjoPerson,
  LjoHolderPerson: TJSONObject;

  LJsonCard : TJSONValue;
  LIDCard: string;
  LJsonInfo: TJSONObject;
begin

 {$REGION 'CARTOES'}
  TUtils.TextMessageColorOpacity := 'Black';
  if assigned(FFrmLstVert) then
  begin
    log('Liberando FFrmLstVert da memoria');
    FreeAndNil(FFrmLstVert);
  end;

  if assigned(FFrmLstHorz2) then
  begin
    log('Liberando FFrmLstHorz2 da memoria');
    FreeAndNil(FFrmLstHorz2);
  end;

  try
    log('Configuerando o scroll de lista de cartões');
    FFrmLstVert := TFrameListModel.Create(Self);
    FFrmLstVert.BeginUpdate;
    FFrmLstVert.Parent := lylScroll;
    if AJsonRetorno.Count = 1 then
    begin
      FFrmLstVert.Align := TAlignLayout.center;
      FFrmLstVert.Width := 490;
    end
    else
      FFrmLstVert.Align := TAlignLayout.Client;
    FFrmLstVert.IsGradientTransparency := False;
    FFrmLstHorz2 := TFrameListModel.Create(Self);
    FFrmLstHorz2.Align := TAlignLayout.Client;
    FFrmLstHorz2.Height := 212;

    FFrmLstHorz2.Margins.Right := 10;
    FFrmLstHorz2.IsGradientTransparency := false;
    TFrameListModel(FFrmLstHorz2).ItemAlign := TAlignLayout.Left;
    LYPos := FFrmLstVert.ContentHeight;
    FFrmLstVert.VtsList.AddObject(FFrmLstHorz2);
    FFrmLstHorz2.Position.Y := LYPos;


    Log('Iniciando Montagem dos frames');

    for LJsonCard in AJsonRetorno do
    begin
      LIDCard := LJsonCard.GetValue<String>('id');
      LJsonObjAccount := LJsonCard.GetValue<TJSONObject>('account');
      LjoPerson := LJsonObjAccount.GetValue<TJSONObject>('person');
      LjoHolderPerson := LJsonObjAccount.GetValue<TJSONObject>('product');

      if LjoHolderPerson.GetValue<string>('id') = '157' then
       LCard:= 'VISA'
      else
       LCard:= 'STZ';

      LJsonInfo := TJSONObject.Create;
      LJsonInfo.AddPair('IDAccount', LJsonObjAccount.GetValue<String>('id'));
      LJsonInfo.AddPair('IDCard', LJsonCard.GetValue<String>('id'));
      LJsonInfo.AddPair('IDProduct', LjoHolderPerson.GetValue<string>('id'));
      LJsonInfo.AddPair('CPF', LjoPerson.GetValue<string>('cpf'));
      LJsonInfo.AddPair('Status', LJsonCard.GetValue<string>('status'));
      LJsonInfo.AddPair('NumCard', LJsonCard.GetValue<string>('number', ''));
      LJsonInfo.AddPair('Nome', UpperCase(LjoPerson.GetValue<string>('name')));

      LFil := FFrmLstHorz2.AddItem(TFilHorz2,LjoHolderPerson.GetValue<string>('id'),
                                             LJsonInfo,
                                             LjoPerson.GetValue<string>('name'),
                                             LJsonCard.GetValue<string>('number', ''));

      FreeAndNil(LJsonInfo);
    end;
    log('Finalizando os frames');
  finally
    FFrmLstVert.EndUpdate;
    log('Finalizando a lista');
  end;
{$ENDREGION}
end;

procedure TfrmSelecaoCartao.lylScrollPainting(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);

begin
end;


{$IFDEF MSWINDOWS}
procedure TfrmSelecaoCartao.ItemClick(Sender: TObject);
{$ELSE}
procedure TfrmSelecaoCartao.ItemClick(Sender: TObject;
  const Point: TPointF);
{$ENDIF}
var
 LJsonInfo : TJSONObject;
begin
  LJsonInfo := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(TframeCartao(Sender).Tagstring), 0) as TJSONObject;

  if (uppercase(LJsonInfo.GetValue<String>('Status')) <> 'NORMAL') and (uppercase(LJsonInfo.GetValue<String>('Status')) <> 'LIBERADO') then
  begin
    FMSG.Show(TIconDialog.Warning, 'Atenção','O cartão não está apto para ser acessado neste totem!','OK');
//    TLogSQLite.New(tmInfo,clOperationRecord,'Cartão '+TframeCartao(Sender).lblPortador.Text+', com status: '+Lstatus+' impedido de ser acesso no totem').Save;
    exit;
  end;

//  TLogSQLite.New(tmInfo,clUserAction,'Acessando o cartão: '+LNumCartao+' do CPF '+FormataCPF(LCPF)).Save;

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
    end;
  end).Start;
end;


end.
