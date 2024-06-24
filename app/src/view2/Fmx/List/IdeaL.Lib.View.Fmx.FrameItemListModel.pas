unit IdeaL.Lib.View.Fmx.FrameItemListModel;
interface
uses
  System.SysUtils,
  System.Types,
  System.UIConsts,
  System.UITypes,
  System.Classes,
  System.Variants,
  Fmx.Types,
  Fmx.Graphics,
  Fmx.Controls,
  Fmx.Forms,
  Fmx.Dialogs,
  Fmx.StdCtrls,
  Fmx.Objects,
  Fmx.Layouts,
  Fmx.Controls.Presentation, System.Skia, FMX.Skia, uGosObjects, FMX.ListBox;
type
  TFrameItemListModel = class(TFrame)
    Rectangle2: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    lbltitulo: TSkLabel;
    lblValor: TSkLabel;
    recMes: TRectangle;
    lblmes: TSkLabel;
    Layout5: TLayout;
    SkLabel5: TSkLabel;
    lblDataVencimento: TSkLabel;
    GosLine1: TGosLine;
    Layout3: TLayout;
    SkLabel2: TSkLabel;
    lbldataPagamento: TSkLabel;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    SkLabel41: TSkLabel;
    Rectangle1: TRectangle;
    ListBox1: TListBox;
    Item1: TListBoxItem;
    Item2: TListBoxItem;
    Item3: TListBoxItem;
    recItem1: TRectangle;
    Layout8: TLayout;
    recCor1: TRectangle;
    label1: TSkLabel;
    svgIcon1: TSkSvg;
    Layout9: TLayout;
    lblNameProduct1: TSkLabel;
    recItem2: TRectangle;
    Layout10: TLayout;
    recCor2: TRectangle;
    label2: TSkLabel;
    svgIcon2: TSkSvg;
    Layout11: TLayout;
    lblNameProduct2: TSkLabel;
    recItem3: TRectangle;
    Layout12: TLayout;
    recCor3: TRectangle;
    label3: TSkLabel;
    svgIcon3: TSkSvg;
    Layout13: TLayout;
    lblNameProduct3: TSkLabel;
    Rectangle12: TRectangle;
    ItemOutros: TListBoxItem;
    recItemOutros: TRectangle;
    Layout14: TLayout;
    SkSvg4: TSkSvg;
    SkLabel7: TSkLabel;
    Layout15: TLayout;
    SkSvg5: TSkSvg;
    Rectangle3: TRectangle;
    lbCobertura: TListBox;
    CItem1: TListBoxItem;
    CItem2: TListBoxItem;
    CItem3: TListBoxItem;
    CItem4: TListBoxItem;
    CItem5: TListBoxItem;
    CItem6: TListBoxItem;
    CItem7: TListBoxItem;
    CItem8: TListBoxItem;
    CItem9: TListBoxItem;
    CItem10: TListBoxItem;
    CItem11: TListBoxItem;
    CItem12: TListBoxItem;
    CItem13: TListBoxItem;
    CItem14: TListBoxItem;
    CItem15: TListBoxItem;
    CItem16: TListBoxItem;
    CItem17: TListBoxItem;
    CItem18: TListBoxItem;
    CItem19: TListBoxItem;
    CItem20: TListBoxItem;
    CItem21: TListBoxItem;
    CItem22: TListBoxItem;
    CItem23: TListBoxItem;
    CItem24: TListBoxItem;
    CItem25: TListBoxItem;
    CItem26: TListBoxItem;
    CItem27: TListBoxItem;
    CItem28: TListBoxItem;
    CItem29: TListBoxItem;
    Layout75: TLayout;
    Layout76: TLayout;
    Rectangle34: TRectangle;
    SkSvg36: TSkSvg;
    Rectangle35: TRectangle;
    SkSvg37: TSkSvg;
    SkLabel4: TSkLabel;
    SkLabel6: TSkLabel;
    loading: TSkAnimatedImage;
    recLoading: TRectangle;
    Layout16: TLayout;
    SkLabel8: TSkLabel;
    lylMaisSeguros: TLayout;
    ListBox2: TListBox;
    Rectangle4: TRectangle;
    imgStz: TImage;
    ImgVisa: TImage;
    Layout4: TLayout;
    SkLabel1: TSkLabel;
    lblPortador: TSkLabel;
    Layout6: TLayout;
    SkLabel3: TSkLabel;
    lblNumCartao: TSkLabel;
    Layout7: TLayout;
    SkSvg1: TSkSvg;
    Rectangle5: TRectangle;
    lbMenu: TListBox;
    lbMenu3: TListBox;
    lbMenu2: TListBox;
    procedure OnClickDefault(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
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

    // To store what is the Frame where it is being shwon
//    property FrmBase: TFrame read FFrmBase write SetFrmBase;
    { Public declarations }
  end;
implementation
{$R *.fmx}
{ TFrameItemListModel }

constructor TFrameItemListModel.Create(AOwner: TComponent);
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

procedure TFrameItemListModel.OnClickDefault(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  if Sender.InheritsFrom(TControl) and (Assigned(TControl(Sender).OnTap)) then
    TControl(Sender).OnTap(Sender, TPointF.Create(0, 0));
{$ENDIF}
end;
procedure TFrameItemListModel.Rectangle1Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if Sender.InheritsFrom(TControl) and (Assigned(TControl(Sender).OnTap)) then
    TControl(Sender).OnTap(Sender, TPointF.Create(0, 0));
{$ENDIF}
end;

procedure TFrameItemListModel.SetDefaultClick(AEvent: TNotifyEvent);
begin
//  rctBackground.OnClick := AEvent;
//   TFrameItemListModel

  Rectangle2.Visible := false;
end;
procedure TFrameItemListModel.SetDefaultTap(AEvent: TTapEvent);
begin
//  rctBackground.OnTap := AEvent;
  Rectangle2.Visible := false;
end;

procedure TFrameItemListModel.SetIdentify(const Value: string);
begin
  FIdentify := Value;
end;

end.

