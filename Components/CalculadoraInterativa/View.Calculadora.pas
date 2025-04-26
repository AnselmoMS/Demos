unit View.Calculadora;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Presenter.Calculadora,
  Comum.Calculadora.Types,
  System.Generics.Collections,
  Comum.ButtonHighlighter;

type
  TfrmCalculadora = class(TForm, IViewCalculadora)
    pnDisplay: TPanel;
    lblHistorico: TLabel;
    lblDisplay: TLabel;
    GridPanel1: TGridPanel;
    btTecla7: TButton;
    btTecla8: TButton;
    btTecla9: TButton;
    btTeclaDividir: TButton;
    btTecla4: TButton;
    btTecla5: TButton;
    btTecla6: TButton;
    btTeclaMultiplicar: TButton;
    btTecla1: TButton;
    btTecla2: TButton;
    btTecla3: TButton;
    btTeclaSoma: TButton;
    btTeclaInverterSinal: TButton;
    btTecla0: TButton;
    btTeclaDecimal: TButton;
    btTeclaIgual: TButton;
    btTeclaSubtrair: TButton;
    btTeclaPercentual: TButton;
    btTeclaBackSpace: TButton;
    btTeclaClear: TButton;
    btTeclaClearNumber: TButton;
    btTeclaSquare: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPresenter: TCalculadoraPresenter;
    FControls: TList<TObject>;
    FButtonHighlighter: TButtonHighlighter;

    function TraduzTecla(Key: Char): Char;

    function ObterTecla(AObject: TObject): TCalculadoraTecla;
    function GetButton(ATecla: TCalculadoraTecla): TButton;
    procedure ButtonClick(Sender: TObject);
    procedure InformarTecla(ATecla: TCalculadoraTecla);
    procedure ExecuteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExecuteKeyPress(Sender: TObject; var Key: Char);

    procedure AtualizarDisplay(ATexto: String);
    procedure AtualizarHistorico(ATexto: String);
  public
    { Public declarations }
  end;

var
  frmCalculadora: TfrmCalculadora;

implementation

uses
  Comum.Calculadora.Constants;

{$R *.dfm}

procedure TfrmCalculadora.AtualizarDisplay(ATexto: String);
begin
  lblDisplay.Caption := ATexto
end;

procedure TfrmCalculadora.AtualizarHistorico(ATexto: String);
begin
  lblHistorico.Caption := ATexto
end;

procedure TfrmCalculadora.ButtonClick(Sender: TObject);
begin
  InformarTecla(ObterTecla(Sender));
end;

procedure TfrmCalculadora.ExecuteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_BACK then
    InformarTecla(ctBackSpace);

  if Key = VK_DELETE then
    InformarTecla(ctLimpar);
end;

procedure TfrmCalculadora.ExecuteKeyPress(Sender: TObject; var Key: Char);
var
  I: TCalculadoraTecla;
begin
  for I := Low(TCalculadoraTecla) to High(TCalculadoraTecla) do
  begin
    if Key = CALCULADORA_TECLA_STRING[I] then
    begin
      InformarTecla(I);
      Exit;
    end;
  end;

  case Key of
     #13:
      InformarTecla(ctIgual);

    '.':
      InformarTecla(ctDecimal);
  end;
end;

procedure TfrmCalculadora.FormCreate(Sender: TObject);
begin
  FPresenter := TCalculadoraPresenter.Create(Self);

  FControls:= TList<TObject>.Create;
  FControls.AddRange(
    TArray<TObject>.Create(
      nil,
      btTecla0, btTecla1, btTecla2, btTecla3, btTecla4, btTecla5, btTecla6, btTecla7, btTecla8, btTecla9,
      btTeclaSoma, btTeclaSubtrair, btTeclaDividir, btTeclaMultiplicar, btTeclaDecimal, btTeclaPercentual,
      btTeclaIgual,
      btTeclaBackSpace, btTeclaClear));

  btTecla0.OnClick := ButtonClick;
  btTecla1.OnClick := ButtonClick;
  btTecla2.OnClick := ButtonClick;
  btTecla3.OnClick := ButtonClick;
  btTecla4.OnClick := ButtonClick;
  btTecla5.OnClick := ButtonClick;
  btTecla6.OnClick := ButtonClick;
  btTecla7.OnClick := ButtonClick;
  btTecla8.OnClick := ButtonClick;
  btTecla9.OnClick := ButtonClick;

  btTeclaSoma.OnClick := ButtonClick;
  btTeclaSubtrair.OnClick := ButtonClick;
  btTeclaDividir.OnClick := ButtonClick;
  btTeclaMultiplicar.OnClick := ButtonClick;
  btTeclaDecimal.OnClick := ButtonClick;
  btTeclaPercentual.OnClick := ButtonClick;
  btTeclaIgual.OnClick := ButtonClick;
  btTeclaBackSpace.OnClick := ButtonClick;

  FPresenter.InformarTecla(ctLimpar);
end;

procedure TfrmCalculadora.FormDestroy(Sender: TObject);
begin
  FControls.Free;
  FPresenter.Free;
end;

procedure TfrmCalculadora.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ExecuteKeyDown(Sender, Key, Shift);
end;

procedure TfrmCalculadora.FormKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteKeyPress(Sender, Key);
end;

function TfrmCalculadora.GetButton(ATecla: TCalculadoraTecla): TButton;
begin
  Result:= TButton(FControls[Ord(ATecla)]);
end;

procedure TfrmCalculadora.InformarTecla(ATecla: TCalculadoraTecla);
begin
  FPresenter.InformarTecla(ATecla);
  TButtonHighlighter.Create(GetButton(ATecla));
end;

function TfrmCalculadora.TraduzTecla(Key: Char): Char;
begin
  case Key of
    '.', ',':
      Result := CALCULADORA_TECLA_STRING[ctDecimal][1];
    #8:
      Result := '<';
    #13:
      Result := '=';
  else
      Result := UpCase(Key);
  end;
end;

function TfrmCalculadora.ObterTecla(AObject: TObject): TCalculadoraTecla;
var
  I: Integer;
begin
  I:= FControls.IndexOf(AObject);
  if I < 0 then
    Exit(ctNone);

  Exit(TCalculadoraTecla(Ord(I)));
end;

end.
