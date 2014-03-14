unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  PApontador = ^TNode;
  TNode = record
    Valor: String;
    Proximo: PApontador;
  end;


  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    BitBtn5: TBitBtn;
    TabSheet4: TTabSheet;
    Panel4: TPanel;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    GridDisplay: TStringGrid;
    StatusBar1: TStatusBar;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure BitBtn5Click(Sender: TObject);
  private
    PrimeiroNo: PApontador;
  public
    VetorEstatico: array [0..4] of Integer;
    VetorDinamicoInt: array of Integer;
    VetorDinamicoStr: array of String;
    MatrizDinamica: array of array of string;
  end;

var
  Form2: TForm2;

implementation

uses
  System.TypInfo;

{$R *.dfm}

// converte para string o valor do ponteiro
function GetAddressOf( var X ) : String;
begin
  Result := IntToHex( Integer( Pointer( @X ) ), 8 );
end;

// Converte o valor do ponteiro par auma
// representação decinal
function PointerToDecimal( var X ): string;
begin
  Result:= IntToStr( StrToInt('$' + GetAddressOf( X ) ) )
end;

// Converte o valor do ponteiro par auma
// representação decinal
function PointerToHexadecinal( var X ): string;
begin
  Result:= IntToHex( StrToInt('$' + GetAddressOf( X ) ) , 4)
end;

function ShowValue( const APointer: PString  ): string;
var
  Str: String;
begin
  Str:= APointer^;
  Result:= Str;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  Indice: Integer;
begin
  // popula o vetor
  VetorEstatico[0]:= 1;
  VetorEstatico[1]:= 10;
  VetorEstatico[2]:= 100;
  VetorEstatico[3]:= 1000;
  VetorEstatico[4]:= 10000;

  // Define a linhas do Grid
  GridDisplay.RowCount:= Succ(Length( VetorEstatico ));
  // Exibe as informações no grid
  for Indice := Low(VetorEstatico) to High(VetorEstatico) do
  begin
    GridDisplay.Cells[0, Succ( Indice )]:= 'VetorEstatico';
    GridDisplay.Cells[1, Succ( Indice )]:= Indice.ToString;
    GridDisplay.Cells[2, Succ( Indice )]:= VetorEstatico[Indice].ToString;
    GridDisplay.Cells[3, Succ( Indice )]:= PointerToHexadecinal( VetorEstatico[Indice] );
    GridDisplay.Cells[4, Succ( Indice )]:= PointerToDecimal( VetorEstatico[Indice] );
  end;

end;

procedure TForm2.BitBtn2Click(Sender: TObject);
var
  NoAuxiliar: PApontador;
begin

  NoAuxiliar:= PrimeiroNo;
  while ( NoAuxiliar <> nil ) do
  begin
    Dispose( NoAuxiliar );

    NoAuxiliar:= NoAuxiliar.Proximo;
  end;

end;

procedure TForm2.BitBtn3Click(Sender: TObject);
var
  Indice, IdxGrid: Integer;
begin
  SetLength( VetorDinamicoInt, 1 );
  VetorDinamicoInt[0]:= 10;
  SetLength( VetorDinamicoStr, 1 );
  VetorDinamicoStr[0]:= 'Brasil';

  SetLength( VetorDinamicoInt, 2 );
  VetorDinamicoInt[1]:= 20;
  SetLength( VetorDinamicoStr, 2 );
  VetorDinamicoStr[1]:= 'Argetina';

  SetLength( VetorDinamicoInt, 3 );
  VetorDinamicoInt[2]:= 30;
  SetLength( VetorDinamicoStr, 3 );
  VetorDinamicoStr[2]:= 'Paraguai';

  SetLength( VetorDinamicoInt, 4 );
  VetorDinamicoInt[3]:= 40;
  SetLength( VetorDinamicoStr, 4 );
  VetorDinamicoStr[3]:= 'Uruguai';

  // Define o tamanho do Grid
  GridDisplay.RowCount:= Succ( Length( VetorDinamicoInt ) + Length( VetorDinamicoStr ));
  // Exibe as informações no grid
  for Indice := Low(VetorDinamicoInt) to High(VetorDinamicoInt) do
  begin
    IdxGrid:= Succ( Indice );

    GridDisplay.Cells[0, IdxGrid]:= 'VetorDinamicoInt';
    GridDisplay.Cells[1, IdxGrid]:= Indice.ToString;
    GridDisplay.Cells[2, IdxGrid]:= VetorDinamicoInt[Indice].ToString;
    GridDisplay.Cells[3, IdxGrid]:= PointerToHexadecinal( VetorDinamicoInt[Indice] );
    GridDisplay.Cells[4, IdxGrid]:= PointerToDecimal( VetorDinamicoInt[Indice] );
  end;
  for Indice := Low(VetorDinamicoStr) to High(VetorDinamicoStr) do
  begin
    // Cálcula o indice da linha no Grid
    IdxGrid:= Succ( Length( VetorDinamicoInt ) + Indice );

    GridDisplay.Cells[0, ( IdxGrid )]:= 'VetorDinamicoStr';
    GridDisplay.Cells[1, ( IdxGrid )]:= Indice.ToString;
    GridDisplay.Cells[2, ( IdxGrid )]:= VetorDinamicoStr[Indice];
    GridDisplay.Cells[3, ( IdxGrid )]:= PointerToHexadecinal( VetorDinamicoStr[Indice] );
    GridDisplay.Cells[4, ( IdxGrid )]:= PointerToDecimal( VetorDinamicoStr[Indice] );
  end;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
