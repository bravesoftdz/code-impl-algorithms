unit CarrinhoDeCompras;

interface

uses
  Generics.Collections;

type
  TItem = class
  strict private
    Descricao: string;
    Quantidade: Integer;
    ValorUnitario: Currency;
  public
    constructor Create( const ADescricao: string; const AQuantidade: Integer;
      const AValorUnitario: Currency );

    function getValorTotal(): Currency;
  end;

  TCarrinhoDeCompras = class
  private
    Itens: TObjectList<TItem>;
  public
    constructor Create();
    destructor Destroy; override;

    procedure Adiciona( Item: TItem );
    function getItens(): TObjectList<TItem>;
    function Encontra( const ACarrinhoDeCompras: TCarrinhoDeCompras): Currency;
  end;

implementation

{ TCarrinhoDeCompras }

function TCarrinhoDeCompras.Encontra(
  const ACarrinhoDeCompras: TCarrinhoDeCompras): Currency;
var
  Maior: Currency;
  Item: TItem;
begin
  if ACarrinhoDeCompras.getItens.Count = 0 then
    Result:= 0
  else
  begin
    Maior:= ACarrinhoDeCompras.getItens[0].getValorTotal();
    for Item in ACarrinhoDeCompras.getItens do
      if ( Maior < Item.getValorTotal ) then
        Maior:= Item.getValorTotal();

    Result:= Maior;
  end;
end;

procedure TCarrinhoDeCompras.Adiciona(Item: TItem);
begin
  Itens.Add( Item )
end;


function TCarrinhoDeCompras.getItens: TObjectList<TItem>;
begin
  Result:= Itens;
end;

constructor TCarrinhoDeCompras.Create;
begin
  Itens:= TObjectList<TItem>.Create
end;

destructor TCarrinhoDeCompras.Destroy;
begin
  Itens.Free;

  inherited;
end;

{ TItem }

constructor TItem.Create(const ADescricao: string; const AQuantidade: Integer;
  const AValorUnitario: Currency);
begin
  Descricao    := ADescricao;
  Quantidade   := AQuantidade;
  ValorUnitario:= AValorUnitario;
end;

function TItem.getValorTotal: Currency;
begin
  Result:= ValorUnitario * Quantidade;
end;

end.
