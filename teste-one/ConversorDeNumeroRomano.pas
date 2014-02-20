unit ConversorDeNumeroRomano;

interface

uses
  System.Generics.Collections;

type
  TConversorDeNumeroRomano = class
  private
    function GetTabela(): TDictionary<Char, Integer>;

  public
    function Converte( const ANumeroRomano: string ): Integer;
  end;


implementation

uses
  System.SysUtils;

{ TFirstClass }

function TConversorDeNumeroRomano.Converte( const ANumeroRomano: string ): Integer;
var
  Tabela: TDictionary<Char, Integer>;

  Atual, Multiplicador, UltimoVizinhoDaDireita, Indice: Integer;

begin
  Result:= 0;
  UltimoVizinhoDaDireita:= 0;

  Tabela:= GetTabela();
  try
    for Indice:= Length( ANumeroRomano ) downto 1 do
    //for Indice:= 1 to Length( ANumeroRomano )  do
    begin
      Atual:= Tabela.Items[ ANumeroRomano[ Indice] ];

      Multiplicador:= 1;

      if ( Atual < UltimoVizinhoDaDireita ) then
        Multiplicador:= -1;

      Result:= Result + Atual * Multiplicador;

      UltimoVizinhoDaDireita:= Atual;
    end;


  finally
    FreeAndNil( Tabela )
  end;


end;

function TConversorDeNumeroRomano.GetTabela: TDictionary<Char, Integer>;
begin
  Result:= TDictionary<Char, Integer>.Create();

  Result.Add( 'I', 1 );
  Result.Add( 'V', 5 );
  Result.Add( 'X', 10 );
  Result.Add( 'L', 50 );
  Result.Add( 'C', 100 );
  Result.Add( 'D', 500 );
  Result.Add( 'M', 1000 );

end;

end.
