unit TestCarrinhoDeCompras;

interface

uses
  TestFramework, CarrinhoDeCompras, Generics.Collections, MaiorPreco;

type

  TestTCarrinhoDeCompras = class(TTestCase)
  strict private
    FCarrinhoDeCompras: TCarrinhoDeCompras;
    FMaiorPreco: TMaiorPreco;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure deveRetornarZeroSeCarrinhoVazio();
    procedure deveRetornarValorDoItemSeCarrinhoCom1Elemento();
    procedure deveRetonarMaiorValorSeCarrinhoContemMuitosElementos();
  end;

implementation


procedure TestTCarrinhoDeCompras.deveRetonarMaiorValorSeCarrinhoContemMuitosElementos;
begin
  FCarrinhoDeCompras.Adiciona( TItem.Create('Geladeira', 1, 900.00) );
  FCarrinhoDeCompras.Adiciona( TItem.Create('Fogão', 1, 1500.00) );
  FCarrinhoDeCompras.Adiciona( TItem.Create('Máquina de Lavar', 1, 750.00) );
  CheckEquals( 1500.00, FCarrinhoDeCompras.Encontra( FCarrinhoDeCompras ) );

end;

procedure TestTCarrinhoDeCompras.deveRetornarValorDoItemSeCarrinhoCom1Elemento;
begin
  FCarrinhoDeCompras.Adiciona( TItem.Create('Geladeira', 1, 900.00) );
  CheckEquals( 900, FCarrinhoDeCompras.Encontra( FCarrinhoDeCompras ) );

end;

procedure TestTCarrinhoDeCompras.deveRetornarZeroSeCarrinhoVazio;
begin
  CheckEquals( 0, FCarrinhoDeCompras.Encontra( FCarrinhoDeCompras ) );
end;

procedure TestTCarrinhoDeCompras.SetUp;
begin
  FCarrinhoDeCompras := TCarrinhoDeCompras.Create;
  FMaiorPreco:= TMaiorPreco.Create;
end;

procedure TestTCarrinhoDeCompras.TearDown;
begin
  FMaiorPreco.Free;
  FMaiorPreco:= nil;
  FCarrinhoDeCompras.Free;
  FCarrinhoDeCompras := nil;
end;


initialization
  RegisterTest(TestTCarrinhoDeCompras.Suite);
end.

