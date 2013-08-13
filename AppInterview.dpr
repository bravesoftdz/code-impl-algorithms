program AppInterview;

uses
  Vcl.Forms,
  App in 'App.pas' {Form1},
  Sample in 'Sample.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
