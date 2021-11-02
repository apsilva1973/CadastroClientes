unit ULib;

interface

uses System.Variants, SysUtils, Classes, Controls, Jpeg, IPPeerClient, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON,
  System.Generics.Collections, System.Contnrs,
  IdAuthentication,
  IdLogFile,
  IdSSLOpenSSL,  IdSMTP,
  IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase,Vcl.Dialogs;



function BuscarCEPNoViaCEP(UmCEP: string): TStringStream;
function LerResultadoCEP(var Logra,Numero,Compl,Bairro,Cidade,Estado,Pais:String;ResultadoCEP : TStringStream) : Boolean;
function ValidaCPF( cpf: string ): boolean;
procedure EnviarEMail(const MailTo: string; Cliente : String; Path : String);
procedure MontarXML (Nome,RG,CPF,Telefone,Email,CEP,Logra,Numero,Compl,Bairro,Cidade,Estado,Pais : String;Var Path:String);

implementation



function ValidaCPF( cpf: string ): boolean;
var
  soma, i, pos, erro, prim, seg, v: integer;
begin
  // Tirando os pontos da string "."
  cpf := StringReplace( cpf, '.', '', [ rfReplaceAll ] );

  // Verificando se a string tem nove numeros
  if Length( cpf ) < 11 then
    cpf := '0' + cpf;
  if Length( cpf ) < 11 then
    cpf := '0' + cpf; // coloca ate' 2 zeros
  // Encontrando o primeiro digito de verificacao
  soma := 0;
  pos := 1;
  for i := 10 downto 2 do
  begin
    Val( Copy( cpf, pos, 1 ), v, erro );
    if erro = 0 then
      soma := soma + v * i;
    pos := pos + 1;
  end;
  prim := ( Trunc( soma / 11 ) + 1 ) * 11 - soma;
  if prim > 9 then
    prim := 0;
  // Encontrando o segundo digito de verificacao
  soma := 0;
  pos := 1;
  for i := 11 downto 3 do
  begin
    Val( Copy( cpf, pos, 1 ), v, erro );
    if erro = 0 then
      soma := soma + v * i;
    pos := pos + 1;
  end;
  soma := soma + 2 * prim;
  seg := ( Trunc( soma / 11 ) + 1 ) * 11 - soma;
  if seg > 9 then
    seg := 0;
  // retorna TRUE se os digitos bateram
  Result := ( IntToStr( prim ) + IntToStr( seg ) ) = Copy( cpf, Length( cpf ) - 1, 2 );
end;

procedure MontarXML (Nome,RG,CPF,Telefone,Email,CEP,Logra,Numero,Compl,Bairro,Cidade,Estado,Pais : String;Var Path:String);
Var
  XML : String;
  SalveXML :  TStringList;
Begin
  SalveXML :=  TStringList.Create;
  XML := '<?xml version="1.0" encoding="utf-8"?> ' +
         '  <Cadastro> ' +
           '<nome> '+Nome+'</nome>' +
           '<Identificacao> '+RG+ '</Identificacao>' +
           '<CPF> '+CPF+'</CPF>' +
           '<Telefone> '+Telefone+'</Telefone>' +
           '<Email> '+Email+'</Email>' +
           '<CEP> '+CEP+'</CEP>' +
           '<Logradouro> '+Logra+'</Logradouro>' +
           '<Numero> '+Numero+'</Numero>' +
           '<Compl> '+Compl+'</Compl>' +
           '<Bairro> '+Bairro+'</Bairro>' +
           '<Cidade> '+Cidade+'</Cidade>' +
           '<Estado> '+Estado+'</Estado>' +
           '<Pais> '+Pais+'</Pais>' +
        '  </Cadastro> ';


 SalveXML.Add(XML);
 SalveXML.SaveToFile(Path);
End;

// Função para enviar e-mail
procedure EnviarEMail(const MailTo: string; Cliente : String; Path : String);
var
  // variáveis e objetos necessários para o envio
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
  sAnexo: string;
