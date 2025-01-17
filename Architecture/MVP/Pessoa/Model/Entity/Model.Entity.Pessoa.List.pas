unit Model.Entity.Pessoa.List;

interface

uses
  Model.Entity.Pessoa,
  Generics.Collections;

type
  TPessoaList = class(TObjectList<TPessoa>)
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
      TComparer<TPessoa>.Construct(
        function(const Left, Right: TPessoa): Integer
        begin
          Result:= TComparer<Integer>.Default.Compare(Left.Id, Right.Id)
        end
      )
    );
end;

end.
