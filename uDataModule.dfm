object dm: Tdm
  OldCreateOrder = False
  Height = 376
  Width = 419
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\AppDogao\DataBase\data.db'
      'DriverID=SQLite')
    Connected = True
    Left = 360
    Top = 16
  end
  object Query: TFDQuery
    Connection = Connection
    Left = 360
    Top = 72
  end
  object FDCommand1: TFDCommand
    Connection = Connection
    CommandText.Strings = (
      'select * from usuario')
    Left = 288
    Top = 40
  end
end
