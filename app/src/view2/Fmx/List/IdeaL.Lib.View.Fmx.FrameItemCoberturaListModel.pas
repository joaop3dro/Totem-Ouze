unit IdeaL.Lib.View.Fmx.FrameItemCoberturaListModel;

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
  TFrameCoberturaListModel = class(TFrame)
    lbCobertura: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    ListBoxItem13: TListBoxItem;
    ListBoxItem14: TListBoxItem;
    ListBoxItem15: TListBoxItem;
    ListBoxItem16: TListBoxItem;
    ListBoxItem17: TListBoxItem;
    ListBoxItem18: TListBoxItem;
    ListBoxItem19: TListBoxItem;
    ListBoxItem20: TListBoxItem;
    ListBoxItem21: TListBoxItem;
    ListBoxItem22: TListBoxItem;
    ListBoxItem23: TListBoxItem;
    ListBoxItem24: TListBoxItem;
    ListBoxItem25: TListBoxItem;
    ListBoxItem26: TListBoxItem;
    ListBoxItem27: TListBoxItem;
    ListBoxItem28: TListBoxItem;
    ListBoxItem29: TListBoxItem;
    Rectangle1: TRectangle;
    Layout8: TLayout;
    svgIcon: TSkSvg;
    Layout9: TLayout;
    lblNameProduct1: TSkLabel;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    SkSvg1: TSkSvg;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    Rectangle3: TRectangle;
    Layout3: TLayout;
    SkSvg2: TSkSvg;
    Layout4: TLayout;
    SkLabel2: TSkLabel;
    Rectangle4: TRectangle;
    Layout5: TLayout;
    SkSvg3: TSkSvg;
    Layout6: TLayout;
    SkLabel3: TSkLabel;
    Rectangle5: TRectangle;
    Layout7: TLayout;
    SkSvg4: TSkSvg;
    Layout10: TLayout;
    SkLabel4: TSkLabel;
    Rectangle6: TRectangle;
    Layout11: TLayout;
    SkSvg5: TSkSvg;
    Layout12: TLayout;
    SkLabel5: TSkLabel;
    Rectangle7: TRectangle;
    Layout13: TLayout;
    SkSvg6: TSkSvg;
    Layout14: TLayout;
    SkLabel6: TSkLabel;
    Rectangle8: TRectangle;
    Layout15: TLayout;
    SkSvg7: TSkSvg;
    Layout16: TLayout;
    SkLabel7: TSkLabel;
    Rectangle9: TRectangle;
    Layout17: TLayout;
    SkSvg8: TSkSvg;
    Layout18: TLayout;
    SkLabel8: TSkLabel;
    Rectangle10: TRectangle;
    Layout19: TLayout;
    SkSvg9: TSkSvg;
    Layout20: TLayout;
    SkLabel9: TSkLabel;
    Rectangle11: TRectangle;
    Layout21: TLayout;
    SkSvg10: TSkSvg;
    Layout22: TLayout;
    SkLabel10: TSkLabel;
    Rectangle12: TRectangle;
    Layout23: TLayout;
    SkSvg11: TSkSvg;
    Layout24: TLayout;
    SkLabel11: TSkLabel;
    Rectangle13: TRectangle;
    Layout25: TLayout;
    SkSvg12: TSkSvg;
    Layout26: TLayout;
    SkLabel12: TSkLabel;
    Rectangle14: TRectangle;
    Layout27: TLayout;
    SkSvg13: TSkSvg;
    Layout28: TLayout;
    SkLabel13: TSkLabel;
    Rectangle15: TRectangle;
    Layout29: TLayout;
    SkSvg14: TSkSvg;
    Layout30: TLayout;
    SkLabel14: TSkLabel;
    Rectangle16: TRectangle;
    Layout31: TLayout;
    SkSvg15: TSkSvg;
    Layout32: TLayout;
    SkLabel15: TSkLabel;
    Rectangle17: TRectangle;
    Layout33: TLayout;
    SkSvg16: TSkSvg;
    Layout34: TLayout;
    SkLabel16: TSkLabel;
    Rectangle18: TRectangle;
    Layout35: TLayout;
    SkSvg17: TSkSvg;
    Layout36: TLayout;
    SkLabel17: TSkLabel;
    Rectangle19: TRectangle;
    Layout37: TLayout;
    SkSvg18: TSkSvg;
    Layout38: TLayout;
    SkLabel18: TSkLabel;
    Rectangle20: TRectangle;
    Layout39: TLayout;
    SkSvg19: TSkSvg;
    Layout40: TLayout;
    SkLabel19: TSkLabel;
    Rectangle21: TRectangle;
    Layout41: TLayout;
    SkSvg20: TSkSvg;
    Layout42: TLayout;
    SkLabel20: TSkLabel;
    Rectangle22: TRectangle;
    Layout43: TLayout;
    SkSvg21: TSkSvg;
    Layout44: TLayout;
    SkLabel21: TSkLabel;
    Rectangle23: TRectangle;
    Layout45: TLayout;
    SkSvg22: TSkSvg;
    Layout46: TLayout;
    SkLabel22: TSkLabel;
    Rectangle24: TRectangle;
    Layout47: TLayout;
    SkSvg23: TSkSvg;
    Layout48: TLayout;
    SkLabel23: TSkLabel;
    Rectangle25: TRectangle;
    Layout49: TLayout;
    SkSvg24: TSkSvg;
    Layout50: TLayout;
    SkLabel24: TSkLabel;
    Rectangle26: TRectangle;
    Layout51: TLayout;
    SkSvg25: TSkSvg;
    Layout52: TLayout;
    SkLabel25: TSkLabel;
    Rectangle27: TRectangle;
    Layout53: TLayout;
    SkSvg26: TSkSvg;
    Layout54: TLayout;
    SkLabel26: TSkLabel;
    Rectangle28: TRectangle;
    Layout55: TLayout;
    SkSvg27: TSkSvg;
    Layout56: TLayout;
    SkLabel27: TSkLabel;
    Rectangle29: TRectangle;
    Layout57: TLayout;
    SkSvg28: TSkSvg;
    Layout58: TLayout;
    SkLabel28: TSkLabel;
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

constructor TFrameCoberturaListModel.Create(AOwner: TComponent);
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

procedure TFrameCoberturaListModel.OnClickDefault(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
  if Sender.InheritsFrom(TControl) and (Assigned(TControl(Sender).OnTap)) then
    TControl(Sender).OnTap(Sender, TPointF.Create(0, 0));
{$ENDIF}
end;

procedure TFrameCoberturaListModel.SetDefaultClick(AEvent: TNotifyEvent);
begin
//  rctBackground.OnClick := AEvent;
//   TFrameItemListModel

//  Rectangle2.Visible := false;
end;
procedure TFrameCoberturaListModel.SetDefaultTap(AEvent: TTapEvent);
begin
//  rctBackground.OnTap := AEvent;
//  Rectangle2.Visible := false;
end;

procedure TFrameCoberturaListModel.SetIdentify(const Value: string);
begin
//  FIdentify := Value;
end;


end.
