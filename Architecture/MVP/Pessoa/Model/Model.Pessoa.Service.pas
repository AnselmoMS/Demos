unit Model.Pessoa.Service;

interface

uses
  Model.Entity.Pessoa,
  DAO.Entity.Pessoa,
  DAO.Pessoa.Adapter,
  DAO.Pessoa.Repository;

type
  TPessoaService = class
  private
    FPessoaRepository: TPessoaRepository;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Atualizar(APessoa: TPessoa);
    procedure Adicionar(APessoa: TPessoa);
    procedure Excluir(AId: Integer);
    function ObterPorId(AId: Integer): TPessoa;
  end;

implementation

{ TPessoaService }

procedure TPessoaService.Adicionar(APessoa: TPessoa);
var
  LPessoaTable: TPessoaTable;
begin
  LPessoaTable:= TPessoaAdapter.PessoaTableFromPessoa(APessoa);
  try
    FPessoaRepository.Adicionar(LPessoaTable);
    //...Salvar demais dados dependentes
  finally
    LPessoaTable.Free;
  end;
end;

procedure TPessoaService.Atualizar(APessoa: TPessoa);
var
  LPessoaTable: TPessoaTable;
begin
  LPessoaTable:= TPessoaAdapter.PessoaTableFromPessoa(APessoa);
  try
    FPessoaRepository.Atualizar(LPessoaTable);
    //...Salvar demais dados dependentes
  finally
    LPessoaTable.Free;
  end;
end;

constructor TPessoaService.Create;
begin
  FPessoaRepository := TPessoaRepository.Create;
end;

destructor TPessoaService.Destroy;
begin
  FPessoaRepository.Free;
  inherited;
end;

procedure TPessoaService.Excluir(AId: Integer);
begin
  FPessoaRepository.Excluir(AId);
  //...Excluir demais dados dependentes
end;

function TPessoaService.ObterPorId(AId: Integer): TPessoa;
var
  LPessoaTable: TPessoaTable;
begin
  LPessoaTable:= FPessoaRepository.ObterPorId(AId);
  try
    Result:= TPessoaAdapter.PessoaFromPessoaTable(LPessoaTable);
    //Carregar demais dados de detalhe
  finally
    LPessoaTable.Free;
  end;
end;

end.
