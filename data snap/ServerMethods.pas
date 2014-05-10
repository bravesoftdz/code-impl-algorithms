unit ServerMethods;

interface

uses
  Data.DBXFirebird,
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TSMCliente = class(TComponent)
  private
    { Private declarations }
  public
    function Cadastrar(Codigo, Nome, Endereco, Cidade: string): string;
    function ListaClientes(): string;
  end;
{$METHODINFO OFF}

implementation

uses System.StrUtils, Data.DBXCommon;

function TSMCliente.Cadastrar(Codigo, Nome, Endereco, Cidade: string): string;
var
  Conexao: TDBXConnection;

  Insert: TDBXCommand;
begin
  Conexao := TDBXConnectionFactory.GetConnectionFactory.GetConnection('Conexao',
    'SYSDBA', 'masterkey');

  Insert := Conexao.CreateCommand;
  Insert.Text := 'insert Into USUARIOS (CODIGO, NOME, ENDERECO, CIDADE ) values (' +
    (Codigo) + ',' + QuotedStr(Nome) + ',' +  QuotedStr(Endereco) + ',' +
    QuotedStr(Cidade ) + ')';

  Insert.ExecuteQuery;
  Insert.Free;
  Conexao.Free;
  Result := 'Gravado com sucesso';
end;

function TSMCliente.ListaClientes: string;
var
  Conexao:TDBXConnection;
  Select:TDBXCommand;
  Registros :TDbxReader;
begin
  Conexao := TDBXConnectionFactory.GetConnectionFactory.GetConnection('Conexao',
    'SYSDBA', 'masterkey');

  Select := Conexao.CreateCommand;
  Select.Text:='select CODIGO, NOME, ENDERECO, CIDADE from USUARIOS ';

  Registros:=Select.ExecuteQuery;
  while Registros.Next do
    Result:= Result + '  ' + Registros.Value['NOME'].AsString;

  Registros.Free;
  Select.Free;
  Conexao.Free;

end;

end.
