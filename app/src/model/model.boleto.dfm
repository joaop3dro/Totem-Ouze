object dmBoleto: TdmBoleto
  Height = 217
  Width = 273
  object ACBrBoleto: TACBrBoleto
    Banco.Numero = 237
    Banco.TamanhoMaximoNossoNum = 11
    Banco.TipoCobranca = cobBradesco
    Banco.LayoutVersaoArquivo = 84
    Banco.LayoutVersaoLote = 42
    Banco.CasasDecimaisMoraJuros = 2
    Banco.DensidadeGravacao = '06250'
    Cedente.Nome = 'TodaObra Materias p/ Construcao'
    Cedente.CodigoCedente = '4266443'
    Cedente.Agencia = '0284'
    Cedente.AgenciaDigito = '5'
    Cedente.Conta = '0079489'
    Cedente.ContaDigito = '9'
    Cedente.CNPJCPF = '05.481.336/0001-37'
    Cedente.TipoInscricao = pJuridica
    Cedente.CedenteWS.ClientID = 'SGCBS02P'
    Cedente.IdentDistribuicao = tbBancoDistribui
    Cedente.PIX.TipoChavePIX = tchNenhuma
    DirArqRemessa = 'c:\temp'
    NumeroArquivo = 0
    ACBrBoletoFC = ACBrBoletoReport
    Configuracoes.Arquivos.LogRegistro = True
    Configuracoes.WebService.SSLHttpLib = httpOpenSSL
    Configuracoes.WebService.StoreName = 'My'
    Configuracoes.WebService.TimeOut = 30000
    Configuracoes.WebService.UseCertificateHTTP = False
    Configuracoes.WebService.Ambiente = taHomologacao
    Configuracoes.WebService.Operacao = tpInclui
    Configuracoes.WebService.VersaoDF = '1.2'
    Left = 48
    Top = 46
  end
  object ACBrBoletoReport: TACBrBoletoFCFortes
    MostrarSetup = False
    SoftwareHouse = 'Projeto ACBr - http://acbr.sf.net'
    DirLogo = '..\..\..\Fontes\ACBrBoleto\Logos\Colorido'
    NomeArquivo = 'boleto.pdf'
    Left = 160
    Top = 54
  end
  object ACBrMail1: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 40
    Top = 112
  end
end
