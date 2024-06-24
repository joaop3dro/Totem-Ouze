unit uConnection;

interface

uses System.SysUtils, System.Classes, REST.Types, REST.Client, System.JSON,
     REST.Authenticator.OAuth, FMX.Graphics, System.Net.HttpClient, System.Generics.Collections;

type
  TParameter = record
    Key: string;
    Value: string;
  end;

  TConnection = class
    private
     FRESTClient: TRESTClient;
     FRESTRequest: TRESTRequest;
     FRESTResponse: TRESTResponse;
     FOAuth2Authenticator: TOAuth2Authenticator;
    public
     constructor Create;
     destructor Destroy;
     function Post(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function Post(AUrl:string; AParameter: array of string; ABody:TJSONArray; out AResult:string): Boolean; overload;
     function PostS3(AUrl: string;AParameter: array of string; ABody: TBytesStream; out AResult: string): Boolean;
     function Post(AUrl:string; AParameter: array of string; ABody:string; out AResult:string;out ATImer: integer; AToken:string = ''): Boolean; overload;
     function Post(AUrl:string; AParameter: TList<TParameter>; ABody:string; out AResult:string): Boolean; overload;
     function PostNoBody(AUrl:string; AParameter: array of string; out AResult:string; AToken:string = ''): Boolean;

     function GetG(AUrl:string; AParameter: array of string; out AResult:string): Boolean; overload;
     function Get(AUrl:string; AParameter: array of string; out AResult:string; AToken:string = ''): Boolean; overload;
     function Get(AUrl:string; AParameter: array of string; ABody: TJSONObject; out AResult:string; AToken:string): Boolean; overload;
     function Get(AUrl: string; AParameter: array of string; out AResult: string; out AEtag: string; AToken: string): Boolean; overload;
     function GetBitmAp(AUrl:string; AParameter: array of string; AResult:TBitmap; AToken: string): Boolean; overload;

     function Put(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function PutS3(AUrl:string; AQueryParameter: TList<TParameter>; out AResult:string): Boolean; overload;
     function Delete(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function Delete(AUrl:string; AParameter: array of string; out AResult:string): Boolean; overload;
     function Delete(AUrl:string; AParameter: array of string; out AResult:string; AToken: string): Boolean; overload;
     function Patch(AUrl:string; AParameter: array of string; ABody:string; out AResult:string; AToken:string = ''): Boolean;
  end;

implementation

{ TConnection }

constructor TConnection.Create;
begin
  FRESTClient:= TRESTClient.Create(nil);
  FRESTRequest:= TRESTRequest.Create(nil);
  FRESTResponse:= TRESTResponse.Create(nil);
  FOAuth2Authenticator:= TOAuth2Authenticator.Create(nil);
  FRESTClient.SecureProtocols:= [THTTPSecureProtocol.TLS11];
end;

function TConnection.Delete(AUrl: string; AParameter: array of string;
  out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmDELETE;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;
  end;
end;

function TConnection.Delete(AUrl: string; AParameter: array of string;
  ABody: TJSONObject; out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmDELETE;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTResponse);
  FreeAndNil(FOAuth2Authenticator);
end;

function TConnection.Get(AUrl: string; AParameter: array of string;
 out AResult: string; AToken: string): Boolean;
var
 LUrl:string;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;

    FRESTClient.BaseURL := LUrl;
//    FRESTRequest.Timeout := 3000;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    if FRESTResponse.StatusCode in [200,204]  then
      Result:= True
    else
      Result := False;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Get(AUrl: string; AParameter: array of string;
 ABody: TJSONObject; out AResult: string; AToken: string): Boolean;
var
 LUrl:string;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    if FRESTResponse.StatusCode in [200,204]  then
      Result:= True
    else
      Result := False;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.GetG(AUrl: string; AParameter: array of string;
  out AResult: string): Boolean;
var
 LUrl:string;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Get(AUrl: string; AParameter: array of string;
  out AResult: string; out AEtag: string; AToken: string): Boolean;
var
 LUrl:string;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;

    FRESTClient.SetHTTPHeader('Etag', AEtag);
    FRESTRequest.Timeout := 3000;
    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AEtag := FRESTResponse.Headers.Values['Etag'];

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;
  except
    on e: exception do
    begin
      Result := false;
    end;
  end;
end;

function TConnection.GetBitmAp(AUrl:string; AParameter: array of string; AResult:TBitmap; AToken: string): Boolean;
var
 LUrl:string;
 LByte:TBytesStream;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];


    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    if Copy(FRESTResponse.Content, 0, 5) = '<?xml' then
    begin
      Result:= false;
      AResult:= nil;
      exit;
    end;

    TThread.Synchronize(nil,
    procedure
    begin
      LByte:= TBytesStream.Create(FRESTResponse.RawBytes);
      LByte.Position:= 0;

      AResult.LoadFromStream(LByte);
    end);

    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Post(AUrl: string; AParameter: array of string;
  ABody: string; out AResult: string; out ATImer: integer;AToken: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody,TRESTContentType.ctAPPLICATION_JSON);

    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;

    FRESTClient.BaseURL := LUrl;
//    FRESTRequest.Timeout := 3000;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    ATImer := FRESTRequest.ExecutionPerformance.ExecutionTime;
    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      AResult := FRESTResponse.Content;
      Result := false;
    end;

  end;
end;

function TConnection.Post(AUrl: string; AParameter: array of string;
  ABody: TJSONArray; out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody.ToString,TRESTContentType.ctAPPLICATION_JSON);
    FRESTRequest.Timeout := 3000;
    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.PostS3(AUrl: string;AParameter: array of string; ABody: TBytesStream; out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody, TRESTContentType.ctAPPLICATION_PDF);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPUT;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.PutS3(AUrl: string ; AQueryParameter: TList<TParameter>; out AResult: string): Boolean;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;

  try

    FRESTRequest.ClearBody;

    FRESTRequest.Accept := '*/*';
    FRESTRequest.AcceptEncoding := 'gzip, deflate, br';

    FRESTClient.BaseURL := AUrl;
    for var LItem in AQueryParameter do
      FRESTClient.Params.AddItem(LItem.Key, Litem.Value, TRESTRequestParameterKind.pkQUERY);
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Post(AUrl: string; AParameter: array of string;
  ABody: TJSONObject; out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);
    FRESTRequest.Timeout := 3000;
    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.PostNoBody(AUrl: string; AParameter: array of string;
  out AResult: string; AToken: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;
    FRESTRequest.Timeout := 3000;
    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;
  end;
end;

function TConnection.Put(AUrl: string; AParameter: array of string;
  ABody: TJSONObject; out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPUT;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;


function TConnection.Delete(AUrl: string; AParameter: array of string;
  out AResult: string; AToken: string): Boolean;
var
 LUrl:string;
begin
  Result := False;
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmDELETE;
    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;
  end;
end;

function TConnection.Patch(AUrl: string; AParameter: array of string;
  ABody: string; out AResult: string; AToken: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for var i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody,TRESTContentType.ctAPPLICATION_JSON);

    FRESTClient.Authenticator:= FOAuth2Authenticator;
    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AToken;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPATCH;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Post(AUrl: string; AParameter: TList<TParameter>;
  ABody: string; out AResult: string): Boolean;
var
 LUrl:string;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;

    if not ABody.IsEmpty then
    begin
      FRESTRequest.ClearBody;
      FRESTRequest.AddBody(ABody,TRESTContentType.ctAPPLICATION_JSON);
    end;

    for var LParam in AParameter do
      FRESTRequest.Params.AddItem(LParam.Key, LParam.Value, pkHTTPHEADER, [poDoNotEncode]);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      AResult := FRESTResponse.Content;
      Result := false;
    end;

  end;
end;

end.
