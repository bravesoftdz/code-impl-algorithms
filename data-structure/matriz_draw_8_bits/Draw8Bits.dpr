program Draw8Bits;

uses
  Vcl.Forms,
  Panel in 'Panel.pas' {Form2},
  DrawImage in 'DrawImage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
