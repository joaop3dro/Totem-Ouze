unit frame.parcelas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Objects, uGosObjects, FMX.Layouts;

type
  TframeParcelas = class(TFrame)
    Rectangle1: TRectangle;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
