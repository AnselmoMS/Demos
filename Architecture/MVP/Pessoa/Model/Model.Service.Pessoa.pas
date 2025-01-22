unit Model.Service.Pessoa;

interface

uses
  Model.Entity.Pessoa,
  Model.DAO.Pessoa.Interfaces,
  DB;

type
  TPessoaService = class
  private
    FDAOPessoa: IDAOPessoa;
    FDAOPessoaDataSet: IDAOPessoaDataSet;
  public
    constructor Create;
    //
    function GetCurrentFromDataset(ADataSet: TDataSet): TPessoa;
    function GetDataSetLista: TDataSet;
    function ObterPorId(AId: Integer): TPessoa;
    procedure Adicionar(var APessoa: TPessoa);
    procedure Atualizar(const APessoa: TPessoa);
    procedure Excluir(Aid: Integer);
    procedure ValidarPessoa(const APessoa: TPessoa);
  end;

implementation

uses
  Model.DAO.Pessoa.Factory,
  Model.DAO.Pessoa.Dataset,
  System.SysUtils;

procedure TPessoaService.Atualizar(const APessoa: TPessoa);
begin
  ValidarPessoa(APessoa);
  FDAOPessoa.Update(APessoa);
end;

constructor TPessoaService.Create;
begin
  FDAOPessoa := TDAOPessoaFactory.GetDAO;
  FDAOPessoaDataSet := TDAOPessoaDataset.Create(FDAOPessoa);
end;

procedure TPessoaService.Excluir(Aid: Integer);
begin
  FDAOPessoa.Delete(AId);
end;

function TPessoaService.GetCurrentFromDataset(ADataSet: TDataSet): TPessoa;
begin
  Result := FDAOPessoaDataSet.GetCurrentFromDataset(ADataSet)
end;

function TPessoaService.GetDataSetLista: TDataSet;
begin
  Result:= FDAOPessoaDataSet.GetDataSet('');
end;

function TPessoaService.ObterPorId(AId: Integer): TPessoa;
begin
  Result:= FDAOPessoa.GetById(AId);
end;

procedure TPessoaService.ValidarPessoa(const APessoa: TPessoa);
begin
  if APessoa.Nome.IsEmpty then
    raise Exception.Create('O nome não pode estar vazio!');

  if not (APessoa.Idade > 0) then
    raise Exception.Create('A Idade deve ser maior que Zero!');
end;

procedure TPessoaService.Adicionar(var APessoa: TPessoa);
begin
  ValidarPessoa(APessoa);
  FDAOPessoa.Insert(APessoa);
end;

end.

