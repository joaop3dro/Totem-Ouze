unit IdeaL.Lib.PushNotification;

{
  * How to implement?
  Sender: https://ibb.co/swSHgt0

  * Need: Project->Options->Entitlement List->Receive push notifications

  Receiver
  Delphi 10.3.3+ http://docwiki.embarcadero.com/RADStudio/Sydney/en/Firebase_Android_Support
  To use the example, follow the link until step number 8

  * Obs:
  It's not necessary any further permission, you can check I've unchecked all of them ;)

  ** For Android13+
  Check out this Forum: https://en.delphipraxis.net/topic/8075-android-13-ask-permission-for-push-notification/
  Check out the oficial DOC: https://developer.android.com/develop/ui/views/notifications/notification-permission
}

interface

uses
  System.SysUtils,

  // Receiver
  System.PushNotification
{$IFDEF ANDROID}
    ,
  FMX.PushNotification.Android
{$ENDIF}

{$IF CompilerVersion <= 33.0} // Delphi 10.3.3 or lower

{$IFEND}
  // Receiver

  // Sender
    ,
  System.Classes,
  System.Net.HttpClient,
  System.JSON
  // Sender
    ;

type
  TPushNotificationReceiver = class
  private
  var
    FPushService: TPushService;
    FOnReceiveNotificationEvent: TProc<string>;
    FDoDeviceTokenHasBeenTaken: TProc;
    FPushServiceConnection: TPushServiceConnection;
    FDeviceToken: string;
    FDeviceId: string;

    class var FPushNotification: TPushNotificationReceiver;

    constructor Create;

    procedure SetDeviceToken(const Value: string);
    procedure DoChangeEvent(Sender: TObject; AChange: TPushService.TChanges);
    procedure DoReceiveNotificationEvent(Sender: TObject; const ANotification: TPushServiceNotification);
    function GetStartupNotifications: TArray<string>;
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);

    class function GetPushNotification: TPushNotificationReceiver; static;
    { private declarations }
  protected
    { protected declarations }
  public
    destructor Destroy; override;

    class property Instance: TPushNotificationReceiver read GetPushNotification;

    property Active: Boolean read GetActive write SetActive;

    property DeviceToken: string read FDeviceToken;
    property DeviceId: string read FDeviceId;
    property OnReceiveNotificationEvent: TProc<string> read FOnReceiveNotificationEvent write FOnReceiveNotificationEvent;
    property OnDeviceTokenHasBeenTaken: TProc read FDoDeviceTokenHasBeenTaken write FDoDeviceTokenHasBeenTaken;

    property StartupNotifications: TArray<string> read GetStartupNotifications;

    function StartupNotificationsStr: string;
    { public declarations }
  end;

  TPushNotificationSender = class
  private
    const
    // FUrlGcm = 'https://android.googleapis.com/gcm/send';
    FUrlFcm = 'https://fcm.googleapis.com/fcm/send';

  var
    FSenderId: string;
    FApiKey: string;
    class var FPushNotification: TPushNotificationSender;

    constructor Create;
    class function GetPushNotification: TPushNotificationSender; static;
    { private declarations }
  protected
    { protected declarations }
  public
    destructor Destroy; override;

    property SenderId: string read FSenderId write FSenderId;
    property ApiKey: string read FApiKey write FApiKey;

    class property Instance: TPushNotificationSender read GetPushNotification;

    // It DOESNT show the Notification Icon on the Device
    function Send(
      ATokens: TArray<string>;
      AFields: TArray<string>;
      AValues: TArray<string>;
      const AProcDataBeferoSend: TProc<string> = nil;
      const AProcResponse: TProc<string> = nil
      ): string; overload;
    // It DOES show the Notification Icon on the Device
    function Send(
      const ATitle: string;
      const AId: string;
      const ABody: string;
      ATokens: TArray<string>;
      AFields: TArray<string>;
      AValues: TArray<string>;
      const AProcDataBeferoSend: TProc<string> = nil;
      const AProcResponse: TProc<string> = nil
      ): string; overload;
    { public declarations }
  end;

implementation

{ TPushNotification }

constructor TPushNotificationReceiver.Create;
var
  AServiceName: string;
begin
  FOnReceiveNotificationEvent := nil;
  FDoDeviceTokenHasBeenTaken := nil;

  FDeviceId := EmptyStr;
  FDeviceToken := EmptyStr;

