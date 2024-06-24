unit frame.menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Layouts, FMX.Skia, FMX.Objects;

type
  TframeMenu = class(TFrame)
    recSeguro: TRectangle;
    SVGSeguro: TSkSvg;
    lblTitulo: TSkLabel;
    Layout11: TLayout;
    SkSvg12: TSkSvg;
    Layout1: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
