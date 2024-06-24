unit view.Seguros;

interface

uses IdeaL.Lib.View.Fmx.FrameListModel,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia,
  FMX.Objects, FMX.Ani, uGosEdit, FMX.Layouts, uGosObjects, System.Generics.Collections,
  FMX.Skia, FMX.Effects, uGosBase, uGosStandard, FMX.TabControl,System.JSON,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, frame.seguros,
  uFancyDialog ,FMX.ListBox, System.Actions, FMX.ActnList;

type
  TfrmSeguros = class(TForm)
    TabControl1: TTabControl;
    tabSegurosContratados: TTabItem;
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
    Layout6: TLayout;
    tabDetalheSeguro: TTabItem;
    Rectangle7: TRectangle;
    Layout19: TLayout;
    btnSair2: TGosButtonView;
    SkSvg17: TSkSvg;
    btnVoltar2: TGosButtonView;
    SkSvg18: TSkSvg;
    Layout20: TLayout;
    Layout21: TLayout;
    SkLabel21: TSkLabel;
    SkLabel22: TSkLabel;
    Layout48: TLayout;
    SkLabel25: TSkLabel;
    Rectangle17: TRectangle;
    Layout39: TLayout;
    lblDescricao: TSkLabel;
    GosLine5: TGosLine;
    Rectangle8: TRectangle;
    lblTitulo: TSkLabel;
    Image1: TImage;
    Cobertura: TSkLabel;
    lbContratos: TListBox;
    Memo1: TMemo;
    tabSegurosGeral: TTabItem;
    Rectangle9: TRectangle;
    Layout4: TLayout;
    btnSair3: TGosButtonView;
    SkSvg1: TSkSvg;
    btnVoltar3: TGosButtonView;
    SkSvg2: TSkSvg;
    Layout5: TLayout;
    Layout22: TLayout;
    SkLabel23: TSkLabel;
    lblSeguros: TListBox;
    Memo2: TMemo;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Rectangle16: TRectangle;
    Layout40: TLayout;
    recMes: TRectangle;
    SkLabel26: TSkLabel;
    svgIcon: TSkSvg;
    Layout41: TLayout;
    lblNameProduct: TSkLabel;
    Rectangle10: TRectangle;
    Layout23: TLayout;
    Rectangle11: TRectangle;
    SkLabel27: TSkLabel;
    SkSvg5: TSkSvg;
    Layout24: TLayout;
    SkLabel28: TSkLabel;
    Rectangle12: TRectangle;
    Layout25: TLayout;
    Rectangle13: TRectangle;
    SkLabel29: TSkLabel;
    SkSvg6: TSkSvg;
    Layout26: TLayout;
    SkLabel30: TSkLabel;
    Rectangle14: TRectangle;
    Layout27: TLayout;
    Rectangle15: TRectangle;
    SkLabel31: TSkLabel;
    SkSvg7: TSkSvg;
    Layout28: TLayout;
    SkLabel32: TSkLabel;
    Rectangle18: TRectangle;
    Layout29: TLayout;
    Rectangle19: TRectangle;
    SkLabel33: TSkLabel;
    SkSvg8: TSkSvg;
    Layout30: TLayout;
    SkLabel34: TSkLabel;
    Rectangle20: TRectangle;
    Layout31: TLayout;
    Rectangle21: TRectangle;
    SkLabel35: TSkLabel;
    SkSvg9: TSkSvg;
    Layout32: TLayout;
    SkLabel36: TSkLabel;
    ActionList1: TActionList;
    actTabSegurosAtivos: TChangeTabAction;
    actTabSeguroDetalhe: TChangeTabAction;
    actTabSeguros: TChangeTabAction;
    Layout7: TLayout;
    Layout10: TLayout;
    lylLoading: TLayout;
    Layout13: TLayout;
    lblTituloLoading: TSkLabel;
    lblSubtituloLoading: TSkLabel;
    SkAnimatedImage1: TSkAnimatedImage;
    recLoading: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnVoltar3Click(Sender: TObject);
    procedure btnVoltar2Click(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSair2Click(Sender: TObject);
  private
    FMSG: TFancyDialog;
    FListaFrame: TList<TframeSeguros>;
    FFrmLstVert: TFrameListModel;
    FFrmLstCobertura: TFrameListModel;
    FCPF: string;
    function SegurosAtivos(ACPF:string; out LjsonSegurosAtivos:TJSONObject): Boolean;
    procedure AddItemLista(AID, ADesc,AStatus: String; AContratado, AItemBranco : boolean);
    procedure SairConta;
{$IFDEF MSWINDOWS}
    procedure ItemProdutoClick(Sender: TObject);
    function ExisteNoArray(const AID: Integer;
      var AIDArray: array of Integer): Boolean;
{$ELSE}
    procedure ItemProdutoClick(Sender: TObject; const Point: TPointF);
{$ENDIF}
    { Private declarations }
  public
    { Public declarations }
    FFrmLstSeguros: TFrameListModel;
    FjsonSeguros: TJSONArray;
    FTabAnterior : TTabItem;
    FJsonAtivos: TJSONArray;
    FJsonDisponiveis: TJSONArray;
    procedure ListaCobertura(AJsonCobertura: TJSONArray; AValorSeguro: Double);
    function  ExtrairTexto(aText, OpenTag, CloseTag: String): String;
    function  ConsultaSeguros(ACPF:string; out AjsonSeguros:TJSONArray): Boolean;
    procedure ListaSegurosDisponivel(AJson: TJSONArray);
    procedure ListaSegurosAtivos(AJson: TJSONArray);
    procedure CarregaTela(ACPF: String);
  end;

var
  frmSeguros: TfrmSeguros;
  FArraySegurosAtivos: Array of Integer;

implementation

{$R *.fmx}

uses uConnection, uToken, uFormataCampos, view.menu, view.Principal,
  view.SelecaoCartao, controller.log, LogSQLite, Notificacao,
  IdeaL.Lib.View.Utils,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1,
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2,
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1;

procedure TfrmSeguros.btnSair2Click(Sender: TObject);
begin
  SairConta;
end;

procedure TfrmSeguros.btnVoltar2Click(Sender: TObject);
begin
  if FTabAnterior = tabSegurosContratados then
    actTabSegurosAtivos.Execute;
    
  if FTabAnterior = tabSegurosGeral then
    actTabSeguros.Execute;
  
end;

procedure TfrmSeguros.btnVoltar3Click(Sender: TObject);
begin
  actTabSegurosAtivos.Execute;
end;

procedure TfrmSeguros.btnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSeguros.CarregaTela(ACPF: String);
var
  LjsonSegurosAtivos: TJSONObject;
  LjsonSeguros: TJSONArray;
begin
  recLoading.Visible := true;
  lylLoading.Visible := true;
  lblTituloLoading.Text := 'Aguarde';
  lblSubtituloLoading.Text := 'Estamos processando as informações';

  FCPF:= ACPF;

  if not frmSeguros.ConsultaSeguros(FCPF,FjsonSeguros) then
  begin
    TLoading.ToastMessage(frmSeguros,'Erro ao consultar seguros para seu cpf!',5,TAlignLayout.Right);
    exit;
  end;

  ListaSegurosAtivos(FJsonAtivos);

  recLoading.Visible := false;
  lylLoading.Visible := false;
end;

function TfrmSeguros.SegurosAtivos(ACPF:string; out LjsonSegurosAtivos:TJSONObject): Boolean;
var
  LConnection: TConnection;
  LResult: string;
  Ljson : TJSONObject;
begin
  LConnection:= TConnection.Create;
  try

    if LConnection.Get(FURL+'/v1/affinity/sales?cpf='+ACPF,[], LResult, uToken.FToken) then
    begin
      result := true;
      LjsonSegurosAtivos := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
    end
    else
    begin
      result := false;
      Log('Erro ao consultar seguros ativos: '+LResult);
    end;
  finally
    FreeAndNil(LConnection);
  end;
end;

function TfrmSeguros.ConsultaSeguros(ACPF:string; out AjsonSeguros:TJSONArray): Boolean;
var
  LConnection: TConnection;
  LResult: string;
  Ljson : TJSONArray;
  LjsonValue, LjsonValueSub: TJSONValue;
  LJsonReasons: TJSONArray;
begin
  LConnection:= TConnection.Create;
  try
    if LConnection.Get(FURL+'/v1/affinity/catalog?cpf='+ACPF,[], LResult, uToken.FToken) then
    begin
      result := true;
      AjsonSeguros := TJSONArray.ParseJSONValue(LResult) as TJSONArray;

      FJsonAtivos := TJSONArray.Create;
      FjsonDisponiveis := TJSONArray.Create;

      for LjsonValue in AjsonSeguros do
      begin
        if LjsonValue.GetValue<Boolean>('allowsAccession') then
          FjsonDisponiveis.AddElement(LjsonValue)
        else
        begin
          LJsonReasons := LjsonValue.GetValue<TJSONArray>('reasonsDontAllowAccession') as TJSONArray;
          for LjsonValueSub in LJsonReasons do
          begin
            if LjsonValueSub.value = 'Cliente já possui este produto. Limite máximo: 1'  then
              FJsonAtivos.AddElement(LjsonValue);
            break;
          end;
        end;
      end;
    end
    else
    begin
      result := false;
      Log('Erro ao consultar seguros: '+LResult);
    end;
  finally
    FreeAndNil(LConnection);
  end;
end;

procedure TfrmSeguros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmSeguros := nil;
end;

procedure TfrmSeguros.FormCreate(Sender: TObject);
begin
  FMSG := TFancyDialog.create(self);
  FListaFrame := TList<TframeSeguros>.create;
  TabControl1.ActiveTab := tabSegurosContratados;
  TabControl1.TabPosition :=TTabPosition.None;

  SkLabel25.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
end;

procedure TfrmSeguros.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FListaFrame);
  FreeAndNil(FFrmLstVert);
  FreeAndNil(FFrmLstCobertura);
  FreeAndNil(FFrmLstSeguros);
  FreeAndNil(FMSG);
