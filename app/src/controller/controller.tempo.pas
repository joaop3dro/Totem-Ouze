unit controller.tempo;

interface

uses
  windows
 ,Winapi.Messages
 ,System.sysUtils
 ,System.Classes
 ,FMX.Forms
 ,FMX.Types;

type
  TTempo = class
  private
    function SecondsIdle: DWord;
  public
    procedure VerificaInatividade(Atempo: integer);
  end;


implementation

uses view.Principal, view.CPF, view.ExtratoFatura, view.Emprestimo,
  view.SelecaoCartao, view.menu, view.PagarFatura, view.ClubeSTZ, view.Limite,
  view.Seguros, controller.log;

function TTempo.SecondsIdle: DWord;
var
  liInfo: TLastInputInfo;
begin
  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  Result := (GetTickCount - liInfo.dwTime) DIV 1000;
end;

procedure TTempo.VerificaInatividade(Atempo: integer);
var
  sec: DWORD;
begin
  sec := SecondsIdle;

  if sec > Atempo then
  begin
    Log('Logout por inatividade');
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
          frmPrincipal.TmrVerifica.Enabled := false;
          if Assigned(frmCPF) then
            frmCPF.Close;

          if Assigned(frmSelecaoCartao) then
            frmSelecaoCartao.Close;

          if Assigned(frmExtratoFatura) then
            frmExtratoFatura.Close;

          if Assigned(frmEmprestimo) then
            frmEmprestimo.Close;

          if Assigned(frmMenu) then
            frmMenu.Close;

          if Assigned(frmPagarFatura) then
            frmPagarFatura.Close;

          if Assigned(frmClubeSTZ) then
            frmClubeSTZ.Close;

          if Assigned(frmLimite) then
            frmLimite.Close;

          if Assigned(frmSeguros) then
            frmSeguros.Close;

        end);
      end;
    end).Start;
  end
end;
end.
