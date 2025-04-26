unit DAO.Entity.Pessoa.List;

interface

uses
  DAO.Entity.Pessoa,
  Generics.Collections;

type
  TPessoaList = class(TObjectList<TPessoaTable>)
    procedure SortById;
  end;

implementation

uses
  System.Generics.Defaults,
  System.SysUtils;

{ TPessoaList }

procedure TPessoaList.SortById;
begin
  Self.Sort(
      TComparer<TPessoaTable>.Construct(
        function(const Left, Right: TPessoaTable): Integer
        begin
          Result:= TComparer<Integer>.Default.Compare(Left.Id, Right.Id)
        end
      )
    );
end;

end.
