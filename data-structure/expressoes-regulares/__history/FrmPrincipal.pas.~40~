unit FrmPrincipal;

interface

uses
  System.RegularExpressions,
  Edit.BorderColor,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TEdit = class(Vcl.StdCtrls.TEdit)
  public
    BorderColor: TColor;

    constructor Create(AOwner: TComponent); override;
  private
    procedure MessagePaint(var Msg: TMessage); message WM_NCPAINT;
    procedure SetBorder(AColor: TColor);
    procedure PaintEdit(DC: HDC; ARect: TRect; EColor, BColor: TColor);
  end;

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    EdtPlacaVeiculo: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EdtPlacaVeiculoEnter(Sender: TObject);
    procedure EdtPlacaVeiculoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private

    const
       REGEX_PLACA_VEICULO = '^[A-Z]{3}\d{4}$';
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TEdit.SetBorder(AColor: TColor);
var
  Canvas: TCanvas;
begin
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := GetWindowDC(Handle);
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := AColor;
    Canvas.Pen.Width:= 1;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(0, 0, Width, Height);
  finally
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Free;
  end;
end;

constructor TEdit.Create(AOwner: TComponent);
begin
  inherited;
   BorderColor:= clGreen;
end;

procedure TEdit.MessagePaint(var Msg: TMessage);
var
  DC: HDC;
  Rect: TRect;
begin
  DC := GetWindowDC(Handle);
  try
    Winapi.Windows.GetClientRect(Handle, Rect);
    PaintEdit(DC, Rect, clWindow, clBlue);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TEdit.PaintEdit(DC: HDC; ARect: TRect; EColor, BColor: TColor);
begin
  InflateRect(ARect, 4, 4);
  Brush.Color := EColor;
  Winapi.Windows.FillRect(DC, ARect, Brush.Handle);
  SetBorder(BorderColor);
end;

procedure DefineCorBordaEdit(AColor: TColor; AEdit: TEdit);
var
  Canvas: TCanvas;
begin
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := GetWindowDC( AEdit.Handle );
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := AColor;
    Canvas.Pen.Width := 2;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(0, 0, AEdit.Width -3, AEdit.Height-3);
  finally
    ReleaseDC(AEdit.Handle, Canvas.Handle);
    Canvas.Free;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if (TRegEx.IsMatch(Edit1.Text, Edit2.Text)) then
    ShowMessage('RegEx Válido')
  else
    ShowMessage('RegEx Inválido')
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  ExpressaoRegular: TRegEx;
begin
  ExpressaoRegular := TRegEx.Create(Edit2.Text);

  if (ExpressaoRegular.IsMatch('ACB1324')) then
    ShowMessage('RegEx Válido')
  else
    ShowMessage('RegEx Inválido')
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (TRegEx.IsMatch('ACB1324', '^[A-Z]{3}\d{4}$')) then
    ShowMessage('A placa informada é valida')
  else
    ShowMessage('A placa informada NÃO é valida')
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ExpressaoRegular: TRegEx;
begin
  ExpressaoRegular := TRegEx.Create('^[A-Z]{3}\d{4}$');

  if (ExpressaoRegular.IsMatch('ACB1324')) then
    ShowMessage('A placa informada é valida')
  else
    ShowMessage('A placa informada NÃO é valida')
end;

procedure TForm1.EdtPlacaVeiculoEnter(Sender: TObject);
begin
  EdtPlacaVeiculo.BorderColor:= clBlue;
end;

procedure TForm1.EdtPlacaVeiculoExit(Sender: TObject);
begin

  if ( EdtPlacaVeiculo.Text <> EmptyStr ) then
  begin
    if not ( TRegEx.IsMatch( EdtPlacaVeiculo.Text, REGEX_PLACA_VEICULO ) ) then
      EdtPlacaVeiculo.BorderColor:= clRed
    else
      EdtPlacaVeiculo.BorderColor:= clGreen;
  end;

end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #13: SelectNext( ActiveControl, True, True );
    #27: SelectNext( ActiveControl, False, True );
  end;
end;

end.
