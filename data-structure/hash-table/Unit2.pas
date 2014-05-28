unit Unit2;

interface

type
  THashTable = class
  strict private type
    // Dados de um computador
    PComputador = ^TComputador;
    TComputador = record
      Codigo: Integer;
      IP: string;
      Descricao: string;
      Setor: string;

      Apontador: PComputador;
    end;

  strict private
    const LEN_VET = 100;

  strict private
    HashTable: array [0..LEN_VET] of TComputador;

    // Fun��o hash que retona um �ndice no
    // vetor com base na chave.
    function Hashing( const ACodigo: Integer ): Integer;
    function Default(): TComputador;

  public
    procedure Adicionar( const AComputador: TComputador );
    function Pesquisar( const ACodigo: Integer ): TComputador;
  end;


implementation

uses
  System.SysUtils;

{ THashTable }

procedure THashTable.Adicionar(const AComputador: TComputador);
var
  IndiceHash: Integer;
  Indice: Integer;

  PAuxiliar: PComputador;
begin
  // C�lculo do hash
  IndiceHash:= Hashing( AComputador.Codigo );

  if ( HashTable[ IndiceHash ].Codigo > 0 ) then
  begin

    // Encontra o pr�ximo ponteiro dispon�vel para inserir no registro
    PAuxiliar:= HashTable[ IndiceHash ].Apontador;
    while ( PAuxiliar <> nil ) do
    begin

      // Verifica se o cadastro n�o foi realizado
      if ( PAuxiliar.Codigo = AComputador.Codigo ) then
        raise Exception.Create('C�digo n�o foi cadastrado');

      PAuxiliar:= PAuxiliar.Apontador;

    end;

    PAuxiliar.Codigo:= AComputador.Codigo;
    PAuxiliar.IP:= AComputador.IP;
    PAuxiliar.Descricao:= AComputador.Descricao;
    PAuxiliar.Setor:= AComputador.Setor;
    PAuxiliar.Apontador:= nil;

    // Tabela hash est� cheia
    raise Exception.Create('Overflow na tabela hash');

  end else
    HashTable[IndiceHash]:= AComputador;

end;

function THashTable.Default: TComputador;
begin
  Result.Codigo:= 0;
  Result.Descricao:= EmptyStr;
  Result.IP:= EmptyStr;
  Result.Setor:= EmptyStr;

  Result.Apontador:= nil;
end;

function THashTable.Hashing(const ACodigo: Integer): Integer;
begin
  Result:=
    ( ACodigo mod LEN_VET );
end;

function THashTable.Pesquisar(const ACodigo: Integer): TComputador;
var
  IndiceHash: Integer;
  Indice: Integer;

  PAuxiliar: PComputador;
begin
  Result:= Default;

  // C�lculo do hash
  IndiceHash:= Hashing( ACodigo );

  if ( HashTable[ IndiceHash ].Codigo > 0 ) then
  begin

    // Encontra o pr�ximo ponteiro dispon�vel para inserir no registro
    PAuxiliar:= HashTable[ IndiceHash ].Apontador;
    while ( PAuxiliar <> nil ) do
    begin

      // Verifica se o cadastro n�o foi realizado
      if ( PAuxiliar.Codigo = ACodigo ) then
      begin

        Result.Codigo:= PAuxiliar.Codigo;
        Result.IP:= PAuxiliar.IP;
        Result.Descricao:= PAuxiliar.Descricao;
        Result.Setor:= PAuxiliar.Setor;

        Exit();
      end;

      PAuxiliar:= PAuxiliar.Apontador;
    end;

    // Tabela hash est� cheia
    raise Exception.Create('Overflow na tabela hash');

  end else
    Exit(HashTable[IndiceHash]);

end;

end.
