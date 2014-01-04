unit TestListasEncadeadas;

interface

uses
  TestFramework, ListasEncadeadas;

type

 TestTListasLineares = class(TTestCase)
  published
    procedure TestAcessar;

    procedure Test();
  end;

implementation

uses
  System.SysUtils;



procedure TestTListasLineares.Test;
begin

//  TListasLineares.Ponteiro();

//  TListasEncadeadas.Ponteiro01();
// TListasEncadeadas.SimplismenteEncadeadaComHeader();

//  TListasEncadeadas.DuplamenteEncadeada();

  TListasEncadeadas.ListaCircular();


end;

procedure TestTListasLineares.TestAcessar;
var
  Status: Boolean;
  TamanhoLista: Integer;
  Valor: string;
  Elemento: Integer;
  Lista: TLista;
  Count: Integer;
  ListasLineares: TListasEncadeadas;
begin
  // Popula a lista
  for Count := 1 to TAMANHO do
    Lista[ Count ]:= Char( 1 + 60 );

  TamanhoLista:= TAMANHO;

  ListasLineares:= TListasEncadeadas.Create;
  try

    Elemento:= 1;
    ListasLineares.Acessar(Lista, Elemento, Valor, TamanhoLista, Status);
    CheckTrue( Status );
    CheckEquals( '=', Valor );

    Elemento:= 11;
    ListasLineares.Acessar(Lista, Elemento, Valor, TamanhoLista, Status);
    CheckFalse( Status );
    CheckEquals( '', Valor );

  finally
    FreeAndNil( ListasLineares )
  end;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTListasLineares.Suite);
end.

