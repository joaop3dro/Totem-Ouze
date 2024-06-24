unit frame.ContratoEP;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Objects, FMX.Skia, FMX.Layouts;

type
  TframeContratoEP = class(TFrame)
    Layout1: TLayout;
    lblData: TSkLabel;
    Rectangle2: TRectangle;
    lblIDContrato: TSkLabel;
    Rectangle3: TRectangle;
    lblValor: TSkLabel;
    Rectangle1: TRectangle;
    lblStatus: TSkLabel;
    SkSvg15: TSkSvg;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
