unit frame.cobertura;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Objects, FMX.Layouts;

type
  TframeCobertura = class(TFrame)
    Rectangle4: TRectangle;
    Layout16: TLayout;
    SkSvg6: TSkSvg;
    Layout17: TLayout;
    SkLabel4: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
