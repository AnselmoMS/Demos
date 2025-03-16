unit Presenter.PessoaListagem;

interface

uses
  DAO.Pessoa.Repository,
  DAO.Entity.Pessoa,
  View.Pessoa.Interfaces,
  Comum.Types,
  System.SysUtils,
  System.Classes,
  View.Interfaces;

type
  TPessoaListagemPresenter = class
  private
    FBeforeLoadList: TProc;
    FAfterLoadList: TProc;
    FView: IView;
    FViewPessoaListagem: IViewPessoaListagem;
    FRepository: TPessoaRepository;
  public
    constructor Create(AView: IView; AViewPessoaDataSet: IViewPessoaListagem);
    destructor Destroy; override;
    procedure CarregarLista;
    property BeforeLoadList: TProc read FBeforeLoadList write FBeforeLoadList;
    property AfterLoadList: TProc read FAfterLoadList write FAfterLoadList;
  end;

implementation

uses
  System.UITypes;

  { TPessoaPresenterList }

constructor TPessoaListagemPresenter.Create(AView: IView; AViewPessoaDataSet: IViewPessoaListagem);
begin
  FView := AView;
  FViewPessoaListagem := AViewPessoaDataSet;
  FRepository := TPessoaRepository.Create;
end;

destructor TPessoaListagemPresenter.Destroy;
begin
  FreeAndNil(FRepository);
  inherited;
end;

procedure TPessoaListagemPresenter.CarregarLista({FakeFilter});
var
  Listagem: TArray<TPessoaListagem>;
begin
  Listagem:= FRepository.ObterListagem('FakeFilter');
  FViewPessoaListagem.ExibirListagem(Listagem);
end;

end.
