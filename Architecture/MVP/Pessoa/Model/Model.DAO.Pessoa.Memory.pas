unit Model.DAO.Pessoa.Memory;

interface

uses
  Model.DAO.Pessoa.Interfaces,
  Model.Entity.Pessoa,
  Generics.Collections;

type
  TDAOPessoaMemory = class(TInterfacedObject, IDAOPessoa)
  private
    FTablePessoa: TObjectList<TPessoa>;
    function GetNewId: Integer;
    procedure InitializeTablePessoa;
  public
    constructor Create;
    destructor Destroy; override;
    function GetById(AId: Integer): TPessoa;
    function GetList(AFilter: String): TObjectList<TPessoa>;
    procedure Delete(AId: Integer);
    procedure Insert(var APessoa: TPessoa);
    procedure Update(APessoa: TPessoa);
  end;

implementation

uses
  System.SysUtils,
  Model.Entity.Pessoa.List,
  Model.DAO.Pessoa.Memory.Constants;

{ TDAOPessoaMemory }

constructor TDAOPessoaMemory.Create;
begin
  FTablePessoa := TObjectList<TPessoa>.Create;
  InitializeTablePessoa;
end;

procedure TDAOPessoaMemory.Delete(AId: Integer);
var
  P : TPessoa;
begin
  for P in FTablePessoa do
  begin
    if P.Id = AId then
    begin
      FTablePessoa.Remove(P);
      Exit;
    end;
  end;

  raise Exception.Create(Format('Pessoa com id %d não encontrado', [AId]));
end;

destructor TDAOPessoaMemory.Destroy;
begin
  FreeAndNil(FTablePessoa);
  inherited;
end;

function TDAOPessoaMemory.GetById(AId: Integer): TPessoa;
var
  P : TPessoa;
begin
  for P in FTablePessoa do
  begin
    if P.Id = AId then
      Exit(P.GetClone);
  end;
  raise Exception.Create(Format('Pessoa com id %d não encontrado', [AId]));
end;

function TDAOPessoaMemory.GetList(AFilter: String): TObjectList<TPessoa>;
var
  LFilteredTable: TObjectList<TPessoa>;
begin
  //Aplicar Filtro
  LFilteredTable := FTablePessoa; //Simplificado para didática
  
  Result:= LFilteredTable;
end;

function TDAOPessoaMemory.GetNewId: Integer;
begin
  if FTablePessoa.Count = 0 then
    Exit(1);

  TPessoaList(FTablePessoa).SortById;
  Result:= FTablePessoa.Last.Id;
end;

procedure TDAOPessoaMemory.InitializeTablePessoa;
var
  LPessoaRecord: TPessoaRecord;
  LPessoa: TPessoa;
begin
  for LPessoaRecord in PESSOAS_CADASTRADAS do
  begin
    LPessoa := TPessoa.Create;
    LPessoa.Id := LPessoaRecord.Id;
    LPessoa.Nome := LPessoaRecord.Nome;
    LPessoa.Idade := LPessoaRecord.Idade;

    FTablePessoa.Add(LPessoa);
  end;
end;

procedure TDAOPessoaMemory.Insert(var APessoa: TPessoa);
begin
  if Assigned(GetById(APessoa.Id)) then
    raise Exception.Create(Format('Erro ao Inserir: Pessoa com id %d já existe', [APessoa.Id]));

  APessoa.Id := GetNewId;

  FTablePessoa.Add(APessoa.GetClone); //'Salvar No banco' uma cópia do objeto
end;

procedure TDAOPessoaMemory.Update(APessoa: TPessoa);
var
  LPessoa: TPessoa;
begin
  LPessoa := GetById(APessoa.Id);
  
  if not Assigned(LPessoa) then
    raise Exception.Create(Format('Erro ao Atualizar: Pessoa com id %d não existe', [APessoa.Id]));

  LPessoa.LoadFrom(APessoa);
end;

end.
