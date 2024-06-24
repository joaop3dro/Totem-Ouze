unit frame.ExtratoCashBack;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Objects, FMX.Skia, FMX.Layouts;

type
  TframeCashBack = class(TFrame)
    Layout1: TLayout;
    lblData: TSkLabel;
    lblDescricao: TSkLabel;
    Rectangle2: TRectangle;
    lblMovimento: TSkLabel;
    Rectangle3: TRectangle;
    lblValor: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
