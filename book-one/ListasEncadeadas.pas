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
    class procedure SimplismenteEncadeada();
    class procedure SimplismenteEncadeadaComHeader();
    class procedure DuplamenteEncadeada();

    class procedure ListaCircular();
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

class procedure TListasEncadeadas.DuplamenteEncadeada;
type
  PNodo = ^Nodo;
  Nodo = record
    Anterior: PNodo;
    Dado: string;
    Proximo: PNodo;
  end;

  PHeader = ^Header;
  Header = record
    Inicio: PNodo;
    Quantidade: Integer;
    Fim: PNodo;
  end;

var
  Head: PHeader;

  procedure InsereEsquerda( const AValor: string );
  var
    Temp: PNodo;
  begin
    Head^.Quantidade:=
      Head^.Quantidade + 1;

    New( Temp );

    Temp^.Anterior:= nil;
    Temp^.Dado:= AValor;
    Temp^.Proximo:= Head^.Inicio;

    if ( Head^.Quantidade > 1 ) then
      Head^.Inicio^.Anterior:= Temp;

    Head^.Inicio:= Temp;

    if ( Head^.Fim = nil ) then
      Head^.Fim:= Temp;
  end;

  procedure InsereDireta( const AValor: string );
  var
    Temp: PNodo;
  begin
    Head^.Quantidade:=
      Head^.Quantidade + 1;

    New( Temp );
    Temp^.Anterior:= Head^.Fim;
    Temp^.Dado:= AValor;
    Temp^.Proximo:= nil;

    if ( Head^.Quantidade > 1 ) then
      Head^.Fim.Proximo:= Temp;

    Head^.Fim:= Temp;

    if ( Head^.Inicio = nil ) then
      Head^.Inicio:= Temp;

  end;

  procedure RemoveDireita();
  var
    Temp: PNodo;
  begin
    Temp:= Head^.Fim.Anterior;

    Temp.Proximo:= nil;

    Dispose( Head^.Fim );

    Head^.Fim:= Temp;
  end;

  procedure RemoveEsquerda();
  var
    Temp: PNodo;
  begin
    Temp:= Head^.Inicio^.Proximo;

    Temp^.Anterior:= nil;

    Dispose( Head^.Inicio );

    Head^.Inicio:= Temp;
  end;

  procedure Mostra();
  var
    Temp: PNodo;

    Dados: string;
  begin
    Temp:= Head^.Inicio;

    while ( Temp <> nil ) do
    begin
      Dados:=
        Dados + ' ' + Temp^.Dado;

      Temp:= Temp^.Proximo;
    end;

    ShowMessage( Dados );
  end;

  procedure MostraTrazFrente();
  var
    Temp: PNodo;

    Dados: string;
  begin
    Temp:= Head^.Fim;
    while ( Temp <> nil ) do
    begin
      Dados:=
        Dados + ' ' + Temp^.Dado;

      Temp:= Temp^.Anterior;
    end;

    ShowMessage( Dados );

  end;



begin
  Head^.Inicio:= nil;
  Head^.Quantidade:= 0;
  Head^.Fim:= nil;

  InsereEsquerda( 'Johni' );
  InsereEsquerda( 'Douglas' );
  InsereEsquerda( 'Marangon' );
  //Mostra(); // Marangon - Douglas - Johni

  InsereDireta( 'Daniele' );
  InsereDireta( 'Klein' );
  //Mostra(); // Marangon - Douglas - Johni - Daniele - Klein

  //RemoveDireita();
  //RemoveDireita();
  //Mostra();

//  RemoveEsquerda();
//  RemoveEsquerda();
  MostraTrazFrente();
//  Percore do inicio ao final

end;




class procedure TListasEncadeadas.ListaCircular;

type
  PNodo = ^Nodo;
  Nodo = record
    Valor: string;
    Proximo: PNodo;
  end;

