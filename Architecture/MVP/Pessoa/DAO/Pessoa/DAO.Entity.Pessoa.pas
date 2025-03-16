unit DAO.Entity.Pessoa;

interface

type
  TPessoaTable = class
  private
    FNome: string;
    FDataNascimento: TDate;
    FId: Integer;
  public
    const
      DEFAULT_NOME = '';
      DEFAULT_IDADE = 1;

    function GetClone: TPessoaTable;
    procedure LoadFrom(APessoa: TPessoaTable);
    //
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
  end;

  TPessoaListagem = record
    Id: Integer;
    Nome: string;
    Idade: Integer;

    Constructor Create(AId: integer; ANome: String; AIdade: Integer);
  end;

implementation

{ TPessoa }

function TPessoaTable.GetClone: TPessoaTable;
begin
  Result:= TPessoaTable.Create;
  Result.FNome := Self.Nome;
  Result.FDataNascimento := Self.FDataNascimento;
  Result.FId := Self.FId;
end;

procedure TPessoaTable.LoadFrom(APessoa: TPessoaTable);
begin
  Self.FId := APessoa.FId;
  Self.FNome := APessoa.FNome;
  Self.FDataNascimento := APessoa.FDataNascimento;
end;

{ TPessoaListagem }

constructor TPessoaListagem.Create(AId: integer; ANome: String; AIdade: Integer);
begin
  Id := AId;
  Nome:= ANome;
  Idade:= AIdade;
end;

end.
