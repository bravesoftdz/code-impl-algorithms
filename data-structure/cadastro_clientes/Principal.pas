unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ImgList;

type
  TCliente = record
    Codigo: Integer;
    Nome: string;
  end;

  PApontador = ^TItem;
  TItem = record
    Valor: TCliente;
    Apontador: PApontador;
  end;

  TForm3 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    BitBtn6: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  PrimeiroNo: PApontador = nil; // no cabeca
  NoAtual:PApontador = nil; // no atual usado na navegacao

implementation

{$R *.dfm}

procedure TForm3.BitBtn1Click(Sender: TObject);
var
  NoAuxiliar: PApontador;
begin
 NoAuxiliar:= PrimeiroNo;
  while ( NoAuxiliar <> nil ) do
  begin
    if ( NoAuxiliar.Valor.Codigo = StrToInt( LabeledEdit1.Text ) ) then
    begin
      NoAuxiliar.Valor.Nome:= LabeledEdit2.Text;

    end;
    NoAuxiliar:= NoAuxiliar.Apontador;
  end;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
var
  NoAuxiliar: PApontador;
begin
  New( NoAuxiliar );

  NoAuxiliar.Apontador:= PrimeiroNo;

  NoAuxiliar.Valor.Nome:= LabeledEdit2.Text;
  NoAuxiliar.Valor.Codigo:= StrToInt( LabeledEdit1.Text );

  PrimeiroNo:= NoAuxiliar;

  MessageDlg( 'Registro gravado con sucesso!', mtInformation, [mbOK], 0 );
end;

procedure TForm3.BitBtn6Click(Sender: TObject);
var
  NoAuxiliar: PApontador;

begin

  NoAuxiliar:= PrimeiroNo;
  while ( NoAuxiliar <> nil ) do
  begin
    ShowMessage( IntToStr( NoAuxiliar.Valor.Codigo ) + ' ' +
      NoAuxiliar.Valor.Nome );

    NoAuxiliar:= NoAuxiliar.Apontador;
  end;

end;

procedure TForm3.FormDestroy(Sender: TObject);
var
  NoAuxiliar: PApontador;

begin

  NoAuxiliar:= PrimeiroNo;
  while ( NoAuxiliar <> nil ) do
  begin
    Dispose( NoAuxiliar );
    NoAuxiliar:= NoAuxiliar.Apontador;
  end;

end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
var
  NoAuxiliar: PApontador;
begin
 NoAuxiliar:= PrimeiroNo;
  while ( NoAuxiliar <> nil ) do
  begin
    if ( NoAuxiliar.Valor.Codigo = StrToInt( LabeledEdit1.Text ) ) then
    begin
      LabeledEdit2.Text:=  NoAuxiliar.Valor.Nome;

    end;
    NoAuxiliar:= NoAuxiliar.Apontador;
  end;
end;

end.