var
  Atual: PNodo;


  procedure Insere( AValor: string );
  var
    Temp: PNodo;
  begin
    New( Temp );

    Temp^.Valor:= AValor;

    if ( Atual = nil ) then
    begin

      Atual:= Temp;
      Atual^.Proximo:= Temp;

    end else
    begin
      Temp^.Proximo:= Atual^.Proximo;
      Atual^.Proximo := Temp;
      Atual := Temp;
    end;

  end;


  procedure Mostra();
  var
    Dados: string;
    Temp : PNodo;
  begin


     Temp:= Atual^.Proximo;
     while ( True ) do
     begin
       Dados:=
         Dados + Temp^.Valor + '  ';

       if ( Temp = Atual ) then
         Break;

       Temp:= Temp^.Proximo;
     end;


    ShowMessage( Dados )
  end;

begin
  Atual:= nil;

  Insere( 'Johni' );
  Insere( 'Douglas' );
  Insere( 'Marangon' );
  Mostra();




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

class procedure TListasEncadeadas.SimplismenteEncadeada;

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

class procedure TListasEncadeadas.SimplismenteEncadeadaComHeader;
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

  procedure InsereDireta( const AValor : Integer );
  var
    Temp: PNodo;
  begin
    New( Temp );

    Temp^.Dado:= AValor;
    Temp^.Posicao:= nil;

    Head^.Fim.Posicao:= Temp;

    Head^.Count:= Head^.Count + 1;

    if ( Head^.Inicio = nil ) then
      Head^.Inicio:= Temp;

    Head^.Fim:= Temp;

  end;

  procedure RemoveDireita();
  var
    Temp: PNodo;
  begin
    if ( Head^.Count <> 0 ) then
    begin
      if ( Head^.Count = 1 ) then
        Head^.Inicio:= nil
      else begin
        // Busca o ponteiro do penultimo nodo para definir nil para ele
        Temp:= Head^.Inicio;
        while ( Temp^.Posicao <> Head^.Fim ) do
          Temp:= Temp^.Posicao;

        Temp^.Posicao:= nil;
      end;

      Dispose( Head^.Fim );

      Head^.Count:= Head^.Count - 1;

      if ( Head^.Count = 1 ) then
        Head^.Fim := nil
      else
        Head^.Fim := Temp;

    end;
  end;


  procedure RemoveEsquerda();
  var
    Temp: PNodo;
  begin

    if ( Head^.Count <> 0 ) then
    begin
      Temp:= Head^.Inicio;

      if ( Head^.Count = 1 ) then
      begin
        Head^.Fim:= nil;
      end;

      Head.Inicio:= Head^.Inicio^.Posicao;

      Dispose( Temp );
      Head^.Count:= Head^.Count - 1;
    end;

  end;

  procedure MostraLista();
  var
    Temp: PNodo;

    Mensagem: string;
  begin

    Temp:= Head^.Inicio;

    while ( Temp <> nil ) do
    begin
      Mensagem:=
        Mensagem + ' ' + IntToStr( Temp^.Dado );


      Temp:= Temp^.Posicao;
    end;
    ShowMessage( Mensagem );
  end;

  procedure Maior();
  var
    Dado: Integer;
    Temp: PNodo;
  begin

    Temp:= Head^.Inicio;
    Dado:= Head^.Inicio^.Dado;

    while ( Temp <> nil ) do
    begin
      if ( Dado < Temp^.Dado ) then
        Dado:= Temp^.Dado;


      Temp:= Temp^.Posicao;
    end;

    ShowMessage( 'Maior ' + IntToStr( Dado ) );
  end;


begin

  Init( );

  InsereEsquerda( 10 ); // 10
  InsereEsquerda( 50 ); // 50 - 10
  InsereEsquerda( 80 ); // 80 - 50 - 10

  InsereDireta( 20 );  // 80 - 50 - 10 - 20
  InsereDireta( 40 );  // 80 - 50 - 10 - 20 - 40
  //Maior();

  RemoveDireita( );    // 80 - 50 - 10 - 20

  //InsereDireta( 100 );
  //Maior();

  RemoveEsquerda();    // 50 - 10 - 20
  //InsereEsquerda( 5 );
  //Maior();

  MostraLista();

end;

{ TO-DO fazer a interseção de duas listas }

end.

