unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ImgList;

type
  TForm3 = class(TForm)
    TreeView1: TTreeView;
    Edit1: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImageList1: TImageList;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarArquivos(Diretorio: string; Sub: Boolean);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.ListarArquivos(Diretorio: string; Sub: Boolean);

function TemAtributo(Attr, Val: Integer): Boolean;
begin
   Result := Attr and Val = Val;
end;

var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
  NodeTemp: TTreeNode;

begin
   Ret := FindFirst(Diretorio+'\*.*', faAnyFile, F);
   try
      while Ret = 0 do begin

         if TemAtributo(F.Attr, faDirectory) then
         begin
            if (F.Name <> '.') and (F.Name <> '..') then
            begin
               NodeTemp:= TreeView1.Items.AddChild( nil, Diretorio );
               NodeTemp.ImageIndex:= 0;
               NodeTemp.SelectedIndex:= 0;

               TreeView1.Selected:= NodeTemp;

               TempNome := Diretorio+'\' + F.Name;
               ListarArquivos(TempNome, True);

             end;
         end else
         begin
           NodeTemp:= TreeView1.Items.AddChild(  TreeView1.Selected, Diretorio+'\'+F.Name );
           NodeTemp.ImageIndex:= 1;
           NodeTemp.SelectedIndex:= 1;

         end;

         Ret := FindNext(F);
      end;
   finally
      FindClose(F);
   end;

   TreeView1.FullExpand();
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
   ListarArquivos( Edit1.Text, True );
end;

{
Função acrescenta(diretório, arquivo);
Begin
Posiciona no Node diretório;
If (arquivo não é Diretório) Then
Cria-node-arquivo
Else
Begin
diretório := Cria-Node-Diretório;
acrescenta(diretório, arquivo);
End;
arquivo := FindNext;
End;
}

end.

