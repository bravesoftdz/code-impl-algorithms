unit HashingFechado;

interface

type
  THashTable = class
  public type
    // Dados de um computador
    TComputador = record
      Codigo: Integer;
      IP: string;
      Descricao: string;
      Setor: string;
    end;

  strict private
    const LEN_VET = 17;

  strict private
    HashTable: array [0..LEN_VET] of TComputador;

    // Fun��o hash que retona um �ndice no
    // vetor com base na chave.
    function Hashing( const ACodigo: Integer ): Integer;
    function Default(): TComputador;

  public
    procedure Adicionar( const AComputador: TComputador );
    function Pesquisar( const ACodigo: Integer ): TComputador;

    procedure ImprimirComputadores();
  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ THashTable }

procedure THashTable.Adicionar(const AComputador: TComputador);
var
  IndiceHash: Integer;
  Indice: Integer;
begin
  // C�lculo do hash
  IndiceHash:= Hashing( AComputador.Codigo );

  if ( HashTable[ IndiceHash ].Codigo > 0 ) then
  begin
    for Indice:= Succ(IndiceHash) to High(HashTable) do
    begin

      if ( HashTable[Indice].Codigo = AComputador.Codigo ) then
        raise Exception.Create('C�digo j� inclu�do');

      if ( HashTable[Indice].Codigo = 0 ) then
      begin
        HashTable[Indice]:= AComputador;
        Exit();
      end;

    end;

    for Indice:= Low(IndiceHash) to Pred(IndiceHash) do
    begin

      if ( HashTable[Indice].Codigo = AComputador.Codigo ) then
        raise Exception.Create('C�digo j� inclu�do');

      if ( HashTable[Indice].Codigo = 0 ) then
      begin
        HashTable[Indice]:= AComputador;
        Exit();
      end;
    end;

    // Tabela hash est� cheia
    raise Exception.Create('Overflow na tabela hash');

  end else
    HashTable[IndiceHash]:= AComputador;
end;


function THashTable.Hashing(const ACodigo: Integer): Integer;
begin
  Result:=
    ( ACodigo mod LEN_VET );
end;

procedure THashTable.ImprimirComputadores;
var
  Indice: Integer;
begin

  for Indice := Low(HashTable) to High(HashTable) do
  begin
    ShowMessage( Indice.ToString + ' ' + HashTable[Indice].Descricao );
  end;

end;

function THashTable.Pesquisar(const ACodigo: Integer): TComputador;
var
  IndiceHash: Integer;
  Indice: Integer;
begin
  // Inicializa o retorno
  Result:= Default();

  // Calcula o hash para a pesquisa
  IndiceHash:= Hashing( ACodigo );

  // Verifica se o hash calculado corressponde a pesquisa feita
  // Essa � a situa��o de melhor caso
  if ( HashTable[IndiceHash] ).Codigo = ACodigo then
  begin
    Exit(HashTable[ IndiceHash ])
  end else
  begin
    // Caso n�o encontre o valor na primeira pesquisa
    // percorre o pr�ximo indice do tabela hash at� o final da tabela hash
    for Indice:= Succ(IndiceHash) to High(HashTable) do
    begin
      if ( HashTable[Indice].Codigo = ACodigo ) then
        Exit( HashTable[Indice] );
    end;

    // Pesquisa circular
    // Caso nao tenha encontaro o registro passa a pesquisa-lo do inico
    for Indice:= Low(HashTable) to Pred(IndiceHash) do
    begin
      if ( HashTable[Indice].Codigo = ACodigo ) then
        Exit( HashTable[Indice] );
    end;

  end;

end;

function THashTable.Default: TComputador;
begin
  Result.Codigo:= 0;
  Result.Descricao:= EmptyStr;
  Result.IP:= EmptyStr;
  Result.Setor:= EmptyStr;
end;


end.
