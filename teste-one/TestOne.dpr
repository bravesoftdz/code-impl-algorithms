program TestOne;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  ConversorDeNumeroRomano in 'ConversorDeNumeroRomano.pas',
  TestConversorDeNumeroRomano in 'TestConversorDeNumeroRomano.pas',
  CarrinhoDeCompras in 'CarrinhoDeCompras.pas',
  TestCarrinhoDeCompras in 'TestCarrinhoDeCompras.pas',
  MaiorPreco in 'MaiorPreco.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

