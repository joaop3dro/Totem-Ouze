program OuzeServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.jhonson,
  controller.imagem in 'src\controller\controller.imagem.pas',
  model.con in 'src\model\model.con.pas' {DmCon: TDataModule};

begin
  THorse.Use(Jhonson());

  controller.imagem.Imagem;

  THorse
    .Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
       res.send('pong');
    end);

  THorse.Listen(9000,
  procedure
  begin
    Writeln(' ' + 'Rodando na porta: '+THorse.Port.ToString);
    Writeln;
  end);
end.
