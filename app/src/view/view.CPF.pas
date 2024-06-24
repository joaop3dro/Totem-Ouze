unit view.CPF;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, DBXJSON,
  FMX.Skia, FMX.Layouts, uGosBase, uGosEdit, FMX.Ani, System.ImageList,
  FMX.ImgList, FMX.Effects, FMX.Filter.Effects,System.JSON, uFancyDialog,
  uGosStandard
  {$IFDEF MSWINDOWS}
  ,windows
  ,Winapi.Messages, System.Skia
  {$ENDIF}
  ;

type
  TfrmCPF = class(TForm)
    ALRectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    edtCPF: TGosEditView;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Timer1: TTimer;
    Layout3: TLayout;
    Layout4: TLayout;
    Rectangle4: TRectangle;
    Glyph2: TGlyph;
    FillRGBEffect2: TFillRGBEffect;
    ImageList1: TImageList;
    lylTecladoNumerico: TLayout;
    FloatAnimation2: TFloatAnimation;
    Layout10: TLayout;
    btn4: TGosButtonView;
    btn5: TGosButtonView;
    btn6: TGosButtonView;
    Layout11: TLayout;
    btn0: TGosButtonView;
    btnEnviar: TGosButtonView;
    btnCorrigir: TGosButtonView;
    Line1: TLine;
    Layout8: TLayout;
    btn8: TGosButtonView;
    btn9: TGosButtonView;
    Layout9: TLayout;
    btn1: TGosButtonView;
    btn3: TGosButtonView;
    btn2: TGosButtonView;
    btn7: TGosButtonView;
    btnVoltar: TGosButtonView;
    SkSvg1: TSkSvg;
    btnSair: TGosButtonView;
    SkSvg2: TSkSvg;
    Layout5: TLayout;
    SkLabel5: TSkLabel;
    skloading: TSkAnimatedImage;
    recLoading: TRectangle;
    SkAnimatedImage1: TSkAnimatedImage;
    lylLoading: TLayout;
    Layout7: TLayout;
    lblTitulo: TSkLabel;
    lblSubtitulo: TSkLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCorrigirClick(Sender: TObject);
    procedure edtCPFTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTempo : integer;
    FMSG: TFancyDialog;
    function ConsultaCPF(ACPF:String; out AjsonCPF: TJSONArray; out Atimer: integer): boolean;
    const Tempo = 30;
  public
    { Public declarations }
  end;

var
  frmCPF: TfrmCPF;


implementation

{$R *.fmx}

uses view.Principal, uFormataCampos, Notificacao,
  view.SelecaoCartao, uToken, uConnection, uAguarde, LogSQLite,
  LogSQLite.KibanaSender, controller.log, uFormat, view.menu;


procedure TfrmCPF.btn1Click(Sender: TObject);
begin
  edtCPF.Text := edtCPF.Text + TGosButtonView(Sender).Text;
end;

procedure TfrmCPF.btnCorrigirClick(Sender: TObject);
begin
  edtCPF.text := '';
end;

procedure TfrmCPF.btnEnviarClick(Sender: TObject);
var
  LjsonArrayCard: TJSONArray;
  Ltimer: integer;
begin
  if length(edtCPF.Text.Replace('.','').Replace('-','')) <> 11  then
  begin
    TLoading.ToastMessage(frmCPF,'Informe um CPF v�lido!',5,TAlignLayout.MostRight);
  end
  else
  begin
    recLoading.Visible := true;
    lylLoading.Visible := true;
    TThread.CreateAnonymousThread(
    procedure
    begin
      try
        try
          if FToken.IsEmpty  then
          begin
            if not ConsultaToken(FURL+'/v1/authentication', FToken) then
            begin
              TLoading.ToastMessage(frmCPF,'Erro ao buscar Token' ,5,TAlignLayout.MostRight);
              edtCPF.Text := '';
              exit;
            end;
          end;
          log('Iniciou consulta: '+datetimetostr(now));
          if not ConsultaCPF(edtCPF.Text.Replace('.','').Replace('-',''),LjsonArrayCard,Ltimer) then
           begin
            edtCPF.Text := '';

            TAguarde.Hide;
            exit;
          end
          else
          begin
            log('Timer perfomace consulta: '+Ltimer.ToString);
            log('Consulta cpf: '+LjsonArrayCard.ToString);
            TThread.Synchronize(nil,
            procedure
            begin
              if not Assigned(frmSelecaoCartao) then
                Application.CreateForm(TfrmSelecaoCartao, frmSelecaoCartao);

            end);

            frmSelecaoCartao.ListaCartoes(LjsonArrayCard);

           TThread.Synchronize(nil,
            procedure
            begin
              frmSelecaoCartao.Show;
            end);


            log('Finalizando listagem: '+datetimetostr(now));

//            TLogSQLite.New(tmInfo,clUserAction,'Acessando a conta do CPF: '+edtCPF.Text).Save;
          end;

        except
          On E:Exception do
          begin
            ShowMessage(E.Message);
            log('Exeption consulta cpf: '+E.Message)
          end;

        end;
      finally
        TThread.Synchronize(nil,
        procedure
        begin
          edtCPF.Text := '';

          recLoading.Visible := false;
          lylLoading.Visible := false;
//          frmCPF.Close;
        end);
        log('Fim tthread');
      end;
    end).Start;
  end;
