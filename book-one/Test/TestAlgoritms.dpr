program TestAlgoritms;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestQuestoinsInterview in 'TestQuestoinsInterview.pas',
  QuestionsInterview in '..\QuestionsInterview.pas',
  TestParameters in 'TestParameters.pas',
  Parameters in '..\Parameters.pas',
  AllocMemory in '..\AllocMemory.pas',
  TestAllocMemory in 'TestAllocMemory.pas',
  ListasEncadeadas in '..\ListasEncadeadas.pas',
  TestListasEncadeadas in 'TestListasEncadeadas.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:= True;

  DUnitTestRunner.RunRegisteredTests;
end.

