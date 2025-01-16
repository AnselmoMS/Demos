unit Model.DAO.Pessoa.Memory.Constants;

interface

type
  TPessoaRecord = record
    Id: integer;
    Nome: String;
    Idade: Integer;
  end;

const
  PESSOAS_CADASTRADAS : array[0..3] of TPessoaRecord =
    (
    (Id: 1; Nome: 'José'; Idade:21),
    (Id: 2; Nome: 'Maria'; Idade:22),
    (Id: 3; Nome: 'Pedro'; Idade:23),
    (Id: 4; Nome: 'Paulo'; Idade:24)
    );

implementation

end.
