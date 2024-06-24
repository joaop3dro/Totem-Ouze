unit model.boleto;

interface

uses
  System.SysUtils, System.Classes, ACBrBase, ACBrPIXBase, ACBrJSON, ACBrBoleto, ACBrBoletoFCFortesFr,
  ACBrMaily, ACBrMail;

type
  TdmBoleto = class(TDataModule)
    ACBrBoleto: TACBrBoleto;
    ACBrBoletoReport: TACBrBoletoFCFortes;
    ACBrMail1: TACBrMail;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmBoleto: TdmBoleto;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
