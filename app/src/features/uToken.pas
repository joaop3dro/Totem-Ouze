unit uToken;

interface
uses
 System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia, System.JSON,
  FMX.Layouts, FMX.Skia, FMX.Objects, uFancyDialog, System.Net.URLClient,
  System.Generics.Collections, System.Net.HttpClientComponent, System.Net.HttpClient, IdHTTP,
  uConnection, Notification;
  function ConsultaToken(AEndPoint:string; Out AToken:string):Boolean;
var
  FToken: string;
  FTimer: integer;
const
  FURL = 'https://pch-totem.calcard.com.br/api/totem-app';
//  FURL = 'https://qa-totem.calcard.com.br/api/totem-app';
  FPublicKey = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw41S2CjlXTmzUHzRHhfj3IXub4YCiwNUIlOg5dCcs99hPKYowjE/V5Bwk2vpLwJ'+
                'gA6Rr0PEZV8yHtXuU2a4EDwbwCgIss7tI8wufzT2tWIvj/c5Eo9qa71K5I4kkAFrPad/pCUlxtQOSFGTlJPmy+RJzTZzZXEYJlgz1iJH+Fc'+
                'JB6SscknM9SEMnNPEst3a1a3ckHLhhDFz+Ecg/5tvvU2v/UhDxewi30x+oYqYEFam78oeWyeN2vmsYLZ903s63UDC/zvTNXB9tWk/SRQ7Nc'+
                '9DjwKdjGZ2Wpekbwrvm2GHqhVqyIDBhoyA6c5sAvJrvlzcPrh20MiY4fGgxy3zvAQIDAQAB';
implementation

function ConsultaToken(AEndPoint:string; Out AToken:string):Boolean;
var
  LConnection: TConnection;
  LResult: string;
  LParam:TList<TParameter>;
  LJo:TJSONObject;
begin
  try
    LConnection:= TConnection.Create;
    try
      LParam:= TList<TParameter>.create;
      var LItem:TParameter;
      LItem.Key:= 'Authorization';
      LItem.Value:= 'Basic VE9URU1fSE1MOjAwMDA=';
      LParam.Add(LItem);
      if LConnection.post(AEndPoint,LParam,'', LResult) then
      begin
        LJo := TJSONObject.ParseJSONValue(LResult) as TJSONObject;
        AToken :=  LJo.GetValue<string>('access_token');
        FTimer := LJo.GetValue<integer>('expires_in');
        FToken := AToken;
        Result:= true;
      end
      else
      begin
        result := false;
      end;
    finally
      FreeAndNil(LConnection);
    end;
  except
    on E:Exception do
    begin
      Result:= false;
    end;

  end;
end;
end.