unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tdm = class(TDataModule)
    Connection: TFDConnection;
    Query: TFDQuery;
    Queryidusuario: TFDAutoIncField;
    Queryusuario: TStringField;
    Querysenha: TStringField;
    QueryPessoa: TFDQuery;
    QueryProduto: TFDQuery;
    QueryPessoaid: TFDAutoIncField;
    QueryPessoanome: TStringField;
    QueryPessoacpf: TStringField;
    QueryPessoacelular: TStringField;
    QueryPessoacep: TStringField;
    QueryPessoaendereco: TStringField;
    QueryPessoacidade: TStringField;
    QueryPessoauf: TStringField;
    QueryPessoabairro: TStringField;
    QueryPessoaemail: TStringField;
    QueryPessoasenha: TStringField;
    QueryPessoaimg_usuario: TBlobField;
    QueryProdutoid: TFDAutoIncField;
    QueryProdutonome: TStringField;
    QueryProdutodescricao: TStringField;
    QueryProdutovalor: TBCDField;
    QueryProdutoquantidade: TIntegerField;
    QueryProdutoimg_produto: TBlobField;
    procedure ConnectionBeforeConnect(Sender: TObject);
    procedure ConnectionAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.ConnectionAfterConnect(Sender: TObject);
const
  cSQLCreatePessoa =
  'create table IF NOT EXISTS Pessoa(              ' +
  'id integer not null primary key autoincrement,  ' +
  'nome varchar(40),                               ' +
  'cpf varchar(11),                                ' +
  'celular varchar(13),                            ' +
  'cep varchar(10),                                ' +
  'endereco varchar(60),                           ' +
  'cidade varchar(60),                             ' +
  'uf char(2),                                     ' +
  'bairro varchar(60),                             ' +
  'email varchar(60),                              ' +
  'senha varchar(40),                              ' +
  'img_usuario blob)                               ';

  cSQLCreateProduto =
  'create table IF NOT EXISTS Produto(             ' +
  'id integer not null primary key autoincrement,  ' +
  'nome varchar(20),                               ' +
  'descricao varchar(200),                         ' +
  'valor numeric(14,2),                            ' +
  'quantidade integer,                             ' +
  'img_produto blob)                               ';

  cSQLCreateUsuario =
  'create table IF NOT EXISTS Usuario(                  ' +
  'idusuario integer not null primary key autoincrement ' +
  'usuario varchar(40), ' +
  'senha varchar(40))';
begin
  connection.ExecSQL(cSQLCreatePessoa);
  connection.ExecSQL(cSQLCreateProduto);
  connection.ExecSQL(cSQLCreateUsuario);
  Query.Active := true;
  QueryPessoa.Active := true;
  QueryProduto.Active := true;


end;

procedure Tdm.ConnectionBeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  StrPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,'data.db');
{$ENDIF}
  Connection.Params.Values['UseUnicode'] := 'False';
  Connection.Params.Values['DATABASE'] := strPath;
end;

end.
