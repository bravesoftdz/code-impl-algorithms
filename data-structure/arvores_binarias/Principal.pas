unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TEstado = record
    Codigo: Integer;
    Sigla: string;
    Nome: string;
  end;

  PApontador = ^TItem;
  TItem = record
    Valor: TEstado;
    NoEsquerda: PApontador;
    NoDireta: PApontador;
  end;

  TForm2 = class(TForm)
    EdtNomeEstado: TEdit;
    Label1: TLabel;
    EdtSiglaEstado: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    LstPreOrdem: TListBox;
    Percorrer: TBitBtn;
    EdtCodigo: TEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    LstPosOrdem: TListBox;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    LstEmOrdem: TListBox;
    BitBtn3: TBitBtn;
    SpeedButton1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure PercorrerClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure Inserir( AEstado: TEstado; var AItem: PApontador );

    procedure PreOrdem( AItem: PApontador );
    procedure PosOrdem( AItem: PApontador );
    procedure EmOrdem( AItem: PApontador );

    procedure Buscar( AItem: PApontador );

    procedure Imprimir( AEstado: TEstado; AListBox: TListBox );

  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Raiz: PApontador = nil;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  Estado: TEstado;
begin
  Estado.Codigo:= StrToInt( EdtCodigo.Text );
  Estado.Sigla:= EdtSiglaEstado.Text;
  Estado.Nome:= EdtNomeEstado.Text;

  Inserir( Estado, Raiz );
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  PosOrdem( Raiz );
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
  EmOrdem( Raiz );
end;

procedure TForm2.Buscar(AItem: PApontador);
var
  CodigoPesquisa: Integer;
begin
  CodigoPesquisa:= StrToInt( EdtCodigo.Text );

  // Verifica se a lista esta vazia
  if ( AItem <> nil ) then
  begin
    // Encontrou o registro
    if ( AItem.Valor.Codigo = StrToInt( EdtCodigo.Text ) ) then
    begin
      EdtSiglaEstado.Text:= AItem.Valor.Sigla;
      EdtNomeEstado.Text:= AItem.Valor.Nome;
    end else
    begin

      if ( CodigoPesquisa < AItem.Valor.Codigo ) then
        Buscar( AItem.NoEsquerda )
      else if ( CodigoPesquisa > AItem.Valor.Codigo ) then
        Buscar( AItem.NoDireta )
    end;
  end;
end;

procedure TForm2.EmOrdem(AItem: PApontador);
begin

  if ( AItem <> nil ) then
  begin
    EmOrdem( AItem.NoEsquerda );

    // Esse n� � o raiz da subarvore
    Imprimir( AItem.Valor, LstEmOrdem );

    EmOrdem( AItem.NoDireta );
  end;

end;


procedure TForm2.Imprimir(AEstado: TEstado; AListBox: TListBox);
begin
  AListBox.Items.Add(
    IntToStr( AEstado.Codigo ) + ' - ' + AEstado.Nome );
end;

procedure TForm2.Inserir( AEstado: TEstado; var AItem: PApontador );
begin

  if ( AItem = nil ) then
  begin
    // Aloca um novo item na mem�ria
    New( AItem );
    AItem.Valor:= AEstado;
    AItem.NoEsquerda:= nil;
    AItem.NoDireta:= nil;
  end else
  begin
    // A o campo para ordena��o � o nome
    if ( AEstado.Codigo < AItem.Valor.Codigo ) then
      Inserir(AEstado, AItem.NoEsquerda)
    else if ( AEstado.Codigo > AItem.Valor.Codigo ) then
      Inserir(AEstado, AItem.NoDireta)
    else
      raise Exception.Create('N�o � permitido item duplicado');
  end;

end;

procedure TForm2.PercorrerClick(Sender: TObject);
begin
  PreOrdem( Raiz );
end;

procedure TForm2.PosOrdem(AItem: PApontador);
begin

  if ( AItem <> nil ) then
  begin
    // Percorre os n�s da esquerda
    PosOrdem( AItem.NoEsquerda );
    // Percorre os n�s da direita
    PosOrdem( AItem.NoDireta );
    // Esse n� � o raiz da subarvore
    Imprimir( AItem.Valor, LstPosOrdem );
  end;
end;

procedure TForm2.PreOrdem(AItem: PApontador);
begin

  if ( AItem <> nil ) then
  begin
    // Esse n� � o raiz da subarvore
    Imprimir( AItem.Valor, LstPreOrdem );

    PreOrdem( AItem.NoEsquerda );
    PreOrdem( AItem.NoDireta );
  end;

end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  Buscar( Raiz )
end;

end.