begin

 // instanciação dos objetos
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
  IdSMTP := TIdSMTP.Create(Nil);
  IdMessage := TIdMessage.Create(Nil);

  try

    // Configuração do servidor SMTP (TIdSMTP)
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    // Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
    IdSSLIOHandlerSocket.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;
    IdSMTP.UseTLS := utUseRequireTLS;

    IdSMTP.Port := 587;//25;//465;
    IdSMTP.Host := 'smtp.live.com';
    IdSMTP.Username := 'testesoftware1973@outlook.com';
    IdSMTP.Password := '@Vivi2468';

    // Configuração da mensagem (TIdMessage)
    IdMessage.From.Address := 'testesoftware1973@outlook.com';
    IdMessage.From.Name := 'Teste de Software';
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    //IdMessage.Recipients.Add.Text := 'epetapp2018@gmail.com';
    IdMessage.Recipients.Add.Text := MailTo;//'alexandre.silva@presenta.com.br';
    //IdMessage.Recipients.Add.Text := 'destinatario2@email.com'; // opcional
    //IdMessage.Recipients.Add.Text := 'destinatario3@email.com'; // opcional
    IdMessage.Subject := 'Cadastro de Clientes';
    IdMessage.Encoding := meMIME;

    // Configuração do corpo do email (TIdText)
    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add('Segue em anexo o Cadastro do Cliente ' + Cliente );
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    // Opcional - Anexo da mensagem (TIdAttachmentFile)
    sAnexo := Path;

    if FileExists(sAnexo) then
    begin
      TIdAttachmentFile.Create(IdMessage.MessageParts, sAnexo);
    end;

    // Conexão e autenticação
    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E:Exception do
      begin
        MessageDlg('Erro na conexão ou autenticação: ' +
          E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;

    // Envio da mensagem
    try
      IdSMTP.Send(IdMessage);
      MessageDlg('Mensagem enviada com sucesso!', mtInformation, [mbOK], 0);
    except
      On E:Exception do
      begin
        MessageDlg('Erro ao enviar a mensagem: ' +
          E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    // desconecta do servidor
    IdSMTP.Disconnect;
    // liberação da DLL
    UnLoadOpenSSLLibrary;
    // liberação dos objetos da memória
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;

end;

function LerResultadoCEP(var Logra,Numero,Compl,Bairro,Cidade,Estado,Pais :String;ResultadoCEP : TStringStream) : Boolean;
var LJSONBytes: TBytes;
    LJSONSObj: TJSONValue;
    LJSONArray: TJSONArray;
    LJSONValue, LReceive: TJSONValue;
    LJPair: TJSONPair;
    size: integer;
    i: Integer;
    ii: Integer;
    Tamanho: Integer;
begin

  LJSONBytes := TEncoding.ASCII.GetBytes(UTF8Decode(ResultadoCEP.DataString));

  LJSONSObj := TJSONObject.ParseJSONValue(LJSONBytes, 0);
  if LJSONSObj <> nil then
  try
    Logra   := StringReplace(TJSONObject(LJSONSObj).Get('logradouro').JsonValue.ToString, '"', '', [rfReplaceAll]);
    Numero  := StringReplace(TJSONObject(LJSONSObj).Get('complemento').JsonValue.ToString, '"', '', [rfReplaceAll]);
    Compl   := StringReplace(TJSONObject(LJSONSObj).Get('complemento').JsonValue.ToString, '"', '', [rfReplaceAll]);
    Bairro  := StringReplace(TJSONObject(LJSONSObj).Get('bairro').JsonValue.ToString, '"', '', [rfReplaceAll]);
    Cidade  := StringReplace(TJSONObject(LJSONSObj).Get('localidade').JsonValue.ToString, '"', '', [rfReplaceAll]);
    Estado  := StringReplace(TJSONObject(LJSONSObj).Get('uf').JsonValue.ToString, '"', '', [rfReplaceAll]);
    Pais    := 'Brasil';



  finally
    LJSONSObj.Free;
  end;
end;

function BuscarCEPNoViaCEP(UmCEP: string): TStringStream;
var
  IdHTTP: TIdHTTP;
  SSL : TIDSSLIOHandlerSocketOpenSSL;
  JsonRetorno : TStringStream;
begin

  JsonRetorno := TStringStream.Create(nil);
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIDSSLIOHandlerSocketOpenSSL.Create(nil);

 // Handle
  IdHTTP.IOHandler := SSL;
  SSL.SSLOptions.SSLVersions := [sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2];
  try
   try
    IdHTTP.get ('https://viacep.com.br/ws/' + UmCEP + '/json',JsonRetorno);

    if JsonRetorno <> Nil then
     Result := JsonRetorno;

   except
    // caso algo de errado.
   end;
  finally
   //livrar os objetos
   FreeAndNil(IdHTTP);
   FreeAndNil(SSL);
   //FreeAndNil(JsonRetorno);
  end;
end;

end.
