program CalculadoraInterativaDEMO;

uses
  Vcl.Forms,
  View.Main in 'View.Main.pas' {Form1},
  View.Calculadora in 'View.Calculadora.pas' {frmCalculadora},
  Presenter.Calculadora in 'Presenter.Calculadora.pas',
  Model.Calculadora in 'Model.Calculadora.pas',
  Comum.ButtonHighlighter in 'Comum.ButtonHighlighter.pas',
  Comum.Calculadora.Types in 'Comum.Calculadora.Types.pas',
  Comum.Calculadora.Constants in 'Comum.Calculadora.Constants.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCalculadora, frmCalculadora);
  Application.Run;
end.
