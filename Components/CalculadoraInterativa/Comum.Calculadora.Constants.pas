unit Comum.Calculadora.Constants;

interface

uses
  Comum.Calculadora.Types;

const
  CALCULADORA_TECLA_STRING: array[TCalculadoraTecla] of string =
    ('',
     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
     '+', '-', '/', '*', ',', '%',
     '=',
     '<'{BackSpace}, 'D'{Delete});

  CALCULADORA_SIMBOLO_STRING: array[TCalculadoraTecla] of string =
    ('',
     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
     '+', '-', '÷', 'X', ',', '%',
     '=',
     ''{BackSpace}, ''{Delete});

  CALCULADORA_DISPLAY_ERRO = 'Erro';


implementation

end.
