unit Presenter.Pessoa.ViewFactory;

interface

uses
  View.Pessoa.Interfaces,
  Presenter.Pessoa,
  View.PessoaCadastroCompleto;

type
  TPessoaViewFactory = class
  public
    class function ObterViewCadastroCompleto(APresenter: TPessoaPresenter): IViewPessoaCadastro;
    class function ObterViewCadastro(APresenter: TPessoaPresenter): IViewPessoaCadastro;
  end;

implementation

uses
  Vcl.Forms,
  SysUtils;

{ TPessoaViewBuilder }

class function TPessoaViewFactory.ObterViewCadastro(APresenter: TPessoaPresenter): IViewPessoaCadastro;
begin
  raise ENotImplemented.Create('Não implementado');
end;

class function TPessoaViewFactory.ObterViewCadastroCompleto(APresenter: TPessoaPresenter): IViewPessoaCadastro;
begin
  Result:= TfrmPessoaCadastroCompleto.Create(Application, APresenter);
end;

end.
