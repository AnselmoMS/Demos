unit DAO.Pessoa.Adapter;

interface

uses
  DAO.Entity.Pessoa,
  Model.Entity.Pessoa;

type
  TPessoaAdapter = class
    class function PessoaTableFromPessoa(APessoa: TPessoa): TPessoaTable;
    class function PessoaFromPessoaTable(ApessoaTable: TPessoaTable): TPessoa;
    //function PessoaEnderecosTableFromPessoa(Apessoa: TPessoa): TPessoa;  Registros-detalhe
  end;

implementation

{ TPessoaAdapter }

class function TPessoaAdapter.PessoaFromPessoaTable(ApessoaTable: TPessoaTable): TPessoa;
begin
  Result:= TPessoa.Create;

  Result.Id := ApessoaTable.Id;
  Result.Nome := ApessoaTable.Nome;
  Result.DataNascimento := ApessoaTable.DataNascimento;
end;

class function TPessoaAdapter.PessoaTableFromPessoa(APessoa: TPessoa): TPessoaTable;
begin
  Result:= TPessoaTable.Create;

  Result.Id := APessoa.Id;
  Result.Nome := APessoa.Nome;
  Result.DataNascimento := APessoa.DataNascimento;
end;

end.
