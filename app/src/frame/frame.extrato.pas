unit frame.extrato;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, System.Skia, FMX.Skia, FMX.Layouts;

type
  TframeExtrato = class(TFrame)
    lblData: TSkLabel;
    Rectangle2: TRectangle;
    lblLocal: TSkLabel;
    lblParcelas: TSkLabel;
    Rectangle3: TRectangle;
    lblValor: TSkLabel;
    Layout1: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
