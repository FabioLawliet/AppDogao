object dm: Tdm
  OldCreateOrder = False
  Height = 376
  Width = 419
  object Connection: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\AppDogao\DataBase\data.db'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = ConnectionAfterConnect
    BeforeConnect = ConnectionBeforeConnect
    Left = 360
    Top = 16
  end
  object QueryPessoa: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from pessoa')
    Left = 360
    Top = 128
    object QueryPessoaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QueryPessoanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 40
    end
    object QueryPessoacpf: TStringField
      FieldName = 'cpf'
      Origin = 'cpf'
      Size = 11
    end
    object QueryPessoacelular: TStringField
      FieldName = 'celular'
      Origin = 'celular'
      Size = 13
    end
    object QueryPessoacep: TStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object QueryPessoaendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 60
    end
    object QueryPessoacidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 60
    end
    object QueryPessoauf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object QueryPessoabairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 60
    end
    object QueryPessoaemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 60
    end
    object QueryPessoasenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 40
    end
    object QueryPessoaimg_usuario: TBlobField
      FieldName = 'img_usuario'
      Origin = 'img_usuario'
    end
  end
  object QueryProduto: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from produto')
    Left = 360
    Top = 192
    object QueryProdutoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QueryProdutonome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
    end
    object QueryProdutodescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 200
    end
    object QueryProdutovalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 14
      Size = 2
    end
    object QueryProdutoquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object QueryProdutoimg_produto: TBlobField
      FieldName = 'img_produto'
      Origin = 'img_produto'
    end
  end
  object QueryUsuario: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select * from usuario')
    Left = 360
    Top = 72
    object QueryUsuarioid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QueryUsuariologin: TStringField
      FieldName = 'login'
      Origin = 'login'
      Size = 40
    end
    object QueryUsuariosenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 40
    end
  end
end