var
  _Hex: string;
  _HexDig: string;
  _Value: Variant;
  P: Pointer;
  pT: PTypeInfo;
begin

  _HexDig:= InputBox('Hexadecinam', 'Digite o valor do ponteiro', '' );

  P:= PString( StrToInt ( '$' + _HexDig ) );

  ShowMessage( String( p^ ) );
  {
  pt:= PTypeInfo( @p );
  if ( pT^.Kind = tkWString ) then
  }
end;


procedure TForm2.BitBtn5Click(Sender: TObject);
var
  Coluna, Linha, IdxGrid: Integer;

begin
  IdxGrid:= 0;

  SetLength(MatrizDinamica, 2, 2 );

  MatrizDinamica[0][0]:= 'Brasil';
  MatrizDinamica[0][1]:= 'Argentina';
  MatrizDinamica[1][0]:= 'Uruguai';
  MatrizDinamica[1][1]:= 'Paraguai';

  for Linha := Low(MatrizDinamica) to High(MatrizDinamica) do
  begin
    for Coluna := Low(MatrizDinamica[Linha]) to High(MatrizDinamica[Linha]) do
    begin
      // Cálcula o indice da linha no Grid
      Inc( IdxGrid );
      GridDisplay.RowCount:= Succ( IdxGrid );

      GridDisplay.Cells[0, ( IdxGrid )]:= 'MatrizDinamica';
      GridDisplay.Cells[1, ( IdxGrid )]:= '[' + Linha.ToString + ',' + Coluna.ToString + ']';
      GridDisplay.Cells[2, ( IdxGrid )]:= MatrizDinamica[Linha, Coluna];
      GridDisplay.Cells[3, ( IdxGrid )]:= PointerToHexadecinal( MatrizDinamica[Linha, Coluna] );
      GridDisplay.Cells[4, ( IdxGrid )]:= PointerToDecimal( MatrizDinamica[Linha, Coluna] );

    end;
  end;


end;

procedure TForm2.BitBtn6Click(Sender: TObject);
var
  NoAuxiliar: PApontador;
begin
  New( NoAuxiliar );  // alocando espaço na memória

  NoAuxiliar.Proximo:=PrimeiroNo;
  NoAuxiliar.Valor:= ( InputBox('', 'Digite uma string', '') );

  PrimeiroNo:= NoAuxiliar;
end;




procedure TForm2.BitBtn7Click(Sender: TObject);
var
  NoAuxiliar: PApontador;
  IdxGrid: Integer;
  Tamanho: Integer;
begin
  IdxGrid:= 0;

  NoAuxiliar:= PrimeiroNo;
  while ( NoAuxiliar <> nil ) do
  begin
    Inc( IdxGrid );

    GridDisplay.RowCount:= Succ( IdxGrid );
    GridDisplay.Cells[0, ( IdxGrid )]:= 'ListaEncadeada(TNode)';
    GridDisplay.Cells[1, ( IdxGrid )]:= IdxGrid.ToString;
    GridDisplay.Cells[2, ( IdxGrid )]:= NoAuxiliar.Valor;
    GridDisplay.Cells[3, ( IdxGrid )]:= Format( '%p', [NoAuxiliar] ) ;
    GridDisplay.Cells[4, ( IdxGrid )]:= IntToStr( StrToInt('$' + Format( '%p', [NoAuxiliar] ) ) );

    NoAuxiliar:= NoAuxiliar.Proximo;
  end;

end;

procedure TForm2.BitBtn8Click(Sender: TObject);
var
  NoAuxiliar, NoAnterior: PApontador;
  ValorASerExcluido: string;
begin
  ValorASerExcluido:= InputBox('', 'Digite uma string', '');

  // caso tenha somente um registro e o valor a ser excluíd é igual
  //
  if ( PrimeiroNo.Proximo = nil ) or ( PrimeiroNo.Valor = ValorASerExcluido ) then
  begin
    NoAuxiliar:= PrimeiroNo;
    PrimeiroNo:= PrimeiroNo.Proximo;
    Dispose( NoAuxiliar );
  end else
  begin
    // Percorre o nó até encontrar o registro a ser excluído
    NoAuxiliar:= PrimeiroNo;
    while ( NoAuxiliar.Proximo <> nil ) do
    begin
      if ( NoAuxiliar.Proximo.Valor = ValorASerExcluido ) then
      begin
        NoAnterior:= NoAuxiliar; // pega o item anterio
        NoAnterior.Proximo:= NoAuxiliar.Proximo.Proximo; // Mudar o ponteiro para excluir o item
        Exit(); // se encontrou o registro sai do laço
      end;
      NoAuxiliar:= NoAuxiliar.Proximo;
    end;
  end;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  GridDisplay.Cols[0].Text:= 'Variável';
  GridDisplay.Cols[1].Text:= 'Indice Vetor';
  GridDisplay.Cols[2].Text:= 'Valor Vetor';
  GridDisplay.Cols[3].Text:= 'Ponteiro(Hex)';
  GridDisplay.Cols[4].Text:= 'Ponteiro(Dec)';
end;

procedure TForm2.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  GridDisplay.RowCount:= 0
end;

end.


