unit Model.Entity.Pessoa;

interface

type
  TPessoa = class
  private
    FNome: string;
    FDataNascimento: TDate;
    FId: Integer;
  public
    const
      DEFAULT_NOME = '';
      DEFAULT_IDADE = 1;
    //
    function GetClone: TPessoa;
    function GetIdade: Integer;
    procedure LoadFrom(APessoa: TPessoa);
    //
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property DataNascimento: TDate read FDataNascimento write FDataNascimento;
  end;


implementation

uses
  DateUtils;

{ TPessoa }

function TPessoa.GetClone: TPessoa;
begin
  Result:= TPessoa.Create;
  Result.FNome := Self.Nome;
  Result.FDataNascimento := Self.FDataNascimento;
  Result.FId := Self.FId;
end;

function TPessoa.GetIdade: Integer;
begin
  Result:=  (YearOf(Today) -  YearOf(FDataNascimento));
end;

procedure TPessoa.LoadFrom(APessoa: TPessoa);
begin
  Self.FId := APessoa.FId;
  Self.FNome := APessoa.FNome;
  Self.FDataNascimento := APessoa.FDataNascimento;
end;

end.
