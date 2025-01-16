unit Model.DAO.Pessoa.Dataset;

interface

uses
  Data.DB,
  uADCompClient,
  Model.DAO.Pessoa.Interfaces,
  Model.Entity.Pessoa,
  Generics.Collections;

type
  TDAOPessoaDataset = class(TInterfacedObject, IDAOPessoaDataSet)
  var
    FDAOPessoa: IDAOPessoa;
  private
    function GetNewDataSet: TADMemTable;
  public
    constructor Create(ADAOPessoa: IDAOPessoa);
    destructor Destroy; override;

    function GetCurrentFromDataset(ADataSet: TDataSet): TPessoa;
    function GetDataSet(AFilter: String): TADMemTable;
    function GetListFromDataSet(ADataSet: TDataSet): TObjectList<TPessoa>;
  end;

implementation

uses
  System.SysUtils;

{ TDAOPessoaDatasetAdapter }

constructor TDAOPessoaDataset.Create(ADAOPessoa: IDAOPessoa);
begin
  FDAOPessoa:= ADAOPessoa;
end;

destructor TDAOPessoaDataset.Destroy;
begin
  inherited;
end;

function TDAOPessoaDataset.GetCurrentFromDataset(ADataSet: TDataSet): TPessoa;
begin
  if ADataSet.RecordCount = 0 then
    raise Exception.Create('Não há dados no dataset passado como parâmetro!');

  Result:= TPessoa.Create;
  Result.Id := ADataSet.FieldByName('Id').Value;
  Result.Nome := ADataSet.FieldByName('Nome').Value;
  Result.Idade := ADataSet.FieldByName('Idade').Value;
end;

function TDAOPessoaDataset.GetDataSet(AFilter: String): TADMemTable;
var
  P: TPessoa;
  LFilteredTable: TObjectList<TPessoa>;
begin
  Result:= GetNewDataSet;

  LFilteredTable := FDAOPessoa.GetList(AFilter);

  Result.Close;
  Result.Open;

  for P in LFilteredTable do
  begin
    Result.Append;
    Result.FieldByName('Id').AsInteger := P.Id;
    Result.FieldByName('Nome').AsString := P.Nome;
    Result.FieldByName('Idade').AsInteger := P.Idade;
    Result.Post;
  end;
end;

function TDAOPessoaDataset.GetListFromDataSet(ADataSet: TDataSet): TObjectList<TPessoa>;
begin
  Result:= TObjectList<TPessoa>.Create;
  ADataSet.First;
  while not ADataSet.Eof do
    Result.Add(GetCurrentFromDataset(ADataSet));
end;

function TDAOPessoaDataset.GetNewDataSet: TADMemTable;
begin
  Result:= TADMemTable.Create(nil);

  Result.FieldDefs.Add('Id', ftInteger, 0, True);
  Result.FieldDefs.Add('Nome', ftString, 100, True);
  Result.FieldDefs.Add('Idade', ftInteger, 0, False);

  Result.CreateDataSet;

  Result.Open;
end;

end.
