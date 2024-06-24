unit model.fatura;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient;

type
  Tdmfatura = class(TDataModule)
    memFatura: TFDMemTable;
    memFaturaIDCONTA: TIntegerField;
    memFaturaSITUACAOPROCESSAMENTO: TStringField;
    memFaturaPAGAMENTOEFETUADO: TBooleanField;
    memFaturaPAGAMENTOATRASO: TBooleanField;
    memFaturaDATAVENCIMENTOFATURA: TDateField;
    memFaturaDATAREALVENCIMENTOFATURA: TDateField;
    memFaturaDATAFECHAMENTO: TDateField;
    memFaturaMELHORDATACOMPRA: TDateField;
    memFaturaVALORTOTAL: TFloatField;
    memFaturaVALORPAGAMENTOMINIMO: TFloatField;
    memFaturaSALDOFATURAANTIRIOR: TFloatField;
    memFaturaVALORJUROSATRASO: TFloatField;
    memFaturaVALORTOTALJUROSATUALIZADO: TFloatField;
    FDMemTable1: TFDMemTable;
    FDMemTable1imagem: TBlobField;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1IDCONTA: TIntegerField;
    ClientDataSet1SITUACAOPROCESSAMENTO: TStringField;
    ClientDataSet1PAGAMENTOEFETUADO: TBooleanField;
    ClientDataSet1PAGAMENTOATRASO: TBooleanField;
    ClientDataSet1DATAVENCIMENTOFATURA: TDateField;
    ClientDataSet1DATAFECHAMENTO: TDateField;
    ClientDataSet1MELHORDATACOMPRA: TDateField;
    ClientDataSet1VALORTOTAL: TFloatField;
    ClientDataSet1VALORPAGAMENTOMINIMO: TFloatField;
    ClientDataSet1SALDOFATURAANTIRIOR: TFloatField;
    ClientDataSet1VALORTOTALJUROSATUALIZADO: TFloatField;
    ClientDataSet1VALORJUROSATRASO: TFloatField;
    memEmprestimo: TFDMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    BooleanField1: TBooleanField;
    BooleanField2: TBooleanField;
    DateField1: TDateField;
    DateField2: TDateField;
    DateField3: TDateField;
    DateField4: TDateField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    memParcelas: TFDMemTable;
    memParcelasnumeroOperacao: TStringField;
    memParcelasnumeroParcela: TIntegerField;
    memParcelasdataVencimentoParcela: TDateField;
    memParcelasvalorPago: TFloatField;
    memParcelassaldoAtual: TFloatField;
    memParcelassituacao: TStringField;
    memParcelasvalorParcela: TFloatField;
    memParcelasvalorFinalEncargos: TFloatField;
    memParcelasboletoRegistrado: TBooleanField;
    memExtratoDetalhado: TFDMemTable;
    memExtratoDetalhadoDATA_COMPRA: TStringField;
    memExtratoDetalhadoDESCRICAO: TStringField;
    memExtratoDetalhadoPARCELAS: TStringField;
    memExtratoDetalhadoVALOR: TStringField;
    memExtratoDetalhadoDATA: TDateField;
    cdsExtrato: TClientDataSet;
    cdsExtratoDATA_COMPRA: TStringField;
    cdsExtratoDATA: TDateTimeField;
    cdsExtratoPARCELAS: TStringField;
    cdsExtratoVALOR: TStringField;
    cdsExtratoDESCRICAO: TStringField;
    memExtratoCashBack: TFDMemTable;
    memExtratoCashBackDATA: TDateTimeField;
    memExtratoCashBackVALOR: TFloatField;
    memExtratoCashBackDEESCRICAO: TStringField;
    memExtratoCashBackMOVIMENTO: TStringField;
    memParcelasdataLiquidacaoParcela: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmfatura: Tdmfatura;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.