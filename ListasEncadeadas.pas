unit ListasEncadeadas;

interface

uses
  Vcl.Dialogs;

const
  TAMANHO = 10;

type
  TLista = array[1..TAMANHO] of string;

  TListasEncadeadas = class
  public
    procedure Acessar( Lista: TLista ; Elemento: Integer ; var Valor: string;
      TamanhoLista: Integer; var Status: Boolean );

    class procedure Ponteiro();
    class procedure Ponteiro01();
    class procedure Ponteiro02();

  end;

implementation

uses
  System.SysUtils;

{ TListasLineares }

procedure TListasEncadeadas.Acessar(Lista: TLista; Elemento: Integer;
  var Valor: string; TamanhoLista: Integer; var Status: Boolean);
begin
  Valor:= EmptyStr;

  if ( Elemento <= 0 ) or ( Elemento > TamanhoLista ) then
    Status:= False
  else begin
    Valor:= Lista[ Elemento ];
    Status:= True;
  end;

end;

class procedure TListasEncadeadas.Ponteiro;
var
  Int1: Integer;
  PInt1: ^Integer;
begin
  Int1:= 5;
  PInt1:= @Int1; // Acesso endereço de memória com o @

  PInt1^ := PInt1^ + 1; // Acessa o conteudo da memoria com o ^

  ShowMessage( IntToStr( Int1 ) )

end;

class procedure TListasEncadeadas.Ponteiro01;

type
  PNodo = ^Nodo;

  Nodo = record
    Dado: string;
    Proximo: PNodo;
  end;

var
  Inicio, Fim, Auxiliar: PNodo;



  procedure insere_direto( Valor : string );
  begin
    if ( Inicio = nil ) then
    begin
      // cria o primeiro item da lista
      New( Inicio );
      Inicio^.Dado:= Valor;
      Inicio^.Proximo:= nil;
      Fim:= Inicio;
    end else
    begin
      New( Auxiliar );
      Auxiliar^.Dado:= Valor;
      Auxiliar^.Proximo:= nil;

      Fim^.Proximo:= Auxiliar; // aqui defini o valor do inicio quando é o promeiro nodo

      Fim:= Auxiliar;
    end;
  end;

  procedure insere_esquerda( Valor : string );
  var
    Temporario: PNodo;
  begin
    New( Temporario );
    Temporario^.Dado:= Valor;
    Temporario^.Proximo := Inicio;

    if ( Fim = nil ) then
      Fim := Temporario;

    Inicio:= Temporario;

  end;


  procedure insere_antes_de_posicao( ANodo: PNodo; const AValor: string );
  var
    Temporario, Atual, Anterior: PNodo;
  begin
    Atual:= Inicio;

    { TO-DO Buh quando é o primeiro item da lista }

    while ( Atual <> nil ) and ( Atual <> ANodo ) do
    begin
      Anterior:= Atual;

      Atual:= Atual^.Proximo;
    end;

    if ( Atual <> nil ) then
    begin
      New( Temporario );
      Temporario^.Dado:= AValor;

      Anterior^.Proximo:= Temporario;

      Temporario^.Proximo:= ANodo;
    end;

  end;


  procedure libera_lista();
  var
    Atual: PNodo;
  begin
    Atual:= Inicio;

    while ( Atual <> nil ) do
    begin

      Inicio:= Inicio^.Proximo;

      Dispose( Atual );

      Atual:= Inicio;
    end;

    Fim:= nil;

  end;

  procedure remove_esquerda();
  var
    Temporario: PNodo;

  begin
    if ( Inicio <> nil ) then // verifica se a lista esta vazia
    begin
      Temporario:= Inicio;

      Inicio:= Inicio^.Proximo;

      if ( Inicio = nil ) then
        Fim:= nil;

      Dispose( Temporario );
    end;

  end;

  procedure remove_direita();
  var
    Atual, Anterior: PNodo;
  begin
    if ( Inicio <> nil ) then // lista vazia
    begin
      if ( Inicio^.Proximo = nil ) then // lista com um nodo
      begin
        Dispose( Inicio );
        Inicio:= nil;
        Fim:= nil;
      end else
      begin

        Atual:= Inicio;
        Anterior:= Inicio;

        while ( Atual^.Proximo <> nil ) do // percorre até o último
        begin
          Anterior:= Atual;

          Atual:= Atual^.Proximo;
        end;

        Anterior^.Proximo:= nil;
        Fim:= Anterior;

        Dispose( Atual );

      end;
    end;
  end;


  procedure remove_antes_da_posicao( ANodo : PNodo );
  var
    Atual, Anterior: PNodo;

  begin

    if ( Inicio <> nil ) then
    begin

      Atual:= Inicio;
      Anterior:= Inicio;

      while ( ( Atual <> nil ) and ( Atual^.Proximo <> ANodo ) ) do
      begin
        Anterior:= Atual;

        Atual:= Atual^.Proximo;
      end;

      if ( Atual <> nil ) then
      begin
        if ( Inicio = Atual ) then
          Inicio:= ANodo
        else
          Anterior^.Proximo:= ANodo;

        Dispose( Atual );
      end;

    end;
  end;


begin
  // Limpa as variáveis pois elas tem lixo
  Inicio:= nil;
  Fim:= nil;
  Auxiliar:= nil;

  insere_direto( 'Johni' );    // Johni
  insere_direto( 'Marangon' ); // Johni - Marangon
  insere_direto( 'Douglas' );  // Johni - Marangon - Douglas

  insere_esquerda( 'Dani' ); // Dani - Johni - Marangon - Douglas

  insere_antes_de_posicao( Inicio^.Proximo, 'Daniele' ); // Dani- Daniele - Johni - Marangon - Douglas

  remove_esquerda(); // Daniele - Johni - Marangon - Douglas

  {TO-DO Liberar objetos da memória 18/12/2013}

  remove_direita(); // remove o último nodo - Daniele - Johni - Marangon

  remove_antes_da_posicao( Inicio^.Proximo ); // Johni - Marangon

  libera_lista();

end;

class procedure TListasEncadeadas.Ponteiro02;
type
  PNodo = ^Nodo;
  Nodo = record
    Dado: Integer;
    Posicao: PNodo;
  end;

  PHeader = ^Header;
  Header = record
    Inicio: PNodo;
    Count: Integer;
    Fim: PNodo;
  end;

var
  Head: PHeader;

  procedure Init();
  begin
    New( Head );

    Head^.Inicio:= nil;
    Head^.Fim:= nil;

    Head^.Count:= 0;
  end;

  procedure InsereEsquerda( AValor : Integer );
  var
    Temp: PNodo;
  begin
    New( Temp );

    Temp^.Dado:= AValor;
    Temp^.Posicao:= Head^.Inicio;

    // Atualiza o início
    Head^.Inicio:= Temp;

    Head^.Count:= Head^.Count + 1;

    // primeiro item da lista
    if ( Head^.Fim = nil ) then
      Head^.Fim:= Temp;

  end;

  procedure InsereDireta();
  begin

  end;

begin

  Init( );

  InsereEsquerda( 10 ); // 10
  InsereEsquerda( 50 ); // 50 - 10
  InsereEsquerda( 80 ); // 80 - 50 - 10



end;

end.

