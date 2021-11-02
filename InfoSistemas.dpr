program InfoSistemas;

uses
  Vcl.Forms,
  UCadClientes in 'UCadClientes.pas' {frmCadastroClientes},
  ULib in 'ULib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroClientes, frmCadastroClientes);
  Application.Run;
end.
