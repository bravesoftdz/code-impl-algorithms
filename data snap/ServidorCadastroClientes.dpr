program ServidorCadastroClientes;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormPrincipal in 'FormPrincipal.pas' {Form1},
  WebModule in 'WebModule.pas' {WebModule1: TWebModule},
  ServerMethods in 'ServerMethods.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
