unit view.Limite;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia,
  FMX.Objects, uGosObjects, FMX.Skia, FMX.Layouts,System.JSON, uFancyDialog,
  FMX.Effects, uGosBase, uGosStandard;

type
  TfrmLimite = class(TForm)
    Rectangle2: TRectangle;
    Layout5: TLayout;
    Layout6: TLayout;
    S: TLayout;
    SkLabel5: TSkLabel;
    SkLabel6: TSkLabel;
    Layout14: TLayout;
    Rectangle8: TRectangle;
    Layout19: TLayout;
    Rectangle9: TRectangle;
    SkLabel11: TSkLabel;
    lblLimiteGlobal: TSkLabel;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    lblSaldo: TSkLabel;
    SkLabel3: TSkLabel;
    GosLine2: TGosLine;
    Rectangle4: TRectangle;
    Layout2: TLayout;
    Rectangle6: TRectangle;
    lblLimiteSaque: TSkLabel;
    SkLabel7: TSkLabel;
    Layout3: TLayout;
    Rectangle7: TRectangle;
    lblSaldoSaque: TSkLabel;
    SkLabel9: TSkLabel;
    GosLine1: TGosLine;
    Layout4: TLayout;
    lylInfo: TLayout;
    SkSvg4: TSkSvg;
    SkLabel12: TSkLabel;
    btnSair: TGosButtonView;
    SkSvg2: TSkSvg;
    btnVoltar: TGosButtonView;
    SkSvg1: TSkSvg;
    Layout7: TLayout;
    SkLabel1: TSkLabel;
    lylElegivel: TLayout;
    Rectangle3: TRectangle;
    SkLabel2: TSkLabel;
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FMSG: TFancyDialog;
    FJson: TJSONObject;
    function ConsultaEmprestimo(ACPF:string): boolean;
  public
    { Public declarations }
    procedure CarregaTela(ACPF: String; AJsonLimite: TJSONObject);
  end;

var
  frmLimite: TfrmLimite;

implementation

{$R *.fmx}

uses view.menu, view.CPF, view.Principal, view.SelecaoCartao, uConnection,
  uToken, Notificacao, controller.log, LogSQLite;

procedure TfrmLimite.btnSairClick(Sender: TObject);
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
          frmLimite.Close;
          frmMenu.Close;
          frmSelecaoCartao.close;
        end);
      end;
    end).Start;
  end,'NÂO',nil);
end;

procedure TfrmLimite.btnVoltarClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLimite.CarregaTela(ACPF: String; AJsonLimite: TJSONObject);
begin
  if not ConsultaToken(FURL+'/v1/authentication', FToken) then
  begin
    TLoading.ToastMessage(frmLimite,'Erro ao buscar Token',5,TAlignLayout.MostRight);
    exit;
  end;

  FJson := AJsonLimite;

//  if not ConsultaEmprestimo(ACPF) then
//  begin
//    lylElegivel.visible := false;
//    lylInfo.align := TAlignLayout.Center;
//  end
//  else
//  begin
//    lylElegivel.visible := true;
//    lylInfo.align := TAlignLayout.Right;
//  end;

  lbllimiteGlobal.text := FormatFloat('R$ #,##0.00',AJsonLimite.GetValue<double>('limitGlobal'));
  lblsaldo.text := FormatFloat('R$ #,##0.00',AJsonLimite.GetValue<double>('availableBalanceGlobal'));
  lblLimiteSaque.text := FormatFloat('R$ #,##0.00',AJsonLimite.GetValue<double>('limitWithdrawGlobal'));
  lblSaldoSaque.text:= FormatFloat('R$ #,##0.00',AJsonLimite.GetValue<double>('availableBalanceWithdraw'));
end;

procedure TfrmLimite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmLimite := nil;
end;

procedure TfrmLimite.FormCreate(Sender: TObject);
begin
  FMsg := TFancyDialog.Create(self);
  SkLabel1.text := 'Sistema de Teste - Versão '+frmPrincipal.FVersion;
  lbllimiteGlobal.text := 'R$';
  lblsaldo.text := 'R$';
  lblLimiteSaque.text := 'R$';
  lblSaldoSaque.text:='R$';
end;

procedure TfrmLimite.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMSG);
end;

function TfrmLimite.ConsultaEmprestimo(ACPF:string): boolean;
var
  LConnection: TConnection;
  LResult: string;
  LjsonLimite: TJSONObject;
begin
  LConnection:= TConnection.Create;
  try
    try
      if LConnection.Get(FURL+'/v1/loan/eligibility?cpf='+ACPF,[], LResult, FToken) then
      begin
        LjsonLimite := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LResult), 0) as TJSONObject;
        result := LjsonLimite.GetValue<Boolean>('elegivel');
      end
      else
      begin
        result := false;
        log('Erro ao consultar elegibilidade de emprestimo: '+LResult);
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


end.
