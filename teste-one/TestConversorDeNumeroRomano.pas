unit TestConversorDeNumeroRomano;

interface

uses
  TestFramework, FirstClass, ConversorDeNumeroRomano;

type
  TTestConversorDeNumeroRomano = class(TTestCase)
  strict private
    ConversorDeNumeroRomano: TConversorDeNumeroRomano;
  protected
   procedure SetUp; override;
   procedure TearDown; override;

  published
    procedure deveEntenderOSimboloI;
    procedure deveEntenderOSimboloII;
    procedure deveEntenderOSimboloV;
    procedure deveEntenderQuatroSimbolosDoisADoisComoXXII();
    procedure deveEntenderNumerosRomanodsComoIX();
    procedure deveEntenderNumerosComplexosComoXXIV();
  end;

implementation


procedure TTestConversorDeNumeroRomano.deveEntenderNumerosComplexosComoXXIV;
begin
  CheckEquals( 24, ConversorDeNumeroRomano.Converte( 'XXIV' ) );
end;

procedure TTestConversorDeNumeroRomano.deveEntenderNumerosRomanodsComoIX;
begin
  CheckEquals( 9, ConversorDeNumeroRomano.Converte( 'IX' ) );
end;

procedure TTestConversorDeNumeroRomano.deveEntenderOSimboloI;
begin
  CheckEquals( 1, ConversorDeNumeroRomano.Converte( 'I' ) );
end;

procedure TTestConversorDeNumeroRomano.deveEntenderOSimboloII;
begin
  CheckEquals( 2, ConversorDeNumeroRomano.Converte( 'II' ) );
end;

procedure TTestConversorDeNumeroRomano.deveEntenderOSimboloV;
begin
  CheckEquals( 5, ConversorDeNumeroRomano.Converte( 'V' ) );
end;

procedure TTestConversorDeNumeroRomano.deveEntenderQuatroSimbolosDoisADoisComoXXII;
begin

  CheckEquals( 22, ConversorDeNumeroRomano.Converte( 'XXII' ) );
end;

procedure TTestConversorDeNumeroRomano.SetUp;
begin
  inherited;
  ConversorDeNumeroRomano:= TConversorDeNumeroRomano.Create();
end;

procedure TTestConversorDeNumeroRomano.TearDown;
begin
  inherited;
  ConversorDeNumeroRomano.Free;
end;

initialization
  RegisterTest(TTestConversorDeNumeroRomano.Suite);
end.

