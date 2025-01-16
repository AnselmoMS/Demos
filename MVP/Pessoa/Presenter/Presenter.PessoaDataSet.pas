unit Presenter.PessoaDataSet;

interface

uses
  Model.Service.Pessoa,
  Model.Entity.Pessoa,
  View.Pessoa.Interfaces,
  Data.DB,
  uADCompClient,
  Comum.Constants,
  System.SysUtils,
  System.Classes,
  View.Interfaces;

type
  TPessoaDatasetPresenter = class
  private
    FPessoaDataSet: TDataSet;
    FBeforeLoadList: TProc;
    FAfterLoadList: TProc;
    FView: IView;
    FViewPessoaDataSet: IViewPessoaDataSet;
    FService: TPessoaService;
  public
    constructor Create(AView: IView; AViewPessoaDataSet: IViewPessoaDataSet);
    destructor Destroy; override;
    procedure CarregarLista;
    function ObterPessoaDaLista: TPessoa;
    property BeforeLoadList: TProc read FBeforeLoadList write FBeforeLoadList;
    property AfterLoadList: TProc read FAfterLoadList write FAfterLoadList;
  end;

implementation

uses
  uADCompDataSet,
  System.UITypes;

  { TPessoaPresenterList }

constructor TPessoaDatasetPresenter.Create(AView: IView; AViewPessoaDataSet: IViewPessoaDataSet);
begin
  FView := AView;
  FViewPessoaDataSet := AViewPessoaDataSet;
  FService := TPessoaService.Create;
end;

destructor TPessoaDatasetPresenter.Destroy;
begin
  if Assigned(FPessoaDataSet) then
    FreeAndNil(FPessoaDataSet);

  FreeAndNil(FService);
  inherited;
end;

procedure TPessoaDatasetPresenter.CarregarLista;
begin
  if Assigned(FPessoaDataSet) then
  begin
    FPessoaDataSet.DisableControls;
    FPessoaDataSet.Free;
  end;

  FPessoaDataSet := FService.GetDataSetLista;
  FViewPessoaDataSet.SetDataSetLista(FPessoaDataSet);
end;

function TPessoaDatasetPresenter.ObterPessoaDaLista: TPessoa;
begin
  if not Assigned(FPessoaDataSet) then
    raise Exception.Create('Lista não carregada');

  if FPessoaDataSet.RecordCount = 0 then
    raise Exception.Create('Lista não possui registros em exibição');

  FView.ExibirMensagem('Carregando registro selecionado...', msLog);
  Sleep(2000); //Atraso artifical para simular busca no banco
  Result := FService.ObterPorId(FPessoaDataSet.FieldByName('Id').AsInteger); //FService.GetCurrentFromDataset(FDataSetLista);
end;

end.
