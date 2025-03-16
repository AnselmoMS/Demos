unit DAO.Pessoa.Memory;

interface

uses
  DAO.Pessoa.Interfaces,
  DAO.Entity.Pessoa,
  Generics.Collections;

type
  TDAOPessoaMemory = class(TInterfacedObject, IDAOPessoa)
  private
    FTablePessoa: TObjectList<TPessoaTable>;
    function GetNewId: Integer;
    procedure InitializeTablePessoa;
  public
    constructor Create;
    destructor Destroy; override;
    function GetById(AId: Integer): TPessoaTable;
    function GetList(AFilter: String): TObjectList<TPessoaTable>;
    function GetListagem(AFilter: String): TArray<TPessoaListagem>; //Aumentando a complexidade, mover para DAO própria
    procedure Delete(AId: Integer);
    procedure Insert(var APessoa: TPessoaTable);
    procedure Update(APessoa: TPessoaTable);
  end;

implementation

uses
  System.SysUtils,
  DAO.Entity.Pessoa.List,
  DAO.Pessoa.Memory.Constants,
  System.DateUtils;

{ TDAOPessoaMemory }

constructor TDAOPessoaMemory.Create;
begin
  FTablePessoa := TObjectList<TPessoaTable>.Create;
  InitializeTablePessoa;
end;

procedure TDAOPessoaMemory.Delete(AId: Integer);
var
  P : TPessoaTable;
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

function TDAOPessoaMemory.GetById(AId: Integer): TPessoaTable;
var
  P : TPessoaTable;
begin
  for P in FTablePessoa do
  begin
    if P.Id = AId then
      Exit(P.GetClone);
  end;
  raise Exception.Create(Format('Pessoa com id %d não encontrado', [AId]));
end;

function TDAOPessoaMemory.GetList(AFilter: String): TObjectList<TPessoaTable>;
var
  LFilteredTable: TObjectList<TPessoaTable>;
begin
  //Aplicar Filtro
  LFilteredTable := FTablePessoa; //Simplificado para didática

  Result:= LFilteredTable;
end;

function TDAOPessoaMemory.GetListagem(AFilter: String): TArray<TPessoaListagem>;
var
  P: TPessoaDBRecord;
  PessoaListagem: TPessoaListagem;
  Lista: TList<TPessoaListagem>;
begin
  Lista:= TList<TPessoaListagem>.Create;
  try
    for P in PESSOAS_CADASTRADAS do  //Consulta direto na fonte de dados
    begin
      PessoaListagem.Create(P.Id, P.Nome, YearsBetween(Today, P.DataNascimento));
      Lista.Add(PessoaListagem);
    end;
    Result:= Lista.ToArray
  finally
    Lista.Free
  end;
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
  LPessoaRecord: TPessoaDBRecord;
  LPessoa: TPessoaTable;
begin
  for LPessoaRecord in PESSOAS_CADASTRADAS do
  begin
    LPessoa := TPessoaTable.Create;
    LPessoa.Id := LPessoaRecord.Id;
    LPessoa.Nome := LPessoaRecord.Nome;
    LPessoa.DataNascimento := LPessoaRecord.DataNascimento;

    FTablePessoa.Add(LPessoa);
  end;
end;

procedure TDAOPessoaMemory.Insert(var APessoa: TPessoaTable);
begin
  if Assigned(GetById(APessoa.Id)) then
    raise Exception.Create(Format('Erro ao Inserir: Pessoa com id %d já existe', [APessoa.Id]));

  APessoa.Id := GetNewId;

  FTablePessoa.Add(APessoa.GetClone); //'Salvar No banco' uma cópia do objeto
end;

procedure TDAOPessoaMemory.Update(APessoa: TPessoaTable);
var
  LPessoa: TPessoaTable;
begin
  LPessoa := GetById(APessoa.Id);
  
  if not Assigned(LPessoa) then
    raise Exception.Create(Format('Erro ao Atualizar: Pessoa com id %d não existe', [APessoa.Id]));

  LPessoa.LoadFrom(APessoa);
end;

end.
