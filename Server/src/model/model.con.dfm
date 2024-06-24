object DmCon: TDmCon
  OnCreate = DataModuleCreate
  Height = 202
  Width = 347
  object DbConexao: TFDConnection
    Params.Strings = (
      'Server=127.0.0.1'
      'Database=ouze'
      'User_Name=grsoft'
      'Password=31211'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '.\libmysql.dll'
    Left = 200
    Top = 24
  end
  object qryImagem: TFDQuery
    Connection = DbConexao
    SQL.Strings = (
      'select * from configuracao ')
    Left = 112
    Top = 128
    object qryImagemID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID'
      Origin = 'ID'
    end
    object qryImagemIMAGEM: TBlobField
      AutoGenerateValue = arDefault
      FieldName = 'IMAGEM'
      Origin = 'IMAGEM'
    end
  end
  object qryInsertImagem: TFDQuery
    Connection = DbConexao
    SQL.Strings = (
      'select * from configuracao')
    Left = 224
    Top = 128
    object qryInsertImagemID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID'
      Origin = 'ID'
    end
    object qryInsertImagemIMAGEM: TBlobField
      AutoGenerateValue = arDefault
      FieldName = 'IMAGEM'
      Origin = 'IMAGEM'
    end
  end
end
