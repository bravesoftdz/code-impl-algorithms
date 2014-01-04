program AppAlgorithms;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  QuestionsInterview in 'QuestionsInterview.pas',
  Parameters in 'Parameters.pas',
  TestParameters in 'Test\TestParameters.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