{$IFDEF IOS}
  AServiceName := TPushService.TServiceNames.APS;
{$ENDIF}
{$IFDEF ANDROID}
{$IF CompilerVersion >= 34.0}
  AServiceName := TPushService.TServiceNames.FCM;
{$ELSE}
  AServiceName := TPushService.TServiceNames.GCM;
{$ENDIF}
{$ENDIF}
  FPushService := TPushServiceManager.Instance.GetServiceByName(AServiceName);

  if not Assigned(FPushService) then
    raise Exception.Create('TPushNotification.Create FPushServer nil');

  FPushServiceConnection := TPushServiceConnection.Create(FPushService);
  FPushServiceConnection.Active := True;
  FPushServiceConnection.OnChange := DoChangeEvent;
  FPushServiceConnection.OnReceiveNotification := DoReceiveNotificationEvent;

  FDeviceId := FPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceId];
  FDeviceToken := FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
end;

destructor TPushNotificationReceiver.Destroy;
begin
  FOnReceiveNotificationEvent := nil;
  FDoDeviceTokenHasBeenTaken := nil;
  if Assigned(FPushServiceConnection) then
  begin
    FPushServiceConnection.Active := False;
    FPushServiceConnection.OnChange := nil;
    FPushServiceConnection.OnReceiveNotification := nil;
  end;
  FreeAndNil(FPushServiceConnection);
  FreeAndNil(FPushService);
  inherited;
end;

procedure TPushNotificationReceiver.DoChangeEvent(Sender: TObject;
  AChange: TPushService.TChanges);
begin
  if (TPushService.TChange.Status in AChange) then
  begin
    if FPushService.Status = TPushService.TStatus.StartupError then
      raise Exception.Create('TPushNotificationReceiver.DoChangeEvent ' + FPushService.StartupError);
  end;
  if (TPushService.TChange.DeviceToken in AChange) and (FDeviceToken.Trim.IsEmpty) then
    SetDeviceToken(FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken]);
end;

procedure TPushNotificationReceiver.DoReceiveNotificationEvent(Sender: TObject;
  const ANotification: TPushServiceNotification);
begin
  if Assigned(FOnReceiveNotificationEvent) then
    FOnReceiveNotificationEvent(ANotification.JSON.ToString);
end;

function TPushNotificationReceiver.GetActive: Boolean;
begin
  Result := False;
  if Assigned(FPushServiceConnection) then
    Result := FPushServiceConnection.Active;
end;

class function TPushNotificationReceiver.GetPushNotification: TPushNotificationReceiver;
begin
  if not Assigned(FPushNotification) then
  begin
    try
      FPushNotification := TPushNotificationReceiver.Create;
    except
      FreeAndNil(FPushNotification);
      raise;
    end;
  end;
  Result := FPushNotification;
end;

function TPushNotificationReceiver.GetStartupNotifications: TArray<string>;
var
  i: Integer;
begin
  SetLength(Result, 0);

  for i := 0 to Pred(Length(FPushService.StartupNotifications)) do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[i] := FPushService.StartupNotifications[i].JSON.ToString
  end;

  // SetLength(FPushService.StartupNotifications, 0);
end;

procedure TPushNotificationReceiver.SetActive(const Value: Boolean);
begin
  if Assigned(FPushServiceConnection) then
    FPushServiceConnection.Active  := Value;
end;

procedure TPushNotificationReceiver.SetDeviceToken(const Value: string);
begin
  FDeviceToken := Value;
  if Assigned(FDoDeviceTokenHasBeenTaken) then
    FDoDeviceTokenHasBeenTaken;
end;

function TPushNotificationReceiver.StartupNotificationsStr: string;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to Pred(Length(StartupNotifications)) do
  begin
    Result := Result + #13 + StartupNotifications[i]
  end;
end;

{ TPushNotificationSender }

constructor TPushNotificationSender.Create;
begin
  FSenderId := EmptyStr;
  FApiKey := EmptyStr;
end;

destructor TPushNotificationSender.Destroy;
begin

  inherited;
end;

class function TPushNotificationSender.GetPushNotification: TPushNotificationSender;
begin
  if not Assigned(FPushNotification) then
  begin
    try
      FPushNotification := TPushNotificationSender.Create;
    except
      FreeAndNil(FPushNotification);
      raise;
    end;
  end;
  Result := FPushNotification;
