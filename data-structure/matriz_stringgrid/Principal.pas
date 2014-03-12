unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StringGrid1: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //MatrizEstatica: array [0..1, 0..3] of string;
    MatrizEstatica: array[0..4] of array[0..3] of string;
    MatrizDinamica: array of array of string;

    MatrizCores: array[0..4] of array[0..3] of TColor;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  IndiceLinha: Integer;
  IndiceColuna: Integer;
begin
  SetLength( MatrizDinamica, 2, 3 );  // 2 linhas 3 colunas

  MatrizDinamica[0, 0]:= 'Brasil';
  MatrizDinamica[0, 1]:= 'Argentina';
  MatrizDinamica[0, 2]:= 'Uruguai';
  MatrizDinamica[1, 0]:= 'Paraguai';
  MatrizDinamica[1, 1]:= 'Peru';
  MatrizDinamica[1, 2]:= 'Bolivia';

  for IndiceLinha := Low( MatrizDinamica ) to High(MatrizDinamica) do
  begin
    for IndiceColuna := Low(MatrizDinamica[IndiceLinha]) to High(MatrizDinamica[IndiceLinha]) do
    begin
      ShowMessage( MatrizDinamica[IndiceLinha, IndiceColuna] );
    end;
  end;
  // Random(256 * 256 * 256); // seleciona uma cor aleatoriamente
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
var
  IndiceLinha: Integer;
  IndiceColuna: Integer;

  function GetColor(): TColor;
  begin
    Result:= Random(256 * 256 * 256);
  end;

  procedure Print( const AColuna, ALinha: Integer; const AColor: TColor );
  var
    R: TRect;
  begin
    R := StringGrid1.CellRect(AColuna, ALinha);
    StringGrid1.Canvas.Brush.Color:= AColor;
    StringGrid1.Canvas.FillRect(R);
  end;

begin
  // Cria a matriz de cores
  for IndiceLinha := Low( MatrizCores ) to High(MatrizCores) do
  begin
    for IndiceColuna := Low(MatrizCores[IndiceLinha]) to High(MatrizCores[IndiceLinha]) do
    begin
      MatrizCores[IndiceLinha, IndiceColuna]:= GetColor();
    end;
  end;

  // Pinta no Grid a matriz de cores
  for IndiceLinha := Low( MatrizCores ) to High(MatrizCores) do
  begin
    for IndiceColuna := Low(MatrizCores[IndiceLinha]) to High(MatrizCores[IndiceLinha]) do
    begin
      Print(IndiceColuna, IndiceLinha, MatrizCores[IndiceLinha, IndiceColuna] );
    end;
  end;

end;

end.
