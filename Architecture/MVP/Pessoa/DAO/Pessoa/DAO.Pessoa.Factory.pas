unit DAO.Pessoa.Factory;

interface

uses
  DAO.Pessoa.Interfaces;

type
  TDAOPessoaFactory = class
    class function GetDAO: IDAOPessoa;
  end;

implementation

uses
  DAO.Pessoa.Memory;

{ TDAOPessoaFactory }

class function TDAOPessoaFactory.GetDAO: IDAOPessoa;
begin
  Result:= TDAOPessoaMemory.Create; //Simplificada construção (construir conforme banco usado)
end;

end.