end;

procedure TfrmSeguros.ListaSegurosAtivos(AJson: TJSONArray);
var
  Ljson: TJSONValue;
  LjsonContratados: TJSONArray;
  LjsonDisponiveis: TJSONArray;
  LFil: TFrameItemListModel;
  LYPos: Single;
  Lcount : integer;
begin
  try
    Lcount := 0;
    TUtils.TextMessageColorOpacity := 'Black';
    if assigned(FFrmLstVert) then
      FreeAndNil(FFrmLstVert);
    FFrmLstVert := TFrameListModel.Create(Self);
    FFrmLstVert.BeginUpdate;
    FFrmLstVert.Parent := Layout6;
    FFrmLstVert.Align := TAlignLayout.Client;
    FFrmLstVert.IsGradientTransparency := false;

    FFrmLstVert.AddItem(TFilVert1,AJson,True);
  finally
    FFrmLstVert.EndUpdate;
  end;
end;

procedure TfrmSeguros.ListaCobertura(AJsonCobertura: TJSONArray; AValorSeguro: Double);
var
  Ljson: TJSONValue;
  LJsoninsurance: TJSONObject;
  LjsonContent: TJSONArray;
  LjsonConjunt: TJSONArray;
  LItem : TListBoxItem;
  LLabel : TSkLabel;
  LFil: TFrameItemListModel;
  LYPos: Single;
  Lcount : integer;
  LCountSeguros: integer;
