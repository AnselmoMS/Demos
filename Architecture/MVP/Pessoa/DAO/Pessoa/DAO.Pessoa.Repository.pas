unit DAO.Pessoa.Repository;

interface

uses
  DAO.Entity.Pessoa,
  DAO.Pessoa.Interfaces,
  System.Generics.Collections;
type
  TPessoaRepository = class
  private
    FDAOPessoa: IDAOPessoa;
  public
    constructor Create;
    //
    function ObterPorId(AId: Integer): TPessoaTable;
    procedure Adicionar(var APessoa: TPessoaTable);
    procedure Atualizar(const APessoa: TPessoaTable);
    procedure Excluir(Aid: Integer);
    procedure ValidarPessoa(const APessoa: TPessoaTable);
    function ObterListagem(AFilter: String; AOffSet: Integer = 1; ALimit: Integer = -1): TArray<TPessoaListagem>;
  end;

implementation

uses
  DAO.Pessoa.Factory,
  System.SysUtils;

procedure TPessoaRepository.Atualizar(const APessoa: TPessoaTable);
begin
  ValidarPessoa(APessoa);
  FDAOPessoa.Update(APessoa);
end;

constructor TPessoaRepository.Create;
begin
  FDAOPessoa := TDAOPessoaFactory.GetDAO;
end;

procedure TPessoaRepository.Excluir(Aid: Integer);
begin
  FDAOPessoa.Delete(AId);
end;

function TPessoaRepository.ObterListagem(AFilter: String; AOffSet: Integer; ALimit: Integer): TArray<TPessoaListagem>;
begin
  Result := FDAOPessoa.GetListagem(AFilter);
end;

function TPessoaRepository.ObterPorId(AId: Integer): TPessoaTable;
begin
  Result:= FDAOPessoa.GetById(AId);
end;

procedure TPessoaRepository.ValidarPessoa(const APessoa: TPessoaTable);
begin
  if APessoa.Nome.IsEmpty then
    raise Exception.Create('O nome não pode estar vazio!');

  if not (APessoa.DataNascimento > 0) then
    raise Exception.Create('A Idade deve ser maior que Zero!');
end;

procedure TPessoaRepository.Adicionar(var APessoa: TPessoaTable);
begin
  ValidarPessoa(APessoa);
  FDAOPessoa.Insert(APessoa);
end;

end.

