unit Model.Entity.Pessoa;

interface

type
  TPessoa = class
  private
    FNome: string;
    FIdade: Integer;
    FId: Integer;
  public
    const
      DEFAULT_NOME = '';
      DEFAULT_IDADE = 1;

    function GetClone: TPessoa;
    procedure LoadFrom(APessoa: TPessoa);
    //
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Idade: Integer read FIdade write FIdade;
  end;

implementation

{ TPessoa }

function TPessoa.GetClone: TPessoa;
begin
  Result:= TPessoa.Create;
  Result.FNome := Self.Nome;
  Result.FIdade := Self.FIdade;
  Result.FId := Self.FId;
end;

procedure TPessoa.LoadFrom(APessoa: TPessoa);
begin
  Self.Id := APessoa.Id;
  Self.Nome := APessoa.Nome;
  Self.Idade := APessoa.Idade;
end;

end.
