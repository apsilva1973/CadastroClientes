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
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    ClientDataSet1Logra: TStringField;
    ClientDataSet1Numero: TStringField;
    ClientDataSet1Bairro: TStringField;
    ClientDataSet1Estado: TStringField;
    ClientDataSet1Pais: TStringField;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    ClientDataSet1CEP: TStringField;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    ClientDataSet1Compl: TStringField;
    ClientDataSet1Localidade: TStringField;
    ClientDataSet1CPF: TStringField;
    ClientDataSet1Identidade: TStringField;
    ClientDataSet1Telefone: TStringField;
    ClientDataSet1Email: TStringField;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure _Validar;
    procedure DBEdit6Exit(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit5Exit(Sender: TObject);
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
    if DBEdit1.Text = EmptyStr then
  begin
    DBEdit1.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBEdit1.DataField );
  end;
  if (DBEdit2.Text = EmptyStr) or (DBEdit2.text = '         ') then
  begin
     DBEdit2.SetFocus;
     raise EErro.Create('Prencha o campo ' + DBEdit2.DataField );
  end;
  if (DBEdit3.Text = EmptyStr) or (DBEdit3.Text = '           ') then
  begin
    DBEdit3.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBEdit3.DataField );
  end;
  if (DBEdit4.Text = EmptyStr) or (DbEdit4.text = '          ') then
  Begin
    DBEdit4.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBEdit4.DataField );
  End;
  if DBEdit5.Text = EmptyStr then
  Begin
    DBEdit5.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBEdit5.DataField );
  End;
  if DBEdit6.Text = EmptyStr then
  Begin
    DBEdit6.SetFocus;
    raise EErro.Create('Prencha o campo ' + DBEdit6.DataField );
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
  Endereco := BuscarCEPNoViaCEP(StringReplace(DBEdit6.EditText, '-', '', [rfReplaceAll]));

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


  DBEdit7.Text   := Logra;
  DBEdit8.Text   := Numero;
  DBEdit9.Text   := Compl;
  DBEdit10.Text  := Bairro;
  DBEdit11.Text  := Cidade;
  DBEdit12.Text  := Estado;
  DBEdit13.Text  := Pais;


end;

procedure TfrmCadastroClientes.Button1Click(Sender: TObject);
Var
 Path : String;
begin

 _Validar;
 StatusBar1.Visible := True;
 Application.ProcessMessages;
 Path := extractfilepath(application.exename)+'Cadastro.xml';
MontarXML (DBEdit1.Text,
           DBEdit2.Text,
           DBEdit3.Text,
           DBEdit4.Text,
           DBEdit5.Text,
           DBEdit6.Text,
           DBEdit7.Text,
           DBEdit8.Text,
           DBEdit9.Text,
           DBEdit10.Text,
           DBEdit11.Text,
           DBEdit12.Text,
           DBEdit13.Text,
           Path);

 EnviarEMail(DBEdit5.Text,DBEdit1.Text,Path);
 StatusBar1.Visible := False;
end;

procedure TfrmCadastroClientes.ClientDataSet1AfterPost(DataSet: TDataSet);
begin



   dbedit1.SetFocus;
end;

procedure TfrmCadastroClientes.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  _Validar;
end;

procedure TfrmCadastroClientes.DBEdit3Exit(Sender: TObject);
begin
   if not ValidaCPF(DBEdit3.Text) then
   begin
    DBEdit3.SetFocus;
    raise EErro.Create('CPF inválido.');
   end;

end;

procedure TfrmCadastroClientes.DBEdit5Exit(Sender: TObject);
begin
   if not ValidarEMail(DBEdit5.Text) then
   begin
    DBEdit5.SetFocus;
    raise EErro.Create('E-Mail inválido.');
   end;
end;

procedure TfrmCadastroClientes.DBEdit6Exit(Sender: TObject);
begin
//  btnBuscarCEPClick(Self);
end;

procedure TfrmCadastroClientes.FormShow(Sender: TObject);
begin
  // Cria tabela temporária na memória.
   ClientDataSet1.CreateDataSet;
   // Abre a tabela depois de criada.
   ClientDataSet1.Open;

   DBEdit6.Field.EditMask:= '00000\-999;1;_'; // Formatação CEP

   DBEdit3.Field.EditMask:= '000\.000\.000\-00;0;'; // Formatação CPF

   DBEdit4  .Field.EditMask:= '\(00\)0000\-0000;0;'; // Foamatação Telefone

   DBEdit2.Field.EditMask:= '00\.000\.000\-0;0;';  // Formatação Identidicação

   dbedit1.SetFocus;

end;

end.
