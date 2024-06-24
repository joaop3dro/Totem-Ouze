unit frame.Fatura;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,

  System.Skia,
  uGosObjects,
  FMX.Skia,
  FMX.Layouts;

type
  TframeFatura = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    lbltitulo: TSkLabel;
    lblValor: TSkLabel;
    recMes: TRectangle;
    lblmes: TSkLabel;
    Layout5: TLayout;
    GosLine1: TGosLine;
    SkLabel5: TSkLabel;
    lblDataVencimento: TSkLabel;
    Layout3: TLayout;
    SkLabel2: TSkLabel;
    lbldataPagamento: TSkLabel;
    Layout45: TLayout;
    SkSvg15: TSkSvg;
    SkLabel41: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrameFatura: TframeFatura;

implementation

{$R *.fmx}

end.
