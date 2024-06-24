object dmfatura: Tdmfatura
  Height = 241
  Width = 551
  object memFatura: TFDMemTable
    FetchOptions.AssignedValues = [evMode, evCursorKind]
    FetchOptions.Mode = fmAll
    FetchOptions.CursorKind = ckDefault
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 64
    Top = 40
    object memFaturaIDCONTA: TIntegerField
      FieldName = 'IDCONTA'
    end
    object memFaturaSITUACAOPROCESSAMENTO: TStringField
      FieldName = 'SITUACAOPROCESSAMENTO'
      Size = 40
    end
    object memFaturaPAGAMENTOEFETUADO: TBooleanField
      FieldName = 'PAGAMENTOEFETUADO'
    end
    object memFaturaPAGAMENTOATRASO: TBooleanField
      FieldName = 'PAGAMENTOATRASO'
    end
    object memFaturaDATAVENCIMENTOFATURA: TDateField
      FieldName = 'DATAVENCIMENTOFATURA'
    end
    object memFaturaDATAREALVENCIMENTOFATURA: TDateField
      FieldName = 'DATAREALVENCIMENTOFATURA'
    end
    object memFaturaDATAFECHAMENTO: TDateField
      FieldName = 'DATAFECHAMENTO'
    end
    object memFaturaMELHORDATACOMPRA: TDateField
      FieldName = 'MELHORDATACOMPRA'
    end
    object memFaturaVALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
    end
    object memFaturaVALORPAGAMENTOMINIMO: TFloatField
      FieldName = 'VALORPAGAMENTOMINIMO'
    end
    object memFaturaSALDOFATURAANTIRIOR: TFloatField
      FieldName = 'SALDOFATURAANTIRIOR'
    end
    object memFaturaVALORJUROSATRASO: TFloatField
      FieldName = 'VALORJUROSATRASO'
    end
    object memFaturaVALORTOTALJUROSATUALIZADO: TFloatField
      FieldName = 'VALORTOTALJUROSATUALIZADO'
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 64
    Top = 112
    object FDMemTable1imagem: TBlobField
      FieldName = 'imagem'
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 40
    object ClientDataSet1IDCONTA: TIntegerField
      FieldName = 'IDCONTA'
    end
    object ClientDataSet1SITUACAOPROCESSAMENTO: TStringField
      FieldName = 'SITUACAOPROCESSAMENTO'
    end
    object ClientDataSet1PAGAMENTOEFETUADO: TBooleanField
      FieldName = 'PAGAMENTOEFETUADO'
    end
    object ClientDataSet1PAGAMENTOATRASO: TBooleanField
      FieldName = 'PAGAMENTOATRASO'
    end
    object ClientDataSet1DATAVENCIMENTOFATURA: TDateField
      FieldName = 'DATAVENCIMENTOFATURA'
    end
    object ClientDataSet1DATAFECHAMENTO: TDateField
      FieldName = 'DATAFECHAMENTO'
    end
    object ClientDataSet1MELHORDATACOMPRA: TDateField
      FieldName = 'MELHORDATACOMPRA'
    end
    object ClientDataSet1VALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
    end
    object ClientDataSet1VALORPAGAMENTOMINIMO: TFloatField
      FieldName = 'VALORPAGAMENTOMINIMO'
    end
    object ClientDataSet1SALDOFATURAANTIRIOR: TFloatField
      FieldName = 'SALDOFATURAANTIRIOR'
    end
    object ClientDataSet1VALORTOTALJUROSATUALIZADO: TFloatField
      FieldName = 'VALORTOTALJUROSATUALIZADO'
    end
    object ClientDataSet1VALORJUROSATRASO: TFloatField
      FieldName = 'VALORJUROSATRASO'
    end
  end
  object memEmprestimo: TFDMemTable
    FetchOptions.AssignedValues = [evMode, evCursorKind]
    FetchOptions.Mode = fmAll
    FetchOptions.CursorKind = ckDefault
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 200
    Top = 112
    object IntegerField1: TIntegerField
      FieldName = 'IDCONTA'
    end
    object StringField1: TStringField
      FieldName = 'SITUACAOPROCESSAMENTO'
      Size = 40
    end
    object BooleanField1: TBooleanField
      FieldName = 'PAGAMENTOEFETUADO'
    end
    object BooleanField2: TBooleanField
      FieldName = 'PAGAMENTOATRASO'
    end
    object DateField1: TDateField
      FieldName = 'DATAVENCIMENTOFATURA'
    end
    object DateField2: TDateField
      FieldName = 'DATAREALVENCIMENTOFATURA'
    end
    object DateField3: TDateField
      FieldName = 'DATAFECHAMENTO'
    end
    object DateField4: TDateField
      FieldName = 'MELHORDATACOMPRA'
    end
    object FloatField1: TFloatField
      FieldName = 'VALORTOTAL'
    end
    object FloatField2: TFloatField
      FieldName = 'VALORPAGAMENTOMINIMO'
    end
    object FloatField3: TFloatField
      FieldName = 'SALDOFATURAANTIRIOR'
    end
    object FloatField4: TFloatField
      FieldName = 'VALORJUROSATRASO'
    end
    object FloatField5: TFloatField
      FieldName = 'VALORTOTALJUROSATUALIZADO'
    end
  end
  object memParcelas: TFDMemTable
    FetchOptions.AssignedValues = [evMode, evCursorKind]
    FetchOptions.Mode = fmAll
    FetchOptions.CursorKind = ckDefault
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 320
    Top = 112
    object memParcelasnumeroOperacao: TStringField
      FieldName = 'numeroOperacao'
    end
    object memParcelasnumeroParcela: TIntegerField
      FieldName = 'numeroParcela'
    end
    object memParcelasdataVencimentoParcela: TDateField
      FieldName = 'dataVencimentoParcela'
    end
    object memParcelasvalorPago: TFloatField
      FieldName = 'valorPago'
    end
    object memParcelassaldoAtual: TFloatField
      FieldName = 'saldoAtual'
    end
    object memParcelassituacao: TStringField
      FieldName = 'situacao'
    end
    object memParcelasvalorParcela: TFloatField
      FieldName = 'valorParcela'
    end
    object memParcelasvalorFinalEncargos: TFloatField
      FieldName = 'valorFinalEncargos'
    end
    object memParcelasboletoRegistrado: TBooleanField
      FieldName = 'boletoRegistrado'
    end
    object memParcelasdataLiquidacaoParcela: TDateField
      FieldName = 'dataLiquidacaoParcela'
    end
  end
  object memExtratoDetalhado: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 440
    Top = 112
    object memExtratoDetalhadoDATA_COMPRA: TStringField
      FieldName = 'DATA_COMPRA'
      Size = 10
    end
    object memExtratoDetalhadoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object memExtratoDetalhadoPARCELAS: TStringField
      FieldName = 'PARCELAS'
      Size = 15
    end
    object memExtratoDetalhadoVALOR: TStringField
      FieldName = 'VALOR'
      Size = 255
    end
    object memExtratoDetalhadoDATA: TDateField
      FieldName = 'DATA'
    end
  end
  object cdsExtrato: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsExtratoIndex3'
        Fields = 'DATA'
        Options = [ixDescending]
      end>
    Params = <>
    StoreDefs = True
    Left = 456
    Top = 48
    object cdsExtratoDATA_COMPRA: TStringField
      FieldName = 'DATA_COMPRA'
    end
    object cdsExtratoDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object cdsExtratoPARCELAS: TStringField
      FieldName = 'PARCELAS'
    end
    object cdsExtratoVALOR: TStringField
      FieldName = 'VALOR'
    end
    object cdsExtratoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
  end
  object memExtratoCashBack: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 440
    Top = 168
    object memExtratoCashBackDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object memExtratoCashBackVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object memExtratoCashBackDEESCRICAO: TStringField
      FieldName = 'DEESCRICAO'
      Size = 100
    end
    object memExtratoCashBackMOVIMENTO: TStringField
      FieldName = 'MOVIMENTO'
      Size = 100
    end
  end
end