end;

function TPushNotificationSender.Send(
  const ATitle, AId, ABody: string;
  ATokens, AFields, AValues: TArray<string>;
  const AProcDataBeferoSend, AProcResponse: TProc<string>): string;
var
  LHttpClient: THttpClient;
  LData: TStringStream;
  LResponse: TStringStream;
  LJson: TJSONObject;
  LJsonData: TJSONObject;
  LJsonNotification: TJSONObject;
  LJsonTokens: TJSONArray;
  i: Integer;
  LUrl: string;
begin
  Result := EmptyStr;
  LData := nil;
  LResponse := nil;
  LHttpClient := nil;
  LJsonNotification := nil;
  LJsonTokens := nil;
  LJsonData := nil;
  LJson := nil;
  // {$IF CompilerVersion >= 34.0}
  LUrl := FUrlFcm;
  (* {$ELSE}
    LUrl := FUrlGcm;
    {$ENDIF} *)
  if (Length(AFields) = 0) or (Length(AValues) = 0) or (Length(AFields) <> Length(AValues)) then
    raise Exception.Create('TPushNotificationSender.Send Field x Value is wrong');

  try
    LJsonTokens := TJSONArray.Create;
    for i := 0 to Pred(Length(ATokens)) do
    begin
      if (Length(ATokens) = 0) or (ATokens[i].Trim.IsEmpty) then
        raise Exception.Create('TPushNotificationSender.Send DeviceToken can NOT be empty');
      LJsonTokens.Add(ATokens[i]);
    end;

    LJsonData := TJSONObject.Create;
    for i := 0 to Pred(Length(AFields)) do
    begin
      if not AFields[i].Trim.IsEmpty then
        LJsonData.AddPair(AFields[i], AValues[i]);
    end;

    if not ATitle.Trim.IsEmpty and
      not AId.Trim.IsEmpty and
      not ABody.Trim.IsEmpty
    then
    begin
      LJsonNotification := TJSONObject.Create;
      LJsonNotification.AddPair('title', ATitle);
      LJsonNotification.AddPair('message_id', AId);
      LJsonNotification.AddPair('body', ABody);
    end;

    LJson := TJSONObject.Create;
    LJson.AddPair('registration_ids', LJsonTokens);
    LJson.AddPair('data', LJsonData);
    if Assigned(LJsonNotification) then
      LJson.AddPair('notification', LJsonNotification);

    LData := TStringStream.Create(LJson.ToString, TEncoding.UTF8);
    LData.Position := 0;

    if Assigned(AProcDataBeferoSend) then
      AProcDataBeferoSend(LData.DataString);

    LResponse := TStringStream.Create;
    LHttpClient := THttpClient.Create;
    LHttpClient.ContentType := 'application/json';
    LHttpClient.CustomHeaders['Authorization'] := 'key=' + FApiKey;
    LHttpClient.Post(LUrl, LData, LResponse);
    LResponse.Position := 0;

    Result := LResponse.DataString;

    if Assigned(AProcResponse) then
      AProcResponse(LResponse.DataString);
  finally
    FreeAndNil(LHttpClient);
    FreeAndNil(LData);
    FreeAndNil(LResponse);
    FreeAndNil(LJson); // It releases all JSON within
  end;
end;

function TPushNotificationSender.Send(
  ATokens, AFields, AValues: TArray<string>;
  const AProcDataBeferoSend, AProcResponse: TProc<string>): string;
begin
  Result := EmptyStr;
  {
    Why use a hidden notification?
    Message broadcasting!
    You can send a 'secret' message which you APP will receive it and execute
    something when your APP  is open
    E.g.: You user is looking on the APP for his sales results; a remote saler
    just finished a big sell and it was applied in your DB, so your Server will
    send that hidden notification for all Managers, the APP will receive it and
    read the message, it will find the key or some value which correspond to
    update the sale results.
  }

  Result := Send(EmptyStr, EmptyStr, EmptyStr, ATokens, AFields, AValues, AProcDataBeferoSend, AProcResponse);
end;

initialization

TPushNotificationReceiver.FPushNotification := nil;
TPushNotificationSender.FPushNotification := nil;

finalization

FreeAndNil(TPushNotificationReceiver.FPushNotification);
FreeAndNil(TPushNotificationSender.FPushNotification);

end.
