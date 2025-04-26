unit Model.CalculadoraInterativa;

interface

uses
  System.SysUtils, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Graphics, Winapi.Windows, Winapi.Messages, System.Classes;

type
  TBotaoDestacarThread = class(TThread)
  private
    FBotao: TButton;
  protected
    procedure Execute; override;
    procedure Pressionar;
    procedure Soltar;
  public
    constructor Create(ABotao: TButton);
  end;

  ICalculadoraInterativa = interface
    ['{B2F3A01B-3496-4C0C-9B69-5A3B9E2041D3}']
    function GetValorExibido: string;
  end;

  TCalculadoraInterativa = class(TInterfacedObject, ICalculadoraInterativa)
  private
    FForm: TForm;
    FDisplay: TLabel;
    FUltimoValor: Double;
    FOperador: Char;
    FLimparDisplay: Boolean;
    FButtons: array[Char] of TButton;
    FHistorico: TLabel;
    FGridPanel: TGridPanel;
    procedure CriarInterface(AOwner: TComponent);
    procedure BotaoClick(Sender: TObject);
    procedure TeclaPressionada(Sender: TObject; var Key: Char);
    procedure TeclaEspecial(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DestacarBotao(Tecla: Char);
    procedure ExecutarOperacao;
    function TraduzTeclaParaBotao(Key: Char): Char;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function GetValorExibido: string;
    class function New(AOwner: TComponent): ICalculadoraInterativa;
  end;

implementation

{ TCalculadoraInterativa }

constructor TCalculadoraInterativa.Create(AOwner: TComponent);
begin
  CriarInterface(AOwner);
end;

destructor TCalculadoraInterativa.Destroy;
begin
  //FForm.Free;
  inherited;
end;

procedure TCalculadoraInterativa.CriarInterface(AOwner: TComponent);
const
  Botoes: array [0..19] of string = (
    '7','8','9','/',
    '4','5','6','*',
    '1','2','3','-',
    '0',',','=','+',
    'C','<','',''
  );
var
  i, row, col: Integer;
  btn: TButton;
  Tecla: Char;
begin
  FForm := TForm.Create(nil);
  FForm.Width := 270;
  FForm.Height := 400;
  FForm.Position := poScreenCenter;
  FForm.Caption := 'Calculadora Interativa';
  FForm.KeyPreview := True;
  FForm.OnKeyPress := TeclaPressionada;
  FForm.OnKeyDown := TeclaEspecial;

  // Painel de histórico
  FHistorico := TLabel.Create(FForm);
  FHistorico.Parent := FForm;
  FHistorico.Align := alTop;
  FHistorico.Height := 30;
  FHistorico.Font.Size := 10;
  FHistorico.Font.Color := clGray;
  FHistorico.Alignment := taRightJustify;
  FHistorico.Layout := tlCenter;
  FHistorico.Caption := '';
  FHistorico.Transparent := False;
  FHistorico.Color := clWhite;
  FHistorico.AutoSize := False;

  // Display
  FDisplay := TLabel.Create(FForm);
  FDisplay.Parent := FForm;
  FDisplay.Align := alTop;
  FDisplay.Height := 60;
  FDisplay.Font.Size := 22;
  FDisplay.Alignment := taRightJustify;
  FDisplay.Layout := tlCenter;
  FDisplay.Caption := '0';
  FDisplay.Color := clWhite;
  FDisplay.Transparent := False;
  FDisplay.AutoSize := False;
  //FDisplay.BorderStyle := bsSingle;

  // GridPanel para botões
  FGridPanel := TGridPanel.Create(FForm);
  FGridPanel.Parent := FForm;
  FGridPanel.Align := alClient;

//  FGridPanel.RowCollection.Add := 5;
//  FGridPanel.ColumnCollection := 4;

  FGridPanel.BevelOuter := bvNone;

  for i := 0 to 4 do
    with FGridPanel.RowCollection.Add do
      Value := 20;

  for i := 0 to 3 do
    with FGridPanel.ColumnCollection.Add do
      Value := 25;

  // Criar botões e adicionar ao grid
  for i := 0 to High(Botoes) do
  begin
    if Botoes[i] = '' then Continue;

    Tecla := Botoes[i][1];
    btn := TButton.Create(FForm);
    btn.Parent := FGridPanel;
    btn.Caption := Botoes[i];
    btn.Align := alClient;
    btn.Font.Size := 14;
    btn.Tag := Ord(Tecla);
    btn.OnClick := BotaoClick;

    // Adiciona na célula correspondente
    row := i div 4;
    col := i mod 4;
    FGridPanel.ControlCollection.AddControl(btn, col, row);

    FButtons[Tecla] := btn;
  end;

  FForm.Show;
end;

procedure TCalculadoraInterativa.BotaoClick(Sender: TObject);
var
  Tecla: Char;
begin
  Tecla := Char(TButton(Sender).Tag);

  case Tecla of
    '0'..'9':
      begin
        if (FDisplay.Caption = '0') or FLimparDisplay then
        begin
          FDisplay.Caption := Tecla;
          FLimparDisplay := False;
        end
        else
          FDisplay.Caption := FDisplay.Caption + Tecla;
      end;

    '+', '-', '*', '/':
      begin
        FUltimoValor := StrToFloat(StringReplace(FDisplay.Caption, ',', '.', [rfReplaceAll]));
        FOperador := Tecla;
        FLimparDisplay := True;
        FHistorico.Caption := Format('%s %s', [FDisplay.Caption, FOperador]);
      end;

    '=':
    begin
      FHistorico.Caption := '';
      FHistorico.Caption := FHistorico.Caption + ' ' + FDisplay.Caption + Tecla;
      ExecutarOperacao;
    end;

    ',':
      begin
        if Pos(',', FDisplay.Caption) = 0 then
          FDisplay.Caption := FDisplay.Caption + ',';
      end;

    'C':
      begin
        FHistorico.Caption := '';
        FDisplay.Caption := '0';
        FUltimoValor := 0;
        FOperador := #0;
        FLimparDisplay := False;
        FHistorico.Caption := FHistorico.Caption + ' ' + FDisplay.Caption;
      end;

    '<': // backspace
      begin
        if FLimparDisplay then Exit;
        if Length(FDisplay.Caption) > 1 then
          FDisplay.Caption := Copy(FDisplay.Caption, 1, Length(FDisplay.Caption) - 1)
        else
          FDisplay.Caption := '0';
      end;
  end;
end;

procedure TCalculadoraInterativa.TeclaPressionada(Sender: TObject; var Key: Char);
var
  T: Char;
begin
  T := TraduzTeclaParaBotao(Key);

  if FButtons[T] <> nil then
  begin
    FButtons[T].Click;
    DestacarBotao(T);
  end;
end;

procedure TCalculadoraInterativa.TeclaEspecial(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_BACK then
  begin
    if FButtons['<'] <> nil then
    begin
      FButtons['<'].Click;
      DestacarBotao('<');
    end;
  end;
end;

function TCalculadoraInterativa.TraduzTeclaParaBotao(Key: Char): Char;
begin
  case Key of
    '.', ',':
      Result := ',';
    #8:
      Result := '<';
    #13:
      Result := '=';
    else
      Result := UpCase(Key);
  end;
end;

procedure TCalculadoraInterativa.DestacarBotao(Tecla: Char);
var
  btn: TButton;
begin
  btn := FButtons[Tecla];
  if btn = nil then Exit;

  TBotaoDestacarThread.Create(btn);
end;

procedure TCalculadoraInterativa.ExecutarOperacao;
var
  ValorAtual: Double;
  Resultado: Double;
begin
  try
    ValorAtual := StrToFloat(StringReplace(FDisplay.Caption, ',', '.', [rfReplaceAll]));

    case FOperador of
      '+': Resultado := FUltimoValor + ValorAtual;
      '-': Resultado := FUltimoValor - ValorAtual;
      '*': Resultado := FUltimoValor * ValorAtual;
      '/':
        if ValorAtual <> 0 then
          Resultado := FUltimoValor / ValorAtual
        else
        begin
          FDisplay.Caption := 'Erro';
          Exit;
        end;
    else
      Exit;
    end;

    FDisplay.Caption := StringReplace(FloatToStr(Resultado), '.', ',', []);
    FLimparDisplay := True;
  except
    FDisplay.Caption := 'Erro';
  end;
end;

function TCalculadoraInterativa.GetValorExibido: string;
begin
  Result := FDisplay.Caption;
end;

class function TCalculadoraInterativa.New(AOwner: TComponent): ICalculadoraInterativa;
begin
  Result := Self.Create(AOwner);
end;



constructor TBotaoDestacarThread.Create(ABotao: TButton);
begin
  inherited Create(False); // False = já inicia a thread
  FreeOnTerminate := True;
  FBotao := ABotao;
end;

procedure TBotaoDestacarThread.Execute;
begin
  Synchronize(Pressionar);
  Sleep(100);
  Synchronize(Soltar);
end;

procedure TBotaoDestacarThread.Pressionar;
begin
  if Assigned(FBotao) then
    FBotao.Perform(BM_SETSTATE, WPARAM(1), 0);
end;

procedure TBotaoDestacarThread.Soltar;
begin
  if Assigned(FBotao) then
    FBotao.Perform(BM_SETSTATE, WPARAM(0), 0);
end;

end.
