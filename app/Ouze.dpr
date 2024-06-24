program Ouze;

uses
  System.StartUpCopy,
  System.IniFiles,
  System.SysUtils,
  FMX.Forms,
  FMX.Skia,
  Fmx.Types,
  view.CPF in 'src\view\view.CPF.pas' {frmCPF},
  view.Principal in 'src\view\view.Principal.pas' {frmPrincipal},
  view.SelecaoCartao in 'src\view\view.SelecaoCartao.pas' {frmSelecaoCartao},
  frame.cartao in 'src\frame\frame.cartao.pas' {frameCartao: TFrame},
  Notificacao in 'src\features\Notificacao.pas',
  uCamelCase in 'src\features\uCamelCase.pas',
  uFancyDialog in 'src\features\uFancyDialog.pas',
  uFormataCampos in 'src\features\uFormataCampos.pas',
  view.menu in 'src\view\view.menu.pas' {frmMenu},
  view.Limite in 'src\view\view.Limite.pas' {frmLimite},
  uConnection in 'src\features\uConnection.pas',
  Loading in 'src\features\Loading.pas',
  uToken in 'src\features\uToken.pas',
  view.Emprestimo in 'src\view\view.Emprestimo.pas' {frmEmprestimo},
  view.ExtratoFatura in 'src\view\view.ExtratoFatura.pas' {frmExtratoFatura},
  view.PagarFatura in 'src\view\view.PagarFatura.pas' {frmPagarFatura},
  frame.extrato in 'src\frame\frame.extrato.pas' {frameExtrato: TFrame},
  frame.Fatura in 'src\frame\frame.Fatura.pas' {frameFatura: TFrame},
  frame.parcelas in 'src\frame\frame.parcelas.pas' {frameParcelas: TFrame},
  uAguarde in 'src\features\uAguarde.pas',
  model.fatura in 'src\model\model.fatura.pas' {dmfatura: TDataModule},
  controller.imagens in 'src\controller\controller.imagens.pas',
  controller.impressao in 'src\controller\controller.impressao.pas',
  view.Seguros in 'src\view\view.Seguros.pas' {frmSeguros},
  FMX.BitmapHelper in 'src\features\FMX.BitmapHelper.pas',
  AnonThread in 'src\features\AnonThread.pas',
  controller.log in 'src\controller\controller.log.pas',
  LogSQLite.Config in 'src\library\LogSQLite.Config.pas',
  LogSQLite.DB in 'src\library\LogSQLite.DB.pas' {LogSQLiteDB: TDataModule},
  LogSQLite.Helper in 'src\library\LogSQLite.Helper.pas',
  LogSQLite.KibanaSender in 'src\library\LogSQLite.KibanaSender.pas',
  LogSQLite.LogExceptions in 'src\library\LogSQLite.LogExceptions.pas',
  LogSQLite in 'src\library\LogSQLite.pas',
  IdeaL.Lib.View.Fmx.FrameItemListModel in 'src\view2\Fmx\List\IdeaL.Lib.View.Fmx.FrameItemListModel.pas' {FrameItemListModel: TFrame},
  IdeaL.Demo.ScrollBox.FrameItemList.Horz1 in 'src\Arq\IdeaL.Demo.ScrollBox.FrameItemList.Horz1.pas' {FilHorz1: TFrame},
  IdeaL.Demo.ScrollBox.FrameItemList.Horz2 in 'src\Arq\IdeaL.Demo.ScrollBox.FrameItemList.Horz2.pas' {FilHorz2: TFrame},
  IdeaL.Demo.ScrollBox.FrameItemList.Vert1 in 'src\Arq\IdeaL.Demo.ScrollBox.FrameItemList.Vert1.pas' {FilVert1: TFrame},
  frame.seguros in 'src\frame\frame.seguros.pas' {frameSeguros: TFrame},
  frame.cobertura in 'src\frame\frame.cobertura.pas' {frameCobertura: TFrame},
  ACBrBoletoFCFortesFr in '..\..\Componentes\ACBr\Fontes\ACBrBoleto\FC\Fortes\ACBrBoletoFCFortesFr.pas' {ACBRBoletoFCFortesFr},
  ACBrBoleto in '..\..\Componentes\ACBr\Fontes\ACBrBoleto\ACBrBoleto.pas',
  uFormat in 'src\features\uFormat.pas',
  IdeaL.Lib.View.Fmx.FrameItemCoberturaListModel in 'src\view2\Fmx\List\IdeaL.Lib.View.Fmx.FrameItemCoberturaListModel.pas' {FrameCoberturaListModel: TFrame},
  uIconsSvg in 'src\features\uIconsSvg.pas',
  controller.tempo in 'src\controller\controller.tempo.pas',
  telnet in 'src\features\telnet.pas',
  uFunctions in 'src\features\uFunctions.pas',
  frame.menu in 'src\frame\frame.menu.pas' {frameMenu: TFrame},
  frame.ContratoEP in 'src\frame\frame.ContratoEP.pas' {frameContratoEP: TFrame},
  view.ClubeSTZ in 'src\view\view.ClubeSTZ.pas' {frmClubeSTZ},
  frame.ExtratoCashBack in 'src\frame\frame.ExtratoCashBack.pas' {frameCashBack: TFrame};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;

//  var FLogSQLiteConfig := TLogSQLiteConfig.GetInstance;
//  var ArqIni := TIniFile.Create(ExtractFilePath(ParamStr(0))+ 'CacheKibana.dat') ;
//  try
//    FLogSQLiteConfig.Load(ArqIni,'0');
//  finally
//    ArqIni.Free;
//  end;
//
//  if FLogSQLiteConfig.Active then
//  begin
//    TLogSQLiteDB.GetInstance;
//    if FLogSQLiteConfig.Kibana.Active then
//      TLogSQLiteKibanaSenderManager.InicializarSender;
//
//  end;

  GlobalUseDirect2D := false;
  GlobalUseHWEffects := true;
  Application.CreateForm(Tdmfatura, dmfatura);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCPF, frmCPF);
  Application.CreateForm(TfrmSelecaoCartao, frmSelecaoCartao);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmLimite, frmLimite);
  Application.CreateForm(TfrmEmprestimo, frmEmprestimo);
  Application.CreateForm(TfrmExtratoFatura, frmExtratoFatura);
  Application.CreateForm(TfrmPagarFatura, frmPagarFatura);
  Application.CreateForm(TfrmSeguros, frmSeguros);
  Application.CreateForm(TfrmClubeSTZ, frmClubeSTZ);
  Application.Run;


end.
