unit Model.DAO.Pessoa.Interfaces;

interface

uses
  Model.Entity.Pessoa,
  Generics.Collections,
  Data.DB,
  uADCompClient;

type
  IDAOPessoa = interface
    ['{1C5F2932-8CED-4763-B98F-A681142FE22E}']
    function GetById(AId: Integer): TPessoa;
    function GetList(AFilter: String): TObjectList<TPessoa>;
    procedure Delete(AId: Integer);
    procedure Insert(var APessoa: TPessoa);
    procedure Update(APessoa: TPessoa);
  end;

  IDAOPessoaDataSet = interface
    function GetDataSet(AFilter: String): TADMemTable;
    function GetCurrentFromDataset(ADataSet: TDataSet): TPessoa;
    function GetListFromDataSet(ADataSet: TDataSet): TObjectList<TPessoa>;
  end;


implementation

end.
