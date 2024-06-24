unit controller.imagem;

interface

uses Horse,
     Horse.JWT,
     System.JSON,
     model.con;

procedure Imagem;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  System.SysUtils;

procedure Imagem;
begin
  THorse.Get('/imagem',Get);
  THorse.Post('/cadastrarimagem',Post);
end;


procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDmCon: TDmCon;
begin
  try
//    Log('Listando produto');
    LDmCon := TDmCon.Create(nil);
    try
      Res.Send<TJSONObject>(LDmCon.Get);
    finally
      Res.Status(200);
      FreeAndNil(LDmCon);
    end;

  except
    on e: Exception do
    begin
      Res.Send(e.Message).Status(400);
//      Log('Erro ao listar produto:'+ e.Message);
      FreeAndNil(LDmCon);
    end;

  end;
end;

procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDmCon: TDmCon;
begin
  try
//    Log('Cadastrando produto');
    LDmCon := TDmCon.Create(nil);
    try
      Res.Send<TJSONObject>(LDmCon.Post(Req.Body<TJSONObject>));
    finally
      Res.Status(200);
      FreeAndNil(LDmCon);
    end;

  except
    on e: Exception do
    begin
      Res.Send(e.Message).Status(400);
//      Log('Erro ao listar produto:'+ e.Message);
      FreeAndNil(LDmCon);
    end;

  end;
end;

end.
