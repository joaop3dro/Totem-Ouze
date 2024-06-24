unit frame.seguros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Objects, uGosObjects, FMX.Layouts;

type
  TframeSeguros = class(TFrame)
    Rectangle2: TRectangle;
    Layout1: TLayout;
    recAtivo: TRectangle;
    lblContratado: TSkLabel;
    svgIcon: TSkSvg;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    SkSvg2: TSkSvg;
    SkLabel1: TSkLabel;
    lblNameProduct: TSkLabel;
    Layout3: TLayout;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
