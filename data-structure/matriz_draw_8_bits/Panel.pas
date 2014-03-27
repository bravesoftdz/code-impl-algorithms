unit Panel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    StringGrid1: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  DrawImage;

{$R *.dfm}

type
  THackPanel = class(TPanel);

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  I: IWImage;
  Img: TWInfoImage;
  Line: Integer;
  Coluna: Integer;

  procedure Print( const AColuna, ALinha: Integer; const AColor: TColor );
  var
    R: TRect;
  begin
    R := StringGrid1.CellRect(AColuna, ALinha);
    StringGrid1.Canvas.Brush.Color:= AColor;
    StringGrid1.Canvas.FillRect(R);
  end;

begin
  (*
  THackPanel( Panel1 ).Canvas.Pen.Style:= psClear;
  THackPanel( Panel1 ).Canvas.Brush.Color:= clRed;
  THackPanel( Panel1 ).Canvas.Rectangle( 20, 2, 0, 0 );
  *)

  I:= NumberOne.Create();
  Img:= I.Image();

  for Line := Low(Img) to High(Img) do
    for Coluna := Low(Img[Line]) to High(Img[Line]) do
      Print(Coluna, Line, Img[Line, Coluna]  )


end;

end.
