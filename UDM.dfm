object DM: TDM
  OldCreateOrder = False
  Height = 342
  Width = 440
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Users\fgbezerra\Downloads\tralhas\Aula3\BD\bancoDado' +
        's.db'
      'SharedCache=10000'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 80
    Top = 72
  end
  object FDQPessoa: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pessoa'
      'where email=:pNome'
      '')
    Left = 80
    Top = 160
    ParamData = <
      item
        Name = 'PNOME'
        DataType = ftString
        ParamType = ptInput
        Value = 'a '
      end>
    object FDQPessoaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQPessoanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 40
    end
    object FDQPessoacpf: TStringField
      FieldName = 'cpf'
      Origin = 'cpf'
      Size = 11
    end
    object FDQPessoacelular: TStringField
      FieldName = 'celular'
      Origin = 'celular'
      Size = 13
    end
    object FDQPessoacep: TStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object FDQPessoaendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 60
    end
    object FDQPessoacidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 60
    end
    object FDQPessoauf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object FDQPessoabairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 60
    end
    object FDQPessoaemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 60
    end
    object FDQPessoasenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 40
    end
    object FDQPessoaimg_usuario: TBlobField
      FieldName = 'img_usuario'
      Origin = 'img_usuario'
    end
  end
  object FDQProduto: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produto')
    Left = 168
    Top = 72
    object FDQProdutoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQProdutonome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
    end
    object FDQProdutodescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 200
    end
    object FDQProdutovalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 14
      Size = 2
    end
    object FDQProdutoquantidade: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object FDQProdutoimg_produto: TBlobField
      FieldName = 'img_produto'
      Origin = 'img_produto'
    end
    object FDQProdutofavorito: TStringField
      FieldName = 'favorito'
      Origin = 'favorito'
      FixedChar = True
      Size = 1
    end
  end
  object FDQFavoritos: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produto where id = :pIdProduto'
      'and favorito = '#39'S'#39)
    Left = 168
    Top = 152
    ParamData = <
      item
        Name = 'PIDPRODUTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object FDAutoIncField1: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object StringField1: TStringField
      FieldName = 'nome'
      Origin = 'nome'
    end
    object StringField2: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 200
    end
    object BCDField1: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 14
      Size = 2
    end
    object IntegerField1: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object BlobField1: TBlobField
      FieldName = 'img_produto'
      Origin = 'img_produto'
    end
    object StringField3: TStringField
      FieldName = 'favorito'
      Origin = 'favorito'
      FixedChar = True
      Size = 1
    end
  end
  object FDQListaFavoritos: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produto'
      'where favorito = '#39'S'#39)
    Left = 88
    Top = 240
    object FDAutoIncField2: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object StringField4: TStringField
      FieldName = 'nome'
      Origin = 'nome'
    end
    object StringField5: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 200
    end
    object BCDField2: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 14
      Size = 2
    end
    object IntegerField2: TIntegerField
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object BlobField2: TBlobField
      FieldName = 'img_produto'
      Origin = 'img_produto'
    end
    object StringField6: TStringField
      FieldName = 'favorito'
      Origin = 'favorito'
      FixedChar = True
      Size = 1
    end
  end
  object FDQPedido: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from pedido')
    Left = 248
    Top = 72
    object FDQPedidoid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQPedidoidpessoa: TIntegerField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
    end
    object FDQPedidodatahora: TDateTimeField
      FieldName = 'datahora'
      Origin = 'datahora'
    end
    object FDQPedidovlrPedido: TBCDField
      FieldName = 'vlrPedido'
      Origin = 'vlrPedido'
      Precision = 8
      Size = 2
    end
  end
  object FDQItemPedido: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from itempedido')
    Left = 248
    Top = 144
    object FDQItemPedidoid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQItemPedidoidPedido: TIntegerField
      FieldName = 'idPedido'
      Origin = 'idPedido'
    end
    object FDQItemPedidoidProduto: TIntegerField
      FieldName = 'idProduto'
      Origin = 'idProduto'
    end
    object FDQItemPedidoqtdeProduto: TIntegerField
      FieldName = 'qtdeProduto'
      Origin = 'qtdeProduto'
    end
    object FDQItemPedidovlrItem: TBCDField
      FieldName = 'vlrItem'
      Origin = 'vlrItem'
      Precision = 8
      Size = 2
    end
  end
end
