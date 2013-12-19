unit TestAllocMemory;


interface

uses
  TestFramework, System.SysUtils, System.Classes, AllocMemory;

type
  TestTAllocMemory = class(TTestCase)
  published
    procedure Test();
  end;

implementation


{ TestTAllocMemory }

procedure TestTAllocMemory.Test;
var
  O: TAllocMemory;
begin
  O:= TAllocMemory.Create();
  try



  finally
    FreeAndNil( O )
  end;

end;

initialization
  RegisterTest( TestTAllocMemory.Suite );
end.

