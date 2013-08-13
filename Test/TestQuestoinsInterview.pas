unit TestQuestoinsInterview;

interface

uses
  TestFramework, System.SysUtils;

type

  TestTSampleInterview = class(TTestCase)
  strict private
    const LENGTH_ARRAY = 1000000;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsODD;
    procedure TestIsNotODD;
    procedure TestPowerTwo;
    procedure TestIsNotPowerTwo;
    procedure TestIsPowerTwo1024;
    procedure TestIsPowerTwo16;
    procedure TestIsPowerTwo512;
    procedure TestIsPowerTwo1;
    procedure TestIsPowerTwo0;

    procedure TestFindNumberInArray;
    procedure TestNotFondNumberInArray;

    procedure TestReverseString();
    procedure TestReverseStringDOUGLAS();

    procedure TestVerifyNumberTwice();

    procedure TestVerifyNumberTwiceIsNotFoud();
    procedure TestVerifyNumberTwiceFirst();
    procedure TestVerifyNumberTwiceLast();
  end;

implementation



uses QuestionsInterview;



procedure TestTSampleInterview.SetUp;
begin
  //
end;


procedure TestTSampleInterview.TearDown;
begin
  //
end;


procedure TestTSampleInterview.TestFindNumberInArray;
begin
  CheckTrue( TSampleInterview.FindNumberInArray( 2, [0, 1, 2, 3, 4, 5, 6] ) );
end;

procedure TestTSampleInterview.TestIsNotODD;
begin
  CheckFalse( TSampleInterview.IsOdd( 2 ) );
end;



procedure TestTSampleInterview.TestIsNotPowerTwo;
begin
  CheckFalse( TSampleInterview.IsPowerTwo( 10 ) );
end;



procedure TestTSampleInterview.TestIsODD;
begin

  CheckTrue( TSampleInterview.IsOdd( 5 ) );
end;



procedure TestTSampleInterview.TestIsPowerTwo0;
begin
  CheckFalse( TSampleInterview.IsPowerTwo( 0 ) );
end;



procedure TestTSampleInterview.TestIsPowerTwo1;
begin
  CheckFalse( TSampleInterview.IsPowerTwo( 1 ) );
end;



procedure TestTSampleInterview.TestIsPowerTwo1024;
begin
  CheckTrue( TSampleInterview.IsPowerTwo( 1024 ) );
end;



procedure TestTSampleInterview.TestIsPowerTwo16;
begin
  CheckTrue( TSampleInterview.IsPowerTwo( 16 ) );
end;



procedure TestTSampleInterview.TestIsPowerTwo512;
begin
  CheckTrue( TSampleInterview.IsPowerTwo( 512 ) );
end;



procedure TestTSampleInterview.TestNotFondNumberInArray;
begin
   CheckFalse( TSampleInterview.FindNumberInArray( 1200 , [0, 1111, 14422, 42343, 43423, 233, 3446] ) );
end;



procedure TestTSampleInterview.TestPowerTwo;
begin
  CheckTrue( TSampleInterview.IsPowerTwo( 2 ) );
end;



procedure TestTSampleInterview.TestReverseString;
begin
  CheckEquals( 'inhoj' , TSampleInterview.ReverseString( 'johni' ) );
end;



procedure TestTSampleInterview.TestReverseStringDOUGLAS;
begin
  CheckEquals( 'salguod', TSampleInterview.ReverseString( 'douglas' ) );
end;



procedure TestTSampleInterview.TestVerifyNumberTwice;
var
  Index: Integer;
  Arr: array of Integer;
begin
  SetLength( Arr, LENGTH_ARRAY );

  for Index:= Low( Arr ) to High( Arr ) do
    Arr[Index]:= Index;

  Arr[ Trunc( LENGTH_ARRAY / 2 ) ]:= 500000;

  CheckTrue( TSampleInterview.VerifyNumberTwice( Arr ) );
end;



procedure TestTSampleInterview.TestVerifyNumberTwiceFirst;
var
  Index: Integer;
  Arr: array of Integer;
begin
  SetLength( Arr, LENGTH_ARRAY );

  for Index:= Low( Arr ) to High( Arr ) do
    Arr[Index]:= Index;

  Arr[ Low( Arr ) ]:= 500000;

  CheckTrue( TSampleInterview.VerifyNumberTwice( Arr ) );

end;


procedure TestTSampleInterview.TestVerifyNumberTwiceIsNotFoud;
var
  Index: Integer;
  Arr: array of Integer;
begin
  SetLength( Arr, LENGTH_ARRAY );

  for Index:= Low( Arr ) to High( Arr ) do
    Arr[Index]:= Index;

  CheckFalse( TSampleInterview.VerifyNumberTwice( Arr ) );

end;

procedure TestTSampleInterview.TestVerifyNumberTwiceLast;
var
  Index: Integer;
  Arr: array of Integer;
begin
  SetLength( Arr, LENGTH_ARRAY );

  for Index:= Low( Arr ) to High( Arr ) do
    Arr[Index]:= Index;

  Arr[ High( Arr ) ]:= 50000;

  CheckTrue( TSampleInterview.VerifyNumberTwice( Arr ) );
end;



initialization
  // Register any test cases with the test runner
  RegisterTest(TestTSampleInterview.Suite);
end.

