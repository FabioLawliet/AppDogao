object dm: Tdm
  OldCreateOrder = False
  Height = 376
  Width = 419
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\AppDogao\DataBase\data.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 360
    Top = 16
  end
  object Query: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from usuario')
    Left = 360
    Top = 72
    object Queryidusuario: TFDAutoIncField
      FieldName = 'idusuario'
      Origin = 'idusuario'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object Queryusuario: TStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Size = 40
    end
    object Querysenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 40
    end
  end
end
