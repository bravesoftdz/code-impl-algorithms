unit QuestionsInterview;

interface

uses
  System.SysUtils;

type


  TSampleInterview = class
  public
    class function IsOdd( const ANumber: Integer ): Boolean;
    class function IsPowerTwo( const ANumber: Integer ): Boolean;
    class function FindNumberInArray( const ANumberFind: Integer; const AArrayNumber: array of Integer ): Boolean;
    class function ReverseString( const AString: string ): string;

    class function VerifyNumberTwice( const AArrayNumber: array of Integer ): Boolean;
  end;

implementation


{ TSampleInterview }


// Find number in array list of integer
// Example use TSampleInterview.FindNumberInArray( 1200 , [1000, 1010, 1050, 1200, 1250, 1300, 1400] )
class function TSampleInterview.FindNumberInArray(const ANumberFind: Integer;
  const AArrayNumber: array of Integer): Boolean;
var
  Index: Integer;
begin

  Result:= False;
  for Index:= Low( AArrayNumber ) to High( AArrayNumber ) do
  begin
    if ( ANumberFind = AArrayNumber[ Index ] ) then
    begin
      Result:= True;
      Break;
    end;
  end;

end;


// Check number is odd
class function TSampleInterview.IsOdd(const ANumber: Integer): Boolean;
begin
  Result:= (ANumber mod 2 ) <> 0;
end;



// Check number is power two
class function TSampleInterview.IsPowerTwo(const ANumber: Integer): Boolean;
var
  Number: Integer;
begin
  Result:= False;

  Number:= ANumber;

  // Not should odd and zero
  // Divider two to result one
  while  ( not (Number in [0, 1] ) ) and ( ( Number mod  2 ) = 0 ) do
  begin
    Number := Number - Trunc( Number / 2 );

    if ( Number = 1 ) then
      Result:= True;
  end;

end;



// Reverse string literal
class function TSampleInterview.ReverseString(const AString: string): string;
var
  Index: Integer;
begin
  for Index:= Length( AString ) downto 1 do
    Result:= Concat( Result, AString[ Index ] )
end;



// Verify number twice in array list
class function TSampleInterview.VerifyNumberTwice(
   const AArrayNumber: array of Integer): Boolean;
var
  Index: Integer;
  CurrentIndex: Integer;
  CurrentValue: Integer;
begin
  Result:= False;

  for CurrentIndex:= Low( AArrayNumber ) to High( AArrayNumber ) do
  begin
    CurrentValue:= AArrayNumber[ CurrentIndex ];

    for Index:= Low( AArrayNumber ) to High( AArrayNumber ) do
    begin
      // Ignore current index
      if ( CurrentIndex = Index ) then
        Continue;

      // Verify value
      if ( AArrayNumber[ Index ] = CurrentValue ) then
      begin
        Result:= True;
        Break;
      end;
    end;

  end;

end;



end.

