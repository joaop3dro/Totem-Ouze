unit IdeaL.Lib.View.TabControl;

{
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Thanks a million to Carlos Henrique Modesto who built 99.99% of the code,
  whitout him, it wouldn't be possible to have this solution
  https://github.com/carloshe
}

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Generics.Collections, FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms,
  FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMX.Ani, FMX.Objects,
  FMX.Controls.Presentation;

type
  TOnboardingDirection = (Undefined, ToLeft, ToRight);

  TIdeaLTabDot = class(TLayout)
  private
    FDot: TCircle;
    function GetColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
    { private declarations }
  protected
    { protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property Dot: TCircle read FDot;
    property Color: TAlphaColor read GetColor write SetColor;
    { public declarations }
  end;

  TIdeaLTabItem = class
  private
    FControl: TControl;
    FDot: TIdeaLTabDot;
    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
    { private declarations }
  protected
    { protected declarations }
  public
    constructor Create;
    destructor Destroy; override;

    property Control: TControl read FControl write FControl;
    property Dot: TIdeaLTabDot read FDot;

    property Enabled: Boolean read GetEnabled write SetEnabled;
    { public declarations }
  end;

  TIdeaLTabControl = class(TFrame)
    Viewport: TLayout;
    FloatAnimation: TFloatAnimation;
    FloatAnimationView: TFloatAnimation;
    lytBottom: TLayout;
    lytBottomCenter: TLayout;
    procedure FrameResize(Sender: TObject);
    procedure FrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FrameMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FrameMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure FramePainting(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure lytBottomCenterPainting(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure FrameMouseLeave(Sender: TObject);
  private
    FItems: TObjectList<TIdeaLTabItem>;
    FIsMouseDown: Boolean;
    FLastMouseXPos: Single;
    FLastOnboardingDirection: TOnboardingDirection;
    FIndex: Integer;
    FDotColorEnabled: TAlphaColor;
    FDotColorDisanabled: TAlphaColor;
    FOnChange: TNotifyEvent;

    procedure ToIndex(AIndex: Integer);
    procedure SetDotColorEnabled(const Value: TAlphaColor);
    procedure SetDotColorDisanabled(const Value: TAlphaColor);
    function GetTabCount: Integer;
    function GetTabActive: TIdeaLTabItem;
    procedure SetTabActive(const Value: TIdeaLTabItem);
    function GetTabActiveControl: TControl;
    procedure SetTabActiveControl(const Value: TControl);
    { Private declarations }
  protected
    procedure DoOnChange(Sender: TObject);
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DotColorEnabled: TAlphaColor read FDotColorEnabled write SetDotColorEnabled;
    property DotColorDisanabled: TAlphaColor read FDotColorDisanabled write SetDotColorDisanabled;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property TabActive: TIdeaLTabItem read GetTabActive write SetTabActive;
    property TabActiveControl: TControl read GetTabActiveControl write SetTabActiveControl;
    property TabIndex: Integer read FIndex;
    property TabCount: Integer read GetTabCount;

    procedure AddItem(AItem: TIdeaLTabItem); overload;
    procedure AddItem(AControl: TControl); overload;

    /// <summary> Call this method after adding all firts Tabs
    /// </summary>
    procedure Start;
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TIdeaLTabControl }

procedure TIdeaLTabControl.AddItem(AItem: TIdeaLTabItem);
begin
  if (not Assigned(AItem)) or (not Assigned(AItem.Control)) then
    Exit;
  if FItems.IndexOf(AItem) = -1 then
  begin
    AItem.Control.Position.X := Self.Width * FItems.Count;
    AItem.Control.Width := Self.Width;
    AItem.Control.Align := TAlignLayout.Left;
    AItem.Control.Parent := Viewport;

    AItem.Dot.Parent := lytBottomCenter;
    AItem.Dot.Align := TAlignLayout.Left;
    AItem.Dot.Height := lytBottomCenter.Height;
    AItem.Dot.Width := AItem.Dot.Height;
    AItem.Dot.Position.X := lytBottomCenter.Height * FItems.Count;
    AItem.Dot.Color := FDotColorDisanabled;

    FItems.Add(AItem);
  end;
end;

procedure TIdeaLTabControl.AddItem(AControl: TControl);
begin
  if not Assigned(AControl) then
    Exit;
  var LItem := TIdeaLTabItem.Create;
  LItem.Control := AControl;
  AddItem(LItem);
end;

constructor TIdeaLTabControl.Create(AOwner: TComponent);
begin
  inherited;
  FOnChange := nil;
  FItems := TObjectList<TIdeaLTabItem>.Create;
  FDotColorEnabled := TAlphaColorRec.Black;
  FDotColorDisanabled := TAlphaColorRec.Gray;
end;

destructor TIdeaLTabControl.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TIdeaLTabControl.DoOnChange(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Sender);
end;

procedure TIdeaLTabControl.FrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FloatAnimation.Stop;
  FIsMouseDown := True;
  FLastMouseXPos := X;
  FLastOnboardingDirection := TOnboardingDirection.Undefined;
end;

procedure TIdeaLTabControl.FrameMouseLeave(Sender: TObject);
var
  LDistance: Single;
  LDistValue: Single;
begin
  if FIsMouseDown then
  begin
    FIsMouseDown := False;
    LDistance := Viewport.Position.X + FIndex * Self.Width;
    LDistValue := 100;
    if (FLastOnboardingDirection = TOnboardingDirection.ToRight) and (LDistance > LDistValue) then
      ToIndex(FIndex - 1)
    else if (FLastOnboardingDirection = TOnboardingDirection.ToLeft) and (LDistance < (LDistValue * -1)) then
      ToIndex(FIndex + 1)
    else
      ToIndex(FIndex);
  end;
end;

procedure TIdeaLTabControl.FrameMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  LDistance: Single;
begin
  if FIsMouseDown then
  begin
    LDistance := Viewport.Position.X + FIndex * Self.Width;
    if Abs(LDistance) < Self.Width + 100 then
    begin
      Viewport.Position.X := Viewport.Position.X - FLastMouseXPos + X;
    end;
    if X > FLastMouseXPos then
      FLastOnboardingDirection := TOnboardingDirection.ToRight
    else if X < FLastMouseXPos then
      FLastOnboardingDirection := TOnboardingDirection.ToLeft
    else
      FLastOnboardingDirection := TOnboardingDirection.Undefined;
    FLastMouseXPos := X;
  end;
end;

procedure TIdeaLTabControl.FrameMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FrameMouseLeave(Sender);
end;

procedure TIdeaLTabControl.FramePainting(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
  Viewport.Height := lytBottom.Position.Y - 5;

  if Self.Tag <> 0 then
    Exit;
  Self.Tag := 1;

  FrameResize(Self);
end;

procedure TIdeaLTabControl.FrameResize(Sender: TObject);
var
  I: Integer;
begin
  Viewport.Position.Y := 0;
  Viewport.Position.X := (FIndex * Self.Width) *  - 1;
  Viewport.Width := Self.Width * FItems.Count;
  FloatAnimation.StopValue := (FIndex * Self.Width) *  - 1;

  for I := 0 to FItems.Count - 1 do
  begin
    if Assigned(FItems.Items[I].Control) then
    begin
      FItems.Items[I].Control.Width := Self.Width;
      FItems.Items[I].Control.Height := Viewport.Height;
    end;
  end;
end;

function TIdeaLTabControl.GetTabActive: TIdeaLTabItem;
begin
  Result := nil;
  if (FIndex >= 0) and (FIndex < FItems.Count) then
  begin
    Result := FItems.Items[FIndex];
  end
  else if (FItems.Count > 0) then
    Result := FItems.Items[0];
end;

function TIdeaLTabControl.GetTabActiveControl: TControl;
begin
  Result := nil;
  var
  LTab := GetTabActive;
  if not Assigned(LTab) then
    Exit;
  Result := LTab.Control;
end;

function TIdeaLTabControl.GetTabCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TIdeaLTabControl.lytBottomCenterPainting(Sender: TObject;
  Canvas: TCanvas; const ARect: TRectF);
begin
  lytBottomCenter.Width := FItems.Count * lytBottomCenter.Height;
end;

procedure TIdeaLTabControl.SetDotColorDisanabled(const Value: TAlphaColor);
begin
  FDotColorDisanabled := Value;
  for var i := 0 to Pred(FItems.Count) do
  begin
    if i <> FIndex then
    begin
      FItems.Items[i].Dot.Color := FDotColorDisanabled;
      FItems.Items[i].Enabled := False;
    end;
  end;
end;

procedure TIdeaLTabControl.SetDotColorEnabled(const Value: TAlphaColor);
begin
  FDotColorEnabled := Value;
  if (FIndex >= 0) and (FIndex < FItems.Count) then
  begin
    FItems.Items[FIndex].Dot.Color := FDotColorEnabled;
    FItems.Items[FIndex].Enabled := True;
  end;
end;

procedure TIdeaLTabControl.SetTabActive(const Value: TIdeaLTabItem);
begin
  for var i := 0 to Pred(FItems.Count) do
  begin
    if FItems.Items[i] = Value then
    begin
      ToIndex(i);
      Break;
    end;
  end;
end;

procedure TIdeaLTabControl.SetTabActiveControl(const Value: TControl);
begin
  for var i := 0 to Pred(FItems.Count) do
  begin
    if FItems.Items[i].Control = Value then
    begin
      ToIndex(i);
      Break;
    end;
  end;
end;

procedure TIdeaLTabControl.Start;
begin
  for var i := 0 to Pred(FItems.Count) do
  begin
    FItems.Items[i].Dot.Color := FDotColorDisanabled;
    FItems.Items[i].Enabled := False;
  end;
  ToIndex(0);
end;

procedure TIdeaLTabControl.ToIndex(AIndex: Integer);
begin
  if (AIndex >= 0) and (AIndex < FItems.Count) then
  begin
    FItems.Items[FIndex].Dot.Color := FDotColorDisanabled;
    FItems.Items[FIndex].Enabled := False;
    FIndex := AIndex;
  end;

  FloatAnimation.StartValue := Viewport.Position.X;
  FloatAnimation.StopValue := (FIndex * Self.Width) *  - 1;
  FloatAnimation.Start;

  FItems.Items[FIndex].Dot.Color := FDotColorEnabled;
  FItems.Items[FIndex].Enabled := True;
  DoOnChange(Self);
end;

{ TIdeaLTabItem }

constructor TIdeaLTabItem.Create;
begin
  FControl := nil;
  FDot := TIdeaLTabDot.Create(nil);
end;

destructor TIdeaLTabItem.Destroy;
begin
  if Assigned(FControl) then
    FControl.Parent := nil;
  FControl := nil;
  inherited;
end;

function TIdeaLTabItem.GetEnabled: Boolean;
begin
  Result := Dot.Margins.Bottom = 0;  
end;

procedure TIdeaLTabItem.SetEnabled(const Value: Boolean);
begin
  var
  LMargim := 2;
  if Value then
    LMargim := 0;
  FDot.Dot.Margins.Bottom := LMargim;
  FDot.Dot.Margins.Left := LMargim;
  FDot.Dot.Margins.Right := LMargim;
  FDot.Dot.Margins.Top := LMargim;
end;

{ TIdeaLTabDot }

constructor TIdeaLTabDot.Create(AOwner: TComponent);
begin
  inherited;
  FDot := TCircle.Create(Self);
  Color := TAlphaColorRec.Black;
  FDot.Margins.Bottom := 2;
  FDot.Margins.Left := 2;
  FDot.Margins.Right := 2;
  FDot.Margins.Top := 2;
  FDot.Align := TAlignLayout.Contents;
  FDot.Parent := Self;
  FDot.Stroke.Thickness := 3;
end;

function TIdeaLTabDot.GetColor: TAlphaColor;
begin
  Result := FDot.Fill.Color;
end;

procedure TIdeaLTabDot.SetColor(const Value: TAlphaColor);
begin
  FDot.Fill.Color := Value;
  FDot.Stroke.Color := Value;
end;

end.