begin
  try
    Lcount := 0;
    TUtils.TextMessageColorOpacity := 'Black';
    if assigned(FFrmLstCobertura) then
      FreeAndNil(FFrmLstCobertura);

    FFrmLstCobertura := TFrameListModel.Create(Self);
    FFrmLstCobertura.BeginUpdate;
    FFrmLstCobertura.Parent := Layout10;
    FFrmLstCobertura.Align := TAlignLayout.Client;
    FFrmLstCobertura.IsGradientTransparency := false;

    FFrmLstCobertura.AddItem(TFilVert1,AJsonCobertura,AValorSeguro);
  finally
    FFrmLstCobertura.EndUpdate;
  end;
end;

procedure TfrmSeguros.ListaSegurosDisponivel(AJson: TJSONArray);
var
  Ljson: TJSONValue;
  LJsoninsurance: TJSONObject;
  LjsonContent: TJSONArray;
  LjsonConjunt: TJSONArray;
  LItem : TListBoxItem;
  LLabel : TSkLabel;
  LFil: TFrameItemListModel;
  LYPos: Single;
  Lcount : integer;
  LCountSeguros: integer;
begin
  try
     Lcount := 0;
     TUtils.TextMessageColorOpacity := 'Black';

     if assigned(FFrmLstSeguros) then
       FreeAndNil(FFrmLstSeguros);

     FFrmLstSeguros := TFrameListModel.Create(Self);
     FFrmLstSeguros.BeginUpdate;
     FFrmLstSeguros.Parent := Layout7;
     FFrmLstSeguros.Align := TAlignLayout.Client;
     FFrmLstSeguros.IsGradientTransparency := false;

     FFrmLstSeguros.AddItem(TFilVert1,AJson,False);
  finally
    FFrmLstSeguros.EndUpdate;
  end;
