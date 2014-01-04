unit AllocMemory;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TAllocMemory = class
  strict private
    StringList: TStringList;
  public

    constructor Create();
    destructor Destroy; override;
  end;

implementation



{ TAllocMemory }

constructor TAllocMemory.Create;
var
  Count: Integer;
begin
  StringList:= TStringList.Create();

  for Count := 0 to 1000000 do
    StringList.Add( StringOfChar( '0' , 100 ) );

end;

destructor TAllocMemory.Destroy;
begin
  FreeAndNil( StringList );
  //StringList:= nil;

  inherited;
end;

end.