end;

procedure TfrmCPF.edtCPFChange(Sender: TObject);
var
  Lcpf : string;
  LcpfQ: integer;
begin
  Formatar(edtCPF,TFormato.CPF);
end;

procedure TfrmCPF.edtCPFTyping(Sender: TObject);
begin
  Formatar(edtCPF,TFormato.CPF);
end;

procedure TfrmCPF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmCPF := nil;
end;

procedure TfrmCPF.FormCreate(Sender: TObject);
begin
  FMsg := TFancyDialog.Create(self);
end;

procedure TfrmCPF.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMsg);
end;

procedure TfrmCPF.FormShow(Sender: TObject);
begin
  edtCPF.Text := '';
//  Timer1.Enabled :=true;
  SkLabel5.text := 'Sistema de Teste - Vers�o '+frmPrincipal.FVersion;
end;

procedure TfrmCPF.btnVoltarClick(Sender: TObject);
begin
//  close;
  btnSairClick(self);
end;

procedure TfrmCPF.btnSairClick(Sender: TObject);
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
        frmCPF.close;
      end);
    end;
  end).Start;
end;

procedure TfrmCPF.Rectangle4Click(Sender: TObject);
begin
  if EdtCPF.Password then
  begin
    EdtCPF.Password := false;
    TGlyph(TLayout(Sender).Children[0]).ImageIndex := 1;
  end
  else
  begin
    EdtCPF.Password := true;
    TGlyph(TLayout(Sender).Children[0]).ImageIndex := 0;
  end;
end;

function SecondsIdle: DWord;
var
  liInfo: TLastInputInfo;
begin
  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  Result := (GetTickCount - liInfo.dwTime) DIV 1000;
end;

procedure TfrmCPF.Timer1Timer(Sender: TObject);
var
  sec: DWORD;
begin
  sec := SecondsIdle;

  if sec > 25 then
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
          frmCPF.close;
        end);
      end;
    end).Start;
  end
end;

function TfrmCPF.ConsultaCPF(ACPF:String; out AjsonCPF: TJSONArray; out Atimer: integer): boolean;
var
  LConnection: TConnection;
  LResult: string;
  LCPF: String;
  Ljson: TJSONValue;
  LStatus: string;
  LJoAccount: TJSONObject;
begin
  try
    LCPF := '{"cpf":"'+ACPF+'"}';
    LConnection:= TConnection.Create;
    try
      if LConnection.post(FURL+'/v1/card/query/',[],LCPF, LResult,Atimer, uToken.FToken) then
      begin
        Result := true;
        AjsonCPF := TJSONArray.ParseJSONValue(LResult) as TJSONArray;

        for Ljson in AjsonCPF do
        begin
          LJoAccount := Ljson.GetValue<TJSONObject>('account');

          if (UPPERCASE(LJoAccount.GetValue<string>('status')) <> 'NORMAL') or (UPPERCASE(LJoAccount.GetValue<string>('status')) = 'CANCELED_DISABLED') then
          begin
            if Pos('BLOQUE',UpperCase(LJoAccount.GetValue<string>('status')))<>0 then
            begin
              FMSG.Show(TIconDialog.Warning, 'Aten��o','Conta bloqueada, favor dirigir-se ao espa�o Ouze.','OK');
              result := false;
              exit;
            end
            else
            begin
              FMSG.Show(TIconDialog.Warning, 'Aten��o','Conta com problema, favor dirigir-se ao espa�o Ouze.','OK');
              result := false;
              exit;
            end;
          end;
        end;
      end
      else
      begin
        AjsonCPF := TJSONArray.ParseJSONValue(LResult) as TJSONArray;
        for Ljson in AjsonCPF do
        begin
          if pos('Pessoa n�o encontrada',Ljson.GetValue<string>('message'))<>0 then
            TLoading.ToastMessage(frmCPF,'CPF N�o encontrado!' ,5,TAlignLayout.MostRight)
          else if pos('Nenhum Cart�o n�o encontrado para o cpf',Ljson.GetValue<string>('message'))<>0 then
            TLoading.ToastMessage(frmCPF,'Nenhum Cart�o encontrado para este CPF!' ,5,TAlignLayout.MostRight)
          else
            TLoading.ToastMessage(frmCPF,'Erro ao consultar CPF!' ,5,TAlignLayout.MostRight);
        end;

        Result := false;
        log('Erro ao consultar cpf: '+ LResult);
      end;
    except
      on E:Exception do
      begin
        log('Erro :'+e.Message);
      end;
    end;

  finally
    FreeAndNil(LConnection);
  end;
end;

end.
