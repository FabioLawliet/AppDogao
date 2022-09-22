unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IOUtils;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQPessoa: TFDQuery;
    FDQPessoaid: TFDAutoIncField;
    FDQPessoanome: TStringField;
    FDQPessoacpf: TStringField;
    FDQPessoacelular: TStringField;
    FDQPessoacep: TStringField;
    FDQPessoaendereco: TStringField;
    FDQPessoacidade: TStringField;
    FDQPessoauf: TStringField;
    FDQPessoabairro: TStringField;
    FDQPessoaemail: TStringField;
    FDQPessoasenha: TStringField;
    FDQPessoaimg_usuario: TBlobField;
    FDQProduto: TFDQuery;
    FDQProdutoid: TFDAutoIncField;
    FDQProdutonome: TStringField;
    FDQProdutodescricao: TStringField;
    FDQProdutovalor: TBCDField;
    FDQProdutoquantidade: TIntegerField;
    FDQProdutoimg_produto: TBlobField;
    FDQProdutofavorito: TStringField;
    FDQFavoritos: TFDQuery;
    FDAutoIncField1: TFDAutoIncField;
    StringField1: TStringField;
    StringField2: TStringField;
    BCDField1: TBCDField;
    IntegerField1: TIntegerField;
    BlobField1: TBlobField;
    StringField3: TStringField;
    FDQListaFavoritos: TFDQuery;
    FDAutoIncField2: TFDAutoIncField;
    StringField4: TStringField;
    StringField5: TStringField;
    BCDField2: TBCDField;
    IntegerField2: TIntegerField;
    BlobField2: TBlobField;
    StringField6: TStringField;
    FDQPedido: TFDQuery;
    FDQPedidoid: TIntegerField;
    FDQPedidoidpessoa: TIntegerField;
    FDQPedidodatahora: TDateTimeField;
    FDQPedidovlrPedido: TBCDField;
    FDQItemPedido: TFDQuery;
    FDQItemPedidoid: TIntegerField;
    FDQItemPedidoidPedido: TIntegerField;
    FDQItemPedidoidProduto: TIntegerField;
    FDQItemPedidoqtdeProduto: TIntegerField;
    FDQItemPedidovlrItem: TBCDField;
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL := 'create table IF NOT EXISTS pessoa( 		' + //
            'id integer not null primary key autoincrement, ' + //
            'nome varchar(40),                              ' + //
            'cpf varchar(11),                               ' + //
            'celular varchar(13),                           ' + //
            'cep varchar(10),                               ' + //
            'endereco varchar(60),                          ' + //
            'cidade varchar(60),                            ' + //
            'uf char(2),                                    ' + //
            'bairro varchar(60),                            ' + //
            'email varchar(60),                             ' + //
            'senha varchar(40),                             ' + //
            'img_usuario blob) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := ' create table IF NOT EXISTS produto( ' + //
            ' id integer not null primary key autoincrement, ' + //
            ' nome varchar(20), '+ //
            ' descricao varchar(200), '+//
            ' valor numeric(14,2), '+
            ' quantidade integer, '+
            ' img_produto blob) ';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := ' create table IF NOT EXISTS pedido(           ' +
            ' id integer primary key,                      ' +
            ' idpessoa integer,                            ' +
            ' datahora datetime,                           ' +
            ' vlrPedido numeric(8,2),                      ' +
            ' statusPedido char(1),                        ' +
            ' foreign key (idpessoa) references pessoa(id))';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := ' create table IF NOT EXISTS itempedido(          ' +
            ' id integer primary key,                         ' +
            ' idPedido integer,                               ' +
            ' idProduto integer,                              ' +
            ' qtdeProduto integer,                            ' +
            ' vlrItem numeric(8,2),                           ' +
            ' foreign key (idPedido) references pedido(id)    ' +
            ' foreign key (idProduto) references produto(id)) ';
  FDConnection1.ExecSQL(strSQL);

  FDQPessoa.Active := true;
  FDQProduto.Active := true;
  FDQFavoritos.Active := true;
  FDQListaFavoritos.Active := true;
  FDQPedido.Active := true;
  FDQItemPedido.Active := true;
end;

procedure TDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
    'bancoDados.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('D:\Users\fgbezerra\Downloads\tralhas\Aula3\BD','bancoDados.db');
{$ENDIF}
  FDConnection1.Params.Values['UseUnicode'] := 'False';
  FDConnection1.Params.Values['DATABASE'] := strPath;
end;

end.
