unit DAO.Pessoa.Interfaces;

interface

uses
  DAO.Entity.Pessoa,
  Generics.Collections,
  Data.DB;

type
  IDAOPessoa = interface
    ['{1C5F2932-8CED-4763-B98F-A681142FE22E}']
    function GetById(AId: Integer): TPessoaTable;
    function GetList(AFilter: String): TObjectList<TPessoaTable>;
    function GetListagem(AFilter: String): TArray<TPessoaListagem>;
    procedure Delete(AId: Integer);
    procedure Insert(var APessoa: TPessoaTable);
    procedure Update(APessoa: TPessoaTable);
  end;

implementation

end.