end;

procedure TfrmSeguros.AddItemLista(AID, ADesc, AStatus: String; AContratado, AItemBranco : boolean);
var
  LItem: TListBoxItem;
  LFrame: TframeSeguros;
  LColuna: integer;
  LQuant: integer;
  Lqtd: integer;
begin

  try
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbContratos.BeginUpdate;
    end);

    LItem := TListBoxItem.Create(nil);
    LItem.Selectable := false;
    LItem.Text := '';
    LItem.Height := 203;
    LItem.Width := 198;
    LItem.Margins.Right:= 4;
    LItem.Margins.Bottom:= 4;
    LItem.Margins.Top:= 4;

    if (AID = '333') and (ADesc = 'T') then
     LItem.Margins.Left:= 396
    else
     LItem.Margins.Left:= 4;


    if not AItemBranco then
    begin
      LFrame := TframeSeguros.Create(LItem);
      LFrame.hittest := false;
      LFrame.Align := TAlignLayout.Client;

      if AContratado = true  then
      begin
        LFrame.lblcontratado.Text := 'CONTRATADO';
      end
      else
      begin
        LFrame.Rectangle1.Visible := true;
        LFrame.Rectangle2.Visible := false;
      end;
      LFrame.lblNameProduct.text := FormataNome(ADesc);
      LFrame.HitTest := true;
      LFrame.TagString :=AID;

      {$IFDEF MSWINDOWS}
      LFrame.Onclick := ItemProdutoClick;
      {$ELSE}
      LFrame.OnTap :=  ItemProdutoClick;
      {$ENDIF}
      LItem.AddObject(LFrame);
    end;

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      LItem.Repaint;
    end);

    lbContratos.AddObject(LItem);

    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      lbContratos.EndUpdate;
    end);

  except on ex: exception do
    begin
//      FMsg.Show(TIconDialog.Error, 'Erro carregar lista: ', ex.Message, 'Ok',
//      procedure
//      begin
//        //ListaItens(1, true);
//      end);
      exit;
    end;
  end;

end;

{$IFDEF MSWINDOWS}
procedure TfrmSeguros.ItemProdutoClick(Sender: TObject);
{$ELSE}
procedure TfrmSeguros.ItemProdutoClick(Sender: TObject; const Point: TPointF);
{$ENDIF}
begin
  // seleciona seguro
  if TframeSeguros(sender).TagString = '333' then
  begin
    actTabSeguros.Execute;
  end
  else
  begin
    lblTitulo.Text := TframeSeguros(sender).lblNameProduct.Text;
    actTabSeguroDetalhe.Execute;
  end;
end;

procedure TfrmSeguros.SairConta;
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
          frmSeguros.close;
          frmMenu.close;
          frmSelecaoCartao.Close;
        end);
      end;
    end).Start;
  end,'NÃO');
end;

function TfrmSeguros.ExisteNoArray(const AID: Integer;
  var AIDArray: array of Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
 
  for i := Low(AIDArray) to High(AIDArray) do
  begin
    if (AID = AIDArray[i]) then
    begin
      Result := True;
      Break;
    end
  end;
end;

function TfrmSeguros.ExtrairTexto(aText, OpenTag, CloseTag : String) : String;
{ Retorna o texto dentro de 2 tags (open & close Tag's) }
var
  iAux, kAux : Integer;
begin
  Result := '';

  if (Pos(CloseTag, aText) <> 0) and (Pos(OpenTag, aText) <> 0) then
  begin
    iAux := Pos(OpenTag, aText) + Length(OpenTag);
    kAux := Pos(CloseTag, aText);
    Result := Copy(aText, iAux, kAux-iAux).Replace('<br />', '');
  end
  else
  begin
    Result := aText;
  end;

  Result := Result.Replace(';','; ');
  Result := Result.Replace('r$','R$');
  Result := Result.Replace(';  ','; ');
end;


end.
