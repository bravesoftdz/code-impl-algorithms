unit Parameters;

interface

type
  TParameters = class
  public
    class procedure Proc01( out AParam: string );

    class procedure Proc02( var AParam;  out AParam1 ; const AParam2 );

    class procedure Proc03(  AParam: string );

    class procedure Proc04( AParam: array of const );

    class procedure Proc05();

  end;

var
//  Vet: array[0..100000000] of string;
  Vet: array of string;

implementation

{ TParameters }

class procedure TParameters.Proc01( out AParam: string );
var
  Data: string;
begin
  Data:= AParam;

  // Out apaga o valor da variável

  AParam:= 'OK';
end;

class procedure TParameters.Proc02( var AParam; out AParam1; const AParam2 );
begin
  Integer( AParam1 ):= 999;

  if ( Boolean ( AParam2 ) ) then
    Integer( AParam1 ):= 1000;


  string(AParam):= 'OK';

end;

class procedure TParameters.Proc03( AParam: string);
begin
  AParam:= 'OK';
end;

class procedure TParameters.Proc04(AParam: array of const);
begin

end;

class procedure TParameters.Proc05;

begin
   SetLength( Vet, 100000000 );
end;

end.
