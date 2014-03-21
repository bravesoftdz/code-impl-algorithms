unit DrawImage;

interface

uses
  Vcl.Graphics;

type
  TWInfoImage = array of array of TColor;

  IWImage = interface
    ['{31D67045-A2D8-4679-81DE-EB5E21A1887A}']
    function Image(): TWInfoImage;
  end;

  NumberOne = class(TInterfacedObject, IWImage)
  public
    function Image(): TWInfoImage;
  end;

  procedure Clear( const AWImage: TWInfoImage );

implementation

uses
  Vcl.Dialogs;

procedure Clear( const AWImage: TWInfoImage );
var
  Line: Integer;
  Column: Integer;
begin
  for Line := Low( AWImage ) to High( AWImage ) do
    for Column := Low( AWImage[Line] ) to High( AWImage[Line] ) do
       AWImage[ Line, Column ]:= clWhite;
end;

function NumberOne.Image: TWInfoImage;
var
  Line: Integer;
  Column: Integer;
begin
  SetLength( Result, 7, 7 );

  Clear( Result );

  Result[0, 3]:= clBlack;
  Result[1, 2]:= clBlack;
  Result[1, 3]:= clBlack;
  Result[2, 1]:= clBlack;
  Result[2, 3]:= clBlack;
  Result[3, 3]:= clBlack;
  Result[4, 3]:= clBlack;
  Result[5, 3]:= clBlack;

  Result[6, 1]:= clBlack;
  Result[6, 2]:= clBlack;
  Result[6, 3]:= clBlack;
  Result[6, 4]:= clBlack;
  Result[6, 5]:= clBlack;
end;

end.
