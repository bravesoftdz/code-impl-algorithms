unit Unit10;

interface

uses
  System.Math,
  Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type

  TRifa = class
  public
    Nome: string;
    Endereco: string;
    Telefone: string;
  public
    constructor Create(const ANome, AEndereco, ATelefone: string);
  end;


  TForm10 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    EdtNumero: TEdit;
    EdtNome: TEdit;
    EdtEndereco: TEdit;
    EdtTelefone: TEdit;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    Sorteio: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    const SEP = ':';

    { Private declarations }
    procedure AdicionaHash( const Chave: Integer );


  public
    { Public declarations }
    VendasRifa: TObjectDictionary<Integer, TRifa>;

    TabelaHash: array of Integer;
  end;

var
  Form10: TForm10;



implementation

{$R *.dfm}

{ TRifa }

procedure GravarArquivoTextFile();
var
  // Variável que representa o arquivo
  Arquivo: TextFile;
begin
  // Associa o nome arquivo em disco com a variável
  AssignFile(Arquivo, 'd:\dados.txt');

  // Abre o arquivo para ser manipulado
  Rewrite(Arquivo);

  // Escreve uma linha no arquivo
  Writeln(Arquivo, 'Essa é uma linha');

  // Fehca o arquivo aberto
  CloseFile(Arquivo);
end;

procedure LerArquivoTextFile();
var
  // Variável que representa o arquivo
  Arquivo: TextFile;

  // Auxiliar para gravas os dados da linha
  Linha: string;
begin
  // Associa o nome arquivo em disco com a variável
  AssignFile(Arquivo, 'd:\dados.txt');

  Reset(Arquivo);

  // Percorre o arquvo até o seu final
  while (not Eof(Arquivo)) do
  begin
    // Le uma linha do arquivo
    Readln(Arquivo, Linha);

    ShowMessage( Linha );
  end;

  // Fehca o arquivo aberto
  CloseFile(Arquivo)
end;

procedure GravarArquivoStringList();
var
  // variável que representa o arquivo
  Arquivo: TStringList;
begin
  // Cria um objeto do tipo TStringList
  Arquivo:= TStringList.Create;
  try
    // Adiciona uma linha na lista
    Arquivo.Add( 'Essa é uma linha' );

    // Salva o arquivo em disco
    Arquivo.SaveToFile('d:\dados.txt');
  finally
    // Destroi o objeto
    FreeAndNil( Arquivo );
  end;

end;

procedure LerArquivoStringList();
var
  // variável que representa o arquivo
  Arquivo: TStringList;
  Indice: Integer;
begin
  // Cria um objeto do tipo TStringList
  Arquivo:= TStringList.Create;
  try

    // Abre o arquivo em disco
    Arquivo.LoadFromFile('d:\dados.txt');

    // Percorre as linhas do arquivo
    for Indice := 0 to Pred(Arquivo.Count) do
      ShowMessage( Arquivo.Strings[Indice] );

  finally
    // Destroi o objeto
    FreeAndNil( Arquivo );
  end;

end;


function RetornarCampo( const ALinha: string; const ACaractereSeparador: Char;
  const ACampo: Integer): string;
var
  Campo: TStringList;
begin
  Campo:= TStringList.Create();
  try
    Campo.Delimiter:= ACaractereSeparador;
    Campo.StrictDelimiter:= False;
    Campo.DelimitedText:= ALinha;

    Result:= EmptyStr;

    if ( Campo.Count > 0 ) and (ACampo > 0) and ( ACampo <= Campo.Count ) then
      Result:= Campo.Strings[ Pred( ACampo ) ];

  finally
    FreeAndNil( Campo );
  end;

end;


constructor TRifa.Create(const ANome, AEndereco, ATelefone: string);
begin
  Nome:= ANome;
  Endereco:= AEndereco;
  Telefone:= ATelefone;
end;

procedure TForm10.AdicionaHash(const Chave: Integer);
var
  Indice: Integer;
begin
  Indice:= Length( TabelaHash );

  SetLength( TabelaHash, Succ( Indice ));

  TabelaHash[ Indice ]:= Chave;
end;

procedure TForm10.BitBtn1Click(Sender: TObject);
begin

  VendasRifa.Add( StrToInt(EdtNumero.Text ),
    TRifa.Create( EdtNome.Text, EdtEndereco.Text, EdtTelefone.Text ) );

  AdicionaHash( StrToInt(EdtNumero.Text ) );
end;

procedure TForm10.BitBtn2Click(Sender: TObject);
var
  Sorteio: Integer;
begin
  Randomize();

  Sorteio:= Random( Length( TabelaHash ) );

  ShowMessage( VendasRifa.Items[TabelaHash[Sorteio]].Nome );

end;

procedure TForm10.BitBtn3Click(Sender: TObject);
var
  Key: Integer;
  Rifa: TRifa;
begin
  Memo1.Lines.Clear;

  for Key in VendasRifa.Keys do
  begin


    Rifa:= VendasRifa[Key];
    Memo1.Lines.Add( Key.ToString + ' - Nome: ' + Rifa.Nome + ' Endereço: ' +
      Rifa.Endereco + ' Telefone: ' + Rifa.Telefone );

  end;
end;

procedure TForm10.BitBtn4Click(Sender: TObject);
var
  Rifa: TRifa;

  Arquivo: TStringList;
  Linha: Integer;
  NomeDoArquivo: string;
begin
  if (OpenDialog1.Execute ) then
    NomeDoArquivo:= OpenDialog1.FileName;



  Arquivo:= TStringList.Create;
  try
    Arquivo.LoadFromFile( 'd:\rifas.txt' );

    VendasRifa.Clear;

    for Linha:= 0 to Pred(Arquivo.Count) do
    begin
      VendasRifa.Add(
        StrToInt( RetornarCampo( Arquivo.Strings[Linha], SEP, 1) ),
          TRifa.Create( RetornarCampo( Arquivo.Strings[Linha], SEP, 2),
            RetornarCampo( Arquivo.Strings[Linha], SEP, 3),
            RetornarCampo( Arquivo.Strings[Linha], SEP, 4) ) );
    end;

  finally
    FreeAndNil( Arquivo );
  end;

end;

procedure TForm10.BitBtn5Click(Sender: TObject);
var
  Rifa: TRifa;

  Key: Integer;

  Arquivo: TStringList;

  NomeDoArquivo: string;
begin
  if (SaveDialog1.Execute()) then
    NomeDoArquivo:= SaveDialog1.FileName;

  Arquivo:= TStringList.Create;
  try
    for Key in VendasRifa.Keys do
    begin
      Rifa:= VendasRifa[Key];
      Arquivo.Add( Key.ToString + SEP + Rifa.Nome + SEP + Rifa.Endereco + SEP + Rifa.Telefone );

    end;
    Arquivo.SaveToFile( 'd:\rifas.txt' );

  finally
    FreeAndNil( Arquivo );
  end;

end;

procedure TForm10.Button1Click(Sender: TObject);
begin

  GravarArquivoStringList;
  LerArquivoStringList;


end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  VendasRifa:= TObjectDictionary<Integer, TRifa>.Create();
end;

procedure TForm10.FormDestroy(Sender: TObject);
begin
  FreeAndNil( VendasRifa );
end;





end.
