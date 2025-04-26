unit Model.Calculadora;

interface

uses
  Comum.Calculadora.Types,
  System.SysUtils;

type
  TEstadoEntrada = (emNovoNumero, emAcumulando, emResultado);

type
  TCalculadoraModel = class
  private
    FValorAnterior: Double;
    FOperador: TCalculadoraTecla;
    FTextoDisplay: string;
    FEstado: TEstadoEntrada;
    FTextoHistorico: string;
    FOnChangeDisplay: TProc<string>;
    FOnChangeHistorico: TProc<string>;
    function TextoToFloat(const Texto: string): Double;
    function FloatToTexto(const Valor: Double): string;
    procedure Calcular;
    procedure SetTextoDisplay(const Value: string);
    procedure TextoDisplayAlterado;
    function GetDisplay: string;
    procedure SetOnChangeDisplay(const Value: TProc<string>);
    procedure SetTextoHistorico(const Value: string);
    procedure TextoHistoricoAtualizado;
    procedure SetOnChangeHistorico(const Value: TProc<string>);
  public
    constructor Create;
    procedure InserirNumero(ATecla: TCalculadoraTecla);
    procedure InserirOperador(ATecla: TCalculadoraTecla);
    procedure InserirDecimal;
    procedure CalcularResultado;
    procedure Limpar;
    procedure Backspace;
    procedure CalcularPercentual;

    property TextoDisplay: string  read FTextoDisplay write SetTextoDisplay;
    property TextoHistorico: string  read FTextoHistorico write SetTextoHistorico;

    property OnChangeDisplay: TProc<String> read FOnChangeDisplay write SetOnChangeDisplay;
    property OnChangeHistorico: TProc<String> read FOnChangeHistorico write SetOnChangeHistorico;
  end;


implementation

uses
  Comum.Calculadora.Constants;

{ TCalculadora }

constructor TCalculadoraModel.Create;
begin
  Limpar;
end;

procedure TCalculadoraModel.TextoDisplayAlterado;
begin
  if Assigned(FOnChangeDisplay) then
    FOnChangeDisplay(FTextoDisplay);
end;

procedure TCalculadoraModel.TextoHistoricoAtualizado;
begin
  if Assigned(FOnChangeHistorico) then
    FOnChangeHistorico(FTextoHistorico)
end;

function TCalculadoraModel.TextoToFloat(const Texto: string): Double;
begin
  Result := StrToFloat(StringReplace(Texto, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
end;

function TCalculadoraModel.FloatToTexto(const Valor: Double): string;
begin
  Result := StringReplace(FloatToStr(Valor), FormatSettings.DecimalSeparator, ',', [rfReplaceAll]);
end;

procedure TCalculadoraModel.InserirNumero(ATecla: TCalculadoraTecla);
begin
  case FEstado of
    emNovoNumero,
    emResultado:
      TextoDisplay := CALCULADORA_SIMBOLO_STRING[ATecla];

    emAcumulando:
    begin
      if FTextoDisplay = CALCULADORA_TECLA_STRING[ctDigito0] then
        TextoDisplay := CALCULADORA_TECLA_STRING[ATecla]
      else
        TextoDisplay := FTextoDisplay + CALCULADORA_TECLA_STRING[ATecla];
    end;
  end;

  FEstado := emAcumulando;
end;

procedure TCalculadoraModel.InserirDecimal;
begin
  if FEstado in [emNovoNumero, emResultado] then
    TextoDisplay := CALCULADORA_TECLA_STRING[ctDigito0] + CALCULADORA_TECLA_STRING[ctDecimal];  //"0,"

  if Pos(CALCULADORA_TECLA_STRING[ctDecimal], FTextoDisplay) = 0 then //",***"
    TextoDisplay := FTextoDisplay + CALCULADORA_TECLA_STRING[ctDecimal];

  FEstado := emAcumulando;
end;

procedure TCalculadoraModel.InserirOperador(ATecla: TCalculadoraTecla);
var
  LTexto: string;
begin
  if FEstado = emNovoNumero then //Operador acionado consecutivamente
  begin
    FOperador := ATecla;
    TextoHistorico := Copy(FTextoHistorico, 1, length(FTextoHistorico)-1) + CALCULADORA_SIMBOLO_STRING[ATecla];
    Exit;
  end;

  if FOperador <> ctNone then
    Calcular
  else
    FValorAnterior := TextoToFloat(FTextoDisplay);

  FOperador := ATecla;

  TextoHistorico := FTextoHistorico + ' ' + FTextoDisplay + ' ' + CALCULADORA_SIMBOLO_STRING[ATecla];

  FEstado := emNovoNumero;
end;

procedure TCalculadoraModel.Calcular;
var
  LOperando: Double;
begin
  LOperando := TextoToFloat(FTextoDisplay);

  case FOperador of
    ctSoma: FValorAnterior := FValorAnterior + LOperando;
    ctSubtrair: FValorAnterior := FValorAnterior - LOperando;
    ctMultiplicar: FValorAnterior := FValorAnterior * LOperando;
    ctDividir:
    begin
      if LOperando <> 0 then
        FValorAnterior := FValorAnterior / LOperando
      else
      begin
        TextoDisplay := CALCULADORA_DISPLAY_ERRO;
        FEstado := emResultado;
        Exit;
      end;

    end;
  end;
  TextoHistorico := FTextoHistorico + ' ' + FloatToTexto(LOperando);
  TextoDisplay := FloatToTexto(FValorAnterior);
  FOperador := ctNone;
  FEstado := emResultado;
end;

procedure TCalculadoraModel.CalcularResultado;
begin
  if FOperador <> ctNone then
  begin
    Calcular;
    TextoHistorico := FTextoHistorico + ' ' + CALCULADORA_SIMBOLO_STRING[ctIgual];
    FTextoHistorico := EmptyStr;
  end;
end;

procedure TCalculadoraModel.CalcularPercentual;
var
  LPercentual: Double;
begin
  LPercentual := TextoToFloat(FTextoDisplay);
  LPercentual := FValorAnterior * LPercentual / 100;
  FTextoDisplay := FloatToTexto(LPercentual);
  TextoHistorico := FTextoHistorico + ' ' + FloatToTexto(LPercentual);
  FEstado := emResultado;
end;

procedure TCalculadoraModel.Limpar;
begin
  FValorAnterior := 0;
  FOperador := ctNone;
  TextoDisplay := CALCULADORA_SIMBOLO_STRING[ctDigito0];
  TextoHistorico := '';
  FEstado := emNovoNumero;
end;

procedure TCalculadoraModel.SetOnChangeDisplay(const Value: TProc<string>);
begin
  FOnChangeDisplay := Value;
end;

procedure TCalculadoraModel.SetOnChangeHistorico(const Value: TProc<string>);
begin
  FOnChangeHistorico := Value;
end;

procedure TCalculadoraModel.SetTextoDisplay(const Value: string);
begin
  FTextoDisplay := Value;
  TextoDisplayAlterado;
end;

procedure TCalculadoraModel.SetTextoHistorico(const Value: string);
begin
  FTextoHistorico := Value;
  TextoHistoricoAtualizado;
end;

procedure TCalculadoraModel.Backspace;
begin
  if FEstado = emResultado then
    Exit;

  if Length(FTextoDisplay) > 1 then
    Delete(FTextoDisplay, Length(FTextoDisplay), 1)
  else
    FTextoDisplay := CALCULADORA_SIMBOLO_STRING[ctDigito0];

  TextoDisplayAlterado;
end;

function TCalculadoraModel.GetDisplay: string;
begin
  Result := FTextoDisplay;
end;

end.
