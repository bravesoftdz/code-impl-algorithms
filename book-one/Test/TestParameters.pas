unit TestParameters;


interface

uses
  TestFramework, Parameters;

type

  TestTParameters = class(TTestCase)
  published
    procedure TestProc01;
    procedure TestProc02;
    procedure TestProc03;
    procedure TestProc04;

    procedure TestProc05;
  end;

implementation

procedure TestTParameters.TestProc01;
var
  Data: string;
begin
  Data:= '11';

  TParameters.Proc01( Data );

  CheckEqualsString( 'OK', Data );
end;

procedure TestTParameters.TestProc02;
var
  Data: string;
  Data01: Integer;
  Data02: Boolean;
begin

  Data02:= True;

  Data:= 'FAIL';

  TParameters.Proc02( Data, Data01, Data02 );


  CheckEquals( 1000, Data01 );
  CheckEqualsString( 'OK', Data );
end;


procedure TestTParameters.TestProc03;
var
  Data: string;
begin

  Data:= 'FAIL';

  TParameters.Proc03( Data );

  CheckEqualsString( 'OK', Data );
end;

procedure TestTParameters.TestProc04;
begin

  TParameters.Proc04( [ 11, 'pro' ] );

  CheckTrue( True );

end;

procedure TestTParameters.TestProc05;
begin
 // TParameters.Proc05();
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTParameters.Suite);
end.

