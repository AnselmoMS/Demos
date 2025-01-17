unit GenericListDEMO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections,
  System.Generics.Defaults;

type
  TMyClass = class
  public
    Valor: string;
  end;

  TMyClassList = class(TObjectList<TMyClass>)
  public
    procedure ExibirMensagem;
    procedure SortByValor;
  end;

  TfrmMain = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Lista: TMyClassList;
  item: TMyClass;
  ListaGenerica: TObjectList<TMyclass>;
begin
  Lista:= TMyClassList.Create;

  item:= TMyClass.Create;
  item.Valor := 'B';

  Lista.Add(item);

  item:= TMyClass.Create;
  item.Valor := 'A';

  Lista.Add(item);

  Lista.SortByValor;

  Lista.ExibirMensagem;
end;

{ TMyClassList }

procedure TMyClassList.ExibirMensagem;
var
  I: TMyClass;
begin
  for I in Self do
    ShowMessage(i.Valor);
end;

procedure TMyClassList.SortByValor;
begin
  Self.Sort(
  TComparer<TMyClass>.Construct(
    function(const AItemLeft, AItemRight: TMyClass): Integer
    begin
      Result:= TComparer<string>.Default.Compare(AItemLeft.Valor, AItemRight.Valor);
    end
    )
    );
end;

end.
