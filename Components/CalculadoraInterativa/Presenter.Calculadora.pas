unit Presenter.Calculadora;

interface

uses
  Model.Calculadora,
  Comum.Calculadora.Types;

type
  IViewCalculadora = interface
  ['{FF096975-2DE2-42C9-AB74-E272A1D42882}']
  procedure AtualizarDisplay(ATexto: String);
  procedure AtualizarHistorico(ATexto: String);
  end;

  TCalculadoraPresenter = class
  private
    FView: IViewCalculadora;
    FModel: TCalculadoraModel;
    procedure AtualizarDisplayView(ATexto: string);
    procedure AtualizarHistoricoView(ATexto: string);
  public
    constructor Create(AViewCalculadora: IViewCalculadora);
    destructor Destroy; override;
    procedure InformarTecla(ATecla: TCalculadoraTecla);
  end;

implementation

{ TCalculadoraPresenter }

procedure TCalculadoraPresenter.AtualizarDisplayView(ATexto: string);
begin
  FView.AtualizarDisplay(ATexto);
end;

procedure TCalculadoraPresenter.AtualizarHistoricoView(ATexto: string);
begin
  FView.AtualizarHistorico(ATexto);
end;

constructor TCalculadoraPresenter.Create(AViewCalculadora: IViewCalculadora);
begin
  FView := AViewCalculadora;
  FModel := TCalculadoraModel.Create;
  FModel.OnChangeDisplay := AtualizarDisplayView;
  FModel.OnChangeHistorico := AtualizarHistoricoView;
end;

destructor TCalculadoraPresenter.Destroy;
begin
  FModel.Free;
  inherited;
end;

procedure TCalculadoraPresenter.InformarTecla(ATecla: TCalculadoraTecla);
begin
  case ATecla of
    //ctNone: ;

    ctDigito0..ctDigito9:
      FModel.InserirNumero(ATecla);

    ctSoma, ctSubtrair, ctDividir, ctMultiplicar:
      FModel.InserirOperador(ATecla);

    ctDecimal:
      FModel.InserirDecimal;

    ctPercentual:
      FModel.CalcularPercentual; //??

    ctBackSpace:
      FModel.Backspace;

    ctLimpar:
      FModel.Limpar;

    ctIgual:
      FModel.CalcularResultado;
  end;
end;

end.
