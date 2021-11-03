unit UCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  vcl.Wwdbedit, Vcl.Buttons, vxlDBEdit, Vcl.Mask, Vcl.DBCtrls,ULib, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, vxlNavigator,Libs, Vcl.ComCtrls;

type
  TfrmCadastroClientes = class(TForm)
    Panel1: TPanel;
    lblNome: TLabel;
    lblIdentidade: TLabel;
    lblCPF: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    gpbEndRes: TGroupBox;
    Label7: TLabel;
    Bairro: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label22: TLabel;
    Label47: TLabel;
    Label80: TLabel;
    btnBuscarCEP: TBitBtn;
    Label1: TLabel;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet1Nome: TStringField;
    DBNome: TDBEdit;
    DBIdentidade: TDBEdit;
    ClientDataSet1Logra: TStringField;
    ClientDataSet1Numero: TStringField;
    ClientDataSet1Bairro: TStringField;
    ClientDataSet1Estado: TStringField;
    ClientDataSet1Pais: TStringField;
    DBCPF: TDBEdit;
    DBTelefone: TDBEdit;
    DBEmail: TDBEdit;
    DBCEP: TDBEdit;
    ClientDataSet1CEP: TStringField;
    DBLogra: TDBEdit;
    DBNumero: TDBEdit;
    DBCompl: TDBEdit;
    DBBairro: TDBEdit;
    DBLocalidade: TDBEdit;
    DBEstado: TDBEdit;
    DBPais: TDBEdit;
    ClientDataSet1Compl: TStringField;
    ClientDataSet1Localidade: TStringField;
    ClientDataSet1CPF: TStringField;
    ClientDataSet1Identidade: TStringField;
    ClientDataSet1Telefone: TStringField;
    ClientDataSet1Email: TStringField;
    DBNavigator1: TDBNavigator;
    btnEnviarEmail: TButton;
    StatusBar1: TStatusBar;
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure _Validar;
    procedure DBCEPExit(Sender: TObject);
    procedure DBCPFExit(Sender: TObject);
    procedure DBEmailExit(Sender: TObject);
  private
    { Private declarations }
  public
     Endereco : TStringStream;
    { Public declarations }
  end;

var
  frmCadastroClientes: TfrmCadastroClientes;

implementation

{$R *.dfm}



procedure TfrmCadastroClientes._Validar;
begin
    if DBNome.Text = EmptyStr then
  begin
    DBNome.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBNome.DataField );
  end;
  if (DBIdentidade.Text = EmptyStr) or (DBIdentidade.text = '         ') then
  begin
     DBIdentidade.SetFocus;
     raise EErro.Create('Prencha o campo ' + DBIdentidade.DataField );
  end;
  if (DBCPF.Text = EmptyStr) or (DBCPF.Text = '           ') then
  begin
    DBCPF.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBCPF.DataField );
  end;
  if (DBTelefone.Text = EmptyStr) or (DBTelefone.text = '          ') then
  Begin
    DBTelefone.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBTelefone.DataField );
  End;
  if DBEmail.Text = EmptyStr then
  Begin
    DBEmail.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBEmail.DataField );
  End;
  if DBCEP.Text = EmptyStr then
  Begin
    DBCEP.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBCEP.DataField );
  End;
end;
procedure TfrmCadastroClientes.btnBuscarCEPClick(Sender: TObject);
Var
 Logra,
 Numero,
 Compl,
 Bairro,
 Cidade,
 Estado,
 Pais  : String;
begin
  Endereco := TStringStream.Create(Nil);
  Endereco := BuscarCEPNoViaCEP(StringReplace(DBCEP.EditText, '-', '', [rfReplaceAll]));

  if  UTF8ToString(Endereco.DataString) = '{'#$A'  "erro": true'#$A'}'    then
   ShowMessage('CEP Invalido')
  else
    LerResultadoCEP(Logra,
                    Numero,
                    Compl,
                    Bairro,
                    Cidade,
                    Estado,
                    Pais,
                    Endereco);


  DBLogra.Text   := Logra;
  DBNumero.Text   := Numero;
  DBCompl.Text   := Compl;
  DBBairro.Text  := Bairro;
  DBLocalidade.Text  := Cidade;
  DBEstado.Text  := Estado;
  DBPais.Text  := Pais;


end;

procedure TfrmCadastroClientes.btnEnviarEmailClick(Sender: TObject);
Var
 Path : String;
begin

 _Validar;
 StatusBar1.Visible := True;
 Application.ProcessMessages;
 Path := extractfilepath(application.exename)+'Cadastro.xml';
MontarXML (DBNome.Text,
           DBIdentidade.Text,
           DBCPF.Text,
           DBTelefone.Text,
           DBEmail.Text,
           DBCEP.Text,
           DBLogra.Text,
           DBNumero.Text,
           DBCompl.Text,
           DBBairro.Text,
           DBLocalidade.Text,
           DBEstado.Text,
           DBPais.Text,
           Path);

 EnviarEMail(DBEmail.Text,DBNome.Text,Path);
 StatusBar1.Visible := False;
end;

procedure TfrmCadastroClientes.ClientDataSet1AfterPost(DataSet: TDataSet);
begin



   DBNome.SetFocus;
end;

procedure TfrmCadastroClientes.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  _Validar;
end;

procedure TfrmCadastroClientes.DBCPFExit(Sender: TObject);
begin
   if not ValidaCPF(DBCPF.Text) then
   begin
    DBCPF.SetFocus;
    raise EErro.Create('CPF inválido.');
   end;

end;

procedure TfrmCadastroClientes.DBEmailExit(Sender: TObject);
begin
   if not ValidarEMail(DBEmail.Text) then
   begin
    DBEmail.SetFocus;
    raise EErro.Create('E-Mail inválido.');
   end;
end;

procedure TfrmCadastroClientes.DBCEPExit(Sender: TObject);
begin
//  btnBuscarCEPClick(Self);
end;

procedure TfrmCadastroClientes.FormShow(Sender: TObject);
begin
  // Cria tabela temporária na memória.
   ClientDataSet1.CreateDataSet;
   // Abre a tabela depois de criada.
   ClientDataSet1.Open;

   DBCEP.Field.EditMask:= '00000\-999;1;_'; // Formatação CEP

   DBCPF.Field.EditMask:= '000\.000\.000\-00;0;'; // Formatação CPF

   DBTelefone  .Field.EditMask:= '\(00\)0000\-0000;0;'; // Foamatação Telefone

   DBIdentidade.Field.EditMask:= '00\.000\.000\-0;0;';  // Formatação Identidicação

   DBNome.SetFocus;

end;

end.
