unit TestHashingFechado;

interface
uses
  HashingFechado,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestHashingFechado = class(TObject)
  strict private
    HashTable: HashingFechado.THashTable;

    function RetornaComupadorPadrao(
      const ACodigo: Integer ): HashingFechado.THashTable.TComputador;
  public

    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    //[Test]
    procedure TestInit();

    [Test]
    procedure TestColisao();

  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;


{ TestHashingFechado }

function TTestHashingFechado.RetornaComupadorPadrao(
  const ACodigo: Integer): HashingFechado.THashTable.TComputador;
begin

  Result.Codigo:= ACodigo;
  Result.IP:= '192.168.0.' + ACodigo.ToString();
  Result.Descricao:= 'PC MESA ' + ACodigo.ToString();
  Result.Setor:= 'LOJA';

end;




procedure TTestHashingFechado.Setup;
begin
  HashTable:= HashingFechado.THashTable.Create();
end;

procedure TTestHashingFechado.TearDown;
begin
  FreeAndNil( HashTable );
end;

procedure TTestHashingFechado.TestColisao;
begin
  HashTable.Adicionar( RetornaComupadorPadrao( 148 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 131 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 114 ) );

  ShowMessage( HashTable.Pesquisar(50).Descricao );
  ShowMessage( HashTable.Pesquisar(131).Descricao );
  ShowMessage( HashTable.Pesquisar(148).Descricao );

      // complito de posi��es
  HashTable.Adicionar( RetornaComupadorPadrao( 133 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 116 ) );

  ShowMessage( HashTable.Pesquisar(133).Descricao )
end;

procedure TTestHashingFechado.TestInit;
begin
  HashTable.Adicionar( RetornaComupadorPadrao( 1 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 2 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 3 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 50 ) );
  HashTable.Adicionar( RetornaComupadorPadrao( 45 ) );

  ShowMessage( HashTable.Pesquisar(50).Descricao );
  ShowMessage( HashTable.Pesquisar(9).Descricao );

  //HashTable.ImprimirComputadores();


end;

initialization
  TDUnitX.RegisterTestFixture(TTestHashingFechado);
end.
