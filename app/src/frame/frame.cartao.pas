unit frame.cartao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Skia, FMX.Objects, FMX.Layouts, System.Skia;

type
  TframeCartao = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    ImgVisa: TImage;
    SkLabel1: TSkLabel;
    lblPortador: TSkLabel;
    SkLabel2: TSkLabel;
    Layout2: TLayout;
    lblNumCartao: TSkLabel;
    Layout3: TLayout;
    SkSvg1: TSkSvg;
    imgStz: TImage;
    procedure OnClickDefault(Sender: TObject);
   private
    FIdentify: string;
    FFrmBase: TFrame;
    procedure SetIdentify(const Value: string);
    { Private declarations }
  protected
    FExtraHeight: Single;
    FOriginalHeight: Single;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property Identify: string read FIdentify write SetIdentify;
    procedure SetDefaultClick(AEvent: TNotifyEvent);
    procedure SetDefaultTap(AEvent: TTapEvent);
  end;

implementation

{$R *.fmx}

constructor TframeCartao.Create(AOwner: TComponent);
begin
  inherited;
  FIdentify := EmptyStr;
//  rctBackground.Visible := False;
  FOriginalHeight := Self.Height;
  FExtraHeight := 0;
  FFrmBase := nil;
//  btnSetFocus.Position.Y := -100;
//  btnSetFocus.Position.X := -100;
end;

procedure TframeCartao.OnClickDefault(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  if Sender.InheritsFrom(TControl) and (Assigned(TControl(Sender).OnTap)) then
    TControl(Sender).OnTap(Sender, TPointF.Create(0, 0));
{$ENDIF}
end;

procedure TframeCartao.SetDefaultClick(AEvent: TNotifyEvent);
begin
//  rctBackground.OnClick := AEvent;
//   TFrameItemListModel

  Rectangle1.Visible := false;
end;
procedure TframeCartao.SetDefaultTap(AEvent: TTapEvent);
begin
//  rctBackground.OnTap := AEvent;
  Rectangle1.Visible := false;
end;


procedure TframeCartao.SetIdentify(const Value: string);
begin
  FIdentify := Value;
end;

end.
